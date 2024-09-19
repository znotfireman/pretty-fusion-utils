local StringBuilder = require("../utils/string-builder")
local config = require("./config")
local fs = require("@lune/fs")
local mkdocs = require("./templates/mkdocs.yaml")
local path = require("../utils/path")
local process = require("@lune/process")
local serde = require("@lune/serde")
local stringer = require("../utils/stringer")

local PATH_DOCS = path(process.cwd, "docs")
local PATH_LIB = path(process.cwd, "lib")
local PATH_TEMPLATES = path(process.cwd, ".lune", "regen", "templates")
local PATH_DOC_BUILD = path(process.cwd, "doc.build")
local TEMPLATE_INDEX = path(PATH_TEMPLATES, "index.md")
local LIB_URL = "https://github.com/znotfireman/pretty-fusion-utils/blob/main/lib"

type DocBuild = {
  build: {
    generated_files: { string },
  },
}

local function reset()
  if fs.isFile(PATH_DOC_BUILD) then
    local docBuild: DocBuild = serde.decode("toml", fs.readFile(PATH_DOC_BUILD))
    for _, file in docBuild.build.generated_files do
      if fs.isFile(file) then
        fs.removeFile(file)
      end
    end
  end
end

local utils = {}

for _, dir in fs.readDir(PATH_LIB) do
  local dirPath, configPath = path(PATH_LIB, dir), path(PATH_LIB, dir, "doc.toml")
  if not fs.isDir(dirPath) or not fs.isFile(configPath) then
    continue
  end

  local config = config.intoConfig(serde.decode("toml", fs.readFile(configPath))).config
  table.insert(utils, {
    dir = dir,
    config = config,
  })
end

table.sort(utils, function(first, second)
  return first.dir < second.dir
end)

local Regenerator = {}

function Regenerator.buildMeta()
  local generatedFiles = {}
  table.insert(generatedFiles, path(PATH_DOCS, "index.md"))

  for _, util in utils do
    table.insert(generatedFiles, path(PATH_DOCS, `{util.dir}.md`))
  end

  fs.writeFile(
    PATH_DOC_BUILD,
    StringBuilder()
      :appendLine("# This file was @generated and is not intended for manual editing.")
      :appendLine("# It is used to store metadata between documentation builds.")
      :appendLine("# Run `lune run regen` to generate fresh documentation files.")
      :appendLine()
      :appendLine(serde.encode("toml", {
        build = {
          generated_files = generatedFiles,
        },
      }, true))
      :build()
  )
end

function Regenerator.initFile()
  print("Regenerating init.luau exports")
  local initFile = StringBuilder()
    :appendLine("-- This file was @generated and is not intended for manual editing.")
    :appendLine("-- Run `lune run regen` to generate a fresh init file.")
    :appendLine()
    :appendLine("return table.freeze {")
    :indent()

  for _, util in utils do
    print("Exporting", util.config.name)
    initFile:appendLine(util.config.name, "=", `require("{util.dir}"),`)
  end

  fs.writeFile(path(PATH_LIB, "init.luau"), initFile:unIndent():appendLine("}"):build())
end

function Regenerator.mkdocsConfig()
  print("Regenerating mkdocs.yaml navigation")
  local newMkdocs, apiReference: any = table.clone(mkdocs), {}

  for _, util in utils do
    print("Adding navigation item", util.config.name)
    table.insert(apiReference, {
      [util.config.name] = `{util.dir}.md`,
    })
  end

  newMkdocs.nav = {
    {
      About = {
        "index.md" :: any,
        {
          ["Getting Started"] = "getting-started.md",
        },
      },
    },
    {
      Reference = apiReference,
    },
  }

  fs.writeFile(path(process.cwd, "mkdocs.yaml"), (StringBuilder()
    :appendLine("# This file was @generated and is not intended for manual editing.")
    :appendLine("# Run `lune run regen` to generate a fresh configuration file.")
    :appendLine()
    :appendLine("# Edit the configuration at `.lune/regenerate/templates/mkdocs.yaml.luau`")
    :appendLine()
    :appendLine(serde.encode("yaml", newMkdocs))
    :build()
    -- HOLY SHIT LUNE. FUCK YOU MEAN I CANT SERDE A TAG?
    :gsub(
      "pymdownx%.inlinehilite",
      function()
        return StringBuilder("pymdownx.inlinehilite")
          :appendLine()
          :appendLine("- pymdownx.emoji:")
          :indent()
          :indent()
          :appendLine("emoji_index: !!python/name:materialx.emoji.twemoji")
          :appendLine("emoji_generator: !!python/name:materialx.emoji.to_svg")
          :build()
      end
    )))
end

function Regenerator.aliases()
  local vscodeSettings = table.clone(require("./templates/vscode"))
  local zedSettings = table.clone(require("./templates/zed"))
  local darkluaConfig = table.clone(require("./templates/darklua"))
  local darkluaDevConfig = table.clone(require("./templates/darklua-dev"))

  local aliases = {}
  aliases["@lune/"] = "~/.lune/.typedefs/0.8.8/"

  for _, dir in fs.readDir(PATH_LIB) do
    if not fs.isDir(path(PATH_LIB, dir)) then
      continue
    end
    aliases[dir] = path("lib", dir)
  end

  type ConvertRequire = {
    current: {
      name: "path",
      sources: { [string]: string },
    },
    rule: "convert_require",
    target: {
      indexing_style: "property",
      name: "roblox",
      rojo_sourcemap: "./sourcemap.json",
    },
  }

  local darkluaSources = table.clone(aliases)
  darkluaSources["@lune/"] = nil

  for _, rule in darkluaConfig.rules do
    if typeof(rule) == "table" and rule.rule == "convert_require" then
      local convertRequire = rule :: ConvertRequire
      convertRequire.current.sources = darkluaSources
    end
  end

  for _, rule in darkluaDevConfig.rules do
    if typeof(rule) == "table" and rule.rule == "convert_require" then
      local convertRequire = rule :: ConvertRequire
      convertRequire.current.sources = darkluaSources
    end
  end

  vscodeSettings["luau-lsp.require.directoryAliases"] = aliases
  zedSettings.lsp["luau-lsp"].settings["luau-lsp"].require.directoryAliases = aliases

  fs.writeFile(
    path(process.cwd, ".vscode", "settings.json"),
    StringBuilder()
      :appendLine("// This file was @generated and is not intended for manual editing.")
      :appendLine("// Run `lune run regen` to generate fresh workspace settings.")
      :appendLine()
      :appendLine(serde.encode("json", vscodeSettings, true))
      :build()
  )

  fs.writeFile(
    path(process.cwd, ".zed", "settings.json"),
    StringBuilder()
      :appendLine("// This file was @generated and is not intended for manual editing.")
      :appendLine("// Run `lune run regen` to generate fresh workspace settings.")
      :appendLine()
      :appendLine(serde.encode("json", zedSettings, true))
      :build()
  )

  -- FUTURE: darklua cant handle comments yet
  fs.writeFile(path(process.cwd, ".darklua.json"), serde.encode("json", darkluaConfig, true))
  fs.writeFile(path(process.cwd, ".darklua-dev.json"), serde.encode("json", darkluaDevConfig, true))
end

--[=[
  Regenerates MkDocs documentation, moonwave-esque documentation comments,
  README files for all utilities, and the init.luau export table. Each utility
  has a doc.toml file that configures how it is displayed.

  I may or may not need a psychological evaluation.
]=]
function Regenerator.regenerate()
  assert(fs.isDir(PATH_DOCS), "Missing `docs` folder, download a copy from the repository")
  reset()

  local firstList, secondList, indexUtils, pages = {}, {}, {}, {}
  for index, util in utils do
    print("Processing", util.config.name)

    local code = StringBuilder():append("function", util.config.name)
    local codeDocumentation = StringBuilder()
    local docComment = StringBuilder("--[=["):appendLine():indent():appendLine(util.config.brief)

    do
      if util.config.variadics then
        code:append(`<{table.concat(util.config.variadics, ", ")}>`)
      end
      code:appendLine("("):indent()

      if util.config.args then
        codeDocumentation
          :appendLine()
          :appendLine("---")
          :appendLine()
          :appendLine("## Parameters")
          :appendLine()

        local args = {}
        for _, arg in util.config.args do
          table.insert(args, `{arg.name}: {arg.type}`)
          codeDocumentation
            :appendLine(
              "###",
              arg.name,
              '<span class="pfu-reference-type">:',
              stringer.cleanHtmlTags(arg.type),
              "</span>"
            )
            :appendLine(arg.description)
            :appendLine()
          docComment:appendLine("@param", arg.name, stringer.cleanNewlines(arg.description))
        end
        code:appendLine(table.concat(args, ",\n"))
      end
      code:unIndent():append(")")

      if util.config.returns then
        code:append(": "):append(util.config.returns.type)
        docComment:appendLine("@return", stringer.cleanNewlines(util.config.returns.description))

        codeDocumentation
          :appendLine()
          :appendLine("---")
          :appendLine()
          :append("## Returns ")
          :appendLine(
            '<span class="pfu-reference-type">->',
            stringer.cleanHtmlTags(util.config.returns.type),
            "</span>"
          )
          :appendLine()
          :appendLine(util.config.returns.description)
      end

      if util.config.example then
        codeDocumentation
          :appendLine()
          :appendLine("---")
          :appendLine()
          :appendLine("## Example Usage")
          :appendLine()
          :appendLine("```Luau")
          :appendLine(util.config.example)
          :appendLine("```")
      end
    end

    table.insert(
      index % 2 == 0 and firstList or secondList,
      StringBuilder("<li> <a ")
        :append(`href="{util.dir}">`)
        :append(util.config.name)
        :append("</a></li>")
        :build()
    )

    table.insert(
      indexUtils,
      StringBuilder("<section>\n")
        :appendLine(`<a href="./{util.dir}/">`)
        :appendLine("<h2>", util.config.name, "</h2>")
        :appendLine(util.config.brief)
        :appendLine("</a>")
        :appendLine("</section>")
        :build()
    )

    local usefulFor = StringBuilder()
    if util.config.useful_for then
      usefulFor:append("Useful for", util.config.useful_for)
    end

    -- stylua: ignore
    pages[util] = StringBuilder()
      :appendLine("<!-- This file was @generated and is not intended for manual editing. -->")
      :appendLine("<!-- Run `lune run regen` to generate a fresh README. -->")
      :appendLine()
      :appendLine('<h1 class="pfu-reference-header" markdown>')
      :appendLine('<span class="pfu-reference-name">', util.config.name, "</span>")
      :appendLine(`<a class="pfu-reference-source" href="{path(LIB_URL, util.dir, "init.luau")}" markdown> :octicons-code-24:\{ title="View source code" } </a>`)
      :appendLine("</h1>")
      :appendLine()
      :appendLine("```Luau")
      :appendLine(code:build())
      :appendLine("```")
      :appendLine()
      :appendLine(util.config.brief)
      :appendStringBuilder(usefulFor)
      :append(codeDocumentation:build())
      :build()

    fs.writeFile(
      path(PATH_LIB, util.dir, "README.md"),
      StringBuilder()
        :appendLine("<!-- This file was @generated and is not intended for manual editing. -->")
        :appendLine("<!-- Run `lune run regen` to generate a fresh README. -->")
        :appendLine()
        :appendLine("#", util.config.name)
        :appendLine()
        :appendLine("```Luau")
        :appendLine(code:build())
        :appendLine("```")
        :appendLine()
        :appendLine(util.config.brief)
        :appendStringBuilder(usefulFor)
        :append(codeDocumentation:build())
        :build()
    )

    local libFilepath = path(PATH_LIB, util.dir, "init.luau")
    local libFile = fs.readFile(libFilepath)
    fs.writeFile(libFilepath, (libFile:gsub("%-%-%[=%[.*]=]", function()
      return docComment:append("]=]"):unIndent():build()
    end)))
  end

  table.sort(firstList)
  table.sort(secondList)
  table.sort(indexUtils)

  for util, content in pages do
    fs.writeFile(path(PATH_DOCS, `{util.dir}.md`), content)
  end

  Regenerator.initFile()
  Regenerator.mkdocsConfig()

  local index = fs.readFile(TEMPLATE_INDEX)
  index = index:gsub("%$utils%-grid", table.concat(indexUtils, "\n\n"))
  index = index:gsub("%$utils%-list%-1", table.concat(firstList, "\n\n"))
  index = index:gsub("%$utils%-list%-2", table.concat(secondList, "\n\n"))
  fs.writeFile(path(PATH_DOCS, "index.md"), index)

  Regenerator.aliases()
  Regenerator.buildMeta()
end

return Regenerator
