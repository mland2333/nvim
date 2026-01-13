return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",        -- 强烈推荐：提供超强的 Diff 对比视图
      "nvim-telescope/telescope.nvim", -- 推荐：用来选分支、选提交
    },
    -- 1. 懒加载：按键或输入命令时才加载
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Open Neogit" },
    },

    opts = {
      -- 2. 界面风格设置
      kind = "split", -- 打开方式：'split'(分屏) | 'vsplit'(垂直分屏) | 'floating'(浮窗)

      -- 3. 禁用自动打开提交时的插入模式 (可选，看个人习惯)
      disable_insert_on_commit = true,

      -- 4. 提交编辑器的设置
      commit_editor = {
        kind = "split",
        show_staged_diff = true, -- 写提交信息时，在下方显示已修改的代码（防写错）
      },

      -- 5. 整合功能
      integrations = {
        diffview = true,  -- 开启 Diffview 集成 (按 d 查看 diff 时更强大)
        telescope = true, -- 开启 Telescope 集成 (选分支时用 Telescope 搜)
      },

      -- 6. UI 美化
      signs = {
        -- 展开/折叠的图标
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },

      -- 7. 提交列表视图
      graph_style = "ascii", -- 或者 "unicode"
    },
  }
}
