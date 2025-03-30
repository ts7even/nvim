-- lua/plugins/themes/tokyonight.lua
return {
  "folke/tokyonight.nvim",
  lazy = false,  -- Load immediately
  priority = 1000,  -- High priority to ensure it's loaded first
  opts = {},  -- You can add options here if needed
  config = function()
    vim.cmd("colorscheme tokyonight")  -- Apply the colorscheme
  end,
}

