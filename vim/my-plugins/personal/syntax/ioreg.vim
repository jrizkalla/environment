"syntax match ioregId0 '\v^(\+-o|\|)'
"syntax match ioregId1 '\v^.{2}(\+-o|\|)'
"syntax match ioregId2 '\v^.{4}(\+-o|\|)'
"syntax match ioregId3 '\v^.{6}(\+-o|\|)'
"syntax match ioregId4 '\v^.{8}(\+-o|\|)'
"syntax match ioregId5 '\v^.{10}(\+-o|\|)'
"syntax match ioregId6 '\v^.{12}(\+-o|\|)'
"syntax match ioregId7 '\v^.{14}(\+-o|\|)'
"syntax match ioregId8 '\v^.{16}(\+-o|\|)'
"syntax match ioregId9 '\v^.{18}(\+-o|\|)'
"syntax match ioregId10 '\v^.{20}(\+-o|\|)'
"
"" TODO: remove highlighting from here
"hi ioregId0 ctermfg=228
"hi ioregId1 ctermfg=227
"hi ioregId2 ctermfg=226
"hi ioregId3 ctermfg=154
"hi ioregId4 ctermfg=155
"hi ioregId5 ctermfg=156
"hi ioregId6 ctermfg=157
"hi ioregId7 ctermfg=118
"hi ioregId8 ctermfg=119
"hi ioregId9 ctermfg=120
"
"
"let indent_level = 0
"while indent_level < 50
"    
"    exec 'syntax match ioregId' . indent_level . " '\v^.{" . (indent_level*2) . "}(\+-o|\|)'"
"    exec 'hi ioregId' . indent_level . ' ctermfg=' . (indent_level+200)
"    
"    let indent_level += 1
"endwhile


syntax match ChildCol '\v^[ \|]*' nextgroup=ioregId contained
syntax match ChildCol2 '\v^[ \|]*\ze[^+]'

let indent_level=0
let all_names=[]
while indent_level < 50
    exec "syntax match ioregId" . indent_level . " '\\v^[ \\|]{" . (indent_level*2) . "}\\+-o' oneline contains=ChildCol nextgroup=ServiceName"
    exec 'hi ioregId' . indent_level . ' ctermfg=' . (indent_level+200)
    
    let indent_level += 1
    
    let all_names += [ "ioregId" . indent_level ]
endwhile

"exec "syntax cluster ioregId contains=" . join(all_names, ",")


"?syntax match ServiceName '\v[a-zA-Z,0-9]+'

syntax region Properties start="{" end="}" transparent contains=Properties,ChildCol2,KVP

syntax match KVP '\v\"[^\"]*\" \= .*$' contained contains=Key
syntax match Key '\v\"[^\"]*\"\ze \=' contained


hi link ChildCol Comment
hi link ChildCol2 Comment

hi link ServiceName Keyword
hi link Key Function
