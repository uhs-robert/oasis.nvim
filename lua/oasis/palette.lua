-- lua/oasis/palette.lua
-- Tailwind-style numeric scale palette system

-- Terminal
-- stylua: ignore start
local terminal = {
	black =               "#101010", -- Overridden by theme
	bright_black =        "#877363", -- Overridden by theme
	red =                 "#FF7979",
	bright_red =          "#FFA0A0",
  green =               "#7FCF78",
  bright_green =        "#A3E39A",
	yellow =              "#F0E68C",
	bright_yellow =       "#F8B471",
	blue =                "#81C0FF",
	bright_blue =         "#87CEEB",
	magenta =             "#C695FF",
	bright_magenta =      "#D2ADFF",
	cyan =                "#68C0B6",
	bright_cyan =         "#8FD1C7",
	white =               "#FFF7D7",
	bright_white =        "#F7F4E9",
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
  stone = "#2D251F",
  desert = "#433F38",
  orange = "#5A3824",
  yellow = "#4D4528",
  green = "#1F3A2D",
  palm = "#345A2B",
  teal = "#2B4A46",
  blue = "#335668",
  sky = "#3D6980",
  night = "#24364D",
  indigo = "#3E2F4A",
  violet = "#653F73",
  pink = "#5A324B",
  grey = "#666666",
}

-- Diagnostics
local diag = {
  error = { fg = terminal.bright_red, bg = visual.red },
  warn = { fg = terminal.yellow, bg = visual.yellow },
  info = { fg = terminal.blue, bg = visual.blue },
  hint = { fg = terminal.bright_cyan, bg = visual.teal },
  ok = { fg = terminal.bright_green, bg = visual.green },
}

-- Diff
local diff = {
  add = visual.green,
  change = visual.yellow, -- Unused, prefer theme[name].bg.surface
  delete = visual.red,
  text = visual.orange,
}

-- Git
local git = {
  add = terminal.bright_green,
  change = terminal.yellow,
  delete = terminal.bright_red,
}

-- Theme specific
local theme = {
  -- Dark themes
  -- fg targets: dim = 4:0:1 (shadow), muted = 3:0:1 (core), comment = 4:5:1 (core)
  abyss = {
    bg = { shadow = "#050505", core = "#000000", mantle = "#101010", surface = "#1C1C1C" },
    fg = { core = "#F0EBE6", strong = "#FFDACC", dim = "#587179", muted = "#605C4D", comment = "#7A7662" },
    light_bg_seed = "#000000",
  },
  cactus = {
    bg = { shadow = "#152017", core = "#18231A", mantle = "#253127", surface = "#334137" },
    fg = { core = "#DDF0E5", strong = "#C7EDCF", dim = "#907B6A", muted = "#5B7360", comment = "#69956D" },
  },
  canyon = {
    bg = { shadow = "#221511", core = "#2B1914", mantle = "#38251E", surface = "#4A342A" },
    fg = { core = "#F8E7D3", strong = "#FFD8BC", dim = "#857164", muted = "#9A6549", comment = "#B67E61" },
  },
  desert = {
    bg = { shadow = "#212121", core = "#262626", mantle = "#2E2E2E", surface = "#404040" },
    fg = { core = "#F7EDE1", strong = "#E5D9CE", dim = "#748C9A", muted = "#77725F", comment = "#948F7A" },
    light_bg_seed = "#F0E68C",
  },
  dune = {
    bg = { shadow = "#241D19", core = "#29211C", mantle = "#352C26", surface = "#483F35" },
    fg = { core = "#E8E5DA", strong = "#EDE8AF", dim = "#6E6E6E", muted = "#826D5A", comment = "#9F8B79" },
    light_bg_seed = "#F3D3A3",
  },
  lagoon = {
    bg = { shadow = "#0F1522", core = "#101825", mantle = "#1A283F", surface = "#22385C" },
    fg = { core = "#D9E6FA", strong = "#D0E2F0", dim = "#877363", muted = "#3B6A87", comment = "#4D88A7" },
  },
  luna = {
    bg = { shadow = "#0C0A2A", core = "#101032", mantle = "#1A1646", surface = "#241F56" },
    fg = { core = "#EEEAFE", strong = "#DCD5FF", dim = "#7E789B", muted = "#8A82B3", comment = "#A29AC9" },
    light_bg_seed = "#1A1646",
  },
  midnight = {
    bg = { shadow = "#0C1014", core = "#101418", mantle = "#18202A", surface = "#223040" },
    fg = { core = "#F7F4F2", strong = "#FFE0CC", dim = "#7D7267", muted = "#4E6578", comment = "#69809D" },
    light_bg_seed = "#F17D62",
  },
  mirage = {
    bg = { shadow = "#132025", core = "#152229", mantle = "#1C2B31", surface = "#253840" },
    fg = { core = "#DDEFEF", strong = "#C9EEE6", dim = "#907C6C", muted = "#587270", comment = "#439789" },
  },
  moonlight = {
    bg = { shadow = "#020304", core = "#070C13", mantle = "#0F1520", surface = "#1A2330" },
    fg = { core = "#F7F4F2", strong = "#E8F1FF", dim = "#74808F", muted = "#4E6578", comment = "#69809D" },
    light_bg_seed = "#E8E5DA",
  },
  night = {
    bg = { shadow = "#020A19", core = "#050F23", mantle = "#0B1832", surface = "#122444" },
    fg = { core = "#E8F1FF", strong = "#D9E6FA", dim = "#74808F", muted = "#536B83", comment = "#708CA8" },
    light_bg_seed = "#85A8CC",
  },
  rose = {
    bg = { shadow = "#2B1523", core = "#301828", mantle = "#3E2636", surface = "#523A4B" },
    fg = { core = "#FADBE4", strong = "#EBBEDF", dim = "#8A786C", muted = "#816175", comment = "#A87A91" },
    light_bg_seed = "#301828",
  },
  scorpion = {
    bg = { shadow = "#080100", core = "#140400", mantle = "#22100B", surface = "#331C16" },
    fg = { core = "#F7EAE5", strong = "#FFD9CF", dim = "#8E7770", muted = "#9A6F66", comment = "#B08A80" },
    light_bg_seed = "#F9A05E",
  },
  sol = {
    bg = { shadow = "#25110F", core = "#2A1412", mantle = "#341F1B", surface = "#462A25" },
    fg = { core = "#FFE0DA", strong = "#FFD3CB", dim = "#7B7B7B", muted = "#83615B", comment = "#A27D78" },
    light_bg_seed = "#D06666",
  },
  starlight = {
    bg = { shadow = "#050505", core = "#000000", mantle = "#111216", surface = "#1C2028" },
    fg = { core = "#FAF7F0", strong = "#DCD9D2", dim = "#85665B", muted = "#4F5B6B", comment = "#5E7C9A" },
  },
  twilight = {
    bg = { shadow = "#201726", core = "#261A30", mantle = "#312140", surface = "#3F2B50" },
    fg = { core = "#F0E4F2", strong = "#EAD8FF", dim = "#76665A", muted = "#71609A", comment = "#8B80AA" },
    light_bg_seed = "#E28E6F",
  },
}

-- Full palette with Tailwind-style numeric scales
local colors = {
  terminal = terminal,
  light_terminal = light_terminal,
  visual = visual,
  diag = diag,
  diff = diff,
  git = git,
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
    [900] = "#4D4A42",
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

  -- soil = {
  --   [900] = "#6F664F",
  --   [800] = "#898067",
  --   [700] = "#A39A7F",
  --   [600] = "#B6B097",
  --   [500] = "#C2BFA5",
  --   [400] = "#D1CDB8",
  --   [300] = "#DFDCCA",
  --   [200] = "#EBE9DD",
  --   [100] = "#F5F4EE",
  --   [50] = "#FBFBF8",
  -- },

  -- Reds/Pinks
  red = {
    [900] = "#A23B3B",
    [800] = "#D06666",
    [700] = "#E26E6E",
    [600] = "#E87272",
    [500] = "#FF7979",
    [400] = "#F78181",
    [300] = "#F58B8B",
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
    [900] = "#6B3420",
    [800] = "#9C5034",
    [700] = "#C96E4D",
    [600] = "#E28E6F",
    [500] = "#F7997D",
    [400] = "#F9AF96",
    [300] = "#FBC0AA",
    [200] = "#FCD1BE",
    [100] = "#FDE1D2",
    [50] = "#FEF0E8",
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
    [900] = "#B35A00",
    [800] = "#E67200",
    [700] = "#FF8A1F",
    [600] = "#FF9633",
    [500] = "#FFA34D",
    [400] = "#FFA857",
    [300] = "#FFBA75",
    [200] = "#FFC78F",
    [100] = "#FFD7AD",
    [50] = "#FFE7CC",
  },

  amber = {
    [900] = "#4E2E12",
    [800] = "#71411D",
    [700] = "#CD853F",
    [600] = "#D79655",
    [500] = "#E2A76B",
    [400] = "#E9B987",
    [300] = "#F0CAA1",
    [200] = "#F5DCBE",
    [100] = "#FAECD9",
    [50] = "#FDF7EF",
  },

  -- Browns
  sand = {
    [900] = "#735A34",
    [800] = "#8A6D46",
    [700] = "#A18159",
    [600] = "#B8956D",
    [500] = "#D0B081",
    [400] = "#E3C394",
    [300] = "#F3D3A3",
    [200] = "#F9D9AB",
    [100] = "#FDE5BC",
    [50] = "#FFF2DB",
  },

  -- Yellows
  gold = {
    [900] = "#7A5200",
    [800] = "#A66F00",
    [700] = "#CC8D00",
    [600] = "#EAAA14",
    [500] = "#FFC43D",
    [400] = "#FFD05C",
    [300] = "#FFDB7D",
    [200] = "#FFE7A3",
    [100] = "#FFF2CC",
    [50] = "#FFF9E8",
  },

  khaki = {
    [900] = "#807C37",
    [800] = "#BDB76B",
    [700] = "#CDC673",
    [600] = "#D6CE7C",
    [500] = "#F0E68C",
    [400] = "#F2E898",
    [300] = "#F3EA9F",
    [200] = "#F6EEB2",
    [100] = "#F9F2C5",
    [50] = "#FBF6D8",
  },

  dune = {
    [900] = "#685A29",
    [800] = "#8B793B",
    [700] = "#AF9A4E",
    [600] = "#C7B35E",
    [500] = "#D8C06A",
    [400] = "#DBC36F",
    [300] = "#E0CA7D",
    [200] = "#EBD998",
    [100] = "#F6E8B7",
    [50] = "#FBF0CB",
  },

  -- Greens
  olive = {
    [900] = "#526528",
    [800] = "#69812F",
    [700] = "#819D3C",
    [600] = "#93B346",
    [500] = "#A1C254",
    [400] = "#B2CF72",
    [300] = "#C3DB93",
    [200] = "#D5E6B6",
    [100] = "#E8F0D8",
    [50] = "#F5F9EE",
  },

  palm = {
    [900] = "#295B24",
    [800] = "#3F8339",
    [700] = "#57A851",
    [600] = "#6BC268",
    [500] = "#7FCF78",
    [400] = "#91D98A",
    [300] = "#A3E39A",
    [200] = "#BEEEB8",
    [100] = "#DCF7DA",
    [50] = "#EFFCF0",
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
    [700] = "#68C0B6",
    [600] = "#79C7BE",
    [500] = "#8FD1C7",
    [400] = "#96D4CB",
    [300] = "#A8DDD5",
    [200] = "#BAE6DF",
    [100] = "#CCEFE9",
    [50] = "#DEF8F4",
  },

  cyan = {
    [900] = "#1E6F8E",
    [800] = "#2788AC",
    [700] = "#36A5CA",
    [600] = "#4FC0E0",
    [500] = "#6DCEEB",
    [400] = "#8ADAF2",
    [300] = "#A5E5F7",
    [200] = "#C0EFFB",
    [100] = "#D8F7FD",
    [50] = "#ECFCFF",
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
    [900] = "#2877C6",
    [800] = "#3787D7",
    [700] = "#47A3FF",
    [600] = "#5BADFF",
    [500] = "#71B8FF",
    [400] = "#81C0FF",
    [300] = "#93C8FF",
    [200] = "#ACD5FF",
    [100] = "#C5E2FF",
    [50] = "#DEF0FF",
  },

  steelblue = {
    [900] = "#4575A5",
    [800] = "#5D8BBB",
    [700] = "#6F98C3",
    [600] = "#7FA3C9",
    [500] = "#85A8CC",
    [400] = "#93B3D2",
    [300] = "#A2BED8",
    [200] = "#B0C8DE",
    [100] = "#BFD2E3",
    [50] = "#CEDCE9",
  },

  -- Purples/Indigos
  lavender = {
    [900] = "#7033CC",
    [800] = "#8F4FE6",
    [700] = "#9C5FEB",
    [600] = "#A870F0",
    [500] = "#C28EFF",
    [400] = "#CB9EFF",
    [300] = "#D2ADFF",
    [200] = "#DEC2FF",
    [100] = "#EEDDFF",
    [50] = "#F4EEFF",
  },

  iris = {
    [900] = "#271B5C",
    [800] = "#3E3094",
    [700] = "#5F51CE",
    [600] = "#736FDF",
    [500] = "#8D8DE7",
    [400] = "#9797E9",
    [300] = "#A9A9ED",
    [200] = "#BCBDF5",
    [100] = "#CFD1F9",
    [50] = "#E2E4FC",
  },

  -- Pinks
  desert_rose = {
    [900] = "#9A5A72",
    [800] = "#B9728A",
    [700] = "#D18BA2",
    [600] = "#DB9AB0",
    [500] = "#E4AABD",
    [400] = "#EAB8C8",
    [300] = "#EFC5D3",
    [200] = "#F4D4DE",
    [100] = "#F8E1E9",
    [50] = "#FCF0F3",
  },
}

return colors
