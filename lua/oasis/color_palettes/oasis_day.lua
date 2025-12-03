-- lua/oasis/color_palettes/oasis_day.lua
-- Alias: use night for dark mode and night-generated light mode
package.loaded["oasis.color_palettes.oasis_night"] = nil
local night = require("oasis.color_palettes.oasis_night")

return {
	dark = night.dark,
	light = night.light,
}
