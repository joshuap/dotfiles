return {
  "neovim/nvim-lspconfig",
  init = function()
    -- https://github.com/standardrb/standard/pull/475#issuecomment-1298904703
    vim.opt.signcolumn = "yes" -- otherwise it bounces in and out, not strictly needed though
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "ruby",
      group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }), -- also this is not /needed/ but it's good practice
      callback = function()
        vim.lsp.start({
          name = "standard",
          cmd = { "/Users/josh/.asdf/shims/standardrb", "--lsp" },
        })
      end,
    })
  end,
}
