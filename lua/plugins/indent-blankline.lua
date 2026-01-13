return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
  keys = {
    {
      "<leader>ui",
      function()
        vim.cmd("IBLToggle")
      end,
      desc = "Toggle indent guides",
    },
  },
}
