-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.wrap = true
opt.textwidth = 80

-- Make copilot tab completion work with nvim-cmp
-- https://github.com/LazyVim/LazyVim/discussions/4830#discussioncomment-11294507
vim.g.ai_cmp = false

-- LSP Server to use for Ruby.
-- Set to "solargraph" to use solargraph instead of ruby_lsp.
vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.lazyvim_ruby_formatter = "standard"
