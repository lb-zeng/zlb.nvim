vim.pack.add({
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("3") },
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

require("neo-tree").setup({})

vim.keymap.set("n", "<leader>fe", "<cmd>Neotree toggle<cr>", { desc = "Toggle File Explorer" })
vim.keymap.set("n", "<leader>ge", "<cmd>Neotree toggle git_status<cr>", { desc = "Git Explorer" })
vim.keymap.set("n", "<leader>be", "<cmd>Neotree toggle buffers<cr>", { desc = "Buffer Explorer" })
