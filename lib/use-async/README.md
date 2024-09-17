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

## Arguments

### scope `#!luau : Scope & Fusion.Scope`
The scope to store cleanup tasks.

### fallback `#!luau : Result`
The fallback value to display while the processor runs.

### processor `#!luau : (use: Fusion.Use, become: Become, scope: Scope) -> Result`
The processor of the eventual value. It receives a Use callback, a Become callback, and an inner scope.


---

## Returns `#!luau : StateObject<Result>`

A state object with the asynchronous value.
