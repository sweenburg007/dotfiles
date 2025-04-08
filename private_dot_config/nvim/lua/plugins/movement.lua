-- Movement Plugins
return {
    -- tmux/vim interop
    "christoomey/vim-tmux-navigator",

    -- Best movement plugin for going through visual space
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()

            require("leap").add_repeat_mappings(";", "\\", {
                relative_directions = false,
            })

            vim.keymap.set({'n', 'x', 'o'}, 'ga',  function ()
              require('leap.treesitter').select()
            end)

            -- Linewise.
            vim.keymap.set({'n', 'x', 'o'}, 'gA',
              'V<cmd>lua require("leap.treesitter").select()<cr>'
            )
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

    -- cool searching
    {
        "kevinhwang91/nvim-hlslens",
        keys = {
            "n",
            "N",
            "*",
            "#",
            "/",
            "?",
        },
        opts = {
            calm_down = false,
            nearest_only = true,
            virt_priority = 10,
        },
    },

    {
        "cbochs/portal.nvim",
        dependencies = {
            "cbochs/grapple.nvim",
            "ThePrimeagen/harpoon"
        },
    },
}
