-- Automatically install Packer if it does not exist
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
end

vim.cmd([[packadd packer.nvim]])

require("packer").startup(function()
	use({ "wbthomason/packer.nvim", opt = true })

	-- colorscheme
	use("folke/tokyonight.nvim")

	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	-- completion
	use("neovim/nvim-lspconfig")
	use("kabouzeid/nvim-lspinstall")
	use("hrsh7th/nvim-compe")
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" })
	-- snippets with completion integration
	use("hrsh7th/vim-vsnip")
	use("hrsh7th/vim-vsnip-integ")
	use("rafamadriz/friendly-snippets")
	use("Nash0x7E2/awesome-flutter-snippets")

	-- icons for lsp completion items
	use("onsails/lspkind-nvim")

	-- highlighting
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- Fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
	})

	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
	})

	-- Debugging
	use("mfussenegger/nvim-dap")

	-- statusline
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	-- bufferline
	use({
		"akinsho/nvim-bufferline.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})

	-- Colorizer
	use("norcalli/nvim-colorizer.lua")

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
