return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
      { "<C-\\>" },
      { "<leader>g", desc = "Lazygit" }, -- 懒加载触发键
    },
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        direction = 'float',
        shade_terminals = true,
        start_in_insert = true, -- 核心设置：默认进入插入模式
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        close_on_exit = true,
        float_opts = {
          border = 'curved',
        },
      })

      ---------------------------------------------------------
      -- 通用终端快捷键 (用于普通命令行终端)
      ---------------------------------------------------------
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        -- 这里定义了 Esc 退出终端模式，这对于普通终端很好，但对于 Lazygit 是灾难
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      ---------------------------------------------------------
      -- Lazygit 专用配置 (关键修复)
      ---------------------------------------------------------
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "curved",
        },
        -- 核心修复逻辑：
        on_open = function(term)
          -- 1. 强制进入插入模式，确保按键能发给 lazygit
          vim.cmd("startinsert!")

          -- 2. 取消该 buffer 的 Esc 映射
          -- 因为在 Lazygit 里，Esc 是用来返回上一级菜单的，不能让它变成“退出终端模式”
          vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
          vim.api.nvim_buf_del_keymap(term.bufnr, "t", "jk")

          -- 3. 按 q 键关闭窗口 (仅在 Normal 模式下生效，防止误触)
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        -- 关闭后重新进入插入模式（可选）
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      vim.keymap.set("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
    end
  }
}
