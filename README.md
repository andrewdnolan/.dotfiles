# dotfiles

System setup and dotfiles using [`chezmoi`](https://www.chezmoi.io/) and [`mise`](https://mise.jdx.dev/).

## Setting up new machines

```bash
sh -c "$(curl -fsLS get.chezmoi.io)"  -- -b $HOME/.local/bin
chezmoi init --apply andrewdnolan/.dotfiles --ssh
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
If you make edits to the `.chezmoi.yaml.tmpl` file you'll need to run
`chezmoi init` before you can run `chezmoi apply`.

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
- [`tree-sitter`](https://github.com/tree-sitter/tree-sitter) — Parser generator used by Neovim.

> [!NOTE]
> Tree-sitter CLI is built locally through `mise`/`Cargo` on all platforms to
> avoid incompatible prebuilt binaries on older systems.  
>
> On LCRC systems, Neovim is built with Spack because the mise-provided binary
> is incompatible with the host glibc. Builds and executable links are isolated
> by machine.

<details>
<summary>Finding compiler paths for Spack</summary>

```bash
module load gcc/<version>

command -v gcc
command -v g++
command -v gfortran
dirname "$(dirname "$(command -v gcc)")"
```

Use these values for `c`, `cxx`, `fortran`, and `prefix` in `.chezmoi.yaml.tmpl`.

</details>

<details>
<summary>Remove a machine's Spack environment</summary>

When a machine no longer uses Spack-managed tools, remove its environment and then garbage-collect packages that are not referenced by any remaining environment:

```bash
machine="$(chezmoi execute-template '{{- $system := includeTemplate "system.yaml" . | fromYaml -}}{{ $system.machine }}')"
spack="$HOME/.local/share/spack/bin/spack"
env="$HOME/.config/spack/environments/chezmoi-tools/$machine"

"$spack" -e "$env" uninstall --all --yes-to-all
rm -rf "$env"

"$spack" gc --except-any-environment --yes-to-all
```

</details>


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
  - [x] Chryslais
  - [x] Perlmutter
  - [ ] Chicoma
  - [ ] Andes (OLCF)
  - [ ] Aurora / Polaris (ALCF)
  - [ ] Carpenter (DoD HPCMP)

