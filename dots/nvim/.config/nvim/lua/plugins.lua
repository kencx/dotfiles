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
			-- lock = true,
			config = function()
				require("config.treesitter")
			end,
			run = ":TSUpdate",
			event = "BufRead",
		})

		-- completion support
		use({
			"hrsh7th/nvim-cmp",
			-- lock = true,
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
			-- lock = true,
			requires = { "hrsh7th/cmp-vsnip", "rafamadriz/friendly-snippets" },
			after = "nvim-cmp",
		})

		-- lsp support
		use({
			"neovim/nvim-lspconfig",
			-- lock = true,
			config = function()
				require("config.lsp")
			end,
			requires = { "lspcontainers/lspcontainers.nvim" },
			event = "BufRead",
		})

		-- formatting, linting sources
		use({
			"jose-elias-alvarez/null-ls.nvim",
			-- lock = true,
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

		-- buffer line
		use({
			"romgrk/barbar.nvim",
			-- lock = true,
			event = "BufEnter",
		})

		-- status line
		use({
			"hoob3rt/lualine.nvim",
			-- lock = true,
			config = function()
				require("config.lualine")
			end,
		})

		-- indentation lines
		use({
			"lukas-reineke/indent-blankline.nvim",
			-- lock = true,
			config = function()
				require("config.indent_blankline")
			end,
			event = "BufRead",
		})

		use({
			"notjedi/nvim-rooter.lua",
			config = function()
				require("nvim-rooter").setup({
					manual = false,
				})
			end,
		})

		use({
			"lewis6991/gitsigns.nvim",
			-- lock = true,
			config = function()
				require("gitsigns").setup()
			end,
		})

		use({
			"sindrets/diffview.nvim",
		})

		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.0",
			module = "telescope",
			cmd = "Telescope",
			config = function()
				require("config.telescope")
			end,
		})
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use({ "nvim-telescope/telescope-file-browser.nvim" })
		use({ "kyazdani42/nvim-web-devicons" })

		-- comment engine
		use({
			"numToStr/Comment.nvim",
			-- lock = true,
			config = function()
				require("Comment").setup()
			end,
			event = "BufRead",
		})

		use({
			"folke/which-key.nvim",
			-- lock = true,
			config = function()
				require("which-key").setup({})
			end,
		})

		use({
			"echasnovski/mini.map",
			lock = true,
			config = function()
				require("config.mini-map")
			end,
		})

		use({ "machakann/vim-sandwich" })
		use({ "jiangmiao/auto-pairs" })
		use({
			"Julian/vim-textobj-variable-segment",
			requires = { "kana/vim-textobj-user" },
			event = "BufRead",
		})

		-- tmux navigation support
		use({ "christoomey/vim-tmux-navigator" })

		-- markdown previewer
		use({
			"iamcco/markdown-preview.nvim",
			run = function()
				fn["mkdp#util#install"]()
			end,
			config = function()
				require("config.markdown_preview")
			end,
		})

		-- obsidian
		use({
			"epwalsh/obsidian.nvim",
			config = function()
				require("config.obsidian-nvim")
			end,
		})

		-- colorscheme
		use({
			"rebelot/kanagawa.nvim",
			-- https://github.com/rebelot/kanagawa.nvim/issues/79
			-- requires nvim >= 0.8 after this commit
			commit = "fc2e308",
			config = function()
				require("config.colors")
			end,
		})
		use({
			"norcalli/nvim-colorizer.lua",
			-- lock = true,
			config = function()
				require("colorizer").setup({ "*" }, {
					RGB = true,
					RRGGBB = true,
					names = false,
					mode = "background",
				})
			end,
		})
		use({
			"mrshmllow/document-color.nvim",
			-- lock = true,
			config = function()
				require("document-color").setup({
					mode = "background",
				})
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
