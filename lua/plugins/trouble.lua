return{
  {
    "folke/trouble.nvim",
    opts = {
      {
        indent = {
          top           = "│ ",
          middle        = "├╴",
          -- last          = "└╴",
          last          = "╰╴",
          fold_open     = " ",
          fold_closed   = " ",
          ws            = "  ",
        },
        folder_closed   = " ",
        folder_open     = " ",
        kinds = {
          Array         = " ",
          Boolean       = "󰨙 ",
          Class         = " ",
          Constant      = "󰏿 ",
          Constructor   = " ",
          Enum          = " ",
          EnumMember    = " ",
          Event         = " ",
          Field         = " ",
          File          = " ",
          Function      = "󰊕 ",
          Interface     = " ",
          Key           = " ",
          Method        = "󰊕 ",
          Module        = " ",
          Namespace     = "󰦮 ",
          Null          = " ",
          Number        = "󰎠 ",
          Object        = " ",
          Operator      = " ",
          Package       = " ",
          Property      = " ",
          String        = " ",
          Struct        = "󰆼 ",
          TypeParameter = " ",
          Variable      = "󰀫 ",
        },
      }, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    }
  }
}
