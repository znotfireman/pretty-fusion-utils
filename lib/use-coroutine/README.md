<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useCoroutine

```Luau
function useCoroutine<Args...>(
  scope: Fusion.Scope,
  resume: thread | (Args...) -> (),
  ...: Args...
): thread
```

Spawns a new coroutine that is closed once the scope is cleaned up.

---

## Arguments

### scope `#!luau : Fusion.Scope`
The scope to store clean up tasks.

### resume `#!luau : thread | (Args...) -> ()`
The thread to resume, or a function to spawn.

### ... `#!luau : Args...`
The arguments to spawn the coroutine with.


---

## Returns `#!luau : thread`

A thread that is closed once the scope is cleaned up.
