# speedcola

> Lean [vim8]/[neovim] configuration infused with a little [Speed Cola].
 
## install

Run [`install.sh`]:
```
curl -sSL https://git.io/speedcola | sh
```

This will default to configuring `vim` if both `nvim` and `vim` are found. 
If neither are found it will install [neovim] for you and configure that.

You can also customize the configuration directory. 
For example, to force [neovim] configuration, run [`install.sh`] like:
```
curl -sSL git.io/speedcola | sh -s -- ~/.config/nvim
```

**Note**: If your terminal does not support [24-bit/"true color"], you can either 
install one that does *or* remove the line: [init.vim#L77].

## configuration

Ceck out: [init.vim](init.vim).

### notable plugins

- [One Dark] colorscheme
- [fzf] for fuzzy searching all the things
- [vim-lsp] for IDE like features (via the [Language Server Protocol])
- [sneak] for jumping around

### key mappings

[`<Leader>`] is mapped to `,`

From [Normal] mode, type:
```
:Maps
```

[vim8]: https://www.vim.org/
[neovim]: https://neovim.io
[Speed Cola]: http://nazizombies.wikia.com/wiki/Speed_Cola
[`install.sh`]: install.sh
[`<Leader>`]: http://learnvimscriptthehardway.stevelosh.com/chapters/06.html#leader
[One Dark]: https://github.com/rakr/vim-one
[fzf]: https://github.com/junegunn/fzf.vim
[vim-lsc]: https://github.com/natebosch/vim-lsc
[vim-lsp]: https://github.com/prabirshrestha/vim-lsp
[ALE]: https://github.com/w0rp/ale
[sneak]: https://github.com/justinmk/vim-sneak
[Normal]: https://en.wikibooks.org/wiki/Learning_the_vi_Editor/Vim/Modes#normal_(command)
[Language Server Protocol]: https://microsoft.github.io/language-server-protocol/
[24-bit/"true color"]: https://gist.github.com/XVilka/8346728
[Terminal.app]: https://en.wikipedia.org/wiki/Terminal_(macOS)
[iTerm2]: https://www.iterm2.com/
[init.vim#L77]: https://github.com/mwilliammyers/speedcola/blob/510e88e/init.vim#L77

[Neovim FAQ]: https://github.com/neovim/neovim/wiki/FAQ
[Learn Vimscript the Hard Way]: http://learnvimscriptthehardway.stevelosh.com/
[Vimcasts]: http://vimcasts.org/
[Vimulator]: http://thoughtbot.github.io/vimulator/
[Learning the vi Editor/Vim Wiki]: https://en.wikibooks.org/wiki/Learning_the_vi_Editor/Vim
[vi-improved]: https://www.vi-improved.org/
