<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useEffect

```Luau
function useEffect<Scope>(
  scope: Fusion.Scope<S & typeof(Fusion)>,
  callback: (Fusion.Use, Fusion.Scope<S>) -> ()
)
```

Perform side effects with state objects.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.Scope&lt;S &amp; typeof(Fusion)&gt; </span>
The scope to store cleanup tasks.

### callback <span class="pfu-reference-type">: (Fusion.Use, Fusion.Scope&lt;S&gt;) -&gt; () </span>
A callback with a Use callback for tracking side effects and an inner scope scope to track cleanup tasks. This callback may not yield.


---

## Example Usage

```Luau
-- TODO: write example
```
