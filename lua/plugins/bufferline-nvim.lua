return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- 图标支持
      "echasnovski/mini.bufremove",  -- 更好的关闭 buffer 插件 (不会弄乱布局)
    },
    config = function()
      -- 确保开启真彩色
      vim.opt.termguicolors = true
      
      -- 引入 mini.bufremove
      require('mini.bufremove').setup()

      require("bufferline").setup {
        options = {
          -- 风格: 'slant' | 'slope' | 'thick' | 'thin'
          style_preset = require("bufferline").style_preset.default,
          separator_style = "slant", 
          
          -- 图标设置
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          
          -- 显示 LSP 诊断
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,

          -- 左侧避让设置 (文件树)
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
              text_align = "left"
            },
            {
              filetype = "aerial", -- 适配你之前问的 aerial
              text = "Outline",
              highlight = "Directory",
              text_align = "right"
            }
          },

          -- 鼠标点击关闭时的行为
          close_command = function(bufnum)
            require('mini.bufremove').delete(bufnum, false)
          end,

          -- 排序和过滤
          sort_by = 'insert_after_current',
          hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
          },
        }
      }

      -- === 快捷键设置 (推荐方案) ===
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true, desc = "Buffer" }

      -- 1. 左右切换 (最常用) -> Shift + H / L
      map('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = "Prev Buffer" })
      map('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { desc = "Next Buffer" })

      -- 2. 移动 Buffer 位置 -> Leader + b + 箭头
      map('n', '<leader>b<Left>', '<cmd>BufferLineMovePrev<CR>', { desc = "Move buffer left" })
      map('n', '<leader>b<Right>', '<cmd>BufferLineMoveNext<CR>', { desc = "Move buffer right" })

      -- 3. 关闭 Buffer
      -- 使用 mini.bufremove 删除当前 buffer，不破坏窗口布局
      map('n', '<leader>bd', function() require("mini.bufremove").delete(0, false) end, { desc = "Delete Buffer" })
      map('n', '<leader>bD', function() require("mini.bufremove").delete(0, true) end, { desc = "Force Delete Buffer" })

      -- 4. 关闭其他/左侧/右侧
      map('n', '<leader>bo', '<cmd>BufferLineCloseOthers<CR>', { desc = "Close other buffers" })
      map('n', '<leader>bl', '<cmd>BufferLineCloseLeft<CR>', { desc = "Close buffers to left" })
      map('n', '<leader>br', '<cmd>BufferLineCloseRight<CR>', { desc = "Close buffers to right" })
      
      -- 5. 快速跳转 (比如 Picker)
      map('n', '<leader>bp', '<cmd>BufferLinePick<CR>', { desc = "Pick Buffer" })

      -- 6. 固定 Buffer (防止被误关)
      map('n', '<leader>bt', '<cmd>BufferLineTogglePin<CR>', { desc = "Toggle Pin" })
    end
  }
}
