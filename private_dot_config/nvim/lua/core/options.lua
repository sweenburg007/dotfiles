-- set color scheme
vim.cmd.colorscheme("catppuccin-mocha")

local options = {
    g = {
        have_nerd_font = true
    },
    opt = {
        number = true,
        relativenumber = true,
        wrap = false,

        expandtab = true,
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,

        -- allow mouse control
        mouse = "a",

        -- case-insensitive, smart search for /, ?
        ignorecase = true,
        smartcase = true,

        -- autoread changes outside of nvim
        autoread = true,

        -- persistent undo!
        undofile = true,

        splitbelow = true,
        splitright = true,

        cursorline = true,
        cursorlineopt = "number,line",

        inccommand = "split",
        scrolloff = 10,
        hlsearch = true
    },
}

-- Set vim options with a neted table like API with the format vim.<first_key>.<second_key>.<value>
-- @parma options the nested table of vim options
for scope, table in pairs(options) do
    for setting, value in pairs(table) do
        vim[scope][setting] = value
    end
end

-- LSP Diagnostics - better signs
local signs = {
    DiagnosticSignError = "x",
    DiagnosticSignWarn = "!",
    DiagnosticSignInfo = ">",
    DiagnosticSignHint = "?",
}

for name, icon in pairs(signs) do
    vim.fn.sign_define(name, { text = icon, texthl = name })
end
