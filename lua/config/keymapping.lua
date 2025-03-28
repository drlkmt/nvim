-- lua/config/keymapping.lua

-- Базовые настройки отступов (можно вынести в отдельный файл settings.lua)
vim.opt.expandtab = true   -- Использовать пробелы вместо табов
vim.opt.smartindent = true -- Умное автоотступление
vim.opt.tabstop = 2        -- Ширина табуляции в 2 пробела
vim.opt.shiftwidth = 2     -- Ширина автоотступа в 2 пробела

------------------------------------------
-- Глобальные маппинги (основные комбинации)
------------------------------------------

-- NeoTree (Файловый менеджер)
-- Открыть/закрыть плавающее окно файлового дерева
vim.keymap.set('n', '<Leader>e', ':Neotree position=float<CR>', {
  noremap = true,
  silent = true,
  desc = 'Toggle file explorer'
})

-- Mason (Управление LSP и тулами)
-- Открыть интерфейс управления языковыми серверами
vim.keymap.set('n', '<Leader>cm', '<cmd>Mason<cr>', {
  noremap = true,
  silent = true,
  desc = 'Open Mason interface'
})

------------------------------------------
-- LSP (Language Server Protocol) маппинги
------------------------------------------

local M = {}

-- Настройка буферных маппингов для LSP
function M.setup_lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Переход к определению символа
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

  -- Показать информацию о символе (ховер)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

  -- Переименовать символ в текущей области видимости
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)

  -- Показать доступные действия для кода
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)

  -- Найти все ссылки на символ
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

  -- Форматировать текущий буфер
  vim.keymap.set('n', '<Leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

------------------------------------------
-- Автодополнение (nvim-cmp) маппинги
------------------------------------------

function M.setup_cmp_mappings(cmp)
  local luasnip = require('luasnip')

  return cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),           -- Прокрутка документации вверх
    ['<C-f>'] = cmp.mapping.scroll_docs(4),            -- Прокрутка документации вниз
    ['<C-Space>'] = cmp.mapping.complete(),            -- Принудительный вызов автодополнения
    ['<C-e>'] = cmp.mapping.abort(),                   -- Закрыть окно автодополнения
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Подтвердить выбор

    -- Навигация по предложениям и сниппетам
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }), -- Режимы: insert и select

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  })
end

return M
