" ----------------------------------------
" Auto Commands
" ----------------------------------------

if has("autocmd")
  augroup general
    autocmd! " Clear all autocmds in the group

    if exists("g:autosave") && g:autosave == 1
      autocmd FocusLost * silent! wa
    endif

    " Always switch to the current file directory
    " autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    " No formatting on o key newlines
    autocmd BufNewFile,BufEnter * set formatoptions-=o

 
    " run neomake on the current file on every write
    autocmd! BufWritePost * Neomake

    " Leave the return key alone when in command line windows, since it's used
    " to run commands there.
    autocmd! CmdwinEnter * :unmap <cr>
    autocmd! CmdwinLeave * :call MapCR()
  augroup END

  augroup languages
    autocmd! " Clear all autocmds in the group

    autocmd FileType python
          \ setlocal ai si et sta sw=4
          \ textwidth=80 backspace=indent,eol,start fo=croql
    

    " recognize newer web languages
    autocmd! BufRead,BufNewFile *.sass setfiletype sass
    autocmd! BufRead,BufNewFile *.coffee setfiletype coffee
    autocmd! BufRead,BufNewFile *.jade setfiletype jade

    " javascript
    autocmd! BufRead,BufNewFile *.jsx setfiletype javascript
    autocmd! FileType javascript
          \ setlocal ai si et sta sw=2

    " makefile
    autocmd FileType make setlocal noexpandtab list

    " markdown
    autocmd! FileType markdown set syntax=off textwidth=80
    autocmd BufRead markdown set autoindent formatoptions=tcroqn2 comments=n:&gt;

    " golang
    autocmd FileType go compiler go
    " autocmd! BufEnter *.go call golang#buffcommands()
    autocmd! FileType go autocmd BufWritePre <buffer> Fmt

    autocmd FileType c,cpp,java,php,ruby,python,html,javascript,markdown 
          \ autocmd BufWritePre <buffer> silent! :StripTrailingWhiteSpace
  augroup END
endif
