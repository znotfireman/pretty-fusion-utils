local roblox = require("@lune/roblox")

type Links = {
  prefixed: boolean,
  links: { [string]: string },
}

local function Links(x: Links)
  table.freeze(x.links)
  return table.freeze(x)
end

-- TODO: reconsider my sanity and try to use lune for this
local ROBLOX_DATATYPES = table.freeze {
  "Axes",
  "BrickColor",
  "CatalogSearchParams",
  "CFrame",
  "Color3",
  "ColorSequence",
  "ColorSequenceKeypoint",
  "Content",
  "DateTime",
  "DockWidgetPluginGuiInfo",
  "Enum",
  "EnumItem",
  "Enums",
  "Faces",
  "FloatCurveKey",
  "Font",
  "Instance",
  "NumberRange",
  "NumberSequence",
  "NumberSequenceKeypoint",
  "OverlapParams",
  "Path2DControlPoint",
  "PathWaypoint",
  "PhysicalProperties",
  "Random",
  "Ray",
  "RaycastParams",
  "RaycastResult",
  "RBXScriptConnection",
  "RBXScriptSignal",
  "Rect",
  "Region3",
  "Region3int16",
  "RotationCurveKey",
  "Secret",
  "SharedTable",
  "TweenInfo",
  "UDim",
  "UDim2",
  "Vector2",
  "Vector2int16",
  "Vector3",
  "Vector3int16",
}

local robloxLinks = {}
local reflection = roblox.getReflectionDatabase()

for _, dataType in ROBLOX_DATATYPES do
  robloxLinks[dataType] = `https://create.roblox.com/docs/reference/engine/datatypes/{dataType}`
end
for _, class in reflection:GetClassNames() do
  robloxLinks[class] = `https://create.roblox.com/docs/reference/engine/classes/{class}`
end

local TYPE_DOCUMENTATION: { [string]: Links } = table.freeze {
  Roblox = Links {
    prefixed = false,
    links = robloxLinks,
  },
  Fusion = Links {
    prefixed = true,
    links = {
      Contextual = "https://elttob.uk/Fusion/0.3/api-reference/general/types/contextual/",
      Version = "https://elttob.uk/Fusion/0.3/api-reference/general/types/version/",

      Scope = "https://elttob.uk/Fusion/0.3/api-reference/memory/types/scope/",
      ScopedObject = "https://elttob.uk/Fusion/0.3/api-reference/memory/types/scopedobject/",
      Task = "https://elttob.uk/Fusion/0.3/api-reference/memory/types/task/",

      GraphObject = "https://elttob.uk/Fusion/0.3/api-reference/graph/types/graphobject/",
      Observer = "https://elttob.uk/Fusion/0.3/api-reference/graph/types/observer/",

      UsedAs = "https://elttob.uk/Fusion/0.3/api-reference/state/types/usedas/",
      Computed = "https://elttob.uk/Fusion/0.3/api-reference/state/types/computed/",
      For = "https://elttob.uk/Fusion/0.3/api-reference/state/types/for/",
      StateObject = "https://elttob.uk/Fusion/0.3/api-reference/state/types/stateobject/",
      Use = "https://elttob.uk/Fusion/0.3/api-reference/state/types/use/",
      Value = "https://elttob.uk/Fusion/0.3/api-reference/state/types/value/",

      Child = "https://elttob.uk/Fusion/0.3/api-reference/roblox/types/child/",
      PropertyTable = "https://elttob.uk/Fusion/0.3/api-reference/roblox/types/propertytable/",
      SpecialKey = "https://elttob.uk/Fusion/0.3/api-reference/roblox/types/specialkey/",

      Animatable = "https://elttob.uk/Fusion/0.3/api-reference/animation/types/animatable/",
      Spring = "https://elttob.uk/Fusion/0.3/api-reference/animation/types/spring/",
      Tween = "https://elttob.uk/Fusion/0.3/api-reference/animation/types/tween/",
    },
  },
}

local patterns = {}
for library, links in TYPE_DOCUMENTATION do
  for type, url in links.links do
    local pattern = if links.prefixed then `{library}%.{type}` else type
    local replacement = if links.prefixed
      then `{library}.<a href="{url}">{type}</a>`
      else `<a href="{url}">{type}</a>`

    patterns[pattern] = replacement
  end
end

function replaceLinks(str: string): string
  for pattern, replacement in patterns do
    str = str:gsub(pattern, function()
      return replacement
    end)
  end

  -- i got lazy
  str = str
    :gsub(
      'Fusion%.<a href="https://elttob%.uk/Fusion/0%.3/api%-reference/state/types/use/">Use</a>dAs',
      function(old)
        return patterns["Fusion%.UsedAs"]
      end
    )
    :gsub('RBX<a href="(.+)">Script</a>Signal', function(old)
      return patterns["RBXScriptSignal"]
    end)

  return str
end

return replaceLinks
