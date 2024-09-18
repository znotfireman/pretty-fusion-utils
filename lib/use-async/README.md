<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useAsync

```Luau
function useAsync<Scope, Result>(
  scope: Scope & Fusion.Scope,
  fallback: Result,
  processor: (use: Fusion.Use, become: Become, scope: Scope) -> Result
): StateObject<Result>
```

Returns a state object with an value from an asynchronous processor. The processor is given a Use callback that adds dependencies, a Become callback alter the current eventual value, and an inner scope to add cleanup tasks to.

---

## Parameters

### scope <span class="pfu-reference-type">: Scope & Fusion.Scope </span>
The scope to store cleanup tasks.

### fallback <span class="pfu-reference-type">: Result </span>
The fallback value to display while the processor runs.

### processor <span class="pfu-reference-type">: (use: Fusion.Use, become: Become, scope: Scope) -> Result </span>
The processor of the eventual value. It receives a Use callback, a Become callback, and an inner scope.


---

## Returns <span class="pfu-reference-type">-> StateObject<Result> </span>

A state object with the asynchronous value.
