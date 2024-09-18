<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useCleanup

```Luau
function useCleanup<Tasks...>(
  scope: Fusion.Scope,
  ...: Tasks...
): Tasks...
```

Add clean up tasks to the scope. Returns the clean up tasks, allowing it to be used in declarations.

---

## Arguments

### scope `#!luau : Fusion.Scope`
The scope to store cleanup tasks.

### ... `#!luau : Tasks...`
The tasks to be added.


---

## Returns `#!luau : Tasks...`

The tasks that has been added.

---

## Example

```Luau
local timeElapsed = scope:Value(0)
local connection = scope:useTasks(
  RunService.PostSimulation:Connect(function(dt)
    timeElapsed:set(peek(timeElapsed) + dt)
  end)
)

task.wait(5)
connection:Disconnect()
print(`Took around {peek(timeElapsed)} seconds`)
```
