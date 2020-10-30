call plug#begin()
" Install multiple cursors"

" Quick find "
Plug 'zivyangll/git-blame.vim'
Plug 'preservim/nerdtree'

" File word in all files "
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Markdown preview

call plug#end()

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'jiangmiao/auto-pairs'
call vundle#end()

" Git blame
" autocmd CursorMoved * :call gitblame#echo()

" Indent
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
set smartindent

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

" Auto indent
filetype plugin indent on
runtime! config/**/*.vim

" Auto turn on nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open nerdtree
map <S-p> :NERDTreeToggle<CR>
" Show hidden files
let NERDTreeShowHidden=1

" Key shortcut
nnoremap q ^
nnoremap e $
vnoremap e $
vnoremap q ^
map C :set colorcolumn=<CR>
map J 10j
map K 10k
map L 10l
map H 10h
map 0 :nohls<CR>
map t :W<CR> " open tab control

" config for jsx prettier
"let g:vim_jsx_pretty_colorful_config = 1 " default 0

" Jump to definition
map oo <C-]>
" Generate tag file
"map ob :r !ctags -R -f ./.git/tags .<CR>


" hight light search
set hls is
" Able to search even capital or lower
set ic

" PLUGIN: FZF
nnoremap <c-p> :Files<CR>
nnoremap <c-f> :Ag<CR>
