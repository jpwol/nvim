local terminal_buf = nil

-- local function set_term()
-- 	local os_name = vim.uv.os_uname().sysname
-- 	if os_name == "Windows_NT" then
-- 		vim.opt.shell = "pwsh"
-- 		vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
-- 		vim.opt.shellquote = ""
-- 		vim.opt.shellxquote = ""
-- 		vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
-- 		vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; cat %s"
-- 		vim.opt.shellslash = true
-- 		vim.opt.shellxescape = ""
-- 	elseif os_name == "Linux" then
-- 		vim.opt.shell = "/usr/bin/zsh"
-- 	end
-- end
--
-- set_term()

-- vim.api.nvim_create_user_command("ToggleTerminal", function(opts)
-- 	if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
-- 		local win_ids = vim.fn.win_findbuf(terminal_buf)
-- 		if #win_ids > 0 then
-- 			vim.api.nvim_win_close(win_ids[1], true)
-- 		else
-- 			vim.api.nvim_command(opts.dir)
-- 			vim.api.nvim_win_set_buf(0, terminal_buf)
-- 			vim.api.nvim_win_set_height(0, opts.height)
-- 		end
-- 	else
-- 		vim.api.nvim_command(opts.dir)
-- 		terminal_buf = vim.api.nvim_create_buf(false, true)
-- 		vim.api.nvim_win_set_buf(0, terminal_buf)
-- 		vim.fn.jobstart(vim.o.shell, { term = true })
-- 		vim.api.nvim_win_set_height(0, opts.height)
-- 	end
-- end, {})

---@param opts { dir: string, height: integer, width: integer }
local function toggle_term(opts)
	if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
		local win_ids = vim.fn.win_findbuf(terminal_buf)
		if #win_ids > 0 then
			vim.api.nvim_win_close(win_ids[1], true)
		else
			vim.api.nvim_command(opts.dir)
			vim.api.nvim_win_set_buf(0, terminal_buf)
			vim.api.nvim_win_set_height(0, opts.height)
      vim.api.nvim_win_set_width(0, opts.width)
		end
	else
		vim.api.nvim_command(opts.dir)
		terminal_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_win_set_buf(0, terminal_buf)
		vim.fn.jobstart(vim.o.shell, { term = true })
		vim.api.nvim_win_set_height(0, opts.height)
		vim.api.nvim_win_set_width(0, opts.width)
	end
end

vim.keymap.set("n", "<leader>st", function()
  local ui = vim.api.nvim_list_uis()[1]
  local count = 10
  if vim.v.count > 0 then count = vim.v.count end
  toggle_term({ dir = "botright split", height = count, width = ui.width })
end, { desc = "open terminal at bottom of screen" })

vim.keymap.set("n", "<leader>sv", function()
  local ui = vim.api.nvim_list_uis()[1]
  local count = math.floor(ui.width * 0.3)
  if vim.v.count > 0 then count = vim.v.count end
  toggle_term({ dir = "botright vsplit", height = ui.height, width = count})
end, { desc = "open terminal on right side of screen" })
