require("bufferline").setup({
	options = {
		view = "multiwindow",
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(_, _, diagnostics_dict)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or " ")
				s = s .. n .. sym
			end
			return s
		end,
		show_buffer_close_icons = true,
		show_close_icon = true,
		separator_style = "thin",
		tab_size = 20,
		numbers = "ordinal",
	},
})

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
vim.api.nvim_set_keymap("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<s-tab>", "<cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })
-- Remove a buffer
vim.api.nvim_set_keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { noremap = true, silent = true })
