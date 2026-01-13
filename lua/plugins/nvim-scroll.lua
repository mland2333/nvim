return {
  {
    'petertriho/nvim-scrollbar',
    -- 优化：只有打开文件后才加载，加快启动速度
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- 推荐：配合 gitsigns 使用，才能在滚动条显示 git 修改
      'lewis6991/gitsigns.nvim',
      -- 推荐：配合 hlslens 使用，搜索高亮体验更好（如果你没装这个，可以把这行删掉）
      -- 'kevinhwang91/nvim-hlslens',
    },
    config = function()
      require("scrollbar").setup({
        show = true,
        show_in_active_only = false,
        set_highlights = true,

        -- 外观设置：让滚动条看起来更自然
        handle = {
          text = " ",
          blend = 50, -- 透明度
        },
        marks = {
          Search    = { color = "#ff9e64" }, -- 搜索匹配项的颜色
          Error     = { color = "#db4b4b" }, -- 错误的颜色
          Warn      = { color = "#e0af68" }, -- 警告的颜色
          GitAdd    = { color = "#9ece6a" }, -- Git 新增
          GitChange = { color = "#7aa2f7" }, -- Git 修改
        },

        -- 排除列表：这些窗口不要显示滚动条
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
          "noice",
          "neo-tree",
          "dashboard",
          "alpha",
          "lazy",
        },

        -- 核心功能：开启集成
        handlers = {
          cursor = false,    -- 关闭光标位置（太晃眼了）
          diagnostic = true, -- 开启：显示 LSP 报错/警告
          gitsigns = true,   -- 开启：显示 Git 修改 (需要安装 gitsigns)
          handle = true,     -- 开启：显示滚动滑块
          search = true,     -- 开启：显示搜索结果
          ale = false,       -- 如果你不用 ale 插件，就关掉
        },
      })
    end
  }
}
