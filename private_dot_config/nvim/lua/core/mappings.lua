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
keymap("n", "<ESC>", "<cmd>noh<cr>")
keymap("n", "<leader><ESC>", "<cmd>noh<cr>")

-- center search results
-- */# searches are centered below, in hlslens keybinds
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Gate mappings that are useless in vscode
-- portal keymaps
vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>", { desc = 'Portal jumplist backwards' })
vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>", { desc = 'Portal jumplist forwards' })
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
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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
    vim.cmd.nohlsearch()
end)

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndotreeToggle" })

-- neogen
vim.api.nvim_set_keymap(
    "n", "<Leader>ng", ":lua require('neogen').generate()<CR>",
    { noremap = true, silent = true, desc = "[N]eogen [G]enerate" }
)

-- Telescope
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    }
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- hlslens
keymap("n", "*", "", {
    callback = function()
        vim.fn.execute("normal! *Nzz")
        require 'hlslens'.start()
    end,
})
