# `useEvent`

```luau
function useEvent(
  scope: Scope,
  event: EventLike,
  listener: (...any) -> ()
): () -> ()
```

Connects an event listener to the given event. The event can be any object with
a `Connect` / `connect` / `subscribe` method that returns a connection-like
object or a cleanup function.

Returns a callback that when called disconnects the event listener.
