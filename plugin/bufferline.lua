require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    always_show_bufferline = true,
    separator_style = 'slope',
    offsets = {
        separator_style = 'slope',
      {
        filetype = 'snacks_layout_box',
        text = function()
          return vim.fn.getcwd()
        end,
        highlight = 'Conceal'
      }
    }
  },
})
