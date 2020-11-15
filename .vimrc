call plug#begin()" Install multiple cursors"

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

set tabstop=8 softtabstop=0 shiftwidth=4 smarttab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2

set backspace=indent,eol,start
set linespace=5 " on MACVim it shows underscore as space

set number

set smartcase " smart case sensitive
set ignorecase
syntax on

set autoindent

set cursorline

set nocompatible

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
" map oo <C-]>
" Generate tag file
"map ob :r !ctags -R -f ./.git/tags .<CR>


" hight light search
set hls is
" Able to search even capital or lower
set ic

" PLUGIN: FZF
" helper function to prevent Fzf to open file in nerdtree buffer
function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

" Mapping for file file and serach code
nnoremap <silent> <C-f> :call FZFOpen(':Ag')<CR>
nnoremap <silent> <C-p> :call FZFOpen(':Files')<CR>


" Compile and run cpp code
nnoremap <C-c> :!clear && g++ -o  %:r.out % -std=c++11<Enter>
nnoremap <C-x> :!clear && g++ -o  %:r.out % -std=c++11 && ./%:r.out<Enter>
