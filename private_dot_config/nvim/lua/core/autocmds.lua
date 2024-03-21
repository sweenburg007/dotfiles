vim.api.nvim_create_autocmd(
    "VimResized",
    {
        desc = "Re-equalize splits on terminal resize",
        pattern = { "*" },
        command = "wincmd =",
    }
)

vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        desc = "Delete trailing whitespace on save",
        pattern = { "*" },
        command = [[%s/\s\+$//e]],
    }
)

vim.api.nvim_create_autocmd(
    "TextYankPost",
    {
        desc = "Highlight when yanking (copying) text",
        callback = function()
            vim.highlight.on_yank()
        end
    }
)
