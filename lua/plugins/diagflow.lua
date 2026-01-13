return {
  {
    'dgagn/diagflow.nvim',
    -- 1. 懒加载：只有当 LSP 启动时才加载这个插件
    event = 'LspAttach',

    -- 2. 详细配置
    opts = {
      -- 作用范围: 'line' (显示当前行所有报错) | 'cursor' (只显示光标下报错)
      scope = 'line',

      -- 放置位置: 'top' (右上角) | 'inline' (行尾，但更智能)
      -- 推荐 'top'，这是这个插件的精髓，把报错放到右上角，完全不挡代码
      placement = 'top',

      -- 是否显示诊断的来源 (比如显示 [Pyright] 还是只显示错误内容)
      show_sign = true,

      -- 渲染混合模式
      render_event = { 'DiagnosticChanged', 'CursorMoved' },

      -- 自定义格式 (可选)
      format = function(diagnostic)
        return diagnostic.message
      end,

      -- 颜色混合 (让背景色更自然)
      toggle_event = { 'InsertEnter' }, -- 进入插入模式时自动隐藏，避免打字干扰
    },

    config = function(_, opts)
      require('diagflow').setup(opts)

      -- 3. 关键一步：关闭 Neovim 原生的虚拟文本
      -- 既然用了 diagflow，就要把原生的关掉，不然会显示两份报错
      vim.diagnostic.config({
        virtual_text = false,
      })
    end
  }
}
