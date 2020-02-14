# speedcola

> Batteries included but lean [neovim] config infused with a little [Speed Cola].

## install

Run [`install.sh`]:

```
curl -sSL https://git.io/speedcola | sh
```

**Note**: If your terminal does not support [24-bit/"true color"], do yourself
a favor and install one that does. But, if you don't don't mind your colors
looking a little off, remove the line: [init.vim#L77]. Also, make sure
`:echo has('termguicolors')` prints `1`.

## configuration

Ceck out: [init.vim](init.vim).

### notable plugins

- [One Dark] colorscheme
- [neovim/nvim-lsp] for IDE like features (via the [Language Server Protocol])
- [fzf] for fuzzy searching all the things
- [sneak] for jumping around
- [neoformat] for formatting code

### key mappings

[`<Leader>`] is mapped to `,`

From [Normal] mode, type:

```
:Maps
```

[vim8]: https://www.vim.org/
[neovim]: https://neovim.io
[speed cola]: http://nazizombies.wikia.com/wiki/Speed_Cola
[`install.sh`]: install.sh
[`<leader>`]: http://learnvimscriptthehardway.stevelosh.com/chapters/06.html#leader
[one dark]: https://github.com/rakr/vim-one
[fzf]: https://github.com/junegunn/fzf.vim
[vim-lsc]: https://github.com/natebosch/vim-lsc
[vim-lsp]: https://github.com/prabirshrestha/vim-lsp
[ale]: https://github.com/w0rp/ale
[sneak]: https://github.com/justinmk/vim-sneak
[normal]: https://en.wikibooks.org/wiki/Learning_the_vi_Editor/Vim/Modes#normal_(command)
[language server protocol]: https://microsoft.github.io/language-server-protocol/
[24-bit/"true color"]: https://gist.github.com/XVilka/8346728
[terminal.app]: https://en.wikipedia.org/wiki/Terminal_(macOS)
[iterm2]: https://www.iterm2.com/
[init.vim#l77]: https://github.com/mwilliammyers/speedcola/blob/510e88e/init.vim#L77
[neoformat]: https://github.com/sbdchd/neoformat
[neovim/nvim-lsp]: https://github.com/neovim/nvim-lsp
[neovim faq]: https://github.com/neovim/neovim/wiki/FAQ
[learn vimscript the hard way]: http://learnvimscriptthehardway.stevelosh.com/
[vimcasts]: http://vimcasts.org/
[vimulator]: http://thoughtbot.github.io/vimulator/
[learning the vi editor/vim wiki]: https://en.wikibooks.org/wiki/Learning_the_vi_Editor/Vim
[vi-improved]: https://www.vi-improved.org/
