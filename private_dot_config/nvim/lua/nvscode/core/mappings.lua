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
keymap("n", "<ESC>", "<cmd>noh<cr>")
keymap("n", "<leader><ESC>", "<cmd>noh<cr>")

local function notify(cmd)
    return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
end

keymap('n', '<Leader>sg', notify 'workbench.action.findInFiles', { silent = true }) -- use ripgrep to search files
keymap('n', '<Leader>ts', notify 'workbench.action.toggleSidebarVisibility', { silent = true })
keymap('n', '<Leader>tp', notify 'workbench.action.togglePanel', { silent = true })
keymap('n', '<Leader>sf', notify 'workbench.action.quickOpen', { silent = true })               -- find files
keymap('n', '<Leader>sg', notify 'workbench.action.quickTextSearch', { silent = true })         -- find files
keymap('n', '<Leader>fs', notify 'workbench.action.showAllSymbols', { silent = true })
keymap('n', '<Leader>tw', notify 'workbench.action.terminal.toggleTerminal', { silent = true }) -- terminal window
keymap('n', 'gr', notify 'editor.action.goToReferences', { silent = true })
keymap('n', 'gD', notify 'editor.action.peekDefinition', { silent = true })
keymap('n', "<Leader>ds", notify 'workbench.action.gotoSymbol', { silent = true })
keymap('n', '<space>D', notify 'editor.action.goToTypeDefinition', { silent = true })
keymap('n', '<space>f', notify 'editor.action.formatDocument', { silent = true })

-- Debugging stuff
keymap('n', '<Leader>b', notify 'editor.debug.action.toggleBreakpoint', { silent = true })
keymap('n', '<Leader>dB', notify 'workbench.debug.viewlet.action.removeAllBreakpoints', { silent = true })

keymap('n', '<Leader>d', notify 'workbench.action.debug.start', { silent = true })
keymap('n', '<Leader>dq', notify 'workbench.action.debug.stop', { silent = true })
keymap('n', '<Leader>dc', notify 'workbench.action.debug.continue', { silent = true })
keymap('n', '<Leader>dr', notify 'workbench.action.debug.restart', { silent = true })

keymap('n', '<Leader>do', notify 'workbench.action.debug.stepOver', { silent = true })
keymap('n', '<Leader>di', notify 'workbench.action.debug.stepInto', { silent = true })
keymap('n', '<Leader>dO', notify 'workbench.action.debug.stepOut', { silent = true })

keymap('n', '<Leader>dp', notify 'workbench.action.debug.pause', { silent = true })
