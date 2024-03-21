local options = {
    opt = {
        -- case-insensitive, smart search for /, ?
        ignorecase = true,
        smartcase = true
    },
}

for scope, table in pairs(options) do
    for setting, value in pairs(table) do
        vim[scope][setting] = value
    end
end
