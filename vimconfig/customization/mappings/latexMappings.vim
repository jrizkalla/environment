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
inoremap <buffer> <CR> <esc>: call LaTeX_Mapping_return()<cr>
nnoremap <buffer> <CR>      : execute "normal! o" . LaTeX_insert_item()<cr>
inoremap <buffer> <S-CR> <cr>

inoremap <buffer> <D-e> \emph{}<++><esc>ba
inoremap <buffer> <D-i> \it{}<++><esc>ba
inoremap <buffer> <D-u> \und{}<++><esc>ba
"inoremap <buffer> <C-e> \emph{}<++><esc>ba
"inoremap <buffer> <C-i> \it{}<++><esc>ba
"inoremap <buffer> <C-u> \und{}<++><esc>ba
       
nnoremap <buffer> <localleader>r :call LaTeX_create_env("")<cr>
      
nnoremap <buffer> <localleader>i : call LaTeX_create_env("itemize")<cr>
nnoremap <buffer> <localleader>e : call LaTeX_create_env("enumerate")<cr>
nnoremap <buffer> <localleader>d : call LaTeX_create_env("description")<cr>
     
nnoremap <buffer> <localleader>s : call LaTeX_Create_section("")<cr>

" Map the " to either `` or ''
inoremap <buffer> " x<bs><c-c>: execute "normal! a" . LaTeX_Type_of_quotes() . "\<c-v><c-c>"<cr>a

" Operator mappings
 
 
