-- Rogue

local BUFF = true
local DEBUFF = false
local p = Raven.ColorPalette

Raven.classSpells.ROGUE = {
	{ "Adrenaline Rush", BUFF, p.Orange1, cooldown = true, school = "Physical", id = 13750 },
	{ "Blade Flurry", BUFF, p.Orange3, cooldown = true, school = "Physical", id = 13877 },
	{ "Blade Twisting", DEBUFF, p.Cyan, school = "Physical", id = 31125 } ,
	{ "Blind", DEBUFF, p.Gray, cooldown = true, school = "Physical", id = 2094 },
	{ "Cheap Shot", DEBUFF, p.Blue3, school = "Physical", id = 1833 },
	{ "Cloak of Shadows", BUFF, p.Purple1, cooldown = true, school = "Physical", id = 31224 },
	{ "Cold Blood", BUFF, p.Green3, cooldown = true, school = "Physical", id = 14177 },
	{ "Combat Insight", BUFF, p.Orange3, school = "Physical", id = 74002 },
	{ "Combat Readiness", BUFF, p.Orange3, cooldown = true, school = "Physical", id = 74001 }, -- Cataclysm level 81
	{ "Deadly Throw", DEBUFF, p.Purple1, school = "Physical", id = 26679 },
	{ "Deep Insight", BUFF, p.Orange3, school = "Physical", id = 84747 },
	{ "Dismantle", DEBUFF, p.Yellow3, cooldown = true, school = "Physical", id = 51722 },
	{ "Distract", nil, p.Orange2, cooldown = true, school = "Physical", id = 1725 },
	{ "Envenom", BUFF, p.Green3, school = "Physical", id = 32645 },
	{ "Evasion", BUFF, p.Purple1, cooldown = true, school = "Physical", id = 5277 },
	{ "Eviscerate", nil, p.Red3, school = "Physical", id = 2098 },
	{ "Expose Armor", DEBUFF, p.Purple2, school = "Physical", id = 8647 },
	{ "Fan of Knives", nil, p.Purple1, school = "Physical", id = 51723 },
	{ "Feint", BUFF, p.Purple1, cooldown = true, school = "Physical", id = 1966 },
	{ "Garrote", DEBUFF, p.Red2, school = "Physical", id = 703 },
	{ "Garrote - Silence", DEBUFF, p.Red2, school = "Physical", id = 1330 },
	{ "Gouge", DEBUFF, p.Red1, cooldown = true, school = "Physical", id = 1776 },
	{ "Hemorrhage", DEBUFF, p.Red3, school = "Physical", id = 16511 },
	{ "Honor Among Thieves", BUFF, p.Green3, school = "Physical", id = 51699 },
	{ "Kick", DEBUFF, p.Gray, cooldown = true, school = "Physical", id = 1766 },
	{ "Kidney Shot", DEBUFF, p.Yellow3, cooldown = true, school = "Physical", id = 408 },
	{ "Killing Spree", BUFF, p.Yellow3, cooldown = true, school = "Physical", id = 51690 },
	{ "Master Poisoner", DEBUFF, p.Green1, school = "Physical", id = 58410 },
	{ "Moderate Insight", BUFF, p.Orange3, school = "Physical", id = 84746 },
	{ "Overkill", BUFF, p.Red3, school = "Physical", id = 58426 },
	{ "Premeditation", nil, p.Purple1, cooldown = true, school = "Physical", id = 14183 },
	{ "Preparation", nil, p.Purple1, cooldown = true, school = "Physical", id = 14185 },
	{ "Recuperate", BUFF, p.Green2, school = "Physical", id = 73651 },
	{ "Redirect", nil, p.Orange2, cooldown = true, school = "Physical", id = 73981 }, -- Cataclysm level 83
	{ "Revealing Strike", DEBUFF, p.Brown3, school = "Physical", id = 84617 },
	{ "Riposte", DEBUFF, p.Red2, cooldown = true, school = "Physical", id = 14251 },
	{ "Rupture", DEBUFF, p.Red1, school = "Physical", id = 1943 },
	{ "Sap", DEBUFF, p.Orange3,  school = "Physical", id = 6770 },
	{ "Shadow Dance", BUFF, p.Blue3, cooldown = true, school = "Physical", id = 51713 },
	{ "Shadowstep", BUFF, p.Purple3, cooldown = true, school = "Physical", ids = { 36563, 36554 } },
	{ "Shallow Insight", BUFF, p.Orange3, school = "Physical", id = 84745 },
	{ "Shiv", nil, p.Green3, school = "Physical", id = 5938 },
	{ "Sinister Strike", nil, p.Purple2, school = "Physical", id = 1752 },
	{ "Silenced - Improved Kick", DEBUFF, p.Brown3, id = 18425 },
	{ "Slice and Dice", BUFF, p.Orange3, school = "Physical", id = 5171 },
	{ "Smoke Bomb", DEBUFF, p.Gray, cooldown = true, school = "Physical", id = 76577 }, -- Cataclysm level 85
	{ "Sprint", BUFF, p.Orange1, cooldown = true, school = "Physical", id = 2983 },
	{ "Stealth", BUFF, p.Blue2, cooldown = true, school = "Physical", id = 1784 },
	{ "Tricks of the Trade", BUFF, p.Red3, cooldown = true, school = "Physical", id = 57934 },
	{ "Vanish", BUFF, p.Gray, cooldown = true, school = "Physical", id = 1856 },
	{ "Vendetta", DEBUFF, p.Purple2, cooldown = true, school = "Physical", id = 79140 },
	{ "Waylay", DEBUFF, p.Yellow1, school = "Physical", id = 51693 },
	-- Poisons --
	{ "Crippling Poison", DEBUFF, p.Brown3, id = 44289 },
	{ "Deadly Poison", DEBUFF, p.Green3, id = 72330 },
	{ "Instant Poison", DEBUFF, p.Green2, id = 59242},
	{ "Mind-Numbing Poison", DEBUFF, p.Gray, id = 5760 },
	{ "Wound Poison", DEBUFF, p.Orange2, id = 65962 },
}

Raven.classConditions.ROGUE = {
	["Mainhand Poison Missing"] = {
		name = "Mainhand Poison Missing", enabled = true, notify = true,
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false, isFishing = false,
									hasMainHand = true, levelMainHand = 1, checkLevel = true, level = 20 },
			["Buff Type"] = { enable = true, hasBuff = "Mainhand", toggle = true },
		},	
	},
	["Offhand Poison Missing"] = {
		name = "Offhand Poison Missing", enabled = true, notify = true,
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false, isFishing = false,
									hasOffHand = true, levelOffHand = 1, checkLevel = true, level = 20 },
			["Buff Type"] = { enable = true, hasBuff = "Offhand", toggle = true },
		},	
	},
	["Ranged Poison Missing"] = {
		name = "Ranged Poison Missing", enabled = true, notify = true,
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false, isFishing = false,
									hasRanged = true, levelRanged = 1, checkLevel = true, level = 20 },
			["Buff Type"] = { enable = true, hasBuff = "Ranged", toggle = true },
		},
	},
}
