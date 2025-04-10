return { 
	"AlexvZyl/nordic.nvim", 
	priority = 1000,
	config = function()
require("nordic").setup({
    on_palette = function(palette) end,
    after_palette = function(palette) end,
    on_highlight = function(highlights, palette) end,
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
        theme = 'light',
        blend = 0.6,
    },
    noice = {
        -- Available styles: `classic`, `flat`.
        style = 'classic',
    },
    telescope = {
        -- Available styles: `classic`, `flat`.
        style = 'classic',
    },
    leap = {
        dim_backdrop = true,
    },
    ts_context = {
        dark_background = false,
    }
})
vim.cmd("colorscheme nordic")
	end
}
