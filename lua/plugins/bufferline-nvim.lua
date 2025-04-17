return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    --dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
      -- calling `setup` is optional for customization
      vim.opt.termguicolors = true
      require("bufferline").setup {
        options = {
          buffer_close_icon = plain and 'x' or nil,
          modified_icon = plain and '*' or nil,
          -- close_icon = plain and 'x' or nil,
          left_trunc_marker = plain and '<' or nil,
          right_trunc_marker = plain and '>' or nil,
          -- 使用 nvim 内置lsp
          --diagnostics = "nvim_lsp",
          numbers = function(opts)
            return string.format(' %s/%s', vim.fn['tabpagenr'](), opts.ordinal)
          end,
          -- 左侧让出 nvim-tree 的位置
          offsets = { {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
          },
          {
            filetype = 'vista',
            text = function()
              return vim.fn.getcwd()
            end,
            highlight = "Tags",
            text_align = "right"
          }

        },
        close_command = function(bufnum)
          require('bufdelete').bufdelete(bufnum, true)
        end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          return "("..count..")"
        end,
        sort_by = 'insert_after_current',
        custom_filter = function(buf_number, buf_numbers)
          -- filter out filetypes you don't want to see
          if vim.bo[buf_number].filetype == "qf" then
            return false
          end
          if vim.bo[buf_number].buftype == "terminal" then
            return false
          end
          if vim.bo[buf_number].buftype == "nofile" then
            return false
          end
          if vim.bo[buf_number].filetype == "Trouble" then
            return false
          end
          -- if string.find(vim.fn.bufname(buf_number), 'term://') == 1 then
          --     return false
          -- end
          return true
        end,
      }
    }
    local function close_empty_unnamed_buffers()
      -- Get a list of all buffers
      local buffers = vim.api.nvim_list_bufs()

      -- Iterate over each buffer
      for _, bufnr in ipairs(buffers) do
        -- Check if the buffer is empty and doesn't have a name
        if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_name(bufnr) == '' and
          -- vim.api.nvim_buf_get_option(bufnr, 'buftype') == ''
          vim.bo[bufnr].buftype == '' then

          -- Close the buffer if it's empty:
          if vim.api.nvim_buf_line_count(bufnr) == 1 then
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
            if #lines == 0 or lines[0] == nil or #lines[0] == 0 then
              vim.api.nvim_buf_delete(bufnr, {
                force = true,
              })
            end
          end
        end
      end
    end
    vim.api.nvim_create_autocmd({"BufReadPost"}, {
      callback = function (data)
        close_empty_unnamed_buffers()
      end,
    })


    vim.keymap.set({"v", "n"}, "g<Tab>", "<cmd>BufferLineTogglePin<CR>", { silent = true })
    vim.keymap.set({"v", "n"}, "gb", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
    vim.keymap.set({"v", "n"}, "gt", "<cmd>BufferLineCycleNext<CR>", { silent = true })
    vim.keymap.set({"v", "n"}, "g<Space>", "<cmd>BufferLinePick<CR>", { silent = true })
    vim.keymap.set({"v", "n"}, "g<BS>", "<cmd>bdelete<CR>", { silent = true })
    -- vim.keymap.set({"v", "n"}, "go", "<cmd>blast<CR>", { silent = true })
    -- vim.keymap.set({"v", "n"}, "gO", "<cmd>bfirst<CR>", { silent = true })
    vim.keymap.set({"v", "n"}, "gB", "<cmd>BufferLineMovePrev<CR>", { silent = true })
    vim.keymap.set({"v", "n"}, "gT", "<cmd>BufferLineMoveNext<CR>", { silent = true })
    vim.keymap.set({"v", "n"}, "g<S-Tab>", "<cmd>BufferLineCloseOthers<CR>", { silent = true })
    vim.keymap.set({"v", "n"}, "g<C-b>", "<cmd>BufferLineCloseLeft<CR>", { silent = true })
    vim.keymap.set({"v", "n"}, "g<C-t>", "<cmd>BufferLineCloseRight<CR>", { silent = true })

    vim.keymap.set({"v", "n", "i"}, "<F1>", "<cmd>BufferLineTogglePin<CR>", { silent = true })
    vim.keymap.set({"v", "n", "i"}, "<F2>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
    vim.keymap.set({"v", "n", "i"}, "<F3>", "<cmd>BufferLineCycleNext<CR>", { silent = true })
    vim.keymap.set({"v", "n", "i"}, "<F13>", "<cmd>bdelete<CR>", { silent = true })
    vim.keymap.set({"v", "n", "i"}, "<F14>", "<cmd>BufferLineMovePrev<CR>", { silent = true })
    vim.keymap.set({"v", "n", "i"}, "<F15>", "<cmd>BufferLineMoveNext<CR>", { silent = true })
    vim.keymap.set({"v", "n", "i"}, "<C-F13>", "<cmd>BufferLineCloseOthers<CR>", { silent = true })
    vim.keymap.set({"v", "n", "i"}, "<C-F14>", "<cmd>BufferLineCloseLeft<CR>", { silent = true })
    vim.keymap.set({"v", "n", "i"}, "<C-F15>", "<cmd>BufferLineCloseRight<CR>", { silent = true })
  end
}
}
