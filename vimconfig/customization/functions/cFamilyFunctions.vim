
if (exists("g:loaded_cfam_fn"))
    finish
endif

"echo "Loading C Family functions"
let g:loaded_cfam_fn = "yes"

" Write a function to open the 'other' file
" If the file is a .cc,.cpp,.C,.CPP,.cp,.cxx it open filename.h
" If the fiename is .h it opens one of filename.{cc,cpp,C,CPP,cp,cxx} (the
" first one that exists)
"

let g:CFamily_OpenFileMatch_createNew = 1
function! CFamily_OpenFileMatch()
   let fileInfo = split(@%, '\.')
   let fileName = fileInfo[0]
   let fileExtension = fileInfo[1]
   let altFileExt = ""
   if fileExtension ==# 'cc' || fileExtension ==# 'cpp' || 
           \fileExtension ==? 'C' || fileExtension ==# 'CPP' || 
           \fileExtension ==# 'cp' || fileExtension ==# 'cxx'
       " That's the easy part. Just open filename.h
       exe 'vsplit ' . fileName . '.h'
   else
       " This is a bit harder because it can be any one of the extensions mentioned above
       if filereadable(fileName . '.cc')
           exe 'vsplit ' . fileName . '.cc'
       elseif filereadable(fileName . '.cpp')
           exe 'vsplit ' . fileName . '.cpp'
       elseif filereadable(fileName . '.C')
           exe 'vsplit ' . fileName . '.C'
       elseif filereadable(fileName . '.c') " c file
           exe 'vsplit ' . fileName . '.c'
       elseif filereadable(fileName . '.cp')
           exe 'vsplit ' . fileName . '.cp'
       elseif filereadable(fileName . '.cxx')
           exe 'vsplit ' . fileName . '.cxx'
       elseif filereadable(fileName . '.CPP')
           exe 'vsplit ' . fileName . '.CPP'
       else
           " We need to create the file. Is the filetype c or cpp?
           if (g:CFamily_OpenFileMatch_createNew)
               if &filetype ==# 'cpp'
                   exe 'vsplit ' . fileName . ".cpp"
               elseif &filetype ==# 'c'
                   exe 'vsplit ' . fileType . '.c'
               endif
           endif
       endif
   endif
endfunction


function! CFamily_OpenAll()
   let allFiles = split(globpath('.', '*.h'), '\n')

   let oldValue = g:CFamily_OpenFileMatch_createNew
   g:CFamily_OpenFileMatch_createNew = 0

   for file in allFiles
       exe 'tabedit ' . file
       " And open the other file
       let fileName = '.' . split(file, '\.')[0] . '.cc'
       if filereadable(fileName)
           exe 'vsplit ' . fileName
       endif
   endfor

   " close the first tab
   exe 'tabfirst'
   exe 'q'

   "g:CFamily_OpenFileMatch_createNew = oldValue
endfunction

function! CFamily_Create_for_loop(varName)
    let varType = "int "
    let varName = ""
    if a:varName ==# ""
        call inputsave()
        let varName = input("Variable name: ")

        if len(split(varName)) > 1 " name and type
            let lst = split(varName)
            let varType = join(lst[0:len(lst)-2], ' ') . ' '
            let varName = lst[len(lst)-1]
        endif

        call inputrestore()
    else
        varName = a:varName
    endif

    call inputsave()
    let rangeInput = input("Range (separated by ... or ..<): ")
    call inputrestore()

    let firstNum = 0
    let lastNum = 0
    let rangeType = ""

    if len(split(rangeInput, '\.\.\.')) == 2
        let lst = split(rangeInput, '\.\.\.')
        let firstNum = substitute(lst[0], '^\s*\(.\{-}\)\s*$', '\1', '') " Remove whitespace
        let lastNum =  substitute(lst[1], '^\s*\(.\{-}\)\s*$', '\1', '')
        let rangeType='<='
    elseif len(split(rangeInput, '\.\.<')) == 2
        let lst = split(rangeInput, '\.\.<')
        let firstNum = substitute(lst[0], '^\s*\(.\{-}\)\s*$', '\1', '') " Remove whitespace
        let lastNum =  substitute(lst[1], '^\s*\(.\{-}\)\s*$', '\1', '')
        let rangeType = "<"
    else
        echoe "Error. Range must be 2 numbers separated by ... or ..<"
    endif
    
    execute 'normal! ofor(' . varType . varName . ' = ' . firstNum . '; ' . varName . ' ' . rangeType . ' ' . lastNum . '; ' . varName . "++)" . 
                \"{\<cr>x\<cr>}<++>\<esc>ka\<bs>"
endfunction


" Returns the name of the current class or empty string if there is no class
function! CFamily_Current_class ()
    let winview = winsaveview()

    let curLine = line('.')
    let curCol = col('.')

    " Go to the first class <something>
    let [lineNo, col] = searchpos('class.\+{', "bW")
    if lineNo == 0 
        call winrestview(winview)
        return ""
    endif

    " does the class end before my current position?
    call searchpos("{", "W")
    execute "normal! %"
    let endLine = line('.')
    let endCol = col('.')

    if endLine < curLine || (endLine == curLine && endCol < curCol)
        call winrestview(winview)
        return ""
    endif
    
    " Get the class name and return it
    call cursor(lineNo, col)
    let line = split(getline('.'))
    let i = 0
    while i < len(line)
        if line[i] ==# "class"
            if i == len(line) - 1
                call winrestview(winview)
                return ""
            else
                call winrestview(winview)
                return line[i+1]
            endif
        endif
        let i += 1
    endwhile
endfunction

function! CFamily_Current_function()
    let winview = winsaveview()
    
    let curLine = line('.')
    let curCol = col('.')
    
    " Go to the last function call
    let [lineNo, col] = searchpos(' *[^ ]\+ *[^ ]\+ *([^()]*) *{.*', "bW")
    if lineNo == 0
        call winrestview(winview)
        return ""
    endif

    " Look for the matching end of the function
    call searchpos('{', "W")
    " Go to the matching }
    execute "normal! %"
    if line('.') == lineNo && col('.') == col
        " No matching }
    endif
    
    let endLine = line('.')
    let endCol = col('.')

    if endLine < curLine || (endLine == curLine && endCol < curCol)
        call winrestview(winview)
        return ""
    endif
    
    "Get the function name
    call cursor(lineNo, col)
    let line = split(getline('.'), "(")
    call winrestview(winview)
    let line = split(line[0])
    return line[1]
endfunction
