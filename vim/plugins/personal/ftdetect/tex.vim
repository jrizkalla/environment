augroup latex_file_type
    autocmd!
    autocmd BufRead,BufNewFile *.cls setlocal filetype=tex
    autocmd BufRead,BufNewFile *.tex setlocal filetype=tex
    autocmd FileType plaintex setlocal filetype=tex
augroup end
