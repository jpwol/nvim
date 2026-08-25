vim.api.nvim_create_autocmd('FileType', {
  callback = function ()
    pcall(vim.treesitter.start)
  end
})

require('treesitter-context').setup({
  enable = true,
  multiwindow = true,
  max_lines = 2,
  min_window_height = 0,
  line_numbers = true,
})
