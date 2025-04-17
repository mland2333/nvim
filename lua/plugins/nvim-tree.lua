return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require('nvim-tree').setup {
      auto_reload_on_write = true,
      -- hijack_cursor = false,
      -- open_on_setup = false,
      -- open_on_setup_file = true,
      -- hijack_unnamed_buffer_when_opening = false,
      sort_by = "name",
      view = {
        width = 30,
        -- height = 30,
        side = "left",
        --color = "#3f0af0",
        preserve_window_proportions = true, -- cmake-tools say that they need this
      },
      filters = {
        custom = { "^.git$" },
      },
      --  update_cwd = true,
      --  sort_by = "case_sensitive",
      -- -- 是否显示 git 状态
      git = {
        enable = true,
        ignore = false,
      },
      update_focused_file = {
        enable = true,
        -- update_cwd = true,
        update_root = true,
      },
      --  view = {
      --    signcolumn = "yes",
      --    -- 文件浏览器展示位置，左侧：left, 右侧：right
      --   side = "left",
      --   -- 行号是否显示
      --   number = false,
      --   relativenumber = false,
      --    --adaptive_size = true,
      --    width = 30,
      --  },
    }
  end
}
