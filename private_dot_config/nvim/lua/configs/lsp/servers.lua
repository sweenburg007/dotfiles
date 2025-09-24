local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local lspconfig_config = require("configs.lsp.config")
local on_attach = lspconfig_config.on_attach

local M = {}

function M.setup()
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
            on_attach = on_attach,
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

    lspconfig.pyright.setup {
        settings = {
            pyright = {
                disableOrganizeImports = true,
                reportMissingTypeStubs = false,
                reportIndexIssue = false,
            },
            python = {
                analysis = {
                    ignore = { '*' },
                    typeCheckingMode = "off",
                }
            }
        }
    }

    require('lspconfig').ruff.setup {
        on_attach = on_attach,
        init_options = {
            settings = {}
        }
    }

    require('lspconfig').verible.setup({
        on_attach = on_attach,
        cmd = {
            'verible-verilog-ls',
            '--indentation_spaces', '4'
        }
    })
    require('lspconfig').vhdl_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities
    })

    -- Really annoyed by mypy rn, going to try doing things without it for a while
    -- local null_ls = require("null-ls")
    -- null_ls.setup({
    --     sources = {
    --         null_ls.builtins.diagnostics.mypy
    --     },
    --     debug = true,
    -- })

    require("mason").setup()

    local ensure_installed = vim.tbl_keys({})
    vim.list_extend(ensure_installed, {
        'matlab-language-server',
        'rust_analyzer',
        'clangd',
        'lua-language-server',
        'bash-language-server',
        'pyright',
        'verible',
        'rust_hdl'
    })

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }
end

return M
