function colorScheme(color)
	local function set_color(group, options)
		vim.api.nvim_set_hl(0, group, options)
	end

	vim.g.ayucolor = "dark"

	color = color or "ayu"

	if color == "onedark" then
		set_color("@operator", { fg = "#56B6C2" })
		set_color("@field", { fg = "#E06C75" })
		set_color("@string.escape", { fg = "#56B6C2" })
		-- set_color("@punctuation.delimiter", { fg = '#56B6C2' })
		set_color("@constructor", { link = "@type" })
		set_color("@type.qualifier", { fg = "#c678dd" })
		set_color("@type.builtin", { link = "@type" })

		set_color("@lsp.type.namespace", { fg = "#D18A66" })
		set_color("@lsp.mod.namespace", { fg = "#D18A66" })
		set_color("@lsp.type.enum", { fg = "#D19A66" })
		set_color("@lsp.type.enumMember", { fg = "#56B6C2" })
		set_color("@lsp.type.interface", { fg = "#98C379", italic = true })
		set_color("@lsp.type.parameter", { fg = "#ABB2BF", italic = true })
		set_color("@lsp.type.property", { fg = "#E06C75" })
		set_color("@lsp.type.selfKeyword", { fg = "#c678dd" })
		set_color("@lsp.type.selfTypeKeyword", { fg = "#c678dd" })
		set_color("@lsp.type.builtinType", { link = "@type" })
	end

	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

colorScheme("onedark")

local function testingAutocmd()
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
		pattern = "*.js",
		callback = function(ev)
			local fidget = require("fidget")

			fidget.notify("Javascript", nil, { annote = ":)", key = "foobar" })
		end,
	})
end

testingAutocmd()

