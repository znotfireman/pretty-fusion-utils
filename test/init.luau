local Fusion = require("./fusion")

local function _createTestEnv()
  local env = {}
  function env.require(path: string): any
    if path == "test/fusion" then
      return Fusion
    end
    if path:match("%../") then
      return require("../src/")
    end
  end
end
