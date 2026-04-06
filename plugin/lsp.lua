local signs = {
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN] = " ",
  [vim.diagnostic.severity.HINT] = "󰠠 ",
  [vim.diagnostic.severity.INFO] = " ",
}
vim.diagnostic.config({
  signs = {
    text = signs,
  },
  underline = true,
  virtual_lines = {
    current_line = true,
  },
})

require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require('mason-lspconfig').setup({
  automatic_enable = true,
  ensure_installed = {
    "html",
    "cssls",
    "jsonls",
    "lua_ls",
    "eslint",
    "basedpyright",
    "clangd",
    "zls",
    "bashls",
    "cmake",
    "texlab",
    "gopls",
    "jdtls",
    "marksman",
    "taplo",
    "glsl_analyzer",
    "rust_analyzer",
    "sqls",
    "vue_ls",
    "vtsls",
  },
})

require("mason-tool-installer").setup({
  ensure_installed = {
    "prettier", -- prettier formatter
    "jsonlint",
    "stylua", -- lua formatter
    "black",    -- python formatter
    "pylint",   -- python linter
    "debugpy",  -- python debugger
    "luacheck", -- lua linter
    -- "cpplint", -- c, c++ linter
    "codelldb", -- c, c++, rust, zig debugger
    "cmakelang",
    "cmakelint",
    "trivy",
    "shellcheck",
  },
})

require("lazydev").setup()


vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    -- set keybinds
    opts.desc = "See available code actions"
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show line diagnostics"
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Show documentation for what is under cursor"
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Restart LSP"
    vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
  end,
})

local lint = require("lint")

lint.linters_by_ft = {
  json = { "jsonlint" },
  jsonc = { "jsonlint" },
  python = { "pylint" },
  cs = { "trivy" },
  lua = { "luacheck" },
  cmake = { "cmakelint" },
  bash = { "shellcheck" },
}

local luacheck = lint.linters.luacheck
local pylint = lint.linters.pylint


luacheck.args = {
  "global = false",
}

pylint.args = {
  "-f",
  "json",
  "--from-stdin",
  function()
    return vim.api.nvim_buf_get_name(0)
  end,
  "--disable=C0114,C0116,W0611,E0401",
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})
