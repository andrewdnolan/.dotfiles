# dotfiles

System setup and dotfiles using [`chezmoi`](https://www.chezmoi.io/) and [`mise`](https://mise.jdx.dev/).

## Setting up new machines

```{bash}
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply andrewdnolan/.dotfiles --ssh
```

## Included tools
I use [`mise`](https://mise.jdx.dev/) to bootstrap the installation of various
cli tools. The installed packages end up in: `$USER/.local/share/mise/installs`
. Currently I'm using:

- [`bat`](https://github.com/sharkdp/bat) — A `cat` clone with syntax highlighting and Git integration.
- [`github/copilot-cli`](https://github.com/github/copilot-cli) — GitHub Copilot in the terminal for AI-powered CLI assistance.
- [`fd`](https://github.com/sharkdp/fd) — A fast, user-friendly alternative to `find`.[^*]
- [`fzf`](https://github.com/junegunn/fzf) — A general-purpose command-line fuzzy finder.[^*]
- [`lsd`](https://github.com/lsd-rs/lsd) — A modern `ls` replacement with icons, colors, and tree views.
- [`node`](https://github.com/nodejs/node) — JavaScript runtime need for `copilot-cli`.
- [`neovim`](https://github.com/neovim/neovim) — A highly extensible, modernized fork of Vim.
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) — Blazing-fast recursive grep with smart defaults and `.gitignore` support.[^*]
- [`tmux`](https://github.com/tmux/tmux) — Terminal multiplexer for managing multiple sessions in one window.

[^*]: These are optional, but very useful, dependencies of `neovim`

**Todo**:
  - [ ] bootstrap OSX terminal settings  
  - [x] git autocomplete on OSX  
  - [ ] bash autocomplete on OSX  
  - [ ] linter for this repo  
