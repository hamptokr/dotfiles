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
    Plug 'ThePrimeagen/git-worktree.nvim'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'

    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lua/lsp-status.nvim'

    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'catppuccin/nvim', {'as': 'catppuccin'}
    Plug 'editorconfig/editorconfig-vim'
    Plug 'xiyaowong/nvim-transparent'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

lua require("hamptokr")
lua require'nvim-treesitter.configs'.setup{ ensure_installed = {'vim', 'c', 'rust', 'lua', 'elixir', 'eex', 'heex', 'erlang', 'go', 'javascript', 'typescript', 'prisma', 'tsx', 'ruby'}, sync_install = false, highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true}}
lua require('telescope').setup{ defaults = { preview = { treesitter = false }}}
lua require('telescope').load_extension("git_worktree")

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" vim-go settings
let g:go_fmt_command = 'goimports'
let g:go_fmt_autosave = 1
let g:go_gopls_enabled = 1

nnoremap <leader>w :w<CR>
nnoremap <leader>s <cmd>lua require("telescope.builtin").find_files{find_command = { "rg", "-i", "--hidden", "--files", "-g", "!.git" }}<CR>
nnoremap <leader>f <cmd>lua require("telescope.builtin").live_grep()<CR>
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

nnoremap <leader>ga :Git fetch --all<CR>

nmap <leader>gs :G<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gj :diffget //3<CR>

nnoremap <leader>cf @*=expand("%")<CR>
