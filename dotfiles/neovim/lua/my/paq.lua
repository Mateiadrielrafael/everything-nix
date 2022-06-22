local M = {}

function M.setup()
    local paq = require("paq")
    local themePackages = require("my.theme").deps
    local base = {
        "neovim/nvim-lspconfig", -- configures lsps for me
        "windwp/nvim-autopairs", -- closes pairs for me (should look for a better one)
        "nvim-lua/plenary.nvim", -- async utility lib it seems?
        "nvim-telescope/telescope.nvim", -- fuzzy search for say opening files
        "purescript-contrib/purescript-vim", -- purescript support
        "terrortylor/nvim-comment", -- allows toggling line comments
        {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}, -- use treesitter for syntax highlighting
        {"nvim-treesitter/nvim-treesitter-textobjects", run = ":TSUpdate"}, -- the lean plugin wants me to install this, lol
        "startup-nvim/startup.nvim", -- splash screen
        "kyazdani42/nvim-web-devicons", -- nice looking icons
        "nvim-lualine/lualine.nvim", -- customizable status line
        "kyazdani42/nvim-tree.lua", -- file tree
        "lervag/vimtex", -- latex support
        "jose-elias-alvarez/null-ls.nvim", -- generic language server
        "nvim-telescope/telescope-file-browser.nvim", -- file creation/deletion menu
        "onsails/lspkind.nvim", -- show icons in lsp completion menus
        "preservim/vimux", -- interact with tmux from within vim
        "christoomey/vim-tmux-navigator", -- easly switch between tmux and vim panes
        "kana/vim-arpeggio", -- chord support, let"s fucking goooo
        {"andweeb/presence.nvim", run = ":DownloadUnicode"}, -- discord rich presence
        "Julian/lean.nvim", -- lean support
        "kmonad/kmonad-vim", -- kmonad config support
        -- "LucHermitte/lh-vim-lib", -- dependency for lh-brackets
        -- "LucHermitte/lh-brackets", -- kinda useless bruh, should find something better
        -- Cmp related stuff
        "hrsh7th/cmp-nvim-lsp", -- lsp completion
        "hrsh7th/cmp-buffer", -- idr what this is
        "hrsh7th/cmp-path", -- path completion ig?
        "hrsh7th/cmp-cmdline", -- cmdline completion perhaps?
        "hrsh7th/nvim-cmp", -- completion engine
        "L3MON4D3/LuaSnip", -- snippeting engine
        "saadparwaiz1/cmp_luasnip", -- snippet support for cmp
        "wakatime/vim-wakatime" -- track time usage
    }

    for _, v in ipairs(themePackages) do
        -- append package in the base list
        table.insert(base, v)
    end

    paq(base)
end

return M