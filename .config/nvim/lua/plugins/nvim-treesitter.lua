-- i don't know why the fuck this conf does not work if treesitter is installed with this initial configuration
-- How to fix it? :
-- delete ~/.local/share/nvim/lazy folder to can re install all plugins again
-- then re-install all plugins but first you must comment the conf section
-- just stay with { "nvim-treesitter/nvim-treesitter", build: ":TSUpdate" }
-- then re-install all plugins and go to ~/.local/share/nvim/lazy/nvim-treesitter/lua/nvim-treesitter/configs.lua and change highlight = true or whatever you want
-- after that use :TSInstall lua.
-- After all that you can finally use nvim-treesitter.configs and modify whatever you want lol.

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "c", "vim", "vimdoc", "query", "javascript", "typescript", "lua", "html" },
				sync_install = false,
				highlight = { enable = true, disable = { "html" } },
				indent = { enable = false },
			})
		end,
	},
}
