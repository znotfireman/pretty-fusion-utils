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

### scope <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/memory/types/scope/">Scope</a> </span>
The scope to store cleanup tasks.

### event <span class="pfu-reference-type">: EventLike </span>
An event-like object to connect. Can be a <a href="https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptSignal">RBXScriptSignal</a>, or an object with a `Connect` or `connect` method.

### listener <span class="pfu-reference-type">: (...any) -&gt; () </span>
An event listener to be connected.


---

## Returns <span class="pfu-reference-type">-> () -&gt; () </span>

A function to disconnect the event listener.

---

## Example Usage

```Luau
-- TODO: write example
```
