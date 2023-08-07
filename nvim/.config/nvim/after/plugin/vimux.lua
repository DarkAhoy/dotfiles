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

function getPath(str)
    return str:match("(.*[/\\])")
end

vim.keymap.set('n', 'tt', function()
    local file_dir = getPath(vim.fn.expand('%'))
    local cmd = " cd " .. file_dir
    vim.cmd(string.format('call VimuxRunCommand("%s")', cmd))
end)
