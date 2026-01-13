return {
  {
    'stevearc/aerial.nvim',
    -- 依赖项
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("aerial").setup({
        -- 1. 优先使用 LSP，如果 LSP 还没启动，才用 Treesitter
        backends = { "lsp", "treesitter", "markdown", "man" },

        layout = {
          -- 侧边栏显示在右侧 (也可以改 'left')
          placement = "window", 
          max_width = { 40, 0.2 },
          min_width = 20,
          -- 根据内容自动缩放宽度
          resize_to_content = true,
          -- 当只有一个编辑器窗口时，保持大纲打开
          preserve_equality = true,
        },

        -- 2. 自动关闭设置 (可选: 如果你喜欢跳过去后大纲自动消失，设为 true)
        close_on_select = false,

        -- 3. 图标设置 (让界面更漂亮)
        show_guides = true, -- 显示缩进辅助线
        nerd_font = "auto", -- 自动适配图标

        -- 4. 快捷键映射 (仅在 aerial 窗口内生效)
        keymaps = {
          ["?"] = "actions.show_help",
          ["q"] = "actions.close",
          ["<CR>"] = "actions.jump",       -- 回车跳转
          ["<2-LeftMouse>"] = "actions.jump", -- 双击跳转
          ["o"] = "actions.tree_toggle",   -- o 展开/折叠
        },

        -- 5. 高级导航：在代码中直接跳转函数！
        -- 当 aerial 加载时，给当前 buffer 绑定快捷键
        on_attach = function(bufnr)
          -- '{' 跳转到上一个符号(函数/类)
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Prev Symbol" })
          -- '}' 跳转到下一个符号(函数/类)
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Next Symbol" })
        end,
      })

      -- === 全局快捷键 ===
      -- 推荐用 <leader>a (Aerial) 或者 <leader>o (Outline)
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle Outline" })
      
      -- 集成 Telescope (模糊搜索大纲)
      -- 这是一个神器：比如你想找个函数，但不知道在哪行，按这个键搜名字直接跳！
      local found_telescope, telescope = pcall(require, "telescope")
      if found_telescope then
        telescope.load_extension("aerial")
        vim.keymap.set("n", "<leader>fa", "<cmd>Telescope aerial<CR>", { desc = "Find Symbol (Aerial)" })
      end
    end
  }
}


