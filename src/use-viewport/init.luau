local Fusion = require("types/fusion")
local lockValue = require("utils/lock-value")
local useCamera = require("use-camera")

--[=[
  Returns the current viewport size. Updates when the current camera changes or when the viewport size is changed.
  @param scope The scope to store cleanup tasks.
  @return A state object with the viewport size.
]=]
local function useViewport(
  outerScope: Fusion.FusionScope,
  observer: (viewport: Vector2) -> ()?
): Fusion.StateObject<Vector2>
  local scope = outerScope:innerScope()

  local camera = useCamera(scope)
  local viewport = scope:Value(Vector2.zero)

  scope:Observer(camera):onBind(function()
    local newCamera = scope.peek(camera)
    local onViewportChanged = newCamera:GetPropertyChangedSignal("ViewportSize")
    table.insert(scope, {
      onViewportChanged:Connect(function()
        viewport:set(newCamera.ViewportSize)
      end),
    })
  end)

  if observer then
    scope:Observer(viewport):onBind(function()
      observer(scope.peek(viewport))
    end)
  end

  return lockValue(viewport)
end

return useViewport
