return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    config = function()
      -- === 修正后的函数 ===
      local function lsp_client_name()
        local msg = 'No Active Lsp'

        -- 使用新的 API: vim.lsp.get_clients
        -- { bufnr = 0 } 表示只获取“当前缓冲区”的 LSP，不再需要手动循环判断文件类型了
        local clients = vim.lsp.get_clients({ bufnr = 0 })

        if next(clients) == nil then
          return msg
        end

        local client_names = {}
        for _, client in ipairs(clients) do
          -- 排除一些不需要显示的客户端 (比如 null-ls 或 copilot，看你喜好)
          if client.name ~= "null-ls" and client.name ~= "copilot" then
            table.insert(client_names, client.name)
          end
        end

        if #client_names > 0 then
          -- 如果有多个 LSP，用逗号隔开显示，例如 [lua_ls, null-ls]
          -- 也是为了美观，加个图标
          return '  ' .. table.concat(client_names, ', ')
        else
          return msg
        end
      end
      -- ==================

      require('lualine').setup {
        options = {
          globalstatus = true,
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = { 'alpha', 'dashboard', 'NvimTree', 'Outline' },
            winbar = { 'alpha', 'dashboard', 'NvimTree', 'Outline' },
          },
        },
        sections = {
          lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
          lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { "nvim_diagnostic" } } },
          lualine_c = { { 'filename', path = 1 } },

          -- 这里调用上面修正后的函数
          lualine_x = {
            lsp_client_name,
            'filetype',
          },
          lualine_y = { 'progress' },
          lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } }
        },
      }
    end
  }
}
