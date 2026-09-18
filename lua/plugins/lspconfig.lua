vim.pack.add({
  -- Extensible UI for LSP progress messages
  "https://github.com/j-hui/fidget.nvim",
  -- Install and manage LSP servers, DAP servers, linters and formatters
  "https://github.com/mason-org/mason.nvim",
  -- Bridge mason.nvim with nvim-lspconfig
  "https://github.com/mason-org/mason-lspconfig.nvim",
  -- Automatically install third-party tools
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  -- A collection of LSP server configurations
  "https://github.com/neovim/nvim-lspconfig",
})

require("fidget").setup()
require("mason").setup()

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("zlb-lsp-attach", { clear = true }),
  callback = function(event)
    -- LSP-specific keymaps
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename" })
    vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Code Action" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "Goto Declaration" })

    -- Highlight references under the cursor
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/documentHighlight", event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup("zlb-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end
    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("zlb-lsp-detach", { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "zlb-lsp-highlight", buffer = event2.buf })
      end,
    })

    -- Toggle virtual type hints shown by the LSP
    if client and client:supports_method("textDocument/inlayHint", event.buf) then
      vim.keymap.set(
        "n",
        "<leader>uh",
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end,
        { buffer = event.buf, desc = "Toggle Inlay Hints" }
      )
    end
  end,
})

-- Keep only LSP servers here, using nvim-lspconfig server names
local servers = {
  clangd = {},
  pyright = {},
  html = {},
  cssls = {},
  ts_ls = {},
  -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
  lua_ls = {
    on_init = function(client)
      -- Disable formatting (formatting is done by stylua)
      client.server_capabilities.documentFormattingProvider = false
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath("config") and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then return end
      end
      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          version = "LuaJIT",
          path = {
            "lua/?.lua",
            "lua/?/init.lua",
          },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
          },
        },
      })
    end,
    settings = {
      Lua = {
        format = { enable = false }, -- Disable formatting (formatting is done by stylua)
      },
    },
  },
}

-- Keep non-LSP tools here, using their Mason package names
local tools = {
  "clang-format",
  "ruff",
  "prettier",
  "stylelint",
  "eslint_d",
  "stylua",
  "luacheck",
}

require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_keys(servers),
  automatic_enable = false, -- Disable automatic LSP enabling; enable servers explicitly below
})

require("mason-tool-installer").setup({
  ensure_installed = tools,
})

-- Enable LSP servers
for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
