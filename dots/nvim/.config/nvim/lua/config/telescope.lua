local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	return
end

local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local Job = require("plenary.job")

telescope.load_extension("fzf")
telescope.load_extension("file_browser")

-- don't preview binaries
local new_maker = function(filepath, bufnr, opts)
	filepath = vim.fn.expand(filepath)
	Job:new({
		command = "file",
		args = { "--mime-type", "-b", filepath },
		on_exit = function(j)
			local mime_type = vim.split(j:result()[1], "/")[1]
			if mime_type == "text" then
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
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
		file_ignore_patterns = { "%.git/.*", "node_modules" },
		buffer_previewer_maker = new_maker,
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

	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
