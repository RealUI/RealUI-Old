-- Warlock

local L = LibStub("AceLocale-3.0"):GetLocale("Raven")
local BUFF = true
local DEBUFF = false
local p = Raven.ColorPalette

Raven.classSpells.WARLOCK = {
	{ "Aftermath", DEBUFF, p.Orange1, school = "Physical", id = 18118 },
	{ "Backdraft", BUFF, p.Yellow1, school = "Physical", ids =  { 54274 , 54277 } },
	{ "Backlash", BUFF, p.Orange3, school = "Fire", id = 34936  },
	{ "Bane of Agony", DEBUFF, p.Orange3, school = "Shadow", id = 980 },
	{ "Bane of Doom", DEBUFF, p.Green2, school = "Shadow", id = 603 },
	{ "Bane of Havoc", DEBUFF, p.Red1, school = "Shadow", id = 80240  },
	{ "Banish", DEBUFF, p.Blue2, school = "Shadow", id = 710 },
	{ "Burning Embers", DEBUFF, p.Red2, school = "Physical", ids = { 91986, 85112 } },
	{ "Chaos Bolt", nil, p.Green3, cooldown = true, school = "Fire", id = 50796 },
	{ "Conflagrate", nil, p.Yellow2, cooldown = true, school = "Fire", id = 17962 },
	{ "Corruption", DEBUFF, p.Red3, school = "Shadow", id = 172 },
	{ "Curse of Exhaustion", DEBUFF, p.Gray, school = "Shadow", id = 18223 },
	{ "Curse of Gul'dan", DEBUFF, p.Orange1, school = "Fire", id = 86000 },
	{ "Curse of the Elements", DEBUFF, p.Purple1, school = "Shadow", id = 1490 },
	{ "Curse of Tongues", DEBUFF, p.Orange1, school = "Shadow", id = 1714 },
	{ "Curse of Weakness", DEBUFF, p.Green3, school = "Shadow", id = 702 },
	{ "Dark Intent", BUFF, p.Purple3, school = "Shadow", id = 85767 }, -- Cataclysm level 83
	{ "Death Coil", DEBUFF, p.Yellow3, cooldown = true, school = "Shadow", id = 6789 },
	{ "Death's Embrace", BUFF, p.Purple1, school = "Physical", ids = { 47198, 47199, 47200 } }, 
	{ "Decimation", BUFF, p.Orange1, school = "Physical", ids = { 63165, 63167 } },
	{ "Demon Armor", BUFF, p.Pink, school = "Shadow", id = 687 },
	{ "Demon Soul", BUFF, p.Purple1, school = "Shadow", id = 77801 }, -- Cataclysm level 85
	{ "Demon Soul: Imp", BUFF, p.Purple1, school = "Shadow", id = 79459 }, -- Cataclysm level 85
	{ "Demon Soul: Voidwalker", BUFF, p.Purple1, school = "Shadow", id = 79464 }, -- Cataclysm level 85
	{ "Demon Soul: Succubus", BUFF, p.Purple1, school = "Shadow", id = 79463 }, -- Cataclysm level 85
	{ "Demon Soul: Felhunter", BUFF, p.Purple1, school = "Shadow", id = 79460 }, -- Cataclysm level 85
	{ "Demon Soul: Felguard", BUFF, p.Purple1, school = "Shadow", id = 79462 }, -- Cataclysm level 85
	{ "Demonic Circle: Summon", BUFF, p.Green3, school = "Shadow", id = 48018 },
	{ "Demonic Circle: Teleport", nil, p.Green3, cooldown = true, school = "Shadow", id = 48020 },
	{ "Demonic Empowerment", BUFF, p.Orange2, cooldown = true, school = "Shadow", id = 47193 },
	{ "Demonic Rebirth", BUFF, p.Red3, school = "Physical", id = 88448 },
	{ "Drain Life", DEBUFF, p.Green1, school = "Shadow", id = 89420 },
	{ "Drain Soul", DEBUFF, p.Blue3, school = "Shadow", id = 1120 },
	{ "Enpowered Imp", BUFF, p.Brown2, school = "Physical", ids = { 47220, 47221 } },
	{ "Enslave Demon", DEBUFF, p.Cyan, school = "Shadow", id = 1098 },
	{ "Eradication", BUFF, p.Purple2, school = "Physical", ids = { 64368, 64370, 64371 } },
	{ "Eye of Kilrogg", BUFF, p.Brown1, school = "Shadow", id = 126 },
	{ "Fear", DEBUFF, p.Gray, school = "Shadow", id = 5782 },
	{ "Fel Armor", BUFF, p.Green1, school = "Shadow", id = 28176 },
	{ "Fel Domination", nil, p.Pink, cooldown = true, school = "Shadow", id = 18708 },
	{ "Hand of Gul'dan", nil, p.Orange1, cooldown = true, school = "Fire", id = 71521 },
	{ "Haunt", DEBUFF, p.Purple3, cooldown = true, school = "Shadow", id = 48181 },
	{ "Health Funnel", BUFF, p.Red2, school = "Shadow", id = 755 },
	{ "Hellfire", BUFF, p.Orange1, school = "Fire", id = 85403 },
	{ "Howl of Terror", DEBUFF, p.Yellow2, cooldown = true, school = "Shadow", id = 5484 },
	{ "Immolate", DEBUFF, p.Orange2, school = "Fire", id = 348 },
	{ "Improved Soul Fire", BUFF, p.Orange3, school = "Physical", id = 18119 },
	{ "Infernal Awakening", DEBUFF, p.Cyan, school = "Fire", id = 22703 },
	{ "Jinx", DEBUFF, p.Pink, school = "Shadow", id = 85479 },
	{ "Jinx: Curse of the Elements", DEBUFF, p.Pink, school = "Physical", id = 86105 },
	{ "Master Demonologist", BUFF, p.Purple3, school = "Physical", id = 77219 },
	{ "Metamorphosis", BUFF, p.Purple1, cooldown = true, school = "Physical", id = 47241 },
	{ "Molten Core", BUFF, p.Orange1, school = "Physical", ids = { 47246, 71162, 71165  } },
	{ "Nether Protection", BUFF, p.Green3, school = "Physical", ids = { 30299, 30301 } },
	{ "Nether Ward", BUFF, p.Green1, cooldown = true, school = "Shadow", id = 91711 },
	{ "Nightmare", DEBUFF, p.Purple1, school = "Physical", ids = { 53754, 53759 } }, -- from Improved Fear talent
	{ "Rain of Fire", DEBUFF, p.Red2, school = "Fire", id = 5740},
	{ "Ritual of Souls", nil, p.Purple1, cooldown = true, school = "Shadow", id = 29893 },
	{ "Ritual of Summoning", nil, p.Purple3, cooldown = true, school = "Shadow", id = 698 },
	{ "Searing Pain", nil, p.Red1, school = "Fire", lockout = true, id = 5676 },
	{ "Seed of Corruption", DEBUFF, p.Purple2, school = "Shadow", id = 27243 },
	{ "Shadow Bolt", nil, p.Purple3, school = "Shadow", lockout = true, id = 686 },
	{ "Shadow Embrace", BUFF, p.Blue3, school = "Physical", ids = { 32388, 32389 } },
	{ "Shadow Mastery", DEBUFF, p.Orange1, school = "Shadow", id = 17800 }, -- from Shadow and Flame talent
	{ "Shadow Trance", BUFF, p.Purple3, school = "Shadow", id = 17941 }, -- from Nightfall talent
	{ "Shadow Ward", BUFF, p.Purple2, cooldown = true, school = "Shadow", id = 6229 },
	{ "Shadowburn", DEBUFF, p.Gray, cooldown = true, school = "Shadow", id = 17877 },
	{ "Shadowflame", DEBUFF, p.Purple3, cooldown = true, school = "Shadow", id = 47897 },
	{ "Shadowfury", DEBUFF, p.Purple2, cooldown = true, school = "Shadow", id = 30283 },
	{ "Soul Harvest", BUFF, p.Purple3, cooldown = true, school = "Shadow", id = 79268 },
	{ "Soul Link", BUFF, p.Gray, school = "Shadow", id = 19028 },
	{ "Soul Swap", nil, p.Pink, cooldown = true, school = "Shadow", id = 86121 },
	{ "Soulburn", nil, p.Purple1, cooldown = true, school = "Shadow", id = 74434 },
	{ "Soulshatter", nil, p.Cyan, cooldown = true, school = "Shadow", id = 29858 },
	{ "Soulstone Resurrection", BUFF, p.Red3, id = 20707 },
	{ "Summon Infernal", nil, p.Green3, cooldown = true, shared = L["Summon Infernal/Doomguard"], school = "Shadow", id = 1122 },
	{ "Summon Doomguard", nil, p.Red3, cooldown = true, shared = L["Summon Infernal/Doomguard"], school = "Shadow", id = 18540 },
	{ "Unstable Affliction", DEBUFF, p.Yellow1, school = "Shadow", id = 30108 },
	{ "Unending Breath", BUFF, p.Blue1, school = "Shadow", id = 5697 },
	-- Metamorphosis
	{ "Demon Leap", nil, p.Brown2, cooldown = true, school = "Physical", id = 54785 },
	{ "Demon Soul", BUFF, p.Red3, cooldown = true, school = "Shadow", id = 77801 },
	{ "Immolation Aura", BUFF, p.Orange1, cooldown = true, school = "Fire", id = 50589 },
}

Raven.classConditions.WARLOCK = {
	["Armor Missing"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false, isFishing = false },
			["Any Buffs"] = { enable = true, toggle = true, unit = "player", auras = { 687, 28176 }, }, -- "Demon Armor", "Fel Armor"
		},	
		associatedSpell = 28176, -- "Fel Armor"
	},
	["No Pet!"] = {
		tests = {
			["Player Status"] = { enable = true, inCombat = true, hasPet = false },
		},	
	},
	["Soul Link Missing"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false, isFishing = false, hasPet = true },
			["Spell Ready"] = { enable = true, spell = 19028 }, -- "Soul Link"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player", auras = { 19028 }, }, -- "Soul Link"
		},	
		associatedSpell = 19028, -- "Soul Link"
	},
}
