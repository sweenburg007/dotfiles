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

if vim.fn.exists("g:vscode") ~= 1 then
    -- clear notify stuff
    -- https://www.reddit.com/r/neovim/comments/zmu22y/uses_for_escape_in_normal_mode/
    vim.keymap.set("n", "<Esc>", function()
        -- clear notifications
        require("notify").dismiss()
        vim.cmd.nohlsearch()
    end)

    -- center search results
    -- */# searches are centered below, in hlslens keybinds
    keymap("n", "n", "nzz")
    keymap("n", "N", "Nzz")
    keymap("n", "<C-d>", "<C-d>zz")
    keymap("n", "<C-u>", "<C-u>zz")


    -- hlslens
    keymap("n", "*", "", {
        callback = function()
            vim.fn.execute("normal! *Nzz")
            require 'hlslens'.start()
        end,
    })

    -- Diagnostic navigation mappings
    vim.diagnostic.config {
        update_in_insert = false,
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = { min = vim.diagnostic.severity.WARN } },

        -- Can switch between these as you prefer
        virtual_text = true,   -- Text shows up at the end of the line
        virtual_lines = false, -- Text shows up underneath the line, with virtual lines

        -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
        jump = { float = true },
    }

    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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
    --
    -- 'yoe' still show gutter diagnostic signs; ']oe' will hide entirely
    vim.keymap.set("n", "yoe", toggle_vim_diagnostic)
    vim.keymap.set("n", "[oe", vim.diagnostic.show)
    vim.keymap.set("n", "]oe", vim.diagnostic.hide)
else
    local function notify(cmd)
        return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
    end

    -- LSP vscode keymaps
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
end
