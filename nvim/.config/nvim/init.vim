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
set clipboard=unnamed
" Add asterisks in block comments
set formatoptions+=r

let mapleader = " "

" Format a json file using jq
nnoremap fj :%!jq .<CR> 

function! ClearSearch()
  let @/ = ""
endfunction

" clear search
nnoremap <leader>rc :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>q :let @/ = ""<CR>
nnoremap <leader>b :!echo hello<CR>

" buffers
nnoremap nb :bnext<cr>
nnoremap pb :bprevious<cr>

" plugins
call plug#begin()
source ~/.config/nvim/plugins/telescope.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/vim-go.vim
source ~/.config/nvim/plugins/fugitive.vim
source ~/.config/nvim/plugins/onedark.vim
source ~/.config/nvim/plugins/vim-tmux-nanvigator.vim
call plug#end()

set background=dark
colorscheme onedark

