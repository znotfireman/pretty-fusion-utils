local Types = require("src/types")
local castToState = require("src/utils/cast-to-state")
local lockValue = require("src/utils/lock-value")

type Become = <T>(value: T) -> T

--[=[
  Returns a state object with an value from an asynchronous processor. The
  processor is given a Use callback that adds dependencies, a Become callback to
  alter the current eventual value, and an inner scope to add cleanup tasks to.
  @param outerScope The scope to use for destruction tasks.
  @param fallback The fallback value to display while the processor runs.
  @param processor The processor of the eventual value. It receives a Use callback, a Become callback, and an inner scope.
  @return A state object with the asynchronous value.
]=]

-- FUTURE: This util is to be obsolete once Fusion issue #4 is implemented:
-- https://github.com/dphfox/Fusion/issues/4
local function useAsync<Scope, Result>(
  outerScope: Scope & Types.FusionScope,
  fallback: Result,
  processor: (
    use: Types.Use,
    become: Become,
    scope: Scope
  ) -> Result
): Types.StateObject<Result>
  local scope = outerScope:scoped()
  local peek = scope.peek

  local eventual = scope:Value(fallback)
  local observers: { [Types.StateObject<any>]: () -> () } = {}
  local innerScope: typeof(outerScope)? = nil

  local function become<T>(value: T): T
    return eventual:set(value)
  end

  local function clear()
    if innerScope then
      innerScope:doCleanup()
      innerScope = nil
    end
    if next(observers) ~= nil then
      for _, disconnect in pairs(observers) do
        pcall(disconnect)
      end
      table.clear(observers)
    end
    eventual:set(fallback)
  end

  -- Because Computed cant handle async processors, we have to mimic it's
  -- behavior through some... devious ways.
  local function process()
    clear()
    local function use<T>(target: Types.UsedAs<T>): T
      if not castToState(target) then
        return target :: any
      end
      local stateObject = target :: Types.StateObject<T>
      observers[stateObject] = scope:Observer(stateObject):onChange(function()
        task.spawn(process)
      end)
      return peek(stateObject)
    end

    innerScope = scope:innerScope()
    local ok, result = xpcall(processor, debug.traceback, use, become, innerScope :: any)
    if ok then
      eventual:set(result)
    end

    warn(`[pretty-fusion-utils] useEventual processor thrown error during processing:\n{result}`)
    eventual:set(fallback)
  end

  return lockValue(eventual)
end

return useAsync
