-- Enable Neovim's built-in Lua module loader for faster Lua module loading
vim.loader.enable()

-- Set the global and local leader key to <space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable line numbers
vim.opt.number = true

-- Enable mouse support in all modes
vim.opt.mouse = "a"

-- Highlight the current line
vim.opt.cursorline = true

-- Keep a minimum number of screen lines above and below the cursor
vim.opt.scrolloff = 10

-- Always display the sign column
vim.opt.signcolumn = "yes"

-- Display whitespace characters according to listchars
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "▫", nbsp = "␣" }

-- Preserve indentation for wrapped lines
vim.opt.breakindent = true

-- Enable persistent undo
vim.opt.undofile = true

-- Prompt for confirmation before discarding unsaved changes
vim.opt.confirm = true

-- Ignore case when searching, unless the pattern contains uppercase letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set the update time interval in milliseconds
vim.opt.updatetime = 250
-- Set the key sequence timeout in milliseconds
vim.opt.timeoutlen = 300

-- Open vertical splits to the right
vim.opt.splitright = true
-- Open horizontal splits below
vim.opt.splitbelow = true




