-- Mage

local L = LibStub("AceLocale-3.0"):GetLocale("Raven")
local BUFF = true
local DEBUFF = false
local p = Raven.ColorPalette

Raven.classSpells.MAGE = {
	{ "Arcane Barrage", nil, p.Purple3, cooldown = true, school = "Arcane", id = 44425 },
	{ "Arcane Blast", DEBUFF, p.Purple3, school = "Arcane", lockout = true, ids = { 30451, 36032 } },
	{ "Arcane Brilliance", BUFF, p.Cyan, school = "Arcane", id = 1459 },
	{ "Arcane Missiles", nil, p.Blue1, school = "Arcane", ids = { 5143, 7268 } },
	{ "Arcane Missiles!", BUFF, p.Blue1, id = 79683 }, -- procs when Arcane Missiles is available
	{ "Arcane Power", BUFF, p.Blue2, cooldown = true, school = "Arcane", id = 12042 },
	{ "Arcane Tactics", BUFF, p.Purple1, school = "Arcane", id = 82930 },
	{ "Blast Wave", DEBUFF, p.Orange2, cooldown = true, school = "Fire", id = 11113 },
	{ "Blazing Speed", BUFF, p.Orange2, school = "Fire", ids = { 31642, 31641} },
	{ "Blink", nil, p.Purple3, cooldown = true, school = "Arcane", id = 1953 },
	{ "Blizzard", BUFF, p.Blue2, school = "Frost", ids = { 10, 42208 } },
	{ "Brain Freeze", BUFF, p.Gray, school = "Physical", ids = { 44549, 44548, 44546, 57761 } },
	{ "Cauterize", BUFF, p.Orange3, school = "Physical", ids = { 86949, 86948 } },
	{ "Clearcasting", BUFF, p.Blue2, id = 12536 },
	{ "Cold Snap", nil, p.Blue2, cooldown = true, school = "Frost", id = 11958 },
	{ "Combustion", DEBUFF, p.Yellow3, cooldown = true, school = "Fire", id = 11129 },
	{ "Cone of Cold", DEBUFF, p.Cyan, cooldown = true, school = "Frost", id = 120 },
	{ "Counterspell", nil, p.Purple1, cooldown = true, school = "Arcane", id = 2139 },
	{ "Critical Mass", DEBUFF, p.Purple3, school = "Physical", id = 12873 },
	{ "Dalaran Brilliance", BUFF, p.Purple2, school = "Arcane", id = 61316 },
	{ "Deep Freeze", DEBUFF, p.Cyan, cooldown = true, school = "Frost", id = 44572 },
	{ "Dragon's Breath", DEBUFF, p.Orange1, cooldown = true, school = "Fire", id = 31661 },
	{ "Evocation", BUFF, p.Purple2, cooldown = true, school = "Arcane", id = 12051 },
	{ "Fingers of Frost", BUFF, p.Blue1, school = "Physical", ids = { 83074, 44545, 44543, 44544 } },
	{ "Fire Blast", nil, p.Red3, cooldown = true, school = "Fire", id = 2136 },
	{ "Fireball", nil, p.Orange2, school = "Fire", lockout = true, id = 133 },
	{ "Flame Orb", nil, p.Orange3, cooldown = true, school = "Fire", ids = { 82731, 82739 } }, -- Cataclysm level 81
	{ "Flamestrike", DEBUFF, p.Orange1, school = "Fire", id = 2120 },
	{ "Focus Magic", BUFF, p.Cyan, school = "Arcane", ids = { 54646, 54648} },
	{ "Frost Armor", BUFF, p.Blue1, school = "Frost", id = 7302 },
	{ "Frost Nova", DEBUFF, p.Blue2, cooldown = true, school = "Frost", id = 122 },
	{ "Frostbolt", DEBUFF, p.Purple3, school = "Frost", lockout = true, id = 116 },
	{ "Frostfire Bolt", DEBUFF, p.Yellow3, school = "Frost", id = 44614 },
	{ "Frostfire Orb", DEBUFF, p.Blue3, school = "Frost", ids = { 84727, 84726 } },
	{ "Hot Streak", BUFF, p.Brown3, school = "Fire", id = 44445 },
	{ "Ice Barrier", BUFF, p.Green3, cooldown = true, school = "Frost", id = 11426 },
	{ "Ice Block", BUFF, p.Blue2, cooldown = true, school = "Frost", id = 45438 },
	{ "Ice Shards", DEBUFF, p.Blue1, school = "Frost", ids = { 12487, 11185 } },
	{ "Icy Veins", BUFF, p.Blue1, cooldown = true, school = "Frost", id = 12472 },
	{ "Ignite", DEBUFF, p.Red2, school = "Physical", ids = { 12846, 11120, 11119 } },
	{ "Impact", BUFF, p.Brown1, school = "Fire", id = 64343 },
	{ "Improved Blink", BUFF, p.Orange3, school = "Physical", ids = { 47000, 46989 } },
	{ "Improved Cone of Cold", DEBUFF, p.Cyan, school = "Frost", id = 83302 },
	{ "Improved Mana Gem", BUFF, p.Orange3, school = "Physical", ids = { 31585, 31584 } },
	{ "Improved Polymorph", DEBUFF, p.Orange3, school = "Arcane", ids = { 12592, 11210 } },
	{ "Incanter's Absorption", BUFF, p.Brown1, ids = { 44395, 44394 } },
	{ "Invisibility", BUFF, p.Blue3, cooldown = true, school = "Arcane", id = 66 },
	{ "Invocation", BUFF, p.Purple3, school = "Physical", ids = { 84723, 84722 } },
	{ "Living Bomb", DEBUFF, p.Red3, school = "Fire", id = 44457 },
	{ "Mage Armor", BUFF, p.Blue1, school = "Arcane", id = 6117 },
	{ "Mage Ward", BUFF, p.Purple1, cooldown = true, school = "Arcane", id = 543 },
	{ "Mana Shield", BUFF, p.Green3, cooldown = true, school = "Arcane", id = 1463 },
	{ "Mirror Image", BUFF, p.Blue1, cooldown = true, school = "Arcane", id = 55342 },
	{ "Molten Armor", BUFF, p.Orange2, school = "Fire", id = 30482 },
	{ "Mote of Flame", BUFF, p.Red1, school = "Fire", id = 67713 },
	{ "Polymorph", DEBUFF, p.Gray, school = "Arcane", ids = { 118, 61305, 28272, 28271, 61721, 61780 } },
	{ "Portal: Dalaran", nil, p.Blue1, cooldown = true, shared = L["Portals"], school = "Arcane", id = 53142 },
	{ "Portal: Darnassus", nil, p.Blue1, cooldown = true, shared = L["Portals"], school = "Arcane", id = 11419 },
	{ "Portal: Exodar", nil, p.Blue1, cooldown = true, shared = L["Portals"], school = "Arcane", id = 32266 },
	{ "Portal: Ironforge", nil, p.Blue1, cooldown = true, shared = L["Portals"], school = "Arcane", id = 11416 },
	{ "Portal: Orgrimmar", nil, p.Blue1, cooldown = true, shared = L["Portals"], school = "Arcane", id = 11417 },
	{ "Portal: Shattrath", nil, p.Blue1, cooldown = true, shared = L["Portals"], school = "Arcane", ids = { 33691, 35717 } },
	{ "Portal: Silvermoon", nil, p.Blue1, cooldown = true, shared = L["Portals"], school = "Arcane", id = 32267 },
	{ "Portal: Stonard", nil, p.Blue1, cooldown = true, shared = L["Portals"], school = "Arcane", id = 49361 },
	{ "Portal: Stormwind", nil, p.Blue1, cooldown = true, shared = L["Portals"], school = "Arcane", id = 10059 },
	{ "Portal: Theramore", nil, p.Blue1, cooldown = true, shared = L["Portals"], school = "Arcane", id = 49360 },
	{ "Portal: Thunder Bluff", nil, p.Blue1, cooldown = true, shared = L["Portals"], school = "Arcane", id = 11420 },
	{ "Portal: Tol Barad", nil, p.Blue1, cooldown = true, school = "Arcane", ids = { 88345, 88346 } }, -- Cataclysm level 85
	{ "Portal: Undercity", nil, p.Blue1, cooldown = true, shared = L["Portals"], school = "Arcane", id = 11418 },
	{ "Presence of Mind", BUFF, p.Gray, cooldown = true, school = "Arcane", id = 12043 },
	{ "Pyroblast", DEBUFF, p.Orange2, school = "Fire", id = 11366 },
	{ "Pyroblast!", DEBUFF, p.Orange2, school = "Fire", id = 92315 },
	{ "Pyromaniac", BUFF, p.Orange3, school = "Fire", ids = { 34295, 34293 } },
	{ "Ring of Frost", DEBUFF, p.Blue2, cooldown = true, school = "Frost", id = 82676 }, -- Cataclysm level 83
	{ "Ritual of Refreshment", nil, p.Purple3, cooldown = true, school = "Arcane", id = 43987 },
	{ "Silenced - Improved Counterspell", DEBUFF, p.Purple2, school = "Physical", ids = { 55021, 18469 } },
	{ "Slow", DEBUFF, p.Yellow2, school = "Arcane", id = 31589 },
	{ "Slow Fall", BUFF, p.Pink, id = 130 },
	{ "Summon Water Elemental", nil, p.Green2, cooldown = true, school = "Frost", id = 31687 },
	{ "Time Warp", BUFF, p.Blue3, cooldown = true, school = "Arcane", id = 80353 }, -- Cataclysm level 85
}

Raven.classConditions.MAGE = {
	["Armor Missing"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false },
			["Spell Ready"] = { enable = true, spell = 30482 }, -- "Molten Armor"
			["Any Buffs"] = { enable = true, toggle = true, isMine = true, unit = "player",
				auras = { 7302, 6117, 30482 }, }, -- "Frost Armor", "Mage Armor", "Molten Armor"
		},	
		associatedSpell = 7302, -- "Frost Armor"
	},
	["Intellect Buff Missing"] = {	
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false },
			["Spell Ready"] = { enable = true, spell = 1459 }, -- "Arcane Brilliance"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player",
				auras = { 1459, 61316, 54424 }, }, -- "Arcane Brilliance", "Dalaran Brilliance", "Fel Intelligence"
		},	
		associatedSpell = 1459, -- "Arcane Brilliance"
	},
	["Remove Curse"] = {	
		tests = {
			["Spell Ready"] = { enable = true, spell = 475 }, -- "Remove Curse"
			["Debuff Type"] = { enable = true, unit = "player", hasDebuff = "Curse", },
		},	
		associatedSpell = 475, -- "Remove Curse"
	},
}
