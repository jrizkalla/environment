" Vim syntax file
" Language: output of ls
" Maintainer: John Rizkalla
" Latest Revision: 17 Apr 2016

if exists("b:current_syntax")
    finish
endif

" ----- File line {{{
" The fileline looks like this:
" <permissions> <num of links> <owner> <owner group> <size> <date> <filename>
" Just look for the permissions for a file line
syntax match fileLine /\v^[ld-]([r-][w-][x-]){3}.*$/ 
            \contains=default,filePermissions,linksAndOwner,fileSize,fileDate,fileName

" Filename {{{
" Matches everything an the end. Least priority matching
" dirName  : filenames ending with /
" execName : filenames ending with *
" linkName : filenames ending with @
syntax match fileName /\v.*$/ contained containedin=fileLine 
            \contains=dirName,execName,linkName
syntax match dirName   /\v.*\ze\/$/  contained containedin=fileName
syntax match execName  /\v.*\ze\*$/  contained containedin=fileName
syntax match linkName  /\v.*\ze\@/   contained containedin=fileName
" }}}


" Permissions {{{
syntax match filePermissions /\v^[^ ]*/ contained containedin=fileLine 
            \contains=filePermissionsEmpty,filePermissionsRead
            \,filePermissionsWrite,filePermissionsExecute 
            \nextgroup=linksAndOwner skipwhite
syntax match filePermissionsEmpty    /\v-/  contained containedin=filePermissions
syntax match filePermissionsRead     /\vr/  contained containedin=filePermissions
syntax match filePermissionsWrite    /\vw/  contained containedin=filePermissions
syntax match filePermissionsExecute  /\vx/  contained containedin=filePermissions
" }}}

" Links and the Onwer (and group) {{{
" assumes that the owner and group don't have numbers in them
syntax match linksAndOwner /\v\d+\s+[^ 0-9]+\s+[^ 0-9]+/ contained containedin=fileLine
            \contains=numLinks 
            \nextgroup=fileSize skipwhite
syntax match numLinks /\v\d+/ contained containedin=linksAndOwner
" }}}

" File size {{{
syntax match fileSize /\v[0-9.]+[BKMGTP]/ contained containedin=fileLine
            \contains=fileSizeNum 
            \nextgroup=fileDate skipwhite
syntax match fileSizeNum   /\v[0-9.]+/   contained containedin=fileSize
syntax match fileSizeUnit  /\v[BKMGTP]/  contained containedin=fileSize
" }}}

" Date {{{
syntax match fileDate /\v\d\d?\s+(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+[0-9:]+/ contained containedin=fileLine
            \contains=month 
            \nextgroup=fileName skipwhite
syntax match month /\v(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)/ contained containedin=fileDate
" }}}

" }}}

" ----- Linked File {{{
" Lines that are split from links. They look like <space?> |-> <path>
syntax match linkedFile /\v^\s*\|-\>\s+.*$/ contains=linkSymbol
syntax match linkedDest /\v\/.*$/ contained containedin=linkedFile
syntax match linkSymbol /\v\|-\>/ contained containedin=linkedFile
" }}}

" ----- Links {{{
highlight def link filePermissionsEmpty    Comment
highlight def link filePermissionsRead     Identifier
highlight def link filePermissionsWrite    Function
highlight def link filePermissionsExecute  Exception

highlight def link numLinks Number 

highlight def link fileSizeNum   Number
highlight def link fileSizeUnit  Identifier

highlight def link dirName   Function
highlight def link execName  Keyword
highlight def link linkName  Type

highlight def link linkSymbol Type
highlight def link linkedDest Comment
" }}}
