local Fusion = require("types/fusion")

--[=[
  Add clean up tasks to the scope. Returns the clean up tasks, allowing it to be used in declarations.
  @param scope The scope to store cleanup tasks.
  @param ... The tasks to be added.
  @return The tasks that has been added.
]=]
local function useCleanup<Tasks...>(scope: Fusion.FusionScope, ...: Tasks...): Tasks...
  for index = 1, select("#", ...) do
    table.insert(scope, select(index, ...))
  end
  return ...
end

return useCleanup
