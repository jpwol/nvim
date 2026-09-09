require('markdown_preview').setup({
  instance_mode = "takeover",
  port = 0,
  open_browser = true,
  debounce_ms = 300,
})

require('render-markdown').setup({
  latex = {
    enabled = true,
  },
})
