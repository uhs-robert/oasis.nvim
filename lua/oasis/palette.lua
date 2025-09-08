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

-- Full palette
local colors = {
	terminal = terminal,
	visual = visual,
	diag = diag,

	-- Darks (Backgrounds)
	black = {
		charcoal = "#111111",

		desertCore = "#333333",
		desertMantle = "#4D4D4D",
		desertCrust = "#2F2F2F",
		desertSurface = "#666666",

		abyssCore = "#000000",
		abyssMantle = "#080808",
		abyssCrust = "#1C1612",
		abyssSurface = "#1A1A1A",

		nightCore = "#0D0D1A",
		nightMantle = "#06060E",
		nightCrust = "#11111E",
		nightSurface = "#262633",

		solCore = "#3A1E1A",
		solMantle = "#4A2823",
		solCrust = "#42221E",
		solSurface = "#56312C",

		canyonCore = "#3B2207",
		canyonMantle = "#512D0F",
		canyonCrust = "#331B06",
		canyonSurface = "#754215",

		duneCore = "#443E34",
		duneMantle = "#50483E",
		duneCrust = "#3A342B",
		duneSurface = "#62594D",

		mirageCore = "#18252A",
		mirageMantle = "#22343A",
		mirageCrust = "#192B2E",
		mirageSurface = "#2A3F46",

		lagoonCore = "#101825",
		lagoonMantle = "#1A283F",
		lagoonCrust = "#0F1522",
		lagoonSurface = "#22385C",

		twilightCore = "#221B2F",
		twilightMantle = "#2B243B",
		twilightCrust = "#282037",
		twilightSurface = "#352D47",
	},

	-- Lights (Foregrounds)
	white = {
		ivorysand = "#F6F0E1",
		dunesand = "#F5E6DC",
		moonstone = "#D0D0E0",
		moonpearl = "#EAE6F4",
		moondust = "#E0E0E0",
		moonash = "#E2E6E5",
		duneveil = "#F8E7D3",
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
		lightdawn = "#F9C97B",
		dawn = "#F8C471",
		lightamber = "#E69E4C",
		amber = "#E3963E",
	},

	yellow = {
		gold = "#FFD700",
		khaki = "#F0E68C",
		khaki2 = "#EDE173",
		dune = "#D4A017",
		wheat = "#FFD87C",
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
		oasis = "#9CEB87",
		darkoasis = "#94E97C",
	},

	teal = {
		sky = "#019992",
		agave = "#8FD1C7",
		lightagave = "#96D4CB",
		deepagave = "#3B9184",
	},

	cyan = {},

	blue = {
		lunartide = "#4680A4",
		lunarShade = "#2C5168",
		azure = "#1CA1FF",
		lightazure = "#2EA8FF",
		deepazure = "#0597FF",
		skyblue = "#87CEEB",
		lightskyblue = "#92D3ED",
		darkskyblue = "#6FC5E7",
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
