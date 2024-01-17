
HOST=$(hostname -s)

if [[ $(uname) -eq Darwin ]];then 
    # suppress the zsh warning on macs
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi

# Export LANL proxys
if [[ $HOST = ch-fe* ]] || [[ $HOST = pn* ]];then 
    # see https://hpc.lanl.gov/proxy_setup
    export http_proxy="http://proxyout.lanl.gov:8080"
    export https_proxy="http://proxyout.lanl.gov:8080"
    export ftp_proxy="http://proxyout.lanl.gov:8080"
    export HTTP_PROXY="http://proxyout.lanl.gov:8080"
    export HTTPS_PROXY="http://proxyout.lanl.gov:8080"
    export FTP_PROXY="http://proxyout.lanl.gov:8080"
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/anolan/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/anolan/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/anolan/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/anolan/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/anolan/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/anolan/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
