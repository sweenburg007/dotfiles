-- ---- ---- ---- ---- ---- ---- ---- ----
-- ---- Helper functions
-- ---- ---- ---- ---- ---- ---- ---- ----

local global_opts = { noremap = true, silent = true }

local keymap = function(mode, lhs, rhs, options)
    local opts = options or global_opts
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end


-- ---- ---- ---- ---- ---- ---- ---- ----
-- ---- Make keybindings
-- ---- ---- ---- ---- ---- ---- ---- ----

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

-- clear higlight matches from find
keymap("n", "<leader><space>", "<cmd>noh<cr>")

-- LSP
if vim.fn.exists("g:vscode") == 0 then
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
end

-- Portal key mappings
if vim.fn.exists("g:vscode") == 0 then
    vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
    vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
end

-- Telescope

-- try to find git_files; otherwise fall back to regular find_files
local project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then require("telescope.builtin").find_files(opts) end
end

if vim.fn.exists("g:vscode") ~= 1 then
    vim.keymap.set("n", "<c-p>", project_files)
    keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
    keymap("n", "<c-f>", "<cmd>Telescope live_grep<CR>")
    keymap("n", "<Tab>", "<cmd>Telescope buffers<CR>")
end

local function notify(cmd)
    return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
end

local function v_notify(cmd)
    return string.format("<cmd>call VSCodeNotifyVisual('%s', 1)<CR>", cmd)
end

-- vscode remaps
if vim.fn.exists("g:vscode") == 1 then

    keymap('n', '<Leader>xr', notify 'references-view.findReferences', { silent = true }) -- language references
    keymap('n', '<space>q', notify 'workbench.actions.view.problems', { silent = true }) -- language diagnostics
    keymap('n', 'gr', notify 'editor.action.goToReferences', { silent = true })
    keymap('n', '<Leader>rn', notify 'editor.action.rename', { silent = true })
    keymap('n', '<Leader>fm', notify 'editor.action.formatDocument', { silent = true })
    keymap('n', '<Leader>ca', notify 'editor.action.refactor', { silent = true }) -- language code actions

    keymap('n', '<Leader>rg', notify 'workbench.action.findInFiles', { silent = true }) -- use ripgrep to search files
    keymap('n', '<Leader>ts', notify 'workbench.action.toggleSidebarVisibility', { silent = true })
    keymap('n', '<Leader>th', notify 'workbench.action.toggleAuxiliaryBar', { silent = true }) -- toggle docview (help page)
    keymap('n', '<Leader>tp', notify 'workbench.action.togglePanel', { silent = true })
    keymap('n', '<Leader>fc', notify 'workbench.action.showCommands', { silent = true }) -- find commands
    keymap('n', '<Leader>ff', notify 'workbench.action.quickOpen', { silent = true }) -- find files
    keymap('n', '<Leader>tw', notify 'workbench.action.terminal.toggleTerminal', { silent = true }) -- terminal window

    keymap('v', '<Leader>fc', v_notify 'workbench.action.showCommands', { silent = true })

end



