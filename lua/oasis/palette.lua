-- lua/oasis/palette.lua
--
-- local melange = {
--  -- stylua: ignore
-- return {
--   a = {
--     bg      = "#292522",
--     float   = "#34302C",
--     sel     = "#403A36",
--     ui      = "#867462",
--     com     = "#C1A78E",
--     fg      = "#ECE1D7",
--   },
--   b = {
--     red     = "#D47766",
--     yellow  = "#EBC06D",
--     green   = "#85B695",
--     cyan    = "#89B3B6",
--     blue    = "#A3A9CE",
--     magenta = "#CF9BC2",
--   },
--   c = {
--     red     = "#BD8183",
--     yellow  = "#E49B5D",
--     green   = "#78997A",
--     cyan    = "#7B9695",
--     blue    = "#7F91B2",
--     magenta = "#B380B0",
--   },
--   d = {
--     red     = "#7D2A2F",
--     yellow  = "#8B7449",
--     green   = "#233524",
--     cyan    = "#253333",
--     blue    = "#273142",
--     magenta = "#422741",
--   },
-- }
-- }
--
--
-- khakiOrange1 = "#E3963E", -- sandstone orange (rich ochre, already in your theme)
-- khakiOrange2 = "#F5B041", -- golden orange (sunlit, vibrant but not harsh)
-- khakiOrange3 = "#FF8C42", -- burnt amber (stronger, desert sunset orange)
-- khakiOrange4 = "#D2691E", -- sienna orange (earthy, grounded)
-- khakiOrange5 = "#CD853F", -- peru (classic warm orange-brown)

local colors = {
	diag = {
		error = {
			fg = "#FF0000",
			bg = "#322639",
		},
		warn = {
			fg = "#eeee00",
			bg = "#38343d",
		},
		info = {
			fg = "#75A0FF",
			bg = "#203346",
		},
		hint = {
			fg = "#62aba0",
			bg = "#273644",
		},
		ok = {
			fg = "#00FF7F",
			bg = "#2f4f4f",
		},
	},
	white = "#ffffff",
	black = "#000000",
	slategrey = "#708090",
	grey20 = "#333333",
	grey30 = "#4D4D4D",
	grey50 = "#7F7F7F",

	moss = "#bfcc9b",
	moss2 = "#809867",
	moss3 = "#406533",
	moss4 = "#003100",

	softgreen = "#c8f08c",

	cactus = "#9ba367",
	cactus2 = "#30bc73",
	cactus3 = "#169c43",
	cactus4 = "#536e2b",
	cactus5 = "#284608",
	cactus6 = "#1b340d",

	catusNew1 = "#60a44f",
	catusNew2 = "#2a8e48",
	catusNew3 = "#35b56e",
	catusNew4 = "#5ee285",
	catusNew5 = "#398825",

copperDust        = "#B87333", -- metallic copper, desert mineral
ironOxide         = "#B7410E", -- rusty soil, strong and earthy
sandstoneOrange   = "#E3963E", -- warm ochre, canyon rock
clayRose          = "#C97E6E", -- clay with red tint
adobeBrick        = "#A0522D", -- classic adobe wall

terraCotta        = "#E2725B", -- terracotta pottery, vibrant clay
burntSienna       = "#E97451", -- sun-baked sienna, warm mineral
desertRust        = "#AF593E", -- oxidized iron, muted rust
mesaClay          = "#CC7357", -- mesa cliff clay, reddish
canyonSoil        = "#A5542F", -- canyon floor soil

sunsetOchre       = "#D2691E", -- strong ochre, orange-brown
puebloClay        = "#D99058", -- pueblo plaster clay, softer tone
aridClaystone     = "#BC6C43", -- muted claystone, earthy
canyonAmber       = "#CD7F32", -- amber-brown, mineral rich
bakedEarth        = "#C65D3E", -- parched earth, reddish brown

sierraBrown       = "#8B4513", -- saddle brown, petrified wood
dustyUmber        = "#8E5B3D", -- raw umber, muted earthy
cinderTan         = "#B86B4B", -- volcanic cinder tan
earthenware       = "#9C4A2F", -- pottery clay red-brown
rustClay          = "#A94F2C", -- deep rusted clay

-- punctuation = hsl("#B8AFA1"), -- sandstone dust (muted tan-grey)
-- punctuation = hsl("#A89F94"), -- canyon silt (darker grey-beige, still neutral)
-- punctuation = hsl("#CCC5B9"), -- pale adobe dust (very light, chalky)
-- punctuation = hsl("#D6CFCB"), -- desert dust (softest, airy neutral)

	twilightViolet = "#B499FF", -- lighter, glowing vibe
	desertOrchid = "#CC99FF", -- clear medium-bright violet
	sunlitAmethyst = "#D8B4F8", -- soft lavender, airy
	pricklyPearBlossom = "#BC8FEE", -- lively but grounded
	paleDesertBloom = "#E6C2FF", -- very light pastel violet
	mesaLilac = "#A788F7", -- slightly deeper, duskier violet
	canyonHeather = "#AD7FE4", -- muted but still vibrant, dusk bloom

	sageBloom = "#D1B2FF", -- soft pastel violet, like sage in bloom
	desertLilac = "#C8A2C8", -- classic lilac, airy, floral
	mesaViolet = "#B57EDC", -- medium lavender, slightly warmer
	twilightBloom = "#D6A9F8", -- lavender-pink, glowing dusk flower
	canyonLavender = "#E0B0FF", -- pale lavender, high desert bloom

	desertIndigo = "#7B68EE", -- vivid indigo, lighter than deep navy
	canyonIndigo = "#6F42C1", -- rich canyon shadow indigo
	horizonIndigo = "#8A2BE2", -- blue-violet glow, energetic but readable
	nightIndigo = "#7966FF", -- brightened indigo, pops on dark bg
	starlitIndigo = "#9F7FFF", -- softer indigo-lavender, airy desert night
	mesaIndigo = "#5D54A4", -- muted dusk indigo, grounded and earthy

	warningDesertBloom = "#D946EF", -- neon cactus bloom violet (bright, floral, desert wildflower)
	warningPricklyNeon = "#C724B1", -- magenta-violet, prickly pear flower intensity
	warningTwilightNeon = "#9D00FF", -- electric indigo, twilight desert horizon
	warningStarglow = "#B026FF", -- glowing violet-indigo, feels like desert night sky
	warningMesaGlow = "#A23BEC", -- neon lilac-indigo, luminous canyon dusk

functionBuiltin1 = "#FF7A1C", -- molten copper (brighter, more saturated orange)
functionBuiltin2 = "#FF6F3C", -- desert ember (leans red-orange, stronger than func)
functionBuiltin3 = "#FF8520", -- solar flare (bold sunset orange, clear pop)
functionBuiltin4 = "#E56717", -- sienna flame (earthy but still vibrant)
functionBuiltin5 = "#FF5E0E", -- lava orange (aggressive, borders on danger but not red)

desertRose        = "#FF6EB4", -- vivid hot pink, iconic desert rose bloom
desertRose2       = "#FF69B4", -- saturated blossom pink
cactusRose        = "#FF77FF", -- bright pink-violet, floral pop
sunsetPetal       = "#FF85C1", -- warm pink glow, late sunset
paleRoseQuartz    = "#FF99CC", -- soft pastel pink

sandstoneBlush    = "#FFB6C1", -- muted light pink, desert stone reflection
ghostFlower       = "#FFCCE5", -- pale pastel, ghost flower bloom
adobeBlush        = "#F19CBB", -- earthy pink, adobe clay tone
hibiscusFire      = "#E75480", -- magenta-pink, hibiscus in desert heat
dustyPrimrose     = "#DB7093", -- muted violet-pink, faded desert bloom

wildOrchid        = "#EE82EE", -- bright violet, orchid bloom
canyonOrchid      = "#DA70D6", -- medium orchid, canyon flora
amethystSpire     = "#BA55D3", -- bold violet, crystal-like
claretBloom       = "#C154C1", -- magenta-violet, rich bloom
neonThistle       = "#D36CFF", -- glowing lilac, electric desert bloom

sageLavender      = "#E6A9EC", -- pastel violet-lavender, airy
plumShadow        = "#DDA0DD", -- soft violet-pink, dusk plum
cactusFlower      = "#CFA7FF", -- pastel violet-pink, cactus flower
pearBlossom       = "#BC8FEE", -- vibrant lilac, prickly pear bloom

punctuation1 = "#D6CFCB", -- desert dust (lightest, almost invisible)
punctuation2 = "#CCC5B9", -- pale adobe dust (airy)
punctuation3 = "#C2BEB3", -- desert ash (your current, balanced)
punctuation4 = "#B0A99A", -- canyon stone (a touch darker)
punctuation5 = "#9E9584", -- dry riverbed (darkest I'd go without clutter)

khaki01_paleThatch     = "#FAFAD2", -- very pale golden straw
khaki02_goldenSteppe   = "#FFF68F", -- light golden khaki (khaki1)
khaki03_canyonDust     = "#EEE8AA", -- pale sandy khaki
khaki04_sunlitSand     = "#FFD87C", -- bright golden sand
khaki05_bleachedWheat  = "#F5DEB3", -- wheat-like soft khaki

khaki06_duneSand       = "#F0E68C", -- classic khaki
khaki07_mesaGold       = "#DAA520", -- goldenrod khaki
khaki08_puebloClay     = "#E0C068", -- clay-gold khaki
khaki09_sageDust       = "#D8C378", -- dusty sage-gold
khaki10_dryGrass       = "#D6C38B", -- pale golden grass

khaki11_sunbakedOchre  = "#D2B48C", -- tan/ochre khaki
khaki12_adobeBeige     = "#DECBA4", -- sandy beige
khaki13_sagebrushTan   = "#C2B280", -- muted sage khaki
khaki14_aridSteppe     = "#C5C599", -- muted pale olive khaki
khaki15_sandstoneLight = "#EEE685", -- khaki2 (light stone khaki)

khaki16_sandstoneDeep  = "#CDC673", -- khaki3 (darker stone khaki)
khaki17_desertOlive    = "#8B864E", -- khaki4 (olive khaki)
khaki18_sunBleachedRock= "#BDB76B", -- darkkhaki
khaki19_coyoteTan      = "#C3B091", -- earthy tan
khaki20_mesaShadow     = "#7A6A4F", -- deep olive-brown khaki


	skyBlue = "#87CEEB",
	skyDesertBlue = "#56c1d8",
	skyDarkCyan = "#4e93b4",
	-- skyAqua="#019992",
	skyNight = "#003030",
  skyBlueDark = "#36525e",

	skyYellow = "#ffc929",
	skyOrange = "#f9a159",
	skyOrangeRed = "#cc7025",
	skyOrangeBrown = "#9f561a",

	skyMauve = "#CAB8FF", -- hazy mauve sky at dusk
	skyRose = "#F4A6C9", -- sunset rose tint
	skyAmber = "#FFBF69", -- amber horizon

	skyPink = "#ec5f4c",
	skyRed = "#c91f26",

	skyDusk = "#614e66",
	skyTwilight = "#B499FF",
	skyTeal = "#b6d7bb",
	skyAqua = "#62aba0",
	skyCyan = "#2b8f91",

	sunYellow = "#f7dc6f",
	sunHotYellow = "#f9fb07",
	sunDarkYellow = "#cda214",
	sunOrange = "#f5b041",
	sunHotOrange = "#f6540d",
	sunDarkOrange = "#cd4514",
	sunRed = "#f06e6e",
	sunHotRed = "#a51515",
	sunDarkRed = "#8c141a",
	sunPurple = "#6a4477",
	sunHotPurple = "#b22e7e",
	sunDarkPurple = "#8c1456",


sertGreen01 = "#D4E157", -- bright lime (desert bloom lime)
sertGreen02 = "#C0CA33", -- cactus sprout (yellow-green, earthy)
sertGreen03 = "#A3C244", -- sage pad (balanced yellow-green)
sertGreen04 = "#8BC34A", -- prickly pear leaf (fresh)
sertGreen05 = "#7CB342", -- agave green (deeper desert plant)

sertGreen06 = "#AED581", -- soft cactus (muted pastel yellow-green)
sertGreen07 = "#9CCC65", -- palo verde (vivid plant tone)
sertGreen08 = "#8BC671", -- desert aloe (sage-leaning)
sertGreen09 = "#7FAE42", -- yucca pad (darker cactus leaf)
sertGreen10 = "#689F38", -- ocotillo stem (deep earthy green)

sertGreen11 = "#CDDC39", -- sunlit lime (very bright, high pop)
sertGreen12 = "#C5E17A", -- pale bloom (soft, light green-yellow)
sertGreen13 = "#B2EB50", -- new growth (lively pastel lime)
sertGreen14 = "#A9DF4C", -- tender cactus (muted chartreuse)
sertGreen15 = "#99CC32", -- desert sage bright (classic yellowgreen)

sertGreen16 = "#80CC28", -- desert mesquite (intense lime green)
sertGreen17 = "#76B947", -- prickly pear fresh (rich green-yellow)
sertGreen18 = "#6FAE3D", -- agave stalk (mid-dark)
sertGreen19 = "#5D8C2B", -- desert olive (earthy dark yellow-green)
sertGreen20 = "#4F772D", -- deep cactus shade (structural, muted)

	-- ⚠️ Warning (replace yellow)
	cactusBloom = "#D946EF", -- neon cactus bloom violet

	-- ❗ Risky (replace orange)
	riskyViolet = "#C724B1", -- magenta-violet, prickly pear bloom
	riskyTwilight = "#B499FF", -- twilight violet (lighter, glowing)

	-- 🔥 Danger (replace red)
	dangerIndigo = "#9D00FF", -- electric indigo, desert twilight
	dangerStarglow = "#B026FF", -- glowing indigo-violet, night sky


comment = "#8B7765",   -- desert parchment (lighter, readable)
nontext = "#514742",   -- canyon shadow (darker, subdued)


	nightSand = "#f2e9e4",
	nightSand2 = "#c9ada7",
	nightSand3 = "#9a8c98",

	lightSand = "#f6f0e1",
	lightSand2 = "#f6edd2",
	lightSand3 = "#f2e9e4",

	sand = "#ffdcb4",
	sand2 = "#dfc8a2",
	sand3 = "#f8c471",
  desertSand = "#edc9af",

	darkSand = "#7C6A5B",
	darkSand2 = "#6B5B56",
	brown = "#e2a754",
	red = "#ff7f59",
	indianred = "#cd5c5c",
	indianpink = "#ffa0a0",
	gold = "#ffd700",
	khaki = "#f0e68c",
	khakireverse = "#8c96f0",
	khaki1 = "#fff68f",
	khaki2 = "#eee685",
	khaki3 = "#cdc673",
	khaki4 = "#8b864e",
	goldenrod = "#daa520",
	seagreen = "#2E8B57",
	springgreen = "#00FF7F",
	yellowgreen = "#9ACD32",
	darkgreen = "#006400",
	lightblue = "#ADD8E6",
	olivedrab = "#6B8E23",
	salmon = "#FA8072",
	orangered = "#FF4500",
	darkred = "#8B0000",
	navajowhite = "#FFDEAD",
	darkkhaki = "#BDB76B",
	palegreen = "#98FB98",
	wheat = "#F5DEB3",
	peru = "#CD853F",
	tan = "#D2B48C",
	yellow2 = "#EEEE00",
}

return colors



