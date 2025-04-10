return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local nordic = require("lualine.themes.nordic")
      nordic.normal.c.bg = "none"
      nordic.insert.c.bg = "none"
      nordic.visual.c.bg = "none"
      nordic.replace.c.bg = "none"
      nordic.command.c.bg = "none"
      nordic.normal.b.bg = "none"
      nordic.normal.a.fg = "#191D24"
      nordic.normal.a.bg = "#5e81ac"
      return {
        options = {
          theme = nordic,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = {}, winbar = {} },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },
}
