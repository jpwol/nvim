local state = {
  plugins = nil,
  expanded = {},
  cursor_map = {},
  buf = nil,
  win = nil,
}

local ns = vim.api.nvim_create_namespace("list_plugins")

local function render()
  if not state.buf then return end

  local lines = {}
  state.cursor_map = {}

  for i, plugin in ipairs(state.plugins) do
    local active_status = plugin.active and "✔  " or "✖  "
    table.insert(lines, active_status .. plugin.spec.name)
    state.cursor_map[#lines] = i

    if state.expanded[i] then
      table.insert(lines, "     active: " .. tostring(plugin.active))
      table.insert(lines, "     source: " .. tostring(plugin.spec.src))
    end
  end

  vim.bo[state.buf].modifiable = true
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.bo[state.buf].modifiable = false

  vim.api.nvim_buf_clear_namespace(state.buf, ns, 0, -1)

  for i, line in ipairs(lines) do
    local row = i - 1
    if line:match("^✔") then
      vim.hl.range(state.buf, ns, "DiagnosticOk", {row, 0}, {row, 1})
      vim.hl.range(state.buf, ns, "Variable", {row, 2}, {row, -1})
    elseif line:match("^✖") then
      vim.hl.range(state.buf, ns, "DiagnosticError", {row, 0}, {row, 1})
    elseif line:find("active") then
      local col = line:find(":") + 1
      local hl = line:match("true") and "DiagnosticOk" or "DiagnosticError"
      vim.hl.range(state.buf, ns, "Conceal", { row, 0 }, { row, col - 1 })
      vim.hl.range(state.buf, ns, hl, { row, col }, { row, -1 })
      -- vim.hl.range(state.buf, ns, "@punctuation.delimiter", { row, col - 2 }, { row, col - 1 })
    elseif line:find("source") then
      local col = line:find(":") + 1
      vim.hl.range(state.buf, ns, "Conceal", { row, 0 }, { row, col - 1 })
      vim.hl.range(state.buf, ns, "String", { row, col }, { row, -1 })
      -- vim.hl.range(state.buf, ns, "@punctuation.delimiter", { row, col - 2 }, { row, col - 1 })
    end
  end
end

local function toggle()
  local line_nr = vim.api.nvim_win_get_cursor(state.win)[1]
  local plugin_idx = state.cursor_map[line_nr]

  if not plugin_idx then return end

  state.expanded[plugin_idx] = not state.expanded[plugin_idx]

  render()
end

---@param all boolean
local function update(all)
  local line_nr = vim.api.nvim_win_get_cursor(state.win)[1]
  local plugin_idx = state.cursor_map[line_nr]

  if not plugin_idx then return end

  local plugin_name = state.plugins[plugin_idx].spec.name
  vim.notify'updating'

  if all then
    vim.pack.update(nil, { force = false })
  else
    vim.pack.update({plugin_name}, { force = false })
  end
end

local function del()
  local line_nr = vim.api.nvim_win_get_cursor(state.win)[1]
  local plugin_idx = state.cursor_map[line_nr]

  if not plugin_idx then return end

  vim.pack.del({ state.plugins[plugin_idx].spec.name }, { force = true })
  state.plugins = nil
end

local function open_window()
  state.buf = vim.api.nvim_create_buf(false, true)

  local ui = vim.api.nvim_list_uis()[1]
  local width = 60
  local height = math.min(#state.plugins + 4, math.floor(ui.height * 0.8))

  state.win = vim.api.nvim_open_win(state.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((ui.width - width) / 2),
    row = math.floor((ui.height - height) / 2),
    style = "minimal",
    border = "solid",
    title = " Plugins ",
    title_pos = "center",
  })


  local opts = { buffer = state.buf, silent = true, noremap = true }

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(state.win, true)
  end, opts)

  vim.keymap.set("n", "<Esc>", function()
    vim.api.nvim_win_close(state.win, true)
  end, opts)

  vim.keymap.set("n", "<CR>", toggle, opts)

  vim.keymap.set("n", "X", del, opts)

  vim.keymap.set("n", "u", function()
    update(false)
  end, opts)

  vim.keymap.set("n", "U", function()
    update(true)
  end, opts)
end


vim.api.nvim_create_user_command("ListPlugins", function()
  if not state.plugins then
    state.plugins = vim.pack.get(nil, {info = true})
  end
  state.expanded = {}

  open_window()
  render()
end, {})

vim.keymap.set("n", "<leader>pl", "<cmd>ListPlugins<CR>")
