" format: Timestamp Thread Type Activity PID TTL process: (Sender) message
 
" ORDER MATTERS A LOT
syntax match LogSender '\v\(\w+\)' nextgroup=LogSelector skipwhite
syntax match LogProcess '\v\w+\:' nextgroup=LogSender skipwhite
syntax match LogTTL '\v\d+' nextgroup=LogProcess skipwhite
syntax match LogPid '\v\d+' nextgroup=LogTTL skipwhite
syntax match LogActivity '\v0x[0-9A-Fa-f]+' nextgroup=LogPid skipwhite
syntax match LogType '\v\w+' nextgroup=LogActivity skipwhite
syntax match LogTypeError 'Error' nextgroup=LogActivity skipwhite
syntax match LogMessage '.*'
syntax match LogSelector '\v(-|\+)?\[[\[\] a-zA-Z0-9_:.]+\]' nextgroup=LogSelector skipwhite
syntax match LogThread '\v0x[0-9A-Fa-f]+' nextgroup=LogType,LogTypeError skipwhite
syntax match LogTimestamp '\v^\d+-\d+-\d+\s[0-9-:.]*' nextgroup=LogThread skipwhite

hi def link LogTimestamp Comment 
hi def link LogThread Comment 
hi def link LogType Comment 
hi def link LogActivity Comment 
hi def link LogPid Comment 
hi def link LogTTL Comment 
hi def link LogProcess Keyword
hi def link LogSender String
hi def link LogSelector Function
hi def link LogTypeError Error

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
