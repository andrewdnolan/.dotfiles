-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- keymaps are automatically loaded on the verylazy event
-- default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua

-- no more pesky escape (for insert mode)
vim.keymap.set("i", "kj", "<Esc>", { noremap = true, desc = "Escape insert mode" })
vim.keymap.set("i", "kJ", "<Esc>", { noremap = true, desc = "Escape insert mode" })
vim.keymap.set("i", "Kj", "<Esc>", { noremap = true, desc = "Escape insert mode" })
vim.keymap.set("i", "KJ", "<Esc>", { noremap = true, desc = "Escape insert mode" })

-- Move to window using the <ctrl> hjkl keys
local Util = require("lazyvim.util")
local function map(mode, lhs, rhs, opts)
        local keys = require("lazy.core.handler").handlers.keys
        ---@cast keys LazyKeysHandler
        -- do not create the keymap if a lazy keys handler exists
        if not keys.active[keys.parse({ lhs, mode = mode }).id] then
                opts = opts or {}
                opts.silent = opts.silent ~= false
                vim.keymap.set(mode, lhs, rhs, opts)
        end
end

map("n", "<C-h>", "<cmd>lua require'tmux'.move_left()<cr>", { desc = "Go to left window" })
map("n", "<C-j>", "<cmd>lua require'tmux'.move_bottom()<cr>", { desc = "Go to lower window" })
map("n", "<C-k>", "<cmd>lua require'tmux'.move_top()<cr>", { desc = "Go to upper window" })
map("n", "<C-l>", "<cmd>lua require'tmux'.move_right()<cr>", { desc = "Go to right window" })
