function! CamelToSnake(word)
    return substitute(a:word, "^\\@![A-Z]\\C", "_\\l\\0", "g")
endfunction

function! SnakeToCamel(word)
    return substitute(a:word, "_\\([a-z]\\)\\C", "\\u\\1", "g")
endfunction!

function! IsSnake(word)
    return match(a:word, "_\\([a-z]\\)") != -1
endfunction

function! SwapCase(word)
    if IsSnake(a:word)
        return SnakeToCamel(a:word)
    else
        return CamelToSnake(a:word)
    endif
endfunction!

function! SwapCaseUnderCursor()
    let word = SwapCase(expand("<cword>"))
    execute "normal! ciw" . l:word . "\<esc>"
endfunction!

command! SwapCase call SwapCaseUnderCursor()
