-- Seamless navigation, pane resize, and copy sync between tmux and neovim
-- https://github.com/aserowy/tmux.nvim
return {
	{
		-- Generate a tmux statusline that matches the neovim colorscheme.
		-- After changing themes, re-run :TmuxlineSnapshot ~/.tmux/tmuxline.conf
		-- to export an updated static snapshot that persists when nvim is closed.
		-- https://github.com/edkolev/tmuxline.vim
		"edkolev/tmuxline.vim",
		cond = function()
			return vim.env.TMUX
		end,
		init = function()
			-- Use powerline-style separators (requires a patched/Nerd font)
			vim.g.tmuxline_powerline_separators = 1
		end,
	},
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
