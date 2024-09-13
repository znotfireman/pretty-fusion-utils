local Types = require("lib/types")

--[=[
  Widens the type of a value object so setting it returns a type error.
  @return The value object with the newly casted type.
]=]
local function lockValue<T>(value: Types.Value<T>): Types.StateObject<T>
  -- FUTURE: Could use a Computed object here or a built-in readonly object
  return value
end

return lockValue
