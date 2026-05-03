if vim.fn.exists("g:vscode") ~= 1 then
    return {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            -- Mason must be loaded before its dependents so we need to set it up here.
            -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
            {
                'mason-org/mason.nvim',
                ---@module 'mason.settings'
                ---@type MasonSettings
                ---@diagnostic disable-next-line: missing-fields
                opts = {},
            },
            -- Maps LSP server names between nvim-lspconfig and Mason package names.
            'mason-org/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            { 'j-hui/fidget.nvim', opts = {} },
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    -- helper function for setting lsp keymaps
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("<leader>rn", vim.lsp.buf.rename, '[R]e[N]ame')
                    map("<leader>ca", vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

                    -- WARN: This is not Goto Definition, this is Goto Declaration.
                    --  For example, in C this would take you to the header.
                    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                    map('<space>f', function() vim.lsp.buf.format { async = true } end, 'Lsp [F]ormat Document')


                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
                        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight',
                            { clear = false })
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end

                    if client and client:supports_method('textDocument/inlayHint', event.buf) then
                        map('<leader>th',
                            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
                            '[T]oggle Inlay [H]ints')
                    end

                    -- specifically here to deal with pyright vs ruff stuff
                    if client and client.name == "ruff" then
                        client.server_capabilities.hoverProvider = false
                    end
                end,
            })

            -- Enable languages servers
            ---@type table<string, vim.lsp.Config>
            local servers = {
                clangd = {},
                vhdl_ls = {},
                bashls = {},
                ruff = {},

                basedpyright = {
                    settings = {
                        basedpyright = {
                            typeCheckingMode = "basic",
                            analysis = {
                                disableOrganizeImports = true,
                                reportMissingTypeStubs = "none",
                                reportMissingImports = "none",
                            },
                        },
                    },
                },

                rust_analyzer = {},
                matlab_ls = {
                    settings = {
                        matlab = {
                            indexWorkspace = true,
                            installPath = "/Applications/MATLAB_R2025b.app/",
                            matlabConnectionTiming = "onStart",
                            telemetry = false,
                        }
                    }
                },

                verible = {
                    cmd = {
                        'verible-verilog-ls',
                        '--indentation_spaces', '4'
                    }
                },

                -- Special Lua Config, as recommended by neovim help docs
                lua_ls = {
                    on_init = function(client)
                        -- client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

                        if client.workspace_folders then
                            local path = client.workspace_folders[1].name
                            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
                        end

                        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                            runtime = {
                                version = 'LuaJIT',
                                path = { 'lua/?.lua', 'lua/?/init.lua' },
                            },
                            workspace = {
                                checkThirdParty = false,
                                -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                                --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                                library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                                    '${3rd}/luv/library',
                                    '${3rd}/busted/library',
                                }),
                            },
                        })
                    end,
                    ---@type lspconfig.settings.lua_ls
                    settings = {},
                },
            }

            -- Ensure the servers and tools above are installed
            --
            -- To check the current status of installed tools and/or manually install
            -- other tools, you can run
            --    :Mason
            --
            -- You can press `g?` for help in this menu.
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                -- You can add other tools here that you want Mason to install
            })

            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            for name, server in pairs(servers) do
                vim.lsp.config(name, server)
                vim.lsp.enable(name)
            end
        end,
    }
end

return {}
