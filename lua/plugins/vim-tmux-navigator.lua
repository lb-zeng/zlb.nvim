vim.pack.add({
  "https://github.com/christoomey/vim-tmux-navigator",
})

local navigation_keys = { ["<c-h>"] = "Left", ["<c-j>"] = "Down", ["<c-k>"] = "Up", ["<c-l>"] = "Right", ["<c-\\>"] = "Previous" }

for key, direction in pairs(navigation_keys) do
vim.keymap.set("n", key, "<cmd><c-u>TmuxNavigate" .. direction .. "<cr>")
end
