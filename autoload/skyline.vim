" === Autoload ================================================================

" Basics
let skyline#dark  = "#282828"
let skyline#light = "#FFFFFF"

" Nord
let skyline#ndark  = "#2e3440"
let skyline#nlight = "#4c566a"

" Pastels
let skyline#blue   = "#81a1c1"
let skyline#red    = "#bf616a"
let skyline#yellow = "#ebcb8b"
let skyline#green  = "#a3be8c"
let skyline#lilac  = "#b48ead"

" helper method to set fg and bg
function! skyline#hi(group, guifg, guibg)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=" . a:guibg
  endif
endfunction

" Returns formatted current buffer name
function skyline#get_curbuf() abort
    let l:curbuf = bufnr()
    for buf in getbufinfo()
        if buf.bufnr == l:curbuf
            return '[' . buf.bufnr . '] ' . fnamemodify(buf.name, ':t')
        endif
    endfor
endfunction

" Returns remaining buffers formatted with separators
function! skyline#get_remainingbufs() abort
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

function! skyline#get_remainingtabs() abort
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

" take mode() input -> longer notation of current mode
" mode() is defined by Vim
let s:currentmode={
      \ 'n' : 'Normal',   'no' : 'N·Operator Pending', 'v' : 'Visual',
      \ 'V' : 'V·Line',   '^V' : 'V·Block',            's' : 'Select',
      \ 'S': 'S·Line',    '^S' : 'S·Block',            'i' : 'Insert',
      \ 'R' : 'Replace',  'Rv' : 'V·Replace',          'c' : 'Command',
      \ 'cv' : 'Vim Ex',  'ce' : 'Ex',                 'r' : 'Prompt',
      \ 'rm' : 'More',    'r?' : 'Confirm',            '!' : 'Shell',
      \ 't' : 'Terminal'}

" return current mode
" abort -> function will abort soon as error detected
function skyline#current_mode() abort
    if g:actual_curbuf == bufnr()
        let l:curmode = mode()
        " use get() -> fails safely, since ^V doesn't seem to register
        " 3rd arg is used when return of mode() == 0, which is case with ^V
        " thus, ^V fails -> returns 0 -> replaced with 'V Block'
        let l:modelist = toupper(get(s:currentmode, l:curmode, 'V·Block '))
        let l:current_status_mode = l:modelist
        return ' ' . l:current_status_mode . ' '
    else
        return ''
endfunction

" Function that returns \" ●" to indicate buffer is modified/dirty
function! skyline#check_dirtybuf() abort
    let l:curbuf = bufnr() " get current buffer number
    if getbufvar(l:curbuf, '&mod') " check if buffer is modified or not
        return '  ●'
    else
        return ''
endfunction

function! skyline#check_active() abort
    return g:actual_curbuf == bufnr() ? ' ' : ''
endfunction

