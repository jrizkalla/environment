" ----- Current_section {{{
" If section is:
"   - part          : returns the text inside the last \part{}
"   - chapter       : returns the text inside the last \chapter{}
"   - section       : returns the text inside the last \section{}
"   - subsection    : returns the text inside the last \subsection{}
"   - subsubsection : returns the text inside the last \subsubsection{}
function! tex#section#Current_section(section)
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

    return tex#environment#Env_in_line(titles[currentPos], positions[currentPos])
endfunction
" }}}

" ----- Create_section {{{
" Creates a section defined by sectionLevel. If
" sectionLevel is 0, it asks for input from the user
function! tex#section#Create_section(sectionLevel)
    let sectionLevel = a:sectionLevel

    call inputsave()
    if a:sectionLevel == 0
        let sectionLevel = input("Section level (1-5): ")
    endif
    call inputrestore()

    let sectionText = ""
    if sectionLevel == 1
        let sectionText = '\part{}<++>'
    elseif sectionLevel == 2
        let sectionText = '\chapter{}<++>'
    elseif sectionLevel == 3
        let sectionText = '\section{}<++>'
    elseif sectionLevel == 4
        let sectionText = '\subsection{}<++>'
    elseif sectionLevel == 5
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
" }}}
