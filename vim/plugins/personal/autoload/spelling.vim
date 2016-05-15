
if !exists("g:spelling_search_directory")
    let g:spelling_search_directory = $HOME . '/.vim/'
endif
if !exists("g:default_spelling_file")
    let g:default_spelling_file = g:spelling_search_directory . "spelling.txt"
endif

func! spelling#LoadSpellingAbbrevs()
    " Look for file spelling_search_directory for spelling*.txt
    let files = split(globpath(g:spelling_search_directory, 'spelling*.txt'), '\n')
    
    for file in files
        " The format of the file looks like this:
        " <wrong word> <correction>
        " So just parse it and create the iabbrevs 
        
        let lines = readfile(file)
        for line in lines
            let words = split(line, ' ')
            if len(words) != 2
                " Invalid, report an errotu
                echoe "Invalid spelling file. Unable to parse: " . line
                return
            endif
            
            execute "inoreabbrev " . words[0] . " " . words[1]
        endfor
    endfor
endfunc

func! spelling#CreateAbbrev(wrong_word, right_word)
    if len(a:wrong_word) == 0 || len(a:right_word) == 0 | return | endif
    
    " Append it to the file...
    let fn = g:default_spelling_file
    " Don't complain if the file can't be opened
    silent! call writefile(add(readfile(fn), a:wrong_word . " " . a:right_word), fn)
    
    " And create the abbreviation
    execute "inoreabbrev " . a:wrong_word . " " . a:right_word
endfunc
