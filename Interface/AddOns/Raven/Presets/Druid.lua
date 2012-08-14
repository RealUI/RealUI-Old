-- Druid

local BUFF = true
local DEBUFF = false
local p = Raven.ColorPalette

Raven.classSpells.DRUID = {
	{ "Aquatic Form", BUFF, p.Cyan, school = "Physical", id = 1066 },
	{ "Barkskin", BUFF, p.Brown1, cooldown = true, school = "Nature", id = 22812 },
	{ "Bash", DEBUFF, p.Cyan, cooldown = true, school = "Physical", id = 5211 },
	{ "Bear Form", BUFF, p.Cyan, school = "Physical", lockout = true, id = 5487 },
	{ "Berserk", BUFF, p.Orange3, cooldown = true, school = "Physical", id = 50334 },
	{ "Blood in the Water", BUFF, p.Red3, school = "Physical", id = 80863 },
	{ "Cat Form", BUFF, p.Cyan, school = "Physical", id = 768 },
	{ "Challenging Roar", DEBUFF, p.Orange1, cooldown = true, school = "Physical", id = 5209 },
	{ "Clearcasting", BUFF, p.Blue2, id = 16870 },
	{ "Cower", nil, p.Yellow1, cooldown = true, school = "Physical", id = 8998 },
	{ "Cyclone", DEBUFF, p.Gray, school = "Nature", id = 33786 },
	{ "Dash", BUFF, p.Green2, cooldown = true, school = "Physical", id = 1850 },
	{ "Demoralizing Roar", DEBUFF, p.Brown3, school = "Physical", id = 99 },
	{ "Earth and Moon", DEBUFF, p.Purple2, school = "Physical", id = 48506 },
	{ "Eclipse (Lunar)", BUFF, p.Blue2, school = "Physical", id = 48518 },
	{ "Eclipse (Solar)", BUFF, p.Brown2, school = "Physical", id = 48517 },
	{ "Efflorescence", BUFF, p.Green1, ids = { 34151, 81274, 81275 } },
	{ "Enrage", BUFF, p.Red2, cooldown = true, school = "Physical", id = 5229 },
	{ "Entangling Roots", DEBUFF, p.Brown3, school = "Nature", id = 339 },
	{ "Faerie Fire", DEBUFF, p.Pink, school = "Nature", id = 770 },
	{ "Faerie Fire (Feral)", DEBUFF, p.Pink, cooldown = true, school = "Nature", id = 16857 },
	{ "Feral Charge", nil, p.Gray, cooldown = true, school = "Physical", ids = { 49376, 16979 } },
	{ "Feral Charge - Cat", DEBUFF, p.Gray, school = "Physical", id = 61138 },
	{ "Feral Charge Effect", DEBUFF, p.Gray, school = "Physical", id = 45334 },
	{ "Ferocious Bite", nil, p.Orange3, id = 22568 },
	{ "Flight Form", BUFF, p.Cyan, id = 33943 },
	{ "Force of Nature", BUFF, p.Green1, cooldown = true, school = "Nature", id = 33831 },
	{ "Frenzied Regeneration", BUFF, p.Green3, cooldown = true, school = "Physical", id = 22842 },
	{ "Fungal Growth", DEBUFF, p.Blue3, school = "Physical", ids = { 78788, 78789 } },
	{ "Fury of Stormrage", BUFF, p.Orange2, school = "Physical", ids = { 17104, 24943} },
	{ "Growl", DEBUFF, p.Orange2, cooldown = true, school = "Physical", id = 6795 },
	{ "Harmony", BUFF, p.Yellow1, school = "Physical", id = 77495 },
	{ "Healing Touch", nil, p.Green1, school = "Nature", lockout = true, id = 5185 },
	{ "Hibernate", DEBUFF, p.Purple2, school = "Nature", id = 2637 },
	{ "Hurricane", DEBUFF, p.Purple2, school = "Nature", id = 16914 },
	{ "Infected Wounds", DEBUFF, p.Purple1, school = "Physical", ids = { 58179, 58180 } },
	{ "Innervate", BUFF, p.Blue1, cooldown = true, school = "Nature", id = 29166 },
	{ "Insect Swarm", DEBUFF, p.Brown1, school = "Nature", id = 5570 },
	{ "Lacerate", DEBUFF, p.Purple3, school = "Physical", id = 33745 },
	{ "Leader of the Pack", BUFF, p.Orange2, school = "Physical", id = 17007 },
	{ "Lifebloom", BUFF, p.Green2, school = "Nature", id = 33763 },
	{ "Living Seed", BUFF, p.Yellow3, school = "Nature", ids = { 48500, 48499, 48496 } },
	{ "Lunar Shower", BUFF, p.Cyan, school = "Physical", ids = { 33603, 33604, 33605, 81006, 81191, 81192 } },
	{ "Maim", DEBUFF, p.Brown2, cooldown = true, school = "Physical", id = 22570 },
	{ "Mangle", DEBUFF, p.Red3, cooldown = true, school = "Physical", ids = { 33876, 33878 } },
	{ "Mark of the Wild", BUFF, p.Pink, school = "Nature", id = 1126 },
	{ "Master Shapeshifter", BUFF, p.Orange2, id = 48411 },
	{ "Maul", nil, p.Brown2, cooldown = true, school = "Physical", id = 6807 },
	{ "Moonfire", DEBUFF, p.Cyan, school = "Arcane", id = 8921 },
	{ "Moonkin Aura", BUFF, p.Purple1, id = 24907 },
	{ "Moonkin Form", BUFF, p.Cyan, school = "Physical", id = 24858 },
	{ "Nature's Grace", BUFF, p.Brown1, ids = { 61346, 61345, 16880} },
	{ "Nature's Grasp", BUFF, p.Brown3, cooldown = true, school = "Nature", id = 16689 },
	{ "Nature's Swiftness", nil, p.Blue3, cooldown = true, school = "Physical", id = 17116 },
	{ "Omen of Clarity", BUFF, p.Green2, school = "Nature", id = 16864 },
	{ "Owlkin Frenzy", BUFF, p.Yellow3, ids = { 48393, 49389, 48392 } },
	{ "Pounce Bleed", DEBUFF, p.Brown1, id = 9007 },
	{ "Primal Madness", BUFF, p.Yellow3, school = "Physical", id = 80886 },
	{ "Prowl", BUFF, p.Purple2, cooldown = true, school = "Physical", id = 5215 },
	{ "Pulverize", BUFF, p.Brown3, school = "Physical", id = 80313 },
	{ "Rake", DEBUFF, p.Purple3, school = "Physical", id = 1822 },
	{ "Rebirth", nil, p.Purple3, cooldown = true, school = "Nature", id = 20484 },
	{ "Regrowth", BUFF, p.Green3, school = "Nature", id = 8936 },
	{ "Rejuvenation", BUFF, p.Green1, school = "Nature", id = 774 },
	{ "Remove Corruption", nil, p.Green1, school = "Arcane", id = 2782 },
	{ "Rip", DEBUFF, p.Blue3, school = "Physical", id = 1079 },
	{ "Savage Defense", BUFF, p.Orange2, school = "Physical", id = 62600 },
	{ "Savage Roar", BUFF, p.Green3, school = "Physical", id = 52610 },
	{ "Shooting Stars", BUFF, p.Blue2, school = "Physical", ids = {93398, 93399} },
	{ "Shred", nil, p.Yellow2, school = "Physical", id = 5221 },
	{ "Skull Bash", DEBUFF, p.Gray, cooldown = true, school = "Physical", ids = { 80965, 80964 } },
	{ "Solar Beam", DEBUFF, p.Yellow2, cooldown = true, school = "Nature", id = 78675 },
	{ "Soothe", DEBUFF, p.Brown3, id = 2908 },
	{ "Stampede", BUFF, p.Orange3, school = "Physical", ids = { 78892, 78893 } },
	{ "Stampeding Roar", BUFF, p.Orange1, cooldown = true, school = "Physical", ids = { 77761, 77764 } }, -- Cataclysm level 83
	{ "Starfall", BUFF, p.Purple3, cooldown = true, school = "Arcane", ids = { 50288, 48505 } },
	{ "Starsurge", BUFF, p.Purple2, cooldown = true, school = "Arcane", id = 78674 },
	{ "Sunfire", DEBUFF, p.Orange2, id = 93402 },
	{ "Survival Instincts", BUFF, p.Orange3, cooldown = true, school = "Physical", id = 61336 },
	{ "Swift Flight Form", BUFF, p.Cyan, id = 40120 },
	{ "Swiftmend", nil, p.Blue3, cooldown = true, school = "Nature", id = 18562 },
	{ "Swipe", nil, p.Yellow3, cooldown = true, school = "Nature", ids = { 779, 62078 } },
	{ "Thorns", BUFF, p.Brown2, cooldown = true, school = "Nature", id = 467 },
	{ "Thrash", DEBUFF, p.Gray, cooldown = true, school = "Physical", id = 77758 }, -- Cataclysm level 81
	{ "Tiger's Fury", BUFF, p.Yellow3, cooldown = true, school = "Physical", id = 5217 },
	{ "Tranquility", BUFF, p.Purple2, cooldown = true, school = "Nature", id = 740 },
	{ "Travel Form", BUFF, p.Cyan, id = 783 },
	{ "Tree of Life", BUFF, p.Cyan, cooldown = true, school = "Physical", id = 33891 },
	{ "Typhoon", nil, p.Purple1, cooldown = true, school = "Nature", ids = { 50516, 61391 } },
	{ "Vengeance", BUFF, p.Orange3, id = 84840 },
	{ "Wild Growth", BUFF, p.Blue2, cooldown = true, school = "Nature", id = 48438 },
	{ "Wild Mushroom: Detonate", nil, p.Orange2, cooldown = true, school = "Nature", id = 88751 }, -- Cataclysm level 85
}

Raven.classConditions.DRUID = {
	["Mark of the Wild Missing"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false },
			["Spell Ready"] = { enable = true, spell = 1126 }, -- "Mark of the Wild"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player",
				auras = { 1126, 20217 }, }, -- "Mark of the Wild", "Blessing of Kings"
		},
		associatedSpell = 1126, -- "Mark of the Wild"
	},
	["Remove Corruption (Poison)"] = {
		tests = {
			["Spell Ready"] = { enable = true, spell = 2782, }, -- "Remove Corruption"
			["Debuff Type"] = { enable = true, unit = "player", hasDebuff = "Poison", },
		},	
		associatedSpell = 2782, -- "Remove Corruption"
	},
	["Remove Corruption (Curse)"] = {	
		tests = {
			["Spell Ready"] = { enable = true, spell = 2782, }, -- "Remove Corruption"
			["Debuff Type"] = { enable = true, unit = "player", hasDebuff = "Curse", },
		},	
		associatedSpell = 2782, -- "Remove Corruption"
	},
	["Remove Corruption (Magic)"] = {	
		tests = {
			["Player Status"] = { enable = true, checkTalent = true, talent = 88423, }, -- "Nature's Cure"
			["Debuff Type"] = { enable = true, unit = "player", hasDebuff = "Magic", },
			["Spell Ready"] = { enable = true, spell = 2782, }, -- "Remove Corruption"
		},	
		associatedSpell = 2782, -- "Remove Corruption"
	},
}
