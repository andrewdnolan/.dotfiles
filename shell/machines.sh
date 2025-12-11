#!/bin/bash

load_tmux_module(){
    if ! hash tmux 2>/dev/null; then
        module load tmux
    fi
}

aurora_config(){
    load_tmux_module
}

chrysalis_config(){
    load_tmux_module
}

# set machine specific configurations
case $MACHINE in
    "chrysalis")
        chrysalis_config
        ;;
esac

# clean up namespace
unset chrysalis_config
