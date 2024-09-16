local Builder = require("./builder")
local stdio = require("@lune/stdio")

local createModel = stdio.prompt("confirm", "Create .rbxm models?")
local createRelease = stdio.prompt("confirm", "Release to Wally/Pesde?")
local version = "0.0.0-dev"
if createRelease then
  local promptedVersion = stdio.prompt("text", "Semver version to publish as?")
  assert(
    promptedVersion:match("^(%d+)%.?(%d*)%.?(%d*)(.-)$") ~= nil,
    `{version} is not a valid semver version`
  )
  version = promptedVersion
end

Builder.build {
  createModel = createModel,
  createRelease = createRelease,
  version = version,
}
