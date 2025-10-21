return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    default_component_configs = {
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "󰡯",
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          ".git",
          ".DS_Store",
          "thumbs.db",
        },
        never_show = {},
      },
    },
  },
}
