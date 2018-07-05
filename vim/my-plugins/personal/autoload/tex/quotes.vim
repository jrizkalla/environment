" Returns the type of quotes to be inserted (`` or '')
function! tex#quotes#Type_of_quotes()
    " Look for the previous ``
    let lineNo = line('.')
    let colNo = col('.')
    let winview = winsaveview()

    let retValue = ""

    let [line, col] = searchpos('``', "bWc")
    if line == 0
        let retValue = '``'
    else
        " Find the next ''
        let [line, col] = searchpos("''", "Wc")
        if line == 0
            let retValue = "''"
        elseif (line == lineNo && col > colNo) || line > lineNo
            let retValue = "''"
        else
            let retValue = '``'
        endif
    endif

    call winrestview(winview)
    return retValue
endfunction
