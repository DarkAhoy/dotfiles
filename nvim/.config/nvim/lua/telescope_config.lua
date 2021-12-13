require("telescope").setup {  
  defaults = {
    file_ignore_patterns = {
      "build/","bin/", ".git/"
    } 
  }, 
  pickers = {
      buffers = {
          mappings = {
              i = {
                  ["<c-d>"] = require("telescope.actions").delete_buffer
                }
            }
        },
        find_files = {hidden = true}
     }
}
