let s:save_cpo = &cpo
set cpo&vim

function! s:rewrite_textobj_by(motion_wise, func_name) abort
  let v = operator#user#visual_command_from_wise_name(a:motion_wise)
  let Func = function(a:func_name)
  try
    let sel_save     = &l:selection
    let &l:selection = 'inclusive'
    let reg_save     = getreg('z')
    let regtype_save = getregtype('z')
    execute 'normal!' '`[' . v . '`]"zy'
    let src = getreg('z')
    let dst = Func(src)
    call setreg('z', dst)
    execute 'normal!' '`[' . v . '`]"zp'
  finally
    let &l:selection = sel_save
    call setreg('z', reg_save, regtype_save)
  endtry
endfunction

function! s:fill(src) abort
  let char = getchar()
  let char = (type(char) == type(0))? nr2char(char): char
  let builder = split(a:src, '\n')
  for i in range(len(builder))
    let builder[i] = repeat(char, strdisplaywidth(builder[i]))
  endfor
  return join(builder, "\n")
endfunction

function! operator#fill#fill(motion_wise) abort
  silent call s:rewrite_textobj_by(a:motion_wise, 's:fill')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
