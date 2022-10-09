Plug 'kyazdani42/nvim-web-devicons'
Plug 'pwntester/octo.nvim'

lua << EOF
config = function ()
 require"octo".setup()
end
EOF
