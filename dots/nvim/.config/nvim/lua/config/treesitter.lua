local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

configs.setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "markdown" },
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
	indent = { enable = false },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
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
