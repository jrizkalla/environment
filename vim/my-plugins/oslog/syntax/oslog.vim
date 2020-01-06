" format: Timestamp Thread Type Activity PID TTL process: (Sender) message
" 
" Note: I have no idea what I'm doing ¯\_(ツ)_/¯
 
" ORDER MATTERS A LOT
 
syntax match LogLine '\v^(\d+-\d+-\d+\s)?(\d+:)?(\d+:\d+\.\d+).*$' transparent contains=LogSender,LogProcess,LogTTL,LogPid,LogActivity,LogType,LogtypeError,LogMessage,LogSelector,LogFunction,LogThread,LogTimestamp


syntax match LogProcess '\v[a-zA-Z](\w|\s|\.)*:?(\[[0-9a-f]+:?[0-9a-f]+\])?' nextgroup=LogSender skipwhite contained
syntax match LogTTL '\v\d+' nextgroup=LogProcess skipwhite contained
syntax match LogPid '\v\d+' nextgroup=LogTTL skipwhite contained
syntax match LogActivity '\v0x[0-9A-Fa-f]+' nextgroup=LogPid skipwhite contained
syntax match LogType '\v\w+' nextgroup=LogProcess,LogActivity skipwhite contained
syntax match LogTypeError '\v(Error)|(Er)|(Fault)|(Fl)' nextgroup=LogProcess,LogActivity skipwhite contained
syntax match LogMessage '.*' contained
"syntax match LogFunction '\v[^\[](\w|\.)*' nextgroup=LogMessage skipwhite contained
syntax match LogSelector '\v((-|\+)?\[[\[\] a-zA-Z0-9_:.#]+\])' nextgroup=LogMessage skipwhite contained
syntax match LogSender '\v\(\w+\)' nextgroup=LogSelector skipwhite contained
syntax match LogThread '\v0x[0-9A-Fa-f]+' nextgroup=LogType,LogTypeError skipwhite contained
syntax match LogTimestamp '\v^(\d+-\d+-\d+\s)?[0-9-:.]*(\+\d+)*' nextgroup=LogThread,LogType,LogTypeError skipwhite contained

syntax match HeaderLine '\v^Timestamp\s+Thread\s+Type\s+Activity\s+PID\s+TTL\s+$'

hi def link LogTimestamp Comment 
hi def link LogThread Comment 
hi def link LogType Comment 
hi def link LogActivity Comment 
hi def link LogPid Comment 
hi def link LogTTL Comment 
hi def link LogProcess Keyword
hi def link LogSender String
hi def link LogSelector Function
hi def link LogFunction Function
hi def link LogTypeError Error

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
