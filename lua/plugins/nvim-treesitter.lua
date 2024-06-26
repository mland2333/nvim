local ensure_list = {
  'c',
  'cpp',
  'lua',
  'query',
  'javascript',
  'html',
  'go',
  'rust',
  'yaml',
  'typescript',
  'json',
  'css',
  'bash',
  'toml',
  'python',
  'dockerfile',
  'vim',
  'regex',
  'comment',
  'tsx',
  'vue',
  'verilog',
  'hlsl',
  'glsl',
}

return {
  {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    event = { "VeryLazy" },
    config = function()
      local configs = require("nvim-treesitter.configs")
      
      configs.setup({
        -- ensure_installed = { "c", "lua", "query", "javascript", "html" },
        ensure_installed = ensure_list,
        sync_install = true, -- Sync install
        highlight = { enable = true },
        indent = { enable = true },
        -- context_commentstring = {
        --   enable = true,
        -- },
      })
      vim.g.skip_ts_context_commentstring_module = true
      -- require("ts-context-commentstring").setup()
    end,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    lazy = true,
    event = 'BufRead',
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterBlue',
          'RainbowDelimiterYellow',
          'RainbowDelimiterCyan',
          'RainbowDelimiterViolet',
          'RainbowDelimiterRed',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
        },
      }
    end
  } 
}
