return {
	'nvim-telescope/telescope-project.nvim',

	keys = {
		{ '<leader>pp', ':lua require"telescope".extensions.project.project{}<CR>', desc = 'Search Projects' }
	},
	dependencies = {
		'nvim-telescope/telescope.nvim',
	},
}
