<!-- This file was @generated and is not intended for manual editing. -->
<!-- Run `lune run regen` to generate a fresh README. -->

# useTagged

```Luau
function useTagged(
  scope: Fusion.Scope,
  tag: string
): StateObject<{ Instance }>
```

Returns a state object with every instance of a given tag. Updates when new instances get tagged or old instances get untagged.

---

## Arguments

### scope `#!luau : Fusion.Scope`
The scope to store cleanup tasks.

### tag `#!luau : string`
The CollectionService tag to track.


---

## Returns `#!luau : StateObject<{ Instance }>`

A state object with every instance of the given tag.
