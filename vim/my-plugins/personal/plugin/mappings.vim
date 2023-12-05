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
"?inoremap <C-j> <esc>: call Useless_func()<cr>
"?nnoremap <C-j> /<++><cr>4x:noh<cr>

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

nnoremap <leader>/ :BLines<cr>

" Make searches center the text being searched for (so you don't have to look
" for it)
nnoremap n nzv
nnoremap N Nzv
nnoremap * *zv
nnoremap # #zv
nnoremap g* g*zv
nnoremap g# g#zv
" }}}

" ----- Tabs and Windows {{{
" Buffers {{{
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>
" }}}

" Tabs {{{
nnoremap <leader>to :tabedit 
" }}}

" Windows {{{
" Switch between windows
nnoremap <leader>ww :wincmd w<cr>
nnoremap <leader>wk :wincmd k<cr>
nnoremap <leader>wj :wincmd j<cr>
nnoremap <leader>wh :wincmd h<cr>
nnoremap <leader>wl :wincmd l<cr>
nnoremap <leader>ws <c-w><c-r>

if exists('g:vscode')
    nnoremap <C-l> <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
    nnoremap <C-h> <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
    nnoremap <C-k> <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
    nnoremap <C-j> <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
    
    "nnoremap <D-l> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
    "nnoremap <D-h> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
    "nnoremap <D-k> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
    "nnoremap <D-j> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>

    " also, copy the tmux bindings
    nnoremap <C-b>" :split <bar> :wincmd j<CR>
endif

" Close all windows
if exists('g:vscode')
    nnoremap <silent><leader>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>
    nnoremap <silent><leader>wq :call VSCodeCall('workbench.action.files.save')<bar> :call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
    nnoremap <silent><leader>tq <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>

    nnoremap <silent><leader>" <Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<cr>
    nnoremap <silent><leader>% <Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<cr>
else
    nnoremap <leader>% :vsplit<cr>
    nnoremap <leader>" :split<cr>

    nnoremap <silent> <leader>wq :call QuitWithoutSaving('quit!')<cr>
    nnoremap <silent><leader>q :call QuitWithoutSaving('quitall!')<cr>
    nnoremap <silent><leader>tq :call QuitWithoutSaving('tabclose!')<cr>
endif
" }}}
" }}}

" ----- Fixing Vim {{{
" Delete the very annoying 'feature' where Vim deletes
" the tabbed spaces if nothing is typed
" WTF John?
"inoremap <cr> <cr>x<bs>
"nnoremap o ox<bs>
"nnoremap O Ox<bs>

" Make the return key do something useful in normal mode
" Make it actually insert a new line
nnoremap <cr> $a<cr>x<bs><c-c>

" }}}

" ----- Files {{{
" File explorer {{{
nnoremap <silent><leader>ff :Explore<cr>
nnoremap <silent><leader>fl :Lexplore<cr>
nnoremap <silent><leader>ft :tabe %:h<cr>
nnoremap <silent><leader>fv :Vexplore<cr>
nnoremap <silent><leader>fh :Hexplore<cr>
" }}}

" Saving {{{
" This weird buftype thing is for online editing
nnoremap <leader><leader>w :set buftype=<cr>:w<cr>
" }}}

" Open vimrc {{{
nnoremap <leader>src :tabedit ~/.vimrc<cr>:split ~/.vim/plugins/personal<cr>
" }}}

" open header of definition
nnoremap <localleader>t :call gotodef#GoToDef()<cr>

" open file under cursor
nnoremap <leader>o :call openfile#OpenFileUnderCursor()<cr>

" Open FZF
if exists("g:vscode")
    nnoremap <leader><leader> <Cmd>call VSCodeNotify('extension.fuzzySearch')<CR>
else
    nnoremap <leader><leader> :FZF<cr>
endif
nnoremap <leader>h :History<cr>
" }}}

" ----- Buffers {{{
nnoremap <leader>bl :buffers<CR>:buffer<Space>
"  }}}

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

nnoremap <leader>s :set spell!<cr>

" }}}

" ----- Commands {{{
nnoremap <leader>e :exe ""<left>

nnoremap <leader>x :!openproj<cr>

nnoremap <leader>r :redraw!<cr>

nnoremap <leader>c :SwapCase<cr>

" Make it easier to execute move and copy
" by changing the line number (turn off relative)
" when the user enters command line mode
" }}}

" ----- Comments {{{
" This is C-/
nnoremap <silent>  :Comment<cr>
vnoremap <silent>  :Comment<cr>
" }}}

" ----- Vim is not for the weak {{{
inoremap <left>    <nop>
inoremap <right>   <nop>
inoremap <up>      <nop>
inoremap <down>    <nop>
nnoremap <left>    <nop>
nnoremap <right>   <nop>
nnoremap <up>      <nop>
nnoremap <down>    <nop>

" }}}

" ----- Plugins {{{
if exists(":GitGutterLineHighlightsToggle")
    nnoremap <leader>d :GitGutterLineHighlightsToggle<cr>
endif
"  }}}


" ----- Autocompletion {{{
if exists('g:vscode')
    nnoremap <silent>K <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
    nnoremap <silent>gd <Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>
    nnoremap <silent>gy <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
    nnoremap <silent>gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
    nnoremap <silent>gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

    nnoremap <silent><C-[> <Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>
else
    " TODO: move here
    nnoremap  K :call <SID>show_documentation()<CR>
    nnoremap t <Plug>(coc-float-jump)
    nnoremap gd <Plug>(coc-definition)
    nnoremap gy <Plug>(coc-type-definition)
    nnoremap gi <Plug>(coc-implementation)
    nnoremap gr <Plug>(coc-references)

    function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
    endfunction
endif
"  }}}


" ----- Folds {{{
if exists('g:vscode')
    nnoremap <silent>zc <Cmd>call VSCodeNotify('editor.fold')<CR>
    nnoremap <silent>zo <Cmd>call VSCodeNotify('editor.unfold')<CR>
    nnoremap <silent>za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>

    nnoremap <silent>zC <Cmd>call VSCodeNotify('editor.foldAll')<CR>
    nnoremap <silent>zO <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
endif
"  }}}

nnoremap <leader>k :call opendoc#SearchDuckDuckGo(expand("<cword>"))<cr>
