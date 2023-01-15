function! s:TextOff(winfo) abort
    if v:versionlong >= 8023627
    " textoff is available only from cdf5fdb2948ecdd24c6a1e27ed33dfa847c2b3e4
    return a:winfo.textoff
    else
    " otherwise we compute it according to a version of
    " https://stackoverflow.com/a/26318602/5825294 improved based on the
    " comments therein
    return a:winfo
            \ -> max([&numberwidth, (&number ? len(line('$')) + 1 : (&relativenumber ? winfo.height + 1 : 0))])
            \ + &foldcolumn
            \ + (empty(sign_getplaced(bufname(), {'group': '*'})[0].signs) ? 0 : 2)
    endif
endfunction

function! softwrap#showSoftwrap() abort
  " can't wrap if it's already wrapped
  if &wrap
    return
  endif

  " we're not gonna wrap fold titles
  if foldclosed(".") != -1
      return
  endif

  let winfo = getwininfo(win_getid())[0]
  let textoff = s:TextOff(winfo)
  let fst_vis_scr_col_in_win = winfo.wincol + textoff
  let fst_scr_col_in_win = screencol() - virtcol('.') + 1

  let textwidth = winfo.width - textoff
  if (fst_vis_scr_col_in_win == fst_scr_col_in_win) && ((virtcol('$') - 1)) <= textwidth
    " there's nothing to wrap
    return
  endif

  let available_screen = textwidth
  let popup_fst_col = fst_vis_scr_col_in_win
  if g:softwrap_unwrap_popup
    let available_screen = &columns - max([0, screencol() - virtcol('.')])
    let popup_fst_col = screencol() - virtcol('.') + 1
  endif
  let popup = popup_create(
    \   bufnr(),
    \   #{
    \      line: 'cursor',
    \      col: popup_fst_col,
    \      moved: 'any',
    \      highlight: 'SoftWrapHighlightGroup',
    \      wrap: 0,
    \      firstline: line('.'),
    \      maxheight: 1,
    \      maxwidth: available_screen,
    \      scrollbar: 0
    \   }
    \ )

  exe printf('nnoremap <expr> <buffer> <silent> %s popup_close("%s")', g:softwrap_close_popup_mapping, popup)
endfunction
