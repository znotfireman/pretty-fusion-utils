local RunService = game:GetService("RunService")

local Types = require("src/types")
local useEventListener = require("src/use-event-listener")

type Timer = Types.Value<number> & {
  start: (self: Timer) -> (),
  stop: (self: Timer) -> (),
  reset: (self: Timer) -> (),
}

--[=[
  Creates a timer that can be used to track a value over time.
  @param initialValue The initial value of the timer.
  @return A timer object.
]=]
local function useTimer(scope: Types.Scope<Types.Fusion>, initial: number?): Timer
  local timer = scope:Value(initial or 0)
  local running = true

  useEventListener(scope, RunService.Heartbeat, function(dt: number)
    if running then
      timer:set(scope.peek(timer) + dt)
    end
  end)

  local self = {} :: Timer
  setmetatable(self, {
    -- Don't lock this value object to expose the :set method
    __index = timer,
  })

  function self:start()
    running = true
  end

  function self:stop()
    running = false
  end

  function self:reset(toInitial: boolean?)
    timer:set(toInitial and initial or 0)
  end

  return self
end

return useTimer
