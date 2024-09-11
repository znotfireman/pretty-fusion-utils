local CollectionService = game:GetService("CollectionService")

local Types = require("src/types")
local lockValue = require("src/utils/lock-value")
local useEventListener = require("src/use-event-listener")

--[=[
  Returns a state object with every instance of a given tag. Updates when new instances get tagged or old instances get untagged.
  @param scope The scope to store cleanup tasks.
  @param tag The CollectionService tag to track.
  @return A state object with every instance of the given tag.
]=]
local function useTagged(scope: Types.FusionScope, tag: string): Types.StateObject<{ Instance }>
  local peek = scope.peek
  local instances = scope:Value(CollectionService:GetTagged(tag))

  useEventListener(scope, CollectionService:GetInstanceAddedSignal(tag), function(instance)
    local freshInstances = table.clone(peek(instances))
    table.insert(freshInstances, instance)
    instances:set(freshInstances)
  end)

  useEventListener(scope, CollectionService:GetInstanceRemovedSignal(tag), function(instance)
    local freshInstances = table.clone(peek(instances))
    local index = table.find(freshInstances, instance)
    if index then
      table.remove(freshInstances, index)
    end
    instances:set(freshInstances)
  end)

  return lockValue(instances)
end

return useTagged
