-- Holy shit Zed why the fuck do you need all this

return {
  lsp = {
    ["luau-lsp"] = {
      settings = {
        ext = {
          prefer_worktree_binary = true,
          fflags = {
            enable_by_default = false,
            sync = true,
          },
          roblox = {
            enabled = true,
          },
          definitions = {
            "testez.d.luau",
          },
        },
        ["luau-lsp"] = {
          require = {
            mode = "relativeToFile",
            directoryAliases = {},
          },
        },
      },
    },
  },
  languages = {
    Luau = {
      formatter = {
        external = {
          command = "stylua",
          arguments = { "-" },
        },
      },
    },
  },
}
