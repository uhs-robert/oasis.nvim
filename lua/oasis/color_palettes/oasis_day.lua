-- lua/oasis/color_palettes/oasis_day.lua
-- Alias: use night for dark mode and night-generated light mode
package.loaded["oasis.color_palettes.oasis_night"] = nil
local night = require("oasis.color_palettes.oasis_night")

-- Deprecation notice (once per session)
if vim and vim.notify and not vim.g.oasis_deprecated_day then
	vim.g.oasis_deprecated_day = true
	vim.notify(
		"Oasis: 'day' is deprecated and will be removed in a future release. Please migrate to 'night' with light_intensity = 3.",
		vim.log.levels.WARN
	)
end

return {
	dark = night.dark,
	light = night.light,
}
