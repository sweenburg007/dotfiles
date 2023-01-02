-- telescope searching configuration
--
local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup {
    defaults = {
        vimgrep_arguments = {

        },

        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-u>"] = false
            },
        },

        extensions = { fzf },
    },

    pickers = {
        live_grep = {
            i = { ["<Tab>"] = actions.to_fuzzy_refine }
        }
    }
}

telescope.load_extension("fzf")
telescope.load_extension("luasnip")
