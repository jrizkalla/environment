" ----- Folding {{{
setlocal foldmethod=indent
" Close all folds
setlocal foldlevelstart=0
" }}}

" Keep the 'gutter' visible for YCM
sign define dummy
execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

function! AddIncludeGuards()
    let filename = toupper(expand('%:t'))
    let filename = substitute(filename, '\.', '_', 'g')
    
    " Save the cursor position
    let winview = winsaveview()
    
    silent execute "normal! ggO#ifndef " . filename . "\<cr>#define " . filename . "\<esc>"
    silent execute "normal! Go#endif /* " . filename . " */\<esc>"
    
    call winrestview(winview)
endfunction

function! AddHeader()
    let name = system("id -F")
    " Strop trailing newline
    let name = name[:-2]
    let date = system("date '+%Y/%m/%d'")
    let fname = expand("%:t")
    
    silent execute "normal! ggI//\n//  " . fname . "\n//\n//  Created by " . name . " on " . date . "//\n"
endfunction

command! IncludeGuards call AddIncludeGuards()

" Execute AddIncludeGuards if the current file is a .h or .hpp file
" and empty
if (expand('%:e') ==# 'h' || expand('%:e') ==# 'hpp') && line('$') == 1 && getline(1) == ''
    call AddIncludeGuards()
    call AddHeader()
endif
