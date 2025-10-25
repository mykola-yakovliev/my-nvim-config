local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("propr", fmt("public required {} {} {{ get; set; }}", { i(1, "int"), i(2, "MyProperty") })),
}
