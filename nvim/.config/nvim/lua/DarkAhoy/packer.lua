vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use { "ellisonleao/gruvbox.nvim" }
    use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
    use { 'itchyny/lightline.vim' }
    use { 'arcticicestudio/nord-vim' }
    use { 'shinchu/lightline-gruvbox.vim' }
    use { 'tpope/vim-fugitive' }
    use { 'preservim/nerdtree' }

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
        }
    }

    use { 'preservim/vimux' }
    use { 'mfussenegger/nvim-dap' }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
end)
