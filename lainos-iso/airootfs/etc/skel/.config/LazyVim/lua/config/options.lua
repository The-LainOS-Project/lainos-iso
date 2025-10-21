-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.expandtab = false -- Use spaces instead of tabs
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.number = true -- Print line number
vim.opt.relativenumber = true
vim.opt.shiftwidth = 8 -- Size of an indent
vim.opt.signcolumn = "auto" -- Column that shows signs for debuggers, etc
vim.opt.tabstop = 8 -- Number of spaces tabs count for
-- vim.opt.winbar = "%=%m %f" -- Filename at top-right corner
vim.opt.wrap = true -- lines longer than the width of the window will wrap and	displaying continues on the next line
vim.opt.shada = "'500,<1000,s100" -- Save marks for the last 500 files, upto 1000 lines, items bigger than 100Kb skipped
-- vim.opt.spell = true
-- vim.opt.spelllang = { "en" } -- list of languages to spell check
