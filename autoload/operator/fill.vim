let s:save_cpo = &cpo
set cpo&vim

function! s:fill_block(motion_wise) abort
  let char = getchar()
  let char = (type(char) == type(0))? nr2char(char): char
  if char == "\<C-[>"
    return a:src
  endif
  execute "normal! `[\<C-v>`]r" . char
endfunction

function! s:fill_range(motion_wise) abort
  let char = getchar()
  let char = (type(char) == type(0))? nr2char(char): char
  if char == "\<C-[>"
    return a:src
  endif
  let v = operator#user#visual_command_from_wise_name(a:motion_wise)
  try
    let sel_save     = &l:selection
    let &l:selection = 'inclusive'
    let reg_save     = getreg('z')
    let regtype_save = getregtype('z')
    execute 'normal!' '`[' . v . '`]"zy'
    let src = getreg('z')
    let builder = split(src, '\n')
    for i in range(len(builder))
      let builder[i] = repeat(char, strdisplaywidth(builder[i]))
    endfor
    let dst = join(builder, "\n")
    call setreg('z', dst)
    execute 'normal!' '`[' . v . '`]"zp'
  finally
    let &l:selection = sel_save
    call setreg('z', reg_save, regtype_save)
  endtry
endfunction

function! operator#fill#fill(motion_wise) abort
  if a:motion_wise == 'block'
    silent call s:fill_block(a:motion_wise)
  else
    silent call s:fill_range(a:motion_wise)
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
