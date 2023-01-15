" SoftWrap - Plugin for soft-wrapping current line in nowrap buffers
" Copyright (c) 2022 Enrico Maria De Angelis
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

if &compatible
  finish
endif

let g:softwrap_unwrap_popup = get(g:, 'softwrap_unwrap_popup', v:false)

if type(g:softwrap_unwrap_popup) != v:t_bool
  echoerr 'SoftWrap: g:softwrap_unwrap_popup must be a boolean.'
  finish
endif

let g:softwrap_close_popup_mapping = get(g:, 'softwrap_close_popup_mapping', '<esc><esc>')
if type(g:softwrap_close_popup_mapping) != v:t_string
  echoerr 'SoftWrap: g:softwrap_close_popup_mapping must be a string.'
  finish
endif

                      highlight default SoftWrapHighlightGroup ctermbg=NONE ctermfg=NONE cterm=bold
autocmd ColorScheme * highlight default SoftWrapHighlightGroup ctermbg=NONE ctermfg=NONE cterm=bold

nnoremap <silent> <Plug>(SoftwrapShow) :call softwrap#showSoftwrap()<cr>

augroup softwrap
    autocmd!
    autocmd CursorHold * call softwrap#showSoftwrap()
augroup END
