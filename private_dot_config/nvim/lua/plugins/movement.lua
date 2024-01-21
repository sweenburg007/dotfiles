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

            vim.keymap.set("n", "<leader>qi", function() harpoon:list():append() end)
            vim.keymap.set("n", "<leader>qo", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<leader>qh", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>qj", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>qk", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>ql", function() harpoon:list():select(4) end)

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<C-h-p>", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<C-h-n>", function() harpoon:list():next() end)

            -- clear items from harpoon list
            vim.keymap.set("n", "<leader>qd", function() harpoon:list():clear() end) -- all
            vim.keymap.set("n", "<leader>qH", function() harpoon:list():removeAt(1) end) -- 1
            vim.keymap.set("n", "<leader>qJ", function() harpoon:list():removeAt(2) end) -- 2
            vim.keymap.set("n", "<leader>qK", function() harpoon:list():removeAt(3) end) -- 3
            vim.keymap.set("n", "<leader>qL", function() harpoon:list():removeAt(4) end) -- all
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
