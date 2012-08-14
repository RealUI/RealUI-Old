-- Warrior

local L = LibStub("AceLocale-3.0"):GetLocale("Raven")
local BUFF = true
local DEBUFF = false
local p = Raven.ColorPalette

Raven.classSpells.WARRIOR = {
	{ "Battle Shout", BUFF, p.Yellow3, cooldown = true, shared = L["Shouts"], school = "Physical", id = 6673 },
	{ "Battle Stance", BUFF, p.Red3, school = "Physical", id = 2457 },
	{ "Battle Trance", BUFF, p.Blue3, school = "Physical", id = 12964 },
	{ "Berserker Rage", BUFF, p.Orange2, cooldown = true, school = "Physical", id = 18499 },
	{ "Berserker Stance", BUFF, p.Cyan, school = "Physical", id = 2458 },
	{ "Bladestorm", BUFF, p.Orange3, cooldown = true, school = "Physical", id = 46924 },
	{ "Blood Craze", BUFF, p.Orange1, school = "Physical", ids = { 16488, 16490, 16491 } },
	{ "Bloodsurge", BUFF, p.Green3, school = "Physical", id = 46916 },
	{ "Bloodthirst", BUFF, p.Red2, cooldown = true, school = "Physical", id = 23881 },
	{ "Challenging Shout", DEBUFF, p.Brown1, cooldown = true, school = "Physical", id = 1161 },
	{ "Charge", nil, p.Red1, cooldown = true, school = "Physical", id = 100 },
	{ "Charge Stun", DEBUFF, p.Cyan, ids = { 7922, 65929 } },
	{ "Cleave", nil, p.Green2, cooldown = true, school = "Physical", id = 845 },
	{ "Colossus Smash", DEBUFF, p.Brown3, cooldown = true, school = "Physical", id = 86346 }, -- Cataclysm level 81
	{ "Commanding Shout", BUFF, p.Orange3, cooldown = true, shared = L["Shouts"], school = "Physical", id = 469 },
	{ "Concussion Blow", DEBUFF, p.Gray, cooldown = true, school = "Physical", id = 12809 },
	{ "Deadly Calm", BUFF, p.Brown1, cooldown = true, school = "Physical", id = 85730 },
	{ "Death Wish", BUFF, p.Orange3, cooldown = true, school = "Physical", id = 12292 },
	{ "Deep Wounds", DEBUFF, p.Red1, school = "Physical", ids = { 12162, 12850, 12868 } },
	{ "Defensive Stance", BUFF, p.Gray, school = "Physical", id = 71 },
	{ "Demoralizing Shout", DEBUFF, p.Green3, school = "Physical", id = 1160 },
	{ "Die by the Sword", BUFF, p.Orange2, school = "Physical", ids = { 85386, 86624 } },
	{ "Disarm", DEBUFF, p.Brown2, cooldown = true, school = "Physical", id = 676 },
	{ "Enrage", BUFF, p.Purple3, school = "Physical", id = 14202 },
	{ "Enraged Regeneration", BUFF, p.Red3, cooldown = true, school = "Physical", id = 55694 },
	{ "Executioner", BUFF, p.Red2, school = "Physical", id = 90806 },
	{ "Flurry", BUFF, p.Red2, school = "Physical", ids = { 12966, 12967, 12968 } },
	{ "Furious Attacks", DEBUFF, p.Yellow3, school = "Physical", id = 56112 },
	{ "Hamstring", DEBUFF, p.Yellow2, school = "Physical", id = 1715 },
	{ "Heroic Fury", nil, p.Orange1, cooldown = true, school = "Physical", id = 60970 },
	{ "Heroic Leap", nil, p.Red3, cooldown = true, school = "Physical", id = 6544 }, -- Cataclysm level 85
	{ "Heroic Strike", nil, p.Orange2, cooldown = true, school = "Physical", id = 78 },
	{ "Heroic Throw", nil, p.Purple3, cooldown = true, school = "Physical", id = 57755 },
	{ "Improved Hamstring", DEBUFF, p.Yellow3, school = "Physical", id = 12668 },
	{ "Incite", BUFF, p.Brown2, school = "Physical", id = 86627 },
	{ "Inner Rage", BUFF, p.Orange1, cooldown = true, school = "Physical", id = 1134 }, -- Cataclysm level 83
	{ "Intercept", DEBUFF, p.Orange3, cooldown = true, school = "Physical", id = 20252 },
	{ "Intervene", BUFF, p.Yellow1, cooldown = true, school = "Physical", id = 3411 },
	{ "Intimidating Shout", DEBUFF, p.Purple2, cooldown = true, school = "Physical", id = 5246 },
	{ "Juggernaut", BUFF, p.Brown3, school = "Physical", id = 65156 },
	{ "Last Stand", BUFF, p.Brown1, cooldown = true, school = "Physical", id = 12975 },
	{ "Meat Cleaver", BUFF, p.Brown1, school = "Physical", ids = { 85738, 85739 } },
	{ "Mortal Strike", DEBUFF, p.Blue3, cooldown = true, school = "Physical", id = 12294 },
	{ "Overpower", nil, p.Yellow3, school = "Physical", id = 7384 },
	{ "Piercing Howl", DEBUFF, p.Brown3, school = "Physical", id = 12323 },
	{ "Pummel", DEBUFF, p.Brown2, cooldown = true, shared = L["Pummel/Shield Bash"], school = "Physical", id = 6552 },
	{ "Raging Blow", nil, p.Red1, cooldown = true, school = "Physical", id = 85288 },
	{ "Rallying Cry", BUFF, p.Blue3, cooldown = true, school = "Physical", id = 97462 }, -- patch 4.1
	{ "Rampage", BUFF, p.Red2, school = "Physical", id = 29801 },
	{ "Recklessness", BUFF, p.Red2, cooldown = true, school = "Physical", id = 1719 },
	{ "Rend", DEBUFF, p.Red1, school = "Physical", id = 94009 },
	{ "Retaliation", BUFF, p.Orange2, cooldown = true, school = "Physical", id = 20230 },
	{ "Revenge", nil, p.Brown3, cooldown = true, school = "Physical", id = 6572 },
	{ "Rude Interruption", BUFF, p.Red2, school = "Physical", ids = { 86662, 86663 } },
	{ "Safeguard", BUFF, p.Yellow2, school = "Physical", ids = { 46946, 46947 } },
	{ "Second Wind", BUFF, p.Pink, school = "Physical", ids = { 29834, 29838 } },
	{ "Shattering Throw", DEBUFF, p.Green2, cooldown = true, school = "Physical", id = 64382 },
	{ "Shield Bash", nil, p.Brown3, cooldown = true, shared = L["Pummel/Shield Bash"], school = "Physical", id = 72 },
	{ "Shield Block", BUFF, p.Blue3, cooldown = true, school = "Physical", id = 2565 },
	{ "Shield Slam", nil, p.Yellow3, cooldown = true, school = "Physical", id = 23922 },
	{ "Shield Wall", BUFF, p.Purple3, cooldown = true, school = "Physical", id = 871 },
	{ "Shockwave", DEBUFF, p.Cyan, cooldown = true, school = "Physical", id = 46968 },
	{ "Silenced - Gag Order", DEBUFF, p.Brown2, ids = { 74347, 18498 } }, -- from Gag Order talent
	{ "Slaughter", BUFF, p.Green3, ids = { 84584, 84585, 84586 } }, -- proc from Lambs to the Slaughter
	{ "Spell Reflection", BUFF, p.Gray, cooldown = true, school = "Physical", id = 23920 },
	{ "Strike", nil, p.Brown3, cooldown = true, school = "Physical", id = 88161 },
	{ "Sunder Armor", DEBUFF, p.Brown1, school = "Physical", id = 58567 }, -- also from Devastate
	{ "Sweeping Strikes", BUFF, p.Orange3, cooldown = true, school = "Physical", id = 12328 },
	{ "Sword and Board", BUFF, p.Yellow3, school = "Physical", id = 50227 },
	{ "Taste for Blood", BUFF, p.Yellow2, school = "Physical", id = 60503 },
	{ "Taunt", nil, p.Orange1, cooldown = true, school = "Physical", id = 355 },
	{ "Throwdown", DEBUFF, p.Gray, cooldown = true, school = "Physical", id = 85388 },
	{ "Thunder Clap", DEBUFF, p.Green3, cooldown = true, school = "Physical", id = 6343 },
	{ "Thunderstruck", BUFF, p.Blue1, school = "Physical", ids = { 87095, 87096 } },
	{ "Trauma", DEBUFF, p.Red, school = "Physical", id = 46857 },
	{ "Vengeance", BUFF, p.Purple2, school = "Physical", id = 93098 },
	{ "Victorious", BUFF, p.Orange2, school = "Physical", id = 32216 },
	{ "Vigilance", BUFF, p.Purple3, school = "Physical", id = 50720 },
	{ "Whirlwind", nil, p.Blue2, cooldown = true, school = "Physical", id = 1680 },
}

Raven.classConditions.WARRIOR = {
	["Battle Shout!"] = {
		tests = {
			["Player Status"] = { enable = true, inCombat = true },
			["Spell Ready"] = { enable = true, spell = 6673, }, -- "Battle Shout"
			["All Buffs"] = { enable = true, toggle = true, unit = "player", isMine = true, auras = { 469 }, }, -- "Commanding Shout"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player",
				auras = { 57330, 8076, 6673, 93435 }, }, -- "Horn of Winter", "Strength of Earth", "Battle Shout", "Roar of Courage"
		},
		dependencies = { ["Commanding Shout!"] = false },
		associatedSpell = 6673, -- "Battle Shout"
	},
	["Commanding Shout!"] = {
		tests = {
			["Player Status"] = { enable = true, inCombat = true, checkStance = true, stance = 71 }, -- "Defensive Stance"
			["Spell Ready"] = { enable = true, spell = 469 }, -- "Commanding Shout"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player",
				auras = { 469, 21562, 6307 }, }, -- "Commanding Shout", "Power Word: Fortitude", "Blood Pact"
		},	
		associatedSpell = 469, -- "Commanding Shout"
	},
}
