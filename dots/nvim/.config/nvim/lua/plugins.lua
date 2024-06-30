local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("config.colors")
		end,
	},
	"nvim-lua/plenary.nvim",

	-- look
	{ "romgrk/barbar.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
	{
		"hoob3rt/lualine.nvim",
		event = "VimEnter",
		config = function()
			require("config.lualine")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
		build = ":TSUpdate",
		event = "BufReadPre",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"RRethy/nvim-treesitter-textsubjects",
		},
	},
	{
		-- provides single text object (on iv and av) for variable segment
		"Julian/vim-textobj-variable-segment",
		lazy = true,
		event = "InsertEnter",
		dependencies = "kana/vim-textobj-user",
	},
	{
		"pearofducks/ansible-vim",
		lazy = true,
		ft = { "yml", "yaml", "ansible.yaml", "ansible.yml" },
	},

	-- lsp support
	{
		"neovim/nvim-lspconfig",
		version = "v0.1.8",
		lazy = true,
		event = "BufEnter",
		dependencies = {
			"lspcontainers/lspcontainers.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},
	{
		"kosayoda/nvim-lightbulb",
		config = function()
			require("config.nvim-lightbulb")
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		lazy = true,
		event = "InsertEnter",
		config = function()
			require("config.lsp-signature")
		end,
	},

	-- completion support
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			require("config.cmp")
		end,
	},

	-- snippet engine
	{
		"hrsh7th/vim-vsnip",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-vsnip",
			"rafamadriz/friendly-snippets",
		},
	},

	-- navigation
	{ "christoomey/vim-tmux-navigator", lazy = false },
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.8",
		lazy = true,
		keys = { "<leader>" },
		config = function()
			require("config.telescope")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		lazy = true,
		keys = { "<leader>" },
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		lazy = true,
		keys = { "<leader>" },
	},
	-- {
	-- 	"folke/which-key.nvim",
	-- 	config = function()
	-- 		require("which-key").setup({})
	-- 	end,
	-- 	keys = {
	-- 		"<space>",
	-- 	},
	-- },

	-- editing
	{ "machakann/vim-sandwich", event = "BufEnter" },
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = "InsertEnter",
		config = function()
			require("config.autopairs")
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("config.comment")
		end,
		event = "BufEnter",
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
	},

	-- git
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		cmd = "Gitsigns",
		config = function()
			require("config.gitsigns")
		end,
	},
	--{
	--	"sindrets/diffview.nvim",
	--	cmd = { "DiffviewFileHistory" },
	--	module = "diffview.lib",
	--},

	-- tools
	-- markdown previewer
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		event = "BufEnter *.md",
		ft = "markdown",
		config = function()
			require("config.markdown_preview")
		end,
	},
	-- obsidian
	{
		"epwalsh/obsidian.nvim",
		config = function()
			require("config.obsidian-nvim")
		end,
		cmd = { "ObsidianSearch", "ObsidianFollowLink" },
	},

	--{
	--	"hkupty/iron.nvim",
	--	version = "v3.0",
	--	cmd = "IronRepl",
	--},
	{
		"stevearc/oil.nvim",
		config = function()
			require("config.oil")
		end,
	},
})
