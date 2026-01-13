return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x', -- 建议锁定分支，更稳定
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- 改进 1: 使用 fzf-native 代替 fzy，速度更快，体验更好
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'               -- 注意：这需要你的电脑安装了 make 和 gcc/clang
      },
      'nvim-tree/nvim-web-devicons', -- 可选：让搜索结果显示图标
    },

    -- 改进 2: 使用 keys 列表来实现懒加载
    -- 这样 Neovim 启动时就会创建快捷键，按下快捷键时才会加载插件
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end,  desc = "Find Files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end,   desc = "Live Grep" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end,     desc = "Find Buffers" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end,   desc = "Help Tags" },
      -- 推荐增加：搜索当前单词
      { "<leader>fw", function() require("telescope.builtin").grep_string() end, desc = "Grep Word" },
      -- 推荐增加：查看之前的搜索记录
      { "<leader>fr", function() require("telescope.builtin").resume() end,      desc = "Resume Search" },
    },

    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          prompt_prefix = '  ', -- 搜索图标
          selection_caret = '  ', -- 选中图标
          path_display = { "truncate" }, -- 如果路径太长，截断显示

          -- 布局配置：让搜索框在上方（类似 VSCode）
          layout_config = {
            horizontal = { prompt_position = 'top', preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
          },
          sorting_strategy = 'ascending', -- 结果从上往下排

          -- 常用映射
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,              -- Ctrl-k 上移
              ["<C-j>"] = actions.move_selection_next,                  -- Ctrl-j 下移
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist, -- 放入列表批量操作
            },
          },

          -- 屏蔽掉 node_modules 和 .git 文件夹
          file_ignore_patterns = { "node_modules", ".git" },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      -- 加载 fzf 扩展
      telescope.load_extension('fzf')
    end
  }
}
