local vscode = require("my.helpers.vscode")
local M = {}

function M.setup()
  require('nvim-autopairs').setup()
  --
  vscode.unless(function()
    require("presence"):setup({})
    require("my.plugins.dashboard").setup()
    require("my.plugins.treesitter").setup()
    require("my.plugins.cmp").setup()
    require("my.plugins.lspconfig").setup()
    require("my.plugins.null-ls").setup()
    require("my.plugins.nvim-tree").setup()
    require("my.plugins.vimtex").setup()
    require("my.plugins.lean").setup()
  end)

  require("my.plugins.vim-tmux-navigator").setup()
  require("my.plugins.lualine").setup()
  require("my.plugins.comment").setup()
  require("my.plugins.telescope").setup()
  require("my.plugins.vimux").setup()

  -- require("my.plugins.idris").setup()
  -- require("which-key").setup()
end

return M
