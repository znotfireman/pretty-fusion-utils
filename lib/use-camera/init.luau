local Workspace = game:GetService("Workspace")

local Types = require("lib/types")
local lockValue = require("lib/utils/lock-value")
local useEventListener = require("lib/use-event-listener")

local onCameraChanged = Workspace:GetPropertyChangedSignal("CurrentCamera")

--[=[
  Returns a state object with the current camera. Updates when the current camera changes.
  @param scope The scope to store cleanup tasks.
  @return A state object with the current camera.
]=]
local function useCamera(scope: Types.Scope<Types.Fusion>)
  local camera = scope:Value(Workspace.CurrentCamera)

  useEventListener(scope, onCameraChanged, function()
    if Workspace.CurrentCamera then
      camera:set(Workspace.CurrentCamera)
    end
  end)

  return lockValue(camera)
end

return useCamera
