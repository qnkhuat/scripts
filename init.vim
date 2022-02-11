call plug#begin()

Plug 'preservim/nerdtree'
" Search stuffs in all files
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Git wrapper
Plug 'tpope/vim-fugitive'
" Show git diff markers
Plug 'airblade/vim-gitgutter'

Plug 'jiangmiao/auto-pairs'
Plug 'kien/rainbow_parentheses.vim'

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'jpalardy/vim-slime'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tweekmonster/gofmt.vim', {'for': 'go'}

" Clojure
Plug 'Olical/conjure', {'branch': 'develop', 'for':['clojure']}
Plug 'clojure-vim/clojure.vim', {'for': ['clojure']}

call plug#end()

" ---------------------------------------
" PLUGIN-vim-gitgutter
" ----------------------------------------
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" ----------------------------------------
" PLUGIN-conjure
" ----------------------------------------
let maplocalleader = " "
let g:conjure#mapping#doc_word = "d"
let g:conjure#log#wrap = "true"
let g:conjure#client#clojure#nrepl#eval#raw_out = v:true
let g:conjure#client#clojure#nrepl#test#raw_out = v:true
let g:conjure#log#hud#width = 0.45
let g:conjure#log#hud#height = 0.4
" Eval
xmap s <localleader>E
nmap s <localleader>er
" add result as comment to next line
xmap S o;; => <C-r>c<ESC><CR>
nmap S o;; => <C-r>c<ESC><CR>
nnoremap F :ConjureDef<CR>
nnoremap D :ConjureDoc<CR>

" ----------------------------------------
" PLUGIN-clojure-vim/clojure.vim
" ----------------------------------------
"let g:clojure_align_multiline_strings = 1
let g:clojure_fuzzy_indent = 1
let g:clojure_fuzzy_indent_blacklist = ['-fn$', '\v^with-%(meta|out-str|loading-context)$']
let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let', '-tpl$']
let g:clojure_maxlines = 0
let g:clojure_special_indent_words = 'deftype,defrecord,reify,proxy,extend-type,extend-protocol,letfn'

" ----------------------------------------
" PLUGIN-vim-fugitive
" ----------------------------------------
nnoremap B :Git blame<CR>

" ----------------------------------------
"" PLUGIN-vim-gofmt
" ----------------------------------------
let g:gofmt_exe = '/opt/homebrew/bin/gofmt'
let g:gofmt_on_save = 1
let g:go_highlight_trailing_whitespace_error=0

" ----------------------------------------
" PLUGIN-coc.vim
" ----------------------------------------
highlight CocErrorFloat ctermfg=yellow ctermbg=gray
highlight CocFloating ctermbg=darkblue ctermfg=white
highlight NormalFloat ctermbg=black guibg=black

" ----------------------------------------
" PLUGIN-AutoPairs
" ----------------------------------------
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"",'"':'"', "`":"", '```':'```', '"""':'"""', "'''":"'''"}

" ----------------------------------------
" Set everything
" ----------------------------------------
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
set splitright            " split the new file open on the right
"set colorcolumn=80
highlight ColorColumn ctermbg=DarkGray guibg=darkgray
" Auto remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Key shortcut
noremap q ^
noremap f e
noremap e $
noremap J 10j
noremap K 10k
noremap L 10l
noremap H 10h
noremap 0 :nohls<CR>
noremap T :W<CR>
" Opposite of <C-o>
nnoremap <C-u> <C-I>
nnoremap <Tab> gt
nnoremap <S-Tab> gT
" Change Search forward to # and backward to *
nnoremap # *
nnoremap * #
nmap 9 :set invnumber<CR>

" noremap is non-recursive means it will be execute rightaway
" map to move block of code up and down
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
noremap + gg=G

" mapping to swith between view points
nnoremap <C-k> <C-w>w
nnoremap <C-j> <C-w>W
noremap <C-h> <C-w>10<
noremap <C-l> <C-w>10>

" Copy to clipboard
vnoremap cp "+y<CR>

" Make sure these deletions are not replaced yanked register
" use x for delete and replace yanks
nnoremap d "_d
vnoremap d "_d
" https://stackoverflow.com/questions/290465/how-to-paste-over-without-overwriting-register
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vnoremap <silent> <expr> p <sid>Repl()

" ----------------------------------------
" PLUGIN-NERDTREE
" ----------------------------------------
" Auto turn on nerdtree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open nerdtree
map <S-p> :NERDTreeToggle<CR>
" Show hidden files
let NERDTreeShowHidden=1

" Open file in Tree
noremap T :NERDTreeFind<CR>
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'
" prevent nerdtree from resize panes when toggle
"set winfixwidth winfixheight
"set autoread

" ----------------------------------------
" PLUGIN-FZF
" ----------------------------------------
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
nnoremap <silent> <C-p> :Files <cr>
nnoremap <silent> <C-f> :Ag <cr>
nnoremap M :Marks<CR>
" Show commits
nnoremap gc :Commits<CR>
" Show all commits of current buffer
nnoremap gb :BCommits<CR>

" Shortcut to run a executable fiel
nnoremap <C-b> :!clear && ./run.sh<Enter>

" ----------------------------------------
" PLUGIN-slime
" ----------------------------------------
let g:slime_target = "tmux"
let g:slime_no_mappings = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
xmap cpp <Plug>SlimeRegionSend
nmap cpp <Plug>SlimeParagraphSend
nmap <c-c>v <Plug>SlimeConfig

" ----------------------------------------
" PLUGIN-rainbow_parentheses
" ----------------------------------------
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs = [
    \ ['brown',   'RoyalBlue3'],
    \ ['blue',    'SeaGreen3'],
    \ ['gray',    'DarkOrchid3'],
    \ ['darkgreen','firebrick3'],
    \ ['cyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',   'firebrick3'],
    \ ['gray',    'RoyalBlue3'],
    \ ['yellow',   'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['blue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['cyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',     'firebrick3'],
    \ ]

" ----------------------------------------
" fix Tmux
" ----------------------------------------
set background=dark
set t_Co=256

if &term =~ "screen"
  let &t_BE = "\e[?2004h"
  let &t_BD = "\e[?2004l"
  exec "set t_PS=\e[200~"
  exec "set t_PE=\e[201~"
endif
