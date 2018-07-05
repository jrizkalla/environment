" Color key:
" User1 is for filename. It is controlled by a helper function
" User2 is for flags (like readonly)
" User3 is for gitbranch. It is controlled by a helper function
 
" ----- Settings {{{
set laststatus=2                    " Keep the status line shown
let g:statusline_filename_modified_color   = "cterm=bold ctermfg=226 ctermbg=30 guifg=#ffff00 guibg=#008787"
let g:statusline_filename_unmodified_color = "cterm=NONE ctermfg=255 ctermbg=30 guifg=#eeeeee guibg=#008787"

let g:statusline_git_dirty_color = "cterm=bold ctermfg=184 ctermbg=30 guifg=#dfdf00 guibg=#008787"
let g:statusline_git_clean_color = "cterm=bold ctermfg=255 ctermbg=30 guifg=#eeeeee guibg=#008787"
" }}}

" ----- Helper functions {{{
" filename {{{
function! Statusline_filename()
    " Return '<filename> ' if it's not modified
    " And    '<filename>+' if it is
    " Also change the color of User1
    if &modified 
        execute "highlight User1 " . g:statusline_filename_modified_color
        redraw
        return @% . '+'
    else
        execute "highlight User1 " . g:statusline_filename_unmodified_color
        redraw
        return @% . ' '
endfunction
" }}}

" gitbranch {{{
let g:statusline_gitbranch_buffer = ""
augroup statusline_gitbranch
    autocmd!
    autocmd FocusGained * let g:statusline_gitbranch_buffer = ""
augroup end
    
function! Statusline_gitbranch()
    " We don't really need to check the git branch every
    " time the status line is updated...
    " We can just do it every time focus is gained
    " 
    " Note: for this to work with tmux, tmux-plugins/vim-tmux-focus-events
    " has to be installed
    
    if len(g:statusline_gitbranch_buffer)
        return g:statusline_gitbranch_buffer
    else
        " Figure out the branch...
        let branch = system("git rev-parse --abbrev-ref HEAD 2>/dev/null")
        let branch = "[" . branch[:-2] . "]"
        if v:shell_error 
            execute "highlight User3 " . g:statusline_git_clean_color
            let g:statusline_gitbranch_buffer = " " " Avoid rerunning
            return " "
        endif
        
        " Is it clean?
        let clean = system("git status --porcelain")
        if v:shell_error 
            execute "highlight User3 " . g:statusline_git_clean_color
            let g:statusline_gitbranch_buffer = " " " Avoid rerunning
            return " "
        endif
        if len(clean)
            " Dirty
            execute "highlight User3 " . g:statusline_git_dirty_color
        else
            execute "highlight User3 " . g:statusline_git_clean_color
        endif
        
        " Return the branch name
        let g:statusline_gitbranch_buffer = branch
        return branch
    endif
endfunction
" }}}
" }}}

" ----- Actual statusline {{{
set statusline=\ \ 
set statusline+=%n:\ %1*%.30{Statusline_filename()}%*%2*%r%*%y
set statusline+=\ %3*%.30{Statusline_gitbranch()}%*
set statusline+=\ \ 
set statusline+=Char:\ %3b\ -\ 0x%-3B
set statusline+=%=
set statusline+=col:\ %-4c
set statusline+=\ \ 
set statusline+=%4l/%-4L
set statusline+=\ \ 
set statusline+=%3p%%
set statusline+=\ \ 

" Color {{{
highlight Statusline ctermfg=255 ctermbg=30 guifg=#eeeeee guibg=#008787
highlight User2 cterm=bold ctermfg=22 ctermbg=30 gui=bold guifg=#005f00 guibg=#008787
" }}}
" }}}
