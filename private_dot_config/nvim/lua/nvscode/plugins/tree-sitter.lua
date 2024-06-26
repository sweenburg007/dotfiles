-- Tree-Sitter configuration
return {
    -- use tree-sitter for language features
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function() require "nvscode.configs.tree-sitter" end,
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
}
