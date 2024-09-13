local Types = require("lib/types")
local useViewport = require("lib/use-viewport")

type Px = typeof(setmetatable(
  {} :: {
    even: (value: number) -> Types.StateObject<number>,
    scale: (value: number) -> Types.StateObject<number>,
    floor: (value: number) -> Types.StateObject<number>,
    ceil: (value: number) -> Types.StateObject<number>,
  },
  {} :: {
    __call: (self: Px, value: number) -> Types.StateObject<number>,
  }
))

local MACBOOK_AIR_RESOLUTION = Vector2.new(1280, 832)

--[=[
  Returns a state object with the current `px` unit based on the current viewport size.
  @param scope The scope to store cleanup tasks.
  @param baseResolution TThe base resolution to scale from, defaults to a Macbook Air's resolution.
  @param minimumScale The smallest scale, defaults to 50%.
  @param dominantAxis The axis to scale for, defaults to 1:1.
  @return A `px` unit that scales with the viewport size..
]=]
local function usePx(
  scope: Types.FusionScope,
  baseResolution: Vector2?,
  minimumScale: number?,
  dominantAxis: number?
): Px
  local baseResolution = baseResolution or MACBOOK_AIR_RESOLUTION
  local minimumScale = minimumScale or 0.5
  local dominantAxis = dominantAxis or 0.5

  local viewport = useViewport(scope)
  local scale = scope:Computed(function(use)
    local viewport = use(viewport)
    local width = math.log(viewport.X / baseResolution.X, 2)
    local height = math.log(viewport.Y / baseResolution.Y, 2)
    local centered = width + (height - width) * dominantAxis
    return math.max(2 * centered, minimumScale)
  end)

  local px = {} :: any
  setmetatable(px, {
    __call = function(_: any, value: number)
      return scope:Computed(function(use)
        return value * use(scale)
      end)
    end,
  })

  function px:even(value: number)
    return scope:Computed(function(use)
      return math.round(value * use(scale) * 0.5) * 2
    end)
  end

  function px:scale(value: number)
    return scope:Computed(function(use)
      return value * use(scale)
    end)
  end

  function px:floor(value: number)
    return scope:Computed(function(use)
      return math.floor(value * use(scale))
    end)
  end

  function px:ceil(value: number)
    return scope:Computed(function(use)
      return math.ceil(value * use(scale))
    end)
  end

  return px
end

return usePx
