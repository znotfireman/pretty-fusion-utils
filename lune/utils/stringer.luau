local stringer = {}
setmetatable(stringer, {
  __index = string,
})

function stringer.cleanNewlines(str: string): string
  return (str:gsub("\n", " "))
end

return stringer
