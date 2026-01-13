return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" }, -- 声明依赖 cmp
    opts = {
      -- 1. 开启 Treesitter 支持 (防止在注释/字符串中补全)
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "template_string" },
        java = false,
      },

      -- 2. 这里的 fast_wrap 不需要写那么多废话，只保留按键即可
      fast_wrap = {
        map = '<A-e>', -- Alt + e
        chars = { '{', '[', '(', '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'PmenuSel',
        highlight_grey = 'LineNr',
      },
    },

    -- 3. 关键改进：配置与 nvim-cmp 的自动联通
    config = function(_, opts)
      local autopairs = require("nvim-autopairs")
      autopairs.setup(opts)

      -- 如果你没有安装 nvim-cmp，下面这部分会报错，所以加个判断
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        -- 当你在 cmp 菜单里确认选中一个函数时，自动补全括号
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  }
}
