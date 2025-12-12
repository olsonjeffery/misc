-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- autosave
vim.api.nvim_create_autocmd({ "InsertLeave", "WinLeave", "VimLeave", "WinClosed" }, {
  command = "silent! wa",
})
