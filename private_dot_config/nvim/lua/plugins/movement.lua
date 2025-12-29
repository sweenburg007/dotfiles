-- Movement Plugins
return {
    -- tmux/vim interop
    "christoomey/vim-tmux-navigator",

    -- Best movement plugin for going through visual space
    {
        "ggandor/leap.nvim",
        dependencies = { "tpope/vim-repeat" },
        config = function()
            vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
            vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

            vim.keymap.set({ 'n', 'o' }, 'gs', function()
                require('leap.remote').action {
                    -- Automatically enter Visual mode when coming from Normal.
                    input = vim.fn.mode(true):match('o') and '' or 'v'
                }
            end)

            -- Forced linewise version (`gS{leap}jjy`):
            vim.keymap.set({ 'n', 'o' }, 'gS', function()
                require('leap.remote').action { input = 'V' }
            end)

            -- treesitter leaping
            vim.keymap.set({ 'x', 'o' }, 'R', function()
                require('leap.treesitter').select {
                    opts = require('leap.user').with_traversal_keys('R', 'r')
                }
            end)
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
