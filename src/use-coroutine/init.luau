local Types = require("src/types")

--[=[
  Spawns a new coroutine that is closed once the scope is cleaned up.
  @param scope The scope to store clean up tasks.
  @param resume The thread to resume, or a function to spawn.
  @param ... The arguments to spawn the coroutine with.
  @return A thread that is closed once the scope is cleaned up.
]=]
local function useCoroutine<Args...>(
  scope: Types.Scope<{}>,
  resume: thread | (Args...) -> (),
  ...: Args...
): thread
  local thread: thread = resume :: any
  if typeof(resume) == "function" then
    thread = coroutine.create(resume)
  end

  coroutine.resume(thread, ...)
  table.insert(scope, function()
    if coroutine.status(thread) ~= "dead" then
      coroutine.close(thread)
    end
  end)

  return thread
end

return useCoroutine
