if vim.fn.exists("g:vscode") ~= 1 then
    -- tree-sitter
    require("nvim-treesitter.configs").setup {
        ensure_installed = {"rust", "python", "c", "verilog", "matlab"},
        ignore_install = {"phpdoc", "php", "t32"},
        sync_install = false,

        highlight = {
            enable = true,
            disable = {},
            additional_vim_regex_highlighting = false,
        },

        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<M-n>",
                node_incremental = "<M-n>",
                scope_incremental = "<M-p>",
                node_decremental = "<M-i>",
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
            enable = true,
            extended_mode = true,
        },

        -- provided by nvim-treesitter/playground
        playground = {
            enable = true,
            disable = {},
            updatetime = 25,
            persist_queries = false,
            keybindings = {
                toggle_query_editor = "o",
                toggle_hl_groups = "i",
                toggle_injected_languages = "t",
                toggle_anonymous_nodes = "a",
                toggle_language_display = "I",
                focus_language = "f",
                unfocus_language = "F",
                update = "R",
                goto_node = "<cr>",
                show_help = "?",
            },
        },

        -- lint playground queries
        query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = { "InsertLeave" },
        },
    }

    require("various-textobjs").setup{
        useDefaultKeymaps = false,
        disabledKeymaps = {"yR", "yr"},
    }

else
    require("nvim-treesitter.configs").setup {
        ensure_installed = {"rust", "python", "c", "verilog", "matlab"},
        ignore_install = {"phpdoc", "php", "t32"},
        sync_install = false,

        highlight = {
            enable = false,
        },

        incremental_selection = {
            enable = false
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
                enable = false,
            },

            swap = {
                enable = false,

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

    require("various-textobjs").setup{
        useDefaultKeymaps = false,
        disabledKeymaps = {"yR", "yr"},
    }

end
