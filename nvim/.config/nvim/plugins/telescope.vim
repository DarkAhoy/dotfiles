Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
