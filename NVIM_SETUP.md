# Machine-Specific NeoVim Setup

## Overview

This chezmoi configuration automatically selects the appropriate NeoVim installation method based on your machine's platform and GLIBC version:

- **Machines with GLIBC ≥ 2.29** (local/modern systems): Use mise-managed nvim (faster, prebuilt binaries)
- **HPC/Cluster systems with GLIBC < 2.29** (LCRC, OLCF, NERSC): Spack-compiled standalone nvim

### Key Design Goals

- **Standalone nvim binary**: Built with spack but extracted to `~/.local/bin` — no need to source spack environment
- **Project spack environments protected**: Your work-related spack envs (set via `spack env activate`) take full precedence
- **Consistent interface**: `nvim` command works the same on all machines regardless of installation method
- **Centralized tool management**: All tools live in `~/.local` (mise, spack, nvim binary)

## How It Works

### Machine Detection

The file `.chezmoi.yaml.tmpl` detects your platform via hostname pattern matching:

```
GLIBC 2.28 systems (requires spack compilation):
  - lcrc (LCRC clusters)
  - olcf (OLCF systems)
  - nersc (NERSC systems)
  - lanl_macbook (for testing or future Darwin systems with GLIBC issues)

All other systems (uses mise):
  - Default: moderne machines with compatible GLIBC
```

### Configuration Files

1. **`.chezmoi.yaml.tmpl`** - Detects platform and sets `nvim_source`
2. **`dot_config/mise/mise.toml`** - Conditionally excludes neovim if using spack
3. **`.chezmoiscripts/run_once_setup_nvim.sh.tmpl`** - Builds nvim with spack (if needed) and extracts binary
4. **`dot_bashrc.tmpl`** - Simple PATH setup (no spack environment sourcing needed!)
5. **`dot_config/spack/packages.yaml`** - Build specs for spack neovim

### Installation Flow

#### On LCRC/OLCF/NERSC machines:

1. Chezmoi detects platform, sets `nvim_source = "spack"`
2. `.chezmoiscripts/run_once_setup_nvim.sh` executes:
   - Clones spack to `~/.local/share/spack` (one time only)
   - Builds neovim with spack (first time ~10-15 min)
   - Extracts standalone nvim binary to `~/.local/bin/nvim`
   - Creates marker file tracking the spack build location
3. `~/.bashrc` adds `~/.local/bin` to PATH (already done for mise)
4. User can run `nvim` without any spack environment loaded
5. Project spack environments (via `spack env activate my-project`) work normally

#### On modern systems:

1. Chezmoi detects machine, sets `nvim_source = "mise"`
2. Mise installs neovim 0.11.6 as usual
3. No spack involvement

## Adding New Machines

To add a platform that needs spack-compiled nvim:

1. Edit `.chezmoi.yaml.tmpl`
2. Add detection logic for your platform (via hostname pattern)
3. Add platform name to `$spack_machines` list

Example for a new cluster:

```bash
{{- else if contains "mycluster.org" $hostname -}}
    {{- $machine = "mycluster" -}}
```

Then add to spack list:
```bash
{{- $spack_machines := list "lcrc" "olcf" "nersc" "mycluster" -}}
```

Or override per-machine by editing `~/.config/chezmoi/chezmoi.yaml` after chezmoi init:

```yaml
nvim_source: spack
```

## Manual Override

To force mise on an HPC system or spack on a local machine:

```bash
chezmoi edit-config
```

Add or modify:
```yaml
nvim_source: mise   # or "spack"
```

Then re-run:
```bash
chezmoi apply
```

## How This Avoids Spack Environment Conflicts

**Problem**: If you source spack environment for nvim, it interferes with project spack environments you activate later.

**Solution**: We extract the nvim binary after building it, then it runs standalone:

```bash
# Your workflow remains clean
spack env activate my-project
nvim some_file.f90  # Uses spack-compiled nvim, but doesn't load spack env
module load some_module  # Can load any modules without conflict
```

The spack environment used only for building is NOT persistent in your shell.

## Verification

After running `chezmoi apply`:

```bash
# Check which nvim is being used
which nvim
nvim --version

# On spack machines, verify standalone binary
file ~/.local/bin/nvim  # Should show it's a statically/dynamically linked executable
cat ~/.local/bin/.nvim_spack_path  # Shows where it was built from (for reference)

# Project spack environment should work fine
spack env list
spack env activate my-project
which nvim  # Still shows ~/.local/bin/nvim
```

## Troubleshooting

### "nvim: command not found"
- Verify `~/.local/bin` is in PATH: `echo $PATH`
- Should be added by bashrc if `~/.local/bin` exists
- Verify binary was created: `ls -la ~/.local/bin/nvim`

### "GLIBC_2.29 not found" even after setup
- Setup script may have failed. Check what happened:
  ```bash
  cat ~/.local/bin/.nvim_spack_path
  spack find neovim
  ```
- Try manual build: `spack install neovim --verbose`
- Then extract: `cp $(spack location -i neovim)/bin/nvim ~/.local/bin/`

### Spack clone failed
- Ensure git is available: `which git`
- Try manually: `git clone https://github.com/spack/spack.git ~/.local/share/spack`
- Then re-run: `chezmoi apply`

### Binary extracted but doesn't run
- Check dependencies: `ldd ~/.local/bin/nvim`
- May need older gcc module. Edit `dot_config/spack/packages.yaml` to specify gcc version
- Rebuild: `rm ~/.local/bin/nvim && spack uninstall neovim && chezmoi apply`

## Future Improvements

- Detect GLIBC version automatically instead of hardcoding platforms
- Build caching across machines using spack binary mirror/cache
- Optional: Use `spack view` to create lightweight symlink view instead of copying binary
- Optional: Build with newer GCC compiler for better performance on HPC systems
- Automatic cleanup of old spack installations
