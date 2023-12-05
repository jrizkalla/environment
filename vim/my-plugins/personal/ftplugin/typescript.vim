set tabstop=2
set shiftwidth=2

function GetComponentFiles()
    let dir = expand('%:h') . "/"
    let fl = expand('%:t')

    let basefl = join(split(fl, '\.')[:-2], '.')

    let tsfl = dir . basefl . '.ts'
    let htmlfl = dir . basefl . '.html'
    let scssfl = dir . basefl . '.scss'

    return [tsfl, htmlfl, scssfl]
endfunction

" True if it's a .component.ts file and also has a component.html and a
" component.scsss file in the same dir
function IsAngularComponentFile()
    let fl = expand('%:t')

    if split(fl, '\.')[-2] != "component"
        return 0
    endif

    " find all 3 files
    let [tsfl, htmlfl, scssfl] = GetComponentFiles()
    return filereadable(tsfl) && filereadable(htmlfl) && filereadable(scssfl)
endfunction


" Setup the current window so that all 3 angular files are open
function OpenComponentParts()
    let [tsfl, htmlfl, scssfl] = GetComponentFiles()

    execute "edit " . htmlfl
    execute "split " . tsfl
    execute "normal! \<C-W>\<C-j>"
    execute "vsplit " . scssfl
endfunction

function OpenComponentPartsIfAngularFile()
    if !IsAngularComponentFile()
        return
    endif

    call OpenComponentParts()
endfunction


nnoremap <localleader>o :call OpenComponentPartsIfAngularFile()<CR>
