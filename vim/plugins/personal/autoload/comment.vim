if !exists("g:comment_strings")
    " Create the default one
    " Note: comments without a delim are marked with ? to 
    " identify them from normal comments
    " Comments like /* */ are not because they can't be nesed
    let g:comment_string = {
                \"vim"        : ['"?'],
                \"c"          : ["//?"],
                \"c++"        : ["//?" ],
                \"ld"         : ["/*", "*/"],
                \"css"        : ["/*", "*/"],
                \"css"        : ["/*", "*/"],
                \"scss"       : ["//?"],
                \"python"     : ["#?"],
                \"javascript" : ["//?"],
                \"tex"        : ["%?"],
                \"plaintex"   : ["%?"],
            \}
endif

function! comment#ToggleComment() range
    let orig_pos = getcurpos()
    let line = a:firstline
    while line <= a:lastline
        " Place the cursor on this line
        call setpos('.', [orig_pos[0], line, 0, 0])
        call comment#ToggleCommentLine()
        let line += 1
    endwhile
    call setpos('.', orig_pos)
endfunction

function! comment#ToggleCommentLine()
    let file = &ft
    
    if !has_key(g:comment_string, file)
        echoe "Error: I don't know how to comment '" . file . "' files. Try adding an entry to g:comment_string_extra"
    endif
    
    let comment_sym = g:comment_string[file]
    
    " Is the start sym the first thing on this line?
    let line_split = split(getline("."), ' ')
    
    if len(line_split) == 0 || 
                \len(line_split[0]) < len(comment_sym[0]) ||
                \line_split[0][0:len(comment_sym[0])-1] !=# comment_sym[0]
        " The line is not commented.
        let put_comment = "normal! I" . comment_sym[0]
        if len(comment_sym) > 1
            let put_comment .= "\<esc>A" . comment_sym[1]
        endif
        execute put_comment
    else
        " Remove the comment
        let rem_comment = "normal! ^" . len(comment_sym[0]) . "x"
        if len(comment_sym) > 1
            let rem_comment .= "g_" . (len(comment_sym[1])-1) . "h" . len(comment_sym[1]) . "x"
        endif
        execute rem_comment
    endif
endfunction
