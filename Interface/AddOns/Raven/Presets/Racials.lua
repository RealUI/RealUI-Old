-- Racial abilities

local BUFF = true
local DEBUFF = false
local p = Raven.ColorPalette

Raven.racialSpells = {
	Scourge = {
		{ "Cannibalize", BUFF, p.Orange1, cooldown = true, school = "Physical", id = 20577 },
		{ "Will of the Forsaken", nil, p.Purple1, cooldown = true, school = "Physical", id = 7744 },
	},
	Orc = {
		{ "Blood Fury", BUFF, p.Red1, cooldown = true, school = "Physical", ids = { 33697, 20572, 33702 } },
	},
	Tauren = {
		{ "War Stomp", DEBUFF, p.Orange1, cooldown = true, school = "Physical", id = 20549 },
	},
	Troll = {
		{ "Berserking", BUFF, p.Red1, cooldown = true, school = "Physical", id = 26297 },
	},
	BloodElf = {
		{ "Arcane Torrent", DEBUFF, p.Blue3, cooldown = true, school = "Arcane", ids = { 28730, 50613, 80483, 25046 } },
	},
	NightElf = {
		{ "Shadowmeld", BUFF, p.Purple3, cooldown = true, school = "Physical", id = 58984 },
	},
	Human = {
		{ "Every Man for Himself", nil, p.Yellow1, cooldown = true, school = "Physical", id = 59752 },
	},
	Worgen = {
		{ "Darkflight", BUFF, p.Green1, cooldown = true, school = "Physical", id = 68992 },
		{ "Running Wild", BUFF, p.Gray, school = "Physical", id = 87840 },
		{ "Transform: Worgen", BUFF, p.Gray, school = "Physical", id = 69001 },
	},
	Goblin = {
		{ "Pack Hobgoblin", nil, p.Yellow1, cooldown = true, school = "Physical", id = 69046 },
		{ "Rocket Barrage", nil, p.Red1, cooldown = true, school = "Fire", id = 69041 },
		{ "Rocket Jump", nil, p.Orange1, cooldown = true, school = "Physical", id = 69070 },
	},
	Gnome = {
		{ "Escape Artist", nil, p.Yellow1, cooldown = true, school = "Physical", id = 20589 },
	},
	Dwarf = {
		{ "Stoneform", BUFF, p.Orange1, cooldown = true, school = "Physical", id = 20594 },
	},
	Draenei = {
		{ "Gift of the Naaru", BUFF, p.Blue3, cooldown = true, school = "Holy", ids = { 59545, 59543, 59548, 59542, 59544, 59547, 28880 } },
	},
}
