-- Override LazyVim's nvim-treesitter spec to ensure parsers are compiled from
-- source using the native toolchain. This avoids relying on the tree-sitter CLI
-- or prebuilt binaries that may be missing or incompatible with the current
-- platform (e.g. macOS Rosetta, HPC Linux systems without tree-sitter CLI).
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            -- Compile parsers from source instead of downloading prebuilt
            -- binaries, ensuring compatibility regardless of platform.
            require("nvim-treesitter.install").prefer_git = true

            -- lazy.nvim resets runtimepath and drops stdpath("data")/site, which
            -- is where nvim-treesitter installs parsers. Re-add it so parsers are
            -- found at startup.
            vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/site")

            return opts
        end,
    },
}
