return {
  "f-person/git-blame.nvim",
  -- 仅在打开文件时加载
  event = { "BufReadPre", "BufNewFile" },

  opts = {
    -- 默认开启
    enabled = true,

    -- 1. 优化显示模板：作者 • 时间 • 摘要
    -- 去掉了 SHA (一般不用看哈希值)，把最重要的作者放前面
    message_template = " <author> • <date> • <summary>",

    -- 2. 使用相对时间 (例如: "3 days ago", "2 hours ago")
    -- 这样比 "01-12-2024 14:00:00" 简洁得多，也更直观
    date_format = "%r",

    -- 3. 视觉优化
    -- 只有光标在当前行停留 1秒 (1000ms) 后才显示
    -- 避免你快速浏览代码时，右边的字一直在闪
    delay = 1000,

    -- 虚拟文本高亮组 (通常不用改，默认灰色就很好)
    highlight_group = "GitBlame",
  },

  -- 4. 添加快捷键开关
  keys = {
    { "<leader>gb", "<cmd>GitBlameToggle<CR>",        desc = "Toggle Git Blame" },
    { "<leader>go", "<cmd>GitBlameOpenCommitURL<CR>", desc = "Open Commit URL" }, -- 如果你想在浏览器看这次提交
  },
}
