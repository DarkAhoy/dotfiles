local opts = {
    remap = false
}

vim.keymap.set("n", "<leader>q", function()
    vim.cmd('let @/ = ""')
end)

vim.keymap.set('n', 'c', '"_c', opts)
vim.keymap.set('n', 'x', '"_x', opts)

vim.keymap.set('n', 'ch', function()
    vim.cmd("set cmdheight=1")
end)

vim.keymap.set('n', '<leader>o', function()
    vim.cmd("tabnew %")
end)

--vim.keymap.set('n', 'q', '<c-v>', opts)
