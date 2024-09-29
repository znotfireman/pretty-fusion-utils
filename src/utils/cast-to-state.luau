local Fusion = require("types/fusion")

--[=[
  Only returns the value if it can be assumed to be a state object.
]=]
local function castToState<T>(value: Fusion.UsedAs<T>): Fusion.StateObject<T>?
  local metatable = getmetatable(value :: any)
  return if typeof(metatable) == "table"
      and metatable.type == "State"
      and typeof(metatable.kind) == "string"
    then value :: any
    else nil
end

return castToState
