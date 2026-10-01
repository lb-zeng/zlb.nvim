-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<c-up>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<c-down>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<c-left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<c-right>", "<cmd>vertical resize +2<cr>")
