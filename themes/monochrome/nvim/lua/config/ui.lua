vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd [[highlight CursorLine guibg=#1d1d1d ctermbg=290]]
  end
})
