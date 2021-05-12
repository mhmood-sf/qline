" === Tabline =================================================================

if exists('g:skyline_tab') && !g:skyline_tab
    finish
endif

let s:light = skyline#light
let s:dark  = skyline#dark
let s:blue  = skyline#blue

call skyline#hi("TabLine",    s:light, s:dark)
call skyline#hi("CurrentBuf", s:dark,  s:blue)
call skyline#hi("CurrentTab", s:dark,  s:blue)

" =============================================================================

" Start
set tabline =

" Current buffer
set tabline +=%#CurrentBuf#              " current buffer colour
set tabline +=\ %{skyline#get_curbuf()}

" Remaining buffers
set tabline +=\ %#TabLine#                      " back to primary tabline colour
set tabline +=\ %{skyline#get_remainingbufs()}  " remaining buffers
set tabline +=%<                                " truncate if too many buffers

" Alignment
set tabline +=%=

" Buf/Tab text
set tabline +=Bufs
set tabline +=\ │
set tabline +=\ Tabs

" Remaining tabs
set tabline +=\ %{skyline#get_remainingtabs()}  " remaining tabs' numbers

" Current tab
set tabline +=%#CurrentTab#     " current tab colour
set tabline +=\ %{tabpagenr()}  " current tab number

" End
set tabline +=\ %*

