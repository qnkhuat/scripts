call plug#begin()

Plug 'preservim/nerdtree'

" File word in all files "
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'jiangmiao/auto-pairs'
call vundle#end()

let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '```':'```', '"""':'"""', "'''":"'''", "`":"`"}

" Set everything
set autoindent smartindent number nocompatible cursorline ignorecase smartcase mouse=a hls is ic backspace=indent,eol,start linespace=5  tabstop=8 softtabstop=0 shiftwidth=4 smarttab expandtab
autocmd Filetype javascript,cpp,c setlocal ts=2 sw=2 sts=2

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
" noremap is non-recursive means it will be execute rightaway
noremap q ^
noremap e $
noremap C :set colorcolumn=<CR>
noremap J 10j
noremap K 10k
noremap L 10l
noremap H 10h
noremap 0 :nohls<CR>
noremap T :W<CR>

" mapping to swith between view points
noremap <C-k> <C-w>w
noremap <C-j> <C-w>W
noremap <C-h> <C-w>10<
noremap <C-l> <C-w>10>
noremap t :NERDTreeFind<CR> " Open file in Tree
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'
set winfixwidth winfixheight " prevent nerdtree from resize panes when toggle


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
nnoremap <C-x> :!clear && clang++ -g '%' -o '%:r.out' -std=c++17 && './%:r.out'<Enter>
nnoremap <C-b> :!clear && ./run.sh<Enter>


" fix Tmux
set background=dark
set t_Co=256


if &term =~ "screen"                                                   
    let &t_BE = "\e[?2004h"                                              
    let &t_BD = "\e[?2004l"                                              
    exec "set t_PS=\e[200~"                                              
    exec "set t_PE=\e[201~"                                              
endif
