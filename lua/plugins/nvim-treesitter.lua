local ensure_list = {
  'c', 'cpp', 'lua', 'query', 'javascript', 'html', 'go', 'rust',
  'yaml', 'typescript', 'json', 'css', 'bash', 'toml', 'python',
  'dockerfile', 'vim', 'regex', 'comment', 'tsx', 'vue', 'verilog',
  'hlsl', 'glsl', 'markdown', 'markdown_inline' -- 建议添加 markdown 支持
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- 优化：在打开文件时加载，确保高亮及时出现
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- 用于在 React/Vue 中正确注释 HTML 标签
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = {
          enable_autocmd = false,
        },
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = ensure_list,

        -- 改进：改为异步安装，防止启动卡死
        sync_install = false,

        -- 建议：如果打开了没有安装过 parser 的文件，自动安装
        auto_install = true,

        highlight = {
          enable = true,
          -- 针对大文件禁用高亮，避免卡顿
          disable = function(lang, buf)
            local max_filesize = 100 * 1024   -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },

        indent = { enable = true },

        -- 新增功能：增量选择 (非常推荐)
        -- 用法：按 Enter 选中当前区域，不断按 Enter 向外扩展选中
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",     -- 开始选择
            node_incremental = "<CR>",   -- 扩大选择范围
            scope_incremental = "<Tab>", -- 选择当前作用域
            node_decremental = "<BS>",   -- 缩小选择范围 (Backspace)
          },
        },
      })

      -- 开启 context_commentstring 模块
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },

  -- Rainbow Delimiters 配置保持不变，你写的已经很好了
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterBlue',
          'RainbowDelimiterYellow',
          'RainbowDelimiterCyan',
          'RainbowDelimiterViolet',
          'RainbowDelimiterRed',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
        },
      }
    end
  }
}
