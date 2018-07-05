
" Make vim wrap words rather than cut them in the middle
setlocal linebreak linebreak

set spell " Turn on spell check

" ----- Appearance {{{
setlocal background=light
colorscheme pencil

if has("gui_running")
    " Change the font
    setlocal guifont=Menlo:h11
endif
" }}}

" ----- Some commands {{{
command! CurrentSec     echo latex#section#Current_section("section")
command! CurrentSub     echo latex#section#Current_section("subsection")
command! CurrentSubSub  echo latex#section#Current_section("subsubsection")

" Automatic saving
augroup markdown
  autocmd!
  autocmd TextChanged * w
  autocmd InsertLeave * w
autocmd END

" }}}
