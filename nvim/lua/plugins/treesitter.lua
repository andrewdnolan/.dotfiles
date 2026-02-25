-- Override LazyVim's nvim-treesitter spec to fix architecture mismatches on macOS.
-- When neovim is installed for x86_64 (e.g. via Rosetta) and later run on Apple
-- Silicon, pre-built parser binaries are incompatible. Setting prefer_git = true
-- forces nvim-treesitter to compile parsers from source using the native toolchain.
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if vim.fn.has("mac") == 1 then
                -- Compile parsers from source instead of downloading prebuilt
                -- binaries, ensuring they match the current CPU architecture.
                require("nvim-treesitter.install").prefer_git = true
            end
            return opts
        end,
    },
}
