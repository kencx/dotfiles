local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
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

	"christoomey/vim-tmux-navigator",
	"nvim-lua/plenary.nvim",
	-- "ray-x/lsp_signature.nvim",
	"romgrk/barbar.nvim",

	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
		build = ":TSUpdate",
		event = "BufRead",
	},

	-- lsp support
	{
		"neovim/nvim-lspconfig",
		version = "v0.1.4",
		event = "BufEnter",
		config = function()
			require("config.lsp")
		end,
		dependencies = {
			"lspcontainers/lspcontainers.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			-- "hrsh7th/nvim-cmp",
		},
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

	-- status line
	{
		"hoob3rt/lualine.nvim",
		config = function()
			require("config.lualine")
		end,
	},

	-- indentation lines
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("config.indent_blankline")
		end,
	},

	{
		"notjedi/nvim-rooter.lua",
		event = "BufEnter",
		opts = function()
			manual = false
		end,
	},

	-- git
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		cmd = "Gitsigns",
		config = function()
			require("gitsigns").setup()
		end,
	},

	--{
	--	"sindrets/diffview.nvim",
	--	cmd = { "DiffviewFileHistory" },
	--	module = "diffview.lib",
	--},

	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.1",
		cmd = "Telescope",
		config = function()
			require("config.telescope")
		end,
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"kyazdani42/nvim-web-devicons",
		},
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cmd = "Telescope" },
	{ "nvim-telescope/telescope-file-browser.nvim", cmd = "Telescope" },

	-- comment engine
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
		event = "BufEnter",
	},

	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
		keys = {
			"<space>",
		},
	},

	{
		"echasnovski/mini.map",
		event = "BufEnter",
		config = function()
			require("config.mini-map")
		end,
		-- module_pattern = { "mini.map*", "MiniMap*" },
	},

	{ "machakann/vim-sandwich", event = "BufEnter" },
	{ "jiangmiao/auto-pairs", event = "InsertEnter" },
	{
		"Julian/vim-textobj-variable-segment",
		dependencies = { "kana/vim-textobj-user" },
	},

	-- markdown previewer
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			fn["mkdp#util#install"]()
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

	---- obsidian
	--{
	--	"epwalsh/obsidian.nvim",
	--	config = function()
	--		require("config.obsidian-nvim")
	--	end,
	--	cmd = { "ObsidianSearch", "ObsidianFollowLink" },
	--},

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
	--{
	--	"norcalli/nvim-colorizer.lua",
	--	-- pin = true,
	--	config = function()
	--		require("colorizer").setup({ "*" }, {
	--			RGB = true,
	--			RRGGBB = true,
	--			names = false,
	--			mode = "background",
	--		})
	--	end,
	--},
	-- {
	-- 	"mrshmllow/document-color.nvim",
	-- 	-- pin = true,
	-- 	config = function()
	-- 		require("document-color").setup({
	-- 			mode = "background",
	-- 		})
	-- 	end,
	-- },
})
