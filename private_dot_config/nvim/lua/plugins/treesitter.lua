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

    -- TODO: this should be updated, as this version is archived
    -- pair highlighting
    {
        "https://git.sr.ht/~p00f/nvim-ts-rainbow",
        name = "nvim-ts-rainbow",
        url = "https://git.sr.ht/~p00f/nvim-ts-rainbow/",
    },

    -- display AST, write TS queries for buffer
    {
        "nvim-treesitter/playground",
        cmd = { "TSPlayGround", "TSPlayGroundToggle" },
    },
}
