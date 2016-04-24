" ----- Env_in_line {{{
" Returns the environment in line (a:line)
function! tex#environment#Env_in_line(env, line)
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
" }}}

" ----- Create_env {{{
" Create environment with a:envName

function! tex#environment#Create_env(envName)
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
" }}}

" ----- Current_env {{{
" Get the current environment
function! tex#environment#Current_env()
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
        let startName = tex#environment#Env_in_line("begin", line)

        call cursor(line, 1)

        " Look for the next end startName
        let endLine = tex#environment#Find_end(startName, line)
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
" }}}

" ----- Find_end {{{
" Finds the end line of an environment
function! tex#environment#Find_end(envName, startLine)
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
" }}}
