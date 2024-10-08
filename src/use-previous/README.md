<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# usePrevious

```Luau
function usePrevious<T>(
  scope: Fusion.Scope,
  state: Fusion.UsedAs<T>,
  predicate: ((T, T) -> boolean)?
): Fusion.StateObject<T>
```

Returns a state object with the previous value of an observable state object. Initially outputs `nil`.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/memory/types/scope/">Scope</a> </span>
The scope to store cleanup tasks.

### state <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/state/types/usedas/">UsedAs</a>&lt;T&gt; </span>
The state object to observe for changes.

### predicate <span class="pfu-reference-type">: ((T, T) -&gt; boolean)? </span>
The predicate function to assert if the value is newer. Defaults to Fusion's similarity rules.


---

## Returns <span class="pfu-reference-type">-> Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/state/types/stateobject/">StateObject</a>&lt;T&gt; </span>

A state object with the previous value of the state object. Initially outputs `nil`.

---

## Example Usage

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
