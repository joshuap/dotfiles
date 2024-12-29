-- Note: emmet requires emmet-language-server. Install with:
--   :MasonInstall emmet-language-server
-- See https://github.com/olrtg/emmet-language-server
return {
  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
    end,
  },

  -- {
  --   "nvim-cmp",
  --   opts = function(_, opts)
  --     table.insert(opts.sources, 1, {
  --       name = "emmet_language_server",
  --       group_index = 1,
  --       priority = 200,
  --     })
  --   end,
  -- },
}
