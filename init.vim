call plug#begin()

Plug 'preservim/nerdtree'
" File word in all files
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'jiangmiao/auto-pairs'

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'jpalardy/vim-slime'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tweekmonster/gofmt.vim'

" Clojure
Plug 'Olical/conjure', {'tag': 'v4.25.0'}

call plug#end()

" Plugin: conjure
let maplocalleader = " "
let g:conjure#mapping#doc_word = ""
xmap s <localleader>E
nmap s <localleader>er

"Plugin : vim-gofmt
let g:gofmt_exe = '/opt/homebrew/bin/gofmt'
let g:gofmt_on_save = 1
let g:go_highlight_trailing_whitespace_error=0

"Plugin : coc.vim
highlight CocErrorFloat ctermfg=black
highlight NormalFloat ctermbg=black guibg=black

let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"",'"':'"', "`":"", '```':'```', '"""':'"""', "'''":"'''"}

" Set everything
filetype plugin on
syntax on
set cursorline number ruler
set mouse=a hls is ic
set backspace=indent,eol,start
set linespace=5 " better display on MacVim
set smartcase ignorecase
set smartindent           " auto indent at new line
"set autoindent            " Indent according to previous line.
set expandtab             " Use spaces instead of tabs.
set softtabstop=2         " Tab key indents by 2 spaces.
set tabstop=2
set shiftround            " >> indents to next multiple of 'shiftwidth'.
set shiftwidth=2          " >> indents by 2 spaces.


" Key shortcut
noremap <Leader>A 100j
noremap q ^
noremap f e
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
inoremap <C-j> :m '>+1<CR>gv=gv
inoremap <C-k> :m '<-2<CR>gv=gv
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
noremap + gg=G

" mapping to swith between view points
nnoremap <C-k> <C-w>w
nnoremap <C-j> <C-w>W
noremap <C-h> <C-w>10>
noremap <C-l> <C-w>10<

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

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <silent> <C-p> :FZF .<cr>
nnoremap <silent> <C-f> :Ag <cr>

" Shortcut to run a executable fiel
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

" Config slime to work with tmux
let g:slime_target = "tmux"
let g:slime_no_mappings = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
xmap S <Plug>SlimeRegionSend
nmap S <Plug>SlimeParagraphSend

nmap <c-c>v <Plug>SlimeConfig
