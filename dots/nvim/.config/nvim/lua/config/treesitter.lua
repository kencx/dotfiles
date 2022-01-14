-- https://github.com/nvim-treesitter/nvim-treesitter

require("nvim-treesitter.configs").setup({

	highlight = {
		enable = true,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},

	indent = {
		enable = false,
	},

	ensure_installed = {
		"bash",
		"comment",
		"css",
		"dockerfile",
		"go",
		"gomod",
		"hcl",
		"html",
		"java",
		"javascript",
		"json",
		"latex",
		"lua",
		"python",
		"rust",
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
		"ledger",
		"llvm",
		"ocaml",
		"pioasm",
		"ql",
		"rst",
		"sparql",
		"supercollider",
		"surface",
		"svelte",
		"tlaplus",
		"turtle",
		"yang",
		"zig",
	},
})
