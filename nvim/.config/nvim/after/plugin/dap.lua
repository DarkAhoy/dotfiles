local dap = require('dap')
local dapui = require("dapui")

dapui.setup()

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>lp',
    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end)

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end


local config = {
    delve = {
        port = 2345,
        initialize_timeout_sec = 20
    }
}

dap.adapters.go = {
    type = "server",
    port = config.delve.port,
    executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:" .. config.delve.port },
    },
    options = {
        initialize_timeout_sec = config.delve.initialize_timeout_sec,
    },
}

dap.configurations.go = {
    {
        type = "go",
        name = "Debug file",
        request = "launch",
        program = "${file}"
    },
    {
        type = "go",
        name = "Debug test",
        request = "launch",
        mode = "test",
        program = "${file}",
    },

}

function Debug_go_test(testname, testpath)
    dap.run({
        type = "go",
        name = testname,
        request = "launch",
        mode = "test",
        program = testpath,
        args = { "-test.run", testname },
    })
end
