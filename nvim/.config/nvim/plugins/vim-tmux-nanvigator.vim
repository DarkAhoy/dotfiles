Plug 'christoomey/vim-tmux-navigator'

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <Leader><Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <Leader><Down> :TmuxNavigateDown<cr>
nnoremap <silent> <Leader><Up> :TmuxNavigateUp<cr>
nnoremap <silent> <Leader><Right> :TmuxNavigateRight<cr>
