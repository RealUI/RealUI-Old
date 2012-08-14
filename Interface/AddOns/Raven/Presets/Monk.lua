-- Monk

local L = LibStub("AceLocale-3.0"):GetLocale("Raven")
local BUFF = true
local DEBUFF = false
local p = Raven.ColorPalette

Raven.classSpells.MONK = {
	{ "Touch of Death", nil, p.Red1, cooldown = true, school = "Physical", id = 115080 },
}

Raven.classConditions.MONK = {
	["Legacy Buff Missing"] = {
		tests = {
			["Player Status"] = { enable = true, isResting = false, isMounted = false },
			["Spell Ready"] = { enable = true, spell = 115921 }, -- "Legacy of the Emperor"
			["Any Buffs"] = { enable = true, toggle = true, unit = "player",
				auras = { 115921, 116781 }, }, -- "Legacy of the Emperor", "Legacy of the White Tiger"
		},
		associatedSpell = 115921, -- "Legacy of the Emperor"
	},
}
