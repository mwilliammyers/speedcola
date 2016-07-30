call deoplete#enable()

" if !exists('g:deoplete#omni#input_patterns')
  " let g:deoplete#omni#input_patterns = {}
" endif

" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function() abort
  " return deoplete#mappings#close_popup() . "\<CR>"
" endfunction

" tab-complete
" inoremap <silent><expr> <Tab>
  " \ pumvisible() ? "\<C-n>" :
  " \ deoplete#mappings#manual_complete()

" ,<Tab> for regular tab
" inoremap <Leader><Tab> <Space><Space>
