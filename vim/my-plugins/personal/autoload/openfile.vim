

function! s:IsAllowed(char)
    if a:char ==# "." || a:char ==# "/" || a:char ==# "-" || a:char ==# "_" || a:char ==# " "
        return 1
    endif
    
    if (a:char >= 'a' && a:char <= 'z') || (a:char >= 'A' && a:char <= 'Z') || (a:char >= '0' && a:char <= '9')
        return 1
    endif
    
    return 0
endfunction

function! openfile#GetFileUnderCursor()
    let line = getline(".")
    let colidx = col(".") - 1
    
    if !s:IsAllowed(line[colidx])
        echoe "No file found under cursor"
        return ""
    endif
    
    " Go left until we hit a weird character or the beginning of the line
    let startidx = colidx
    while startidx > 0
        if s:IsAllowed(line[startidx-1])
            let startidx -= 1
        else
            break
        endif
    endwhile
    
    " Find the end index in the same way
    let endidx = colidx
    while endidx < len(line)-1
        if s:IsAllowed(line[endidx+1])
            let endidx += 1
        else
            break
        endif
    endwhile
    
    let fname = line[startidx:endidx]
    " remove leading and trailing spaces
    let fname = substitute(fname, '^\v\s*(.{-})\s*$', '\1', '')
    return fname
endfunction

function! openfile#OpenFileUnderCursor()
    let fname = openfile#GetFileUnderCursor()
    if fname == ""
        return
    endif
    
    execute "tabedit " . fname
endfunction
