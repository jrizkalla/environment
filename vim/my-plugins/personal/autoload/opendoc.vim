let g:duckduckgo_lang_modifiers = {
            \ "objc": ["appledev"],
            \ "objcpp": ["appledev"],
            \ "cpp": ["cppr"],
            \ "c": ["cppr"],
            \ }
    
func! opendoc#SearchDuckDuckGo(lookup)
    if !has("python")
        echoe "Error: need vim compiled with python to run"
        return
    endif
    
    python << EOF
    
import sys
is_python3 = sys.version_info.major == 3

if is_python3:
    import urllib.parse
    urlencode = urllib.parse.urlencode
else:
    import urllib
    urlencode = urllib.urlencode

import vim
import webbrowser
    

# is the filename associated with modifiers?
ftype = vim.eval('&filetype')
lang_modifiers = vim.eval("g:duckduckgo_lang_modifiers")
modifiers = lang_modifiers.get(ftype, [])
mod_str = " ".join("!" + m for m in modifiers)

# construct the query
url = "https://duckduckgo.com/?" + urlencode(dict(
        q=vim.eval("a:lookup") + mod_str))
webbrowser.open(url)


EOF
    
endfunc
