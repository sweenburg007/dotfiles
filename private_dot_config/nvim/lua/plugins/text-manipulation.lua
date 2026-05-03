-- Text Manipulation
local plugins = {
    -- updated vim-surround
    {
        "kylechui/nvim-surround",
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
}


if vim.fn.exists("g:vscode") ~= 1 then
    table.insert(plugins,
        {
            -- visualization for undo tree
            {
                "mbbill/undotree",
                config = function()
                    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndotreeToggle" })
                end,
            },

            {
                "danymat/neogen",
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
                    vim.api.nvim_set_keymap(
                        "n", "<Leader>ng", ":lua require('neogen').generate()<CR>",
                        { noremap = true, silent = true, desc = "[N]eogen [G]enerate" }
                    )
                end,
            },
        }
    )
end

return plugins
