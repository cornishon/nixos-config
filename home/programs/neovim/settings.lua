require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = true,
})

require("gruvbox").setup({
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = true,
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "", -- can be "hard", "soft" or empty string
	palette_overrides = {},
	overrides = {},
	dim_inactive = false,
	transparent_mode = true,
})

-- colorschme
vim.cmd("colorscheme gruvbox")

vim.g.mapleader = " "

-- local nmaps = {
-- 	-- Center the screen on movement. This approach has the advantage over scroloff
-- 	-- in that it also centers it near the end of the file
-- 	["j"] = "gjzz",
-- 	["k"] = "gkzz",
-- 	["n"] = "nzz",
-- 	["N"] = "Nzz",
-- 	["<C-d>"] = "<C-d>zz",
-- 	["<C-u>"] = "<C-u>zz",
-- }
--
-- for key, action in pairs(nmaps) do
-- 	vim.keymap.set("n", key, action, { noremap = true })
-- end

-- toggle scrolloff
vim.keymap.set({ "n", "v" }, "zj", function()
	if vim.opt.scrolloff:get() == 999 then
		vim.opt.scrolloff = 1
	else
		vim.opt.scrolloff = 999
	end
	return "zz"
end, { noremap = true, expr = true })

vim.keymap.set({ "i", "n" }, "<A-w>", "<Esc>:update<CR>", { noremap = true })

-- move lines up and down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.opt.scrolloff = 999
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.cmdheight = 0
vim.opt.title = true
