-- Tree-Sitter configuration
return {
    -- use tree-sitter for language features
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function() require "configs.treesitter" end,
        dependencies = {
            {
                "IndianBoy42/tree-sitter-just",
                config = true,
            },
        },
    },

    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",

      -- more textobjects
    {
        "echasnovski/mini.ai",
        main = "mini.ai",
        config = true,
    },

    {"https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git"},

    -- display AST, write TS queries for buffer
    {
        "nvim-treesitter/playground",
        cmd = { "TSPlayGround", "TSPlayGroundToggle" },
    },
}
