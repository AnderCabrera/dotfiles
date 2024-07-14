return {
	{
		"rmagatti/auto-session",
		dependencies = {
			"nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
		},
		config = function()
			require("auto-session").setup({
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
				auto_session_enable_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
				auto_save_enabled = false,
				auto_restore_enabled = true,
				session_lens = {
					-- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
					load_on_setup = true,
					theme_conf = { border = true },
					previewer = false,
					buftypes_to_ignore = {}, -- list of buffer types that should not be deleted from current session when a new one is loaded
				},
			})
		end,
	},
}
