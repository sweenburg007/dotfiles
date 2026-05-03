-- Tree-Sitter configuration
return {
    -- use tree-sitter for language features
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        config = function()
            local parsers = { "rust", "python", "c", "systemverilog", "matlab", "cpp", "lua", "bash", "cmake", "diff",
                "html", "markdown", "json", "yaml", "markdown_inline", "vim", "vimdoc", }
            require('nvim-treesitter').install(parsers)

            local function treesitter_try_attach(buf, language)
                -- check if parser exists and load it
                if not vim.treesitter.language.add(language) then return end
                -- enables syntax highlighting and other treesitter features
                vim.treesitter.start(buf, language)

                -- check if treesitter indentation is available for this language, and if so enable it
                -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
                local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

                -- enables treesitter based indentation
                if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
            end

            local available_parsers = require('nvim-treesitter').get_available()
            vim.api.nvim_create_autocmd('FileType', {
                callback = function(args)
                    local buf, filetype = args.buf, args.match

                    local language = vim.treesitter.language.get_lang(filetype)
                    if not language then return end

                    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

                    if vim.tbl_contains(installed_parsers, language) then
                        -- enable the parser if it is installed
                        treesitter_try_attach(buf, language)
                    elseif vim.tbl_contains(available_parsers, language) then
                        -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
                        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
                    else
                        -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
                        treesitter_try_attach(buf, language)
                    end
                end,
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
    },

    -- more textobjects
    {
        "echasnovski/mini.ai",
        main = "mini.ai",
        config = function()
            local ai = require("mini.ai")

            ai.setup({
                custom_textobjects = {
                    -- function
                    F = ai.gen_spec.treesitter({
                        a = "@function.outer",
                        i = "@function.inner",
                    }),

                    -- class
                    c = ai.gen_spec.treesitter({
                        a = "@class.outer",
                        i = "@class.inner",
                    }),

                    -- assignment (lhs / rhs split like your config)
                    k = ai.gen_spec.treesitter({
                        a = "@assignment.lhs",
                        i = "@assignment.lhs",
                    }),

                    v = ai.gen_spec.treesitter({
                        a = "@assignment.rhs",
                        i = "@assignment.rhs",
                    }),

                    -- number
                    n = ai.gen_spec.treesitter({
                        a = "@number.inner",
                        i = "@number.inner",
                    }),
                },
            })
        end,
    },

    { "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git" },

}
