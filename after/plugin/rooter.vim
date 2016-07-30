let g:rooter_manual_only = 1
let g:rooter_disable_map = 1

" let g:rooter_change_directory_for_non_project_files = 1
" let g:rooter_resolve_links = 1

let g:rooter_patterns = g:rooter_patterns + 
  \ [ 'Rakefile', 'Makefile', '.travis.yml', 'CMakeLists.txt', 'Doxyfile', 
  \   'LICENSE', 'README', 'README.md', 'README.txt', 'MAINTAINERS' ]
