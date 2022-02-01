let mapleader = " "

call plug#begin()
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
	Plug 'nvim-lua/lsp-status.nvim'

    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    Plug 'gruvbox-community/gruvbox'

	Plug 'machakann/vim-highlightedyank'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-surround'
	Plug 'airblade/vim-rooter'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lua/lsp-status.nvim'
call plug#end()

lua require("hamptokr")
lua require'nvim-treesitter.configs'.setup{ ensure_installed = "maintained", sync_install = false, highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true}}

nnoremap <leader>w :w<CR>
nnoremap <leader>s <cmd>lua require("telescope.builtin").find_files{find_command = { "rg", "-i", "--hidden", "--files", "-g", "!.git" }}<CR>
nnoremap H ^
nnoremap L $

nnoremap Y yg$

xnoremap <leader>p "_dP

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

nnoremap <leader><leader> <c-^>
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

inoremap <C-c> <esc>