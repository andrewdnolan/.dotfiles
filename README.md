# dotfiles

System setup and dotfiles using [`chezmoi`](https://www.chezmoi.io/) and [`mise`](https://mise.jdx.dev/).

## Setting up new machines

```{bash}
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $andrewdnolan
```

```
## TODO:
    - [ ] bootstrap OSX terminal settings
    - [ ] bash / git autocomplete on OSX
    - [ ] linter for this repo
