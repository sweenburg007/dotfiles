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
        vim.lsp.config("lsp", {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        })
        vim.lsp.enable(lsp)
    end

    vim.lsp.config("matlab_ls", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
            matlab = {
                indexWorkspace = true,
                installPath = "/Applications/MATLAB_R2025b.app/",
                matlabConnectionTiming = "onStart",
                telemetry = false,
            }
        }
    })
    vim.lsp.enable("matlab_ls")

    vim.lsp.config("pyright", {
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
    })
    vim.lsp.enable("pyright")

    vim.lsp.config("ruff", {
        on_attach = on_attach,
        init_options = {
            settings = {}
        }
    })
    vim.lsp.enable("ruff")


    vim.lsp.config("verible", {
        on_attach = on_attach,
        cmd = {
            'verible-verilog-ls',
            '--indentation_spaces', '4'
        }
    })
    vim.lsp.enable("verible")

    vim.lsp.config("vhdl_ls", {
        on_attach = on_attach,
        capabilities = capabilities
    })
    vim.lsp.enable("vhdl_ls")

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
