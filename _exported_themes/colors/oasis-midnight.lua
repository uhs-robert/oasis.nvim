-- colors/theme_name.lua

local colors = {
	-- content here will not be touched
	-- PATCH_OPEN
	-- group data will be inserted here
	-- PATCH_CLOSE
	-- content here will not be touched
}

-- colorschemes generally want to do this
vim.cmd("highlight clear")
vim.cmd("set t_Co=256")
vim.cmd("let g:colors_name='theme_name'") --TODO: Change name

-- apply highlight groups
for group, attrs in pairs(colors) do
	vim.api.nvim_set_hl(0, group, attrs)
end
