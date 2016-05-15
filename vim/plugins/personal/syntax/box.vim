if exists("b:current_syntax")
    finish
endif

" Anything after \ {{{
syntax match BoxCtorName "\v\\[a-zA-z]+" nextgroup=BoxCtorArgs skipwhite
syntax match BoxKeyword "\\class"
syntax match BoxVarInit "\\let" nextgroup=BoxLHS
" }}}
 
syntax region BoxBlock start="{" end="}" fold transparent contains=BoxKeyword,BoxCtorName,BoxBlock
 
syntax match BoxObj "\v\h+" nextgroup=BoxCtorArgs
syntax match BoxLHS "\v\h[a-zA-Z0-9]* *\=" nextgroup=BoxNum,BoxObj,BoxStr skipwhite

" Ctor {{{
syntax region BoxCtorArgs start="(" end=")" transparent contains=BoxLHS,BoxNum,BoxStr
" }}}
 
" Values {{{
syntax match BoxNum "\v(0x)?\d+(\.\d*)? *(em|px|pt|\%|cm|mm|m|ft|in)?"
syntax region BoxStr start='"' end='"' skip='\\'
" }}}
 
" Comments
syntax match BoxComment "\v#.*$"

highlight link BoxCtorName Identifier
highlight link BoxKeyword Keyword
highlight link BoxVarInit Keyword
highlight link BoxNum Number
highlight link BoxObj Structure
highlight link BoxStr String
highlight link BoxComment Comment

"highlight link BoxCtorArg Statement
"highlight link BoxCtorArgs Error
