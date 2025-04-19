return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
        'andrew-george/telescope-themes',
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod

		local trouble = require("trouble")

		local builtin = require("telescope.builtin")
		-- create your custom action
		local custom_actions = transform_mod({
			open_trouble_qflist = function()
				trouble.toggle("quickfix")
			end,
		})

        telescope.load_extension("fzf")
        telescope.load_extension('themes') 

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
					},
				},
			},
            extensions = {
                themes = {
                    enable_previewer = true,
                    enable_live_preview = true,
                    persist = {
                        enabled = true,
                        path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua"
                    }
                },
            }
		})

		vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy find files in cwd" })
		vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Fuzzy search string in cwd" })
		vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
		-- vim.keymap.set( "n", "<leader>pc", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in cwd" })
		-- vim.keymap.set("n", "<leader>pt", "<cmd>TodoTelescope<CR>", { desc = "Find all comment tags in current dir" })
		-- vim.keymap.set("n", "<leader>pws", function() local word = vim.fn.expand("<cword>") builtin.grep_string({ search = word }) end, {desc = "Find word under the cursor"})
		vim.keymap.set("n", "<leader>pWs", function() local word = vim.fn.expand("<cWORD>") builtin.grep_string({ search = word }) end, {desc = "Find Connected Words under cursor"})
		-- vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>ths", ":Telescope themes<CR>", {noremap = true, silent = true, desc = "Theme Switcher"})
	end,
}
