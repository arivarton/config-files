" Vundle
" First install Vundle:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible      " be iMproved   " required
filetype off                          " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugins/')

" let Vundle manage Vundle            " required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'klen/python-mode'
Plugin 'tpope/vim-fugitive'
Plugin 'dracula/vim'
Plugin 'vim-airline/vim-airline'

call vundle#end()                     " required
filetype plugin indent on             " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Vundle HELP
" :PluginList         - lists configured plugins
" :PluginInstall      - Installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo   - Searches for foo; append `!` to refresh local cache
" :PluginClean        - Confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki on github for FAQ
" Put your non-plugin stuff after this line
"
" Vundle end

" Plugin Options
"
" Valloric/YouCompleteMe
" Make YouCompleteMe use python3+ as an interpreter 
let g:ycm_python_binary_path = '/usr/bin/python3'
"
" scrooloose/nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDRemoveExtraSpaces = 1
"
" pymode
let g:pymode_lint_ignore = "E501,E265"

set timeoutlen=2000
set completeopt=menuone,longest,preview
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set clipboard=unnamedplus
set number
set showcmd
map K gt
map J gT
map <C-q> q
map <Enter> o<Esc>k
nnoremap <buffer> <F9> :exec '!python3.5' shellescape(@%, 1)<cr>

color dracula
set printoptions=syntax:n,number:y
