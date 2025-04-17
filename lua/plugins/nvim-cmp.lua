return {
  {
    'hrsh7th/nvim-cmp',
    lazy = false,
    event = 'LspAttach',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      {
        'saadparwaiz1/cmp_luasnip',
        dependencies = {
          'L3MON4D3/LuaSnip',
        },
      },
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind-nvim',
      'lukas-reineke/cmp-under-comparator',
    },
    config = function()
      local lspkind = pcall(require, 'lspkind')
      local cmp = require'cmp'
      local luasnip = require'luasnip'
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      cmp.setup({
        preselect = 'none',
        completion = {
          completeopt = 'menu,menuone,noinsert, noselect'
          -- completeopt = 'menu,menuone'
        },
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        sources = cmp.config.sources({
          {name = "nvim_lsp", max_item_count = 10},
          {name = "buffer", max_item_count = 8, keyword_length = 2},
          { name = 'luasnip' },
          { name = 'path' },
          {name = "calc", max_item_count = 3},
        }),
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            require("cmp-under-comparator").under,
            -- require("cmp_tabnine.compare"), -- INFO: uncomment this for AI completion
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          }
        },
        mapping = cmp.mapping.preset.insert({
          --['<C-b>'] = cmp.mapping.scroll_docs(-4),
          --['<C-f>'] = cmp.mapping.scroll_docs(4),
          --['<C-Space>'] = cmp.mapping.complete(),
          --['<C-e>'] = cmp.mapping.abort(),
          --['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          -- 出现补全
          ['<C-j>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          -- 取消
          ['<C-k>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({
            select = false,
            behavior = cmp.ConfirmBehavior.Insert,
          }),
        }),
        window = {
          completion = {
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
            col_offset = -3,
            side_padding = 0,
            border = 'rounded',
            scrollbar = true,
          },
          documentation = {
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
            border = 'rounded',
            scrollbar = true,
          },
        },
        formatting = {
          format = require'lspkind'.cmp_format{
            mode = 'symbol',
            maxwidth = 50,    -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            before = function(entry, vim_item)
              -- Source 显示提示来源
              vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
              if entry.source.name == "calc" then
                vim_item.kind = "Calc"
              end
              return vim_item
            end,
            ellipsis_char = '...',
            symbol_map = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "",
              Calc = "",
              Git = "",
              Search = "",
              Rime = "",
              Clipboard = "",
              Call = "",
            },
          }
        },


        experimental = {
          ghost_text = true,
        }

      })
    end
  }

}
