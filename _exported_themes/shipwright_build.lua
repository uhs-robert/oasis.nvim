-- shipwright_build.lua
local lushwright = require("shipwright.transform.lush")

-- Theme
local colorscheme = require("lush_theme.oasis")

-- NEOVIM
run(
	colorscheme,
	-- generate lua code
	lushwright.to_lua,
	-- write the lua code into our destination.
	-- you must specify open and close markers yourself to account
	-- for differing comment styles, patchwrite isn't limited to lua files.
	{ patchwrite, "colors/oasis-midnight.lua", "-- PATCH_OPEN", "-- PATCH_CLOSE" } --TODO: Enter file name
)

--VIM SCRIPT
-- run(
-- 	colorscheme,
-- 	lushwright.to_vimscript,
--
-- 	-- we can pass the vimscript through a vim compatible transform if we want.
-- 	-- note: this strips blending
-- 	-- lushwright.vim_compatible_vimscript,
--
-- 	-- the vimscript commands alone are generally not enough for a colorscheme, we
-- 	-- will need to append a few housekeeping lines first.
-- 	--
-- 	-- note how we are passing arguments to append by wrapping the transform in a table.
-- 	-- {transform 1 2 3} ends up as transform(last_pipe_value, 1, 2, 3)
-- 	--
-- 	-- append() accepts a table of values, or one value, so this call ends up being:
-- 	-- append(last_pipe_value, {"set...",  "let..."})
-- 	{ append, { "set background=dark", 'let g:colors_name="oasis"' } }, -- TODO: Enter name
--
-- 	-- now we are ready to write our colors file. note: there is no reason this has
-- 	-- to be written to the relative "colors" dir, you could write the file to an
-- 	-- entirely different vim plugin.
-- 	{ overwrite, "colors/colorscheme.vim" }
-- )
