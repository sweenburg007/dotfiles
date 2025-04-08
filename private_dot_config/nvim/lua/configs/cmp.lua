-- required for nvim-cmp
vim.opt.completeopt = "menu,menuone,noselect"

-- Setup nvim-cmp.
local cmp = require("cmp")
local map = cmp.mapping
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- annotate completion candidates in Pmenu (vscode-like)
-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-codicons-to-the-menu
-- had to install nerd-fonts-patched FantasqueSansMono to get this to work:
-- https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono
local kind_icons = {
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
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    -- cmp.mapping.preset.{insert,cmdline} sets some default bindings.
    -- see: https://github.com/hrsh7th/nvim-cmp/issues/231#issuecomment-1098175017
    -- and: https://github.com/hrsh7th/nvim-cmp/commit/93cf84f7deb2bdb640ffbb1d2f8d6d412a7aa558
    -- TODO - in light of this removal, this bindings could probably be cleaned up in the future.
    mapping = map.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { 'i', 's' }),
    }),

    sources = cmp.config.sources({
        { name = "path" },
        { name = "nvim_lsp", keyword_length = 3 },
        { name = "buffer",   keyword_length = 3 },
        { name = "luasnip",  keyword_length = 2 },
    }),

    formatting = {
        format = function(entry, vim_item)
            local kind_menu = {
                path = "[Path]",
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[luasnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
            }

            -- README says it marks completion items, but it's not showing up for me
            kind_menu["vim-dadbod-completion"] = "[DB]"

            if entry.source.name == "vim-dadbod-completion" then
                vim_item.kind = "DataBase"
            end

            -- Kind icons
            -- Concatenate the icons with the name of the item kind
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            -- Source
            vim_item.menu = kind_menu[entry.source.name]
            return vim_item
        end
    }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" }
    },
    mapping = map.preset.cmdline({}),
})

-- triggered by input() (e.g. LSP renames, conditional breakpoints, etc)
cmp.setup.cmdline("@", {
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    },
    mapping = map.preset.cmdline({}),
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    }),
    mapping = map.preset.cmdline({}),
})

-- Ensure we still have buffer completion in SQL files opened without DBUI
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
        cmp.setup.buffer({
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
                { name = "luasnip" },
            }
        })
    end,
})

-- mute diagnostics by default, too noisy
vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        source = true, -- Show diagnostic source
        format = function(diagnostic)
            local source = diagnostic.source
            local msg = diagnostic.message

            -- Format based on severity
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
                return string.format("[%s] Error: %s", source, msg)
            elseif diagnostic.severity == vim.diagnostic.severity.WARNING then
                return string.format("[%s] Warning: %s", source, msg)
            else
                return string.format("[%s] %s", source, msg)
            end
        end
    },
})

cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done()
)
