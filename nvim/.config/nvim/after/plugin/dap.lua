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

function get_parent_function_name()
    local ts_utils = require 'nvim-treesitter.ts_utils'
    local node = ts_utils.get_node_at_cursor()
    if not node then
        print("node is nil")
        return ''
    end
    while node do
        if (node:type() == 'function_declaration' or node:type() == 'method_declaration') and node:named() then
            local start_line, start_index, end_line, end_index = node:field("name")[1]:range()
            local line = vim.api.nvim_buf_get_lines(0, start_line, end_line + 1, true)
            return string.sub(line[1], start_index, end_index)
        end
        node = node:parent()
    end
    print("could not find function name")
    return ''
end

function Debug_CurrentTest()
    local test_name = get_parent_function_name():gsub("%s+", "")
    print(test_name)
    local file_path = vim.fn.expand('%:p:h')
    Debug_go_test(test_name, file_path)
end
