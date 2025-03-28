vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2


-- Neo-Tree plugin keybindings
vim.keymap.set('n', '<Leader>e', ':Neotree position=float<CR>', {
  noremap = true,   -- Отключает рекурсивные маппинги
  silent = true,    -- Подавляет вывод команды в командную строку
})
