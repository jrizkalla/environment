

let g:smartusline_string_to_highlight = '(%n) %f '



" Functions
"

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
 
 

" Move
let g:move_key_modifier = 'D'
