local telescope = require("telescope")
local actions = require("telescope.actions")

local previewers = require("telescope.previewers")
local Job = require("plenary.job")

telescope.load_extension("fzf")

local new_maker = function(filepath, bufnr, opts)
	filepath = vim.fn.expand(filepath)
	Job
		:new({
			command = "file",
			args = { "--mime-type", "-b", filepath },
			on_exit = function(j)
				local mime_type = vim.split(j:result()[1], "/")[1]
				if mime_type == "text" then
					previewers.buffer_previewer_maker(filepath, bufnr, opts)
				else
					-- maybe we want to write something to the buffer here
					vim.schedule(function()
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
					end)
				end
			end,
		})
		:sync()
end

telescope.setup({
	defaults = {
		initial_mode = "insert",
		file_ignore_patterns = { "%.git/.*" },
		buffer_previewer_maker = new_maker,
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},

		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--trim", -- add this value
		},

		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				mirror = false,
			},
			width = 0.8,
			height = 0.8,
		},
	},

	-- pickers = {
	-- 	find_files = {
	-- 		mappings = {
	-- 			n = {
	-- 				["cd"] = function(prompt_bufnr)
	-- 					local selection = require("telescope.actions.state").get_selected_entry()
	-- 					local dir = vim.fn.fnamemodify(selection.path, ":p:h")
	-- 					actions.close(prompt_bufnr)
	-- 					vim.cmd(string.format("silent cd %s", dir))
	-- 				end,
	-- 			},
	-- 		},
	-- 	},
	-- },

	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
