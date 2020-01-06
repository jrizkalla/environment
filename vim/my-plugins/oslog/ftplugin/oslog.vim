fun! Abbrev()
    
    let cursor_pos = getpos(".")
    
    " remove the first line (header)
    silent! normal! ggdd
    " Abbreviate the time
    silent! %s/\v^\d+-\d+-\d+\s+(\d+):(\d+):(\d+)\.(\d+)(-|\+\d+)?/\2:\3.\4
    " Cut out the thread, PID, and TTL
    silent! %s/\v^(\d+:\d+.\d+\s+)(0x[0-9a-f]+\s+)([a-zA-Z]+\s)\s*(0x[0-9a-f]+\s+\d+\s+\d+\s+)/\1\3
    
    
    " Replace all Default, Debug... with abreviations
    silent! %s/\v^(\d+:\d+.\d+\s+)Default/\1Df
    silent! %s/\v^(\d+:\d+.\d+\s+)Info/\1In
    silent! %s/\v^(\d+:\d+.\d+\s+)Error/\1Er
    silent! %s/\v^(\d+:\d+.\d+\s+)Debug/\1Db
    silent! %s/\v^(\d+:\d+.\d+\s+)Fault/\1Fl
    
    silent! call setpos(".", cursor_pos)
endfun


command! Min :call Abbrev()

" Settings
set nowrap

" Mappings
nnoremap <localleader>m :Min<cr>
