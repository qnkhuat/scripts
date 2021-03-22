call plug#begin()

Plug 'preservim/nerdtree'

" File word in all files "
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'jiangmiao/auto-pairs'
call vundle#end()

" Set everything
set autoindent smartindent number nocompatible cursorline ignorecase smartcase mouse=a hls is ic backspace=indent,eol,start linespace=5 tabstop=4 softtabstop=0 shiftwidth=4 smarttab noexpandtab
autocmd Filetype javascript,cpp,c,go setlocal tabstop=2 shiftwidth=2
autocmd Filetype python setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd Filetype haskell expandtab tabstop=8 shiftwidth=8
let g:go_highlight_trailing_whitespace_error=0
let g:go_doc_keywordprg_enabled = 0
let g:go_gopls_enabled = 0

" Auto indent
filetype plugin indent on
syntax on
runtime! config/**/*.vim

" Key shortcut
" noremap is non-recursive means it will be execute rightaway
noremap q ^
noremap e $
noremap C :set colorcolumn=<CR>
" execute "set <M-k>=[k"
noremap J 10j
noremap K 10k
noremap L 10l
noremap H 10h
noremap 0 :nohls<CR>
noremap T :W<CR>
nnoremap <Tab> gt
nnoremap <S-Tab> gT

" mapping to swith between view points
noremap <C-k> <C-w>w
noremap <C-j> <C-w>W
noremap <C-h> <C-w>10<
noremap <C-l> <C-w>10>

" PLUGIN : NERDTREE
" Auto turn on nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open nerdtree
map <S-p> :NERDTreeToggle<CR>
" Show hidden files
let NERDTreeShowHidden=1

" Open file in Tree
noremap t :NERDTreeFind<CR>
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'
 " prevent nerdtree from resize panes when toggle
set winfixwidth winfixheight
set autoread


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
nnoremap <C-b> :!clear && ./run.sh<Enter>

" folding
set fdm=manual

" fix Tmux
set background=dark
set t_Co=256

if &term =~ "screen"                                                   
    let &t_BE = "\e[?2004h"                                              
    let &t_BD = "\e[?2004l"                                              
    exec "set t_PS=\e[200~"                                              
    exec "set t_PE=\e[201~"                                              
endif
