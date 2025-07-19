return {
  {
    "nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "copilot",
        -- LazyVim sets `group_index = 1` by default, which results in useless copilot suggestions clobering i.e. emmet suggestions.
        -- https://www.lazyvim.org/extras/coding/copilot#nvim-cmp
        group_index = 2,
        priority = 100,
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      copilot_node_command = "/opt/homebrew/bin/node",
    },
  },
}
