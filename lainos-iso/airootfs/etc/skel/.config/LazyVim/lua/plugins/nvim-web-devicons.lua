return {
  "nvim-tree/nvim-web-devicons",
  event = "VimEnter",
  opts = {
    strict = false,
    override_by_filename = {
      ["init.lua"] = { icon = "", color = "#78B461", name = "NeovimInitLua" },
    },
    override_by_extension = {
      ["log"] = { icon = "", color = "#FEFEFE", name = "log" },
      ["po"] = { icon = "󰗊", color = "#2596BE" },
      ["pot"] = { icon = "󰗊", color = "#2596BE" },
      ["qm"] = { icon = "󰗊", color = "#2596BE", name = "QMCompiled" },
      ["sample"] = { icon = "󰷊", color = "#12D754", name = "Sample" },
      ["sh"] = { icon = "", color = "#12D754", name = "sh" },
    },
  },
}
