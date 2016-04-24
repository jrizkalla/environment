function! tex#item#Insert_item()
    let env = tex#environment#Current_env()
    if env ==# "itemize" || env ==# "enumerate"
        return '\item '
    elseif env ==# "description"
        return "\\item[]<++>\<esc>4ha"
    else
        return "x\<BS>"
    endif
endfunction
