export type Config = {
  config: {
    name: string,
    brief: string,
    example: string?,

    variadics: { string }?,
    args: {
      {
        name: string,
        type: string,
        description: string,
      }
    }?,
    returns: {
      type: string,
      description: string,
    }?,
  },
}

local config = {}

function config.intoConfig(toml: any): Config
  assert(typeof(toml) == "table", "Cannot parse config.toml")
  assert(typeof(toml.config) == "table", "Expected [config] table")
  assert(typeof(toml.config.name) == "string", "Expected config.name field")
  toml.config.brief = toml.config.brief or "TBA"
  return toml
end

return config
