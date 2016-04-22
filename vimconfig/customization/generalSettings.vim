
set autoread 						" Automatically read from a file when it changes on disk

" set clipboard=unnamed				" Make vim use the system clipboard

set number

set nocompatible                    " Make vim uncompatible with old vi

colorscheme monokai                 " Set the color to. Other subscripts (like latexSettings.vim) can change it
"colorscheme xcode-midnight
if has("gui_running")
    set guifont=Monaco:h11
    
    " Make the window as big as possible
    set lines=999
    set columns=999
endif
    

filetype indent on                  " Enable file-type specific indentation

syntax on                           " Enable syntax highlighting 

set autoindent

set ignorecase
set smartcase

" Place at least 10 lines at the bottom or on top of the cursor
set scrolloff=10

" Disable sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
autocmd! GUIEnter * set vb t_vb=

set laststatus=2                    " Keep the status line shown
set statusline=\ \ 
set statusline+=%.30f%m%r\ %y
set statusline+=\ \ 
set statusline+=branch:\ %{fugitive#statusline()}
set statusline+=\ \ 
set statusline+=Char:\ %3b\ -\ 0x%-3B
set statusline+=%=
set statusline+=col:\ %-4c
set statusline+=\ \ 
set statusline+=%4l/%-4L
set statusline+=\ \ 
set statusline+=%3p%%
set statusline+=\ \ 

" Replace the tab with 4 spaces
set tabstop=4
set shiftwidth=4 " For indentation
set expandtab

set cursorline " Hightlight the line the cursor is on

" Highlight all results and highlight next result while typing
:set hlsearch incsearch


set shiftround  " Make indent a multiple of shiftwidth


" Set line numbering to relative in normal mode and absolute in insert mode
set relativenumber
set number
:augroup line_numbering
:   autocmd!
:   autocmd InsertEnter * :set norelativenumber
:   autocmd InsertEnter * :set number
:   autocmd InsertLeave * :set relativenumber
:augroup end

:augroup search_highlighting
:   autocmd!
:   autocmd InsertEnter * :noh
:augroup end

" Create a command to reload the vimrc
command! Reloadrc execute "normal! :source $MYVIMRC\<cr> :filetype detect\<cr>"

let g:smartusline_string_to_highlight = '(%n) %f '

" Autocomplete with tab
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    if &filetype ==# "css"
      return "\<c-x>\<c-o>"
    else
      return "\<C-N>"
    endif
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

:set dictionary="/usr/dict/words"



" Functions
"
" Quits the current buffer it is a saved file or if it is a buffer without a
" file
" And reports an error otherwise
" Returns 1 if it quit and 0 if it didn't
function! QuitWithoutSaving(quitCommand)
   " Is the current buffer a real file?
   if filereadable(bufname("%"))
       " Is it saved?
       if &modified
           echoerr "Cannot quit file with unsaved changes"
           return 0
       endif
   endif
   " Quit
   exe a:quitCommand
   return 1
endfunction

" If I don't press a key for a while in insert mode, place me in normal mode
" :augroup insert_mode
" :   autocmd!
" :   autocmd CursorHoldI :normal jk
" :augroup END
" 
" YCM Options
" Explicitly control which files to turn YCM for
"let g:ycm_filetype_whitelist = {
"            \ "cpp": 1,
"            \ "c": 0,
"            \ "vim": 1,
"            \ "javascript": 1}
            
            
 " For assembly file (ARM assembly)
 let asmsyntax='armasm'
 let filetype_inc='armasm'
 
 
 " Hard-time:
let g:hardtime_timeout=500
let g:hardtime_maxcount=1
let g:hardtime_allow_different_key = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>", "w", "e", "b"]
let g:hardtime_ignore_quickfix = 0
let g:hardtime_ignore_buffer_patterns = []

" Move
let g:move_key_modifier = 'D'

" Close all folds
set foldlevelstart=0
" A column that indicates whether something is folded or not
set foldcolumn=1 
