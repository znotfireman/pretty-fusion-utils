local fs = require("@lune/fs")
local path = require("../utils/path")
local pesdeTemplate = require("./templates/pesde")
local process = require("@lune/process")
local rojoProject = require("./templates/rojo")
local serde = require("@lune/serde")
local summon = require("../utils/summon")
local wallyTemplate = require("./templates/wally")

local PATH_LIB = path(process.cwd, "lib")
local PATH_DIST = path(process.cwd, "dist")
local DARKLUA_DEV = path(process.cwd, ".darklua-dev.json")
local DARKLUA_STD = path(process.cwd, ".darklua.json")
local ROJO_PROJECT = path(process.cwd, "default.project.json")
local ROJO_SOURCEMAP = path(process.cwd, "sourcemap.json")

local Builder = {}

local function reset(dir: string)
  if not fs.isDir(dir) then
    fs.writeDir(dir)
  else
    for _, file in fs.readDir(dir) do
      if fs.isFile(path(dir, file)) then
        fs.removeFile(path(dir, file))
      end
    end
  end
end

function Builder.build(props: {
  createModel: boolean,
  createRelease: boolean,
  version: string,
})
	-- stylua: ignore
	local createModel, createRelease, version = props.createModel, props.createRelease, props.version
  assert(
    version:match("^(%d+)%.?(%d*)%.?(%d*)(.-)$") ~= nil,
    `{version} is not a valid semver version`
  )

  reset(PATH_DIST)

  print("Generating sourcemap")
  summon("rojo", "sourcemap", ROJO_PROJECT, "-o", ROJO_SOURCEMAP)

  -- FIXME: Darklua is stinky & cant give good types on bundle
  print("Processing library files")
  local darkluaConfig = createRelease and DARKLUA_STD or DARKLUA_DEV
  summon("darklua", "process", PATH_LIB, path(PATH_DIST, "lib"), "-c", darkluaConfig, "-v")

  fs.copy(path(process.cwd, "README.md"), path(PATH_DIST, "README.md"))

  print("Writing Rojo project")
  fs.writeFile(path(PATH_DIST, "default.project.json"), serde.encode("json", rojoProject))

  if createRelease then
    print("Writing Wally config")
    local wally = table.clone(wallyTemplate)
    wally.package.version = version
    fs.writeFile(path(PATH_DIST, "wally.toml"), serde.encode("toml", wally))

    print("Writing Pesde config")
    local pesde = table.clone(pesdeTemplate)
    pesde.version = version
    fs.writeFile(path(PATH_DIST, "pesde.yaml"), serde.encode("yaml", pesde))

    print("Publishing")
    summon("wally", "publish", "-v", "--project-path", PATH_DIST)
    process.spawn("pesde", { "publish" }, {
      shell = true,
      cwd = PATH_DIST,
    })
  end

  if createModel then
    print("Creating Roblox model")
    summon(
      "rojo",
      "build",
      path(PATH_DIST, "default.project.json"),
      "-o",
      path(PATH_DIST, "pretty-fusion-utils.rbxm")
    )
  end
end

return Builder
