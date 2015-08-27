if exists('g:loaded_operator_fill')
  finish
endif
let g:loaded_operator_fill = 1

let s:save_cpo = &cpo
set cpo&vim

call operator#user#define('fill', 'operator#fill#fill')

let &cpo = s:save_cpo
unlet s:save_cpo
