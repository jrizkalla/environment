autocmd InsertEnter * :q!

silent! g/\v^[ld-]([r-][w-][x-]){3}.*\@\s+-\>/exec "norm! ^" . '/\v\@\s+\zs-\>' . "\<cr>i\<cr>|\<esc>>>"
