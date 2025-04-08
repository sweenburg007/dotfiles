return {
    'mfussenegger/nvim-dap',
    dependencies = {
        -- Creates a beautiful debugger UI
        'nvim-neotest/nvim-nio',
        'rcarriga/nvim-dap-ui',

        -- Installs the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',

        -- Add your own debuggers here
        'leoluz/nvim-dap-go',
        'mfussenegger/nvim-dap-python',
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            automatic_setup = true,

            handlers = {},

            ensure_installed = {
                'debugpy'
            },
        }

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<leader>d', dap.continue, { desc = '[D]ebug: [S]tart/[C]ontinue' })
        vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug: [S]tep [I]nto' })
        vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[D]ebug: [S]tep [o]ver' })
        vim.keymap.set('n', '<leader>dsO', dap.step_out, { desc = '[D]ebug: [S]tep [O]ut' })
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle [B]reakpoint' })
        vim.keymap.set('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'Debug: Set Breakpoint' })
        vim.keymap.set('n', '<leader>dq', function()
            dap.terminate({ terminateDebuggee = true })
        end)
        vim.keymap.set('n', '<leader>drl', dap.run_last, { desc = '[D]ebug: [R]un [L]ast Config' })
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        vim.keymap.set('n', '<leader>dl', dapui.toggle, { desc = '[D]ebug: See [L]ast session result.' })


        -- Dap UI setup
        dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        }

        -- Set breakpoint character
        vim.fn.sign_define('DapBreakpoint', {
            text = '●',
            texthl = 'DiagnosticSignError'
        })
        vim.fn.sign_define('DapBreakpointCondition', {
            text = '○',
            texthl = 'DiagnosticSignError'
        })

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- Install golang specific config
        require('dap-go').setup()
        require('dap-python').setup("uv")
    end,
}
