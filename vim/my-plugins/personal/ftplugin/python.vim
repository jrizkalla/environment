" Make K access the python docs
nnoremap <silent> K :execute "! pydoc \"" . expand("<cword>") . "\""<cr>

nnoremap <localleader>d oimport pdb; pdb.set_trace()<esc>

set colorcolumn=79
