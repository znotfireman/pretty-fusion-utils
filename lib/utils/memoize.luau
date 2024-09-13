type Pack = { [number]: unknown, n: number }
type Cache = {
  children: Cache,
  returns: Pack,
}

local function getCached(cache: Cache, arguments: Pack): Pack?
  local node = cache
  for index = 1, arguments.n do
    node = node.children and node.children[arguments[index]]
    if not node then
      return nil
    end
  end
  return node.returns
end

local function setCached(cache: Cache, arguments: Pack, returns: Pack)
  local node = cache
  local param
  for i = 1, arguments.n do
    param = arguments[i]
    node.children = node.children or {} :: Cache
    node.children[param] = node.children[param] or {}
    node = node.children[param]
  end
  node.returns = returns
end

--[=[
  Returns a function that it's returns is cached to be returned when the same
  arguments occur.
  @param fn The function to memoize.
  @return The memoized function.
]=]
local function memoize<Args..., Returns...>(fn: (Args...) -> Returns...): (Args...) -> Returns...
  local cache = {} :: Cache

  return function(...: Args...): Returns...
    local arguments = table.pack(...)

    local returns = getCached(cache, arguments)
    if not returns then
      returns = table.pack(fn(...))
      setCached(cache, arguments, assert(returns, "Luau"))
    end

    return table.unpack(returns :: any)
  end
end

return memoize
