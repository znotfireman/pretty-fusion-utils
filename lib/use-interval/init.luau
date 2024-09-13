local RunService = game:GetService("RunService")

local Fusion = require("lib/types/fusion")
local useEventListener = require("lib/use-event-listener")
local useThread = require("lib/use-thread")

--[=[
  Sets an interval that runs the callback function every `delay` seconds. If `delay` is `undefined`, the interval is cleared. If the delay changes, the the interval is cleared. If the delay changes, the interval is reset.
  @param scope The scope to store cleanup tasks.
  @param delay The delay, in seconds per each interval.
  @param callback The callback to run at an interval. Receives an inner scope that is cleaned up per each interval.
  @param immediate Whether to spawn the callback immediately.
]=]
local function useInterval<S>(
  scope: Fusion.Scope<S & Fusion.Fusion>,
  delay: Fusion.UsedAs<number?>,
  callback: (Fusion.Scope<S>) -> (),
  immediate: boolean?
)
  local scope = scope:innerScope()
  local peek = scope.peek

  local innerScope: typeof(scope)? = nil
  local immediate = if immediate ~= nil then immediate else false
  local timeElapsed = 0

  local disconnect
  disconnect = useEventListener(scope, RunService.Heartbeat, function(dt)
    timeElapsed += dt
    if typeof(peek(delay)) ~= "number" then
      return disconnect()
    end

    if timeElapsed < peek(delay) then
      return
    end

    timeElapsed = 0

    if innerScope then
      innerScope:doCleanup()
    end

    innerScope = scope:innerScope()
    callback(innerScope :: any)
  end)

  if immediate then
    innerScope = scope:innerScope()
    useThread(scope, callback, innerScope :: any)
  end
end

return useInterval
