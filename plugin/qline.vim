" Plugin:      https://github.com/quintik/qline.vim
" Description: Yet another lightweight statusline/tabline for vim.
" Maintainer:  quintik <https://github.com/quintik>

if exists('g:loaded_qline') || &cp
    finish
endif
let g:loaded_qline = '0.1.0'

let s:light     = qline#color.light
let s:dark      = qline#color.dark
let s:secondary = qline#color.secondary
let s:primary   = qline#color.primary
let s:dirty     = qline#color.dirty

" === StatusLine ==============================================================
if exists('g:qline_status') && !g:qline_status
    finish
endif

call qline#hi("StatusLine",   s:light,   s:dark)
call qline#hi("StatusLineNC", s:primary, s:dark)
call qline#hi("Mode",         s:dark,    s:primary)
call qline#hi("Mode",         s:dark,    s:primary)
call qline#hi("Dirty",        s:dirty,   s:dark)
call qline#hi("Start",        s:primary, s:primary)

" Note: %0* changes the colour to the StatusLine group.
" This is preferred over custom highlight groups because
" when the buffer is inactive, it switches to using the StatusLineNC group,
" allowing us to easily set different colours for when the buffer is
" active/inactive.

" === Start
set statusline =

" Indicate start of current buf's statusline, if buffer is active
set statusline +=%#Start#
set statusline +=%{qline#check_active()}

" Shows current file name + modified status
set statusline +=%#Dirty#                   " change color to dirty indicator
set statusline +=%{qline#check_dirtybuf()}  " set dirty indicator
set statusline +=\ %0*                      " change back to primary color
set statusline +=%f                         " filename

" Alignment
set statusline +=%=

" Shows line:column
set statusline +=/
set statusline +=\ %l:%c

" Shows file type
set statusline +=\ /
set statusline +=\ %Y

" Current mode
set statusline +=\ %#Mode#                " Mode color
set statusline +=%{qline#current_mode()}  " Show mode

set statusline +=%*
" === End

" === TabLine =================================================================
if exists('g:qline_tab') && !g:qline_tab
    finish
endif

call qline#hi("TabLine",    s:light, s:dark)
call qline#hi("CurrentBuf", s:dark,  s:primary)
call qline#hi("CurrentTab", s:dark,  s:primary)

" === Start
set tabline =

" Current buffer
set tabline +=%#CurrentBuf#            " current buffer colour
set tabline +=\ %{qline#get_curbuf()}  " active buffer

" Remaining buffers
set tabline +=\ %#TabLine#                    " back to primary tabline colour
set tabline +=\ %{qline#get_remainingbufs()}  " remaining buffers
set tabline +=%<                              " truncate if too many buffers

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

set tabline +=\ %*
" === End

