return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
    check_ts = true,
    break_undo = false,
    fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        before_key = 'h',
        after_key = 'l',
        cursor_pos_before = true,
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        manual_position = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
    },
  } -- this is equalent to setup({}) function
}
