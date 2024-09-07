local Workspace = game:GetService("Workspace")

local Types = require("src/types")
local lockValue = require("src/utils/lock-value")
local useEvent = require("src/use-event")

local onCameraChanged = Workspace:GetPropertyChangedSignal("CurrentCamera")

--[=[
  Returns a state object with the current camera. Updates when the current
  camera changes.
  @return A state object with the camera instance.
]=]
local function useCamera(scope: Types.Scope<Types.Fusion>)
  local camera = scope:Value(Workspace.CurrentCamera)

  useEvent(scope, onCameraChanged, function()
    if Workspace.CurrentCamera then
      camera:set(Workspace.CurrentCamera)
    end
  end)

  return lockValue(camera)
end

return useCamera
