"set nocompatible
"filetype off
"
"call plug#begin()
"
"Plug 'preservim/nerdtree'
"" File word in all files 
"Plug 'junegunn/fzf.vim'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go'}
"Plug 'tomlion/vim-solidity', {'for': 'solidity'}
"Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
"
"Plug 'pangloss/vim-javascript'
"Plug 'leafgarland/typescript-vim'
"Plug 'maxmellon/vim-jsx-pretty'
"Plug 'jiangmiao/auto-pairs'
"call plug#end()
"
"" Auto indent
"filetype plugin on
"filetype indent on
"filetype plugin indent on
"runtime! config/**/*.vim
"
"
"" Set everything
"syntax on
"set cursorline number ruler 
"set mouse=a hls is ic 
"set backspace=indent,eol,start 
"set linespace=5 " better display on MacVim
"set smartcase ignorecase
"set smartindent " auto indent at new line
"set autoindent             " Indent according to previous line.
"set expandtab              " Use spaces instead of tabs.
"set softtabstop=2         " Tab key indents by 4 spaces.
"set shiftwidth=2         " >> indents by 4 spaces.
"set shiftround            " >> indents to next multiple of 'shiftwidth'.
"
"
"" Key shortcut
"" noremap is non-recursive means it will be execute rightaway
"noremap q ^
"noremap e $
"noremap J 10j
"noremap K 10k
"noremap L 10l
"noremap H 10h
"noremap 0 :nohls<CR>
"noremap T :W<CR>
"nnoremap <Tab> gt
"nnoremap <S-Tab> gT
"nmap 9 :set invnumber<CR>
"
"" mapping to swith between view points
"noremap <C-k> <C-w>w
"noremap <C-j> <C-w>W
"noremap <C-h> <C-w>10>
"noremap <C-l> <C-w>10<
"
"" PLUGIN : NERDTREE
"" Auto turn on nerdtree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"" Open nerdtree
"map <S-p> :NERDTreeToggle<CR>
"" Show hidden files
"let NERDTreeShowHidden=1
"
"" Open file in Tree
"noremap t :NERDTreeFind<CR>
"let g:NERDTreeMapJumpNextSibling = '<Nop>'
"let g:NERDTreeMapJumpPrevSibling = '<Nop>'
" " prevent nerdtree from resize panes when toggle
"set winfixwidth winfixheight
"set autoread
"
"let g:closetag_html_style=1
"
"
"" PLUGIN: FZF
"" helper function to prevent Fzf to open file in nerdtree buffer
"function! FZFOpen(command_str)
"  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
"    exe "normal! \<c-w>\<c-w>"
"  endif
"  exe 'normal! ' . a:command_str . "\<cr>"
"endfunction
"
"" Mapping for file file and serach code
"nnoremap <silent> <C-f> :call FZFOpen(':Ag')<CR>
"nnoremap <silent> <C-p> :call FZFOpen(':Files')<CR>
"
"" Compile and run cpp code
"nnoremap <C-b> :!clear && ./run.sh<Enter>
"
"" fix Tmux
"set background=dark
"set t_Co=256
"
"if &term =~ "screen"                                                   
"    let &t_BE = "\e[?2004h"                                              
"    let &t_BD = "\e[?2004l"                                              
"    exec "set t_PS=\e[200~"                                              
"    exec "set t_PE=\e[201~"                                              
"endif
"
"" Plugin typescript-vim turn off auto indent
"let g:typescript_indent_disable = 1
"
"
"
