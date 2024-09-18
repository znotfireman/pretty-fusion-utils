local Fusion = require("types/fusion")
local Ripple = require("types/ripple")
local lockValue = require("utils/lock-value")
local useMotion = require("use-motion")

--[=[
  Applies spring animations to the given value, and updates the goal with the latest value on every re-render. Returns a state object with the motor's value. Not to be confused with Fusion's own Spring objects.
  @param scope The scope to store cleanup tasks.
  @param goal The goal of the motor.
  @param options Options for the spring.
  @return A state object with the motor's value.
]=]
local function useSpring<T>(
  scope: Fusion.FusionScope,
  goal: Fusion.UsedAs<T & Ripple.MotionGoal>,
  options: Ripple.SpringOptions?
): Fusion.StateObject<T>
  local peek = scope.peek
  local value, motion = useMotion(scope, peek(goal))

  scope:Observer(goal):onChange(function()
    motion:spring(peek(goal), options)
  end)

  return lockValue(value :: any)
end

return useSpring
