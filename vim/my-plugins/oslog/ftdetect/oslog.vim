fun! SetFtIfFileIsOsLog()
    let firstline = getbufline("%", 1)
    if len(firstline) == 0
        return
    endif
    let firstline = firstline[0]
    echom "first line is " . firstline
    
    echom "Match1: " . match(firstline, '\v^Timestamp\s+Thread\s+Type\s+Activity\s+PID\s+TTL')
    echom "Match2: " . match(firstline, '\v^Timestamp\s+Ty\s+Process\[PID:TID\]')
    if (match(firstline, '\v^Timestamp\s+Thread\s+Type\s+Activity\s+PID\s+TTL') >= 0 || match(firstline, '\v^Timestamp\s+Ty\s+Process\[PID:TID\]') >= 0) " abbreviated output
        set filetype=oslog
    endif
    
endfun
"
augroup oslog
    autocmd!
    "autocmd BufNewFile,BufRead *.log :set filetype=oslog
    autocmd StdinReadPost * call SetFtIfFileIsOsLog()
augroup END
