call plug#begin()

" Quick find "
"Plug 'zivyangll/git-blame.vim'
Plug 'preservim/nerdtree'

" File word in all files "
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'maxmellon/vim-jsx-pretty'

call plug#end()

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'jiangmiao/auto-pairs'
call vundle#end()

let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '```':'```', '"""':'"""', "'''":"'''", "`":"`", '<<':'', '<':'>'}

" Set everything
set autoindent smartindent number nocompatible cursorline ignorecase smartcase mouse=a hls is ic backspace=indent,eol,start linespace=5  tabstop=8 softtabstop=0 shiftwidth=4 smarttab 
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
noremap T :W<CR> " open tab control

" mapping to swith between view points
noremap <C-k> <C-w>w
noremap <C-j> <C-w>W
noremap <C-,> <C-w>10<
noremap <C-.> <C-w>10>
noremap t :NERDTreeFind<CR> " Open file in Tree
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'


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
nnoremap <C-x> :!clear && g++ -g '%' -o '%:r.out' -std=c++17 && './%:r.out'<Enter>
nnoremap <C-b> :!clear && ./run.sh<Enter>
