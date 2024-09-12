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

## Arguments

| Name     | Type     | Description          |
| -------- | -------- | -------------------- |
| scope | `#!luau Scope & Fusion.Scope` | The scope to store cleanup tasks. |
| callback | `#!luau (Fusion.Use, Scope) -> ()` | A callback with a Use callback for tracking side effects and an inner scope scope to track cleanup tasks. This callback may not yield.. |
