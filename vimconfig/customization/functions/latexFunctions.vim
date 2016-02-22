if (exists("g:loaded_latex_fn"))
    finish
endif

"echom "Loading LaTeX functions"
let g:loaded_latex_fn = "yes"


function! LaTeX_create_env(envName)
    call inputsave()
    let envName = ""
    if a:envName ==# ""
        let envName = input("Environment: " )
    else
        let envName = a:envName
    endif
    call inputrestore()

    let textToInsert = "\<cr>"
    if envName ==# "itemize" || envName ==# "enumerate"
        let textToInsert = "\\item \<cr>"
    elseif envName ==# "description"
        let textToInsert = ''
    endif
    execute 'normal! o\begin{' . envName . '}' . "\<cr>x\<bs>" . textToInsert . '\end{' . envName . '}<++>' . "\<esc>k$"
endfunction

function! LaTeX_env_in(env, line)
    let lst = split(getline(a:line), '\\' . a:env)
    let i = 0
    while i < len(lst)
        let str = lst[i]
        if str[0] ==# '{'
            let nameWithGarb = str[1:] " Now we need to remove everything after the }
            return split(nameWithGarb, "}")[0]
        endif
        let i += 1
    endwhile
endfunction

function! LaTeX_Find_End(envName, startLine)
    let winview = winsaveview()

    " Go to start line
    call cursor(a:startLine, 10000)

    " Look for the next begin or end envName
    let numEndingsNeeded = 1

    let lineContainingEnd = a:startLine
    while 1
        let [line, col] = searchpos('\\\(begin\|end\){' . a:envName . '}', "W")
        if line <= 0
            break
        endif

        " Is this line a begin or end?
        if len(split(getline('.'), "begin")) > 1 
            let numEndingsNeeded += 1
        else
            let numEndingsNeeded -= 1
        endif

        if numEndingsNeeded == 0
            let lineContainingEnd = line('.')
            break
        endif
    endwhile

    call winrestview(winview)
    return lineContainingEnd
endfunction

" I don't know why but echo LaTeX_Current_Env() does not work so
function! LaTeX_Current_Env()
    " set the cursor position
    let winview = winsaveview()
    " Move to the end of the line
    execute "normal $"

    let cursorPos = line('.')

    let env = ""
    " look for the previous \begin{}
    while 1
        let [line, col] = searchpos('\\begin{.\+}', "bW")
        if line == 0 " Not in an environment
            break
        endif
        let startName = LaTeX_env_in("begin", line)

        call cursor(line, 1)

        " Look for the next end startName 
        let endLine = LaTeX_Find_End(startName, line)
        if endLine > cursorPos || endLine == line
            " Match found
            let env = startName
            break
        else
            " look for the next one
            " Go to the line containing the environment that starts and closes
            " and look again
            call cursor(line, 1)
        endif
    endwhile

    call winrestview(winview)
    return env
endfunction

function! LaTeX_insert_item()
    let env = LaTeX_Current_Env()
    if env ==# "itemize" || env ==# "enumerate"
        return '\item '
    elseif env ==# "description"
        return "\\item[]<++>\<esc>4ha"
    else
        return "x\<BS>"
    endif
endfunction


function! LaTeX_Create_section(sectionLevel)
    let sectionLevel = a:sectionLevel

    call inputsave()
    if a:sectionLevel == 0
        let sectionLevel = input("Section level (1-3): ")
    endif
    call inputrestore()

    let sectionText = ""
    if sectionLevel == 1
        let sectionText = '\section{}<++>'
    elseif sectionLevel == 2
        let sectionText = '\subsection{}<++>'
    elseif sectionLevel == 3
        let sectionText = '\subsubsection{}<++>'
    elseif sectionLevel ==# ''
        " Cancel. Do nothing
        return
    else
        echoe "Unrecognized section level " . sectionLevel
        return 0
    endif

    execute 'normal! o' . sectionText . "\<esc>bl"
    startinsert
    return 1
endfunction

function! LaTeX_Current_section(section)
    " Searc for the previous part, chapter, section, subsection, and
    " subsubsection
    let [partLine, col] = searchpos('\\part{.\+}', "nbW")
    let [chapLine, col] = searchpos('\\chapter{.\+}', "nbW")
    let [secLine, col] = searchpos('\\section{.\+}', "nbW")
    let [subsecLine, col] = searchpos('\\subsection{.\+}', "nbW")
    let [subsubsecLine, col] = searchpos('\\subsubsection{.\+}', "nbW")

    let titles = ["part", "chapter", "section", "subsection", "subsubsection"]
    let positions = [partLine, chapLine, secLine, subsecLine, subsubsecLine]

    let currentPos = 0
    if a:section ==# "part"
        let currentPos = 0
    elseif a:section ==# "chapter"
        let currentPos = 1
    elseif a:section ==# "section"
        let currentPos = 2
    elseif a:section ==# "subsection"
        let currentPos = 3
    elseif a:section ==# "subsubsection"
        let currentPos = 4
    else
        echoe "Unrecognized section " . a:section
    endif

    " If something higher in order comes after something lower in order (i.e.
    " a section comes after a subsection), then the subsection is considered
    " empty
    if positions[currentPos] == 0
        return ""
    endif

    " Check all positions above it
    let i  = currentPos - 1
    while i >= 0 
        if positions[i] != 0 && positions[i] > positions[currentPos]
            return ""
        endif
        let i -= 1 
    endwhile

    return LaTeX_env_in(titles[currentPos], positions[currentPos])
endfunction

" Returns the type of quotes to be inserted (`` or '')
function! LaTeX_Type_of_quotes()
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


function! LaTeX_GetTree()
    " Process the whole document line by line and create a tree of
    " environments
    " A node is an array with the first element being the environment name and
    " the following elements being the children
   
    execute "normal! gg" 
    
    " Sections are also considered
    
    let root = []
    " Look for \begin{document} and make it the root. If it does not exist
    " return an error
    let [line, col] = searchpos('\\begin{document}')
    if line == 0
        echoe "Missing begin document"
    endif
    
    let root = ["begin", "document"]
    let currentNote = root
    
    while 1
        " Look for the next \section, \subsection, \subsubsection, or \begin
        let [line, col] = searchpos('\\' .
                                \ '\(part\)\|' .
                                \ '\(chapter\)\|' .
                                \ '\(section\)\|' .
                                \ '\(subsection\)\|' .
                                \ '\(subsubsection\)\|' .
                                \ '\(begin\)' .
                                \ '{.\+}', 'W')
        if line == 0
            break
        endif
        
        let line = getline('.')[col:]
        let type = split(line, '{')[0]

        " Add it to the currentNode
        
    endwhile
endfunction
