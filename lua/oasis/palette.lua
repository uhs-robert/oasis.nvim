-- lua/oasis/palette.lua
-- Tailwind-style numeric scale palette system

-- Terminal
local terminal = {
	color0 = "#000000",
	color8 = "#514742",

	color1 = "#D06666",
	color9 = "#FFA0A0",

	color2 = "#35B56E",
	color10 = "#6BBF59",

	color3 = "#F0E68C",
	color11 = "#FFA247",

	color4 = "#87CEEB",
	color12 = "#6FB8FF",

	color5 = "#B499FF",
	color13 = "#C0A0FF",

	color6 = "#1CA1FF",
	color14 = "#8FD1C7",

	color7 = "#E8E2D4",
	color15 = "#FFF9F2",
}

local light_terminal = {
	color0 = "#3A3427",
	color8 = "#454030",

	color1 = "#663021",
	color9 = "#692c34",

	color2 = "#1b491d",
	color10 = "#35450d",

	color3 = "#6b2e00",
	color11 = "#533c00",

	color4 = "#10426d",
	color12 = "#1f3f71",

	color5 = "#46259f",
	color13 = "#4d19a8",

	color6 = "#064658",
	color14 = "#084559",

	color7 = "#453826",
	color15 = "#443f36",
}

-- Visual BG
local visual = {
	red = "#532E2E",
	light_red = "#E8BABA",
	brown = "#2D251F",
	light_brown = "#E5CEBD",
	orange = "#5A3824",
	light_orange = "#EDCAB6",
	yellow = "#4D4528",
	light_yellow = "#E9DFB9",
	green = "#1F3A2D",
	light_green = "#BAE9D2",
	teal = "#2B4A46",
	light_teal = "#BBE7E2",
	blue = "#335668",
	light_blue = "#9BC1E6",
	indigo = "#3E2F4A",
	light_indigo = "#D3BCE6",
	violet = "#50325A",
	light_violet = "#DDBAE8",
	pink = "#47283B",
	light_pink = "#E8BAD6",
	slate = "#1B242B",
	light_slate = "#BCD4E6",
}

-- Diagnoistics
local diag = {
	error = {
		fg = "#FF0000",
		fg_light = "#FFA0A0",
		bg = "#322639",
	},
	warn = {
		fg = "#EEEE00",
		bg = "#38343D",
	},
	info = {
		fg = "#75A0FF",
		fg_light = "#87CEEB",
		bg = "#203346",
	},
	hint = {
		fg = "#62ABA0",
		fg_light = "#8FD1C7",
		bg = "#273644",
	},
	ok = {
		fg = "#00FF7F",
		bg = "#2F4F4F",
	},
}

-- Theme specific
local theme = {
	-- Dark themes
	desert = {
		bg = { shadow = "#303030", core = "#333333", mantle = "#444444", surface = "#555555" },
		fg = { core = "#F9F8F7", strong = "#E5D9CE", dim = "#857262", muted = "#566B76", comment = "#6D90A8" },
	},
	abyss = {
		bg = { shadow = "#050505", core = "#000000", mantle = "#080808", surface = "#1A1A1A" },
		fg = { core = "#D5D9E2", strong = "#CED3E0", dim = "#5E5148", muted = "#39494F", comment = "#546D79" },
	},
	midnight = {
		bg = { shadow = "#0C1014", core = "#101418", mantle = "#14181C", surface = "#1C242C" },
		fg = { core = "#E1E9FF", strong = "#D7E0FF", dim = "#635A51", muted = "#3F5160", comment = "#5F7390" },
	},
	night = {
		bg = { shadow = "#0C0C18", core = "#0D0D1A", mantle = "#06060E", surface = "#262633" },
		fg = { core = "#E0E4F8", strong = "#DAD3FF", dim = "#60584D", muted = "#4B4A61", comment = "#6A6E8B" },
	},
	sol = {
		bg = { shadow = "#2C1512", core = "#2F1815", mantle = "#3A2521", surface = "#4F312B" },
		fg = { core = "#FFE0DA", strong = "#FFD3CB", dim = "#636363", muted = "#6B4F4A", comment = "#987069" },
	},
	canyon = {
		bg = { shadow = "#2B1804", core = "#2F1A05", mantle = "#402412", surface = "#624020" },
		fg = { core = "#F8E7D3", strong = "#FFD8BC", dim = "#636363", muted = "#714F37", comment = "#9F7051" },
	},
	dune = {
		bg = { shadow = "#2B231E", core = "#2E2620", mantle = "#3C332C", surface = "#534A3F" },
		fg = { core = "#ECE6DF", strong = "#E6DAC9", dim = "#636363", muted = "#6B5A4A", comment = "#8A7663" },
	},
	mirage = {
		bg = { shadow = "#172328", core = "#18252A", mantle = "#1A2D33", surface = "#2A3F46" },
		fg = { core = "#DDEFEF", strong = "#C9EEE6", dim = "#736458", muted = "#475D5B", comment = "#387F74" },
	},
	cactus = {
		bg = { shadow = "#19231B", core = "#1C261E", mantle = "#2C3A30", surface = "#3C4B3E" },
		fg = { core = "#E2E8E2", strong = "#C7ECD8", dim = "#756456", muted = "#4B5F4F", comment = "#608864" },
	},
	lagoon = {
		bg = { shadow = "#0F1522", core = "#101825", mantle = "#1A283F", surface = "#22385C" },
		fg = { core = "#D9E6FA", strong = "#D0E2F0", dim = "#665D55", muted = "#30556d", comment = "#467B99" },
	},
	twilight = {
		bg = { shadow = "#201C2B", core = "#221B2F", mantle = "#2B243B", surface = "#352D47" },
		fg = { core = "#E6E0F8", strong = "#E1D2FF", dim = "#6F6055", muted = "#5D4E7E", comment = "#8073A1" },
	},
	rose = {
		bg = { shadow = "#2B1523", core = "#301828", mantle = "#3E2636", surface = "#523A4B" },
		fg = { core = "#E9E3E8", strong = "#E6D6EE", dim = "#706156", muted = "#6A4F60", comment = "#9F6C85" },
	},
	starlight = {
		bg = { shadow = "#050505", core = "#000000", mantle = "#080808", surface = "#1A1A1A" },
		fg = { core = "#E8E8E8", strong = "#E0E0E0", dim = "#6A5448", muted = "#4E5A6A", comment = "#7FA5CC" },
	},
	-- Light themes
	dawn = {
		bg = { shadow = "#E9E0AE", core = "#EFE5B6", mantle = "#E3D8A4", surface = "#D7CC97" },
		fg = { core = "#443725", strong = "#261E12", dim = "#54523A", muted = "#4E4D39", comment = "#456B80" },
	},
	dawnlight = {
		bg = { shadow = "#E3D396", core = "#ECDFA3", mantle = "#DDD091", surface = "#D1C085" },
		fg = { core = "#403423", strong = "#261E12", dim = "#504E3A", muted = "#4B4936", comment = "#43677b" },
	},
	day = {
		bg = { shadow = "#DFC87D", core = "#E5D68B", mantle = "#DFC47A", surface = "#D3BA68" },
		fg = { core = "#392E1D", strong = "#2A1F0F", dim = "#4B4934", muted = "#464430", comment = "#3E6174" },
	},
	dusk = {
		bg = { shadow = "#E0C480", core = "#DCBA75", mantle = "#D5B36A", surface = "#CEAC5F" },
		fg = { core = "#251C10", strong = "#2A1F0C", dim = "#3D3929", muted = "#373425", comment = "#3e5060" },
	},
	dust = {
		bg = { shadow = "#CFA955", core = "#D4B165", mantle = "#C9A55A", surface = "#C39E4F" },
		fg = { core = "#181309", strong = "#1C160B", dim = "#353224", muted = "#302D20", comment = "#31434C" },
	},
}

-- Full palette with Tailwind-style numeric scales
local colors = {
	terminal = terminal,
	light_terminal = light_terminal,
	visual = visual,
	diag = diag,
	theme = theme,

	-- Neutrals
	grey = {
		[500] = "#A3A3BB", -- palemoon
	},

	brown = {
		[700] = "#A39B8E",
		[600] = "#B5ADA0",
		[500] = "#C5C0B3",
		[400] = "#DDC8B4",
	},

	-- Reds/Pinks
	red = {
		[900] = "#A23B3B",
		[800] = "#D06666",
		[500] = "#ED7777",
		[400] = "#F58888",
		[300] = "#F28D8D",
		[200] = "#F39493",
		[100] = "#F29B9B",
		[50] = "#FFACA5",
	},

	coral = {
		[500] = "#E58383",
		[400] = "#F09595",
		[300] = "#FBABAB",
		[200] = "#F6C1C1",
	},

	rose = {
		[700] = "#FF8080",
		[500] = "#FFA0A0",
		[400] = "#FFB0B0",
		[300] = "#FFC0C0",
		[200] = "#FFCECE",
	},

	-- Oranges
	sundown = {
		[500] = "#F89D82",
		[400] = "#FFBA80",
	},

	sunrise = {
		[700] = "#F8944D",
		[600] = "#F9A05E",
		[500] = "#F8B471",
	},

	sunshine = {
		[700] = "#E3910B",
		[600] = "#F49F15",
		[500] = "#F5A72C",
		[400] = "#F7B64D",
		[300] = "#F8C471",
		[200] = "#F9C97B",
	},

	sunset = {
		[500] = "#FFA247",
		[400] = "#FFA852",
		[300] = "#FFB870",
	},

	-- Yellows
	gold = {
		[500] = "#FFD700",
		[400] = "#F4E36B",
		[300] = "#EADD61",
	},

	khaki = {
		[700] = "#BDB76B",
		[600] = "#CDC673",
		[500] = "#F0E68C",
	},

	dune = {
		[500] = "#D4A017",
	},

	sand = {
		[400] = "#FFD393",
	},

	-- Greens
	cactus = {
		[700] = "#34CB7D",
		[500] = "#53D390",
		[400] = "#6DDFA0",
	},

	moss = {
		[500] = "#6BBF59",
		[400] = "#8DCD7E",
	},

	palm = {
		[600] = "#94E97C",
		[500] = "#96EA7F",
	},

	aloe = {
		[500] = "#A7D3A9",
		[400] = "#AED6B0",
	},

	-- Teals/Cyans
	agave = {
		[800] = "#47A99B",
		[700] = "#5ABAAE",
		[600] = "#81C0B6",
		[500] = "#8FD1C7",
		[400] = "#96D4CB",
	},

	-- Blues
	sky = {
		[600] = "#61AEFF",
		[500] = "#87CEEB",
		[400] = "#92D3ED",
	},

	azure = {
		[600] = "#3DB5FF",
		[500] = "#4AC8FF",
		[400] = "#5CCEFF",
	},

	lagoon = {
		[600] = "#38D0EF",
		[500] = "#8EEBEC",
	},

	-- Purples/Indigos
	lavender = {
		[600] = "#C28EFF",
		[500] = "#C799FF",
		[400] = "#D2ADFF",
		[300] = "#D8B7FF",
	},
}

return colors
