function RunDevDocker()
    vim.cmd('call VimuxRunCommand(" cd ~/src/pynt-dev/ && ./build/run-dev-docker.sh")')
end

if string.find(vim.api.nvim_buf_get_name(0), "src/pynt-dev", 1, true) ~= nil then
    vim.api.nvim_create_user_command(
        "RunDevDocker",
        function()
            RunDevDocker()
        end,
        { nargs = 0 })
end

function hasRunner(index)
    local out = vim.fn.system("tmux list-panes -F '#{pane_id}'")
    for v in out:gmatch("[^\r\n]+") do
        if v == index then
            return true
        end
    end
    return false
end

vim.keymap.set('n', 'tt', function()
    if vim.g.VimuxRunnerIndex ~= nil and hasRunner(vim.g.VimuxRunnerIndex) then
        print("will toggle current")
        vim.cmd("VimuxTogglePane")
    else
        print("will open a new one")
        vim.cmd("VimuxOpenRunner")
    end
end)
