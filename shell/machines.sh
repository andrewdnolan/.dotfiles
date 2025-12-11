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

polaris_config(){
    if hash xalt_syshost 2>/dev/null; then
         module unload xalt
    fi
}

# set machine specific configurations
case $MACHINE in
    "aurora")
        aurora_config
        ;;
    "chrysalis")
        chrysalis_config
        ;;
    "polaris")
        polaris_config
        ;;
esac

# clean up namespace
unset load_tmux_module
unset aurora_config
unset chrysalis_config
unset polaris_config
