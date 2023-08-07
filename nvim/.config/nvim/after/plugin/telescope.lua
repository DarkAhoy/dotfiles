local builtin = require('telescope.builtin')

vim.keymap.set("n", "<C-p>", builtin.find_files)
vim.keymap.set("n", "<C-S-f>", builtin.live_grep)
vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>c", builtin.commands)
vim.keymap.set("n", "rr", builtin.command_history)
vim.keymap.set("n", "<leader>gb", builtin.git_branches)
vim.keymap.set("n", "<leadet>r", builtin.resume)
vim.keymap.set("n", "<leader>f", function() TelescopeSearchInDirectoy() end)

require("telescope").setup {
    defaults = {
        file_ignore_patterns = {
            "bin/", ".git/"
        },
        mappings = {
            i = {
                ["<esc>"] = require("telescope.actions").close,
                ["<c-i>"] = require("telescope.actions").select_vertical,
                ["<c-s>"] = require("telescope.actions").select_horizontal,
                ["<c-t>"] = require("telescope.actions").select_tab
            },
        },
        cycle_layout = {
            layout_config = {}
        }
    },
    pickers = {
        buffers = {
            mappings = {
                i = {
                    ["<c-d>"] = require("telescope.actions").delete_buffer,
                }
            }
        },
        find_files = {
            hidden = true,
        },
        commands_history = {
            mappings = {
                ["<CR>"] = require("telescope.actions").edit_command_line,
            }
        },
    }
}

function TelescopeSearchInDirectoy()
    local path = vim.fn.input("Path to directory: ", "", "dir")
    builtin.live_grep({ search_dirs = { path } })
end
