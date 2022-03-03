require("telescope").setup {  
  defaults = {
    file_ignore_patterns = {
      "build/","bin/", ".git/"
    },
    mappings = {
      i = {
         ["<esc>"] = require("telescope.actions").close
      },
    },
  }, 
  pickers = {
      buffers = {
          mappings = {
              i = {
                  ["<c-d>"] = require("telescope.actions").delete_buffer,
                  ["<leader>v"] = require("telescope.actions").select_vertical
                }
            }
        },
        find_files = {hidden = true}
     }

}
