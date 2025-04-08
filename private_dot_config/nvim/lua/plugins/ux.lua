-- UX changes and add-ons
return {
    -- repeate motions from plugins and elsewhere
    "tpope/vim-repeat",

    -- telescope - arbitrary fuzzy-searching over lists
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                config = function()
                    require("telescope").load_extension("fzf")
                end
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            {
                'nvim-tree/nvim-web-devicons',
                enabled = vim.g.have_nerd_font
            },
        },
        config = function()
            local actions = require("telescope.actions")
            require('telescope').setup {
                defaults = {
                    file_ignore_pattersn = { ".venv", "target" },
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close
                        }
                    },
                    extensions = {
                        ['ui-select'] = {
                            require('telescope.themes').get_dropdown(),
                        },
                    },
                },
            }
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            -- show numbers in telescope preview window
            vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
        end,
    },

    -- git signs in gutter, management of hunks ;) and simple diff views
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({
                numhl = true,
                current_line_blame = true,
                current_line_blame_opts = { delay = 500 },
                signs = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                }
            })
        end,
    },
}
