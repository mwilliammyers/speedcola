setlocal shiftwidth=4 softtabstop=4 expandtab


let b:ale_linters = ['pyls', 'vulture']
let b:ale_fixers = ['yapf', 'isort']

let b:ale_warn_about_trailing_whitespace = 0
