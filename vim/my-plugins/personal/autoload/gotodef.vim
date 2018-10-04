let s:header_names = [ "h", "hpp" ]
let s:def_extensions = ["cc", "cpp", "c", "m", "mm" ]

func! gotodef#GoToDef()
    let extension = tolower(expand("%:e"))
    
    let is_header = index(s:header_names, extension) > -1
    if !is_header && index(s:def_extensions, extension) == -1
        " make sure it's actually valid
        echoe "Error: unknown file extension " . extension
        return
    endif
    
    let poss_extensions = []
    if is_header
        let poss_extensions = s:def_extensions
    else
        let poss_extensions = s:header_names
    endif
    
    let fname = expand("%:p:r")
    
    for ext in poss_extensions
        let fullname = fname . "." . ext
        if filereadable(fullname)
            execute "edit " . fullname
            return
        endif
    endfor
    
    echoe "No definition file found for " . fname
endfunc
