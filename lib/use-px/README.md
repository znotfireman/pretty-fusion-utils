<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# usePx

```Luau
function usePx(
  scope: Fusion.Scope,
  baseResolution: Fusion.UsedAs<Vector2>?,
  minimumScale: Fusion.UsedAs<number>?,
  dominantAxis: Fusion.UsedAs<number>?
): Px
```

Returns a state object with the current `px` unit based on the current viewport size.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/memory/types/scope/">Scope</a> </span>
The scope to store cleanup tasks.

### baseResolution <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/state/types/usedas/">UsedAs</a>&lt;<a href="https://create.roblox.com/docs/reference/engine/datatypes/Vector2">Vector2</a>&gt;? </span>
TThe base resolution to scale from, defaults to a Macbook Air's resolution.

### minimumScale <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/state/types/usedas/">UsedAs</a>&lt;number&gt;? </span>
The smallest scale, defaults to 50%.

### dominantAxis <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/state/types/usedas/">UsedAs</a>&lt;number&gt;? </span>
The axis to scale for, defaults to 1:1.


---

## Returns <span class="pfu-reference-type">-> Px </span>

A `px` unit that scales with the viewport size.

---

## Example Usage

```Luau
-- TODO: write example
```
