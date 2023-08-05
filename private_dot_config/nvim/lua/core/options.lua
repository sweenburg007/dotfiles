-- set the main colorscheme
vim.cmd.colorscheme("one_monokai")

-- set main options
local options = {
    g = {
        rainbow_active = 1,
    },

    opt = {
        -- relativenumber = true,
        number = true,
        -- nowrap = true,
        wrap = false,

        expandtab = true,
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,

        -- case-insensitivity, smaek search for /, ?
        ignorecase = true,
        smartcase = true,

        -- autoread changes made outside of vim
        autoread = true,

        -- identify cursor line number visually
        -- cursourlineopt=both (line and number) is too much
        cursorline = true,
        cursorlineopt = "number,line",
    },
}

-- set vim options with a nested talbe like API with the format
--     vim.<first_key>.<second_key>.<value>
for scope, table in pairs(options) do
    for setting, value in pairs(table) do
        vim[scope][setting] = value
    end
end
