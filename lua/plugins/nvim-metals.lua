return {
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap", -- 建议添加：调试支持
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()

      -- 1. 改进：关联 nvim-cmp 的 capabilities
      -- 这样你的自动补全才会包含 Snippets 和更详细的信息
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 2. 改进：配置 on_attach
      metals_config.on_attach = function(client, bufnr)
        -- 启用调试器功能 (需要你安装了 nvim-dap)
        require("metals").setup_dap()

        -- 这里可以绑定一些 Scala 专用的快捷键
        -- 例如：查看所有引用、实现等
        -- vim.keymap.set("n", "<leader>ws", function() require("metals").hover_worksheet() end)
      end

      -- 3. 改进：Metals 具体设置
      metals_config.settings = {
        showImplicitArguments = true, -- 显示隐式参数 (Scala 杀手级功能)
        showImplicitConversionsAndClasses = true,
        showInferredType = true,      -- 显示推导类型
        superMethodLensesEnabled = true,
        -- 如果你用 gradle 或 maven，可以在这里指定
        -- buildTool = "sbt",
      }

      -- 4. 状态栏支持
      -- 允许 Metals 向状态栏发送构建进度信息
      metals_config.init_options.statusBarProvider = "on"

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  }
}
