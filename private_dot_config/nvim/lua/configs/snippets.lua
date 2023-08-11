if vim.fn.exists("g:vscode") ~= 1 then
    -- personal snippets
    local ls = require('luasnip')
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
end
