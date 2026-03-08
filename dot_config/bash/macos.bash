perlmutter_login() {
    # SSH login helper for NERSC Perlmutter (macOS specific due to date -j syntax)
    local certfile="${HOME}/.ssh/nersc-cert.pub"

    # Check if the certification file exists
    if [[ ! -f "$certfile" ]]; then
        echo "Error: Certificate file not found at $certfile"
        return 1
    fi

    local valid
    valid=$(ssh-keygen -L -f "$certfile" | grep Valid)
    valid="${valid//+( )/}"      # Remove extra spaces
    valid="${valid/Valid/valid}" # Normalize

    # Extract expiration date from the "valid" line
    local expiry="${valid/valid*to /}"

    # Convert the date to epoch (macOS specific: date -j)
    local expepoch
    expepoch=$(date -j -f '%FT%T' $expiry +%s)

    # Get current datetime in epoch time
    local epoch
    epoch=$(date -j +%s)

    # Compute interval between expiration and now (minus 1 second for safety)
    local interval=$((expepoch - epoch - 1))

    # If key expired, re-run certification script
    if [[ $interval -le 0 ]]; then
        sshproxy.sh
    fi

    # SSH to perlmutter with up-to-date certification
    ssh perlmutter.nersc.gov "$@"
}
