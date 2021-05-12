" === Statusline ==============================================================

if exists('g:skyline_status') && !g:skyline_status
    finish
endif

let s:light  = skyline#light
let s:dark   = skyline#dark
let s:nlight = skyline#ndark
let s:blue   = skyline#blue
let s:yellow = skyline#yellow

call skyline#hi("StatusLine",   s:light,  s:dark)
call skyline#hi("StatusLineNC", s:blue,   s:dark)
call skyline#hi("Mode",         s:dark,   s:blue)
call skyline#hi("Dirty",        s:yellow, s:dark)
call skyline#hi("Start",        s:blue,   s:blue)

" =============================================================================

" Note: %0* changes the colour to the StatusLine group.
" This is preferred because when the buffer is inactive, it switches to using
" the StatusLineNC group, allowing us to easily set different colours for
" when the buffer is active/inactive.

" Start
set statusline =

" Indicate start of current buf's statusline, if buffer is active
set statusline +=%#Start#
set statusline +=%{skyline#check_active()}

" Shows current file name + modified status
set statusline +=%#Dirty#                     " change color to dirty indicator
set statusline +=%{skyline#check_dirtybuf()}  " set dirty indicator
set statusline +=\ %0*                        " change back to primary color
set statusline +=%f                           " filename

" = Middle =
set statusline +=%=  " Alignment

" Shows line:column
set statusline +=/
set statusline +=\ %l:%c

" Shows file type
set statusline +=\ /
set statusline +=\ %Y

" Current mode
set statusline +=\ %#Mode#                  " Mode color
set statusline +=%{skyline#current_mode()}  " Show mode

" End
set statusline +=%*

