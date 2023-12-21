local runtime = require("my.tempest")

local header_string = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗       ██████╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║    ██╗╚════██╗
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║    ╚═╝ █████╔╝
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║    ██╗ ╚═══██╗
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║    ╚═╝██████╔╝
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝       ╚═════╝
]]

local header = runtime.helpers.split(header_string, "\n")

local M = {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local theme = require("alpha.themes.dashboard")
    theme.opts.width = 70
    theme.opts.position = "center"
    theme.section.buttons.val = {}

    -- See [the header generator](https://patorjk.com/software/taag/#p=display&v=0&f=ANSI%20Shadow&t=NEOVim%20%3A3)
    theme.section.header.opts.hl = "AlphaHeader"
    theme.section.header.val = header
    local version = vim.version()
    local footer = function()
      local versionString = "🚀 "
        .. version.major
        .. "."
        .. version.minor
        .. "."
        .. version.patch
      local lazy_ok, lazy = pcall(require, "lazy")
      if lazy_ok then
        local total_plugins = lazy.stats().count .. " Plugins"
        local startuptime = (
          math.floor(lazy.stats().startuptime * 100 + 0.5) / 100
        )
        return versionString
          .. " —  🧰 "
          .. total_plugins
          .. " —  🕐 "
          .. startuptime
          .. "ms"
      else
        return version
      end
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        theme.section.footer.val = footer()
        vim.cmd("AlphaRedraw")
      end,
      desc = "Footer for Alpha",
    })

    theme.section.footer.opts.hl = "AlphaFooter"
    theme.section.header.opts.hl = "AlphaHeader"
    theme.section.buttons.opts.hl = "AlphaButton"

    require("alpha").setup(theme.config)
  end,
  lazy = false,
  cond = runtime.blacklist({ "vscode", "firenvim" }),
}

return M
