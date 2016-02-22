" Load the mappings
source ~/.vim/customization/mappings/latexMappings.vim

" Make vim wrap words rather than cut them in the middle
setlocal linebreak linebreak

set spell " Turn on spell check

" Set the color scheme
set background=light
colorscheme scheakur

if has("gui_running")
    " Change the font
    set guifont=Menlo:h11
endif

command! Currentsec echo LaTeX_Current_section("section")
command! Currentsub echo LaTeX_Current_section("subsection")
command! Currentsubsub echo LaTeX_Current_section("subsubsection")


let g:latex_status_bar_buffer = "no"
let g:latex_status_bar_string = ""
let g:latex_status_bar_sensitivity = 5


" Vim updates the status_bar after every char inserted in insert mode
" This makes it VERY slow. So to solve this problem, we will stop updating the
" status bar when in insert mode (information will be up to date unless the
" mouse or arrow keys are used)
" We will keep a buffer to use during insert mode and update the buffer during
" normal mode
augroup latex_status_bar
    autocmd!
    autocmd InsertEnter * :let g:latex_status_bar_buffer = "yes"
    autocmd InsertLeave * :let g:latex_status_bar_buffer = "no"
augroup end

function! LaTeX_section_status_line()
    if g:latex_status_bar_buffer ==# "yes"
        return g:latex_status_bar_string
    endif
        
    let sec = LaTeX_Current_section("section")
    let subsec = LaTeX_Current_section("subsection")
    let subsubsec = LaTeX_Current_section("subsubsection")
    let env = LaTeX_Current_Env()

    let res = sec
    if subsec ==# "" && subsubsec ==# "" && env ==# ""
        let g:latex_status_bar_string = res
        return res
    endif
    let res .= " > " . subsec
    if subsubsec ==# "" && env ==# ""
        let g:latex_status_bar_string = res
        return res
    endif
    
    let res .= " > " . subsubsec
    if env ==# ""
        let g:latex_status_bar_string = res
        return res
    endif
    
    let res .= " > " . env
    let g:latex_status_bar_string = res
    return res
endfunction


" Status line
" Redo the whole status line for LaTeX
set statusline=%1*\ \ 
set statusline+=%.30f%m\ %y
set statusline+=\ %2*\ 
set statusline+=%-30{LaTeX_section_status_line()}\ %1*
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
