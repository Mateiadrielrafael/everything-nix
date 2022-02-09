local M = {}

function M.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.mapSilent(mode, lhs, rhs, opts)
    local options = {silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    M.map(mode, lhs, rhs, opts)
end

function M.setup()
    M.map("i", "jj", "<Esc>") -- Remap Esc to jj
    M.map("n", "<Space><Space>", ":w<cr>") -- Double space to sace
end

return M