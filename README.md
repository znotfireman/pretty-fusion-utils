<img
  src="./assets/logo.svg"
  height="100px"
  alt="Flower"
/>

# pretty fusion utils

**Spread the joy of Fusion.** `pretty-fusion-utils` is an opinionated collection
of useful <a href="https://elttob.uk/Fusion/0.3/">Fusion 0.3</a> utilities,
borrowed from <a href="https://github.com/PepeElToro41/pretty-vide-utils/">Vide</a>
and <a href="https://github.com/littensy/pretty-react-hooks/">React hooks</a>.

## Prerelease

### Existing

- [X] `useCamera`
- [ ] `useDebounceCallback`
- [ ] `useDebounceEffect` (unlikely as Fusion has no concept of effects)
- [ ] `useDebounceSource` (as `useDebounceValue`)
- [ ] `useDeferEffect` (unlikely as Fusion has no concept of effects)
- [ ] `useDeferSource` (as `useDeferValue`)
- [X] `useEventListener`
- [X] `useInterval`
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

- [X] `useCoroutine`
- [X] `useTasks`
- [X] `useThread`
- [X] `useAsync` (analogous to [Fusion Eventuals])
- [X] `useEffect` (somewhat broken, see `src/use-effect/init.luau`)

### Misc

- [X] Darklua setup & build system
- [ ] TypeScript support (waiting for `@rbxts/fusion@0.3`, may defer to using `@znotfireman/fusion`)
- [ ] Memoize utility for some utilities e.g. `usePx` really should be cached

[Fusion Eventuals]: https://github.com/dphfox/Fusion/issues/4
[`pretty-vide-utils`]: https://github.com/PepeElToro41/pretty-vide-utils
[`pretty-react-hooks`]: https://github.com/littensy/pretty-react-hooks

## License

`pretty-fusion-utils` is avalible under MIT or Apache 2.0 terms.
