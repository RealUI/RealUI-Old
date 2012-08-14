-- Paladin

local L = LibStub("AceLocale-3.0"):GetLocale("Raven")
local BUFF = true
local DEBUFF = false
local p = Raven.ColorPalette

Raven.classSpells.PALADIN = {
	{ "Ancient Crusader", BUFF, p.Purple3, id = 86701 }, -- Cataclysm level 85
	{ "Ancient Guardian", BUFF, p.Brown3, id = 86657 }, -- Cataclysm level 85
	{ "Ancient Healer", BUFF, p.Orange3, id = 86674 }, -- Cataclysm level 85
	{ "Ancient Power", BUFF, p.Brown3, id = 86700 }, -- Cataclysm level 85
	{ "Ardent Defender", BUFF, p.Brown2, cooldown = true, school = "Physical", id = 31850 },
	{ "Aura Mastery", BUFF, p.Orange1, cooldown = true, school = "Physical",id = 31821 },
	{ "Avenger's Shield", DEBUFF, p.Orange2, cooldown = true, school = "Holy", id = 31935 },
	{ "Avenging Wrath", BUFF, p.Yellow1, cooldown = true, school = "Holy", id = 31884 },
	{ "Beacon of Light", BUFF, p.Yellow1, school = "Holy", id = 53563 },
	{ "Blessing of Kings", BUFF, p.Blue1, school = "Holy", id = 20217 },
	{ "Blessing of Might", BUFF, p.Blue1, school = "Holy", id = 19740 },
	{ "Concentration Aura", BUFF, p.Purple1, school = "Holy", id = 19746 },
	{ "Consecration", DEBUFF, p.Yellow1, cooldown = true, school = "Holy", id = 26573 },
	{ "Conviction", BUFF, p.Orange3, school = "Physical", ids = { 20050, 20052, 20053 } },	
	{ "Crusader Aura", BUFF, p.Yellow1, school = "Holy", id = 32223 },	
	{ "Crusader Strike", nil, p.Yellow2, cooldown = true, shared = L["Crusader/Hammer"], school = "Physical", id = 35395 },
	{ "Daybreak", BUFF, p.Orange3, school = "Physical", id = 88819 },
	{ "Denounce", BUFF, p.Orange2, school = "Physical", id = 85509 },
	{ "Devotion Aura", BUFF, p.Blue1, school = "Holy", id = 465 },
	{ "Divine Favor", nil, p.Yellow2, cooldown = true, school = "Holy", id = 31842 },
	{ "Divine Guardian", BUFF, p.Yellow3, cooldown = true, school = "Holy", id = 70940 },
	{ "Divine Plea", BUFF, p.Yellow3, cooldown = true, school = "Holy", id = 54428 },
	{ "Divine Protection", BUFF, p.Yellow1, cooldown = true, school = "Holy", id = 498 },
	{ "Divine Shield", BUFF, p.Yellow1, cooldown = true, school = "Holy", id = 642 },
	{ "Divine Storm", nil, p.Yellow3, school = "Physical", id = 53385 },
	{ "Exorcism", nil, p.Orange2, school = "Holy", id = 879 },
	{ "Guarded by the Light", BUFF, p.Orange1, school = "Holy", ids = { 85646, 85639, 88063 } },
	{ "Guardian of Ancient Kings", BUFF, p.Yellow2, cooldown = true, school = "Holy", id = 86150 }, -- Cataclysm level 85
	{ "Hammer of Justice", DEBUFF, p.Cyan, cooldown = true, school = "Holy", id = 853 },
	{ "Hammer of the Righteous", nil, p.Yellow1, cooldown = true, shared = L["Crusader/Hammer"], school = "Holy", id = 53595 },
	{ "Hammer of Wrath", nil, p.Green3, cooldown = true, school = "Holy", id = 24275 },
	{ "Hand of Freedom", BUFF, p.Green1, cooldown = true, school = "Holy", id = 1044 },
	{ "Hand of Light", BUFF, p.Blue1, id = 90174 },
	{ "Hand of Protection", BUFF, p.Green1, cooldown = true, school = "Holy", id = 1022 },
	{ "Hand of Reckoning", DEBUFF, p.Yellow3, cooldown = true, school = "Holy", id = 62124 },
	{ "Hand of Sacrifice", BUFF, p.Green1, cooldown = true, school = "Holy", id = 6940 },
	{ "Hand of Salvation", BUFF, p.Green1, cooldown = true, school = "Holy", id = 1038 },
	{ "Holy Light", nil, p.Yellow1, school = "Holy", lockout = true, id = 635 },
	{ "Holy Power", BUFF, p.Green3, school = "Holy", id = 85247 },
	{ "Holy Radiance", BUFF, p.Yellow3, cooldown = true, school = "Holy", id = 82327 }, -- Cataclysm level 83
	{ "Holy Shield", BUFF, p.Yellow2, cooldown = true, school = "Holy", id = 20925 },
	{ "Holy Shock", nil, p.Yellow1, cooldown = true, school = "Holy", id = 20473 },
	{ "Holy Wrath", DEBUFF, p.Orange3, cooldown = true, school = "Holy", id = 2812 },
	{ "Illuminated Healing", BUFF, p.Blue3, id = 76669 },
	{ "Infusion of Light", BUFF, p.Yellow3, school = "Physical", id = 54149 },
	{ "Inquisition", BUFF, p.Yellow1, school = "Holy", id = 84963 }, -- Cataclysm level 81
	{ "Judgement", nil, p.Orange3, cooldown = true, school = "Holy", id = 20271 },
	{ "Judgements of the Bold", BUFF, p.Cyan, id = 89901 },
	{ "Judgements of the Just", DEBUFF, p.Orange2, id = 68055 },
	{ "Judgements of the Pure", BUFF, p.Green3, id = 54151 },
	{ "Judgements of the Wise", BUFF, p.Cyan, id = 31878 },
	{ "Lay on Hands", nil, p.Gray, cooldown = true, school = "Holy", id = 633 },
	{ "Light of Dawn", nil, p.Yellow1, cooldown = true, school = "Holy", id = 85222 },
	{ "Light's Beacon", BUFF, p.Yellow1, school = "Holy", id = 53651 },
	{ "Long Arm of the Law", BUFF, p.Red3, school = "Physical", id = 87173 },
	{ "Rebuke", DEBUFF, p.Brown3, cooldown = true, school = "Physical", id = 96231 },
	{ "Reckoning", BUFF, p.Orange1, school = "Physical", id = 20178 },
	{ "Repentance", DEBUFF, p.Brown2, cooldown = true, school = "Holy", id = 20066 },
	{ "Resistance Aura", BUFF, p.Orange2, school = "Holy", id = 19891 },
	{ "Retribution Aura", BUFF, p.Purple2, school = "Holy", id = 7294 },
	{ "Righteous Defense", nil, p.Brown2, cooldown = true, school = "Holy", id = 31789 },
	{ "Righteous Fury", BUFF, p.Red3, id = 25780 },
	{ "Sacred Duty", BUFF, p.Brown3, school = "Physical", id = 85433 },
	{ "Sacred Shield", BUFF, p.Yellow2, cooldown = true, school = "Physical", id = 85285 },
	{ "Seal of Insight", BUFF, p.Orange1, school = "Holy", id = 20165 },
	{ "Seal of Justice", BUFF, p.Orange2, school = "Holy", id = 20164 },
	{ "Seal of Righteousness", BUFF, p.Blue3, school = "Holy", id = 20154 },
	{ "Seal of Truth", BUFF, p.Yellow3, school = "Holy", id = 31801 },
	{ "Selfless Healer", BUFF, p.Yellow1, school = "Physical", id = 85804 },
	{ "Speed of Light", BUFF, p.Orange1, school = "Physical", id = 85499 },
	{ "The Art of War", BUFF, p.Green2, school = "Physical", id = 59578 },
	{ "Turn Evil", DEBUFF, p.Brown3, school = "Holy", id = 10326 },
	{ "Vindication", DEBUFF, p.Brown2, id = 26017 },
	{ "Word of Glory", nil, p.Yellow3, cooldown = true, school = "Holy", id = 85673 },
	{ "Zealotry", BUFF, p.Purple3, cooldown = true, school = "Holy", id = 85696 },
}

Raven.classConditions.PALADIN = {
	["Cleanse (Poison)"] = {	
		tests = {
			["Spell Ready"] = { enable = true, spell = 4987, }, -- "Cleanse"
			["Debuff Type"] = { enable = true, unit = "player", hasDebuff = "Poison", },
		},	
		associatedSpell = 4987, -- "Cleanse"
	},
	["Cleanse (Disease)"] = {	
		tests = {
			["Spell Ready"] = { enable = true, spell = 4987, }, -- "Cleanse"
			["Debuff Type"] = { enable = true, unit = "player", hasDebuff = "Disease", },
		},	
		associatedSpell = 4987, -- "Cleanse"
	},
	["Cleanse (Magic)"] = {	
		tests = {
			["Spell Ready"] = { enable = true, spell = 4987, }, -- "Cleanse"
			["Player Status"] = { enable = true, checkTalent = true, talent = 53551, }, -- "Sacred Cleansing"
			["Debuff Type"] = { enable = true, unit = "player", hasDebuff = "Magic", },
		},	
		associatedSpell = 4987, -- "Cleanse"
	},
	["Aura Missing"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false },
			["Any Buffs"] = { enable = true, toggle = true, unit = "player",
				auras = { 19746, 32223, 465, 19891, 7294 }, }, -- "Concentration Aura", "Crusader Aura", "Devotion Aura", "Resistance Aura", "Retribution Aura"
		},	
	},
	["Blessing Missing"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false, },
			["Spell Ready"] = { enable = true, spell = 19740 }, -- "Blessing of Might"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player",
				auras = { 19740, 20217 }, }, -- "Blessing of Might", "Blessing of Kings"
		},	
	},
	["Seal Missing"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false, },
			["Spell Ready"] = { enable = true, spell = 20154 }, -- "Seal of Righteousness"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player",
				auras = { 20164, 20165, 20154, 31801 }, }, -- "Seal of Justice", "Seal of Insight", "Seal of Righteousness", "Seal of Truth"
		},	
	},
	["Crusader Aura!"] = {
		tests = {
			["Player Status"] = { enable = true, inCombat = true, },
			["Any Buffs"] = { enable = true, unit = "player", isMine = true, auras = { 32223 }, }, -- "Crusader Aura"
		},	
		associatedSpell = 32223, -- "Crusader Aura"
	},
}
