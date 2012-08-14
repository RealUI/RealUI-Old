-- Priest

local BUFF = true
local DEBUFF = false
local p = Raven.ColorPalette

Raven.classSpells.PRIEST = {
	{ "Archangel", BUFF, p.Yellow1, cooldown = true, school = "Holy", id = 87151 },
	{ "Blessed Healing", BUFF, p.Yellow3, school = "Holy", id = 70772 },
	{ "Blessed Recovery", BUFF, p.Brown3, id = 27818 },
	{ "Blessed Resilience", BUFF, p.Orange3, school = "Physical", id = 33145 },
	{ "Body and Soul", BUFF, p.Green3, id = 64128 },
	{ "Borrowed Time", BUFF, p.Yellow3, id = 59888 },
	{ "Chakra", BUFF, p.Yellow3, cooldown = true, school = "Physical", id = 14751 },
	{ "Chakra: Serenity", BUFF, p.Purple3, id = 81208 },
	{ "Chakra: Sanctuary", BUFF, p.Yellow2, id = 81206 },
	{ "Chakra: Chastise", BUFF, p.Yellow3, id = 81209 },
	{ "Circle of Healing", nil, p.Yellow1, cooldown = true, school = "Holy", id = 34861 },
	{ "Dark Archangel", BUFF, p.Yellow1, cooldown = true, school = "Holy", id = 87153 },
	{ "Dark Evangelism", BUFF, p.Brown3, school = "Physical", id = 87117 },
	{ "Desperate Prayer", nil, p.Orange1, cooldown = true, school = "Holy", id = 19236 },
	{ "Devouring Plague", DEBUFF, p.Purple3, school = "Shadow", id = 2944 },
	{ "Dispersion", BUFF, p.Purple1, cooldown = true, school = "Physical", id = 47585 },
	{ "Divine Aegis", BUFF, p.Brown2, id = 47515 },
	{ "Divine Hymn", BUFF, p.Orange3, cooldown = true, school = "Holy", id = 64843 },
	{ "Echo of Light", BUFF, p.Blue3, id = 77485 },
	{ "Empowered Shadow", BUFF, p.Red2, school = "Shadow", id = 95799 },
	{ "Evangelism", BUFF, p.Brown3, school = "Physical", id = 81662 },
	{ "Fade", BUFF, p.Cyan, cooldown = true, school = "Shadow", id = 586 },
	{ "Fear Ward", BUFF, p.Orange2, cooldown = true, school = "Holy", id = 6346 },
	{ "Focused Will", BUFF, p.Brown1, school = "Physical", id = 45242 },
	{ "Grace", BUFF, p.Blue3, school = "Physical", id = 77613 },
	{ "Guardian Spirit", BUFF, p.Blue2, cooldown = true, school = "Holy", id = 47788 },
	{ "Holy Concentration", BUFF, p.Orange3, id = 34859 },
	{ "Holy Fire", DEBUFF, p.Yellow2, cooldown = true, school = "Holy", id = 14914 },
	{ "Holy Word: Chastise", DEBUFF, p.Brown2, cooldown = true, school = "Holy", id = 88625 },
	{ "Holy Word: Sanctuary", BUFF, p.Brown2, cooldown = true, school = "Holy", id = 88685, refer = 88625 },
	{ "Holy Word: Serenity", BUFF, p.Brown2, cooldown = true, school = "Holy", id = 88684, refer = 88625 },
	{ "Hymn of Hope", BUFF, p.Gray, cooldown = true, school = "Holy", id = 64901 },
	{ "Inner Fire", BUFF, p.Orange1, school = "Holy", id = 588 },
	{ "Inner Focus", BUFF, p.Gray, cooldown = true, school = "Physical", id = 89485 },
	{ "Inner Will", BUFF, p.Cyan, school = "Holy", id = 73413 }, -- Cataclysm level 83
	{ "Inspiration", BUFF, p.Brown3, id = 15357 },
	{ "Leap of Faith", nil, p.Blue3, cooldown = true, school = "Holy", id = 73325 }, -- Cataclysm level 85
	{ "Levitate", BUFF, p.Gray, id = 1706 },
	{ "Lightwell", nil, p.Yellow3, cooldown = true, school = "Holy", id = 724 },
	{ "Mind Blast", nil, p.Yellow2, cooldown = true, school = "Shadow", id = 8092 },
	{ "Mind Control", DEBUFF, p.Orange3, id = 605 },
	{ "Mind Flay", DEBUFF, p.Orange2, school = "Shadow", id = 15407 },
	{ "Mind Melt", BUFF, p.Purple3, school = "Shadow", id = 33371 },
	{ "Mind Quickening", BUFF, p.Purple3, school = "Shadow", id = 49868 },
	{ "Mind Sear", DEBUFF, p.Purple3, school = "Shadow", id = 48045 },
	{ "Mind Soothe", DEBUFF, p.Purple2, school = "Shadow", id = 453 },
	{ "Mind Spike", DEBUFF, p.Purple1, school = "Shadow", id = 73510 }, -- Cataclysm level 81
	{ "Mind Vision", BUFF, p.Yellow3, id = 2096 },
	{ "Misery", BUFF, p.Green3, id = 33192},
	{ "Pain Suppression", BUFF, p.Gray, cooldown = true, school = "Holy", id = 33206 },
	{ "Paralysis", DEBUFF, p.Red3, id = 87195 },
	{ "Penance", BUFF, p.Green3, cooldown = true, school = "Holy", id = 47540 },
	{ "Power Infusion", BUFF, p.Yellow1, cooldown = true, school = "Holy", id = 10060 },
	{ "Power Word: Barrier", BUFF, p.Yellow3, cooldown = true, school = "Holy", id = 62618 },
	{ "Power Word: Shield", BUFF, p.Yellow3, cooldown = true, school = "Holy", id = 17 },
	{ "Power Word: Fortitude", BUFF, p.Cyan, id = 21562 },
	{ "Prayer of Mending", BUFF, p.Yellow2, cooldown = true, school = "Holy", id = 33076 },
	{ "Psychic Horror", DEBUFF, p.Purple3, cooldown = true, school = "Shadow", id = 64044 },
	{ "Psychic Scream", DEBUFF, p.Blue3, cooldown = true, school = "Shadow", id = 8122 },
	{ "Renew", BUFF, p.Green2, id = 139 },
	{ "Renewed Hope", BUFF, p.Orange1, id = 57472 },
	{ "Serendipity", BUFF, p.Blue1, id = 63735 },
	{ "Shackle Undead", DEBUFF, p.Orange2, id = 9484 },
	{ "Shadowfiend", nil, p.Purple3, cooldown = true, school = "Shadow", id = 34433 },
	{ "Shadowform", BUFF, p.Purple3, school = "Shadow", id = 15473 },
	{ "Shadow Orb", BUFF, p.Purple1, school = "Shadow", id = 77487 },
	{ "Shadow Protection", BUFF, p.Purple3, id = 27683 },
	{ "Shadow Word: Death", nil, p.Red2, cooldown = true, school = "Shadow", id = 32379 },
	{ "Shadow Word: Pain", DEBUFF, p.Red3, school = "Shadow", lockout = true, id = 589 },
	{ "Silence", DEBUFF, p.Brown2, cooldown = true, school = "Shadow", id = 15487 },
	{ "Smite", nil, p.Green1, school = "Holy", lockout = true, id = 585 },
	{ "Spirit of Redemption", BUFF, p.Gray, id = 20711 },
	{ "Strength of Soul", BUFF, p.Orange2, id = 89489 },
	{ "Surge of Light", BUFF, p.Orange3, id = 88688 },
	{ "Vampiric Embrace", BUFF, p.Blue2, id = 15286 },
	{ "Vampiric Touch", DEBUFF, p.Purple3, id = 34914 },
	{ "Weakened Soul", DEBUFF, p.Orange3, id = 6788 },
}

Raven.classConditions.PRIEST = {
	["Fortitude Missing"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false },
			["Spell Ready"] = { enable = true, spell = 21562, }, -- "Power Word: Fortitude"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player",
				auras = { 469, 21562, 6307 }, }, -- "Commanding Shout", "Power Word: Fortitude", "Blood Pact"
		},	
		associatedSpell = 21562, -- "Power Word: Fortitude"
	},
	["Shadow Protection!"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false, },
			["Any Buffs"] = { enable = true, toggle = true, unit = "player", auras = { 27683 }, }, -- "Shadow Protection"
			["Spell Ready"] = { enable = true, spell = 27683, }, -- "Shadow Protection"
		},	
		associatedSpell = 27683, -- "Shadow Protection"
	},
	["Vampiric Embrace!"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false, },
			["All Buffs"] = { enable = true, unit = "player", auras = { 15473 }, }, -- "Shadowform"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player", auras = { 15286 }, }, -- "Vampiric Embrace"
			["Spell Ready"] = { enable = true, spell = 15286, }, -- "Vampiric Embrace"
		},	
		associatedSpell = 15286, -- "Vampiric Embrace"
	},
	["Inner Fire!"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false, },
			["Any Buffs"] = { enable = true, toggle = true, unit = "player", auras = { 588, 73413 }, }, -- "Inner Fire" or "Inner Will"
			["Spell Ready"] = { enable = true, spell = 588, }, -- "Inner Fire"
		},	
		associatedSpell = 588, -- "Inner Fire"
	},
	["Chakra!"] = {
		tests = {
			["Player Status"] = { enable = true, inCombat = true, isMounted = false, },
			["Any Buffs"] = { enable = true, toggle = true, unit = "player", auras = { 81206, 81208, 81209 }, }, -- "Sanctuary" or "Serenity" or "Chastise"
			["Spell Ready"] = { enable = true, spell = 14751, }, -- "Chakra"
		},	
		associatedSpell = 14751, -- "Chakra"
	},
	["Cure Disease"] = {
		tests = {
			["Spell Ready"] = { enable = true, spell = 528, }, -- "Cure Disease"
			["Debuff Type"] = { enable = true, unit = "player", hasDebuff = "Disease", },
		},
		associatedSpell = 528, -- "Cure Disease"
	},
	["Dispel Magic"] = {
		tests = {
			["Spell Ready"] = { enable = true, spell = 527, }, -- "Dispel Magic"
			["Debuff Type"] = { enable = true, unit = "player", hasDebuff = "Magic", },
		},	
		associatedSpell = 527, -- "Dispel Magic"
	},
	["Cure Poison"] = {
		tests = {
			["Player Status"] = { enable = true, checkTalent = true, talent = 64128, }, -- "Body and Soul"
			["Debuff Type"] = { enable = true, unit = "player", hasDebuff = "Poison", },
			["Spell Ready"] = { enable = true, spell = 528, }, -- "Cure Disease"
		},
		associatedSpell = 528, -- "Cure Disease"
	},
}
