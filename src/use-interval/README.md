<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useInterval

```Luau
function useInterval<S>(
  scope: Fusion.Scope<S & typeof(Fusion)>,
  delay: Fusion.UsedAs<number?>,
  callback: (Fusion.Scope<S>) -> (),
  immediate: boolean?
)
```

Sets an interval that runs the callback function every `delay` seconds. If `delay` is `undefined`, the interval is cleared. If the delay changes, the the interval is cleared. If the delay changes, the interval is reset.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/memory/types/scope/">Scope</a>&lt;S &amp; typeof(Fusion)&gt; </span>
The scope to store cleanup tasks.

### delay <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/state/types/usedas/">UsedAs</a>&lt;number?&gt; </span>
The delay, in seconds per each interval.

### callback <span class="pfu-reference-type">: (Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/memory/types/scope/">Scope</a>&lt;S&gt;) -&gt; () </span>
The callback to run at an interval. Receives an inner scope that is cleaned up per each interval.

### immediate <span class="pfu-reference-type">: boolean? </span>
Whether to spawn the callback immediately.


---

## Example Usage

```Luau
-- TODO: write example
```
