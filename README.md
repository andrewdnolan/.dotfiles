# dotfiles

System setup and dotfiles using [`chezmoi`](https://www.chezmoi.io/) and [`mise`](https://mise.jdx.dev/).

## Setting up new machines

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply andrewdnolan/.dotfiles --ssh
```

<details>
<summary>If you have an older version of this dotfile repo that you would like to back up</summary>

```bash
# create the archive directory to copy dotfiles into
backupdir="${HOME}/dotfiles_$(date +%Y-%m-%d_%H:%M:%S)" && mkdir $backupdir

# copy the dotfiles to the archive direcotry
find $HOME -maxdepth 1 \( -name ".bashrc" \
                       -o -name ".bash_profile" \
                       -o -name ".vimrc" \
                       -o -name ".tmux.conf" \
                       -o -name ".gitconfig" \
                       -o -name ".gitignore" \) \
                       -exec cp {} $backupdir ";"

# tar the acrhive dir
tar -cvf "${backupdir}.tar" $backupdir
# clean up
rm -rf $backupdir

echo "Exisiting dotfiles archived in $(tput setaf 7)${backupdir}.tar"
```

</details>

## Updating an already supported machine

To pull the changes from the remote repo and apply them in a single command, run:
```
chezmoi update
```
This runs `git pull --autostash --rebase` in your source directory and then `chezmoi apply`.

Instead if you want to pull the latest changes from the remote repo and see what *would* change,
without actually applying the changes, run:
```
chezmoi git pull -- --autostash --rebase && chezmoi diff
```
If you're happy with the changes, then you can run:
```
chezmoi apply
```

## Included tools
I use [`mise`](https://mise.jdx.dev/) to bootstrap the installation of various
cli tools. The installed packages end up in: 
```
$USER/.local/share/mise/installs
```
Currently I'm using:

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

## Development:
Running `chezmoi cd` will change into the source directory (i.e. where this repo is cloned), but it spawns a new shell, which is frustrating.
Instead, it's easier to just just run:
```
cd ~/.local/share/chezmoi/
```
Use the `chezmoi status` and `chezmoi diff` commands to see what changes would be made to the dotfiles in you `$HOME` directory, based on your changes here within the source directory.
If you are statisfied with these changes run `chezmoi apply` for them to take effect.
Then `git add/commit/push` the changes like you would any other repo, so that they can be applied to other machines. 


**Todo**:
  - [x] `conda` sourcing  
  - [x] `sshproxy` on OSX for signing onto perlmutter  
  - [ ] bootstrap OSX terminal settings  
  - [x] git autocomplete on OSX  
  - [ ] bash autocomplete on OSX  
  - [ ] pre-commit hooks. See [example](https://gitlab.com/ohspl/oss/chezmoi/dotfiles/-/blob/main/.pre-commit-config.yaml?ref_type=heads)

## Deployment on machines
> [!NOTE]
> Prior to deploying on a given machine, check for local changes to exisint dotfiles.

**Checklist**:
  - [x] LANL macbook
  - [ ] Chryslais
    - need to build `nvim` from source, becuase `/lib64/libm.so.6` is too old.[^2]  
  - [ ] Perlmutter
  - [ ] Chicoma
  - [ ] Andes (OLCF)
  - [ ] Aurora / Polaris (ALCF)
  - [ ] Carpenter (DoD HPCMP)

[^2]: chrysalis has `GLIBC 2.28`, whereas neovim needs `GLIBC >= 2.29`. 
