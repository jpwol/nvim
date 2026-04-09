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
