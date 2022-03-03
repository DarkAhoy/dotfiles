local api = vim.api

require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,                    -- false will disable the whole extension
      disable = {},        -- list of language that will be disabled
      custom_captures = {},               -- mapping of user defined captures to highlight groups
    },
    refactor = {
      highlight_definitions = {
        enable = true
      },
      highlight_current_scope = {
        enable = true
      },
    }
 }


function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end 


local function starts_with(str, start)
   return str:sub(1, #start) == start
end

local function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

function get_parent_function_name() 
    local ts_utils = require 'nvim-treesitter.ts_utils'
    local node = ts_utils.get_node_at_cursor()
    while node do
      if node:type() == 'function_declaration' and node:named() then
         local start_line, start_index, end_line, end_index = node:field("name")[1]:range()
         local line = api.nvim_buf_get_lines(0, start_line,end_line+1, true)
         return string.sub(line[1], start_index, end_index)
      end
      node = node:parent()
   end
   return ''
end

function run_test_in_term()
   local file_path = api.nvim_buf_get_name(0)
   local test_name = get_parent_function_name()
   print(file_name)
   local command = ""
   if ends_with(file_path, ".go") then
      command = string.format("!go test %s -run %s", file_path, test_name)
   elseif ends_with(file_path, ".py") then
      command = "pytest %s \n"
   else 
      print("Unknown file type: ", file_path)
      return
   end
   api.nvim_command(command)
end

