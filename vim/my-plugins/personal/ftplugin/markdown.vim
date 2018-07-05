" ----- Syntax {{{


syntax region markdownInlineCode start=/\v`/ skip=+\v\\+ end=/\v`/
syntax region markdownCode start=/\v```/ skip=+\v\\+ end=/\v```/

highlight link markdownInlineCode String
highlight link markdownCode String

syntax match markdownHeader "\v^#+.*$"
hi link markdownHeader Error
" }}}
 
" ----- Settings {{{
set spell
set linebreak " Wrap at word boundaries

setlocal background=light
colorscheme scheakur

if exists(":SoftPencil")
    SoftPencil
endif

" Automatic saving
augroup markdown
  autocmd!
  autocmd TextChanged * w
  autocmd InsertLeave * w
augroup END

" }}}
