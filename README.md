# speedcola

__Ultra fast [neovim] configuration;
powered by [vim-plug], infused with [XDG] & a little [speed-cola]__

> Just take a sip, you will move faster. Just try it now! & speed is mastered!
Press those lips against the only one that really moves you. Speed Cola speeds
up your life! - [nazi zombies]


## Installation

```
git clone https://github.com/mwilliammyers/speedcola.git ~/.config/nvim
```

[Install](https://github.com/junegunn/vim-plug#installation) [vim-plug]*

For some automation fun, checkout: [mwilliammyers/ansible-neovim]

\* [`plugin.vim`](plugin.vim) will install it for you if you don't.

#### Requirements

- Linux or OS X
- [neovim] 0.1.3+
- [vim-plug]
- Set: `$XDG_CONFIG_HOME`, `$XDG_DATA_HOME` & `$XDG_CACHE_HOME`. (see: [XDG])
- Plugins (optional):
  - [Fugitive] requires Git
  - [Tagbar] requires [exuberant-ctags]


## Accessorize

#### User config files:
  - All `local/*.vim` files will be sourced automatically & are ignored by Git.

For example, place this in `local/neocomplete.vim`:

```viml
let g:neocomplete#enable_at_startup = 0   " disable neocomplete
let g:neocomplcache_enable_at_startup = 0 " disable the fallback version when no LUA
```

#### Colors!
- Default color scheme: `Hybrid`
- Use a different color scheme:
  ```bash
  echo "let g:cola_colorscheme='solarized'" >> "$XDG_CONFIG_HOME/nvim/local/colors.vim"
  ```
- List of available color schemes: [flazz/vim-colorschemes]
- screenshots __coming soon__


## Plugins

__All plugins are managed by [vim-plug]__

See [plug.vim] for a list of currently bundled plugins

#### [Undotree]

If you undo changes & then make a new change, in most editors the changes you
undid are gone forever, as their undo-history is a simple list. Since version
7.0 vim uses an undo-tree instead. If you make a new change after undoing
changes, a new branch is created in that tree. Combined with persistent undo,
this is nearly as flexible & safe as git ;-)

Undotree makes that feature more accessible by creating a visual representation
of said undo-tree.

_QuickStart_

Launch using `<Leader>u`

#### [NERDTree]

NERDTree is a file explorer plugin that provides "project drawer" functionality
to your vim editing.  You can learn more about it with `:help NERDTree`.

_QuickStart_

Launch using `\`

#### [Surround]

This plugin is a tool for dealing with pairs of "surroundings."  Examples of
surroundings include parentheses, quotes, & HTML tags.  They are closely
related to what Vim refers to as text-objects.  Provided are mappings to allow
for removing, changing, & adding surroundings.

Details follow on the exact semantics, but first, consider the following
examples.  An asterisk (\*) is used to denote the cursor position.

```text
Old text                  Comm&     New text ~
"Hello *world!"           ds"         Hello world!
[123+4*56]/2              cs])        (123+456)/2
"Look ma, I'm *HTML!"     cs"<q>      <q>Look ma, I'm HTML!</q>
if *x>3 {                 ysW(        if ( x>3 ) {
my $str = *whee!;         vllllS'     my $str = 'whee!';
```

For instance, if the cursor was inside `"foo bar"`, you could type `cs"'` to
convert the text to `'foo bar'`.

There's a lot more, check it out at `:help surround`

#### [neocomplete]

Neocomplete is an amazing autocomplete plugin with additional support for
snippets. It can complete simulatiously from the dictionary, buffer,
omnicomplete & snippets. This is the one true plugin that brings Vim
autocomplete on par with the best editors.

_QuickStart_

Just start typing, it will autocomplete where possible

#### [Syntastic]

Syntastic is a syntax checking plugin that runs buffers through external syntax
checkers as they are saved & opened. If syntax errors are detected, the user
is notified & is happy because they didn't have to compile their code or
execute their script to find them.

#### [AutoClose]

AutoClose does what you expect. It's simple, if you open a bracket, paren,
brace, quote, etc, it automatically closes it. It h&les curlys correctly &
doesn't get in the way of double curlies for things like jinja & twig.


## Acknowledgements
- [spf13-vim] legendary vim distribution
- Luan Santos' [vimfiles]


[mwilliammyers/ansible-neovim]: https://github.com/mwilliammyers/ansible-neovim
[nazi zombies]: http://nazizombies.wikia.com/wiki/Speed_Cola
[speed-cola]: http://nazizombies.wikia.com/wiki/Speed_Cola
[plug.vim]: plug.vim

[Git]:http://git-scm.com
[Curl]:http://curl.haxx.se
[Vim]:http://www.vim.org/download.php#pc
[neovim]: https://github.com/neovim/neovim
[MacVim]:http://code.google.com/p/macvim/

[vim-respect-xdg]:https://tlvince.com/vim-respect-xdg
[XDG]:http://st&ards.freedesktop.org/basedir-spec/basedir-spec-latest.html

[vim-plug]:https://github.com/junegunn/vim-plug

[ack]:http://betterthangrep.com/
[ag]:https://github.com/ggreer/the_silver_searcher
[exuberant-ctags]:https://github.com/fishman/ctags
[fzf]:https://github.com/junegunn/fzf

[Vundle]:https://github.com/gmarik/vundle
[PIV]:https://github.com/spf13/PIV
[NERDCommenter]:https://github.com/scrooloose/nerdcommenter
[Undotree]:https://github.com/mbbill/undotree
[NERDTree]:https://github.com/scrooloose/nerdtree
[ctrlp]:https://github.com/kien/ctrlp.vim
[solarized]:https://github.com/altercation/vim-colors-solarized
[neocomplete]:https://github.com/shougo/neocomplete
[Fugitive]:https://github.com/tpope/vim-fugitive
[Surround]:https://github.com/tpope/vim-surround
[Tagbar]:https://github.com/majutsushi/tagbar
[Syntastic]:https://github.com/scrooloose/syntastic
[vim-easymotion]:https://github.com/Lokaltog/vim-easymotion
[YouCompleteMe]:https://github.com/Valloric/YouCompleteMe
[Matchit]:http://www.vim.org/scripts/script.php?script_id=39
[Tabularize]:https://github.com/godlygeek/tabular
[EasyMotion]:https://github.com/Lokaltog/vim-easymotion
[Airline]:https://github.com/bling/vim-airline
[Powerline]:https://github.com/lokaltog/powerline
[PowerlineFonts]:https://github.com/Lokaltog/powerline-fonts
[AutoClose]:https://github.com/spf13/vim-autoclose
[ag.vim]:https://github.com/rking/ag.vim
[Ack.vim]:https://github.com/mileszs/ack.vim

[flazz/vim-colorschemes]:https://github.com/flazz/vim-colorschemes/tree/master/colors

[spf13-vim]:https://github.com/spf13/spf13-vim
[vimfiles]:https://github.com/luan/vimfiles

[spf13-vim-img]:https://i.imgur.com/UKToY.png
[spf13-vimrc-img]:https://i.imgur.com/kZWj1.png
[autocomplete-img]:https://i.imgur.com/90Gg7.png
[tagbar-img]:https://i.imgur.com/cjbrC.png
[fugitive-img]:https://i.imgur.com/4NrxV.png
[nerdtree-img]:https://i.imgur.com/9xIfu.png
[phpmanual-img]:https://i.imgur.com/c0GGP.png
[easymotion-img]:https://i.imgur.com/ZsrVL.png
[airline-img]:https://i.imgur.com/D4ZYADr.png
