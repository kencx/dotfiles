local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

return require("packer").startup({
	function(use)
		-- caches lua modules
		use({
			"lewis6991/impatient.nvim",
			config = function()
				require("impatient").enable_profile()
			end,
		})

		use({ "wbthomason/packer.nvim" })
		use({ "nvim-lua/plenary.nvim" })

		-- syntax highlighting
		use({
			"nvim-treesitter/nvim-treesitter",
			lock = true,
			config = function()
				require("config.treesitter")
			end,
			run = ":TSUpdate",
			event = "BufRead",
		})

		-- completion support
		use({
			"hrsh7th/nvim-cmp",
			lock = true,
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
			config = function()
				require("config.cmp")
			end,
			-- event = "InsertEnter", # gives problems
		})

		-- snippet engine
		use({
			"hrsh7th/vim-vsnip",
			lock = true,
			requires = { "hrsh7th/cmp-vsnip", "rafamadriz/friendly-snippets" },
			after = "nvim-cmp",
		})

		-- lsp support
		use({
			"neovim/nvim-lspconfig",
			lock = true,
			config = function()
				require("config.lsp")
			end,
			requires = { "lspcontainers/lspcontainers.nvim" },
			event = "BufRead",
		})

		-- formatting, linting sources
		use({
			"jose-elias-alvarez/null-ls.nvim",
			lock = true,
			config = function()
				-- local on_attach = require("config.lsp").on_attach
				-- require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
				require("config.null-ls")
			end,
			after = {
				"plenary.nvim",
				"nvim-lspconfig",
			},
		})

		-- use({ "ray-x/lsp_signature.nvim" })

		-- tree navigation
		use({
			"kyazdani42/nvim-tree.lua",
			lock = true,
			config = function()
				require("config.nvim_tree")
			end,
		})

		-- buffer line
		use({
			"romgrk/barbar.nvim",
			lock = true,
			event = "BufEnter",
		})

		-- status line
		use({
			"hoob3rt/lualine.nvim",
			lock = true,
			config = function()
				require("config.lualine")
			end,
		})

		-- indentation lines
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("config.indent_blankline")
			end,
			event = "BufRead",
		})

		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup()
			end,
		})

		use({ "kyazdani42/nvim-web-devicons" })

		use({
			"nvim-telescope/telescope.nvim",
			module = "telescope",
			cmd = "Telescope",
			config = function()
				require("config.telescope")
			end,
		})
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

		-- comment engine
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
			event = "BufRead",
		})

		use({
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup({})
			end,
		})

		-- nvim dashboard
		-- use({
		-- 	"glepnir/dashboard-nvim",
		-- 	config = function()
		-- 		require("config.dashboard")
		-- 	end,
		-- })
		use {
			"echasnovski/mini.nvim",
			config = function()
				local starter = require "mini.starter"
				starter.setup {
					items = {
						starter.sections.builtin_actions(),
						starter.sections.telescope(),
					},
					header = "Good day Kenneth",
					footer = "",
					content_hooks = {
						starter.gen_hook.adding_bullet(),
						starter.gen_hook.indexing("all", { "Builtin actions" }),
						starter.gen_hook.aligning("center", "center"),
					},
				}
			end,
		}
		-- use({ "ahmedkhalf/project.nvim",
		-- 	config = function ()
		-- 		require("project_nvim").setup{}
		-- 	end
		-- })

		use({ "machakann/vim-sandwich" })
		use({ "jiangmiao/auto-pairs" })

		-- tmux navigation support
		use({ "christoomey/vim-tmux-navigator" })

		use({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup({ "*" }, {
					RGB = true,
					RRGGBB = true,
					names = false,
					mode = "background",
				})
			end,
		})

		-- colorscheme
		use({
			"rebelot/kanagawa.nvim",
			lock = true,
			config = function()
				require("config.colors")
			end,
		})
	end,

	config = {
		compile_on_sync = true,
		-- floating window for command outputs
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
		compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
		profile = {
			enable = true,
			threshold = 1,
		},
	},
})
