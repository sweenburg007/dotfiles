-- Language Server Protocol (LSP) plugins
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                -- development settings for lua files under nvim root
                -- load neodev only if editing lua/lua.tmpl files under nvim/chezmoi/packer root
                "folke/neodev.nvim",
                opts = {
                    override = function(root_dir, library)
                        local util = require("neodev.util")
                        if (
                                util.has_file(root_dir, ".local/share/chezmoi/")
                                or
                                util.has_file(root_dir, "pack/packer")
                            -- neodev will implicitly set up for nvim config dir:
                            -- or
                            -- util.is_nvim_config()
                            ) then
                            library.enabled = true
                            library.plugins = true
                        end
                    end,
                },
            },
            {
                -- completion candidates for nvim-cmp
                "hrsh7th/cmp-nvim-lsp",
            },
            -- provide virtual text inline type hints
            {
                "lvimuser/lsp-inlayhints.nvim",
                -- config = true,
                opts = {
                    inlay_hints = {
                        type_hints = {
                            prefix = "<= ",
                        },
                        highlight = "Comment",
                    },
                },
            },
        },
        config = function()
            require("configs.lspconfig")
        end
    },

    -- use vscode snips from friendly-snippets
    {
        "L3MON4D3/LuaSnip",
        event = { "InsertEnter", "CmdlineEnter" },
        version = "v1.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "kristijanhusak/vim-dadbod-completion",
        },
        config = function() require("configs.cmp") end,
    },
    -- auto-popup signature_help while in insert mode inside a method's param list
    {
        "ray-x/lsp_signature.nvim",
        opts = { bind = true },
    },

    {
        "DNLHC/glance.nvim",
        opts = {
            preview_win_opts = {
                relativenumber = false,
            },
            border = {
                enable = true,
            }
        },
    }
}
