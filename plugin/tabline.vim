" === Tabline =================================================================

if exists('g:qline_tab') && !g:qline_tab
    finish
endif

let s:light   = qline#color.light
let s:dark    = qline#color.dark
let s:primary = qline#color.primary

call qline#hi("TabLine",    s:light, s:dark)
call qline#hi("CurrentBuf", s:dark,  s:primary)
call qline#hi("CurrentTab", s:dark,  s:primary)

" =============================================================================

" Start
set tabline =

" Current buffer
set tabline +=%#CurrentBuf#              " current buffer colour
set tabline +=\ %{qline#get_curbuf()}

" Remaining buffers
set tabline +=\ %#TabLine#                      " back to primary tabline colour
set tabline +=\ %{qline#get_remainingbufs()}  " remaining buffers
set tabline +=%<                                " truncate if too many buffers

" Alignment
set tabline +=%=

" Buf/Tab text
set tabline +=Bufs
set tabline +=\ │
set tabline +=\ Tabs

" Remaining tabs
set tabline +=\ %{qline#get_remainingtabs()}  " remaining tabs' numbers

" Current tab
set tabline +=%#CurrentTab#     " current tab colour
set tabline +=\ %{tabpagenr()}  " current tab number

" End
set tabline +=\ %*

