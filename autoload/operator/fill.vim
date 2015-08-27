let s:save_cpo = &cpo
set cpo&vim

function! operator#fill#strfill(src, char) abort
  if a:src =~ "^\n*$"
    return a:src
  endif

  let head = matchstr(a:src, "^\n*")
  let tail = matchstr(a:src, "\n$")
  let builder = split(a:src, '\n')
  for i in range(len(builder))
    let builder[i] = repeat(a:char, strdisplaywidth(builder[i]))
  endfor
  return head . join(builder, "\n") . tail
endfunction

function! s:fill(motion_wise, char) abort
  if a:motion_wise == 'block'
    execute "normal! `[\<C-v>`]r" . a:char
  else
    let v = operator#user#visual_command_from_wise_name(a:motion_wise)
    try
      let sel_save     = &l:selection
      let &l:selection = 'inclusive'
      let reg_save     = getreg('z')
      let regtype_save = getregtype('z')
      execute 'normal!' '`[' . v . '`]"zy'
      let src = getreg('z')
      let dst = operator#fill#strfill(src, a:char)
      call setreg('z', dst)
      execute 'normal!' '`[' . v . '`]"zp'
    finally
      let &l:selection = sel_save
      call setreg('z', reg_save, regtype_save)
    endtry
  endif
endfunction

let s:dotinfo = {
\   'is_repeating': 0,
\   'was_eol': 0,
\   'char': '',
\ }

function! operator#fill#initialize_dotinfo()
  let s:dotinfo.is_repeating = 0
  let s:dotinfo.was_eol = getcurpos()[4] == 2147483647
endfunction

function! operator#fill#fill(motion_wise) abort
  let char = s:dotinfo.char
  if !s:dotinfo.is_repeating
    let char = getchar()
    let char = (type(char) == type(0))? nr2char(char): char
    if char == "\<C-[>"
      return
    endif
  endif

  let pos = getcurpos()
  if !s:dotinfo.is_repeating && !s:dotinfo.was_eol
    let pos[4] = pos[2]
  endif
  silent call s:fill(a:motion_wise, char)
  call setpos('.', pos)

  let s:dotinfo.is_repeating = 1
  let s:dotinfo.char = char
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
