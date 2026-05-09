if vim.fn.exists("g:vscode") ~= 1 then
    return {
        'saghen/blink.cmp',
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
            --snippet engine
            {
                'L3MON4D3/LuaSnip',
                version = '2.*',
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    {
                        'rafamadriz/friendly-snippets',
                        config = function()
                            require('luasnip.loaders.from_vscode').lazy_load()
                        end,
                    },
                },
                opts = {},
            },
        },
        ---@module 'blink.cmp'
        opts = {
            keymap = {
                preset = "default",
                ['<C-l>'] = { 'snippet_forward', 'fallback' },
                ['<C-h>'] = { 'snippet_backward', 'fallback' }
            },
            appearance = {
                nerd_font_variant = "mono",
                kind_icons = {
                    Text = "  ",
                    Method = "  ",
                    Function = "  ",
                    Constructor = "  ",
                    Field = "  ",
                    Variable = "  ",
                    Class = "  ",
                    Interface = "  ",
                    Module = "  ",
                    Property = "  ",
                    Unit = "  ",
                    Value = "  ",
                    Enum = "  ",
                    Keyword = "  ",
                    Snippet = "  ",
                    Color = "  ",
                    File = "  ",
                    Reference = "  ",
                    Folder = "  ",
                    EnumMember = "  ",
                    Constant = "  ",
                    Struct = "  ",
                    Event = "  ",
                    Operator = "  ",
                    TypeParameter = "  ",
                    DataBase = "  ",
                },
            },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                ghost_text = { enabled = true }
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lsp = { name = "[LSP]" },
                    buffer = { name = "[Buffer]" },
                    path = { name = "[Path]" },
                    snippets = { name = "[Snip]" }
                },
            },
            snippets = { preset = 'luasnip' },
            fuzzy = { implementation = 'lua' },
            signature = { enabled = true },
            cmdline = {
                keymap = { preset = "inherit" },
                completion = { menu = { auto_show = true } },
            }
        },
    }
end

return {}
