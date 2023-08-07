local opts = { remap = false }

vim.keymap.set("n", "<leader>p", function()
    local isNerdTreeOpen = function()
        return vim.t.NERDTreeBufName and vim.fn.bufwinnr(vim.t.NERDTreeBufName) ~= -1
    end

    if vim.g.NERDTree and isNerdTreeOpen() then
        vim.cmd("NERDTreeClose")
        return
    else
        if vim.fn.filereadable(vim.fn.expand("%")) then
            vim.cmd("NERDTreeFind")
            return
        end
    end
    vim.cmd("NERDTree")
end, opts)
