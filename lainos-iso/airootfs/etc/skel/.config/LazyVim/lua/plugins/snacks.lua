return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      sections = {
        -- { section = "header" },
        {
          -- XXX: cool configs -> https://github.com/folke/snacks.nvim/discussions/111
          section = "terminal",
          cmd = vim.fn.stdpath("config")
            .. "/lua/plugins/script.sh "
            .. vim.fn.stdpath("config")
            .. "/lua/plugins/banner_lain.txt",
          indent = 10, -- horizontal displacement
          height = 23,
          width = 33,
          padding = 1, -- empty lines after section
        },
        {
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 1,
        },
        { section = "startup" },
        { pane = 2, section = "keys", gap = 1, indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      },
    },
    lazygit = {
      configure = false,
    },
    styles = {
      lazygit = {
        relative = "editor",
        width = 0.95,
        height = 0.95,
      },
    },
  },
}
