return {
  {
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim'
    },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      -- 1. 设置头部 Logo (这里是一个简单的 Nvim Logo，你可以换成任何你喜欢的 ASCII Art)
      dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }

      -- 2. 设置按钮 (结合 Telescope)
      -- 参数: 快捷键, 显示文字, 执行命令
      dashboard.section.buttons.val = {
        dashboard.button("f", "🔍  Find File  (找文件)", ":Telescope find_files<CR>"),
        dashboard.button("r", "🕒  Old Files  (最近历史)", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "fw  Live Grep  (全局搜索)", ":Telescope live_grep<CR>"),
        dashboard.button("c", "⚙️   Config     (配置文件)", ":e $MYVIMRC<CR>"),
        dashboard.button("q", "🚪  Quit       (退出)", ":qa<CR>"),
      }

      -- 3. 底部显示插件数量和启动时间
      -- 这是一个小函数，用来读取 lazy.nvim 的统计数据
      local function footer()
        return "⚡ Neovim loaded " .. require("lazy").stats().count .. " plugins"
      end
      dashboard.section.footer.val = footer()

      -- 4. 样式调整 (让它居中更好看)
      dashboard.section.header.opts.hl = "Type"
      dashboard.section.buttons.opts.hl = "Keyword"
      dashboard.section.footer.opts.hl = "Constant"

      -- 5. 启动 alpha
      alpha.setup(dashboard.config)

      -- 额外优化: 打开 dashboard 时自动隐藏底部的状态栏和 Tab 栏，进入文件后恢复
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          vim.opt.cmdheight = 0
          vim.opt.laststatus = 0
        end,
      })
      vim.api.nvim_create_autocmd("BufUnload", {
        buffer = 0,
        callback = function()
          vim.opt.cmdheight = 1
          vim.opt.laststatus = 3 -- 或者你原来的设置 (通常是 2 或 3)
        end,
      })
    end
  }
}
