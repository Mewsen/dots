return {
	'stevearc/overseer.nvim',
	---@module 'overseer'
	---@type overseer.SetupOpts
	opts = {
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = false,
		}
	},

	keys = {
		{ '<C-c><C-c>', '<CMD>OverseerRun<CR>', desc = 'run Task' }
	},
}
