-- Death Knight
local L = LibStub("AceLocale-3.0"):GetLocale("Raven")
local BUFF = true
local DEBUFF = false
local p = Raven.ColorPalette

Raven.classSpells.DEATHKNIGHT = {
	{ "Abomination's Might", BUFF, p.Orange1, school = "Physical", id = 53138 },
	{ "Acherus Deathcharger", BUFF, p.Blue2, id = 48778 }, -- mount
	{ "Anti-Magic Shell", BUFF, p.Yellow3, cooldown = true, school = "Shadow", id = 48707 },
	{ "Anti-Magic Zone", BUFF, p.Gray, cooldown = true, school = "Shadow", id = 51052 },
	{ "Army of the Dead", nil, p.Purple3, cooldown = true, school = "Shadow", id = 42650 },
	{ "Blade Barrier", BUFF, p.Purple3, school = "Physical", id = 64856 },
	{ "Blood Plague", DEBUFF, p.Red1, school = "Shadow", id = 59879 },
	{ "Blood Presence", BUFF, p.Red2, school = "Physical", id = 48263 },
	{ "Blood Shield", BUFF, p.Red3, school = "Physical", id = 77513 },
	{ "Blood Tap", nil, p.Red2, cooldown = true, school = "Physical", id = 45529 },
	{ "Bone Shield", BUFF, p.Purple3, cooldown = true, school = "Nature", id = 49222 },
	{ "Chains of Ice", DEBUFF, p.Blue2, id = 45524 },
	{ "Crimson Scourge", BUFF, p.Red2, school = "Physical", id = 81136 },
	{ "Dancing Rune Weapon", BUFF, p.Yellow1, cooldown = true, school = "Physical", id = 49028 },
	{ "Dark Command", DEBUFF, p.Orange1, cooldown = true, school = "Physical", id = 56222 },
	{ "Dark Simulacrum", DEBUFF, p.Purple2, cooldown = true, school = "Physical", id = 77606 }, -- Cataclysm level 85
	{ "Dark Transformation", BUFF, p.Brown3, school = "Shadow", id = 63560 },
	{ "Death and Decay", nil, p.Orange3, cooldown = true, school = "Shadow", id = 43265 },
	{ "Death Gate", nil, p.Purple1, cooldown = true, school = "Shadow", id = 50977 },
	{ "Death Grip", DEBUFF, p.Purple2, cooldown = true, school = "Physical", id = 49576 },
	{ "Death Pact", nil, p.Orange2, cooldown = true, school = "Shadow", id = 48743 },
	{ "Desecration", DEBUFF, p.Purple1, school = "Shadow", id = 68766 },
	{ "Ebon Plague", DEBUFF, p.Purple3, id = 65142 },
	{ "Empower Rune Weapon", nil, p.Purple1, cooldown = true, school = "Physical", id = 47568 },
	{ "Freezing Fog", BUFF, p.Blue1, id = 59052 }, -- proc for Rime talent
	{ "Frost Fever", DEBUFF, p.Blue3, school = "Frost", id = 59921 },
	{ "Frost Presence", BUFF, p.Blue3, school = "Frost", id = 48266 },
	{ "Horn of Winter", BUFF, p.Brown3, cooldown = true, school = "Physical", id = 57330 },
	{ "Howling Blast", nil, p.Blue1, school = "Frost", id = 49184 },
	{ "Hungering Cold", DEBUFF, p.Purple3, cooldown = true, school = "Frost", id = 49203 },
	{ "Icebound Fortitude", BUFF, p.Cyan, cooldown = true, school = "Physical", id = 48792 },
	{ "Improved Icy Talons", BUFF, p.Green3, school = "Frost", id = 55610 },
	{ "Killing Machine", BUFF, p.Blue3, school = "Physical", id = 51124 },
	{ "Lichborne", BUFF, p.Gray, cooldown = true, school = "Shadow", id = 49039 },
	{ "Mind Freeze", nil, p.Purple3, cooldown = true, school = "Frost", id = 47528 },
	{ "Necrotic Strike", DEBUFF, p.Orange3, school = "Physical", id = 73975 }, -- Cataclysm level 83
	{ "On a Pale Horse", BUFF, p.Gray, school = "Physical", id = 51986 },
	{ "Outbreak", nil, p.Green3, cooldown = true, school = "Physical", id = 77575 }, -- Cataclysm level 81
	{ "Path of Frost", BUFF, p.Blue1, school = "Physical", id = 3714 },
	{ "Pillar of Frost", BUFF, p.Cyan, cooldown = true, school = "Physical", id = 51271 },
	{ "Raise Ally", nil, p.Gray, cooldown = true, school = "Physical", id = 61999 },
	{ "Raise Dead", nil, p.Gray, cooldown = true, school = "Physical", id = 46584 },
	{ "Runic Corruption", BUFF, p.Purple2, school = "Shadow", id = 51462 },
	{ "Rune Tap", nil, p.Red3, cooldown = true, school = "Shadow", id = 48982 },
	{ "Scarlet Fever", DEBUFF, p.Red1, school = "Physical", id = 81130 },
	{ "Scent of Blood", BUFF, p.Orange2, school = "Physical", id = 50421 },
	{ "Shadow Infusion", BUFF, p.Green3, school = "Physical", id = 91342 },
	{ "Strangulate", DEBUFF, p.Green2, cooldown = true, school = "Shadow", id = 47476 },
	{ "Sudden Doom", BUFF, p.Purple1, school = "Physical", id = 81340 },
	{ "Summon Gargoyle", nil, p.Brown2, cooldown = true, school = "Shadow", id = 49206 },
	{ "Unholy Blight", DEBUFF, p.Gray, school = "Shadow", id = 49194 },
	{ "Unholy Frenzy", BUFF, p.Green1, cooldown = true, school = "Physical", id = 49016 },
	{ "Unholy Presence", BUFF, p.Green1, school = "Shadow", id = 48265 },
	{ "Vampiric Blood", BUFF, p.Red3, cooldown = true, school = "Physical", id = 55233 },
	{ "Will of the Necropolis", BUFF, p.Orange2, school = "Physical", id = 81163 },
	-- Rune cooldown colors
	{ L["Blood Rune"], nil, p.Red1 },
	{ L["Frost Rune"], nil, p.Blue1 },
	{ L["Unholy Rune"], nil, p.Green1 },
	{ L["Death Rune"], nil, p.Purple1 },
}

Raven.runeSpells = {
	["Anti-Magic Zone"] = { unholy = true, id = 51052 },
	["Army of the Dead"] = { blood = true, frost = true, unholy = true, id = 42650 },
	["Blood Boil"] = { blood = true, id = 48721 },
	["Blood Strike"] = { blood = true, id = 45902 },
	["Bone Shield"] = { unholy = true, id = 49222 },
	["Chains of Ice"] = { frost = true, id = 45524 },
	["Dark Transformation"] = { unholy = true, id = 63560 },
	["Death and Decay"] = { unholy = true, id = 43265 },
	["Death Gate"] = { unholy = true, id = 50977 },
	["Death Strike"] = { frost = true, unholy = true, id = 49998 },
	["Festering Strike"] = { blood = true, frost = true, id = 86061 },
	["Heart Strike"] = { blood = true, id = 55050 },
	["Howling Blast"] = { frost = true, id = 49184 },
	["Icy Touch"] = { frost = true, id = 45477 },
	["Necrotic Strike"] = { unholy = true, id = 73975 },
	["Obliterate"] = { frost = true, unholy = true, id = 49020 },
	["Path of Frost"] = { frost = true, id = 3714 },
	["Pestilence"] = { blood = true, id = 50842 },
	["Pillar of Frost"] = { frost = true, id = 51271 },
	["Plague Strike"] = { unholy = true, id = 45462 },
	["Rune Tap"] = { blood = true, id = 48982 },
	["Scourge Strike"] = { unholy = true, id = 55090 },
	["Strangulate"] = { blood = true, id = 47476 },
}

Raven.classConditions.DEATHKNIGHT = {
	["Presence Missing"] = {
		tests = {
			["Spell Ready"] = { enable = true, spell = 48266, }, -- "Frost Presence"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player",
				auras = { 48266, 48263, 48265 }, }, --  "Frost Presence", "Blood Presence", "Unholy Presence"
		},	
	},
	["Horn of Winter!"] = {
		tests = {
			["Player Status"] = { enable = true, inCombat = true },
			["Spell Ready"] = { enable = true, spell = 57330, }, -- "Horn of Winter"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player",
				auras = { 57330, 8076, 6673, 93435 }, }, -- "Horn of Winter", "Strength of Earth", "Battle Shout", "Roar of Courage"
		},	
		associatedSpell = 57330, -- "Horn of Winter"
	},
}
