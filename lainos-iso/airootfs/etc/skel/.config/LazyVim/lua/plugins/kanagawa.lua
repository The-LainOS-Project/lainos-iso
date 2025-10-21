return {
  -- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      theme = "wave",
      keywordStyle = { italic = true },
      commentStyle = { italic = true },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
