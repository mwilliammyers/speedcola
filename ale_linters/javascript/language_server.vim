" TODO: get this file merged in upstream

call ale#Set('javascript_language_server_executable', 'javascript-typescript-stdio')
call ale#Set('javascript_language_server_use_global', 
\    get(g:, 'ale_use_global_executables', 0)
\)

call ale#linter#Define('javascript', {
\   'name': 'language_server',
\   'lsp': 'stdio',
\   'executable_callback': ale#node#FindExecutableFunc('javascript_language_server', [
\       'node_modules/.bin/javascript-typescript-stdio',
\   ]),
\   'command': '%e',
\   'project_root_callback': {-> ''},
\})
