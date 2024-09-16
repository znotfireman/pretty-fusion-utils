<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useMotion

```Luau
function useMotion<T>(
  scope: Fusion.Scope,
  initialValue: T & Ripple.MotionGoal
): (Fusion.StateObject<T>, Ripple.Motion<T>)
```

Returns a state object following a Ripple Motion along with the Motion
  itself.

---

## Arguments

| Name     | Type     | Description          |
| -------- | -------- | -------------------- |
| scope | `#!luau Fusion.Scope` | The scope to store cleanup tasks. |
| initialValue | `#!luau T & Ripple.MotionGoal` | The initial value of the motor. |

---

## Returns

| Type     | Description                  |
| -------- | ---------------------------- |
| `#!luau (Fusion.StateObject<T>, Ripple.Motion<T>)` | A state object following a Ripple Motion along with the Motion itself. |
