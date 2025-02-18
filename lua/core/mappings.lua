vim.g.mapleader = " " -- Определяем клавишу лидер, после которой будут комманды - это пробел

-- NeoTree
vim.keymap.set('n', '<leader>e', ':Neotree position=float<CR>')
vim.keymap.set('n', '<leader>o', ':Neotree position=float source=git_status<CR>')
vim.keymap.set('n', '<TAB>', ':tabnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>')
-- vim.api.nvim_set_keymap('n', '<leader>t', ':Neotree toggle<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>t', ':Neotree toggle<CR>', { noremap = true, silent = true })

