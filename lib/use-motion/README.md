<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useMotion

```Luau
function useMotion<T>(
  scope: Fusion.Scope,
  initialValue: T & Ripple.MotionGoal
): (Fusion.StateObject<T>, Ripple.Motion<T>)
```

Returns a state object following a Ripple Motion along with the Motion itself.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.Scope </span>
The scope to store cleanup tasks.

### initialValue <span class="pfu-reference-type">: T & Ripple.MotionGoal </span>
The initial value of the motor.


---

## Returns <span class="pfu-reference-type">-> (Fusion.StateObject<T>, Ripple.Motion<T>) </span>

A state object following a Ripple Motion along with the Motion itself.
