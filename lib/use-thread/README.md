<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useThread

```Luau
function useThread<Args...>(
  scope: Fusion.Scope,
  resume: thread | (Args...) -> (),
  ...: Args...
): thread
```

Spawns a new thread that is cancelled once the scope is cleaned up.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.Scope </span>
The scope to store clean up tasks.

### resume <span class="pfu-reference-type">: thread | (Args...) -&gt; () </span>
The thread to resume, or a function to spawn.

### ... <span class="pfu-reference-type">: Args... </span>
The arguments to spawn the thread with.


---

## Returns <span class="pfu-reference-type">-> thread </span>

A thread that is cancelled once the scope is cleaned up.
