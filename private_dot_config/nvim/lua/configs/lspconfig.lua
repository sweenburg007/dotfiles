vim.lsp.set_log_level('debug')

vim.api.nvim_create_autocmd('LspAttach', {

    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),

    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('<space>f', function() vim.lsp.buf.format { async = true } end, 'Lsp [F]ormat Document')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end

        -- lsp-inlayhints
        require("lsp-inlayhints").on_attach(client, event.buf)
    end,
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

-- Use a loop to conveniently call "setup" on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
    "bashls",
    "lua_ls",
    "clangd",
    "rust_analyzer",
}
for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    }
end

lspconfig.matlab_ls.setup({
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {
        matlab = {
            indexWorkspace = true,
            installPath = "/Applications/MATLAB_R2023b.app/",
            matlabConnectionTiming = "onStart",
            telemetry = false,
        }
    }
})

lspconfig["pylsp"].setup({
    enable = true,
    settings = {
        pylsp = {
            configurationSources = { "ruff", "mypy" },
            plugins = {
                ruff = { enabled = true },
                mypy = { enabled = true },
            },
        },
    },
})

require("mason").setup()

local ensure_installed = vim.tbl_keys({})
vim.list_extend(ensure_installed, {
    'matlab-language-server',
    'rust_analyzer',
    'clangd',
    'lua-language-server',
    'bash-language-server'
})

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

require('mason-lspconfig').setup {
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
        end,
    },
}
