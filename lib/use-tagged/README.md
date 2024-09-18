<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useTagged

```Luau
function useTagged(
  scope: Fusion.Scope,
  tag: string
): Fusion.StateObject<{ Instance }>
```

Returns a state object with every instance of a given tag. Updates when new instances get tagged or old instances get untagged.

---

## Parameters

### scope <span class="pfu-reference-type">: Fusion.Scope </span>
The scope to store cleanup tasks.

### tag <span class="pfu-reference-type">: string </span>
The CollectionService tag to track.


---

## Returns <span class="pfu-reference-type">-> Fusion.StateObject&lt;{ Instance }&gt; </span>

A state object with every instance of the given tag.
