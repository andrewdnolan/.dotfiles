-- Keymaps ported from vimrc

-- no more pesky escape (for insert mode)
vim.keymap.set("i", "kj", "<Esc>", { noremap = true, desc = "Escape insert mode" })
vim.keymap.set("i", "kJ", "<Esc>", { noremap = true, desc = "Escape insert mode" })
vim.keymap.set("i", "Kj", "<Esc>", { noremap = true, desc = "Escape insert mode" })
vim.keymap.set("i", "KJ", "<Esc>", { noremap = true, desc = "Escape insert mode" })
