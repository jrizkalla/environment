" Make K access the python docs
nnoremap <silent> K :execute "! pydoc \"" . expand("<cword>") . "\""<cr>
