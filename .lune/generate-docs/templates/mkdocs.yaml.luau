-- selene: allow(mixed_table)
return {
  site_name = "pretty-fusion-hooks",
  site_url = "https://znotfireman.github.com/pretty-fusion-hooks",
  repo_name = "znotfireman/pretty-fusion-hooks",
  repo_url = "https://github.com/znotfireman/pretty-fusion-hooks",

  extra = {
    version = {
      provider = "mike",
    },
  },

  theme = {
    name = "material",
    custom_dir = "docs/assets/overrides",
    logo = "assets/logo",
    favicon = "assets/logo-dark.svg",
    palette = {
      {
        media = "(prefers-color-scheme: dark)",
        scheme = "fusiondoc-dark",
        toggle = {
          icon = "octicons/sun-24",
          title = "Switch to light theme",
        },
      },
      {
        media = "(prefers-color-scheme: light)",
        scheme = "fusiondoc-dark",
        toggle = {
          icon = "octicons/moon-24",
          title = "Switch to dark theme",
        },
      },
    },
    font = {
      text = "Plus Jakarta Sans",
      code = "JetBrains Mono",
    },
    features = {
      "navigation.top",
      "navigation.sections",
      "navigation.instant",
      "navigation.indexes",
      "search.suggest",
      "search.highlight",
    },
    icon = {
      repo = "octicons/mark-github-16",
    },
  },

  extra_css = {
    "assets/theme/fusiondoc.css",
    "assets/theme/colours.css",
    "assets/theme/code.css",
    "assets/theme/paragraph.css",
    "assets/theme/page.css",
    "assets/theme/admonition.css",
    "assets/theme/404.css",
    "assets/theme/api-reference.css",
    "assets/theme/dev-tools.css",
  },

  extra_javascript = {
    "assets/scripts/smooth-scroll.js",
  },

  nav = {} :: { [any]: any },

  markdown_extensions = {
    "admonition",
    "attr_list",
    "meta",
    "md_in_html",
    "pymdownx.superfences",
    "pymdownx.betterem",
    ["pymdownx.tabbed"] = {
      alternative_style = true,
    },
    "pymdownx.inlinehilite",
    toc = {
      permalink = true,
    },
    ["pymdownx.highlight"] = {
      guess_lang = false,
    },
    ["pymdownx.emoji"] = {
      emoji_index = "!!python/name:materialx.emoji.twemoji",
      emoji_generator = "!!python/name:materialx.emoji.to_svg",
    },
  },
}
