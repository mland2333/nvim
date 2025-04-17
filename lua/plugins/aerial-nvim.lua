return {
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function ()
      require("aerial").setup({
        layout = {
          max_width = { 40, 0.25 },
          min_width = 16,
          resize_to_content = true,
          preserve_equality = true,
        },
        keymaps = {
          ["q"] = {
            callback = function() vim.cmd [[ :AerialClose ]] end,
            desc = "Close the aerial window",
            nowait = true,
          },
        },
      })
      vim.keymap.set("n", "<F12>", "<cmd>AerialToggle!<CR>")
      local found_telescope, telescope = pcall(require, "telescope")
      if found_telescope then
        telescope.load_extension("aerial")
      end
    end
  }
}


