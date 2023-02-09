require("telescope").setup {
  defaults = {
    file_ignore_patterns = {
      "bin/", ".git/"
    },
    mappings = {
      i = {
         ["<esc>"] = require("telescope.actions").close,
         ["<c-s>"] = require("telescope.actions").select_vertical,
         ["<c-i>"] = require("telescope.actions").select_horizontal,
         ["<c-t>"] = require("telescope.actions").select_tab
      },
    },
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
     }

}
