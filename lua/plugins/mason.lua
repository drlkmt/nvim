return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        -- LSP серверы
        "pyright",
        "clangd",
        "lua-language-server",
        -- Форматтеры
        "stylua",
        "black",
        "clang-format",
        -- Линтеры
        "flake8",
        "cpplint",
      },
      ui = {
        icons = {
          package_installed = "󰄳",
          package_pending = "",
          package_uninstalled = "󰚌"
        }
      }
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")

      -- Автоматическая установка отсутствующих пакетов при старте
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local pkg = mr.get_package(tool)
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "mason.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
    end
  }
}
