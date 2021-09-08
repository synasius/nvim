require("nvim-treesitter.configs").setup({
	-- one of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = "maintained",
	highlight = {
		enable = true, -- false will disable the whole extension
		use_languagetree = true,
	},
	indent = {
		enable = true,
	},
})
