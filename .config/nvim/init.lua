vim.g.mapleader = ' '

require 'paq' {
    'savq/paq-nvim';

    'neovim/nvim-lspconfig';
    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-buffer';
    'hrsh7th/cmp-path';
    'hrsh7th/cmp-cmdline';
    'hrsh7th/nvim-cmp';

    'hrsh7th/cmp-vsnip';
    'hrsh7th/vim-vsnip';

    'nvim-lua/plenary.nvim';
    'nvim-telescope/telescope.nvim';

    'gruvbox-community/gruvbox';

	'machakann/vim-highlightedyank';
	'tpope/vim-fugitive';
	'tpope/vim-surround';
	'andymass/vim-matchup';
	'airblade/vim-rooter';

    {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'};
}

require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
  indent = {
	enable = true,
  },
  matchup = {
	enable = true,
  },
}

-- Setup LSPs
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
	  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 5000)
    ]], false)
  end
end

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
	  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
	  i = cmp.mapping.abort(),
	  c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig integration.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.rust_analyzer.setup{
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
}

nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  single_file_support = true
}


-- Editor options
vim.cmd([[colorscheme gruvbox]])
vim.api.nvim_set_var('gruvbox_contrast_light', 'hard')
vim.o.encoding = 'utf-8'
vim.o.scrolloff = 2
vim.o.hidden = true
vim.o.showmode = false
vim.o.wrap = false
vim.o.signcolumn = 'yes'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.undodir = '~/.vimdid'
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.gdefault = true
vim.o.relativenumber = true
vim.o.number = true
vim.o.colorcolumn = '80,120'
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4


-- Keybindings

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function nmap(lhs, rhs, opts)
  map('n', lhs, rhs, opts)
end

local function imap(lhs, rhs, opts)
  map('i', lhs, rhs, opts)
end

nmap('<leader>w', ':w <CR>')
nmap('<leader>s', '<cmd>lua require("telescope.builtin").find_files()<CR>')
nmap('H', '^')
nmap('L', '$')

-- Force home row
nmap('<up>', '<nop>')
nmap('<down>', '<nop>')
imap('<up>', '<nop>')
imap('<down>', '<nop>')
imap('<left>', '<nop>')
imap('<right>', '<nop>')

-- Switch buffers
nmap('<left>', ':bp<CR>')
nmap('<right>', ':bn<CR>')
nmap('<leader><leader>', '<c-^>')

-- Replace up to next - or _
nmap('<leader>m', 'ct_')
