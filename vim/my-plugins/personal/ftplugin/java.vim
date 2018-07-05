set foldmethod=syntax

function! CreateGettersAndSetters()
    let curr_line = getline('.')
    
    let split_by_equal = split(curr_line, "=")
    let var_name = ""
    let split_by_space = split(split_by_equal[0], " ")
    let var_name = split_by_space[-1]
    
    let var_name = split(var_name, ";")[0]
    
    let cmd_str = "norm! o**\nGet " . var_name . "\n@param " . var_name + " get " . var_name
    let cmd_str += "\n*/\nget" . var_name . "() {\nreturn " . var_name . ";\n}\n"
    echo cmd_str
endfunction

iabbrev system System
