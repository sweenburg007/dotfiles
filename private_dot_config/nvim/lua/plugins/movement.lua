-- Movement Plugins
return {
    -- CamelCase and snake case movements
    "bkad/CamelCaseMotion",

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
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>hi", function() harpoon:list():append() end)
            vim.keymap.set("n", "<leader>hv", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<leader>hh", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>hj", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>hk", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>hl", function() harpoon:list():select(4) end)

            -- -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<C-h>p", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<C-h>n", function() harpoon:list():next() end)

            -- -- clear items from harpoon list
            vim.keymap.set("n", "<leader>hd", function() harpoon:list():clear() end)     -- all
            vim.keymap.set("n", "<leader>hH", function() harpoon:list():removeAt(1) end) -- 1
            vim.keymap.set("n", "<leader>hJ", function() harpoon:list():removeAt(2) end) -- 2
            vim.keymap.set("n", "<leader>hK", function() harpoon:list():removeAt(3) end) -- 3
            vim.keymap.set("n", "<leader>hL", function() harpoon:list():removeAt(4) end) -- all
        end
    },

    {
        "cbochs/portal.nvim",
        dependencies = {
            "cbochs/grapple.nvim",
            "ThePrimeagen/harpoon"
        },
    },
}
