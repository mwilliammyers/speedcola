let g:deoplete#enable_at_startup = 1

  " if !exists('g:deoplete#omni#input_patterns')
  " let g:deoplete#omni#input_patterns = {}
" endif

" let g:deoplete#disable_auto_complete = 1

" tab-complete
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" omnifuncs
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [ 'tern#Complete', 'jspc#omni' ]

" sources
set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']

