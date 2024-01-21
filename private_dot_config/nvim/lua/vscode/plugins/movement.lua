return {
    -- CamelCase and snake case movements
    "bkad/CamelCaseMotion",

    -- Best movement plugin for going through visual space
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()

            require("leap").add_repeat_mappings(";", "\\", {
                relative_directions = false,
            })
        end,
    },

    -- multi-line f/t
    {
        "ggandor/flit.nvim",
        opts = {
            labeled_modes = "n",
            special_keys = {
                repeat_search = { "<Enter>" },
            },
            opts = {
                special_keys = {
                    repeat_search = { "<Enter>" },
                }
            },
        },
    },

    {
        'rasulomaroff/telepath.nvim',
        dependencies = 'ggandor/leap.nvim',
        -- there's no sence in using lazy loading since telepath won't load the main module
        -- until you actually use mappings
        lazy = false,
        config = function()
            require('telepath').use_default_mappings()
        end
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("harpoon").setup()
        end
    }
}
