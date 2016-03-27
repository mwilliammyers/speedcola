" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" nmap \ [ctrlp]
" nnoremap [ctrlp] <nop>

nnoremap <silent> <D-t> :CtrlP<CR>
nnoremap <silent> <D-r> :CtrlPMRU<CR>

nnoremap [ctrlp]t :CtrlPBufTag<cr>
nnoremap [ctrlp]T :CtrlPTag<cr>
nnoremap [ctrlp]l :CtrlPLine<cr>
nnoremap [ctrlp]o :CtrlPFunky<cr>
nnoremap [ctrlp]b :CtrlPBuffer<cr>

" let g:ctrlp_map = ''
" nnoremap <C-p> :CtrlPCurWD<cr>
" nnoremap <leader>f :CtrlPCurWD<cr>
" nnoremap <leader>m :CtrlPMRUFiles<cr>
" nnoremap <leader>F :CtrlPBufTag<cr>
" nnoremap <leader>S :CtrlPTag<cr>
" nnoremap <leader>L :CtrlPLine<cr>
" nnoremap <leader>b :CtrlPBuffer<cr>

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:50'
let g:ctrlp_max_height = 40
let g:ctrlp_show_hidden = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_max_files = 20000
let g:ctrlp_cache_dir = $COLA_CACHE_HOME . '/ctrlp'
let g:ctrlp_switch_buffer = '1'
let g:ctrlp_reuse_window = 'startify'
let g:ctrlp_extensions = ['funky']
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.(git|hg|svn|idea)$',
    \ 'file': '\v[\/]\.(DS_Store|pdf|jpg|jpg|gif|mp4|m4v|pyc|so|dll)$'
\ }
" TODO: update more root markers
let g:ctrlp_root_markers = ['pom.xml', '.p4ignore', 'Makefile', 'Gemfile']

"Matcher for CtrlP
if has('python') || has('python3')
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

if executable('ag')
  " let g:ctrlp_use_caching = 0
  let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
elseif executable('ack-grep')
  let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
elseif executable('ack')
  let s:ctrlp_fallback = 'ack %s --nocolor -f'
else
  let s:ctrlp_fallback = 'find %s -type f'
endif
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
  \ },
  \ 'fallback': s:ctrlp_fallback
\ }

" function! s:define_user_command()
  " " Change wildignore into space or | separated groups
  " " e.g. .aux .out .toc .jpg .bmp .gif
  " " or   .aux$\|.out$\|.toc$\|.jpg$\|.bmp$\|.gif$
  " let pats = ['[*\/]*\([?_.0-9A-Za-z]\+\)\([*\/]*\)\(\\\@<!,\|$\)','\\\@<!,', '\.']
  " let subs = ['\1\2\3', '\\|', '\\.']
  " let expr = substitute(&wig, pats[0], subs[0], 'g')
  " let expr = substitute(expr, pats[1], subs[1], 'g')
  " let expr = substitute(expr, pats[2], subs[2], 'g')
  " let expr = substitute(expr, '\\,', ',', 'g')

  " " Set the user_command option
  " if executable('ag')
    " let g:ctrlp_use_caching = 0
    " let cmd = 'ag %s -U -l --hidden --nocolor -g ""'
  " else
    " let cmd = 'find %s -type f'
  " endif

  " " Set the user_command option
  " let g:ctrlp_user_command = cmd . ' | grep -v "'.expr .'"'
" endfunction

" call s:define_user_command()
