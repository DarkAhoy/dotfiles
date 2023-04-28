vim.g.mapleader = " "

vim.opt.ignorecase = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.termguicolors = true

vim.opt.clipboard = 'unnamedplus'
vim.opt.background = "dark"

vim.g.wildmode = longest, list

vim.g.lightline = {
    active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'absolutepath', 'modified' } } },
    separator = { left = '', right = '' },
    subseparator = { left = '', right = '' },
    component_function = {
        gitbranch = 'FugitiveHead',
    },
    colorscheme = 'nord',
}

vim.opt.swapfile = false
