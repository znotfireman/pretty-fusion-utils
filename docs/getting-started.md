# Getting Started

`pretty-fusion-utils` is an opinionated collection of modern [Fusion 0.3]
utilities.

This package assumes you are comfortable using Fusion, the Luau scripting
language, and Roblox fundamentals. If you would like to learn, see the
[Fusion documentation] and the [Roblox creator documentation].

---

## Installation

### via Wally

1. Append this to your `wally.toml` configuration:

    ```TOML
    [dependencies]
    fusionUtils = "znotfireman/pretty-fusion-utils@0.1"
    ```

2. Run `wally install` to install `pretty-fusion-utils`
3. Import `pretty-fusion-utils` into your code:

    ```Luau
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local fusionUtils = require(ReplicatedStorage.Packages.fusionUtils)
    ```

### via Pesde

1. Run `pesde add znotfireman/pretty_fusion_utils@0.1` to install `pretty-fusion-utils`
2. Import `pretty-fusion-utils` into your code:

    ```Luau
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local fusionUtils = require(ReplicatedStorage.packages.fusionUtils)
    ```

### via Roblox

1. Visit the `pretty-fusion-utils` [GitHub Releases] to find the target release
2. Click "Assets", then click `pretty-fusion-utils.rbxm` to download it
3. Open Roblox Studio to import the package, preferrably within ReplicatedStorage
4. Rename the package to something that can be required, such as "fusionUtils"
5. Import `pretty-fusion-utils` into your code:

    ```Luau
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local fusionUtils = require(ReplicatedStorage.fusionUtils)
    ```

### via Source

1. Clone the `pretty-fusion-utils` [GitHub repository]
2. Install all tooling using [Rokit] via `rokit install`
3. Run `lune run build`, choose not to release to Wally/Pesde when prompted:

    ```Sh
    $ lune run build
    ✔ Create .rbxm models? · yes
    ✔ Release to Wally/Pesde? · no
    ```

4. Copy the generated `dist/lib` folder or use the generated
    `pretty-fusion-utils.rbxm` model

---

## Usage

`pretty-fusion-utils` can use any Fusion 0.3 package. It does not require a deep
scan of a game to find Fusion 0.3. Just provide it a scope with Fusion:

```Luau
local scope = Fusion:scoped()
useInterval(scope, 0.5, function()
  print("Hello!")
end)
```

For convenience, `pretty-fusion-utils` can be passed into scope constructors:

```Luau
local scope = Fusion:scoped(fusionUtils)
scope:useInterval(0.5, function()
  print("Hello!")
end)
```

Components that use `pretty-fusion-utils` can specify it as type information:

```Luau
local function Button(
  scope: Fusion.Scope<typeof(Fusion) & typeof(fusionUtils)>,
  props: {
    -- ...
  }
)
```

---

## Navigation

Using the sidebar to the left, you can browse all of the utilities by name.

[Fusion 0.3]: https://elttob.uk/Fusion/0.3/
[Fusion documentation]: https://elttob.uk/Fusion/0.3/tutorials/
[Roblox creator documentation]: https://create.roblox.com/docs/
[GitHub Releases]: https://github.com/znotfireman/pretty-fusion-utils/releases
[GitHub repository]: https://github.com/znotfireman/pretty-fusion-utils
[Rokit]: https://github.com/rojo-rbx/rokit
