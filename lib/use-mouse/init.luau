local UserInputService = game:GetService("UserInputService")

local Types = require("lib/types")
local lockValue = require("lib/utils/lock-value")

--[=[
  Returns a state object with the mouse position. Updates when the mouse position changes.
  @param scope The scope to store cleanup tasks.
  @param observer Optional observer tracking the mouse position.
  @return A state object with the mouse position.
]=]
local function useMouse(
  scope: Types.Scope<Types.Fusion>,
  observer: (mouse: Vector2) -> ()?
): Types.StateObject<Vector2>
  local peek = scope.peek
  local mouse = scope:Value(UserInputService:GetMouseLocation())

  table.insert(
    scope,
    UserInputService.InputBegan:Connect(function(input)
      local mouseMoved = input.UserInputType == Enum.UserInputType.MouseMovement
      local touch = input.UserInputType == Enum.UserInputType.Touch
      if mouseMoved or touch then
        mouse:set(UserInputService:GetMouseLocation())
      end
    end)
  )

  if observer then
    scope:Observer(mouse):onBind(function()
      observer(peek(mouse))
    end)
  end

  return lockValue(mouse)
end

return useMouse
