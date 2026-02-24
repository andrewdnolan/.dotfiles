-- Autocmds ported from vimrc

-- python specific colorcolumn following PEP8
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.colorcolumn = "80"
    end,
})

-- enable xml syntax highlighting for MPAS streams files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "streams.landice", "streams.ocean", "streams.seaice" },
    callback = function()
        vim.opt_local.filetype = "xml"
    end,
})
