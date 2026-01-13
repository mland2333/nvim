return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode", -- 懒加载：只有输入 :ZenMode 命令时才加载插件
    opts = {
      window = {
        backdrop = 0.95,          -- 背景遮罩的透明度 (1 是全黑)
        width = 120,              -- 窗口宽度，可以是数字(列数)或百分比(例如 0.80)
        height = 1,               -- 窗口高度 (1 = 100%)
        options = {
          signcolumn = "no",      -- 隐藏左侧的 git 标记/错误标记列
          number = false,         -- 隐藏行号
          relativenumber = false, -- 隐藏相对行号
          cursorline = false,     -- 隐藏光标所在行的高亮
          cursorcolumn = false,   -- 隐藏光标所在列的高亮
          foldcolumn = "0",       -- 隐藏折叠列
          list = false,           -- 隐藏空白字符显示
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,                -- 隐藏右下角的标尺
          showcmd = false,              -- 隐藏按键提示
          laststatus = 0,               -- 隐藏状态栏
        },
        twilight = { enabled = true },  -- 集成 twilight 插件（不仅居中，还暗化不相关的代码）
        gitsigns = { enabled = false }, -- 隐藏 git 变化提示
        tmux = { enabled = true },      -- 如果你在用 tmux，开启时自动隐藏 tmux 状态栏
        wezterm = {                     -- 如果你用 wezterm
          enabled = true,
          font = "+4",                  -- 开启禅模式时字体自动放大
        },
        kitty = {                       -- 如果你用 kitty
          enabled = true,
          font = "+4",
        },
      },
      -- 回调函数：开启/关闭时的自定义操作
      on_open = function(win)
      end,
      on_close = function()
      end,
    },
    -- 设置快捷键
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
  }
}
