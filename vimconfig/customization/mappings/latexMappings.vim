" word count mapping
nnoremap <localleader>wc :VimtexWordCount<cr>

function! LaTeX_Mapping_return()
    if col('.') == col('$')-1
        let itemType = LaTeX_insert_item()
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


" The x<BS> is to make sure Vim does not remove indentation
inoremap <CR> <esc>: call LaTeX_Mapping_return()<cr>
nnoremap <CR>      : execute "normal! o" . LaTeX_insert_item()<cr>
inoremap <S-CR> <cr>

inoremap <D-e> \emph{}<++><esc>ba
inoremap <D-i> \it{}<++><esc>ba
inoremap <D-u> \und{}<++><esc>ba

nnoremap <localleader>r :call LaTeX_create_env("")<cr>

nnoremap <localleader>i : call LaTeX_create_env("itemize")<cr>
nnoremap <localleader>e : call LaTeX_create_env("enumerate")<cr>
nnoremap <localleader>d : call LaTeX_create_env("description")<cr>

nnoremap <localleader>s : call LaTeX_Create_section("")<cr>

" Map the " to either `` or ''
inoremap " x<bs><c-c>: execute "normal! a" . LaTeX_Type_of_quotes() . "\<c-v><c-c>"<cr>a

" Operator mappings
 
 
