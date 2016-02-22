" Precondition: a backspace is already executed before this function is called
function! SmartBackspace (numSpacesPerTab)
    " Look back numSpacesPerTab and if they're all spaces delete them
    let line = getline('.')
    let pos = col('.') - 1
    let numSpaces = 0

    while numSpaces < (a:numSpacesPerTab - 1)
        if pos >= 0 && line[pos] ==# ' '
            " go on
        else
            if col('.') == (col('$')-1)
                startinsert!
            else
                execute "normal! l"
                startinsert
            endif
            return 1
        endif

        let pos -= 1
        let numSpaces += 1
    endwhile
    " Delete numSpacesPerTab chars
    execute "normal! " . (a:numSpacesPerTab - 1) . "h" . (a:numSpacesPerTab - 1) . "x"
    if col('.') == (col('$')-1) " end of line
        startinsert!
    elseif col('.') == 1
        startinsert
    else
        execute "normal! l"
        startinsert
    endif
    return a:numSpacesPerTab
endfunction
