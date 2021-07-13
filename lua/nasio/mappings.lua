-- Here we define some general useful mappings not related to any plugin

vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>luafile %<CR>", { noremap = true })

-- These are handful mappings to encode strings in base64 and viceversa
vim.api.nvim_set_keymap("v", "<F2>", 'c<c-r>=system("base64 -w 0", @")<cr><esc>', { noremap = true })
vim.api.nvim_set_keymap("v", "<F3>", 'c<c-r>=system("base64 -d", @")<cr>', { noremap = true })

-- better window movement
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true })
