return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "RchrdAriza/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
    local stats = require("lazy").stats()
		local dashboard = require("alpha.themes.dashboard")
		local time = os.date("%I:%M%p")
		local date = os.date("%A, %d %b")
		local v = vim.version()
		local version = " " .. v.major .. "." .. v.minor .. "." .. v.patch
    local plugin_load_time = string.format("%.2f", stats.startuptime) .. "ms"

		dashboard.section.header.val = {
" ████     ██ ████████   ███████   ██      ██ ██ ████     ████",
"░██░██   ░██░██░░░░░   ██░░░░░██ ░██     ░██░██░██░██   ██░██",
"░██░░██  ░██░██       ██     ░░██░██     ░██░██░██░░██ ██ ░██",
"░██ ░░██ ░██░███████ ░██      ░██░░██    ██ ░██░██ ░░███  ░██",
"░██  ░░██░██░██░░░░  ░██      ░██ ░░██  ██  ░██░██  ░░█   ░██",
"░██   ░░████░██      ░░██     ██   ░░████   ░██░██   ░    ░██",
"░██    ░░███░████████ ░░███████     ░░██    ░██░██        ░██",
}

		dashboard.section.buttons.val = {
			dashboard.button("n", "   New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "󰈞   Find file", ":cd $HOME | Telescope find_files<CR>"),
			dashboard.button("r", "󰈢   Recent", ":Telescope oldfiles<CR>"),
			dashboard.button("R", "󱘞   Ripgrep", ":Telescope live_grep<CR>"),
			dashboard.button("c", "   Configuration", ":cd ~/.config/nvim | Neotree<CR>"),
			dashboard.button("l", "   Plugin Manager", ":Lazy<CR>"),
			dashboard.button("q", "󰗼   Quit", ":qa<CR>"),
		}
		function centerText(text, width)
			local totalPadding = width - #text
			local leftPadding = math.floor(totalPadding / 2)
			local rightPadding = totalPadding - leftPadding
			return string.rep(" ", leftPadding) .. text .. string.rep(" ", rightPadding)
		end

		dashboard.section.footer.val = {
      centerText("󰂖 ".. stats.loaded .. "/" .. stats.count .. " Plugins Loaded in " .. plugin_load_time, 52.5),
      centerText(version, 50),
			" ",
			centerText(date, 50),
			centerText(time, 50),
		}
		alpha.setup(dashboard.opts)
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
