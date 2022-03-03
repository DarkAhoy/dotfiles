Plug 'preservim/nerdtree'

"nnoremap <leader>p :NERDTreeToggle %<cr>

function! NerdTreeToggleFind()
    if exists("g:NERDTree") && g:NERDTree.IsOpen()
        NERDTreeClose
    elseif filereadable(expand('%'))
        NERDTreeFind
    else
        NERDTree
    endif
endfunction


nnoremap <leader>p :call NerdTreeToggleFind()<cr>

