vim.pack.add({
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
})

require("telescope").setup({})

local builtin = require("telescope.builtin")
-- File Pickers
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Find Word" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Live Grep" })

-- Vim Pickers
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Old Files" })
vim.keymap.set("n", "<leader>sc", builtin.command_history, { desc = "Command History" })
vim.keymap.set("n", "<leader>s/", builtin.search_history, { desc = "Search History" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>sM", builtin.man_pages, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "Marks" })
vim.keymap.set("n", "<leader>sb", builtin.current_buffer_fuzzy_find, { desc = "Current Buffer Fuzzy" })

-- Neovim LSP Pickers
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
  callback = function(event)
    local buf = event.buf
    vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = buf, desc = "Goto Reference" })
    vim.keymap.set("n", "gI", builtin.lsp_implementations, { buffer = buf, desc = "Goto Implementation" })
    vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = buf, desc = "Goto Definition" })
    vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { buffer = buf, desc = "Goto Symbol" })
    vim.keymap.set("n", "<leader>sS", builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = "Goto Workspace Symbol" })
    vim.keymap.set("n", "gy", builtin.lsp_type_definitions, { buffer = buf, desc = "Goto Type Definition" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { buffer = buf, desc = "Diagnostics" })
  end,
})
