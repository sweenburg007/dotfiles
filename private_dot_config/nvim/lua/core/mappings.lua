-- Setup all key mappings

-- ---- Helper functions
local global_opts = { noremap = true, silent = true }

local keymap = function(mode, lhs, rhs, options)
    local opts = options or global_opts
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- Main copy keybindings
keymap("v", "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+yg_')
keymap("n", "<leader>y", '"+y')
keymap("n", "<leader>yy", '"+yy')

-- paste from system: clipboard
keymap("n", "<leader>p", '"+p')
keymap("n", "<leader>P", '"+P')
keymap("v", "<leader>p", '"+p')
keymap("v", "<leader>P", '"+P')

-- clear search highlighting
keymap("n", "<leader><space>", "<cmd>noh<cr>")

-- center search results
-- */# searches are centered below, in hlslens keybinds
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- chmod current file to executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- camelcasemotion
keymap("", "<leader>w", "<Plug>CamelCaseMotion_w")
keymap("", "<leader>b", "<Plug>CamelCaseMotion_b")
keymap("", "<leader>e", "<Plug>CamelCaseMotion_e")
keymap("", "<leader>ge", "<Plug>CamelCaseMotion_ge")

vim.keymap.set({ "o", "x" }, "<leader>iw", "<Plug>CamelCaseMotion_iw")
vim.keymap.set({ "o", "x" }, "<leader>ib", "<Plug>CamelCaseMotion_ib")
vim.keymap.set({ "o", "x" }, "<leader>ie", "<Plug>CamelCaseMotion_ie")

-- Gate mappings that are useless in vscode
-- portal keymaps
vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
vim.keymap.set(
    "n",
    "<Space>o",
    function()
        -- Search both the jumplist and quickfix list
        local jumplist = require("portal.builtin").jumplist
        local jumplist_query = jumplist.query({ max_results = 3 })

        local quickfix = require("portal.builtin").quickfix
        local quickfix_query = quickfix.query({ max_results = 1 })

        require("portal").tunnel({ jumplist_query, quickfix_query })
    end
)
-- LSP (note lsp is built-in functionality)
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- mappings for trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
-- vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)

-- maybe this should be defined as on_attach?
local diagnostics_shown = 1
local toggle_vim_diagnostic = function()
    if diagnostics_shown == 1 then
        vim.diagnostic.config({ virtual_text = false, underline = false })
        diagnostics_shown = 0
    else
        vim.diagnostic.config({ virtual_text = true, underline = true })
        diagnostics_shown = 1
    end
end

-- 'yoe' still show gutter diagnostic signs; ']oe' will hide entirely
vim.keymap.set("n", "yoe", toggle_vim_diagnostic)
vim.keymap.set("n", "[oe", vim.diagnostic.show)
vim.keymap.set("n", "]oe", vim.diagnostic.hide)

-- clear stuff
-- https://www.reddit.com/r/neovim/comments/zmu22y/uses_for_escape_in_normal_mode/
vim.keymap.set("n", "<Esc>", function()
    -- clear notifications
    require("notify").dismiss()
    -- clear highlights
    vim.cmd.nohlsearch()
end)

-- undotree
keymap("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "UndotreeToggle" })

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
keymap("n", "<leader>rg", "<cmd>Telescope live_grep<CR>")
keymap("n", "<leader>tt", "<cmd>Telescope buffers<CR>")
keymap("n", "<leader>fg", "<cmd>Telescope git_status<CR>")
keymap("n", "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>")

-- ssr
vim.keymap.set(
    { "n", "x" },
    "<leader>sr",
    function() require("ssr").open() end,
    { desc = "Structural Replace" }
)

-- hlslens
keymap("n", "*", "", {
    callback = function()
        vim.fn.execute("normal! *Nzz")
        require 'hlslens'.start()
    end,
})

