<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# usePrevious

```Luau
function usePrevious<T>(
  scope: Fusion.Scope,
  state: Fusion.StateObject<T>,
  predicate: ((T, T) -> boolean)?
): Fusion.StateObject<T>
```

Returns a state object with the previous value of an observable state object. Initially outputs `nil`.

---

## Arguments

### scope `#!luau : Fusion.Scope`
The scope to store cleanup tasks.

### state `#!luau : Fusion.StateObject<T>`
The state object to observe for changes.

### predicate `#!luau : ((T, T) -> boolean)?`
The predicate function to assert if the value is newer. Defaults to Fusion's similarity rules.


---

## Returns `#!luau : Fusion.StateObject<T>`

A state object with the previous value of the state object. Initially outputs `nil`.

---

## Example

```Luau
local function randomColor(): Color3
  return Color3.fromHSV(math.random(0, 360), 0.75, 1)
end

local currentColor = scope:Value(randomColor())
local previousColor = scope:usePrevious(currentColor)

scope:useInterval(1, function()
  currentColor:set(randomColor)
end)

scope:Observer(currentColor):onChange(function()
  print("Current color:", peek(currentColor), "Previous color:", peek(previousColor))
end)
```
