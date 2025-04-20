-- lua/plugins/barbar.lua
return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- Optional: for git status in bufferline
    "nvim-tree/nvim-web-devicons", -- Optional: for file icons
  },
  event = "BufReadPost", -- Load after opening a buffer
  opts = {
    -- Enable animations for buffer transitions
    animation = true,
    -- Auto-hide the tabline when only one buffer is open
    auto_hide = false,
    -- Show buffer icons (requires nvim-web-devicons)
    icons = {
      buffer_index = true, -- Show buffer index number
      buffer_number = false, -- Do not show buffer number
      button = "×", -- Close button style
      filetype = {
        enabled = true, -- Requires nvim-web-devicons
      },
      -- Git status indicators (requires gitsigns.nvim)
      gitsigns = {
        added = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },
    },
    -- Highlight the current buffer
    highlight_visible = true,
    -- Maximum buffer name length
    maximum_length = 30,
  },
  config = function(_, opts)
    require("barbar").setup(opts)
    -- Custom keymaps for buffer navigation
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    map("n", "<leader>,", "<Cmd>BufferPrevious<CR>", opts)
    map("n", "<leader>.", "<Cmd>BufferNext<CR>", opts)
    -- Re-order buffers
    map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
    map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
    -- Close buffer
    map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
  end,
}
