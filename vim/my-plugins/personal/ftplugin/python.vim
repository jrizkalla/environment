" Make K access the python docs
"nnoremap <silent> K :execute \"! pydoc \"" . expand("<cword>") . \"\""<cr>

nnoremap <localleader>d obreakpoint()<esc>

set colorcolumn=79

set foldmethod=indent
