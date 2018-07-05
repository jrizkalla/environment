"" word count mapping
nnoremap <silent> <buffer> <localleader>wc :VimtexWordCount<cr>

" ----- <CR> mappings {{{
function! Tex_mapping_return()
    if col('.') == col('$')-1
        let itemType = tex#item#Insert_item()
        execute 'normal! o' . itemType . "\<esc>"
        if itemType ==# '\item ' || itemType ==# "x\<BS>"
            startinsert!
        else
            startinsert
        endif
    else
        execute "normal! a\<cr>\<esc>"
        startinsert
    endif
endfunction

inoremap <silent> <buffer> <cr> <esc>:call Tex_mapping_return()<cr>
nnoremap <silent> <buffer> <cr>      :execute "normal! o" . tex#item#Insert_item()<cr>
inoremap <silent> <buffer> <s-cr> <cr>
nnoremap <silent> <buffer> <s-cr> ox<bs>

" }}}

" ----- Insert mode mappings {{{

" Command key for MacVim {{{
inoremap <silent> <buffer> <D-e> \emph{}<++><esc>ba
inoremap <silent> <buffer> <D-i> \it{}<++><esc>ba
inoremap <silent> <buffer> <D-u> \und{}<++><esc>ba
" }}}

" Control key for regular Vim {{{
inoremap <silent> <buffer> <C-e> \emph{}<++><esc>ba
"inoremap <silent> <buffer> <C-i> \it{}<++><esc>ba
inoremap <silent> <buffer> <C-u> \und{}<++><esc>ba
" }}}

" Map the " to either `` or ''
inoremap <silent> <buffer> " x<bs><c-c>: execute "normal! a" . tex#quotes#Type_of_quotes() . "\<c-v><c-c>"<cr>a
" }}}

" ----- Create stuff {{{
" environments {{{
nnoremap <silent> <buffer> <localleader>r :call tex#environment#Create_env("")<cr>
      
nnoremap <silent> <buffer> <localleader>i : call tex#environment#Create_env("itemize")<cr>
nnoremap <silent> <buffer> <localleader>e : call tex#environment#Create_env("enumerate")<cr>
nnoremap <silent> <buffer> <localleader>d : call tex#environment#Create_env("description")<cr>
" }}}

" Sections {{{
nnoremap <silent> <buffer> <localleader>s : call tex#environment#Create_section("")<cr>
" }}}
" }}}
