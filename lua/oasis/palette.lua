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
	bg = {
		-- Inlay and gutter (0)
		shadow = {
			desert = "#303030",
			abyss = "#050505",
			midnight = "#0C1014",
			night = "#0C0C18",
			sol = "#2C1512",
			canyon = "#2B1804",
			dune = "#2B231E",
			mirage = "#172328",
			cactus = "#19231B",
			lagoon = "#0F1522",
			twilight = "#201C2B",
			rose = "#2B1523",
			starlight = "#050505",
			dawn = "#E9E0AE",
			dawnlight = "#E3D396",
			day = "#DFC87D",
			dusk = "#E0C480",
			dust = "#CFA955",
		},
		-- Main background (1)
		core = {
			desert = "#333333",
			abyss = "#000000",
			midnight = "#101418",
			night = "#0D0D1A",
			sol = "#2F1815",
			canyon = "#2F1A05",
			dune = "#2E2620",
			mirage = "#18252A",
			cactus = "#1C261E",
			lagoon = "#101825",
			twilight = "#221B2F",
			rose = "#301828",
			starlight = "#000000",
			dawn = "#EFE5B6",
			dawnlight = "#ECDFA3",
			day = "#E5D68B",
			dusk = "#DCBA75",
			dust = "#D4B165",
		},
		-- Panels (2)
		mantle = {
			desert = "#444444",
			abyss = "#080808",
			midnight = "#14181C",
			night = "#06060E",
			sol = "#3A2521",
			canyon = "#402412",
			dune = "#3C332C",
			mirage = "#1A2D33",
			cactus = "#2C3A30",
			lagoon = "#1A283F",
			twilight = "#2B243B",
			rose = "#3E2636",
			starlight = "#080808",
			dawn = "#E3D8A4",
			dawnlight = "#DDD091",
			day = "#DFC47A",
			dusk = "#D5B36A",
			dust = "#C9A55A",
		},
		-- Floats (3)
		surface = {
			desert = "#555555",
			abyss = "#1A1A1A",
			midnight = "#1C242C",
			night = "#262633",
			sol = "#4F312B",
			canyon = "#624020",
			dune = "#534A3F",
			mirage = "#2A3F46",
			cactus = "#3C4B3E",
			lagoon = "#22385C",
			twilight = "#352D47",
			rose = "#523A4B",
			starlight = "#1A1A1A",
			dawn = "#D7CC97",
			dawnlight = "#D1C085",
			day = "#D3BA68",
			dusk = "#CEAC5F",
			dust = "#C39E4F",
		},
	},
	fg = {
		-- Normal
		core = {
			desert = "#F9F8F7",
			abyss = "#D5D9E2",
			midnight = "#E1E9FF",
			night = "#E0E4F8",
			sol = "#FFE0DA",
			canyon = "#F8E7D3",
			dune = "#ECE6DF",
			mirage = "#DDEFEF",
			cactus = "#E2E8E2",
			lagoon = "#D9E6FA",
			twilight = "#E6E0F8",
			rose = "#E9E3E8",
			starlight = "#E8E8E8",
			dawn = "#453826",
			dawnlight = "#453826",
			day = "#382D1C",
			dusk = "#3A2C18",
			dust = "#332814",
		},
		-- Strong
		strong = {
			desert = "#E5D9CE",
			abyss = "#CED3E0",
			midnight = "#D7E0FF",
			night = "#DAD3FF",
			sol = "#FFD3CB",
			canyon = "#FFD8BC",
			dune = "#E6DAC9",
			mirage = "#C9EEE6",
			cactus = "#C7ECD8",
			lagoon = "#D0E2F0",
			twilight = "#E1D2FF",
			rose = "#E6D6EE",
			starlight = "#E0E0E0",
			dawn = "#261E12",
			dawnlight = "#261E12",
			day = "#2A1F0F",
			dusk = "#2A1F0C",
			dust = "#1C160B",
		},
		-- Inlay hints / nontext (slightly warm/dark, distinct from comments)
		dim = {
			desert = "#7C6A5B",
			abyss = "#5A4E45",
			midnight = "#5B534B",
			night = "#5E564C",
			sol = "#566B5D",
			canyon = "#566B5D",
			dune = "#5B7464",
			mirage = "#5A4E45",
			cactus = "#7C6A5B",
			lagoon = "#5A524B",
			twilight = "#5A4E45",
			rose = "#5A4E45",
			starlight = "#6A5448",
			dawn = "#69674C",
			dawnlight = "#656349",
			day = "#605D42",
			dusk = "#534e38",
			dust = "#45412E",
		},
		-- Line numbers (darkest, low-chroma)
		muted = {
			desert = "#4A5C66",
			abyss = "#3A4A50",
			midnight = "#3A4A58",
			night = "#3B3A4C",
			sol = "#5F4642",
			canyon = "#5C402D",
			dune = "#6B5A4A",
			mirage = "#3C4F4D",
			cactus = "#4B5F4F",
			lagoon = "#2F536A",
			twilight = "#43385B",
			rose = "#3E2E38",
			starlight = "#4E5A6A",
			dawn = "#69674C",
			dawnlight = "#656349",
			day = "#605D42",
			dusk = "#534e38",
			dust = "#45412E",
		},
		-- Comments (mid-contrast, readable but soft)
		comment = {
			desert = "#6D90A8",
			abyss = "#5E7B88",
			midnight = "#5F7390",
			night = "#676B88",
			sol = "#9B756E",
			canyon = "#9A6C4E",
			dune = "#8A7663",
			mirage = "#387F74",
			cactus = "#5F8663",
			lagoon = "#467B99",
			twilight = "#6F6291",
			rose = "#9F6C85",
			starlight = "#7FA5CC",
			dawn = "#456B80",
			dawnlight = "#43677b",
			day = "#3E6174",
			dusk = "#3e5060",
			dust = "#31434C",
		},
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
		[700] = "#A39B8E", -- dryriverbed
		[600] = "#B5ADA0", -- lightriverbed
		[500] = "#C5C0B3", -- drybone (BASE)
		[400] = "#DDC8B4", -- paleclay
	},

	-- Reds/Pinks
	red = {
		[900] = "#A23B3B", -- brick
		[800] = "#D06666", -- indianred
		[500] = "#ED7777", -- vibrantred (BASE)
		[400] = "#F58888", -- brightvibrantred
		[300] = "#F28D8D", -- brightervibrantred
		[200] = "#F39493", -- brightestvibrantred
		[100] = "#F29B9B", -- lightvibrantred
		[50] = "#FFACA5", -- lightestvibrantred
	},

	coral = {
		[500] = "#E58383", -- heatwave (BASE)
		[400] = "#F09595", -- brightheatwave
		[300] = "#FBABAB", -- brightestheatwave
		[200] = "#F6C1C1", -- lighterheatwave
	},

	rose = {
		[700] = "#FF8080", -- deepdesertrose
		[500] = "#FFA0A0", -- desertrose (BASE)
		[400] = "#FFB0B0", -- brightdesertrose
		[300] = "#FFC0C0", -- brightestdesertrose
		[200] = "#FFCECE", -- lightdesertrose
	},

	-- Oranges
	sundown = {
		[500] = "#F89D82", -- brightestsunrise (BASE)
		[400] = "#FFBA80", -- lightestlightRedDawn
	},

	sunrise = {
		[700] = "#F8944D", -- darkRedDawn
		[600] = "#F9A05E", -- lightRedDawn
		[500] = "#F8B471", -- redDawn (BASE)
	},

	sunshine = {
		[700] = "#E3910B", -- deepersun
		[600] = "#F49F15", -- deepsun
		[500] = "#F5A72C", -- sun (BASE)
		[400] = "#F7B64D", -- lightsun
		[300] = "#F8C471", -- dawn
		[200] = "#F9C97B", -- lightdawn
	},

	sunset = {
		[500] = "#FFA247", -- sunset (BASE)
		[400] = "#FFA852", -- lightsunset
		[300] = "#FFB870", -- lightestsunset
	},

	-- Yellows
	gold = {
		[500] = "#FFD700", -- gold (BASE)
		[400] = "#F4E36B", -- sunYellow
		[300] = "#EADD61", -- moonlitsand
	},

	khaki = {
		[700] = "#BDB76B", -- darkkhaki
		[600] = "#CDC673", -- khaki3
		[500] = "#F0E68C", -- khaki (BASE)
	},

	dune = {
		[500] = "#D4A017", -- dune (BASE)
	},

	sand = {
		[400] = "#FFD393", -- navajowhite
	},

	-- Greens
	cactus = {
		[700] = "#34CB7D", -- springcactus
		[500] = "#53D390", -- cactus (BASE)
		[400] = "#6DDFA0", -- lightcactus
	},

	moss = {
		[500] = "#6BBF59", -- moss (BASE)
		[400] = "#8DCD7E", -- springmoss
	},

	palm = {
		[600] = "#94E97C", -- darkPalm
		[500] = "#96EA7F", -- palm (BASE)
	},

	aloe = {
		[500] = "#A7D3A9", -- aloe (BASE)
		[400] = "#AED6B0", -- lightaloe
	},

	-- Teals/Cyans
	agave = {
		[800] = "#47A99B", -- lightdeepagave
		[700] = "#5ABAAE", -- midagave
		[600] = "#81C0B6", -- darkagave
		[500] = "#8FD1C7", -- agave (BASE)
		[400] = "#96D4CB", -- lightagave
	},

	-- Blues
	sky = {
		[600] = "#61AEFF", -- skyBlueDress
		[500] = "#87CEEB", -- skyblue (BASE)
		[400] = "#92D3ED", -- lightskyblue
	},

	azure = {
		[600] = "#3DB5FF", -- brightazure
		[500] = "#4AC8FF", -- horizon (BASE)
		[400] = "#5CCEFF", -- lighthorizon
	},

	lagoon = {
		[600] = "#38D0EF", -- crystalBlue
		[500] = "#8EEBEC", -- blueLagoon (BASE)
	},

	-- Purples/Indigos
	lavender = {
		[600] = "#C28EFF", -- cactusflower
		[500] = "#C799FF", -- moonlitflower (BASE)
		[400] = "#D2ADFF", -- lightcactusflower
		[300] = "#D8B7FF", -- lightestcactusflower
	},
}

return colors
