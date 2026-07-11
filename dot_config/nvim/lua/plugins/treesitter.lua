return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "bibtex",
        "c",
        "cmake",
        "cpp",
        "diff",
        "fortran",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "jinja",
        "julia",
        "latex",
        "make",
        "markdown",
        "markdown_inline",
        "perl",
        "python",
        "rst",
        "tmux",
        "toml"
      })
    end,
  },
}
