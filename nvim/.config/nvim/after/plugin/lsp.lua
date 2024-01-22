local lsp = require("lsp-zero")

vim.filetype.add({ extension = { templ = "templ" } })

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	-- When neovim > 0.10
	-- vim.lsp.inlay_hint.enable(bufnr, true)

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "gr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>k", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"eslint",
		"lua_ls",
		"rust_analyzer",
		"gopls",
	},
	handlers = {
		lsp.default_setup,
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
	},
	formatting = lsp.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<S-TAB>"] = cmp.mapping.select_prev_item(cmp_select),
		["<TAB>"] = cmp.mapping.select_next_item(cmp_select),
		["<ENTER>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

local lexical_config = {
	filetypes = { "elixir", "eelixir", "heex" },
	cmd = { "/Users/kramer/oss/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
	settings = {},
}

if not configs.lexical then
	configs.lexical = {
		default_config = {
			filetypes = lexical_config.filetypes,
			cmd = lexical_config.cmd,
			root_dir = function(fname)
				return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
			end,
			-- optional settings
			settings = lexical_config.settings,
		},
	}
end

lspconfig.lexical.setup({})
