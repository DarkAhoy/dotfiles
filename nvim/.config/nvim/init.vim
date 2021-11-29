" Fundamentals "{{{
" ---------------------------------------------------------------------

" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set number
set relativenumber 
syntax on
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set nobackup
set hlsearch
set showcmd
set laststatus=2
set scrolloff=10
set expandtab
"let loaded_matchparen = 1
set shell=zsh
set backupskip=/tmp/*,/private/tmp/*

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
set showmatch
" How many tenths of a second to blink when matching brackets
"set mat=2
" Ignore case when searching
set ignorecase
" Be smart when using tabs ;)
set smarttab
" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set backspace=start,eol,indent
" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" Add asterisks in block comments
set formatoptions+=r

" Format a json file using jq
nnoremap fj :%!jq .<CR> 

runtime ./plug_changes/*.vim
runtime ./plug.vim

" Use coc copletion instead of vim-go
let g:go_def_mapping_enabled = 0

function! ClearSearch()
  let @/ = ""
endfunction

" Copy to clipboard
" vnoremap y :w !pbcopy<CR>
set clipboard=unnamed

runtime ./plugged/vim-tmux-navigator/plugin/tmux_navigator.vim
let g:tmux_navigator_no_mappings = 1
let mapleader = "<c-b>"
nnoremap <silent> <Leader><Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <Leader><Down> :TmuxNavigateDown<cr>
nnoremap <silent> <Leader><Up> :TmuxNavigateUp<cr>
nnoremap <silent> <Leader><Right> :TmuxNavigateRight<cr>
nnoremap <silent> <Leader><\> :TmuxNavigatePrevious<cr>

" Telescope
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>

" Colors 
set background=dark
colorscheme onedark
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" buffers
nnoremap nb :bnext<cr>
nnoremap pb :bprevious<cr>

