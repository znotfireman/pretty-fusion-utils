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

### scope <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/memory/types/scope/">Scope</a> </span>
The scope to store cleanup tasks.

### initialValue <span class="pfu-reference-type">: T &amp; Ripple.MotionGoal </span>
The initial value of the motor.


---

## Returns <span class="pfu-reference-type">-> (Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/state/types/stateobject/">StateObject</a>&lt;T&gt;, Ripple.Motion&lt;T&gt;) </span>

A state object following a Ripple Motion along with the Motion itself.

---

## Example Usage

```Luau
-- TODO: write example
```
