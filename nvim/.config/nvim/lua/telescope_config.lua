require("telescope").setup {  
  defaults = {
    file_ignore_patterns = {
      "build/","bin/", ".git/"
    },
    mappings = {
      i = {
         ["<esc>"] = require("telescope.actions").close,
         ["<leader>v"] = require("telescope.actions").select_vertical,
         ["<leader>h"] = require("telescope.actions").select_horizontal
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
