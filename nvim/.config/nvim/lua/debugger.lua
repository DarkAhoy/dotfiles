function get_parent_function_name() 
    local ts_utils = require 'nvim-treesitter.ts_utils'
    local node = ts_utils.get_node_at_cursor()
    if not node then
      print("node is nil")
      return ''
    end
    while node do
      if ( node:type() == 'function_declaration' or node:type() == 'method_declaration' ) and node:named() then
         local start_line, start_index, end_line, end_index = node:field("name")[1]:range()
         local line = vim.api.nvim_buf_get_lines(0, start_line,end_line+1, true)
         return string.sub(line[1], start_index, end_index)
      end
      node = node:parent()
    end
    print("could not find function name")
    return ''
end

function current_directory() 
  return vim.fn.getcwd()
end 

function RunDebbuger() 
  local function_name = string.gsub(get_parent_function_name(), "%s+", "")
  print("call vimspector#LaunchWithSettings(#{configuration:\"test\", TestIdentifier:\"" .. function_name .. "\"})")
  vim.cmd("call vimspector#LaunchWithSettings(#{configuration: \"test\", TestIdentifier:\"" .. function_name .. "\"})")
end 


vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>lua RunDebbuger()<CR>', {noremap=true, silent=true})
