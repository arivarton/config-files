syntax on
" Vundle
"
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
Plugin 'chriskempson/base16-vim'
Plugin 'python-mode/python-mode'
Plugin 'tpope/vim-fugitive'
Plugin 'dracula/vim'
Plugin 'dongweiming/vary.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'powerline/powerline'
Plugin 'wincent/terminus'
Plugin 'junegunn/vim-easy-align'
Plugin 'myusuf3/numbers.vim'

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
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
"
" scrooloose/nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDRemoveExtraSpaces = 1
"
" pymode
let g:pymode_lint_ignore = "E501,E265"
let g:pymode_doc_bind = "<F2>"
let g:pymode_quickfix_maxheight = 4
let g:pymode_quickfix_minheight = 2
"
" vary.vim
let g:auto_striptrail = 'python,ruby'
let g:auto_striptab = 'python,ruby,cpp'
"
" vim-airline
let g:airline_powerline_fonts = 1

set timeoutlen=2000
set completeopt=menuone,longest,preview
set shiftwidth=2
set softtabstop=2
set tabstop=4
set expandtab
set clipboard=unnamedplus
set number
set showcmd
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize

set vb

nmap K gt
nmap J gT
map <C-q> q
map <Enter> o<Esc>k

" VIM easy-align mappings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" color dracula
" color base16-tomorrow-night
" color base16-tomorrow-night
set printoptions=syntax:n,number:y

" Automatically set base16 shell theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
