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

function! s:suite.test_strfill_specialwidth()
  for test in [
  \   {
  \     'src': 'あいう', 'char': 'b',
  \     'dst': 'bbbbbb'
  \   },
  \   {
  \     'src': '', 'char': 'a',
  \     'dst': 'aaaa'
  \   },
  \ ]
    let expect = test.dst
    let actual = operator#fill#strfill(test.src, test.char)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:suite.test_strfill_multiline()
  for test in [
  \   {
  \     'src': join(['ab', 'dcef'], "\n"), 'char': 'c',
  \     'dst': join(['cc', 'cccc'], "\n")
  \   },
  \   {
  \     'src': join(['foo', 'bar', 'baz'], "\n"), 'char': 'c',
  \     'dst': join(['ccc', 'ccc', 'ccc'], "\n")
  \   },
  \   {
  \     'src': join(['あいうえ', '', 'ab'], "\n"), 'char': 'c',
  \     'dst': join(['cccccccc', 'cccc', 'cc'], "\n")
  \   },
  \ ]
    let expect = test.dst
    let actual = operator#fill#strfill(test.src, test.char)
    call s:assert.equals(actual, expect)
  endfor
endfunction
