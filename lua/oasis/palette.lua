-- lua/oasis/palette.lua

-- Terminal
local terminal = {
	color0 = "#000000",
	color8 = "#514742",

	color1 = "#CD5C5C",
	color9 = "#FFA0A0 ",

	color2 = "#35B56E",
	color10 = "#6BBF59",

	color3 = "#F0E68C",
	color11 = "#FF9F41 ",

	color4 = "#87CEEB",
	color12 = "#48B4E0",

	color5 = "#B499FF",
	color13 = "#9F7FFF ",

	color6 = "#1CA1FF",
	color14 = "#8FD1C7",

	color7 = "#F6F0E1",
	color15 = "#F2E9E4",
}

-- Visual BG
local visual = {
	red = "#532E2E",
	brown = "#2D251F",
	orange = "#5A3824",
	yellow = "#4D4528",
	green = "#1F3A2D",
	teal = "#2B4A46",
	blue = "#335668",
	indigo = "#3E2F4A",
	violet = "#50325A",
}

-- Diagnoistics
local diag = {
	error = {
		fg = "#FF0000",
		bg = "#322639",
	},
	warn = {
		fg = "#EEEE00",
		bg = "#38343D",
	},
	info = {
		fg = "#75A0FF",
		bg = "#203346",
	},
	hint = {
		fg = "#62ABA0",
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
		},
		-- Main background (1)
		core = {
			desert = "#333333",
			abyss = "#000000",
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
		},
		-- Panels (2)
		mantle = {
			desert = "#444444",
			abyss = "#080808",
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
		},
		-- Floats (3)
		surface = {
			desert = "#555555",
			abyss = "#1A1A1A",
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
		},
	},
	fg = {
		-- Normal
		core = {
			desert = "#ECE6D8",
			abyss = "#DADADA",
			night = "#E0E4F8",
			sol = "#F6DAD7",
			canyon = "#F1DCCF",
			dune = "#ECE6D8",
			mirage = "#DDEFEF",
			cactus = "#E2E8E2",
			lagoon = "#D9E6FA",
			twilight = "#E6E0F8",
			rose = "#E9E3E8",
			starlight = "#E6E6E6",
		},
		-- Inlay hints / nontext (slightly warm/dark, distinct from comments)
		dim = {
			desert = "#7C6A5B",
			abyss = "#5A4E45",
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
		},
		-- Line numbers (darkest, low-chroma)
		muted = {
			desert = "#4A5C66",
			abyss = "#3A4A50",
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
		},
		-- Comments (mid-contrast, readable but soft)
		comment = {
			desert = "#6D90A8",
			abyss = "#5E7B88",
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
		},
	},
}

-- Full palette
local colors = {
	terminal = terminal,
	visual = visual,
	diag = diag,
	theme = theme,

	-- Darks (Backgrounds)
	black = {
		charcoal = "#111111",
	},

	-- Lights (Foregrounds)
	white = {
		ivorysand = "#F6F0E1",
		dunesand = "#F5E6DC",
		duneveil = "#F8E7D3",
		moonstone = "#D0D0E0",
		moonpearl = "#EAE6F4",
		moondust = "#E0E0E0",
		moonash = "#E2E6E5",
	},

	grey = {
		twilight = "#7A7A99",
		darktwilight = "#7b6f90",
		palemoon = "#A3A3BB",
		duskslate = "#4A4A66",
		duskash = "#6F667C",
		dustcloud = "#555B66",
		duskbasalt = "#5A5A5A",
		stone = "#808080",
		dusklilac = "#9D92AA",
		ivorysilver = "#A8B3B3",
		lightgrey = "#BCBCB8",
	},

	-- Neutrals (Foregrounds/Backgrounds/Neutrals)
	brown = {
		dryriverbed = "#9E9584",
		bonedryriverbed = "#938976",
		driftwood = "#8B7765",
		lightdriftwood = "#96816E",
		wood = "#A59383",
		canyonsoil = "#7C6A5B",
		canyonshadow = "#514742",
		umber = "#2E2620",
		drybone = "#C5C0B3",
		charredClay = "#6A5247",
		clay = "#BDA896",
		paleclay = "#DDC8B4",
		fadedclay = "#D5C2B2",
		puebloclay = "#E0C4A8",
		adobeDust = "#D8B592",
		dune = "#D2B48C",
		sandstoneGlow = "#C68E4D",
		coyoteGold = "#C99A41",
		dustysand = "#C6BFAD",
		mud = "#857C70",
	},

	-- Primary Colors
	red = {
		indianred = "#CD5C5C",
		heatwave = "#E68A8A",
		deepheatwave = "#E17070",
		desertrose = "#FFA0A0",
		deepdesertrose = "#FF8080",
		brick = "#A23B3B",
	},

	orange = {
		sun = "#F5A72C",
		deepsun = "#F49F15",
		lightsunset = "#FFA852",
		sunset = "#FF9F41",
		sunrise = "#E67451",
		lightdawn = "#F9C97B",
		dawn = "#F8C471",
		redDawn = "#F8B471",
		darkRedDawn = "#F89047",
		lightamber = "#E69E4C",
		amber = "#E3963E",
		indianSaffron = "#FF7722",
		burntUmber = "#8A5A3C",
	},

	yellow = {
		dawn = "#F2C44A",
		gold = "#FFD700",
		sunYellow = "#F4E36B",
		khaki = "#F0E68C",
		khaki2 = "#EDE173",
		khaki3 = "#CDC673",
		darkkhaki = "#BDB76B",
		khaki4 = "#8B864E",
		dune = "#D4A017",
		wheat = "#FFD87C",
		navajowhite = "#FFDEAD",
		moonlitsand = "#EADD61",
	},

	lime = {},

	green = {
		cactus = "#30BC73",
		springcactus = "#34CB7D",
		moss = "#6BBF59",
		springmoss = "#8DCD7E",
		aloe = "#A7D3A9",
		lightaloe = "#AED6B0",
		mutedaloe = "#739675",
		palm = "#9CEB87",
		darkPalm = "#94E97C",
	},

	teal = {
		sky = "#019992",
		darkagave = "#7BBDB3",
		agave = "#8FD1C7",
		lightagave = "#96D4CB",
		lightdeepagave = "#47A99B",
		deepagave = "#3B9184",
		dustyAgave = "#387F74",
		depthagave = "#23877A",
	},

	cyan = {},

	blue = {
		water = "#0E87CC",
		lunartide = "#4680A4",
		lunarShade = "#2C5168",
		azure = "#1CA1FF",
		lightazure = "#2EA8FF",
		deepazure = "#0597FF",
		blueLagoon = "#8EEBEC",
		skyblue = "#87CEEB",
		crystalBlue = "#5CB3FF",
		skyBlueDress = "#6698FF",
		lightskyblue = "#92D3ED",
		darkskyblue = "#6FC5E7",
		deepskyblue = "#319EC9",
		darkerskyblue = "#378BA4",
		horizon = "#4AC8FF",
		lighthorizon = "#5CCEFF",
		deephorizon = "#33C2FF",
	},

	indigo = {
		cactusflower = "#CFA7FF",
		lightcactusflower = "#D2ADFF",
		darkcactusflower = "#BC85FF",
		moonlitflower = "#C799FF",
	},

	violet = {},
}

return colors
