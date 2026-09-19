vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
})

local parsers = { "c", "cpp", "python", "lua", "html", "css", "javascript" }
require("nvim-treesitter").install(parsers)
