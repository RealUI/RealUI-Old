-- Shaman
local L = LibStub("AceLocale-3.0"):GetLocale("Raven")
local BUFF = true
local DEBUFF = false
local p = Raven.ColorPalette

Raven.classSpells.SHAMAN = {
	{ "Ancestral Fortitude", BUFF, p.Green2, school = "Physical", id = 16236 }, -- from Ancestral Healing talent
	{ "Astral Recall", nil, p.Purple2, cooldown = true, school = "Nature", id = 556 },
	{ "Bind Elemental", DEBUFF, p.Pink, school = "Nature", id = 76780 },
	{ "Bloodlust", BUFF, p.Red1, cooldown = true, school = "Nature", id = 2825 },
	{ "Chain Heal", nil, p.Green2, school = "Nature", id = 1064 },
	{ "Chain Lightning", nil, p.Blue1, cooldown = true, school = "Nature", id = 421 },
	{ "Clearcasting", BUFF, p.Blue2, id = 16246 },
	{ "Earth Elemental Totem", nil, p.Brown2, cooldown = true, shared = L["Earth/Fire Elementals"], school = "Nature", id = 2062 },
	{ "Earth Shield", BUFF, p.Brown3, id = 974 },
	{ "Earth Shock", DEBUFF, p.Yellow3, cooldown = true, shared = L["Shocks"], school = "Nature", id = 8042 },
	{ "Earthbind", DEBUFF, p.Gray, id = 3600 },
	{ "Earthbind Totem", nil, p.Gray, cooldown = true, school = "Nature", id = 2484 },
	{ "Earthliving", BUFF, p.Green1, school = "Nature", id = 51945 },
	{ "Earthliving Weapon", BUFF, p.Green1, school = "Nature", id = 51730 },
	{ "Earthquake", DEBUFF, p.Gray, cooldown = true, school = "Nature", id = 61882 },
	{ "Elemental Devastation", BUFF, p.Purple2, school = "Physical", id = 29180 },
	{ "Elemental Mastery", BUFF, p.Purple3, cooldown = true, school = "Nature", id = 16166 },
	{ "Elemental Oath", BUFF, p.Blue3, school = "Physical", id = 51470 },
	{ "Elemental Overload", BUFF, p.Blue3, id = 77222 },
	{ "Elemental Resistance", BUFF, p.Orange3, id = 8185 },
	{ "Elemental Resistance Totem", nil, p.Orange3, id = 8184 },
	{ "Far Sight", BUFF, p.Orange2, school = "Nature", id = 6196 },
	{ "Feral Spirit", nil, p.Cyan, cooldown = true, school = "Nature", id = 51533 },
	{ "Fire Elemental Totem", nil, p.Orange3, cooldown = true, shared = L["Earth/Fire Elementals"], school = "Physical", id = 2894 },
	{ "Fire Nova", nil, p.Orange2, cooldown = true, school = "Fire", id = 1535 },
	{ "Flame Shock", DEBUFF, p.Red3, cooldown = true, shared = L["Shocks"], school = "Fire", id = 8050 },
	{ "Flametongue Totem", BUFF, p.Orange3, school = "Physical", id = 8227 },
	{ "Flametongue Weapon", BUFF, p.Orange3, school = "Fire", lockout = true, id = 8024 },
	{ "Flurry", BUFF, p.Red2, school = "Physical", id = 16278 },
	{ "Focused Insight", BUFF, p.Cyan, school = "Physical", id = 77796 },
	{ "Freeze", DEBUFF, p.Blue1, id = 63685 },
	{ "Frost Shock", DEBUFF, p.Cyan, cooldown = true, shared = L["Shocks"], school = "Frost", id = 8056 },
	{ "Frostbrand Attack", BUFF, p.Cyan, id = 54609 },
	{ "Frostbrand Weapon", BUFF, p.Cyan, school = "Frost", lockout = true, id = 8033 },
	{ "Ghost Wolf", BUFF, p.Purple3, school = "Nature", id = 2645 },
	{ "Grounding Totem", nil, p.Purple2, cooldown = true, school = "Nature", id = 8177 },
	{ "Grounding Totem Effect", BUFF, p.Purple2, id = 8178 },
	{ "Healing Rain", BUFF, p.Blue1, cooldown = true, school = "Nature", id = 73920 }, -- Cataclysm level 83
	{ "Healing Stream", BUFF, p.Cyan, id = 65994 },
	{ "Healing Stream Totem", nil, p.Cyan, school = "Physical", id = 5394 },
	{ "Heroism", BUFF, p.Orange2, cooldown = true, school = "Nature", id = 32182 },
	{ "Hex", DEBUFF, p.Green2, cooldown = true, school = "Nature", id = 51514 },
	{ "Lava Burst", nil, p.Red3, cooldown = true, school = "Fire", id = 51505 },
	{ "Lava Lash", nil, p.Red2, cooldown = true, school = "Fire", id = 60103 },
	{ "Lightning Bolt", nil, p.Blue1, school = "Nature", lockout = true, id = 403 },
	{ "Lightning Shield", BUFF, p.Blue2, school = "Nature", id = 324 },
	{ "Maelstrom Weapon", BUFF, p.Purple3, school = "Physical", id = 53817 },
	{ "Magma Totem", nil, p.Red3, school = "Physical", id = 8190 },
	{ "Mana Spring", BUFF, p.Purple3, id = 5677 },
	{ "Mana Spring Totem", nil, p.Purple3, school = "Physical", id = 5675 },
	{ "Mana Tide", BUFF, p.Blue3, id = 16191 },
	{ "Mana Tide Totem", nil, p.Blue3, cooldown = true, school = "Physical", id = 16190 },
	{ "Nature's Guardian", BUFF, p.Blue1, school = "Physical", ids = { 30884, 30881, 30883 } },
	{ "Nature's Swiftness", BUFF, p.Blue2, cooldown = true, school = "Physical", id = 16188 },
	{ "Primal Strike", nil, p.Brown1, cooldown = true, school = "Physical", id = 73899 },
	{ "Purge", nil, p.Purple1, school = "Nature", id = 370 },
	{ "Reincarnation", nil, p.Purple2, cooldown = true, school = "Nature", id = 20608 },
	{ "Riptide", BUFF, p.Blue2, cooldown = true, school = "Nature", id = 61295 },
	{ "Rockbiter Weapon", BUFF, p.Brown2, school = "Nature", id = 8017 },
	{ "Searing Totem", nil, p.Orange3, school = "Physical", id = 3599 },
	{ "Shamanistic Rage", BUFF, p.Red1, cooldown = true, school = "Physical", id = 30823 },
	{ "Spiritwalker's Grace", BUFF, p.Green3, cooldown = true, school = "Nature", id = 79206 }, -- Cataclysm level 85
	{ "Spirit Link Totem", BUFF, p.Green2, cooldown = true, school = "Physical", id = 98008 }, -- patch 4.1
	{ "Stoneclaw Totem", BUFF, p.Brown2, cooldown = true, school = "Nature", id = 5730 },
	{ "Stoneskin", BUFF, p.Purple2, id = 31986 },
	{ "Stoneskin Totem", nil, p.Purple2, school = "Physical", lockout = true, id = 8071 },
	{ "Stormstrike", BUFF, p.Blue1, cooldown = true, school = "Physical", id = 17364 },
	{ "Strength of Earth", BUFF, p.Yellow1, id = 8076 },
	{ "Strength of Earth Totem", BUFF, p.Yellow1, school = "Physical", id = 8075 },
	{ "Thunderstorm", nil, p.Blue3, cooldown = true, school = "Nature", id = 51490 },
	{ "Tidal Waves", BUFF, p.Cyan, school = "Physical", id = 53390 },
	{ "Totem of Tranquil Mind", BUFF, p.Blue2, school = "Physical", id = 87718 },
	{ "Totemic Wrath", BUFF, p.Red3, school = "Physical", id = 77746 },
	{ "Tremor Totem", nil, p.Yellow3, cooldown = true, school = "Physical", id = 8143 },
	{ "Unleash Earth", DEBUFF, p.Brown3, cooldown = true, school = "Nature", id = 73684 }, -- Cataclysm level 81
	{ "Unleash Elements", nil, p.Pink, cooldown = true, school = "Physical", id = 73680 }, -- Cataclysm level 81
	{ "Unleash Flame", BUFF, p.Red3, cooldown = true, school = "Fire", id = 73683 }, -- Cataclysm level 81
	{ "Unleash Frost", DEBUFF, p.Blue3, cooldown = true, school = "Frost", id = 73682 }, -- Cataclysm level 81
	{ "Unleash Life", BUFF, p.Green3, cooldown = true, school = "Nature", id = 73685 }, -- Cataclysm level 81
	{ "Unleash Wind", BUFF, p.Gray, cooldown = true, school = "Physical", id = 73681 }, -- Cataclysm level 81
	{ "Unleashed Rage", BUFF, p.Orange1, school = "Physical", id = 30808 },
	{ "Water Breathing", BUFF, p.Cyan, school = "Nature", id = 131 },
	{ "Water Shield", BUFF, p.Blue3, school = "Nature", id = 52127 },
	{ "Water Walking", BUFF, p.Gray, school = "Nature", id = 546 },
	{ "Wind Shear", nil, p.Gray, cooldown = true, school = "Nature", id = 57994 },
	{ "Windfury Totem", BUFF, p.Pink, school = "Physical", id = 8512 },
	{ "Windfury Weapon", BUFF, p.Gray, school = "Nature", id = 8232 },
	{ "Wrath of Air Totem", BUFF, p.Green3, school = "Physical", id = 3738 },
	-- Totem tracker colors
	{ L["Fire Totem"], nil, p.Red2 },
	{ L["Water Totem"], nil, p.Blue1 },
	{ L["Earth Totem"], nil, p.Brown3 },
	{ L["Air Totem"], nil, p.Purple3 },
}

Raven.classConditions.SHAMAN = {
	["Weapon Buff Missing"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false, isFishing = false },
			["Spell Ready"] = { enable = true, spell = 8017, }, -- "Rockbiter Weapon"
			["Buff Type"] = { enable = true, unit = "player", toggle = true, hasBuff = "Mainhand" },
		},	
	},
	["Shield Missing"] = {
		tests = {
			["Player Status"] = { enable = true, inCombat = true },
			["Spell Ready"] = { enable = true, spell = 324, }, -- "Lightning Shield"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player",
				auras = { 52127, 324, 974 }, }, -- "Water Shield", "Lightning Shield", "Earth Shield"
		},	
	},
	["Cleanse Spirit (Curse)"] = {	
		tests = {
			["Spell Ready"] = { enable = true, spell = 51886, }, -- "Cleanse Spirit"
			["Debuff Type"] = { enable = true, unit = "player", hasDebuff = "Curse", },
		},
		associatedSpell = 51886, -- "Cleanse Spirit"
	},
	["Cleanse Spirit (Magic)"] = {	
		tests = {
			["Spell Ready"] = { enable = true, spell = 51886, }, -- "Cleanse Spirit"
			["Player Status"] = { enable = true, checkTalent = true, talent = 77130, }, -- "Improved Cleanse Spirit"
			["Debuff Type"] = { enable = true, unit = "player", hasDebuff = "Magic", },
		},
		associatedSpell = 51886, -- "Cleanse Spirit"
	},
}
