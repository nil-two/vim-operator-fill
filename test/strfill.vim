let s:suite = themis#suite('genpath')
let s:assert = themis#helper('assert')

function! s:suite.test_strfill_oneline()
  for test in [
  \   {
  \     'src': 'abc', 'char': 'a',
  \     'dst': 'aaa',
  \   },
  \   {
  \     'src': ' 12345 ', 'char': 'a',
  \     'dst': 'aaaaaaa',
  \   },
  \   {
  \     'src': 'foo bar baz', 'char': 'a',
  \     'dst': 'aaaaaaaaaaa',
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
  \     'dst': 'bbbbbb',
  \   },
  \   {
  \     'src': '', 'char': 'a',
  \     'dst': 'aaaa',
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
  \     'src': "abd\ncef", 'char': 'c',
  \     'dst': "ccc\nccc",
  \   },
  \   {
  \     'src': "foo\nbar\nbaz", 'char': 'c',
  \     'dst': "ccc\nccc\nccc",
  \   },
  \   {
  \     'src': "あいうえ\n\nab", 'char': 'c',
  \     'dst': "cccccccc\ncccc\ncc",
  \   },
  \ ]
    let expect = test.dst
    let actual = operator#fill#strfill(test.src, test.char)
    call s:assert.equals(actual, expect)
  endfor
endfunction

function! s:suite.test_strfill_emptyline()
  for test in [
  \   {
  \     'src': "", 'char': 'd',
  \     'dst': "",
  \   },
  \   {
  \     'src': "\n", 'char': 'd',
  \     'dst': "\n",
  \   },
  \   {
  \     'src': "\n\n\n", 'char': 'd',
  \     'dst': "\n\n\n",
  \   },
  \   {
  \     'src': "\nab", 'char': 'd',
  \     'dst': "\ndd",
  \   },
  \   {
  \     'src': "\n\nabc", 'char': 'd',
  \     'dst': "\n\nddd",
  \   },
  \   {
  \     'src': "foo\nbar", 'char': 'd',
  \     'dst': "ddd\nddd",
  \   },
  \   {
  \     'src': "foobar\n\nfoobar", 'char': 'd',
  \     'dst': "dddddd\n\ndddddd",
  \   },
  \   {
  \     'src': "abcde\n", 'char': 'c',
  \     'dst': "ccccc\n",
  \   },
  \   {
  \     'src': "abcdeghi\n\n", 'char': 'c',
  \     'dst': "cccccccc\n\n",
  \   },
  \ ]
    let expect = test.dst
    let actual = operator#fill#strfill(test.src, test.char)
    call s:assert.equals(actual, expect)
  endfor
endfunction
