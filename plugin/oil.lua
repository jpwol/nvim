require("oil").setup({
  default_file_explorer = true,
  columns = { "icon" },
  keymaps = {
    ["<M-h>"] = "actions.select_split",
    ["<M-v>"] = "actions.select_vsplit",
  },
  buf_options = {
    buflisted = false,
    bufhidden = 'hide',
  },

  lsp_file_methods = {
    enabled = true,
  },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Open parent directory" })

require('oil-git').setup({
  show_ignored_files = true,
  show_ignored_directories = true,
})
