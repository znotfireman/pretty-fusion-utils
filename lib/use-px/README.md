<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# usePx

```Luau
function usePx(
  scope: Fusion.Scope,
  baseResolution: Vector2?,
  minimumScale: number?,
  dominantAxis: number?
): Px
```

Returns a state object with the current `px` unit based on the current viewport size.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.Scope </span>
The scope to store cleanup tasks.

### baseResolution <span class="pfu-reference-type">: Vector2? </span>
TThe base resolution to scale from, defaults to a Macbook Air's resolution.

### minimumScale <span class="pfu-reference-type">: number? </span>
The smallest scale, defaults to 50%.

### dominantAxis <span class="pfu-reference-type">: number? </span>
The axis to scale for, defaults to 1:1.


---

## Returns <span class="pfu-reference-type">-> Px </span>

A `px` unit that scales with the viewport size.
