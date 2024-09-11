local Types = require("src/types")
local lockValue = require("src/utils/lock-value")

local function isSimilar(a: unknown, b: unknown): boolean
  local typeA = typeof(a)
  local isTable = typeA == "table"
  local isUserdata = typeA == "userdata"
  return if not (isTable or isUserdata)
    then a == b or a ~= a and b ~= b
    elseif
      typeA == typeof(b)
      and (isUserdata or table.isfrozen(a :: any) or getmetatable(a :: any) ~= nil)
    then a == b
    else false
end

--[=[
  Returns a state object with the previous value of an observable state object. Initially outputs `nil`.
  @param scope The scope to store cleanup tasks.
  @param state The state object to observe for changes.
  @param predicate The predicate function to assert if the value is newer. Defaults to Fusion's similarity rules.
  @return A state object with the previous value of the state object.
]=]
local function usePrevious<T>(
  scope: Types.FusionScope,
  state: Types.StateObject<T>,
  predicate: ((T, T) -> boolean)?
): Types.StateObject<T?>
  local peek = scope.peek

  local previous = scope:Value(nil :: any)
  local predicate: (T, T) -> boolean = predicate or isSimilar

  scope:Observer(state):onChange(function()
    local current = peek(state)
    local old = peek(previous)

    if not predicate(old, current) then
      previous:set(current)
    end
  end)

  return lockValue(previous)
end

return usePrevious
