return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({
      -- 可以在这里修改默认配置，比如快捷键等
      -- 通常默认配置已足够好用
    })
  end,
  keys = {
    -- 推荐快捷键：<leader>sr (Search Replace)
    { "<leader>sr", function() require("grug-far").open() end, mode = { "n", "v" }, desc = "Search and Replace (Grug-far)" },
  },
}
