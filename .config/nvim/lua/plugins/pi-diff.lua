return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Pi working tree diff" },
      { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Close working tree diff" },
    },
  },
}
