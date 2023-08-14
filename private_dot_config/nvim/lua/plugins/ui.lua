-- Themeing and UI changes
if vim.fn.exists("g:vscode") == 1 then
    return {
        'tanvirtin/monokai.nvim',
        -- {
        --     "catppuccin/nvim", name = "catppuccin", priority = 1000
        -- },
    }
else
    return {
        'tanvirtin/monokai.nvim',
        -- {
        --     "catppuccin/nvim", name = "catppuccin", priority = 1000
        -- },

        {
            "nvim-lualine/lualine.nvim",
            config = function() require("configs.lualine") end,
        },

        {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                vim.opt.list = true
                vim.opt.listchars:append "space:⋅"
                vim.opt.listchars:append "eol:↴"

                require("indent_blankline").setup {
                    space_char_blankline = " ",
                    show_current_context = true,
                    show_current_context_start = true,
                }
            end,
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
                input = {enabled = false},
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
    }
end
