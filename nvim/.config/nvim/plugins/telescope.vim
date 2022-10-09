Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-S-f> <cmd>Telescope live_grep<cr>
nnoremap <C-f> <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>m <cmd>Telescope marks<cr>
nnoremap <leader>* <cmd>Telescope grep_string<cr>
