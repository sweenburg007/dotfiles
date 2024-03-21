-- Themeing and UI changes
return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },

    {
        "nvim-lualine/lualine.nvim",
        config = function() require("configs.lualine") end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },

    -- re-color window split borders
    {
        "nvim-zh/colorful-winsep.nvim",
        opts = {
            highlight = { ctermfg = 2 },
        },
    },

    -- updated vim ui, needed to make noice less annoyning
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {
            input = { enabled = false },
        },
    },

    -- noice setup
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                signature = {
                    enabled = false,
                },
            },
        },
    },
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false }
    },

}
