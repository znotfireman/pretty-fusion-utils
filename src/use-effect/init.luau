local Types = require("src/types")

--[=[
  Perform side effects with state objects.
  @deprecated Not recommended as Fusion has no concept of side effects.
  @param A callback with a Use callback for tracking side effects and an inner
  scope to track cleanup tasks. This callback may not yield.
]=]
local function useEffect<Scope>(
  scope: Scope & Types.FusionScope,
  callback: (Types.Use, Scope & Types.FusionScope) -> ()
)
  -- FUTURE: This seems BAD. Maybe wait for a built-in?
  -- TODO: async support
  -- FIXME: computed lazily evaluates, use observers
  scope:Computed(function(use, scope)
    callback(use, scope)
    return {}
  end)
end

return useEffect
