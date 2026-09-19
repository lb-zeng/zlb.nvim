vim.pack.add({
  "https://github.com/mfussenegger/nvim-lint",
})

local lint = require("lint")
lint.linter_by_ft = {
  -- clangd can run clang-tidy diagnostics, so nvim-lint does not run it separately.
  -- c = { "clang-tidy" },
  -- cpp = { "clang-tidy" },
  python = { "ruff" },
  lua = { "luacheck" },
  javascript = { "eslint_d" },
  css = { "stylelint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("zlb-lint", { clear = true }),
  callback = function()
    if vim.bo.modifiable then lint.try_lint() end
  end,
})

-- Configure diagnostic display for LSP and linters
vim.diagnostic.config({
  float = { border = "rounded", source = "if_many" },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = "cursor",
        focus = false,
      })
    end,
  },
})

vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
