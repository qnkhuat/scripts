call plug#begin()
" Install multiple cursors"
" Plug 'terryma/vim-multiple-cursors'

" Quick find "
Plug 'kien/ctrlp.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'zivyangll/git-blame.vim'


" File word in all files "
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

call plug#end()

" Indent
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces
set backspace=indent,eol,start
set linespace=5     " on MACVim it shows underscore as space

set number

set smartcase " smart case sensitive
set ignorecase
syntax on

set autoindent

set cursorline

set nocompatible

" Enable mosue scrolling
" set mouse=a

" Python limit chars line
set colorcolumn=80

" Initialisation de pathogen
call pathogen#infect()
call pathogen#helptags() " ctags

" Auto indent
filetype plugin indent on
runtime! config/**/*.vim

" Auto turn on nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open nerdtree
map <S-p> :NERDTreeToggle<CR>
" Show hidden files
let NERDTreeShowHidden=1

colorscheme molokai


" Key shortcut
nnoremap q ^
nnoremap e $
vnoremap e $
vnoremap q ^
map J 10j
map K 10k
map L 10l
map H 10h
map 0 :nohls<CR>

" Jump to definition
map oo <C-]>
" Generate tag file
"map ob :r !ctags -R -f ./.git/tags .<CR>


" hight light search
set hls is
" Able to search even capital or lower
set ic

" Use tab as ESC
" nnoremap <Tab> <Esc>
" vnoremap <Tab> <Esc>gV
" onoremap <Tab> <Esc>
" cnoremap <Tab> <C-C><Esc>
" inoremap <Tab> <Esc>`^
" inoremap <Leader><Tab> <Tab>




" Auto close
inoremap " ""<left>
inoremap ( ()<left>
""inoremap [ [<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O



" Setup quick find files
set runtimepath^=~/.vim/bundle/ctrlp.vim
