let s:suite = themis#suite('genpath')
let s:assert = themis#helper('assert')

function! s:suite.test_strfill_oneline()
  for test in [
  \   {
  \     'src': 'abc', 'char': 'a',
  \     'dst': 'aaa'
  \   },
  \   {
  \     'src': ' 12345 ', 'char': 'a',
  \     'dst': 'aaaaaaa'
  \   },
  \   {
  \     'src': 'foo bar baz', 'char': 'a',
  \     'dst': 'aaaaaaaaaaa'
  \   },
  \ ]
    let expect = test.dst
    let actual = operator#fill#strfill(test.src, test.char)
    call s:assert.equals(actual, expect)
  endfor
endfunction
