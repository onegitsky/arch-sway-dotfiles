return {
    -- requires pngpaste ( brew install pngpaste )
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    keys = {
        -- suggested keymap
        { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
    opts = {
        default = {
            insert_mode_after_paste = true,
            url_encode_path = true,
            template = "$FILE_PATH",
            use_cursor_in_template = true,

            prompt_for_file_name = true,
            show_dir_path_in_prompt = true,

            use_absolute_path = false,
            relative_to_current_file = true,

            embed_image_as_base64 = false,
            max_base64_size = 10,

            dir_path = function()
                local cwd = vim.fn.getcwd()
                local vault_name = "sethVault"  -- obsidian vault dir 
                local vault_images_path = "Archives/All-Vault-Images/"

                if cwd:match(vault_name) then
                    return vault_images_path
                else
                    return "assets"
                end
            end,

            drag_and_drop = {
                enabled = true,
                insert_mode = true,
                copy_images = true,
                download_images = true,
            },
        },
        -- add options here
        -- or leave it empty to use the default settings
    },
  "3rd/image.nvim",
  opts = {
    -- Optional configuration options
    backend = "kitty", -- Use kitty backend (or "ueberzug" if preferred)
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
      },
    },
    max_width = 50,
    max_height = 50,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required dependency
  },
}
