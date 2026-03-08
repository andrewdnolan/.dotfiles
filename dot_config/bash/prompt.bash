set_prompt() {
    local bold reset o w y g

    if command -v tput >/dev/null 2>&1 && tput setaf 1 >/dev/null 2>&1; then
      tput sgr0  # reset terminal attrs/colors

      bold=$(tput bold)
      reset=$(tput sgr0)

      o=$(tput setaf 166)  # orange
      w=$(tput setaf 254)  # white
      y=$(tput setaf 136)  # yellow
      g=$(tput setaf  64)  # green
    else
      bold=""
      reset=$'\e[0m'
      o="\e[1;33m"
      w="\e[1;37m"
      y="\e[1;33m"
      g="\e[1;32m"
    fi

    PS1="\[$o\]\u"             # orange user
    PS1+="\[$w\]@"             # white @
    PS1+="\[$y\]\h"            # yellow hostname (up to the first .)
    PS1+="\[$w\]: "            # white colon with a space
    PS1+="\[$g\]\w "           # green working direcotry, with no path
    PS1+="\[$w\]\[$bold\]\$ "  # white and bold dollar sign
    PS1+="\[$reset\]"          # reset everything

    export PS1
}

set_prompt
unset -f set_prompt
