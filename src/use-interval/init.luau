local RunService = game:GetService("RunService")

local Types = require("src/types")
local useEventListener = require("src/use-event-listener")
local useThread = require("src/use-thread")

--[=[
  Sets an interval that runs the callback function every `delay` seconds. If
  `delay` is `undefined`, the interval is cleared. If the delay changes, the
* interval is reset.
  @param scope The scope to store clean up tasks.
  @param delay The delay, in seconds per each interval.
  @param callback The callback to run at an interval. Receives an inner scope that is cleaned up per each interval.
  @param immediate Whether to spawn the callback immediately.
]=]
local function useInterval<S>(
  scope: Types.Scope<S & Types.Fusion>,
  delay: Types.UsedAs<number?>,
  callback: (Types.Scope<S>) -> (),
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
