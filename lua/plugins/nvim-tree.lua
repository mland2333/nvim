return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- 必须：添加图标支持
  },
  -- 优化：懒加载，只有输入命令或按下快捷键时才加载插件
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  -- 快捷键配置：按 <Leader>e 切换文件树
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer" },
  },
  config = function()
    -- 建议：禁用 netrw（Neovim 内置的文件浏览器），避免冲突
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      -- 核心行为
      auto_reload_on_write = true,
      sync_root_with_cwd = true, -- 自动同步目录，这比 update_focused_file 更常用

      -- 排序规则
      sort = {
        sorter = "case_sensitive",
      },

      -- 视图设置
      view = {
        width = 30,
        side = "left",
        preserve_window_proportions = true, -- 你保留的 cmake-tools 兼容设置
        number = false,
        relativenumber = false,
        signcolumn = "yes",
      },

      -- 渲染效果 (图标与UI)
      renderer = {
        group_empty = true, -- 压缩空目录 (如把 a/ -> b/ 显示为 a/b/)
        indent_markers = {
          enable = true,    -- 显示缩进线
        },
        icons = {
          git_placement = "after", -- git 图标放在文件名后面
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },

      -- 过滤器
      filters = {
        dotfiles = false,      -- 是否隐藏 . 开头的文件 (按 H 键切换)
        custom = { "^.git$" }, -- 隐藏 .git 文件夹
      },

      -- Git 集成
      git = {
        enable = true,
        ignore = false, -- 是否隐藏 .gitignore 里定义的文件
      },

      -- 文件跟踪 (当你打开文件时，树自动定位到该文件)
      update_focused_file = {
        enable = true,
        update_root = true, -- 如果文件不在当前根目录下，是否切换根目录
      },

      -- 诊断信息 (报错文件变红)
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
    })
  end,
}
