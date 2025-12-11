#!/bin/bash

chrysalis_config(){
    module load tmux
}

# set machine specific configurations
case $MACHINE in
    "chrysalis")
        chrysalis_config
        ;;
esac

# clean up namespace
unset chrysalis_config
