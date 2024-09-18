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

## Parameters

### scope <span class="pfu-reference-type">: Fusion.Scope </span>
The scope to store cleanup tasks.


---

## Returns <span class="pfu-reference-type">-> StateObject<Vector2> </span>

A state object with the viewport size.