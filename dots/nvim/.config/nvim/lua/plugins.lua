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
	-- caches lua modules
	--{
	--	"lewis6991/impatient.nvim",
	--	config = function()
	--		require("impatient").enable_profile()
	--	end,
	--},

	"nvim-lua/plenary.nvim",

	{
		"nvim-treesitter/nvim-treesitter",
		-- pin = true,
		config = function()
			require("config.treesitter")
		end,
		build = ":TSUpdate",
		event = "BufRead",
	},

	-- lsp support
	{
		"neovim/nvim-lspconfig",
		-- pin = true,
		config = function()
			require("config.lsp")
		end,
		dependencies = {
			"lspcontainers/lspcontainers.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
		},
	},

	-- formatting, linting sources
	{
		"jose-elias-alvarez/null-ls.nvim",
		-- pin = true,
		config = function()
			-- local on_attach = require("config.lsp").on_attach
			-- require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
			require("config.null-ls")
		end,
	},

	-- completion support
	{
		"hrsh7th/nvim-cmp",
		-- pin = true,
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
		dependencies = {
			"hrsh7th/cmp-vsnip",
			"rafamadriz/friendly-snippets",
		},
	},

	---- "ray-x/lsp_signature.nvim",

	-- buffer line
	"romgrk/barbar.nvim",

	-- status line
	{
		"hoob3rt/lualine.nvim",
		-- pin = true,
		config = function()
			require("config.lualine")
		end,
	},

	-- indentation lines
	{
		"lukas-reineke/indent-blankline.nvim",
		-- pin = true,
		config = function()
			require("config.indent_blankline")
		end,
		event = "BufRead",
	},

	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup({
				manual = false,
			})
		end,
		event = "BufEnter",
	},

    -- git
	{
		"lewis6991/gitsigns.nvim",
		-- pin = true,
		config = function()
			require("gitsigns").setup()
		end,
		event = "BufRead",
		cmd = "Gitsigns",
	},

	--{
	--	"sindrets/diffview.nvim",
	--	cmd = { "DiffviewFileHistory" },
	--	module = "diffview.lib",
	--},

	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.0",
		module = "telescope",
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
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		cmd = "Telescope",
	},

	-- comment engine
	{
		"numToStr/Comment.nvim",
		-- pin = true,
		config = function()
			require("Comment").setup()
		end,
		event = "BufRead",
	},

	{
		"folke/which-key.nvim",
		-- pin = true,
		config = function()
			require("which-key").setup({})
		end,
		keys = {
		  "<space>"
		},
	},

	{
		"echasnovski/mini.map",
		config = function()
			require("config.mini-map")
		end,
		-- module_pattern = { "mini.map*", "MiniMap*" },
	},

	"machakann/vim-sandwich",
	"jiangmiao/auto-pairs",
	{
		"Julian/vim-textobj-variable-segment",
		dependencies = { "kana/vim-textobj-user" },
	},

	---- tmux navigation support
	"christoomey/vim-tmux-navigator",

	-- markdown previewer
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			fn["mkdp#util#install"]()
		end,
		config = function()
			require("config.markdown_preview")
		end,
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = "markdown",
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

	{
		"rebelot/kanagawa.nvim",
		-- https://github.com/rebelot/kanagawa.nvim/issues/79
		-- requires nvim >= 0.8 after this commit
		-- commit = "fc2e308",
		config = function()
			require("config.colors")
		end,
	},
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
