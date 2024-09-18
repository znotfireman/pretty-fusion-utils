<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useMotion

```Luau
function useMotion<T>(
  scope: Fusion.Scope,
  goal: Fusion.UsedAs<T & Ripple.MotionGoal>,
  options: Ripple.SpringOptions?
): Fusion.StateObject<T>
```

Applies spring animations to the given value, and updates the goal with the latest value on every re-render. Returns a state object with the motor's value.

---

## Arguments

### scope `#!luau : Fusion.Scope`
The scope to store cleanup tasks.

### goal `#!luau : Fusion.UsedAs<T & Ripple.MotionGoal>`
The goal of the motor.

### options `#!luau : Ripple.SpringOptions?`
Options for the spring.


---

## Returns `#!luau : Fusion.StateObject<T>`

A state object with the motor's value.
