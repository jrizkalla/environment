if !has('python')
  echoerr "SourceKittenDaemon.vim requires Vim compiled with +python"
  finish
endif

let s:plug = expand('<sfile>:p:h:h')
let s:python_version = 'python '
let s:pyfile_version = 'pyfile '

augroup sourcekittendaemon_complete
  autocmd!
  autocmd CompleteDone *.swift call s:CompletionFinished(v:completed_item)
augroup END

function! s:LoadPythonScript()
  if exists("s:loaded_sourcekittendaemon_python") && s:loaded_sourcekittendaemon_python
    return
  endif
  let s:loaded_sourcekittendaemon_python = 1

  let l:script = s:plug . "/pythonx/sourcekittendaemon.py"
  execute s:python_version . 'import sys'
  execute s:python_version . 'sys.path.append("' . s:plug . '")'
  execute s:pyfile_version . l:script
  execute s:python_version . 'source_kitten_daemon_vim = SourceKittenDaemonVim()'
endfunction

function! s:GetByteOfLastDot()
  let line = line2byte(line("."))
"?  let col = col('.')
  let col = strridx(getline("."), expand("<cword>"))
  return line + col
endfunction

function! s:CompletionFinished(item)
"  let word = a:item["word"]
"  if word !~ "("
"    return
"  endif
"
"  let [lnum, col] = searchpos("(", "bn", line("."))
"  call cursor(lnum, col + 1)
endfunction

function! s:ColOfCursorWord()
    let saved_pos = getpos('.')
    " If the current char is a part of a word (alphabet, digit, or _)
    " go back to the beggining of the word, otherwise, start a new one
    let curr_char = getline('.')[col('.') - 2]
    echom "curr_char is '" . curr_char . "'"
    if (curr_char >= '0' && curr_char <= '9')
                \ || (curr_char >= 'a' && curr_char <= 'z')
                \ || (curr_char >= 'A' && curr_char <= 'Z')
                \ || curr_char == '_'
        normal! "hb"
    endif
    
    let cursor_pos = col('.')
    
    call setpos('.', saved_pos)
    return cursor_pos - 1
endfunction

function! sourcekittendaemon#Complete(findstart, base)
  if a:findstart
    let col = s:ColOfCursorWord()
    echom "col is " . col
    return col
"?    return col('.')
  endif

  update
  call s:LoadPythonScript()
  echom "prefix is '" . a:base . "'"
  let offset = line2byte(line('.')) + col('.')
  execute "python source_kitten_daemon_vim.complete(lineno = " . line('.')
        \ . " , prefix = '" . a:base
        \ . "', path = '" . expand("%:p")
        \ . "', offset = " . s:GetByteOfLastDot() . ")"
  return s:result
endfunction
