
nnoremap <localleader>if oif(){<cr><++><cr>}<++><esc>kkba
nnoremap <localleader>eif oif(){<cr><++><cr>} else {<cr><++><cr>}<++><esc>4kba
nnoremap <localleader>for :call CFamily_Create_for_loop("")<cr>

" Map my amazing first vimscript function :)
nnoremap <buffer><localleader>o :call CFamily_OpenFileMatch()<cr>
" inoremap <buffer>; ;<esc>:w<cr> very bad idea
