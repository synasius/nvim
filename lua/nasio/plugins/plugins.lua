-- Automatically install Packer if it does not exist
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
end

vim.cmd([[packadd packer.nvim]])

require("packer").startup(function()
	use({
		"wbthomason/packer.nvim",
		opt = true,
	})

	-- themes, ux and style
	use({
		"folke/tokyonight.nvim",
	})

	use({
		"famiu/feline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nasio.plugins.configs.statusline")
		end,
	})

	use({
		"akinsho/nvim-bufferline.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nasio.plugins.configs.bufferline")
		end,
		setup = function()
			require("nasio.plugins.mappings.bufferline")
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
	})

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- Git utilities
	use({
		"lewis6991/gitsigns.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("nasio.plugins.configs.gitsigns")
		end,
	})

	use({
		"TimUntersberger/neogit",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("nasio.plugins.configs.neogit")
		end,
	})

	-- highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nasio.plugins.configs.treesitter")
		end,
	})

	-- smooth scroll
	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	})

	-- completion
	use("neovim/nvim-lspconfig")
	use("kabouzeid/nvim-lspinstall")
	use("hrsh7th/nvim-compe")
	use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" })

	-- snippets with completion integration
	use("hrsh7th/vim-vsnip")
	use("hrsh7th/vim-vsnip-integ")
	use("rafamadriz/friendly-snippets")
	use("Nash0x7E2/awesome-flutter-snippets")

	-- icons for lsp completion items
	use("onsails/lspkind-nvim")

	-- file managing , picker, fuzzy finder
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		cmd = "NvimTreeToggle",
		config = function()
			require("nasio.plugins.configs.nvimtree")
		end,
		setup = function()
			require("nasio.plugins.mappings.nvimtree")
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("nasio.plugins.configs.telescope")
		end,
		setup = function()
			require("nasio.plugins.mappings.telescope")
		end,
	})

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
		setup = function()
			require("nasio.plugins.mappings.trouble")
		end,
	})

	-- Debugging
	use("mfussenegger/nvim-dap")

	-- Trim traling spaces and whitelines at the end of files
	use({
		"cappyzawa/trim.nvim",
		config = function()
			require("trim").setup({
				disable = { "markdown" },
			})
		end,
	})
end)

-- Auto compile when there are changes in plugins.lua
vim.api.nvim_command("augroup PackerCompileOnWrite")
vim.api.nvim_command("autocmd!")
vim.api.nvim_command("autocmd BufWritePost plugins.lua source <afile> | PackerSync")
vim.api.nvim_command("augroup END")
