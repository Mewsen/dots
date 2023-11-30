return {
  {
    "nvim-neorg/neorg",
    -- lazy-load on filetype
    lazy = false,
    -- options for neorg. This will automatically call `require("neorg").setup(opts)`
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              home = "~/workspace/git/ausbildung/",
            },
          },
        },
      },
    },
  },
}
