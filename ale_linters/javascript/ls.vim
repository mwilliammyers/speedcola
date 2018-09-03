call ale#Set('javascript_ls_executable', 'javascript-typescript-stdio')
call ale#Set('javascript_ls_use_global', 
\    get(g:, 'ale_use_global_executables', 0)
\)

call ale#linter#Define('javascript', {
\   'name': 'language-server',
\   'lsp': 'stdio',
\   'executable_callback': ale#node#FindExecutableFunc('javascript_ls', [
\       'node_modules/.bin/javascript-typescript-stdio',
\   ]),
\   'command': '%e',
\   'project_root_callback': {-> ''},
\   'language': '',
\})
