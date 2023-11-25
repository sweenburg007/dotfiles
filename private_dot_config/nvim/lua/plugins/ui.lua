-- Themeing and UI changes
if vim.fn.exists("g:vscode") == 1 then
    return {
        'tanvirtin/monokai.nvim',
    }
else
    return {
        {
          "folke/tokyonight.nvim",
        },

        {
            "rebelot/kanagawa.nvim"
        },

        {
            'cesaralvarod/tokyogogh.nvim',
            lazy=false,
            priority=1000,
            config = function ()
                require('tokyogogh').setup {
                    style = 'storm' -- storm | night
                }
                vim.cmd([[colorscheme tokyogogh]])
            end
        },

        {'tanvirtin/monokai.nvim'},

        {
            "nvim-lualine/lualine.nvim",
            config = function() require("configs.lualine") end,
        },

        {
            "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}
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

