-- See Telescope default settings here:
-- https://github.com/nvim-telescope/telescope.nvim#telescope-defaults
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules", "*.meta" },
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<c-t>"] = trouble.open_with_trouble,
			},
			n = {
				["<c-t>"] = trouble.open_with_trouble,
			},
		},
	},
})

-- load extensions
require("telescope").load_extension("flutter")

-- Mappings
local opt = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fl", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fg", [[<Cmd>lua require('telescope.builtin').grep_string()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fp", [[<Cmd>lua require('telescope.builtin').builtin()<CR>]], opt)
