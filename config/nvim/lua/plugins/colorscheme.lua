return {
	"AlexvZyl/nordic.nvim",
	priority = 1000,
	config = function()
		require("nordic").setup({
			on_palette = function(palette) end,
			after_palette = function(palette) end,
			on_highlight = function(highlights, palette)
				highlights.TelescopeNormal = {
					bg = "none",
					fg = palette.white0,
				}
				highlights.TelescopeBorder = {
					bg = "none",
					fg = palette.gray3,
				}
				highlights.TelescopePromptNormal = {
					bg = "none",
					fg = palette.white0,
				}
				highlights.TelescopePromptBorder = {
					bg = "none",
					fg = palette.gray3,
				}
              			highlights.TelescopePromptPrefix = {
					bg = "none",
					fg = palette.orange.base,
				}
				highlights.TelescopeResultsNormal = {
					bg = "none",
					fg = palette.white1,
				}
				highlights.TelescopePreviewNormal = {
					bg = "none",
					fg = palette.white1,
				}
			end,
			bold_keywords = false,
			italic_comments = true,
			transparent = {
				bg = true,
				float = true,
			},
			bright_border = false,
			reduced_blue = true,
			swap_backgrounds = false,
			cursorline = {
				bold = false,
				bold_number = true,
				theme = "light",
				blend = 0.6,
			},
			noice = {
				style = "classic",
			},
			telescope = {
				style = "flat",
			},
			leap = {
				dim_backdrop = true,
			},
			ts_context = {
				dark_background = false,
			},
		})
		vim.cmd("colorscheme nordic")
	end,
}
