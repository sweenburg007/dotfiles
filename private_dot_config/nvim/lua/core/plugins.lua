-- Plugin setup and configuration

local fn = vim.fn

local check_os = function(target)
    local uname = vim.api.nvim_command_output("!uname -s"):gsub("%s+", "")
    return uname == target
end

local ensure_packer = function ()
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        print("Installing packer ...")
        fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local PACKER_BOOTSTRAP = ensure_packer()

local packer = require("packer")

packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
})

return packer.startup(function(use)

    -- let packer manage itself
    use {"wbthomason/packer.nvim"}

    -- ---- Tree-Sitter
    -- ---- ---- ---- ---- ---- ----

    -- use tree-sitter for language features
    use {
        "nvim-treesitter/nvim-treesitter",
        -- run = ":TSUpdate",
        -- config = function() require "configs.treesitter" end,
    }

    use {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
    }

    use {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    }

    use {
        "https://git.sr.ht/~p00f/nvim-ts-rainbow/",
        after = "nvim-treesitter",
    }

    -- Language Server Protocol (LSP) plugins _ Completions (nvim-cmp)
    
    -- standard configs for popular LSP servers
    use {
        "neovim/nvim-lspconfig",
    }

    use {
        "hrsh7th/nvim-cmp",
        after = "nvim-lspconfig",
    }
    use {
        "hrsh7th/cmp-nvim-lsp",
        after = {"nvim-lspconfig", "nvim-cmp"},

        -- this config sets up nvim-lspconfig, nvim-cmp, and cmp-nvim-lsp
        -- so should be run after all those three are loaded
        config = function() require("configs.cmp") end,
    }
    use {
        "hrsh7th/cmp-buffer",
        after = {"nvim-lspconfig", "nvim-cmp"},
    }
    use {
        "hrsh7th/cmp-path",
        after = {"nvim-lspconfig", "nvim-cmp"},
    }
    use {
        "hrsh7th/cmp-cmdline",
        after = {"nvim-lspconfig", "nvim-cmp"},
    }    

    -- snippets for nvim-cmp
    use {
        "L3MON4D3/LuaSnip",
        tag = "v1.*",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    }
    use { "saadparwaiz1/cmp_luasnip" }
    use { "rafamadriz/friendly-snippets" }
    
   
    --  configs for UI and other backend
    use { "tanvirtin/monokai.nvim" }
    use { "tpope/vim-repeat"}
    use { "frazrepo/vim-rainbow" }
    use { "tpope/vim-fugitive" }

    use { 'ryanoasis/vim-devicons' }

    use { 
        'folke/noice.nvim',
        requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify"},
        config = function()
            require("noice").setup()
        end
    }

    use {
        "vim-airline/vim-airline",
        -- config = function() require("configs.airline") end,
    }
    use {"vim-airline/vim-airline-themes"}

    -- telescope - arbitrary fuzzy-searching over lists (e.g. buffers or files in workspace)
    use {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = function() require "configs.telescope" end,
        -- this loads after telescope extensions so it can register them in its config
        after = { "telescope-fzf-native.nvim", "telescope-luasnip.nvim" },
    }

    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    }

    -- search luasnip snippets from inside telescope
    use {
        "benfowler/telescope-luasnip.nvim",
    }    

    -- -------
    -- Movement plugins
    use { 
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end,
    }

    use {
        "ggandor/flit.nvim",
        after = "leap.nvim",
        config = function()
            require("flit").setup({
                labeled_modes = "n",
                special_keys = {
                    repeat_search = { "<Enter>" },
                },
                opts = {
                    special_keys = {
                        repeat_search = { "<Enter>" },
                    }
                },
            })
        end,
    }

    use {
        "ggandor/leap-spooky.nvim",
        after = "leap.nvim",
        config = function()
            require("leap-spooky").setup({ paste_on_remote_yank = true })
        end,
    }

    -- TS aware comments
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- trying out something to work with vscode
    use {
        "icedman/nvim-textmate",
        config = function ()
            require("nvim-textmate").setup(
                {
                    quick_load = true,
                    theme_name = "Monokai",
                    override_colorscheme = false
                }
            )
        end
    }

    -- -------
    -- Text Manipulation
    use { "tpope/vim-surround"}
    -- use { "tpope/vim-commentary" }
    use { "alker0/chezmoi.vim" }
    use { "kovetskiy/sxhkd-vim" }

    -- if bootstrapping, run sync
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
 
end)
