return {
  {
    'stevearc/conform.nvim',
    event = { "BufReadPre", "BufNewFile" }, -- 只有打开文件时才加载，不用 lazy=true + cmd
    dependencies = {
      "mason.nvim",                         -- 确保 mason 在这之前加载
    },
    cmd = { "ConformInfo" },

    -- 快捷键设置
    keys = {
      {
        -- 手动触发格式化
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
      {
        -- 开关自动格式化 (Toggle)
        "<leader>tf",
        function()
          -- 如果全局变量为 true，则设为 false，反之亦然
          if vim.g.disable_autoformat or vim.b.disable_autoformat then
            vim.cmd("FormatEnable")
            vim.notify("Autoformat Enabled", "info", { title = "Conform" })
          else
            vim.cmd("FormatDisable")
            vim.notify("Autoformat Disabled", "warn", { title = "Conform" })
          end
        end,
        desc = "Toggle Autoformat",
      },
    },

    -- 插件主要配置
    opts = {
      -- 1. 定义不同语言的格式化工具
      formatters_by_ft = {
        lua = { "stylua" },
        -- Python: 先跑 isort 整理引用，再跑 black 格式化
        python = { "isort", "black" },
        -- JS/TS: 优先用 prettierd (守护进程版，更快)，没有就用 prettier
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        c = { "clang-format" },
        cpp = { "clang-format" },
        -- 这里的 _ 意味着“所有其他文件类型”
        -- ["_"] = { "trim_whitespace" },
      },

      -- 2. 保存时自动格式化配置
      format_on_save = function(bufnr)
        -- 如果手动禁用了（通过下面的命令），则不格式化
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          timeout_ms = 3000,   -- 增加到 3秒，防止 prettier 超时
          lsp_fallback = true, -- 如果没安装 prettier，尝试用 tsserver 格式化
        }
      end,

      -- 3. 错误通知
      notify_on_error = true,
    },

    -- 初始化配置 (这里用来定义开关命令)
    init = function()
      -- 创建 :FormatDisable 命令
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! (加感叹号只禁用当前 buffer)
          vim.b.disable_autoformat = true
        else
          -- FormatDisable (禁用全局)
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      -- 创建 :FormatEnable 命令
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  }
}
