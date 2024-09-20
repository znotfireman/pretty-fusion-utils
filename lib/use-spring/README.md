<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useSpring

```Luau
function useSpring<T>(
  scope: Fusion.Scope,
  goal: Fusion.UsedAs<T & Ripple.MotionGoal>,
  options: Ripple.SpringOptions?
): Fusion.StateObject<T>
```

Applies spring animations to the given value, and updates the goal with the latest value on every re-render. Returns a state object with the motor's value. Not to be confused with Fusion's own Spring objects.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/memory/types/scope/">Scope</a> </span>
The scope to store cleanup tasks.

### goal <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/state/types/usedas/">UsedAs</a>&lt;T &amp; Ripple.MotionGoal&gt; </span>
The goal of the motor.

### options <span class="pfu-reference-type">: Ripple.SpringOptions? </span>
Options for the spring.


---

## Returns <span class="pfu-reference-type">-> Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/state/types/stateobject/">StateObject</a>&lt;T&gt; </span>

A state object with the motor's value.

---

## Example Usage

```Luau
-- TODO: write example
```
