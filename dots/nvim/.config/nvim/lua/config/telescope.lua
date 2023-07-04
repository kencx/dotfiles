local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	return
end

local plenary_ok, _ = pcall(require, "plenary")
if not plenary_ok then
	return
end

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local util = require("util")

util.map("n", "<Leader>ft", telescope.extensions.file_browser.file_browser)
util.map("n", "<Leader>ff", function()
	builtin.find_files({ hidden = true })
end)
util.map("n", "<Leader>fw", builtin.grep_string)
util.map("n", "<Leader>fg", builtin.live_grep)
util.map("n", "<Leader>fz", builtin.current_buffer_fuzzy_find)
util.map("n", "<Leader>fb", builtin.buffers)
util.map("n", "<Leader>fc", builtin.commands)
util.map("n", "<Leader>fr", builtin.registers)
util.map("n", "<Leader>fo", builtin.oldfiles)

util.map("n", "<Leader>fd", function()
	builtin.diagnostics({ bufnr = 0 })
end)
util.map("n", "<Leader>fs", builtin.lsp_document_symbols)

util.map("n", "<Leader>gc", builtin.git_commits)
util.map("n", "<Leader>gbc", builtin.git_bcommits)
util.map("n", "<Leader>gst", builtin.git_status)

-- don't preview binaries
local avoid_binaries = function(filepath, bufnr)
	filepath = vim.fn.expand(filepath)
	Job:new({
		command = "file",
		args = { "--mime-type", "-b", filepath },
		on_exit = function(j)
			local mime_type = vim.split(j:result()[1], "/")[1]
			if mime_type == "text" then
				previewers.buffer_previewer_maker(filepath, bufnr)
			else
				vim.schedule(function()
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
				end)
			end
		end,
	}):sync()
end

telescope.setup({
	defaults = {
		initial_mode = "insert",
		file_ignore_patterns = { "%.git/.*", "node_modules", ".venv" },
		buffer_previewer_maker = avoid_binaries,
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
		preview = { treesitter = false },
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			-- trim indentation
			"--trim",
			-- ignore .git/
			"--glob",
			"!**/.git/*",
		},
		layout_strategy = "vertical",
		layout_config = {
			vertical = { mirror = false },
			width = 0.8,
			height = 0.8,
		},
	},

	pickers = {
		grep_string = {
			initial_mode = "normal",
		},
	},

	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		file_browser = {
			hijack_netrw = true,
			hidden = true,
			grouped = true,
			respect_gitignore = false,
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
