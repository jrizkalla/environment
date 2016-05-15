" A very simple plugin
" manager.
" 
" The difference between this and other plugin managers
" is that this one does not get the plugins from GitHub
" which gives the user the freedom to install the plugin
" however he/she wants

function! LoadPlugin(plugin_name)
    " Add $HOME/plugins/plugin_name to runtime path
     
    let &runtimepath .= "," . $HOME . "/.vim/plugins/" . a:plugin_name
endfunction

command! -nargs=1 Plugin call LoadPlugin(<args>)
