" === qline ===================================================================

let qline#colorschemes = {
        \ "nord": #{
            \ dark:    "#282828", light:     "#FFFFFF",
            \ primary: "#81a1c1", secondary: "#2e3440",
            \ dirty:   "#ebcb8b" },
        \ "onedark": #{
            \ dark:    "#282828", light:     "#FFFFFF",
            \ primary: "#e5c07b", secondary: "#61afef",
            \ dirty:   "#61afef" }
        \ }

if !exists("qline#color")
    let qline#color = qline#colorschemes["onedark"]
endif

" Helper method to set fg and bg
function! qline#hi(group, guifg, guibg)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=" . a:guibg
  endif
endfunction

" Returns formatted current buffer name:
" [x] <buffer>
function! qline#get_curbuf() abort
    let l:curbuf = bufnr()
    for buf in getbufinfo()
        if buf.bufnr == l:curbuf
            return '[' . buf.bufnr . '] ' . fnamemodify(buf.name, ':t')
        endif
    endfor
endfunction

" Returns formatted string showing non-active buffers:
" [x] <buffer1> | [y] <buffer2> | [z] <buffer3>
function! qline#get_remainingbufs() abort
    let l:curbuf = bufnr()
    let l:buflist = []
    for buf in getbufinfo()
        if buf.bufnr == l:curbuf
            continue
        elseif buf.listed
            let l:name = '[' . buf.bufnr . '] ' . fnamemodify(buf.name, ':t')
            call add(l:buflist, l:name)
        endif
    endfor
    return join(l:buflist, ' | ')
endfunction

" Returns formatted string showing non-active tabs:
" x | y | z
function! qline#get_remainingtabs() abort
    let l:tablist = []
    for tab in gettabinfo()
        if tab.tabnr == tabpagenr()
            continue
        else
            let l:tabnr = tab.tabnr
            call add(l:tablist, l:tabnr)
        endif
    endfor

    if len(l:tablist)
        return ' ' . join(l:tablist, ' | ') . ' '
    else
        return ''
    endif
endfunction

" Expand current mode
let s:currentmode={
      \ 'n' : 'Normal',   'no' : 'N·Operator Pending', 'v' : 'Visual',
      \ 'V' : 'V·Line',   '^V' : 'V·Block',            's' : 'Select',
      \ 'S': 'S·Line',    '^S' : 'S·Block',            'i' : 'Insert',
      \ 'R' : 'Replace',  'Rv' : 'V·Replace',          'c' : 'Command',
      \ 'cv' : 'Vim Ex',  'ce' : 'Ex',                 'r' : 'Prompt',
      \ 'rm' : 'More',    'r?' : 'Confirm',            '!' : 'Shell',
      \ 't' : 'Terminal'}

" Return current mode (expanded)
function! qline#current_mode() abort
    if g:actual_curbuf == bufnr()
        let l:curmode = mode()
        let l:modelist = toupper(get(s:currentmode, l:curmode, 'V·Block '))
        let l:current_status_mode = l:modelist
        return ' ' . l:current_status_mode . ' '
    else
        return ''
endfunction

function! qline#check_dirtybuf() abort
    let l:curbuf = bufnr()
    if getbufvar(l:curbuf, '&mod')
        return '  ●'
    else
        return ''
endfunction

function! qline#check_active() abort
    return g:actual_curbuf == bufnr() ? ' ' : ''
endfunction

