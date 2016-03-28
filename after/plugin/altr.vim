" FIXME: Fix altr config so it matches include/*.h
" call altr#remove_all()
" call altr#define('%/src/%.c',
" \                '%/include/%.h')

nmap <Leader>a <Plug>(altr-forward)
nmap <Leader>A <Plug>(altr-back)
