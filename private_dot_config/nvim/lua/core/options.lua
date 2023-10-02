-- set color scheme
if vim.fn.exists("g:vscode") ~= 1 then
    vim.cmd.colorscheme("tokyonight-storm")
else
    vim.cmd.colorscheme("monokai")
end

local options = {
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
        cursorlineopt = "number,line"
    },
}

for scope, table in pairs(options) do
    for setting, value in pairs(table) do
    vim[scope][setting] = value
    end
end
