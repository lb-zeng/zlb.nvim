vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/rafamadriz/friendly-snippets",
})

require("blink.cmp").setup({
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "rounded" } },
  },
  cmdline = {
    completion = { menu = { auto_show = true } },
  },
})
