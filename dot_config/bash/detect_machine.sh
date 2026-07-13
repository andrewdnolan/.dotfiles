dotfiles_machine() {

    local host="$(hostname -s)"
    local domain="$(hostname -d)"

    if [[ $host == "pn"* ]] && [[ $domain == *"lanl"* ]]; then
        platform="macos"
        machine="macbook"
    elif [[ $host == "ch-fe"* ]] && [[ $domain == *"lanl"* ]]; then
        platform="LANL_IC"
        machine="chicoma"
    elif [[ $host == "login"* ]] && [[ $domain == *"perlmutter"* ]]; then
        platform="nersc"
        machine="perlmutter"
    elif [[ $host == "chr"* ]] && [[ $domain == *"lcrc.anl.gov"* ]]; then
        platform="lcrc"
        machine="chrysalis"
    elif [[ $host == "ilog"* ]] && [[ $domain == *"lcrc.anl.gov"* ]]; then
        platform="lcrc"
        machine="improv"
    elif [[ $host == "cedar"* ]] && [[ $domain == *"computecanada.ca"* ]]; then
        platform="computecanada"
        machine="cedar"
    elif [[ $domain == *"aurora.alcf.anl.gov" ]]; then
        platform="alcf"
        machine="aurora"
    elif [[ $domain == *"polaris.alcf.anl.gov" ]]; then
        platform="alcf"
        machine="polaris"
    fi

    printf '%s\n' $machine
}
