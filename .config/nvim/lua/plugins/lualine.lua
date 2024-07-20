return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "onedark",
				component_separators = { "" }, -- { left = "|", right = "|" },
				section_separators = { "" }, -- { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{
						"branch",
						icon = "",
					},
					"diff",
					"diagnostics",
				},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "fugitive", "nvim-tree" },
		})
	end,
}
