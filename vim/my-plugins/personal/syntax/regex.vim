if exists("b:current_syntax")
    finish
endif

syn match regexElem '*'
syn match regexElem '+'
syn match regexElem '!'
syn match regexElem '?'
syn match regexElem '\.'

syn region regexCharList start='\[' end='\]'

syn match regexSet '\\[ep]'
syn match regexCharset '\\[sdlwE]'
syn match regexCtrl '\\[Cc]'
syn match regexEscape '\v\\([\\|.+*!?()]|\[|\])'

syn match regexUnion '|'

syn region regexTokenType start='||' end='\n'
syn match regexErrorToken '\v\|\|\s*\|\s*\n'

" The empty language followed by a token type is essentially a NOP
" So highlight it as a comment
syn match regexComment '\v^\\p\|\|.*$'

hi link regexElem Keyword
hi link regexUnion Operator

hi link regexCtrl Conditional
hi link regexCharlist String
hi link regexCharset String
hi link regexSet String

hi link regexErrorToken function

hi link regexTokenType Identifier

hi link regexComment Comment
