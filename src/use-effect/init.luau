local Fusion = require("types/fusion")

local function doNothing() end

--[=[
  Perform side effects with state objects.
  @param scope The scope to store cleanup tasks.
  @param callback A callback with a Use callback for tracking side effects and an inner scope scope to track cleanup tasks. This callback may not yield.
]=]
local function useEffect<S>(scope: Fusion.Scope<S & Fusion.Fusion>, callback: (Fusion.Use, S) -> ())
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
