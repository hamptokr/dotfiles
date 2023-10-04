local lsp = require("lsp-zero")
local ih = require("inlay-hints")

ih.setup({
	-- renderer to use
	-- possible options are dynamic, eol, virtline and custom
	-- renderer = "inlay-hints/render/dynamic",
	renderer = "inlay-hints/render/eol",

	hints = {
		parameter = {
			show = true,
			highlight = "whitespace",
		},
		type = {
			show = true,
			highlight = "Whitespace",
		},
	},

	-- Only show inlay hints for the current line
	only_current_line = false,

	eol = {
		-- whether to align to the extreme right or not
		right_align = false,

		-- padding from the right if right_align is true
		right_align_padding = 7,

		parameter = {
			separator = ", ",
			format = function(hints)
				return string.format(" <- (%s)", hints)
			end,
		},

		type = {
			separator = ", ",
			format = function(hints)
				return string.format(" => %s", hints)
			end,
		},
	},
})

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"lua_ls",
	"rust_analyzer",
	"gopls",
})

local custom_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

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
end

lsp.configure("elixirls", {
	settings = {
		elixirLS = {
			dialyzerEnabled = false,
			fetchDeps = false,
			enableTestLenses = true,
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my-inlay-hints", {}),
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if ft ~= "go" then
			return
		end

		local client = vim.lsp.get_client_by_id(args.data.client_id)
		require("inlay-hints").on_attach(client, args.buf)
	end,
})

lsp.setup({ on_attach = custom_attach })

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

local lexical_config = {
	filetypes = { "elixir", "eelixir" },
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

lspconfig.lexical.setup({ on_attach = custom_attach })
