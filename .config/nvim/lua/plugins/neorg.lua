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
        ["core.export"] = {},
        ["core.export.markdown"] = {},
        ["core.summary"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              default = "~/workspace/neorg",
            },
          },
        },
      },
    },
  },
}
