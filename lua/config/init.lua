require("config.keymaps")
require("config.options")
require("config.terminal")
require("config.plugins")


require('vim._core.ui2').enable({msg={target='cmd'}})

vim.pack.add({
  -- THEMES
  { src = "https://github.com/jpwol/thorn.nvim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/shaunsingh/nord.nvim" },
  { src = "https://github.com/everviolet/nvim.git", name = 'everviolet' },
  { src = "https://github.com/neanias/everforest-nvim.git" },
  -- TREESITTER
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  -- LSP
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/mfussenegger/nvim-lint" },
  -- FORMATTING
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/folke/lazydev.nvim" },
  -- AUTOCOMPLETE
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range('1.x') },
  -- UI
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/malewicz1337/oil-git.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  -- QOL
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = 'https://github.com/abecodes/tabout.nvim' },
  { src = "https://github.com/szw/vim-maximizer" },
  -- MARKDOWN
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/selimacerbas/markdown-preview.nvim" },
  { src = "https://github.com/selimacerbas/live-server.nvim" },
  -- GIT
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
})

-- vim.cmd[[colorscheme thorn]]
