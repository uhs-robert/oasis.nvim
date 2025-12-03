-- lua/oasis/palette.lua
-- Tailwind-style numeric scale palette system

-- Terminal
-- stylua: ignore start
local terminal = {
	black =               "#000000",
	bright_black =        "#666666",
	red =                 "#D06666",
	bright_red =          "#FFA0A0",
	green =               "#53D390",
	bright_green =        "#96EA7F",
	yellow =              "#F0E68C",
	bright_yellow =       "#FFA247",
	blue =                "#519BFF",
	bright_blue =         "#87CEEB",
	magenta =             "#C28EFF",
	bright_magenta =      "#D2ADFF",
	cyan =                "#5ABAAE",
	bright_cyan =         "#8FD1C7",
	white =               "#DDDBD5",
	bright_white =        "#FFF9F2",
}

local light_terminal = {
	black =               "#3A3427",
	bright_black =        "#454030",
	red =                 "#663021",
	bright_red =          "#692c34",
	green =               "#1b491d",
	bright_green =        "#35450d",
	yellow =              "#6b2e00",
	bright_yellow =       "#533c00",
	blue =                "#10426d",
	bright_blue =         "#1f3f71",
	magenta =             "#46259f",
	bright_magenta =      "#4d19a8",
	cyan =                "#064658",
	bright_cyan =         "#084559",
	white =               "#453826",
	bright_white =        "#443f36",
}

-- Map semantic names to numeric colors
local semantic_ansi_map = {
	"black", "red", "green", "yellow", "blue", "magenta", "cyan", "white",
	"bright_black", "bright_red", "bright_green", "bright_yellow", "bright_blue", "bright_magenta", "bright_cyan", "bright_white",
}
-- stylua: ignore end

local function map_ansi_colors(ansi_map, terminal_type)
	for i, name in ipairs(ansi_map) do
		terminal_type["color" .. (i - 1)] = terminal_type[name]
	end
end

map_ansi_colors(semantic_ansi_map, terminal)
map_ansi_colors(semantic_ansi_map, light_terminal)

-- Visual BG
local visual = {
	red = "#532E2E",
	light_red = "#E8BABA",
	stone = "#2D251F",
	light_stone = "#E5CEBD",
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
	grey = "#1B242B",
	light_grey = "#BCD4E6",
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
		fg = { core = "#F0EBE6", strong = "#FFDACC", dim = "#5E5148", muted = "#39494F", comment = "#546D79" },
	},
	midnight = {
		bg = { shadow = "#0C1014", core = "#101418", mantle = "#14181C", surface = "#1C242C" },
		fg = { core = "#F7F4F2", strong = "#FFE0CC", dim = "#635A51", muted = "#3F5160", comment = "#5F7390" },
	},
	night = {
		bg = { shadow = "#0C0C18", core = "#0D0D1A", mantle = "#06060E", surface = "#262633" },
		fg = { core = "#F7F4E9", strong = "#F2E8D8", dim = "#60584D", muted = "#4B4A61", comment = "#6A6E8B" },
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
		fg = { core = "#E8E5DA", strong = "#EDE8AF", dim = "#636363", muted = "#6B5A4A", comment = "#8A7663" },
	},
	mirage = {
		bg = { shadow = "#172328", core = "#18252A", mantle = "#1A2D33", surface = "#2A3F46" },
		fg = { core = "#DDEFEF", strong = "#C9EEE6", dim = "#736458", muted = "#475D5B", comment = "#387F74" },
	},
	cactus = {
		bg = { shadow = "#19231B", core = "#1C261E", mantle = "#2C3A30", surface = "#3C4B3E" },
		fg = { core = "#DDF0E5", strong = "#C7EDCF", dim = "#756456", muted = "#4B5F4F", comment = "#608864" },
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
		fg = { core = "#EDD5E7", strong = "#EBBEDF", dim = "#706156", muted = "#6A4F60", comment = "#9F6C85" },
	},
	starlight = {
		bg = { shadow = "#050505", core = "#000000", mantle = "#080808", surface = "#1A1A1A" },
		fg = { core = "#FAF7F0", strong = "#DCD9D2", dim = "#6A5448", muted = "#4E5A6A", comment = "#7FA5CC" },
	},
	-- Light themes
	dawn = {
		bg = { shadow = "#E9E0AE", core = "#EFE5B6", mantle = "#E3D8A4", surface = "#D7CC97" },
		fg = { core = "#443725", strong = "#261E12", dim = "#54523A", muted = "#4E4D39", comment = "#456B80" }, -- #F0E7CE or #F2ECD3
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
		[900] = "#2D2D3D",
		[800] = "#4D4D66",
		[700] = "#6D6D8F",
		[600] = "#888AA5",
		[500] = "#A3A3BB",
		[400] = "#B3B3C7",
		[300] = "#C3C3D3",
		[200] = "#D3D3DF",
		[100] = "#E3E3EB",
		[50] = "#F1F1F5",
	},

	slate = {
		[900] = "#2D3340",
		[800] = "#4D5566",
		[700] = "#6D768F",
		[600] = "#8890A5",
		[500] = "#A3ABB8",
		[400] = "#B3BAC7",
		[300] = "#C3C9D3",
		[200] = "#D3D8DF",
		[100] = "#E3E7EB",
		[50] = "#F1F3F5",
	},

	stone = {
		[900] = "#3D3A33",
		[800] = "#6B665C",
		[700] = "#A39B8E",
		[600] = "#B5ADA0",
		[500] = "#C5C0B3",
		[400] = "#D2CEC3",
		[300] = "#DFDCD3",
		[200] = "#ECE9E3",
		[100] = "#F5F3EF",
		[50] = "#FAF9F7",
	},

	-- Reds/Pinks
	red = {
		[900] = "#A23B3B",
		[800] = "#D06666",
		[700] = "#E26E6E",
		[600] = "#E87272",
		[500] = "#ED7777",
		[400] = "#F58888",
		[300] = "#F28D8D",
		[200] = "#F39493",
		[100] = "#F29B9B",
		[50] = "#FFACA5",
	},

	coral = {
		[900] = "#5C2A2A",
		[800] = "#9F4A4A",
		[700] = "#D46B6B",
		[600] = "#DD7777",
		[500] = "#E58383",
		[400] = "#F09595",
		[300] = "#FBABAB",
		[200] = "#F6C1C1",
		[100] = "#FBD7D7",
		[50] = "#FDEBEB",
	},

	peach = {
		[900] = "#633328",
		[800] = "#AA5845",
		[700] = "#F17D62",
		[600] = "#F58D72",
		[500] = "#F89D82",
		[400] = "#F9AD92",
		[300] = "#FABDA2",
		[200] = "#FBCDB2",
		[100] = "#FCDDC2",
		[50] = "#FDEED2",
	},

	rose = {
		[900] = "#803333",
		[800] = "#CC5959",
		[700] = "#FF8080",
		[600] = "#FF9090",
		[500] = "#FFA0A0",
		[400] = "#FFB0B0",
		[300] = "#FFC0C0",
		[200] = "#FFCECE",
		[100] = "#FFDCDC",
		[50] = "#FFEBEB",
	},

	-- Oranges
	sundown = {
		[900] = "#663217",
		[800] = "#B35829",
		[700] = "#FF7E3B",
		[600] = "#FF8E5E",
		[500] = "#F89D82",
		[400] = "#FFBA80",
		[300] = "#FFC89A",
		[200] = "#FFD6B4",
		[100] = "#FFE4CE",
		[50] = "#FFF2E7",
	},

	sunrise = {
		[900] = "#663A14",
		[800] = "#B3671F",
		[700] = "#F8944D",
		[600] = "#F9A05E",
		[500] = "#F8B471",
		[400] = "#F9C084",
		[300] = "#FACC97",
		[200] = "#FBD8AA",
		[100] = "#FCE4BD",
		[50] = "#FDF0D0",
	},

	sunshine = {
		[900] = "#664100",
		[800] = "#996200",
		[700] = "#E3910B",
		[600] = "#F49F15",
		[500] = "#F5A72C",
		[400] = "#F7B64D",
		[300] = "#F8C471",
		[200] = "#F9C97B",
		[100] = "#FBD89E",
		[50] = "#FDE7C1",
	},

	sunset = {
		[900] = "#804000",
		[800] = "#B35A00",
		[700] = "#E67200",
		[600] = "#FF8A1F",
		[500] = "#FFA247",
		[400] = "#FFA852",
		[300] = "#FFB870",
		[200] = "#FFC78F",
		[100] = "#FFD7AD",
		[50] = "#FFE7CC",
	},

	-- Yellows
	gold = {
		[900] = "#664500",
		[800] = "#B37800",
		[700] = "#FFAA00",
		[600] = "#FFC133",
		[500] = "#FFD700",
		[400] = "#F4E36B",
		[300] = "#EADD61",
		[200] = "#F2E890",
		[100] = "#F8F1BF",
		[50] = "#FCF8DF",
	},

	khaki = {
		[900] = "#4D4A1B",
		[800] = "#807C37",
		[700] = "#BDB76B",
		[600] = "#CDC673",
		[500] = "#F0E68C",
		[400] = "#F3EA9F",
		[300] = "#F6EEB2",
		[200] = "#F9F2C5",
		[100] = "#FBF6D8",
		[50] = "#FEFBEB",
	},

	dune = {
		[900] = "#402F07",
		[800] = "#6D500D",
		[700] = "#9A7012",
		[600] = "#C78815",
		[500] = "#D4A017",
		[400] = "#DDB03D",
		[300] = "#E6C063",
		[200] = "#EFD089",
		[100] = "#F8E0AF",
		[50] = "#FCF0D5",
	},

	sand = {
		[900] = "#664D1A",
		[800] = "#B3862E",
		[700] = "#FFBF42",
		[600] = "#FFCB6B",
		[500] = "#FFD082",
		[400] = "#FFD393",
		[300] = "#FFDCA4",
		[200] = "#FFE5B5",
		[100] = "#FFEEC6",
		[50] = "#FFF7D7",
	},

	soil = {
		[900] = "#58503E",
		[800] = "#97886A",
		[700] = "#BBA593",
		[600] = "#CCB7A4",
		[500] = "#DDC8B4",
		[400] = "#E3D1C1",
		[300] = "#E9DACE",
		[200] = "#EFE3DB",
		[100] = "#F5ECE8",
		[50] = "#FAF5F3",
	},

	-- Greens
	palm = {
		[900] = "#2E5E1F",
		[800] = "#4FA035",
		[700] = "#70D255",
		[600] = "#94E97C",
		[500] = "#96EA7F",
		[400] = "#A6EE93",
		[300] = "#B6F2A7",
		[200] = "#C6F6BB",
		[100] = "#D6FACF",
		[50] = "#E6FDE3",
	},

	moss = {
		[900] = "#244D1A",
		[800] = "#3E802D",
		[700] = "#58B340",
		[600] = "#61BB4D",
		[500] = "#6BBF59",
		[400] = "#8DCD7E",
		[300] = "#A3D89B",
		[200] = "#B9E3B8",
		[100] = "#CFEED5",
		[50] = "#E5F9F2",
	},

	aloe = {
		[900] = "#355E37",
		[800] = "#5A9C5D",
		[700] = "#7FBB82",
		[600] = "#93C795",
		[500] = "#A7D3A9",
		[400] = "#AED6B0",
		[300] = "#BADEBC",
		[200] = "#C6E6C8",
		[100] = "#D2EED4",
		[50] = "#DEF6E0",
	},

	cactus = {
		[900] = "#1A5338",
		[800] = "#2B8A5E",
		[700] = "#34CB7D",
		[600] = "#43CF8C",
		[500] = "#53D390",
		[400] = "#6DDFA0",
		[300] = "#87E5B0",
		[200] = "#A1EBC0",
		[100] = "#BBF1D0",
		[50] = "#D5F7E0",
	},

	-- Teals/Cyans
	teal = {
		[900] = "#2A5E56",
		[800] = "#47A99B",
		[700] = "#5ABAAE",
		[600] = "#81C0B6",
		[500] = "#8FD1C7",
		[400] = "#96D4CB",
		[300] = "#A8DDD5",
		[200] = "#BAE6DF",
		[100] = "#CCEFE9",
		[50] = "#DEF8F4",
	},

	cyan = {
		[900] = "#0D4040",
		[800] = "#1A6B6B",
		[700] = "#269999",
		[600] = "#33CCCC",
		[500] = "#8EEBEC",
		[400] = "#A3EFF0",
		[300] = "#B8F3F4",
		[200] = "#CDF7F8",
		[100] = "#E2FBFC",
		[50] = "#F0FDFE",
	},

	-- Blues
	sky = {
		[900] = "#1A3D5C",
		[800] = "#2E6894",
		[700] = "#4D9ACF",
		[600] = "#6BBAE0",
		[500] = "#87CEEB",
		[400] = "#92D3ED",
		[300] = "#A5DCF1",
		[200] = "#B8E5F5",
		[100] = "#CBEEF9",
		[50] = "#DEF6FC",
	},

	horizon = {
		[900] = "#0D4266",
		[800] = "#1870AD",
		[700] = "#2A9FE6",
		[600] = "#3DB5FF",
		[500] = "#4AC8FF",
		[400] = "#5CCEFF",
		[300] = "#7DD8FF",
		[200] = "#9EE2FF",
		[100] = "#BFECFF",
		[50] = "#DFF6FF",
	},

	lagoon = {
		[900] = "#0D4266",
		[800] = "#1670AD",
		[700] = "#1CA0FD",
		[600] = "#3AACFD",
		[500] = "#58B8FD",
		[400] = "#76C4FD",
		[300] = "#94D0FE",
		[200] = "#B2DCFE",
		[100] = "#D0E8FE",
		[50] = "#EEF4FF",
	},

	sapphire = {
		[900] = "#1A3966",
		[800] = "#2D62AD",
		[700] = "#408BF4",
		[600] = "#519BFF",
		[500] = "#61AEFF",
		[400] = "#7ABBFF",
		[300] = "#93C8FF",
		[200] = "#ACD5FF",
		[100] = "#C5E2FF",
		[50] = "#DEF0FF",
	},

	-- Purples/Indigos
	lavender = {
		[900] = "#7033CC",
		[800] = "#8F4FE6",
		[700] = "#9C5FEB",
		[600] = "#A870F0",
		[500] = "#C28EFF",
		[400] = "#C695FF",
		[300] = "#D8B7FF",
		[200] = "#DEC2FF",
		[100] = "#EEDDFF",
		[50] = "#F4EEFF",
	},
}

return colors
