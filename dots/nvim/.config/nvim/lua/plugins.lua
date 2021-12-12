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
			config = function()
				require("config.treesitter")
			end,
			run = ":TSUpdate",
			event = "BufRead",
		})

		-- completion support
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
			config = function() -- todo: lazy load
				require("config.cmp")
			end,
			event = "InsertEnter",
		})

		-- snippet engine
		use({
			"hrsh7th/vim-vsnip",
			requires = { "hrsh7th/cmp-vsnip", "rafamadriz/friendly-snippets" },
			after = { "nvim-cmp" },
			event = "InsertEnter",
		})

		-- lsp support
		use({
			"neovim/nvim-lspconfig", -- todo: lazy load
			config = function()
				require("config.lsp")
			end,
			event = "BufRead",
		})

		-- formatting, linting sources
		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("config.null-ls")
				local on_attach = require("config.lsp").on_attach
				require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
			end,
			after = {
				"plenary.nvim",
				"nvim-lspconfig",
			},
		})

		-- lsp servers in docker containers
		use({
			"lspcontainers/lspcontainers.nvim",
			event = "BufRead",
		})

		-- use({ "ray-x/lsp_signature.nvim" })

		-- tree navigation
		use({
			"kyazdani42/nvim-tree.lua",
			config = function()
				require("config.nvim_tree") -- todo: lazy load
			end,
		})

		-- buffer line
		use({
			"romgrk/barbar.nvim",
			event = "BufEnter",
		})

		-- status line
		use({
			"hoob3rt/lualine.nvim",
			config = function()
				require("config.lualine")
			end,
		})

		-- indentation lines
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("indent_blankline").setup({
					char = "⦙",
					show_current_context = true,
					show_first_indent_level = false,
					buftype_exclude = { "terminal" },
				})
			end,
			event = "BufRead",
		})

		use({ "lewis6991/gitsigns.nvim" })
		use({ "kyazdani42/nvim-web-devicons" })

		-- nvim dashboard
		use({
			"glepnir/dashboard-nvim",
			config = function()
				require("config.dashboard")
			end,
		})

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

		use({ "tpope/vim-surround" })
		use({ "jiangmiao/auto-pairs" })
		-- TODO: project, which-key

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
		use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
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
