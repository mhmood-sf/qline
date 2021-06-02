" === qline ==============================================================

if exists('g:qline_status') && !g:qline_status
    finish
endif

let s:light     = qline#color.light
let s:dark      = qline#color.dark
let s:secondary = qline#color.secondary
let s:primary   = qline#color.primary
let s:dirty     = qline#color.dirty

call qline#hi("StatusLine",   s:light,   s:dark)
call qline#hi("StatusLineNC", s:primary, s:dark)
call qline#hi("Mode",         s:dark,    s:primary)
call qline#hi("Dirty",        s:dirty,   s:dark)
call qline#hi("Start",        s:primary, s:primary)

" =============================================================================

" Note: %0* changes the colour to the StatusLine group.
" This is preferred because when the buffer is inactive, it switches to using
" the StatusLineNC group, allowing us to easily set different colours for
" when the buffer is active/inactive.

" Start
set statusline =

" Indicate start of current buf's statusline, if buffer is active
set statusline +=%#Start#
set statusline +=%{qline#check_active()}

" Shows current file name + modified status
set statusline +=%#Dirty#                     " change color to dirty indicator
set statusline +=%{qline#check_dirtybuf()}  " set dirty indicator
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
set statusline +=%{qline#current_mode()}  " Show mode

" End
set statusline +=%*

