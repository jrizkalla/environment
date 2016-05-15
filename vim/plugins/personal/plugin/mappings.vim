let mapleader = " "
let maplocalleader = ","


" ----- Moving around {{{
"  jk {{{
" Map the jk keys
inoremap jk <esc>:noh<cr>
" and since I tend to keep the shift key pressed while pressing jk...
inoremap Jk <esc>:noh<cr>
inoremap jK <esc>:noh<cr>
inoremap JK <esc>:noh<cr>
" }}}
 
" <++> {{{
function! Useless_func()
    execute "normal! /<++>\<cr>4x:noh\<cr>"
    if col('.') == (col('$')-1)
        startinsert!
    else
        startinsert
    endif
endfunction

inoremap <D-j> <esc>: call Useless_func()<cr>
nnoremap <D-j> /<++><cr>4x:noh<cr>
" And for vim on terminal (or Linux)
inoremap <C-j> <esc>: call Useless_func()<cr>
nnoremap <C-j> /<++><cr>4x:noh<cr>

vnoremap <D-j> /<++><cr>4x:noh<cr>
inoremap <D-J> <++>
nnoremap <D-J> i<++>
vnoremap <D-J> i<++>
nnoremap + a<++><esc>
" }}}

" ` and ' {{{
" Switch ` and ' around because ` is more usefule but ' is easier to reach
nnoremap ' `
nnoremap ` '
" }}}
"  }}}
  
" ----- Searching {{{
nnoremap / /\v
nnoremap ? ?\v
" }}}

" ----- Tabs and Windows {{{
" Buffers {{{
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>
" }}}

" Tabs {{{
nnoremap <leader>to :tabedit 
nnoremap <leader>tq :call QuitWithoutSaving('tabclose!')<cr>
" }}}

" Windows {{{
nnoremap <leader>wov :vsplit 
nnoremap <leader>woh :split 
" Switch between windows
nnoremap <leader>ww :wincmd w<cr>
nnoremap <leader>wk :wincmd k<cr>
nnoremap <leader>wj :wincmd j<cr>
nnoremap <leader>wh :wincmd h<cr>
nnoremap <leader>wl :wincmd l<cr>
nnoremap <leader>wq :call QuitWithoutSaving('quit!')<cr>
nnoremap <leader>ws <c-w><c-r>

" Close all windows
nnoremap <leader>q :call QuitWithoutSaving('quitall!')<cr>
" }}}
" }}}
 
" ----- Fixing Vim {{{
" Delete the very annoying 'feature' where Vim deletes
" the tabbed spaces if nothing is typed
inoremap <cr> <cr>x<bs>
nnoremap o ox<bs>
nnoremap O Ox<bs>

" Make the return key do something useful in normal mode
" Make it actually insert a new line
nnoremap <cr> $a<cr>x<bs><c-c>

" }}}
 
" ----- Files {{{
" File explorer (NerdTree) {{{
nnoremap <leader>ls  :NERDTreeToggle<cr>
nnoremap <leader>tls :tabe %:h<cr>
nnoremap <leader>vls :Vexplore<cr>
nnoremap <leader>hls :Hexplore<cr>
" }}}

" Saving {{{
" This weird buftype thing is for online editing
nnoremap <leader><leader>w :set buftype=<cr>:w<cr>
" }}}

" Open vimrc {{{
nnoremap <leader>src :tabedit ~/.vimrc<cr>:split ~/.vim/plugins/personal<cr>
" }}}
" }}}
 
" ----- Copying {{{
" Copy and paste to system clipboard {{{
nnoremap <leader>y "+y
nnoremap <leader>p "+p
" }}}

" Copy and paste between sessions (via a temp file) {{{
vmap <C-c> :w! ~/.vbuf<CR>
nnoremap <C-c> :.w! ~/.vbuf<CR>
nnoremap <C-p> :r ~/.vbuf<CR>
" }}}
" }}}
 
" ----- Editing {{{
nnoremap <leader>c 0d$
" }}}
 
" ----- Commands {{{
nnoremap <leader>e :exe ""<left>

" Make it easier to execute move and copy 
" by changing the line number (turn off relative)
" when the user enters command line mode
" {{{
" Note: for some reason I don't understand, `cnoremap <esc>` breaks the arrow
" keys behaviour in command line mode
nnoremap : :set norelativenumber<cr>:
cnoremap <silent> <cr> <cr>:set relativenumber<cr>
cnoremap <silent> <c-c> <c-c>:set relativenumber<cr>
" }}}
" }}}

" ----- Vim is not for the weak {{{
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>

inoremap <esc> <nop>
" }}}
