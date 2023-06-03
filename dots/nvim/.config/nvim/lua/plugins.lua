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
		-- https://github.com/rebelot/kanagawa.nvim/issues/79
		-- requires nvim >= 0.8 after this commit
		-- commit = "fc2e308",
		commit = "476eb22",
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
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("config.indent_blankline")
		end,
	},
	{
		"echasnovski/mini.map",
		event = "BufEnter",
		config = function()
			require("config.mini-map")
		end,
	},

	-- lsp support
	{
		"neovim/nvim-lspconfig",
		version = "v0.1.4",
		event = "BufEnter",
		dependencies = {
			"lspcontainers/lspcontainers.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},
	{
		"utilyre/barbecue.nvim",
		-- version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("config.barbeque")
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("config.lsp-signature")
		end,
	},

	-- completion support
	{
		"hrsh7th/nvim-cmp",
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
		version = "0.1.1",
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
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
		keys = {
			"<space>",
		},
	},

	-- editing
	{ "machakann/vim-sandwich", event = "BufEnter" },
	{ "jiangmiao/auto-pairs" },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("config.comment")
		end,
		event = "BufEnter",
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
	},
	{
		"Julian/vim-textobj-variable-segment",
		dependencies = "kana/vim-textobj-user",
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

	--{
	--	"stevearc/oil.nvim",
	--	config = function()
	--		require("oil").setup({
	--			columns = {
	--				"icon",
	--				"permissions",
	--				"size",
	--			},
	--		})
	--	end,
	--	cmd = "Oil",
	--},
})
