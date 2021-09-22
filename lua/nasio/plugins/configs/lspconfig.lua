-- setup lspconfig
local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "ga", "<cmd>lua require[[telescope.builtin]].lsp_code_actions{}<CR>", opts)
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua require[[telescope.builtin]].lsp_definitions{}<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua require[[telescope.builtin]].lsp_references{}<CR>", opts)
	buf_set_keymap("n", "gws", "<cmd>lua require[[telescope.builtin]].lsp_workspace_symbols{}<CR>", opts)
	buf_set_keymap("n", "gwd", "<cmd>lua require[[telescope.builtin]].lsp_workspace_diagnostics{}<CR>", opts)
	buf_set_keymap("n", "gos", "<cmd>lua require[[telescope.builtin]].lsp_document_symbols{}<CR>", opts)
	buf_set_keymap("n", "god", "<cmd>lua require[[telescope.builtin]].lsp_document_diagnostics{}<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<space>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

-- Configure lua language server for neovim development
local lua_settings = {
	Lua = {
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = { "vim", "use" },
		},
	},
}

-- config that activates keymaps and enables snippet support
local function make_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
	}
end

local black = require("nasio/efm/black")
local flake8 = require("nasio/efm/flake8")
local isort = require("nasio/efm/isort")
local mypy = require("nasio/efm/mypy")
local stylua = require("nasio/efm/stylua")

local function setup_servers()
	require("lspinstall").setup()

	local servers = require("lspinstall").installed_servers()
	-- manually installed servers are added here

	for _, server in pairs(servers) do
		local config = make_config()

		-- here customize config for different servers
		if server == "lua" then
			config.settings = lua_settings
		end

		if server == "efm" then
			config.init_options = { documentFormatting = true }
			config.root_dir = vim.loop.cwd
			config.filetypes = { "python", "lua" }
			config.settings = {
				rootMarkers = { ".git/", "pyproject.toml" },
				languages = {
					python = { black, flake8, isort, mypy },
					lua = { stylua },
				},
			}
		end

		nvim_lsp[server].setup(config)
	end
end

setup_servers()

-- define custom diagnostics
vim.fn.sign_define(
	"DiagnosticSignWarn",
	{ text = "", numhl = "DiagnosticSignWarn", texthl = "DiagnosticSignWarn" }
)
vim.fn.sign_define(
	"DiagnosticSignError",
	{ text = "", numhl = "DiagnosticSignError", texthl = "DiagnosticSignError" }
)
vim.fn.sign_define(
	"DiagnosticSignInfo",
	{ text = "", numhl = "DiagnosticSignInfo", texthl = "DiagnosticSignInfo" }
)
vim.fn.sign_define(
	"DiagnosticSignHint",
	{ text = "", numhl = "DiagnosticSignHint", texthl = "DiagnosticSignHint" }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
   virtual_text = {
      prefix = "",
      spacing = 0,
   },
   signs = true,
   underline = true,
   update_in_insert = false, -- update diagnostics insert mode
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
   border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
   border = "single",
})

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require("lspinstall").post_install_hook = function()
	setup_servers() -- reload installed servers
	vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- Also setup fluttertools
require("flutter-tools").setup({
	debugger = {
		enabled = true,
	},
	lsp = {
		on_attach = on_attach,
	},
})
