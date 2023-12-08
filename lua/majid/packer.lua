-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- packer itself

    -- Essential Plugins
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'numToStr/Comment.nvim'
    }

    use {
        "folke/trouble.nvim",

    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end, }
    use("nvim-treesitter/playground")
    use("nvim-treesitter/nvim-treesitter-context");
    use("theprimeagen/harpoon")
    use("theprimeagen/refactoring.nvim")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use { "akinsho/bufferline.nvim" }
    use { "moll/vim-bbye" }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
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
            { 'L3MON4D3/LuaSnip',
                dependencies = { 'rafamadriz/friendly-snippets' } },
        }
    }
    -- LSP
    -- use {
    --     "neovim/nvim-lspconfig",
    --     opt = true,
    --     event = "BufEnter", -- Prefer BufReadPre.. figure out how to debug: `E201: autocommands must not change current buffer`.
    --     wants = { "cmp-nvim-lsp", "nvim-lsp-installer", "lsp_signature.nvim" },
    -- }

    use("folke/zen-mode.nvim")
    use("github/copilot.vim")
    use("eandrju/cellular-automaton.nvim")
    use("laytan/cloak.nvim")

    use("lukas-reineke/indent-blankline.nvim")

    -- formatter
    use("stevearc/conform.nvim")
    -- Themes
    use 'navarasu/onedark.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }
    use 'simrat39/symbols-outline.nvim'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    -- use {
    --     'goolord/alpha-nvim',
    --     -- event = 'VimEnter',
    --     requires = { 'nvim-tree/nvim-web-devicons' }
    -- }
use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

    use "goolord/alpha-nvim"
    
    use {
        "danymat/neogen",
        requires = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    }
    
    use "smjonas/inc-rename.nvim"
    -- use
    -- use 'rmagamagatti/auto-session'
    use "RRethy/vim-illuminate"
    if packer_bootstrap then
        require('packer').sync()
    end
end)
