type Library = {
  name: string,
  exports: unknown,
}

local Finder = {}
Finder.libraries = {} :: { [string]: Library }

do
  local springTypes = {
    tension = "number",
    friction = "number",
  }

  Finder.libraries.ripple = {
    name = "ripple",
    exports = {
      createMotion = "function",
      immediate = "function",
      linear = "function",
      spring = "function",
      tween = "function",
      config = {
        spring = {
          default = springTypes,
          gentle = springTypes,
          wobbly = springTypes,
          stiff = springTypes,
          slow = springTypes,
          molasses = springTypes,
        },
        linear = {
          default = { speed = "number" },
        },
        tween = {
          default = {
            time = "number",
            style = "EnumItem",
            direction = "EnumItem",
            repeatCount = "number",
            reverses = "boolean",
            delayTime = "number",
          },
        },
      },
    },
  }
end

local function compareTypes(library: unknown, target: unknown)
  if typeof(library) == "string" then
    return library == typeof(target)
  end

  if typeof(target) ~= "table" then
    return false
  end

  for key, value in library :: any do
    if not compareTypes(value, (target :: any)[key]) then
      return false
    end
  end

  return true
end

function Finder.find(library: Library, usage: string)
  local parent = script.Parent.Parent
  local lowercaseName = library.name:lower()

  while parent do
    local foundLibrary = parent:FindFirstChild(library) or parent:FindFirstChild(lowercaseName)

    if foundLibrary and foundLibrary:IsA("ModuleScript") then
      local exports = require(foundLibrary) :: any
      if compareTypes(library, exports) then
        return exports :: any
      end
    end

    parent = parent.Parent
  end

  error(`[pretty-fusion-utils] Cannot find library {library.name} for {usage}`)
end

return Finder
