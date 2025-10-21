-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- transparent toggle
map({ "i", "n", "v" }, "<F7>", "<cmd>TransparentToggle<cr><esc>", { desc = "Toggle transparency" })

-- toggle terminal
map({ "i", "n", "v" }, "<C-k>", "<cmd>TmuxNavigateUp<cr><esc>", { desc = "Move cursor to top pane" })
map({ "i", "n", "v" }, "<C-j>", "<cmd>TmuxNavigateDown<cr><esc>", { desc = "Move cursor to bottom pane" })
map({ "i", "n", "v" }, "<C-h>", "<cmd>TmuxNavigateLeft<cr><esc>", { desc = "Move cursor to left pane" })
map({ "i", "n", "v" }, "<C-l>", "<cmd>TmuxNavigateRight<cr><esc>", { desc = "Move cursor to right pane" })
map({ "i", "n", "v" }, "<C-\\>", "<cmd>TmuxNavigatePrevious<cr><esc>", { desc = "Move cursor to previous pane" })
