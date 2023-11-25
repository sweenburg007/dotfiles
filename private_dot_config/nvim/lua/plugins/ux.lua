-- UX changes and add-ons

if vim.fn.exists("g:vscode") ~= 1 then

    return {
        -- repeate motions from plugins and elsewhere
        "tpope/vim-repeat",

        -- telescope - arbitrary fuzzy-searching over lists
        {
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            dependencies = {
                "nvim-lua/plenary.nvim",

                -- search luasnip snippets from inside telescope
                {
                    "benfowler/telescope-luasnip.nvim",
                    config = function()
                        require("telescope").load_extension("luasnip")
                    end
                },

                -- faster compiled fzf
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                    config = function ()
                        require("telescope").load_extension("fzf")
                    end
                },
            },
            config = function() require "configs.telescope" end,
        },

        {
            "folke/trouble.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
        },

        -- git signs in gutter, management of hunks ;) and simple diff views
        {
            "lewis6991/gitsigns.nvim",
            config = function() require "configs.gitsigns" end,
        },

        -- better viewer for git history, git diffs
        {
            "sindrets/diffview.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = { use_icons = false },
        },

        -- use git from inside vim (e.g. `:Git commit`)
        "tpope/vim-fugitive",
    }
else
    return {
        -- repeate motions from plugins and elsewhere
        "tpope/vim-repeat",
    }
end
