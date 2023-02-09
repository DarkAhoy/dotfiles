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
set shell=zsh
set modifiable
set backupskip=/tmp/*,/private/tmp/*
set foldmethod=manual
" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=
set splitright
set splitbelow
  let @/ = ""
set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
set showmatch
" Ignore case when searching
set ignorecase
" Be smart when using tabs ;)
set smarttab
set noexpandtab
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
set clipboard=unnamedplus

" Add asteisks in block comments
set formatoptions+=r

" stop vim yanking when deleting
nnoremap d "_d
nnoremap dd dd
nnoremap c "_c
nnoremap x "_x
vnoremap d "_d

let mapleader = " "
" Format a json file using jq
nnoremap fj :%!jq .<CR> 

function! ClearSearch()
  let @/ = ""
endfunction

" clear search
nnoremap <leader>rc :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>q :let @/ = ""<CR>
nnoremap <leader>c :cclose<CR>

" buffer
nnoremap nb :bnext<cr>
nnoremap pb :bprevious<cr>

" plugins
call plug#begin("~/.config/nvim/plugged/")
source ~/.config/nvim/plugins/telescope.vim
source ~/.config/nvim/plugins/fugitive.vim
source ~/.config/nvim/plugins/colors.vim
source ~/.config/nvim/plugins/vimspector.vim
source ~/.config/nvim/plugins/lsp.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/treesitter.vim
source ~/.config/nvim/plugins/icons.vim
source ~/.config/nvim/plugins/maximizer.vim
call plug#end()

" sourcing lua files 
source ~/.config/nvim/lua/telescope_config.lua
source ~/.config/nvim/lua/tree_sitter.lua
source ~/.config/nvim/lua/lsp.lua
source ~/.config/nvim/lua/split.lua
source ~/.config/nvim/lua/debugger.lua

let g:airline_powerline_fonts = 1
let g:gruvbox_transparent_bg = 1
set background=dark
let g:cmdheight = 1
colorscheme gruvbox
highlight Normal guibg=none
highlight NonText guibg=none

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
	endif
  return expand('%')
endfunction

function! LightLineGit() 
	return ' ' . FugitiveHead()
endfunction

let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified'] ]
  \ },
  \ 'separator': {'left': '', 'right': ''},
  \ 'subseparator': {'left': '', 'right': ''},
  \ 'component_function': {
  \   'gitbranch': 'LightLineGit',
  \   'filename': 'LightlineFilename',
  \ },
  \ 'colorscheme': 'nord',
  \ }


