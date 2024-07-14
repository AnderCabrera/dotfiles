return {
	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		{
			"j-hui/fidget.nvim",
			opts = {
				integration = {
					["nvim-tree"] = {
						enable = true,
					},
				},
			},
		},

		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),

			callback = function(event)
				-- Mappings
				local map = function(m, l, r, desc, opts)
					opts = opts or { buffer = event.buffer, noremap = true, silent = true }
					desc = desc or nil
					opts.desc = desc
					vim.keymap.set(m, l, r, opts)
				end

				map("n", "gD", vim.lsp.buf.declaration, "go declaration")
				map("n", "gd", vim.lsp.buf.definition, "go definition")
				map("n", "gr", vim.lsp.buf.references, "references")
				map("n", "K", vim.lsp.buf.hover, "hover")
				map("n", "gi", vim.lsp.buf.implementation, "go implementation")
				map("n", "<space>k", vim.lsp.buf.signature_help, "signature help")
				map("n", "<space>ca", vim.lsp.buf.code_action, "code action")
				map("n", "<space>rn", vim.lsp.buf.rename, "rename")
				map("n", "<space>rl", vim.lsp.codelens.run, "run codelens")
				map("n", "<space>cr", vim.lsp.codelens.refresh, "refresh codelens")
				map("n", "<space>e", vim.diagnostic.open_float, "open diagnostics")
				map("n", "[d", vim.diagnostic.goto_prev, "diagnostics prev")
				map("n", "]d", vim.diagnostic.goto_next, "diagnostics next")
				map("n", "<space>cl", vim.diagnostic.setqflist, "diagnostics quicklist")
				map("n", "<space>f", vim.lsp.buf.format, "format")

				-- stylua: ignore start
				map("n", "<space>ds", function() require("telescope.builtin").lsp_document_symbols() end, "document symbols")
				map("n", "<space>ws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
					"workspace symbols")
				-- stylua: ignore end

				-- lesser used lsp functionality
				map("n", "<space>D", vim.lsp.buf.type_definition, "type definition")
				map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "add workspace folder")
				map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "remove workspace folder")
				map("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "list workspace folders")
			end,
		})

		-- Signs
		local function callSigns()
			local signs = {
				Error = "",
				Warn = "",
				Hint = "󰌶",
			}

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end

		callSigns()

		local lspconf = require("lspconfig")

		lspconf.tsserver.setup({
			cmd = { "typescript-language-server", "--stdio" },
			name = "tsserver",
			root_dir = lspconf.util.root_pattern("package.json"),
			capabilities = vim.lsp.protocol.make_client_capabilities(),
		})

		lspconf.lua_ls.setup({})
		lspconf.angularls.setup({
			cmd = { "angular-language-server", "--stdio" },
			filetypes = { "typescript", "html" },
			root_dir = lspconf.util.root_pattern("angular.json"),
		})
		lspconf.emmet_language_server.setup({})
		lspconf.html.setup({})
		lspconf.ast_grep.setup({
			cmd = { "ast-grep", "--lsp" },
			filetypes = { "lua", "typescript", "javascript", "html", "css", "scss", "vue", "tsx", "jsx" },
			root_dir = lspconf.util.root_pattern(".git"),
		})
		lspconf.jsonls.setup({
			-- cmd = { "vscode-json-languageserver", "--stdio" },
			filetypes = { "json" },
			-- root_dir = lspconf.util.root_pattern(".git"),
		})
		lspconf.clangd.setup({
			cmd = { "clangd", "--background-index" },
			filetypes = { "c", "cpp" },
			-- root_dir = lspconf.util.root_pattern(".git"),
		})
		-- lspconf.tailwindcss.setup({
		-- 	cmd = { "tailwindcss-language-server", "--stdio" },
		-- 	filetypes = { "html", "css", "scss", "javascript", "typescript", "vue", "tsx", "jsx", "react" },
		-- 	root_dir = lspconf.util.root_pattern("tailwind.config.js"),
		-- })
		lspconf.pyright.setup({
			cmd = { "pyright-langserver", "--stdio" },
			filetypes = { "python" },
			root_dir = lspconf.util.root_pattern(".git"),
		})
		lspconf.arduino_language_server.setup({
			cmd = { "arduino-language-server", "--stdio" },
			filetypes = { "ino" },
			root_dir = lspconf.util.root_pattern(".git"),
		})

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "tsserver", "lua_ls" },
		})
	end,
}
