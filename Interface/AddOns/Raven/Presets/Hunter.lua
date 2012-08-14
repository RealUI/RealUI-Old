-- Hunter

local L = LibStub("AceLocale-3.0"):GetLocale("Raven")
local BUFF = true
local DEBUFF = false
local p = Raven.ColorPalette

Raven.classSpells.HUNTER = {
	{ "Aspect of the Cheetah", BUFF, p.Yellow1, id = 5118 },
	{ "Aspect of the Fox", BUFF, p.Orange1, id = 82661 }, -- Cataclysm level 83
	{ "Aspect of the Hawk", BUFF, p.Blue2, id = 13165 },
	{ "Aspect of the Pack", BUFF, p.Gray, id = 13159 },
	{ "Aspect of the Wild", BUFF, p.Green1, id = 20043 },
	{ "Bestial Wrath", BUFF, p.Red1, cooldown = true, school = "Physical", id = 19574 },
	{ "Black Arrow", DEBUFF, p.Purple3, cooldown = true, shared = L["Fire Traps"], school = "Physical", id = 3674 },
	{ "Bombardment", BUFF, p.Red2, school = "Physical", ids = { 35104, 35110 } },
	{ "Camouflage", BUFF, p.Gray, cooldown = true, school = "Nature", id = 51753 }, -- Cataclysm level 85
	{ "Chimera Shot", BUFF, p.Purple2, cooldown = true, school = "Nature", id = 53209 },
	{ "Cobra Strikes", BUFF, p.Pink, school = "Physical", id = 53256 },
	{ "Concussive Barrage", DEBUFF, p.Cyan, id = 35101 },
	{ "Concussive Shot", DEBUFF, p.Cyan, cooldown = true, school = "Arcane", id = 5116 },
	{ "Counterattack", DEBUFF, p.Orange3, cooldown = true, school = "Physical", id = 19306 },
	{ "Deterrence", BUFF, p.Cyan, cooldown = true, school = "Physical", id = 19263 },
	{ "Disengage", nil, p.Purple3, cooldown = true, school = "Physical", id = 781 },
	{ "Distracting Shot", DEBUFF, p.Purple2, cooldown = true, school = "Arcane", id = 20736 },
	{ "Eagle Eye", BUFF, p.Cyan, school = "Arcane", id = 6197 },
	{ "Entrapment", DEBUFF, p.Yellow2, school = "Physical", ids = { 19185, 64803 } },
	{ "Explosive Shot", DEBUFF, p.Yellow1, cooldown = true, school = "Fire", id = 53301 },
	{ "Explosive Trap", nil, p.Orange2, cooldown = true, shared = L["Fire Traps"], school = "Fire", ids = { 13813, 82939 } },
	{ "Feed Pet", nil, p.Brown1, cooldown = true, school = "Physical", id = 6991 },
	{ "Feign Death", BUFF, p.Green3, cooldown = true, school = "Physical", id = 5384 },
	{ "Fervor", nil, p.Blue3, cooldown = true, school = "Physical", id = 82726 },
	{ "Fire!", BUFF, p.Cyan, school = "Physical", id = 82926 },
	{ "Flare", DEBUFF, p.Orange2, cooldown = true, school = "Arcane", id = 1543 },
	{ "Focus Fire", BUFF, p.Orange3, cooldown = true, school = "Physical", id = 82692 },
	{ "Freezing Trap", nil, p.Purple3, cooldown = true, shared = L["Frost Traps"], school = "Frost", ids = { 1499, 60192 } },
	{ "Go for the Throat", BUFF, p.Orange3, school = "Physical", ids = { 34952, 34953 } },
	{ "Hunter's Mark", DEBUFF, p.Red1, school = "Arcane", id = 1130 },
	{ "Hunting Party", BUFF, p.Green3, school = "Physical", id =  53290 },
	{ "Ice Trap", nil, p.Cyan, cooldown = true, shared = L["Frost Traps"], school = "Frost", ids = { 13809, 82941 } },
	{ "Immolation Trap", nil, p.Orange1, cooldown = true, shared = L["Fire Traps"], school = "Fire", ids = { 13795, 82945 } },
	{ "Improved Steady Shot", BUFF, p.Yellow1, school = "Physical", ids = { 53221, 53222, 53224 } },
	{ "Intimidation", BUFF, p.Brown3, cooldown = true, school = "Physical", id = 19577 },
	{ "Kill Command", nil, p.Orange3, cooldown = true, school = "Physical", id = 34026 },
	{ "Kill Shot", nil, p.Red1, cooldown = true, school = "Physical", id = 53351 },
	{ "Killing Streak", BUFF, p.Red3, school = "Physical", id = 82748 },
	{ "Kindred Spirits", BUFF, p.Red2, school = "Physical", ids = { 56314, 56315, 88680 }}, -- hunter and pet
	{ "Lock and Load", BUFF, p.Red3, school = "Physical", id = 56453 },
	{ "Marked for Death", DEBUFF, p.Brown1, school = "Physical", ids = { 53241, 53243 } },
	{ "Master Marksman", BUFF, p.Purple3, school = "Physical", ids = { 34485, 34486, 34487} },
	{ "Master's Call", nil, p.Yellow2, cooldown = true, school = "Physical", id = 53271 },
	{ "Mend Pet", BUFF, p.Orange2, id = 136 },
	{ "Misdirection", BUFF, p.Cyan, cooldown = true, school = "Physical", id = 34477 },
	{ "Piercing Shots", DEBUFF, p.Red2, school = "Physical", ids = { 53234, 53237, 53238 }},
	{ "Posthaste", BUFF, p.Brown3, school = "Physical", ids = { 83559, 83558, 83560 } },
	{ "Rapid Fire", BUFF, p.Red2, cooldown = true, school = "Physical", id = 3045 },
	{ "Rapid Killing", BUFF, p.Red3, ids = { 35098, 35099 } },
	{ "Raptor Strike", nil, p.Gray, cooldown = true, school = "Physical", id = 2973 },
	{ "Readiness", nil, p.Blue1, cooldown = true, school = "Physical", id = 23989 },
	{ "Ready, Set, Aim...", BUFF, p.Purple3, school = "Physical", id = 82925 },
	{ "Resistance is Futile!", BUFF, p.Orange1, school = "Physical", ids = { 82893, 82894 }},
	{ "Scare Beast", DEBUFF, p.Blue2, school = "Nature", id = 1513},
	{ "Scatter Shot", DEBUFF, p.Gray, cooldown = true, school = "Physical", id = 19503 },
	{ "Serpent Sting", DEBUFF, p.Brown3, school = "Nature", id = 1978 },
	{ "Silencing Shot", DEBUFF, p.Purple3, cooldown = true, school = "Physical", id = 34490 },
	{ "Snake Trap", nil, p.Brown1, cooldown = true, school = "Fire", ids = { 82948, 34600 }},
	{ "Sniper Training", BUFF, p.Blue3, school = "Physical", ids = { 53302, 53303, 53304} },
	{ "Spirit Bond", BUFF, p.Brown1, school = "Nature", ids = { 19578, 20895 }},
	{ "Tame Beast", BUFF, p.Green1, school = "Nature", id = 1515 },
	{ "The Beast Within", BUFF, p.Red1, school = "Physical", id = 34692 },
	{ "Track Beasts", BUFF, p.Brown3, school = "Physical", id = 1494 },
	{ "Track Demons", BUFF, p.Brown2, school = "Physical", id = 19878 },
	{ "Track Dragonkin", BUFF, p.Orange1, school = "Physical", id = 19879 },
	{ "Track Elementals", BUFF, p.Blue2, school = "Physical", id = 19880 },
	{ "Track Giants", BUFF, p.Blue3, school = "Physical", id = 19882 },
	{ "Track Hidden", BUFF, p.Brown3, school = "Physical", id = 19885 },
	{ "Track Humanoids", BUFF, p.Gray, school = "Physical", id = 19883 },
	{ "Track Undead", BUFF, p.Green3, school = "Physical", id = 19884 },
	{ "Trap Launcher", BUFF, p.Red3, school = "Physical", id = 77769 },
	{ "Trueshot Aura", BUFF, p.Brown3, school = "Arcane", id = 19506 },
	{ "Widow Venom", DEBUFF, p.Brown1, school = "Nature", id = 82654 },
	{ "Wing Clip", DEBUFF, p.Yellow3, school = "Physical", id = 2974 },
	{ "Wyvern Sting", DEBUFF, p.Green2, cooldown = true, school = "Nature", id = 19386 },
}

Raven.classConditions.HUNTER = {
	["Check Aspect!"] = {
		tests = {
			["Player Status"] = { enable = true, inCombat = true },
			["Any Buffs"] = { enable = true, toggle = false, unit = "player", isMine = true,
				auras = { 13159, 5118 }, }, -- "Aspect of the Pack", "Aspect of the Cheetah"
		},	
		associatedSpell = 13159, -- "Aspect of the Pack"
	},
	["Aspect Missing"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false, },
			["Spell Ready"] = { enable = true, spell = 13165 }, -- "Aspect of the Hawk"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player", isMine = true,
				auras = { 5118, 82661, 13165, 13159, 20043 }, }, -- "Aspect of the Cheetah", "Fox", "Hawk", "Pack", "Wild"
		},	
	},
	["No Pet!"] = {
		tests = {
			["Player Status"] = { enable = true, inCombat = true, hasPet = false },
		},	
	},
	["Trueshot Aura Missing"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false },
			["Spell Ready"] = { enable = true, spell = 19506 }, -- "Trueshot Aura"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player", auras = { 19506 }, }, -- "Trueshot Aura"
		},	
		associatedSpell = 19506, -- "Trueshot Aura"
	},
}
