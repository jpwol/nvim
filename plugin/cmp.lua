require("blink-cmp").setup({
  keymap = { preset = "default" },

  appearance = {
    nerd_font_variant = "mono",
  },

  completion = {
    -- menu = { border = "rounded" },
    documentation = {
      auto_show = false,
      -- window = {
      --   border = 'rounded',
      -- },
    },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  fuzzy = {
    prebuilt_binaries = {
      force_version = "v*",
    },
  },
  -- signature = { enabled = true }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink-cmp").get_lsp_capabilities(capabilities)

vim.lsp.config("*", {
  capabilities = capabilities,
})
