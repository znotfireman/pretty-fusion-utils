<img
  src="./assets/logo-light.svg#gh-light-mode-only"
  width="100px"
  alt="Flower bouquet with Fusion accent colors"
/><img
  src="./assets/logo-dark.svg#gh-dark-mode-only"
  width="100px"
  alt="Flower bouquet with Fusion accent colors"/>

# pretty-fusion-utils

Utilities and hooks from [`pretty-vide-utils`] and [`pretty-react-hooks`] for
[Fusion 0.3](https://elttob.uk/Fusion/0.3/), along with specific Fusion
utilities.

## Prerelease

### Existing

- [X] `useCamera`
- [ ] `useDebounceCallback`
- [ ] `useDebounceEffect` (unlikely as Fusion has no concept of effects)
- [ ] `useDebounceSource` (as `useDebounceValue`)
- [ ] `useDeferEffect` (unlikely as Fusion has no concept of effects)
- [ ] `useDeferSource` (as `useDeferValue`)
- [X] `useEventListener`
- [ ] `useInterval`
- [ ] `useLifetime` (unlikely, just `useTimer` starting at zero)
- [ ] `useMotion` (unlikely, Fusion already has Tween and Spring objects)
- [X] `useMouse`
- [ ] `usePrevious` (unlikely, Fusion has no concept of component lifecycles)
- [X] `usePx`
- [ ] `useSpring` (unlikely, Fusion has Spring objects)
- [X] `useTagged`
- [ ] `useThrottleCallback`
- [ ] `useThrottleEffect` (unlikely as Fusion has no concept of effects)
- [ ] `useThrottleSource` (as `useThrottleValue`)
- [X] `useTimer`
- [ ] `useUpdateEffect` (unlikely as Fusion has no formal concept of components)
- [X] `useViewport`

### Fusion

- [X] `useAsync` (analogous to [Fusion Eventuals])
- [ ] `useCoroutine`
- [ ] `useThread`

### Misc

- [ ] Darklua setup & build system
- [ ] TypeScript support (waiting for `@rbxts/fusion@0.3`, may defer to using `@znotfireman/fusion`)
- [ ] Memoize utility for some utilities e.g. `usePx` really should be cached

[Fusion Eventuals]: https://github.com/dphfox/Fusion/issues/4
[`pretty-vide-utils`]: https://github.com/PepeElToro41/pretty-vide-utils
[`pretty-react-hooks`]: https://github.com/littensy/pretty-react-hooks
