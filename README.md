# speedcola

> Batteries included but lean [neovim] config infused with a little [Speed Cola].

## install

Run [`install.sh`]:

```
curl -sSL https://git.io/speedcola | sh
```

**Note**: If your terminal does not support [24-bit/"true color"], do yourself
a favor and install one that does. Otherwise, remove `set termguicolors` from
init.vim. Also, make sure `:echo has('termguicolors')` prints `1`.

## configuration

Check out: [init.vim](init.vim).

### notable plugins

- Built-in LSP for IDE features (pyright, ruff, ts_ls, rust-analyzer)
- [One Dark] colorscheme
- [blink.cmp] for autocompletion
- [fzf] for fuzzy searching all the things
- [sneak] for jumping around
- [sandwich] for surround text objects
- [fugitive] for git integration

### key mappings

[`<Leader>`] is mapped to `,`

From [Normal] mode, type:

```
:Maps
```

[neovim]: https://neovim.io
[speed cola]: http://nazizombies.wikia.com/wiki/Speed_Cola
[`install.sh`]: install.sh
[`<leader>`]: http://learnvimscriptthehardway.stevelosh.com/chapters/06.html#leader
[one dark]: https://github.com/rakr/vim-one
[blink.cmp]: https://github.com/Saghen/blink.cmp
[fzf]: https://github.com/junegunn/fzf.vim
[sneak]: https://github.com/justinmk/vim-sneak
[sandwich]: https://github.com/machakann/vim-sandwich
[fugitive]: https://github.com/tpope/vim-fugitive
[normal]: https://en.wikibooks.org/wiki/Learning_the_vi_Editor/Vim/Modes#normal_(command)
[24-bit/"true color"]: https://gist.github.com/XVilka/8346728
