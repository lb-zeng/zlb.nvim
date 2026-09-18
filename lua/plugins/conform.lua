vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

require("conform").setup({
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    python = { "ruff" },
    lua = { "stylua" },
    html = { "prettier" },
    css = { "prettier" },
    javascript = { "prettier" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
})

vim.keymap.set({ "n", "x" }, "<leader>cf", function() require("conform").format({ async = true }) end, { desc = "Format" })
