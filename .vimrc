"Configuration based on this https://realpython.com/vim-and-python-a-match-made-in-heaven/
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Add in packages here
" Solarized
Plugin 'altercation/vim-colors-solarized'
"Indent Python
Plugin 'vim-scripts/indentpython.vim'
"Jedi-vim
Plugin 'davidhalter/jedi-vim'
"Syntastic
Plugin 'vim-syntastic/syntastic'
"PEP-8
Plugin 'nvie/vim-flake8'
" Stop adding packages here



call vundle#end()            " required
filetype plugin indent on    " required

"Solarized configuration
syntax enable
set background=dark
colorscheme solarized

"Vim configuration
"Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Python PEP-8
au BufNewFile, BufRead *.py
  \ set tabstop=4
  \ set softtabstop=4
  \ set shiftwidth=4
  \ set expandtab
  \ set autoindent
  \ set fileformat=unix

"Python
set encoding=utf-8
let python_highlight_all=1
syntax on


" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
