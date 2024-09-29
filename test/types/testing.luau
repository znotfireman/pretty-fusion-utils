type This = {
  never: This,
  exists: () -> (),
  exist: () -> (),
  equals: (expectedValue: unknown) -> (),
  equal: (expectedValue: unknown) -> (),
  isA: (expectedType: string) -> (),
  fails: () -> (),
  fail: () -> (),
  throws: () -> (),
  throw: () -> (),
  matches: (pattern: string) -> (),
  match: (pattern: string) -> (),
  [string]: This,
}

type It = { __stdIt: never? }
type Test = { __stdDtest: never? }

return (nil :: any) :: {
  it: (should: string, callback: (expect: (value: unknown) -> This) -> ()) -> It,
  test: (feature: string) -> (tests: { It }) -> Test,
}
