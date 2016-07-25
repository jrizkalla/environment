" ----- Folding {{{
setlocal foldmethod=syntax
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

command! IncludeGuards call AddIncludeGuards()

" Execute AddIncludeGuards if the current file is a .h or .hpp file
" and empty
if (expand('%:e') ==# 'h' || expand('%:e') ==# 'hpp') && line('$') == 1 && getline(1) == ''
    call AddIncludeGuards()
endif
