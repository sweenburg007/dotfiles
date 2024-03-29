-- Telescope searching
local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup {
    defaults = {
        -- ignore patters for certain folders
        file_ignore_pattersn = { ".venv", "target" },

        -- trim leading space from matches
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim" -- add this value
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
            mappings = {
                i = { ["<Tab>"] = actions.to_fuzzy_refine }
            }
        }
    }
}
