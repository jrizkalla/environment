
" ----- Folding {{{
setlocal foldmethod=syntax
" Close all folds
setlocal foldlevelstart=0
" }}}

" Keep the 'gutter' visible for YCM
sign define dummy
execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
