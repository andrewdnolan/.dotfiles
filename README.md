# .dotfiles

A `dotfile` configuration heavily following: https://github.com/necolas/dotfiles.

## Terminal profile and theme set up 

Download the `OneHalfDark` terminal theme: 
```shell
curl https://raw.githubusercontent.com/sonph/onehalf/refs/heads/master/terminal/OneHalfDark.terminal -o ~/Downloads/OneHalfDark.terminal
```
And then download and install the `UbuntuMono Nerd Font`: 
```
curl https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/UbuntuMono.zip -o ~/Downloads/UbuntuMono.zip
unzip ~/Downloads/UbuntuMono.zip -d ~/Downloads/UbuntuMono
open ~/Downloads/UbuntuMono/UbuntuMonoNerdFontMono-*.ttf
```
Open the `Terminal` app, then select Terminal > Settings, then click Profiles.
Click the "more" button (just to the right of the minus sign) and select import. 
Import the `OneHalfDark` from the `~/Downloads`  folder. 
Next change the font to `Ubuntu Mono` and set the default text size to 18. 
Then, click the "Color & Effects" menu and set the Opacity to 90% and the Blur to 5%.
Finally, set this profile as the Default. 

__Working Notes__: 
  - https://www.bugsnag.com/blog/tmux-and-vim/
    - https://github.com/keeganlow/dotfiles/blob/master/.vimrc#L219C5-L219C5
  - https://vim.fandom.com/wiki/Avoid_the_escape_key
  - https://github.com/christoomey/vim-tmux-navigator
  - https://github.com/edkolev/tmuxline.vim
  - https://gist.github.com/davidlamt/444ad0d60a09a9a3e10a58a4ce884531
  - https://gist.github.com/xinshuoweng/ea62e1b19f30dbba60184a85cf04e9a1

