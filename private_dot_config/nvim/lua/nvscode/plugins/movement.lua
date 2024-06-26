return {
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
        lazy = false,
        config = function()
            require('telepath').use_default_mappings()
        end
    },
}
