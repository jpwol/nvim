-- vim.cmd[[set completeopt+=menuone,noselect,popup]]
-- local on_attach = function(client, bufnr)
--   vim.lsp.completion.enable(true, client.id, bufnr, {
--     autotrigger = true
--   })
-- end

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "Lua 5.4",
        path = {
          "?.lua",
          "?/init.lua",
          "?/?.lua",
          "/usr/share/lua/5.4/?.lua",
          "/usr/share/lua/5.4/?/init.lua",
          vim.fn.expand("~/.luarocks/lib/lua/5.4/"),
        },
      },
      workspace = {
        library = {
          "?.lua",
          "/home/josh/.luarocks/share/lua/5.4",
          "/home/josh/.luarocks/lib/lua/5.4",
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.api.nvim_get_runtime_file("", true),
        },
        checkThirdParty = false,
      },
      diagnostics = {
        -- globals = { "vim" },
      },
    },
  },
})
vim.lsp.config("clangd", {
  cmd = { "clangd", "--fallback-style=Google" },
  filetypes = { "c", "cpp" },
  settings = {
    clangd = {
      fallbackFlags = {},
    },
  },
})
vim.lsp.config("zls", {
  cmd = { "zls" },
  filetypes = { "zig", "zir" },
  root_markers = { "build.zig" },
})
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "mod" },
})
vim.lsp.config("jsonls", {
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      validate = { enable = true },
      format = { enable = true },
      schemas = {},
      allowComments = true,
      trailingCommas = "ignore",
    },
  },
})
vim.lsp.config("jdtls", {
  filetypes = { "java" },
  cmd = { "jdtls" },
  settings = {
    java = {
      project = {
        referencedLibraries = {
          "/home/josh/.local/lib/javafx-sdk-21.0.6/lib/*.jar",
        },
      },
    },
  },
})
vim.lsp.config("marksman", {
  filetypes = { "markdown" },
  cmd = { "marksman" },
})
vim.lsp.config("taplo", {
  filetypes = { "toml" },
})
vim.lsp.config("bashls", {
  filetypes = { "bash", "zsh", "sh" },
  cmd = { "bash-language-server", "start" },
  settings = {
    bashIde = {
      logLevel = "error",
      enableSourceErrorDiagnostics = false,
    },
  },
})
vim.lsp.config("glsl_analyzer", {
  filetypes = { "glsl", "vs", "fs" },
})
vim.lsp.config("rust_analyzer", {
  settings = {
    rust_analyzer = {
      cargo = {
        allFeatures = true,
      },
    },
  },
})
vim.lsp.config("omnisharp_mono", {
  cmd = { "omnisharp-mono", "--languageserver" },
  root_dir = vim.fs.dirname(vim.fs.find({ "*.sln", "*.csproj", ".git" }, { upward = true })[1]),
})

local vue_ls_path = "/usr/lib/node_modules/@vue/language-server"
local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_ls_path,
  languages = { "vue" },
  configNamespace = "typescript",
}
local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },
}
local vue_ls_config = {}
vim.lsp.config("vtsls", vtsls_config)
vim.lsp.config("vue_ls", vue_ls_config)
vim.lsp.enable({ "vtsls", "vue_ls" })

vim.lsp.config("sqls", {
  filetypes = { "sql" },
  cmd = { "sqls" },
})

vim.lsp.config("basedpyright", {
  filetypes = { "python" },
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = "openFilesOnly",
        diagnosticSeverityOverrides = {
          reportUnusedImport = false,
          reportMissingTypeStubs = false,
          reportUnknownArgumentType = false,
          reportUnknownMemberType = false,
          reportUnknownVariableType = false,
          reportUnusedCallResult = false,
        },
        inlayHints = {
          callArgumentNames = true,
        },
      },
    },
  },
})
