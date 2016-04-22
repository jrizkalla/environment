set foldmethod=syntax
let g:cfam_status_bar_buffer = "no"
let g:cfam_status_bar_string = ""

augroup cfam_status_bar
    autocmd!
    autocmd InsertEnter * :let g:cfam_status_bar_buffer = "yes"
    autocmd InsertLeave * :let g:cfam_status_bar_buffer = "no"
augroup end

function! CFamily_place_status_line()
    if g:cfam_status_bar_buffer ==# "yes"
        return g:cfam_status_bar_string
    endif
    
    let class = CFamily_Current_class()
    let func =  CFamily_Current_function()

    let res = ""
    if class ==# ""
    else
        let res .= class . "::"
    endif
    
    if func ==# ""
    else
        let res .= func
    endif
    
    return res
endfunction

" Status line
" Redo the whole status line for c
set statusline=%1*\ \ 
set statusline+=%.30f%m\ %y
set statusline+=\ \ 
set statusline+=branch:\ %-20{fugitive#statusline()}
set statusline+=\ %2*\ 
"set statusline+=%-30{CFamily_place_status_line()}\ %1*
set statusline+=%=
set statusline+=col:\ %-4c
set statusline+=\ \ 
set statusline+=%4l/%-4L
set statusline+=\ \ 
set statusline+=%3p%%
set statusline+=\ \ 
" And some color...
hi User1 guifg=#FFFFDB  guibg=#004D6B
hi User2 guifg=#FFFF00  guibg=#004D6B

" Keep the 'gutter' visible for YCM
sign define dummy
execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
