if vim.fn.exists("g:vscode") ~= 1 then
    return {
        'ThePrimeagen/vim-be-good',

        'MortenStabenau/matlab-vim',
        "yinflying/matlab.vim",
    },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true,
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*"
    }

else
    return {}
end
