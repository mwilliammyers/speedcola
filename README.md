# speedcola

> Batteries included but lean [neovim] config infused with a little [Speed Cola].

## install

Run [`install.sh`]:

```
curl -sSL https://git.io/speedcola | sh
```

## configuration

Check out: [init.lua](init.lua).

### notable plugins

- [mini.deps] for plugin management
- Built-in LSP for IDE features (pyright, ruff, ts_ls, rust-analyzer)
- [onedark.nvim] colorscheme with treesitter support
- [blink.cmp] for autocompletion
- [flash.nvim] for jumping around
- [fzf] for fuzzy searching
- [gitsigns.nvim] for git signs
- [fugitive] for git commands
- [sandwich] for surround text objects

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
[mini.deps]: https://github.com/echasnovski/mini.deps
[onedark.nvim]: https://github.com/navarasu/onedark.nvim
[blink.cmp]: https://github.com/Saghen/blink.cmp
[flash.nvim]: https://github.com/folke/flash.nvim
[fzf]: https://github.com/junegunn/fzf.vim
[gitsigns.nvim]: https://github.com/lewis6991/gitsigns.nvim
[fugitive]: https://github.com/tpope/vim-fugitive
[sandwich]: https://github.com/machakann/vim-sandwich
[normal]: https://en.wikibooks.org/wiki/Learning_the_vi_Editor/Vim/Modes#normal_(command)
