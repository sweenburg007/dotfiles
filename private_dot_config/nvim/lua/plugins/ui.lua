-- Themeing and UI changes
local plugins = {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
    {
        'folke/tokyonight.nvim',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('tokyonight').setup {
                styles = {
                    comments = { italic = false }, -- Disable italics in comments
                },
            }
        end,
    },
    {
        "rebelot/kanagawa.nvim"
    },
    {
        "ellisonleao/gruvbox.nvim"
    },
    {
        "shaunsingh/nord.nvim"
    },
    {
        "shatur/neovim-ayu"
    }
}
if vim.fn.exists("g:vscode") ~= 1 then
    table.insert(plugins, {

        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            opts = {},
        },

        -- re-color window split borders
        {
            "nvim-zh/colorful-winsep.nvim",
            config = true,
            event = { "WinLeave" },
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
            "folke/todo-comments.nvim",
            event = "VimEnter",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = { signs = false },
        },

        {
            "nvim-lualine/lualine.nvim",
            config = function()
                require("configs.lualine")
            end,
        },
    })
end

return plugins
