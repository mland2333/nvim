return {
  {
    'hrsh7th/nvim-cmp',
    -- 优化：改为在进入插入模式时加载，加快启动速度
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      {
        'saadparwaiz1/cmp_luasnip',
        dependencies = {
          'L3MON4D3/LuaSnip',
          'rafamadriz/friendly-snippets', -- 这是一个片段库
        },
      },
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'onsails/lspkind-nvim',
      'lukas-reineke/cmp-under-comparator',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      -- 修复：加载 friendly-snippets 库，否则你的代码片段是空的
      require("luasnip.loaders.from_vscode").lazy_load()

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        preselect = cmp.PreselectMode.None, -- 显式使用枚举更规范
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect'
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", max_item_count = 10 },
          { name = "luasnip" },
          { name = "path" },
          { name = "calc",     max_item_count = 3 },
        }, {
          -- 放在第二个 group 里，优先级低于上面的
          { name = "buffer", max_item_count = 8, keyword_length = 2 },
        }),
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            require("cmp-under-comparator").under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          }
        },
        -- 按键映射保持你原有的习惯
        mapping = cmp.mapping.preset.insert({
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
          ['<C-j>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-k>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({
            select = false, -- 只有显式选中才确认，防止误触
            behavior = cmp.ConfirmBehavior.Insert,
          }),
        }),
        window = {
          completion = {
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
            col_offset = -2,
            side_padding = 1,
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder,Search:None",
          },
        },

        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").symbolic(vim_item.kind, {
              mode = "symbol",
            })

            vim_item.kind = " " .. kind .. " "
            vim_item.menu = ({
              nvim_lsp = "󰘦 LSP",
              luasnip  = "󰃐 Snip",
              buffer   = "󰦨 Buf",
              path     = "󰉋 Path",
              calc     = " Calc",
            })[entry.source.name]

            return vim_item
          end,
        },

        experimental = {
          ghost_text = true,
        }
      })
      vim.api.nvim_set_hl(0, "CmpPmenu", { bg = "#1e1e2e" })
      vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
      vim.api.nvim_set_hl(0, "CmpSel", { bg = "#313244", bold = true })
      vim.api.nvim_set_hl(0, "CmpDoc", { bg = "#181825" })
      vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = "#94e2d5", bg = "#181825" })
    end
  }
}
