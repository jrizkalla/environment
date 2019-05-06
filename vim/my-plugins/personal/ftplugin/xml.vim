function! ConvertPlistToJson()
    let curr_file = expand("%:p")
    enew
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    
    
    exec '%! plutil -convert json -r -o - ' . curr_file
    exec '%! python3 -m json.tool'
    
    setlocal ft=json
    
    nnoremap <localleader>c :bprevious<CR>
endfunction

noremap <silent><localleader>c :call ConvertPlistToJson()<CR>
