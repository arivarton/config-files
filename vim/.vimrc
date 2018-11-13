" xonsh is buggy with vim (fzf and vundle are clunky)
set shell=sh
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
" Plugin 'scrooloose/nerdcommenter'
Plugin 'chriskempson/base16-vim'
" Plugin 'tpope/vim-fugitive'
" Plugin 'dracula/vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'powerline/powerline'
" Plugin 'wincent/terminus'
" Plugin 'junegunn/vim-easy-align'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'myusuf3/numbers.vim'
" Plugin 'mattn/emmet-vim'

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

"
" scrooloose/nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1
let g:NERDRemoveExtraSpaces = 1
"
"
" vary.vim
let g:auto_striptrail = 'python,ruby'
let g:auto_striptab = 'python,ruby,cpp'
"
" vim-airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_theme='base16_oceanicnext'

set timeoutlen=2000
set completeopt=menuone,longest,preview
set clipboard=unnamedplus
set number
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize

set vb

" VIM easy-align mappings
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

set printoptions=syntax:n,number:y

let base16colorspace=256
" Automatically set base16 shell theme
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif
" colorscheme base16-bright

" Custom key maps and more by vidr
nnoremap K gt
nnoremap J gT
noremap <C-q> q
noremap <Enter> o<Esc>k
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <space> za
" Window resizing
nnoremap + :exe "resize " . (winheight(0) * 3/2)<CR> 
nnoremap <kPlus> :exe "resize " . (winheight(0) * 3/2)<CR> 
nnoremap - :exe "resize " . (winheight(0) * 2/3)<CR> 
nnoremap <kMinus> :exe "resize " . (winheight(0) * 2/3)<CR> 
nnoremap <leader>o <C-w>_<C-w>\|
" Automatically change to base directory for each file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" set rtp+=~/.fzf
" FZF keymaps
nnoremap <leader>fs :FZF!<CR>
nnoremap <leader>fdj :FZF $HOME/Source/django/<CR>
nnoremap <leader>fdev :FZF $HOME/Development/<CR>
nnoremap <leader>fh :FZF $HOME<CR>
nnoremap <leader>fpy :FZF /lib/python3.7/<CR>
"
" Use the 0 register (yank) instead of 1-9 register (delete) to paste
" noremap p "0p
nnoremap <F4> :wa<Bar>exe "mksession! " . v:this_session<CR>:echo 'Saved session here ' . v:this_session<CR> 
"
" Edit vimrc in split
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Abbreviations
iabbrev atrygg Andri Viðar Tryggvason
iabbrev avt arivarton

" tex mappings
autocmd FileType tex nnoremap <leader>c<CR> :!texi2pdf %<CR>
autocmd BufWritePost *.tex :!texi2pdf %

" set
set encoding=utf-8
set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4
set showcmd
set background=dark

" Set filetype of .xsh
autocmd BufRead,BufNewFile *.xsh setfiletype python


" Plugins installed by pikaur:
"
" Plugin Options
"
" YouCompleteMe
" let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" Make YouCompleteMe use python3+ as an interpreter 
" let g:ycm_python_binary_path = '/usr/bin/python3'
" let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
"
" pymode
let g:pymode = 1
let g:pymode_python = 'python3'
let g:pymode_lint_ignore = "E501,E265,E722,C0301,E0401,C0111,E266"
let g:pymode_doc_bind = "<F2>"
let g:pymode_quickfix_maxheight = 4
let g:pymode_quickfix_minheight = 2
" let g:pymode_lint_checkers = ['pep257', 'pyflakes', 'pylint', 'mccabe', 'pep8']
let g:pymode_lint_checkers = ['pyflakes', 'pylint', 'pep8']
" let g:pymode_lint_checkers = ['pylint']
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_regenerate_on_write = 0

" Only run PyLint when triggered by \p
let g:pymode_lint_on_write = 1
nnoremap <leader>p :PymodeLint<cr>
