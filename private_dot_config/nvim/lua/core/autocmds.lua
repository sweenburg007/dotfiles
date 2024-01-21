local cmd = vim.api.nvim_create_autocmd

-- re-equalize splits on terminal resize
cmd("VimResized",
    {
        pattern = { "*" },
        command = "wincmd =",
    }
)

cmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})
