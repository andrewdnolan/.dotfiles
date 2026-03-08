-- Options ported from vimrc and customized for neovim/LazyVim
-- Many settings are already LazyVim defaults; only non-defaults are set here.

-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- highlight matching bracket or brace
vim.opt.showmatch = true

-- set tab to be 4 spaces for indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Instead of failing a command because of unsaved changes, raise a
-- dialogue asking if you wish to save changed files.
vim.opt.confirm = true

-- sane text files
vim.opt.fileformat = "unix"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- enables bash aliases from vim shell
vim.opt.shell = "bash"

-- better FORTRAN syntax highlighting
vim.g.fortran_fixed_source = 0
