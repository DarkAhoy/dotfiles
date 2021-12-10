Plug 'christoomey/vim-tmux-navigator'

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-b><Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-b><Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-b><Up> :TmuxNavigateUp<cr>
nnoremap <silent> <C-b><Right> :TmuxNavigateRight<cr>
