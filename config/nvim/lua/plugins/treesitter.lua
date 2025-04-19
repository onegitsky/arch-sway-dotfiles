return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require ("nvim-treesitter.configs")
    config.setup({
	  ensure_installed = {"lua", "javascript", "html", "c", "bash", "markdown", "markdown_inline", "yaml", "json", "jsonc", "python"},
	  highlight = { enable = true },
	  indent = { enable = true },
  })
  end
}
