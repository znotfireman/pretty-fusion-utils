local Types = require("lib/types")

--[=[
  Spawns a new thread that is cancelled once the scope is cleaned up.
  @param scope The scope to store clean up tasks.
  @param resume The thread to resume, or a function to spawn.
  @param ... The arguments to spawn the thread with.
  @return A thread that is cancelled once the scope is cleaned up.
]=]
local function useThread<Args...>(
  scope: Types.Scope<{}>,
  resume: thread | (Args...) -> (),
  ...: Args...
): thread
  local thread = task.spawn(resume, ...)
  table.insert(scope, function()
    task.cancel(thread)
  end)

  return thread
end

return useThread
