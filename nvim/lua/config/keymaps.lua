-- Keymaps ported from vimrc

-- no more pesky escape (for insert mode)
vim.keymap.set("i", "kj", "<Esc>", { noremap = true, desc = "Escape insert mode" })
vim.keymap.set("i", "kJ", "<Esc>", { noremap = true, desc = "Escape insert mode" })
vim.keymap.set("i", "Kj", "<Esc>", { noremap = true, desc = "Escape insert mode" })
vim.keymap.set("i", "KJ", "<Esc>", { noremap = true, desc = "Escape insert mode" })

-- Tmux/neovim split navigation.
-- LazyVim sets <C-hjkl> to plain <C-w>hjkl on VeryLazy, which stops at the
-- neovim window border and never crosses into an adjacent tmux pane.  User
-- keymaps (this file) are sourced by LazyVim *after* its own defaults, so
-- these definitions reliably override them and restore the tmux.nvim behaviour.
vim.keymap.set("n", "<C-h>", function() require("tmux").move_left() end,   { desc = "Navigate left (nvim/tmux)" })
vim.keymap.set("n", "<C-j>", function() require("tmux").move_bottom() end, { desc = "Navigate down (nvim/tmux)" })
vim.keymap.set("n", "<C-k>", function() require("tmux").move_top() end,    { desc = "Navigate up (nvim/tmux)" })
vim.keymap.set("n", "<C-l>", function() require("tmux").move_right() end,  { desc = "Navigate right (nvim/tmux)" })
