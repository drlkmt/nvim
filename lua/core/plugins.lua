-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
    "tiagovla/tokyodark.nvim",
        opts = {
            -- custom options here
        },
        config = function(_, opts)
            require("tokyodark").setup(opts) -- calling setup is optional
        end,
    },
    { "rose-pine/neovim", name = "rose-pine" },
    { 'rebelot/kanagawa.nvim' },
    { 'navarasu/onedark.nvim' },
    { 'jose-elias-alvarez/null-ls.nvim' },

	{'phaazon/hop.nvim'},
	{
	    "nvim-neo-tree/neo-tree.nvim",
	    branch = "v3.x",
	    dependencies = {
	      "nvim-lua/plenary.nvim",
	      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	      "MunifTanjim/nui.nvim",
	      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	    }
	},
	{ 'nvim-treesitter/nvim-treesitter' },
	{ 'neovim/nvim-lspconfig' },
    {'hrsh7th/cmp-nvim-lsp'}, {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-cmdline'}, {'hrsh7th/nvim-cmp'}, {'lewis6991/gitsigns.nvim'},
    { 'hrsh7th/vim-vsnip', dependencies = {
    'hrsh7th/vim-vsnip-integ',
    } },

    { "williamboman/mason.nvim",
        {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" }
        },
    },

    { 'nvim-telescope/telescope.nvim' },
    
    {
      "mfussenegger/nvim-lint",
      config = function()
        require('lint').linters_by_ft = {
          yaml = { "kube-linter" },
          dockerfile = { "hadolint" },
          helm = { "helm-lint" }

        }
      end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    {
  -- Подключаем LSP-сервер от SonarSource
  "SonarSource/sonarlint-language-server",
  lazy = false,
  -- Запускать SonarLint на перечисленных типах файлов
  ft = { "yaml", "javascript", "typescript", "python", "java", "go", "cpp" },
  config = function()
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")

    if not configs.sonarlint then
      configs.sonarlint = {
        default_config = {
          -- Важно: бинарник/скрипт `sonarlint-language-server` должен быть доступен в $PATH
          cmd = { "sonarlint-language-server", "--stdio" },
          filetypes = { "yaml", "javascript", "typescript", "python", "java", "go", "cpp" },
          root_dir = lspconfig.util.root_pattern("sonarlint.json", ".git", "package.json"),
          settings = {
            sonarlint = {
              -- Здесь можно указывать кастомные правила, если нужны проверки именно для K8s.
              -- Для этого придётся подложить свой sonarlint.json с настройками/правилами.
              rules = {
                -- Пример (условный, если у вас есть конкретные ключи правил SonarLint):
                -- {
                --   key = "yaml:SomeK8sRule",
                --   activated = true,
                -- }
              },
            },
          },
        },
      }
    end

    -- Регистрируем конфиг с именем 'sonarlint'
    lspconfig.sonarlint.setup({})
  end
},


    {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
    }

})
