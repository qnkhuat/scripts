call plug#begin()
" Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'preservim/nerdtree'
" Search stuffs in all files
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Git wrapper
Plug 'tpope/vim-fugitive'
" Enable :GBrowse
Plug 'tpope/vim-rhubarb'
" Show git diff markers
Plug 'airblade/vim-gitgutter'

Plug 'jiangmiao/auto-pairs'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-surround'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tweekmonster/gofmt.vim', {'for': 'go'}

" Clojure
Plug 'Olical/conjure', {'for': ['clojure', 'python', 'scheme'], 'tag': 'v4.53.0'}

Plug 'github/copilot.vim'

" vim-arsync depedencies
Plug 'prabirshrestha/async.vim'
" Remote editing
Plug 'qnkhuat/vim-arsync'

" avante
"Plug 'stevearc/dressing.nvim'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'MunifTanjim/nui.nvim'
"
"" avante: Optional deps
"Plug 'hrsh7th/nvim-cmp'
"Plug 'nvim-tree/nvim-web-devicons' "or Plug 'echasnovski/mini.icons'
"Plug 'HakonHarnes/img-clip.nvim'
"Plug 'zbirenbaum/copilot.lua'
"
"Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }

call plug#end()

" ----------------------------------------
" Set everything
" ----------------------------------------
let g:python_recommended_style = 0
filetype on
filetype plugin on
syntax on
set number ruler
set mouse=a hls is ic
set backspace=indent,eol,start
set smartcase ignorecase
set smartindent           " auto indent at new line
set autoindent            " Indent according to previous line.
set expandtab             " Use spaces instead of tabs.
set shiftround            " >> indents to next multiple of 'shiftwidth'.
set softtabstop=2 tabstop=2 shiftwidth=2         " Tab key indents by 2 spaces.
"autocmd FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4
set splitright            " split the new file open on the right
set updatetime=300
set foldmethod=indent
set nofoldenable
set nowrap
autocmd FileType markdown setlocal wrap
autocmd FileType json setlocal wrap
autocmd FileType markdown setlocal statusline=%f\ %h%m%r%=Words:\ %{wordcount().words}\ \ %l,%c\ %P
set laststatus=2
augroup CursorLineHighlight
  autocmd!
  " Set cursorline only for the active buffer/window
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

  " Clear existing cursor line highlighting and set new properties
  " This ensures it happens after any colorscheme is loaded
  autocmd VimEnter,WinEnter,BufWinEnter,ColorScheme * highlight clear CursorLine
  autocmd VimEnter,WinEnter,BufWinEnter,ColorScheme * highlight CursorLine gui=NONE cterm=NONE guibg=#2d2d30 ctermbg=236
augroup END

" override default nvim 0.10.0 color
colorscheme vim
set notermguicolors
highlight ColorColumn ctermbg=DarkGray guibg=darkgray
" Auto remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
" Map leader to space
let maplocalleader = " "

" Key shortcut
" record macro, use ; to execute
noremap ! q
noremap ; @
noremap q ^
noremap c t
noremap t $
noremap J 10j
noremap K 10k
noremap L 10l
noremap H 10h
noremap ) :nohls<CR>
noremap T :W<CR>
" move up half a page
nnoremap U <C-u>
nnoremap I <C-d>
" Opposite of <C-o>
nnoremap <C-u> <C-I>
" Change Search forward to # and backward to *
nnoremap # *
nnoremap * #
"nnoremap ( :set invnumber<CR>
nnoremap S :w<CR>
" noremap is non-recursive means it will be execute rightaway
" map to move block of code up and down
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
noremap + gg=G
" unmap the built-in Y -> y$
vnoremap Y y
cnoreabbrev epy !python3 %

" mapping to swith between view points
noremap <Tab> <C-w>w
noremap <S-tab> <C-w>W
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

function! SpellToggle()
  if &spell
    setlocal nospell
    setlocal spelllang=en
    echo "Spell checking disabled"
  else
    setlocal spell
    setlocal spelllang=en_us
    echo "Spell checking enabled"
  endif
endfunction

vnoremap <silent> <expr> p <sid>Repl()

" Prevent insert when press C-space
noremap <NUL> <ESC>

" Prevent from opening scratch preview window
set completeopt-=preview

" Quickly open a todo file
command T :35vsp ~/.cache/todo.md
command S :35vsp ~/.cache/scripts.sh

function! DecompileJava()
  set ft=java
  set ro
  execute '1,$d'
  execute '0r !procyon-decompiler ' . shellescape(expand('%'), 1)
endfunction

autocmd BufReadPost *.class call DecompileJava()

" ---------------------------------------
" PLUGIN-vim-gitgutter
" ----------------------------------------
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" ----------------------------------------
" PLUGIN-coc.nvim
" ----------------------------------------
" coc-conjure will make sure all suggestions, document of clojure code linked to coc-completion
let g:coc_global_extensions = ['coc-tsserver', 'coc-go', 'coc-diagnostic', 'coc-conjure', 'coc-rust-analyzer']
" map up and down arrow keys for select completion
inoremap <expr> <Up> coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"
inoremap <expr> <Down> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"
highlight CocFloating ctermbg=darkblue ctermfg=white
highlight FgCocInfoFloatBgCocFloating ctermfg=white ctermbg=darkblue guifg=LightBlue
highlight NormalFloat ctermbg=black guibg=black
nmap <silent> cr <Plug>(coc-rename)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gv :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> gn :call CocAction('jumpDefinition', 'tabe')<CR>
command! -nargs=1 CocSearchHere execute 'CocSearch ' . <q-args> . ' --glob ' . expand('%:h') . '/**'
"command! -nargs=* CS CocSearch <args>
cnoreabbrev CS CocSearch
cnoreabbrev CSH CocSearchHere

" Use K to show documentation in preview window
nnoremap <silent> D :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('D', 'in')
  endif
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use N to show documentation in preview window
nnoremap <silent> C :CocCommand<CR>

" ----------------------------------------
" PLUGIN-conjure
" ----------------------------------------

nnoremap cn :ConjureConnect<CR>
let g:conjure#client#scheme#stdio#command = "scheme"
let g:conjure#mapping#doc_word = "d"
let g:conjure#log#wrap = v:true
let g:conjure#client#clojure#nrepl#eval#raw_out = v:true
let g:conjure#client#clojure#nrepl#test#raw_out = v:true
let g:conjure#log#hud#width = 0.45
let g:conjure#log#hud#height = 0.4
let g:conjure#log#hud#anchor = "NE"
let g:conjure#client#python#stdio#command = "/Users/earther/.pyenv/shims/python3 -iq"
"let g:conjure#log#hud#enabled = v:false

" Eval comment block like do block
let g:conjure#eval#gsubs = {'do-comment': ['^%(comment[%s%c]', '(do ']}
" Eval
autocmd FileType python,clojure,scheme xmap s <localleader>E
autocmd FileType python,clojure,scheme nmap s <localleader>er
" add result as comment to next line
autocmd FileType python,clojure,scheme nmap <C-s> o;; => <C-r>c<ESC><CR>
nnoremap F :ConjureDef<CR>
autocmd FileType python,clojure,scheme nnoremap D :ConjureDoc<CR>

" ----------------------------------------
" PLUGIN-vlime
" ----------------------------------------
let g:vlime_window_settings = {'repl': {'vertical': v:true}, 'mrepl': {'vertical': v:true}, 'sldb': {'size': 15}}
let g:vlime_auto_show_arglist = v:false
autocmd FileType lisp nmap s <localleader>st
autocmd FileType lisp xmap s <localleader>st

" ----------------------------------------
" PLUGIN-clojure-vim/clojure.vim
" ----------------------------------------
let g:clojure_align_subforms = 1
let g:clojure_fuzzy_indent = 1
let g:clojure_fuzzy_indent_blacklist = ['-fn$', '\v^with-%(meta|out-str|loading-context)$', 'with-api-error-message']
let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let', '-tpl$', '^prog', 'dataset', 'test-drivers', 'test-driver', 'test-migrations', 'test-helpers-set-global-values!', 'condas->', 'are', 'discard-setting-changes', 'try', 'finally', 'match', 'mbql-query', 'do', 'ignore-exceptions', 'comment', 'with-task-history', 'cond']
let g:clojure_maxlines = 50
" indent with 2 spaces list
let g:clojure_special_indent_words = 'deftype,defrecord,reify,proxy,extend-type,extend-protocol,letfn'

" ----------------------------------------
" PLUGIN-eraserhd/parinfer-rust
" ----------------------------------------
let g:parinfer_force_balance = v:false
let g:parinfer_mode = 'paren'

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
" PLUGIN-auto-pairs
" ----------------------------------------
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"",'"':'"', "`":"", '```':'```', '"""':'"""', "'''":"'''"}


" ----------------------------------------
" PLUGIN-NERDTREE
" ----------------------------------------
" Auto turn on nerdtree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open nerdtree
map <S-p> :NERDTreeToggle<CR>
" Show hidden files
let NERDTreeShowHidden=1
let NERDTreeHighlightCursorline=0
"  https://github.com/preservim/nerdtree/issues/1321
let g:NERDTreeMinimalMenu=1

" Open file in Tree
noremap T :NERDTreeFind<CR>
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'
" prevent nerdtree from resize panes when toggle
"set winfixwidth winfixheight
set autoread
au CursorHold * checktime

" ----------------------------------------
" PLUGIN-FZF
" ----------------------------------------
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
command! -bang -nargs=* MRU call fzf#vim#history(fzf#vim#with_preview())
function! s:fzf_preview_p(bang, ...) abort
    let preview_args = get(g:, 'fzf_preview_window', ['right:50%', 'ctrl-/'])
    if empty(preview_args)
        return { 'options': ['--preview-window', 'hidden'] }
    endif

    " For backward-compatiblity
    if type(preview_args) == type('')
        let preview_args = [preview_args]
    endif
    return call('fzf#vim#with_preview', extend(copy(a:000), preview_args))
endfunction

  command! -bar -bang MP
        \ call fzf#vim#marks(
        \     s:fzf_preview_p(<bang>0, {'placeholder': '$([ -r $(echo {4} | sed "s#^~#$HOME#") ] && echo {4} || echo ' . fzf#shellescape(expand('%')) . '):{2}',
        \               'options': '--preview-window +{2}-/2'}),
        \     <bang>0)

nnoremap <silent> <C-f> :Ag<CR>
nnoremap <silent> <C-k> :MRU<CR>
if system('git rev-parse --is-inside-work-tree 2>/dev/null | tr -d "\n"') == 'true'
  nnoremap <silent> <C-p> :GFiles <cr>
else
  nnoremap <silent> <C-p> :Files<CR>
endif
nnoremap M :MP<CR>
"nnoremap U :Jumps<CR>
" Show commits
nnoremap gc :Commits<CR>
" Show all commits of current buffer
nnoremap gb :BCommits<CR>

" Shortcut to run a executable fiel
"nnoremap <C-b> :!clear && ./run.sh<Enter>

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
" PLUGIN-copilot
" ----------------------------------------
let g:copilot_enabled = v:false

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


"let g:mark_sign_id = 1000
"sign define mysign text=▶ texthl=WarningMsg
"nnoremap mc :call SignLine()<CR>
"nnoremap md :call UnsignLine()<CR>
"nnoremap mj :call JumpToNextSign()<CR>

"function! SignLine()
"  execute 'sign place ' . g:mark_sign_id . ' line=' . line('.') . ' name=mysign buffer=' . bufnr('%')
"  let g:mark_sign_id += 1
"endfunction
"
"function! UnsignLine()
"  let line_num = line('.')
"  let bufnr = bufnr('%')
"
"  " Get all signs in the current buffer
"  let signs_output = execute('sign place buffer=' . bufnr)
"
"  " Find signs on the current line
"  let pattern = 'line=' . line_num . '\s\+id=\(\d\+\)'
"  let match_list = matchlist(signs_output, pattern)
"
"  " If a sign was found on the current line, unplace it
"  if len(match_list) > 1
"    let sign_id = match_list[1]
"    execute 'sign unplace ' . sign_id . ' buffer=' . bufnr
"  else
"    echo "No sign found on the current line"
"  endif
"endfunction
"
"function! JumpToNextSign()
"  let bufnr = bufnr('%')
"  let current_line = line('.')
"
"  " Get all signs in the current buffer
"  let signs_output = execute('sign place buffer=' . bufnr)
"
"  " Extract all line numbers with signs
"  let sign_lines = []
"  let pattern = 'line=\(\d\+\)'
"  let start_idx = 0
"
"  " Find all matches in the output
"  while 1
"    let match_idx = match(signs_output, pattern, start_idx)
"    if match_idx == -1
"      break
"    endif
"
"    let match_end = matchend(signs_output, pattern, start_idx)
"    let line_num = str2nr(matchstr(signs_output[match_idx:match_end], '\d\+'))
"    call add(sign_lines, line_num)
"
"    let start_idx = match_end
"  endwhile
"
"  " Sort the line numbers
"  call sort(sign_lines, 'n')
"
"  " Find the next sign after the current line
"  let next_line = 0
"  for line_num in sign_lines
"    if line_num > current_line
"      let next_line = line_num
"      break
"    endif
"  endfor
"
"  " If no next sign found, wrap around to the first sign
"  if next_line == 0 && len(sign_lines) > 0
"    let next_line = sign_lines[0]
"  endif
"
"  " Jump to the next sign if found
"  if next_line > 0
"    execute next_line
"    echo "Jumped to sign on line " . next_line
"  else
"    echo "No signs found in buffer"
"  endif
"endfunction
