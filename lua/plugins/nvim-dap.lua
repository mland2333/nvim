return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    -- 只有在需要调试时才加载，优化启动速度
    -- 也可以用 keys = { ... } 来懒加载
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- 1. 初始化插件 (必须步骤，否则会报错或样式不对)
      dapui.setup()

      -- 2. 自动化配置：
      -- 当开始调试(attach或launch)时，自动打开 UI
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      -- 当调试结束(terminated或exited)时，自动关闭 UI
      -- 如果你想调试完看看变量，可以注释掉下面这两行
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- 3. 界面美化 (可选，设置断点图标)
      vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })
    end,

    -- 4. 快捷键配置 (Lazy.nvim 风格)
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle Debug UI" },
      { "<leader>de", function() require("dapui").eval() end,   desc = "Eval Variable" },
    }
  }
}
