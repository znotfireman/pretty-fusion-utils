<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useMouse

```Luau
function useMouse(
  scope: Fusion.Scope,
  observer: (mouse: Vector2) -> ()?
): Fusion.StateObject<Vector2>
```

Returns a state object with the mouse position. Updates when the mouse position changes.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/memory/types/scope/">Scope</a> </span>
The scope to store cleanup tasks.

### observer <span class="pfu-reference-type">: (mouse: <a href="https://create.roblox.com/docs/reference/engine/datatypes/Vector2">Vector2</a>) -&gt; ()? </span>
Optional observer tracking the mouse position.


---

## Returns <span class="pfu-reference-type">-> Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/state/types/stateobject/">StateObject</a>&lt;<a href="https://create.roblox.com/docs/reference/engine/datatypes/Vector2">Vector2</a>&gt; </span>

A state object with the mouse position.

---

## Example Usage

```Luau
-- TODO: write example
```
