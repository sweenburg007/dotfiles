if vim.fn.exists("g:vscode") ~= 1 then
    local cmd = vim.api.nvim_create_autocmd
    local group = vim.api.nvim_create_augroup
    local opts = {clear = true}

    -- re-equalize splits on terminal resize
    cmd("VimResized",
        {
            pattern = {"*"},
            command = "wincmd =",
        }
    )

    cmd({ "BufWritePre" }, {
      pattern = { "*" },
      command = [[%s/\s\+$//e]],
    })
end
