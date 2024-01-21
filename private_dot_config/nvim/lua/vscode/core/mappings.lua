-- VSCODE mappings
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

-- camelcasemotion
keymap("", "<leader>w", "<Plug>CamelCaseMotion_w")
keymap("", "<leader>b", "<Plug>CamelCaseMotion_b")
keymap("", "<leader>e", "<Plug>CamelCaseMotion_e")
keymap("", "<leader>ge", "<Plug>CamelCaseMotion_ge")

vim.keymap.set({ "o", "x" }, "<leader>iw", "<Plug>CamelCaseMotion_iw")
vim.keymap.set({ "o", "x" }, "<leader>ib", "<Plug>CamelCaseMotion_ib")
vim.keymap.set({ "o", "x" }, "<leader>ie", "<Plug>CamelCaseMotion_ie")

local function notify(cmd)
    return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
end

keymap('n', '<Leader>rg', notify 'workbench.action.findInFiles', { silent = true }) -- use ripgrep to search files
keymap('n', '<Leader>ts', notify 'workbench.action.toggleSidebarVisibility', { silent = true })
keymap('n', '<Leader>tp', notify 'workbench.action.togglePanel', { silent = true })
keymap('n', '<Leader>ff', notify 'workbench.action.quickOpen', { silent = true })               -- find files
keymap('n', '<Leader>fs', notify 'workbench.action.showAllSymbols', {silent = true})
keymap('n', '<Leader>tw', notify 'workbench.action.terminal.toggleTerminal', { silent = true }) -- terminal window
keymap('n', 'gr', notify 'editor.action.goToReferences', { silent = true })
keymap('n', 'gD', notify 'editor.action.peekDefinition', { silent = true })
keymap('n', '<space>D', notify 'editor.action.goToTypeDefinition', { silent = true })
keymap('n', '<space>f', notify 'editor.action.formatDocument', { silent = true })


local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED


vim.keymap.set("n", "<leader>qi", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>qo", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- vim.keymap.set("n", "<M-a>", function() harpoon:list():select(1) end)
-- vim.keymap.set("n", "<M-s>", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<M-d>", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<M-f>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>qh", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>qj", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>qk", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>ql", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-h-p>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-h-n>", function() harpoon:list():next() end)

-- clear items from harpoon list
vim.keymap.set("n", "<leader>qd", function() harpoon:list():clear() end) -- all
vim.keymap.set("n", "<leader>qH", function() harpoon:list():removeAt(1) end) -- 1
vim.keymap.set("n", "<leader>qJ", function() harpoon:list():removeAt(2) end) -- 2
vim.keymap.set("n", "<leader>qK", function() harpoon:list():removeAt(3) end) -- 3
vim.keymap.set("n", "<leader>qL", function() harpoon:list():removeAt(4) end) -- all
