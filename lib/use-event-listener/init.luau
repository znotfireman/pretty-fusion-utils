local Fusion = require("types/fusion")

type EventLike =
  RBXScriptSignal
  | { Connect: (self: unknown, callback: () -> ()) -> unknown }
  | { connect: (self: unknown, callback: () -> ()) -> unknown }
  | { subscribe: (self: unknown, callback: () -> ()) -> unknown }

type ConnectionLike =
  RBXScriptConnection
  | { Disconnect: (self: unknown) -> () }
  | { disconnect: (self: unknown) -> () }
  | () -> ()

local function connect(event: EventLike, callback: () -> ())
  if typeof(event) == "RBXScriptSignal" then
    -- https://devforum.roblox.com/t/deferred-engine-events/2276564/99
    local event = event :: RBXScriptSignal
    local connection
    connection = event:Connect(function(...)
      if connection.Connected then
        callback(...)
      end
    end)

    return connection
  end

  assert(typeof(event) == "table", "[pretty-fusion-utils] Event-like should be an object")
  if typeof(event.Connect) == "function" then
    return event:Connect(callback)
  elseif typeof(event.connect) == "function" then
    return event:connect(callback)
  elseif typeof(event.subscribe) == "function" then
    return event:subscribe(callback)
  end

  error("[pretty-fusion-utils] Event-like has no supported connect method")
end

local function bindDisconnect(connection: ConnectionLike)
  if typeof(connection) == "function" then
    return connection
  end

  assert(typeof(connection) == "table", "[pretty-fusion-utils] Connection-like should be an object")
  local disconnect = (connection :: any).Disconnect or (connection :: any).disconnect
  return function()
    disconnect(connection)
  end
end

--[=[
  Connects to an event-like object. The connection is automatically disconnected when the scope is cleaned up.
  @param scope The scope to store cleanup tasks.
  @param event An event-like object to connect. Can be a RBXScriptSignal, or an object with a `Connect` or `connect` method.
  @param listener An event listener to be connected.
  @return A function to disconnect the event listener.
]=]
local function useEventListener(
  scope: Fusion.Scope<Fusion.Fusion>,
  event: EventLike,
  listener: (...any) -> ()
)
  local disconnect = bindDisconnect(connect(event, listener))
  table.insert(scope, disconnect)
  return disconnect
end

return useEventListener
