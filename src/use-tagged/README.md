<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useTagged

```Luau
function useTagged(
  scope: Fusion.Scope,
  tag: Fusion.UsedAs<string>
): Fusion.StateObject<{ Instance }>
```

Returns a state object with every instance of a given tag. Updates when new instances get tagged or old instances get untagged.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/memory/types/scope/">Scope</a> </span>
The scope to store cleanup tasks.

### tag <span class="pfu-reference-type">: Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/state/types/usedas/">UsedAs</a>&lt;string&gt; </span>
The <a href="https://create.roblox.com/docs/reference/engine/classes/CollectionService">CollectionService</a> tag to track.


---

## Returns <span class="pfu-reference-type">-> Fusion.<a href="https://elttob.uk/Fusion/0.3/api-reference/state/types/stateobject/">StateObject</a>&lt;{ <a href="https://create.roblox.com/docs/reference/engine/classes/Instance">Instance</a> }&gt; </span>

A state object with every instance of the given tag.

---

## Example Usage

```Luau
-- TODO: write example
```
