-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
	},
})

--vim.opt.runtimepath:append(vim.fn.expand("~/.cargo/bin"))
--vim.cmd.colorscheme("sonokai")

require("lualine").setup({
	options = {
		theme = "sonokai",
	},
})

vim.api.nvim_create_autocmd({ "FocusLost", "InsertLeave", "WinLeave", "VimLeave", "WinClosed" }, {
	command = "silent! wa",
})

vim.lsp.config("cucumber", {
	cmd = { "/home/jeff/.local/share/mise/installs/node/22.19.0/bin/cucumber-language-server" },
	filetypes = { "cucumber" },
	root_markers = { ".git" },
})
