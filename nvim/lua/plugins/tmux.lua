-- Seamless navigation, pane resize, and copy sync between tmux and neovim
-- https://github.com/aserowy/tmux.nvim
return {
    {
        "aserowy/tmux.nvim",
        opts = {
            copy_sync = {
                -- sync registers *, +, unnamed, and 0-9 with tmux buffers
                enable = true,
            },
            navigation = {
                -- cycle to opposite pane when navigating beyond the border
                cycle_navigation = true,
                -- enable default C-hjkl keybindings in normal mode
                enable_default_keybindings = true,
            },
            resize = {
                -- enable default M-hjkl keybindings in normal mode
                enable_default_keybindings = true,
                resize_step_x = 2,
                resize_step_y = 2,
            },
        },
    },
}
