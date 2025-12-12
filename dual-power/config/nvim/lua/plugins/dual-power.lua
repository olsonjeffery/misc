-- lua/plugins/my_new_plugin.lua
return {
  -- rainbow delims
  { "HiPhish/rainbow-delimiters.nvim" },
  -- lazygit integration
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
  },
  -- NeoColumn; shows a nag marker for long lines
  {
    "ecthelionvi/NeoColumn.nvim",
    opts = {},
  },
  -- color theme
  { "ellisonleao/gruvbox.nvim",       priority = 1000, config = true, opts = {} },
  -- show trouble errors in the bottom status line
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        -- The following line is needed to fix the background color
        -- Set it to the lualine section you want to use
        hl_group = "lualine_c_normal",
      })
      table.insert(opts.sections.lualine_c, {
        symbols.get,
        cond = symbols.has,
      })
    end,
  },
}
