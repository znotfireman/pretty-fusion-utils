<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useViewport

```Luau
function useViewport(
  scope: Fusion.Scope
): StateObject<Vector2>
```

Returns the current viewport size. Updates when the current camera changes or when the viewport size is changed.

---

## Arguments

| Name     | Type     | Description          |
| -------- | -------- | -------------------- |
| scope | `#!luau Fusion.Scope` | The scope to store cleanup tasks. |

---

## Returns

| Type     | Description                  |
| -------- | ---------------------------- |
| `#!luau StateObject<Vector2>` | A state object with the viewport size. |
