return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require('nvim-tree').setup {
      update_cwd = true,
      sort_by = "case_sensitive",
	    -- 是否显示 git 状态
	    git = {
		    enable = true,
	    },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      view = {
        signcolumn = "yes",
        -- 文件浏览器展示位置，左侧：left, 右侧：right
	      side = "left",
	      -- 行号是否显示
	      number = false,
	      relativenumber = false,
        --adaptive_size = true,
        width = 30,
      },
    }
  end
}
