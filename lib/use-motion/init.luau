local RunService = game:GetService("RunService")

local Finder = require("utils/finder")
local Fusion = require("types/fusion")
local Ripple = require("types/ripple")
local lockValue = require("utils/lock-value")
local useEventListener = require("use-event-listener")

--[=[
  Returns a state object following a Ripple Motion along with the Motion
    itself.
  @param scope The scope to store cleanup tasks.
  @param initialValue The initial value of the motor.
  @return A state object following a Ripple Motion along with the Motion itself.
]=]
local function useMotion<T>(
  scope: Fusion.FusionScope,
  initialValue: T & Ripple.MotionGoal
): (Fusion.StateObject<T>, Ripple.Motion<T>)
  local Ripple = Finder.find(Finder.libraries.ripple, "useMotion") :: Ripple.Ripple
  local peek = scope.peek

  local motion = Ripple.createMotion(initialValue :: T)
  local motionValue = scope:Value(initialValue)

  useEventListener(scope, RunService.Heartbeat, function(dt: number)
    local value = motion:step(dt)
    if value ~= peek(motionValue) then
      motionValue:set(value)
    end
  end)

  return lockValue(motionValue), motion
end

return useMotion
