"function cljstyle#fix()
"    let cwd = getcwd()
"    let winsave = winsaveview()
"    execute "cd" . expand('%:p:h')
"
"    :%!cljstyle pipe
"
"    execute "cd" . cwd
"    call winrestview(winsave)
"endfunction
"
"" Example shortcut to fix the current file
"nnoremap <leader>cs :call cljstyle#fix()<cr>
