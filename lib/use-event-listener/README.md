<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useEventListener

```Luau
function useEventListener(
  scope: Fusion.Scope,
  event: EventLike,
  listener: (...any) -> ()
): () -> ()
```

Connects to an event-like object. The connection is automatically disconnected when the scope is cleaned up.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.Scope </span>
The scope to store cleanup tasks.

### event <span class="pfu-reference-type">: EventLike </span>
An event-like object to connect. Can be a RBXScriptSignal, or an object with a `Connect` or `connect` method.

### listener <span class="pfu-reference-type">: (...any) -&gt; () </span>
An event listener to be connected.


---

## Returns <span class="pfu-reference-type">-> () -&gt; () </span>

A function to disconnect the event listener.
