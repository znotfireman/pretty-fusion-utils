<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useEventual

```Luau
function useEventual<T, S>(
  scope: Fusion.Scope<S & typeof(Fusion)>,
  fallback: T,
  processor: (use: Fusion.Use, become: Become, scope: Fusion.Scope<S>) -> T
): Fusion.StateObject<T>
```

Returns a state object with an eventual value from a processor. The processor is given a Use callback that adds dependencies, a Become callback alter the current eventual value, and an inner scope to add cleanup tasks to.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.Scope<S & typeof(Fusion)> </span>
The scope to store cleanup tasks.

### fallback <span class="pfu-reference-type">: T </span>
The fallback value to display while the processor runs.

### processor <span class="pfu-reference-type">: (use: Fusion.Use, become: Become, scope: Fusion.Scope<S>) -> T </span>
The processor of the eventual value. It receives a Use callback, a Become callback, and an inner scope.


---

## Returns <span class="pfu-reference-type">-> Fusion.StateObject<T> </span>

A state object with the asynchronous value.
