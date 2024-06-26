require("nvim-treesitter.configs").setup {
    ensure_installed = { "rust", "python", "c", "verilog", "matlab" },
    ignore_install = { "phpdoc", "php", "t32" },
    sync_install = false,

    highlight = {
        enable = false,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gis",
            node_incremental = "gni",
            scope_incremental = "gsi",
            node_decremental = "gnd",
        }
    },

    indent = {
        enable = false,
    },

    -- setup text objects
    textobjects = {
        select = {
            enable = true,

            -- automatically jump forward to textobj
            lookahead = true,

            keymaps = {
                ["aF"] = "@function.outer",
                ["iF"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ip"] = "@parameter.inner",
                ["ap"] = "@parameter.outer",

                ["iv"] = "@assignment.rhs",
                ["ik"] = "@assignment.lhs",
                ["in"] = "@number.inner",

                -- system verilog specific text objects (NOTE: will need updated ts parser)
                ["am"] = "@mod-head.outer",
                ["aP"] = "@parameter-port-list.outer",
                ["al"] = "@list-of-port-declarations.outer",
            },
        },

        -- TODO: neovim provides mappings for jumping over functions
        -- [[, ]], [m, ]M,
        -- should i add these as text object movements, or keep them as nvim-provided?
        move = {
            enable = true,
            set_jumps = true,

            goto_next_start = {
                ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
                ["]A"] = "@parameter.outer",
            },
            goto_previous_start = {
                ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["[A"] = "@parameter.outer",
            },
        },

        swap = {
            enable = true,

            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },

    -- provided by p00f/nvim-ts-rainbow
    rainbow = {
        enable = false,
        extended_mode = false,
    },

    -- provided by nvim-treesitter/playground
    playground = {
        enable = false,
    },

    -- lint playground queries
    query_linter = {
        enable = false,
        use_virtual_text = false,
    },
}
