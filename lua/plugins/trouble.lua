return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- 必须依赖图标库
    cmd = "Trouble",                                  -- 懒加载：输入命令时加载
    -- 懒加载：按下以下快捷键时加载
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    -- 插件具体配置
    opts = {
      -- 这里的配置会自动传给 require("trouble").setup(opts)
      -- 除非你有非常特殊的审美需求，否则保留默认即可，默认已经非常好看
      focus = true,       -- 打开时自动聚焦到窗口
      auto_close = false, -- 点击结果后自动关闭窗口? 建议 false

      -- 如果你确实想要自定义图标，应该写在 icons 表里 (适配 Trouble v3)
      icons = {
        indent = {
          top = "│ ",
          middle = "├╴",
          last = "╰╴",
          fold_open = " ",
          fold_closed = " ",
          ws = "  ",
        },
        folder_closed = " ",
        folder_open = " ",
        kinds = {
          -- 这里其实不用写，默认的就已经包含这些图标了
          -- 如果你想改，格式如下：
          -- Error = " ",
        },
      },
    },
  },
}
