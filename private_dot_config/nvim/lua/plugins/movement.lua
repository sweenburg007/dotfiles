-- Movement Plugins

if vim.fn.exists("g:vscode") ~= 1 then
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
else
    return {
        -- CamelCase and snake case movements
        "bkad/CamelCaseMotion",

        -- Best movement plugin for going through visual space
        {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
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
        }
    }
end

