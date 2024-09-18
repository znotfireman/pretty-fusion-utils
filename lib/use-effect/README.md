<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useEffect

```Luau
function useEffect<Scope>(
  scope: Scope & Fusion.Scope,
  callback: (Fusion.Use, Scope) -> ()
)
```

Perform side effects with state objects.

---

## Parameters

### scope <span class="pfu-reference-type">: Scope & Fusion.Scope </span>
The scope to store cleanup tasks.

### callback <span class="pfu-reference-type">: (Fusion.Use, Scope) -> () </span>
A callback with a Use callback for tracking side effects and an inner scope scope to track cleanup tasks. This callback may not yield..

