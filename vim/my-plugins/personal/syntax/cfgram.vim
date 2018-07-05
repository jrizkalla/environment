if exists("b:current_syntax")
    finish
endif

syn match cfgTerminal '\v(<[A-Z_]+>|[^A-Za-z ])'

syn match cfgRuleStart '^:'
syn match cfgSubsStart '^='

syn match cfgComment '\v^\s*#.*$'

syn match cfgTransition '->'


hi link cfgComment Comment
hi link cfgTransition Keyword
hi link cfgRuleStart Keyword
hi link cfgSubsStart Keyword
hi link cfgTerminal String
