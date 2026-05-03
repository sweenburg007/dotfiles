-- UX changes and add-ons
local plugins = {
    -- repeate motions from plugins and elsewhere
    "tpope/vim-repeat",
}

if vim.fn.exists("g:vscode") ~= 1 then
    table.insert(plugins,
        {
            -- telescope - arbitrary fuzzy-searching over lists
            {
                "nvim-telescope/telescope.nvim",
                event = "VimEnter",
                dependencies = {
                    "nvim-lua/plenary.nvim",
                    {
                        "nvim-telescope/telescope-fzf-native.nvim",
                        build = "make",
                        cond = function()
                            return vim.fn.executable("make") == 1
                        end,
                    },
                    { "nvim-telescope/telescope-ui-select.nvim" },
                    {
                        "nvim-tree/nvim-web-devicons",
                        enabled = vim.g.have_nerd_font,
                    },
                },
                config = function()
                    require("telescope").setup({
                        defaults = {
                            file_ignore_pattersn = { ".venv", "target" },
                            extensions = {
                                ["ui-select"] = {
                                    require("telescope.themes").get_dropdown(),
                                },
                            },
                        },
                    })
                    pcall(require("telescope").load_extension, "fzf")
                    pcall(require("telescope").load_extension, "ui-select")

                    vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")

                    -- setup telescope keymaps
                    local builtin = require("telescope.builtin")
                    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
                    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
                    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
                    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
                    vim.keymap.set({ "n", "v" }, "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
                    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
                    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
                    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
                    vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "[S]earch [J]umplist" })
                    vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "[G]it [S]tatus" })
                    vim.keymap.set("n", "<leader>s.", builtin.oldfiles,
                        { desc = '[S]earch Recent Files ("." for repeat)' })
                    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
                    vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands" })

                    -- Override default behavior and theme when searching
                    vim.keymap.set("n", "<leader>/", function()
                        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                            winblend = 10,
                            previewer = false,
                        }))
                    end, { desc = "[/] Fuzzily search in current buffer" })

                    -- It's also possible to pass additional configuration options.
                    --  See `:help telescope.builtin.live_grep()` for information about particular keys
                    vim.keymap.set("n", "<leader>s/", function()
                        builtin.live_grep({
                            grep_open_files = true,
                            prompt_title = "Live Grep in Open Files",
                        })
                    end, { desc = "[S]earch [/] in Open Files" })

                    -- Shortcut for searching your Neovim configuration files
                    vim.keymap.set("n", "<leader>sn", function()
                        builtin.find_files({ cwd = vim.fn.stdpath("config") })
                    end, { desc = "[S]earch [N]eovim files" })

                    vim.api.nvim_create_autocmd("LspAttach", {
                        group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
                        callback = function(event)
                            local buf = event.buf

                            vim.keymap.set("n", "gr", builtin.lsp_references,
                                { buffer = buf, desc = "[G]oto [R]eferences" })
                            vim.keymap.set("n", "gI", builtin.lsp_implementations,
                                { buffer = buf, desc = "[G]oto [I]mplementation" })
                            -- Jump to the definition of the word under your cursor.
                            -- This is where a variable was first declared, or where a function is defined, etc.
                            -- To jump back, press <C-t>.
                            vim.keymap.set("n", "gd", builtin.lsp_definitions,
                                { buffer = buf, desc = "[G]oto [D]efinition" })
                            vim.keymap.set(
                                "n",
                                "<leader>ds",
                                builtin.lsp_document_symbols,
                                { buffer = buf, desc = "Open [D]ocument [S]ymbols" }
                            )
                            vim.keymap.set(
                                "n",
                                "<leader>ws",
                                builtin.lsp_dynamic_workspace_symbols,
                                { buffer = buf, desc = "Open [W]orkspace [S]ymbols" }
                            )
                            vim.keymap.set(
                                "n",
                                "gt",
                                builtin.lsp_type_definitions,
                                { buffer = buf, desc = "[G]oto [T]ype Definition" }
                            )
                        end,
                    })
                end,
            },

            -- git signs in gutter, management of hunks ;) and simple diff views
            {
                "lewis6991/gitsigns.nvim",
                config = function()
                    require("gitsigns").setup({
                        numhl = true,
                        current_line_blame = true,
                        current_line_blame_opts = { delay = 500 },
                        signs = {
                            add = { text = "┃" },
                            change = { text = "┃" },
                            delete = { text = "_" },
                            topdelete = { text = "‾" },
                            changedelete = { text = "~" },
                            untracked = { text = "┆" },
                        },

                        on_attach = function(bufnr)
                            local gs = package.loaded.gitsigns

                            local function map(mode, lhs, rhs, opts)
                                opts = opts or {}
                                opts.buffer = bufnr
                                vim.keymap.set(mode, lhs, rhs, opts)
                            end

                            -- navigation
                            map("n", "]h", function()
                                if vim.wo.diff then
                                    return "]h"
                                end
                                vim.schedule(function()
                                    gs.next_hunk()
                                    vim.api.nvim_feedkeys("zz", "n", false)
                                end)
                                return "<Ignore>"
                            end, { expr = true, desc = "Gitsigns next hunk" })

                            map("n", "[h", function()
                                if vim.wo.diff then
                                    return "[h"
                                end
                                vim.schedule(function()
                                    gs.prev_hunk()
                                    vim.api.nvim_feedkeys("zz", "n", false)
                                end)
                                return "<Ignore>"
                            end, { expr = true, desc = "Gitsigns prev hunk" })

                            -- actions
                            map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Gitsigns stage_hunk" })
                            map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Gitsigns reset_hunk" })
                            map("n", "<leader>hS", gs.stage_buffer, { desc = "Gitsigns stage_buffer" })
                            map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Gitsigns undo_stage_hunk" })
                            map("n", "<leader>hR", gs.reset_buffer, { desc = "Gitsigns reset_buffer" })
                            map("n", "<leader>hp", gs.preview_hunk, { desc = "Gitsigns preview_hunk" })
                            map("n", "<leader>hd", gs.diffthis, { desc = "Gitsigns diffthis" })
                            map("n", "<leader>hD", function()
                                gs.diffthis("~")
                            end, { desc = "Gitsigns diffthis" })
                            map("n", "yog", gs.toggle_current_line_blame, { desc = "Gitsigns toggle_current_line_blame" })

                            -- text object
                            map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<CR>", { desc = "Gitsigns select_hunk" })
                        end,
                    })
                end,
            },

            {
                "stevearc/oil.nvim",
                ---@module 'oil'
                opts = {},
                -- Optional dependencies
                dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
                -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
                lazy = false,
                config = function()
                    require("oil").setup()
                    vim.keymap.set("n", "<leader>ls", "<cmd>Oil<cr>", { desc = "Open Oil session" })
                end,
            },
        }
    )
end

return plugins
