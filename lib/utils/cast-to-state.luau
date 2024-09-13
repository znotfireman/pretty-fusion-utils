local Types = require("lib/types")

--[=[
  Only returns the value if it can be assumed to be a state object.
]=]
local function castToState<T>(value: Types.UsedAs<T>): Types.StateObject<T>?
  local metatable = getmetatable(value :: any)
  return if typeof(metatable) == "table"
      and metatable.type == "State"
      and typeof(metatable.kind) == "string"
    then value :: any
    else nil
end

return castToState
