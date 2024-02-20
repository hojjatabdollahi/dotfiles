return {
  n = {
    ["<leader>fg"] = {
      function () 
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      desc = "Run telescope with args support"
    },
  ["<leader>lc"] = {
      function () 
        require('telescope.builtin').lsp_incoming_calls()
      end,
      desc = "Search all the functions calling this function"
    },
  ["<leader>lo"] = {
      function () 
        require('telescope.builtin').lsp_outgoing_calls()
      end,
      desc = "Search all the functions called in this function"
    },
  ["<F2>"] = {
      "<cmd>cprevious<cr>",
      desc = "Goes to the previous item in quickfix window"
    },
  ["<F3>"] = {
      "<cmd>cnext<cr>",
      desc = "Goes to the next item in quickfix window"
    }
  }
}
