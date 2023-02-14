return {
  "glepnir/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require('dashboard').setup {
      -- config
      header = {}
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}