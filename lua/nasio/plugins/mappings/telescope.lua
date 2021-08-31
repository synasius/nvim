-- Mappings
local opt = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fl", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fg", [[<Cmd>lua require('telescope.builtin').grep_string()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fp", [[<Cmd>lua require('telescope.builtin').builtin()<CR>]], opt)
