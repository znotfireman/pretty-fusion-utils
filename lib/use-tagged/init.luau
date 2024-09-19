local CollectionService = game:GetService("CollectionService")

local Fusion = require("types/fusion")
local lockValue = require("utils/lock-value")
local useEventListener = require("use-event-listener")

--[=[
  Returns a state object with every instance of a given tag. Updates when new instances get tagged or old instances get untagged.
  @param scope The scope to store cleanup tasks.
  @param tag The CollectionService tag to track.
  @return A state object with every instance of the given tag.
]=]
local function useTagged(
  scope: Fusion.FusionScope,
  tag: Fusion.UsedAs<string>
): Fusion.StateObject<{ Instance }>
  local scope = scope:innerScope()
  local peek = scope.peek

  local instances = scope:Value({} :: { Instance })
  local eventScope: typeof(scope)? = nil
  scope:Observer(tag):onBind(function()
    if eventScope then
      eventScope:doCleanup()
    end

    eventScope = scope:innerScope()
    instances = CollectionService:GetTagged(peek(tag))

    useEventListener(
      assert(eventScope, "Luau"),
      CollectionService:GetInstanceAddedSignal(tag),
      function(instance)
        local freshInstances = table.clone(peek(instances))
        table.insert(freshInstances, instance)
        instances:set(freshInstances)
      end
    )

    useEventListener(
      assert(eventScope, "Luau"),
      CollectionService:GetInstanceAddedSignal(tag),
      function(instance)
        local freshInstances = table.clone(peek(instances))
        table.insert(freshInstances, instance)
        instances:set(freshInstances)
      end
    )
  end)

  return lockValue(instances)
end

return useTagged
