" Auto indent
filetype plugin on
filetype indent on
filetype plugin indent on
runtime! config/**/*.vim


" Set everything
syntax on
set cursorline number ruler 
set mouse=a hls is ic 
set backspace=indent,eol,start 
set linespace=5 " better display on MacVim
set smartcase ignorecase
set smartindent " auto indent at new line
set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop=2         " Tab key indents by 4 spaces.
set shiftwidth=2         " >> indents by 4 spaces.
set shiftround            " >> indents to next multiple of 'shiftwidth'.


" Key shortcut
" noremap is non-recursive means it will be execute rightaway
noremap q ^
noremap e $
noremap J 10j
noremap K 10k
noremap L 10l
noremap H 10h
noremap 0 :nohls<CR>
noremap T :W<CR>
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nmap 9 :set invnumber<CR>

" noremap is non-recursive means it will be execute rightaway
" map to move block of code up and down
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" mapping to swith between view points
nnoremap <C-k> <C-w>w
nnoremap <C-j> <C-w>W
noremap <C-h> <C-w>10>
noremap <C-l> <C-w>10<

" fix Tmux
set background=dark
set t_Co=256

if &term =~ "screen"                                                   
    let &t_BE = "\e[?2004h"                                              
    let &t_BD = "\e[?2004l"                                              
    exec "set t_PS=\e[200~"                                              
    exec "set t_PE=\e[201~"                                              
endif
