-- check for vscode, only want this setup when vscode doesn't exist
if vim.fn.exists("g:vscode") == 0 then
    -- Setup lspconfig.
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        local buf_keymap = function(m, s, c) vim.keymap.set(m, s, c, bufopts) end

        buf_keymap("n", "gD", vim.lsp.buf.declaration)
        buf_keymap("n", "gd", vim.lsp.buf.definition)
        buf_keymap("n", "K", vim.lsp.buf.hover)
        buf_keymap("n", "gi", vim.lsp.buf.implementation)
        buf_keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder)
        buf_keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder)
        buf_keymap("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end)
        buf_keymap("n", "<space>D", vim.lsp.buf.type_definition)
        buf_keymap("n", "<space>rn", vim.lsp.buf.rename)
        buf_keymap("n", "<space>ca", vim.lsp.buf.code_action)
        buf_keymap("n", "gr", vim.lsp.buf.references)
        buf_keymap("n", "<space>f", function() vim.lsp.buf.format { async = true } end)

        -- for lvimuser/lsp-inlayhints.nvim
        require("lsp-inlayhints").on_attach(client, bufnr)
    end

    -- restrain a language server (in the case that i"m using multiple for same language)
    local on_attach_restrained = function(client, buffer)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.renameProvider = false
        client.server_capabilities.signatureHelpProvider = false
    end

    -- assign border -> border_chars
    -- override all floating windows with our new explicitly-defined border
    local border_chars = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
    local border = {}
    for i, char in pairs(border_chars) do
        border[i] = { char, "FloatBorder" }
    end

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, fp_opts, ...)
        fp_opts = fp_opts or {}
        fp_opts.border = fp_opts.border or border
        return orig_util_open_floating_preview(contents, syntax, fp_opts, ...)
    end

    -- Use a loop to conveniently call "setup" on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local servers = {
        -- bash
        "bashls",
        -- python
            -- needs custom flags
        -- "pylsp",
        -- "pyright",
        -- ruby
        "solargraph",
        -- lua
        "lua_ls",
        -- java
            -- needs custom flags
            -- "java_language_server",
        -- c/c++
            -- ccls/clangd both rely on JSON compilation databases
            -- requires running `bear -- <build cmd>` first
        -- "ccls",
        "clangd",
        -- rust
        "rust_analyzer",
        -- go
        "gopls",
    }
    for _, lsp in pairs(servers) do
        lspconfig[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                -- This will be the default in neovim 0.7+
                debounce_text_changes = 150,
            },
        }
    end

    -- python
    lspconfig["pyright"].setup({
        -- disable several capabilities in favor of pylsp
        on_attach = on_attach_restrained,
        capabilities = capabilities,
    })

    lspconfig["pylsp"].setup({
        enable = true,
        on_attach = on_attach,
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

    -- Only define once
    if not require'lspconfig.configs'.hdl_checker then
        require'lspconfig.configs'.hdl_checker = {
            default_config = {
            cmd = {"hdl_checker", "--lsp", };
            filetypes = {"vhdl", "verilog", "systemverilog"};
                root_dir = function(fname)
                    -- will look for the .hdl_checker.config file in parent directory, a
                    -- .git directory, or else use the current directory, in that order.
                    local util = require'lspconfig'.util
                    return util.root_pattern('.hdl_checker.config')(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
                end;
                settings = {};
            };
        }
    end

    require'lspconfig'.hdl_checker.setup{}

    -- java
    lspconfig.java_language_server.setup {
        on_attach = on_attach,
        -- TODO - should this line be templated/checked for which OS?
        cmd = { os.getenv("HOME") .. "/.cache/java-language-server/dist/lang_server_mac.sh" },
    }

else

    local function notify(cmd)
        return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
    end

    local global_opts = { noremap = true, silent = true }

    local keymap = function(mode, lhs, rhs, options)
        local opts = options or global_opts
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    end


    keymap('n', '<Leader>xr', notify 'references-view.findReferences', { silent = true }) -- language references
    keymap('n', '<space>q', notify 'workbench.actions.view.problems', { silent = true }) -- language diagnostics
    keymap('n', 'gr', notify 'editor.action.goToReferences', { silent = true })
    keymap('n', '<Leader>rn', notify 'editor.action.rename', { silent = true })
    keymap('n', '<Leader>fm', notify 'editor.action.formatDocument', { silent = true })
    keymap('n', '<Leader>ca', notify 'editor.action.refactor', { silent = true }) -- language code actions
end