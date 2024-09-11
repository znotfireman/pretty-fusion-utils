local Types = require("src/types")

local function doNothing() end

--[=[
  Perform side effects with state objects.
  @deprecated Not recommended as Fusion has no concept of side effects.
  @param A callback with a Use callback for tracking side effects and an inner
  scope to track cleanup tasks. This callback may not yield.
]=]
local function useEffect<Scope>(scope: Scope & Types.FusionScope, callback: (Types.Use, Scope) -> ())
  -- Top ten silliest fusion hacks of all time
  -- FIXME: as funny as this is i need to make it yieldable
  scope
    :Observer(scope:Computed(function(use, scope)
      callback(use, scope)
      return {}
    end))
    :onChange(doNothing)
end

return useEffect
