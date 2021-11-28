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

		-- lsp and completion support
		use({
			"nvim-treesitter/nvim-treesitter",
			config = function()
				require("config.treesitter")
			end,
			run = ":TSUpdate",
			event = "BufRead",
		})

		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
			config = function() -- todo: lazy load
				require("config.cmp")
			end,
			event = "InsertEnter",
		})

		use({
			"SirVer/ultisnips",
			requires = { { "honza/vim-snippets", rtp = "." } },
			config = function()
				vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
				vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
				vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
				vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
				vim.g.UltiSnipsRemoveSelectModeMappings = 0
			end,
			after = { "nvim-cmp" },
		})

		use({
			"neovim/nvim-lspconfig", -- todo: lazy load
			config = function()
				require("config.lsp")
			end,
		})

		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("config.null-ls")
				require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
			end,
			after = {
				"plenary.nvim",
				"nvim-lspconfig",
			},
		})

		-- UI
		use({
			"kyazdani42/nvim-tree.lua",
			config = function()
				require("config.nvim_tree") -- todo: lazy load
			end,
			-- cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
		})

		use({
			"romgrk/barbar.nvim",
			event = "BufEnter",
			--[[config = function()
            require('config.barbar_nvim')     -- todo: configs
        end]]
		})

		use({
			"hoob3rt/lualine.nvim",
			config = function()
				require("lualine").setup() -- todo: configs
			end,
			-- after = 'gruvbox.nvim',
		})

		--[[use {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
    }]]
		use({ "lewis6991/gitsigns.nvim" })
		use({ "kyazdani42/nvim-web-devicons" })
		use({
			"glepnir/dashboard-nvim",
			config = function()
				require("config.dashboard")
			end,
		})

		-- Quality of Life support
		-- TODO: project, which-key
		use({
			"nvim-telescope/telescope.nvim", -- todo: configs
			module = "telescope",
			cmd = "Telescope",
		})

		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		use({ "tpope/vim-surround" })
		use({ "jiangmiao/auto-pairs" })

		use({ "christoomey/vim-tmux-navigator" })

		-- colorscheme
		use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
	end,

	config = {
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
