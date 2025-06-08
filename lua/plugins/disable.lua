return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false }, -- отключает стартовый экран
      explorer = { enabled = false }, -- отключает snacks explorer
      picker = { enabled = false }, -- отключает snacks picker
    },
    keys = {
      { "<leader>e", false }, -- снимаем возможный дефолтный маппинг
    },
  },
}
