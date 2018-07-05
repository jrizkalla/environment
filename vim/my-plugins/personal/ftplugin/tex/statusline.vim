" ----- Status line function {{{
" Vim updates the status_bar after every char inserted in insert mode
" This makes it VERY slow. So to solve this problem, we will stop updating the
" status bar when in insert mode (information will be up to date unless the
" mouse or arrow keys are used)
" We will keep a buffer to use during insert mode and update the buffer during
" normal mode
let g:latex_status_bar_buffer = ""
let g:latex_status_bar_buffer_dirty = 1
let g:latex_status_bar_sensitivity = 5

augroup latex_status_bar
    autocmd!
    autocmd InsertLeave * :let g:latex_status_bar_buffer_dirty = 1
    autocmd CursorMoved * :let g:latex_status_bar_buffer_dirty = 1
augroup end
    
function! Tex_status_line()
    if !g:latex_status_bar_buffer_dirty
        return g:latex_status_bar_buffer
    endif
    
    let info = []
    call add(info, tex#section#Current_section("part"))
    call add(info, tex#section#Current_section("chapter"))
    call add(info, tex#section#Current_section("section"))
    call add(info, tex#section#Current_section("subsection"))
    call add(info, tex#section#Current_section("subsubsection"))
    
    " Create the string: part > chapter > ... >
    let res = ""
    for i in info
        if len(i)
            let res .= i . " > "
        endif
    endfor
    " Remove the trailing ' > '
    if len(res)
        let res = res[:-3]
    else
        let res = " > "
    endif
    
    let g:latex_status_bar_buffer = res
    let g:latex_status_bar_buffer_dirty = 0
    return res
endfunction
" }}}

" ----- Actual status line {{{
setlocal statusline=%1*\ \ 
setlocal statusline+=%.30f%m\ %y
setlocal statusline+=\ %2*\ 
setlocal statusline+=%-30.120{Tex_status_line()}\ %1*
setlocal statusline+=%=
setlocal statusline+=col:\ %-4c
setlocal statusline+=\ \ 
setlocal statusline+=%4l/%-4L
setlocal statusline+=\ \ 
setlocal statusline+=%3p%%
setlocal statusline+=\ \ 
" Some color {{{
highlight User1 ctermfg=231 ctermbg=24 guifg=#FFFFDB  guibg=#004D6B
highlight User2 ctermfg=226 ctermbg=24 guifg=#FFFF00  guibg=#004D6B
" }}}
" }}}
