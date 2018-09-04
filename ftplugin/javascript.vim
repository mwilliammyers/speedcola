setlocal shiftwidth=2 softtabstop=2 expandtab list


let b:ale_javascript_prettier_use_local_config = 1
" let b:ale_javascript_ls_use_global = 1
let b:ale_javascript_tsserver_use_global = 1

let b:ale_linters = ['tsserver', 'language-server', 'eslint', 'prettier']
let b:ale_fixers = ['eslint', 'prettier']
