--!nonstrict
return {
  generator = "retain_lines",
  rules = {
    {
      current = {
        name = "path",
        sources = {},
      },
      rule = "convert_require",
      target = {
        indexing_style = "property",
        name = "roblox",
        rojo_sourcemap = "./sourcemap.json",
      },
    },
    {
      identifier = "__DEV__",
      rule = "inject_global_value",
      value = false,
    },
    "compute_expression",
    "remove_unused_if_branch",
    "remove_unused_while",
    "filter_after_early_return",
    "remove_nil_declaration",
    "remove_empty_do",
    "remove_spaces",
  },
}
