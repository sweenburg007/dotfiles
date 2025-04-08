-- Text Manipulation

return {
    -- updated vim-surround
    {
        "kylechui/nvim-surround",
        config = true,
    },

    -- TS aware commenting
    {
        "numToStr/Comment.nvim",
        config = true,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local autopairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")
            local cond = require("nvim-autopairs.conds")

            autopairs.setup({})

            autopairs.add_rules {
                -- autopair<>
                -- all languages? or just xml/langs w/ <> generics?
                Rule("<", ">")
                    :with_pair(cond.before_regex("%a+"))
                    :with_move(function(opts)
                        return opts.char == ">"
                    end),
                -- autopair||  <-- this one might be buggy? oh well
                Rule("|", "|", "rust")
                -- match letters or open parens
                    :with_pair(cond.before_regex("[%a(]+"))
                    :with_move(function(opts)
                        return opts.char == "|"
                    end),
            }
        end,
    },

    -- visualization for undo tree
    "mbbill/undotree",

    -- handy docstring generator
    {
        "danymat/neogen",
        -- dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("neogen").setup({
                snippet_engine = "luasnip",
                languages = {
                    python = {
                        template = {
                            annotation_convention = "numpydoc"
                        }
                    }
                }
            })
        end,
    },
}
