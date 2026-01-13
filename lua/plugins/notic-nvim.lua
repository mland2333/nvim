return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      -- 1. LSP UI 覆盖配置
      lsp = {
        signature = { enabled = false }, -- 交给其他插件(如 cmp)处理
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },

      -- 2. 预设配置
      presets = {
        bottom_search = false,        -- 搜索栏居中
        command_palette = true,       -- 命令行居中
        long_message_to_split = true, -- 长消息分屏显示
        inc_rename = true,            -- 增量重命名弹窗
        lsp_doc_border = false,       -- 文档边框
      },

      -- 3. 核心改进：使用 Noice 的路由系统来过滤垃圾消息
      -- 替代了你原来在 nvim-notify 里手写的 if msg:match(...)
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },                                 -- 屏蔽保存文件时的 "10L, 50B" 提示
              { find = "; after #%d+" },                               -- 屏蔽 undo/redo 提示
              { find = "; before #%d+" },
              { find = "multiple different client offset_encodings" }, -- 屏蔽常见 LSP 报错
              { find = "clipboard: error" },                           -- 屏蔽剪贴板错误
              { find = "trying to get preamble for non-added document" },
            },
          },
          opts = { skip = true }, -- 动作：直接跳过，不显示
        },
        -- 特殊处理：将 "No results for **qflist**" 这类消息简化
        -- 这里只是示例，通常 Noice 处理这类消息已经很好看了
      },

      -- 4. 命令行外观
      cmdline = {
        view = "cmdline_popup",
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        },
      },
    },
    -- 5. 配置 nvim-notify 的外观 (Noice 会自动加载它)
    config = function(_, opts)
      require("noice").setup(opts)

      -- 单独配置 notify 的样式
      require("notify").setup({
        background_colour = "#000000", -- 你原本的黑色背景设置
        render = "minimal",
        minimum_width = 50,
        max_width = 100,
        timeout = 2000,    -- 稍微延长一点时间，1秒有时候看不清
        stages = "static", -- 或者 "fade_in_slide_out", 动画效果
      })

      -- 绑定 telescope 查找历史通知 (可选快捷键)
      vim.keymap.set("n", "<leader>fn", function()
        require("telescope").extensions.notify.notify()
      end, { desc = "Find Notifications" })
    end,
  }
}
