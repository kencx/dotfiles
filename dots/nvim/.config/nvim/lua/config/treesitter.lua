local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

configs.setup({
	indent = { enable = false },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "markdown" },
		disable = function()
			-- disable for ansible yml files
			if vim.bo.filetype == "yaml.ansible" then
				return true
			end
		end,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-Space>",
			node_incremental = "<C-Space>",
			scope_incremental = false,
			node_decremental = "<S-Tab>",
		},
	},
	-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<Leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<Leader>A"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
	-- https://github.com/RRethy/nvim-treesitter-textsubjects/
	textsubjects = {
		enable = true,
		prev_selection = ",",
		keymaps = {
			["."] = "textsubjects-smart",
			[";"] = "textsubjects-container-outer",
			["i;"] = "textsubjects-container-inner",
		},
	},
	ensure_installed = {
		"bash",
		"comment",
		"css",
		"dockerfile",
		"go",
		"gomod",
		"haskell",
		"hcl",
		"html",
		"http",
		"java",
		"javascript",
		"json",
		"markdown",
		"markdown_inline",
		"lua",
		"python",
		"rust",
		"svelte",
		"scss",
		"toml",
		"typescript",
		"vim",
		"yaml",
	},
	ignore_install = {
		"beancount",
		"clojure",
		"commonlisp",
		"cuda",
		"erlang",
		"fennel",
		"fish",
		"glimmer",
		"glsl",
		"heex",
		"julia",
		"latex",
		"ledger",
		"llvm",
		"ocaml",
		"pioasm",
		"ql",
		"rst",
		"sparql",
		"supercollider",
		"surface",
		"tlaplus",
		"turtle",
		"yang",
		"zig",
	},
})
