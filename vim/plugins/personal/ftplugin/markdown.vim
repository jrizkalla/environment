" ----- Syntax {{{


syntax region markdownInlineCode start=/\v`/ skip=+\v\\+ end=/\v`/
syntax region markdownCode start=/\v```/ skip=+\v\\+ end=/\v```/

highlight link markdownInlineCode String
highlight link markdownCode String

syntax match markdownHeader "\v^#+.*$"
hi link markdownHeader Error
" }}}
