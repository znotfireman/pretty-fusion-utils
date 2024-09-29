local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Fusion = require("test/fusion")
local testing = require("test/testing")
local useCamera = require("use-camera")

local it, test = testing.it, testing.test
local scopeMethods = table.freeze { useCamera = useCamera }

local function refreshCamera()
  Workspace.CurrentCamera:Destroy()
  RunService.Heartbeat:Wait()
end

return test "useCamera" {
  it("should return the current camera", function(expect)
    local scope = Fusion:scoped(scopeMethods)
    local camera = scope:useCamera()
    expect(Fusion.peek(camera)).to.equal(Workspace.CurrentCamera)
    scope:doCleanup()
  end),

  it("should update when the current camera changes", function(expect)
    local scope = Fusion:scoped(scopeMethods)
    local camera = scope:useCamera()
    expect(Fusion.peek(camera)).to.equal(Workspace.CurrentCamera)
    refreshCamera()
    expect(Fusion.peek(camera)).to.equal(Workspace.CurrentCamera)
    scope:doCleanup()
  end),
}
