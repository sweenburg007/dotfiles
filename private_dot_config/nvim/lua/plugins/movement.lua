-- Movement Plugins
local plugins = {

    -- Best movement plugin for going through visual space
    {
        url = "https://codeberg.org/andyg/leap.nvim",
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

            -- enhanced f/t motions from flit
            local function ft(key_specific_args)
                require('leap').leap(
                    vim.tbl_deep_extend('keep', key_specific_args, {
                        -- Uncomment to limit search scope to the current line:
                        -- pattern = function(pat) return '\\%.l' .. pat end,
                        inputlen = 1,
                        inclusive = true,
                        opts = {
                            -- Force autojump.
                            labels = '',
                            -- Match the modes where you don't need labels (`:h mode()`).
                            safe_labels = vim.fn.mode(1):match('o') and '' or nil,
                        },
                    })
                )
            end

            -- A helper function making it easier to set "clever-f" behavior
            -- (use f/F or t/T instead of ;/, - see the plugin clever-f.vim).
            local clever = require('leap.user').with_traversal_keys
            local clever_f, clever_t = clever('f', 'F'), clever('t', 'T')

            vim.keymap.set({ 'n', 'x', 'o' }, 'f', function()
                ft { opts = clever_f }
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, 'F', function()
                ft { backward = true, opts = clever_f }
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, 't', function()
                ft { offset = -1, opts = clever_t }
            end)
            vim.keymap.set({ 'n', 'x', 'o' }, 'T', function()
                ft { backward = true, offset = 1, opts = clever_t }
            end)
        end,
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
}
if vim.fn.exists("g:vscode") ~= 1 then
    table.insert(plugins, {
        -- tmux/vim interop
        "christoomey/vim-tmux-navigator",
    })
end

return plugins
