<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useMouse

```Luau
function useMouse(
  scope: Fusion.Scope,
  observer: (mouse: Vector2) -> ()?
): StateObject<Vector2>
```

Returns a state object with the mouse position. Updates when the mouse position changes.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.Scope </span>
The scope to store cleanup tasks.

### observer <span class="pfu-reference-type">: (mouse: Vector2) -> ()? </span>
Optional observer tracking the mouse position.


---

## Returns <span class="pfu-reference-type">-> StateObject<Vector2> </span>

A state object with the mouse position.