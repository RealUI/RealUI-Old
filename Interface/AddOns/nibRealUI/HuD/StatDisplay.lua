local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local L = LibStub("AceLocale-3.0"):GetLocale("nibRealUI")
local db, dbc, ndbc

local mass
if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local _
local MODNAME = "StatDisplay"
local StatDisplay = nibRealUI:NewModule(MODNAME, "AceEvent-3.0", "AceTimer-3.0")

local strform = string.format

local Stats = {
	[1] = "Dodge",
	[2] = "Parry",
	[3] = "Block",
	[4] = "Armor_Defense",
	[5] = "Defense_Mastery",
	
	[6] = "Melee_Haste",
	[7] = "Melee_Hit",
	[8] = "Melee_AP",
	[9] = "Melee_Crit",
	[10] = "Expertise",
	[11] = "Melee_Armor_Pen",
	[12] = "Weapon_Speed",
	[13] = "Melee_Mastery",
	
	[14] = "Dmg_Reduction",
	[15] = "Total_Resilience",
	[16] = "Total_PvPPower",
	
	[17] = "Range_Haste",
	[18] = "Range_Hit",
	[19] = "Range_Armor_Pen",
	[20] = "Range_AP",
	[21] = "Range_Crit",
	[22] = "Range_Speed",
	[23] = "Range_Mastery",
	
	[24] = "Spell_Power",
	[25] = "Spell_Crit",
	[26] = "Spell_Haste",
	[27] = "Spell_Hit",
	[28] = "MP5",
	[29] = "Spell_Mastery",
}
local StatTexts = {
	[1] = PLAYERSTAT_DEFENSES..": "..STAT_DODGE,
	[2] = PLAYERSTAT_DEFENSES..": "..STAT_PARRY,
	[3] = PLAYERSTAT_DEFENSES..": "..STAT_BLOCK,
	[4] = PLAYERSTAT_DEFENSES..": "..ARMOR,
	[5] = PLAYERSTAT_DEFENSES..": "..STAT_MASTERY,
	
	[6] = PLAYERSTAT_MELEE_COMBAT..": "..STAT_HASTE,
	[7] = PLAYERSTAT_MELEE_COMBAT..": "..STAT_HIT_CHANCE,
	[8] = PLAYERSTAT_MELEE_COMBAT..": "..STAT_ATTACK_POWER,
	[9] = PLAYERSTAT_MELEE_COMBAT..": "..MELEE_CRIT_CHANCE,
	[10] = PLAYERSTAT_MELEE_COMBAT..": "..STAT_EXPERTISE,
	[11] = PLAYERSTAT_MELEE_COMBAT..": "..ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT,
	[12] = PLAYERSTAT_MELEE_COMBAT..": "..WEAPON_SPEED,
	[13] = PLAYERSTAT_MELEE_COMBAT..": "..STAT_MASTERY,
	
	[14] = PVP.." "..COMBAT_TEXT_SHOW_RESISTANCES_TEXT,
	[15] = RESILIENCE,
	[16] = STAT_PVP_POWER,
	
	[17] = PLAYERSTAT_RANGED_COMBAT..": "..STAT_HASTE,
	[18] = PLAYERSTAT_RANGED_COMBAT..": "..STAT_HIT_CHANCE,
	[19] = PLAYERSTAT_RANGED_COMBAT..": "..ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT,
	[20] = PLAYERSTAT_RANGED_COMBAT..": "..STAT_ATTACK_POWER,
	[21] = PLAYERSTAT_RANGED_COMBAT..": "..RANGED_CRIT_CHANCE,
	[22] = PLAYERSTAT_RANGED_COMBAT..": "..WEAPON_SPEED,
	[23] = PLAYERSTAT_RANGED_COMBAT..": "..STAT_MASTERY,
	
	[24] = PLAYERSTAT_SPELL_COMBAT..": "..STAT_SPELLPOWER,
	[25] = PLAYERSTAT_SPELL_COMBAT..": "..SPELL_CRIT_CHANCE,
	[26] = PLAYERSTAT_SPELL_COMBAT..": "..STAT_HASTE,
	[27] = PLAYERSTAT_SPELL_COMBAT..": "..STAT_HIT_CHANCE,
	[28] = PLAYERSTAT_SPELL_COMBAT..": "..MANA_REGEN,
	[29] = PLAYERSTAT_SPELL_COMBAT..": "..STAT_MASTERY,
}

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Stat Display",
		arg = MODNAME,
		childGroups = "tab",
		order = 1920,
		args = {
			header = {
				type = "header",
				name = "Stat Display",
				order = 10,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Stat Display module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
					nibRealUI:ReloadUIDialog()
				end,
				order = 30,
			},
			gap1 = {
				name = " ",
				type = "description",
				order = 31,
			},
			color = {
				type = "color",
				name = "Text Color",
				get = function(info,r,g,b)
					return db.color.r, db.color.g, db.color.b
				end,
				set = function(info,r,g,b)
					db.color.r = r
					db.color.g = g
					db.color.b = b
				end,
				order = 40,
			},
			smallfont = {
				type = "toggle",
				name = "Use Small Font",
				get = function() return db.smallfont end,
				set = function(info, value) 
					db.smallfont = value
				end,
				order = 50,
			},
			gap2 = {
				name = " ",
				type = "description",
				order = 51,
			},
			gap3 = {
				name = " ",
				type = "description",
				order = 52,
			},
			primary = {
				type = "group",
				inline = true,
				name = PRIMARY,
				disabled = function() return not(nibRealUI:GetModuleEnabled(MODNAME)) end,
				order = 60,
				args = {
					stat1 = {
						type = "select",
						name = "Stat 1",
						set = function(info, value)
							dbc.stats[1][1] = Stats[value]
							StatDisplay:TalentUpdate()
						end,
						style = "dropdown",
						width = nil,
						values = StatTexts,
						order = 10,
					},
					stat1name = {
						name = function()
							for k,v in pairs(Stats) do
								if v == dbc.stats[1][1] then
									return StatTexts[k]
								end
							end
						end,
						type = "description",
						order = 20,
					},
					gap1 = {
						name = " ",
						type = "description",
						order = 21,
					},
					stat2 = {
						type = "select",
						name = "Stat 2",
						set = function(info, value)
							dbc.stats[1][2] = Stats[value]
							StatDisplay:TalentUpdate()
						end,
						style = "dropdown",
						width = nil,
						values = StatTexts,
						order = 30,
					},
					stat2name = {
						name = function()
							for k,v in pairs(Stats) do
								if v == dbc.stats[1][2] then
									return StatTexts[k]
								end
							end
						end,
						type = "description",
						order = 40,
					},
				},
			},
			gap2 = {
				name = " ",
				type = "description",
				order = 61,
			},
			secondary = {
				type = "group",
				inline = true,
				name = SECONDARY,
				disabled = function() return not(nibRealUI:GetModuleEnabled(MODNAME)) end,
				order = 70,
				args = {
					stat1 = {
						type = "select",
						name = "Stat 1",
						set = function(info, value)
							dbc.stats[2][1] = Stats[value]
							StatDisplay:TalentUpdate()
						end,
						style = "dropdown",
						width = nil,
						values = StatTexts,
						order = 10,
					},
					stat1name = {
						name = function()
							for k,v in pairs(Stats) do
								if v == dbc.stats[2][1] then
									return StatTexts[k]
								end
							end
						end,
						type = "description",
						order = 20,
					},
					gap1 = {
						name = " ",
						type = "description",
						order = 21,
					},
					stat2 = {
						type = "select",
						name = "Stat 2",
						set = function(info, value)
							dbc.stats[2][2] = Stats[value]
							StatDisplay:TalentUpdate()
						end,
						style = "dropdown",
						width = nil,
						values = StatTexts,
						order = 30,
					},
					stat2name = {
						name = function()
							for k,v in pairs(Stats) do
								if v == dbc.stats[2][2] then
									return StatTexts[k]
								end
							end
						end,
						type = "description",
						order = 40,
					},
				},
			},
		},
	}
	end
	return options
end

local InCombat
local watchedStats = {}
local StatFunc = {}
-----------------
---- Defense ----
-----------------
StatFunc.Dodge = function()
	local Total_Dodge = GetDodgeChance()
	return strform("%.2f%%", Total_Dodge)
end

StatFunc.Parry = function()
	local Total_Parry = GetParryChance()
	return strform("%.2f%%", Total_Parry)
end

StatFunc.Block = function()
	local Total_Block = GetBlockChance()
	return strform("%.2f%%", Total_Block)
end

StatFunc.Armor_Defense = function()
	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor("player")
	local Melee_Reduction = effectiveArmor
	return nibRealUI:ReadableNumber(Melee_Reduction)
end

StatFunc.Defense_Mastery = function()
	local Total_DM = GetMasteryEffect("player")
	return strform("%.2f%%", Total_DM)
end

---------------
---- Melee ----
---------------
StatFunc.Melee_Haste = function()
	local Total_Melee_Haste = GetMeleeHaste("player")
	return strform("%.2f%%", Total_Melee_Haste)
end

StatFunc.Melee_Hit = function()
	local Total_Hit = GetCombatRatingBonus("6")
	return strform("%.2f%%", Total_Hit)
end

StatFunc.Melee_AP = function()
	local base, posBuff, negBuff = UnitAttackPower("player")
	local Melee_AP = base + posBuff + negBuff
	return nibRealUI:ReadableNumber(Melee_AP)
end

StatFunc.Melee_Crit = function()
	local Melee_Crit = GetCritChance("player")
	return strform("%.2f%%", Melee_Crit)
end

StatFunc.Expertise = function()
	local Expertise = GetCombatRatingBonus("24")
	return strform("%.2f%%", Expertise)
end

StatFunc.Melee_Armor_Pen = function()
	local Melee_Armor_Pen = GetCombatRatingBonus("25")
	return strform("%.2f%%", Melee_Armor_Pen)
end

StatFunc.Weapon_Speed = function()
	local mainSpeed, offSpeed = UnitAttackSpeed("player");
	local MH = mainSpeed
	local OH = offSpeed
	return strform("%.2f", MH)
end

StatFunc.Melee_Mastery = function()
	local Total_MM = GetMasteryEffect("player");
	return strform("%.2f%%", Total_MM)
end

-------------
---- PvP ----
-------------
StatFunc.Dmg_Reduction = function()
	local PvPDmg = GetCombatRatingBonus("16") + 40
	return strform("-%.2f%%", PvPDmg)
end

StatFunc.Total_Resilience = function()
	local Total_Resil = GetCombatRating("16")
	return nibRealUI:ReadableNumber(Total_Resil)
end

StatFunc.Total_PvPPower = function()
	local PvPPower = GetCombatRatingBonus("27")
	return strform("%.2f%%", PvPPower)
end

---------------
---- Range ----
---------------
StatFunc.Range_Haste = function()
	local Total_Range_Haste = GetRangedHaste("player")
	return strform("%.2f%%", Total_Range_Haste)
end

StatFunc.Range_Hit = function()
	local Total_Range_Hit = GetCombatRatingBonus("7")
	return strform("%.2f%%", Total_Range_Hit)
end

StatFunc.Range_Armor_Pen = function()
	local Range_Armor_Pen = GetCombatRatingBonus("25")
	return strform("%.2f%%", Range_Armor_Pen)
end

StatFunc.Range_AP = function()
	local base, posBuff, negBuff = UnitRangedAttackPower("player")
	local Range_AP = base + posBuff + negBuff
	return nibRealUI:ReadableNumber(Range_AP)
end

StatFunc.Range_Crit = function()
	local Range_Crit = GetRangedCritChance("25")
	return strform("%.2f%%", Range_Crit)
end

StatFunc.Range_Speed = function()
	local speed = UnitRangedDamage("player")
	local Total_Range_Speed = speed
	return strform("%.2f", Total_Range_Speed)
end

StatFunc.Range_Mastery = function()
	local Total_RM = GetMasteryEffect("player")
	return strform("%.2f%%", Total_RM)
end

----------------
---- Spells ----
----------------
StatFunc.Spell_Power = function()
	local SP = GetSpellBonusDamage("2")
	return nibRealUI:ReadableNumber(SP)
end

StatFunc.Spell_Crit = function()
	local SC = GetSpellCritChance("2")
	return strform("%.2f%%", SC)
end

StatFunc.Spell_Haste = function()
	local Total_Spell_Haste = UnitSpellHaste("player")
	return strform("%.2f%%", Total_Spell_Haste)
end

StatFunc.Spell_Hit = function()
	local Total_Spell_Hit = GetCombatRatingBonus("8")
	return strform("%.2f%%", Total_Spell_Hit)
end

StatFunc.MP5 = function()
	local base, casting = GetManaRegen()
	local MP5_1 = (casting * 5)
	return strform("%.0f", MP5_1)
end

StatFunc.Spell_Mastery = function()
	local Total_SM = GetMasteryEffect("player")
	return strform("%.2f%%", Total_SM)
end


------------
local GetStatText
local DefaultStatTypes = {
	Tank = {"Armor_Defense", "Defense_Mastery"},
	Melee = {"Melee_AP", "Melee_Crit"},
	Ranged = {"Range_AP", "Range_Crit"},
	Spell = {"Spell_Power", "Spell_Crit"},
	Heal = {"MP5", "Spell_Mastery"},
}
local DefaultStats = {
	["DEATHKNIGHT"] = {
		[1] = DefaultStatTypes.Tank,	-- B
		[2] = DefaultStatTypes.Melee,	-- F
		[3] = DefaultStatTypes.Melee,	-- U
		["NA"] = DefaultStatTypes.Melee,
	},
	["DRUID"] = {
		[1] = DefaultStatTypes.Spell,	-- B
		[2] = DefaultStatTypes.Melee,	-- F
		[3] = DefaultStatTypes.Tank,	-- G
		[4] = DefaultStatTypes.Heal,	-- R
		["NA"] = DefaultStatTypes.Melee,
	},
	["HUNTER"] = {
		[1] = DefaultStatTypes.Ranged,	-- BM
		[2] = DefaultStatTypes.Ranged,	-- MM
		[3] = DefaultStatTypes.Ranged,	-- S
		["NA"] = DefaultStatTypes.Ranged,
	},
	["MAGE"] = {
		[1] = DefaultStatTypes.Spell,	-- A
		[2] = DefaultStatTypes.Spell,	-- Fi
		[3] = DefaultStatTypes.Spell,	-- Fr
		["NA"] = DefaultStatTypes.Spell,
	},
	["MONK"] = {
		[1] = DefaultStatTypes.Tank,	-- BM
		[2] = DefaultStatTypes.Heal,	-- MW
		[3] = DefaultStatTypes.Melee,	-- WW
		["NA"] = DefaultStatTypes.Melee,
	},
	["PALADIN"] = {
		[1] = DefaultStatTypes.Heal,	-- H
		[2] = DefaultStatTypes.Tank,	-- P
		[3] = DefaultStatTypes.Melee,	-- R
		["NA"] = DefaultStatTypes.Melee,
	},
	["PRIEST"] = {
		[1] = DefaultStatTypes.Heal,	-- D
		[2] = DefaultStatTypes.Heal,	-- H
		[3] = DefaultStatTypes.Spell,	-- S
		["NA"] = DefaultStatTypes.Spell,
	},
	["ROGUE"] = {
		[1] = DefaultStatTypes.Melee,	-- A
		[2] = DefaultStatTypes.Melee,	-- C
		[3] = DefaultStatTypes.Melee,	-- S
		["NA"] = DefaultStatTypes.Melee,
	},
	["SHAMAN"] = {
		[1] = DefaultStatTypes.Spell,	-- El
		[2] = DefaultStatTypes.Melee,	-- Enh
		[3] = DefaultStatTypes.Heal,	-- R
		["NA"] = DefaultStatTypes.Melee,
	},
	["WARLOCK"] = {
		[1] = DefaultStatTypes.Spell,	-- A
		[2] = DefaultStatTypes.Spell,	-- Dem
		[3] = DefaultStatTypes.Spell,	-- Des
		["NA"] = DefaultStatTypes.Spell,
	},
	["WARRIOR"] = {
		[1] = DefaultStatTypes.Melee,	-- A
		[2] = DefaultStatTypes.Melee,	-- F
		[3] = DefaultStatTypes.Tank,	-- P
		["NA"] = DefaultStatTypes.Melee,
	},
}


local function RefreshStats()
	if GetStatText == nil then
		GetStatText = {
			Dodge 				= function() return StatFunc.Dodge() end,
			Parry 				= function() return StatFunc.Parry() end,
			Block 				= function() return StatFunc.Block() end,
			Armor_Defense 		= function() return StatFunc.Armor_Defense() end,
			Defense_Mastery		= function() return StatFunc.Defense_Mastery() end,
			
			Melee_Haste			= function() return StatFunc.Melee_Haste() end,
			Melee_Hit 			= function() return StatFunc.Melee_Hit() end,
			Melee_AP 			= function() return StatFunc.Melee_AP() end,
			Melee_Crit 			= function() return StatFunc.Melee_Crit() end,
			Expertise 			= function() return StatFunc.Expertise() end,
			Melee_Armor_Pen		= function() return StatFunc.Melee_Armor_Pen() end,
			Weapon_Speed 		= function() return StatFunc.Weapon_Speed() end,
			Melee_Mastery		= function() return StatFunc.Melee_Mastery() end,
			
			Dmg_Reduction 		= function() return StatFunc.Dmg_Reduction() end,
			Total_Resilience 	= function() return StatFunc.Total_Resilience() end,
			Total_PvPPower 		= function() return StatFunc.Total_PvPPower() end,
			
			Range_Haste 		= function() return StatFunc.Range_Haste() end,
			Range_Hit 			= function() return StatFunc.Range_Hit() end,
			Range_Armor_Pen 	= function() return StatFunc.Range_Armor_Pen() end,
			Range_AP 			= function() return StatFunc.Range_AP() end,
			Range_Crit 			= function() return StatFunc.Range_Crit() end,
			Range_Speed 		= function() return StatFunc.Range_Speed() end,
			Range_Mastery 		= function() return StatFunc.Range_Mastery() end,
			
			Spell_Power 		= function() return StatFunc.Spell_Power() end,
			Spell_Crit 			= function() return StatFunc.Spell_Crit() end,
			Spell_Haste 		= function() return StatFunc.Spell_Haste() end,
			Spell_Hit 			= function() return StatFunc.Spell_Hit() end,
			MP5 				= function() return StatFunc.MP5() end,
			Spell_Mastery 		= function() return StatFunc.Spell_Mastery() end,
		}
	end
end

----------
-- Misc --
----------
function StatDisplay:GetCharStatTexts()
	local stats = {
		{},
		{},
	}
	for k,v in pairs(Stats) do
		if v == dbc.stats[1][1] then
			stats[1][1] = StatTexts[k]
		end
		if v == dbc.stats[1][2] then
			stats[1][2] = StatTexts[k]
		end
		if v == dbc.stats[2][1] then
			stats[2][1] = StatTexts[k]
		end
		if v == dbc.stats[2][2] then
			stats[2][2] = StatTexts[k]
		end
	end
	return stats
end

function StatDisplay:SetDefaultStats()
	if not dbc.statDefaultsSet[1] then
		local Spec1 = GetSpecialization(false, false, 1) or "NA"
		dbc.stats[1] = DefaultStats[nibRealUI.class][Spec1]
		dbc.statDefaultsSet[1] = true
	end
	if not dbc.statDefaultsSet[2] then
		local Spec2 = GetSpecialization(false, false, 2) or "NA"
		dbc.stats[2] = DefaultStats[nibRealUI.class][Spec2]
		dbc.statDefaultsSet[2] = true
	end
end

------------------
-- Stat Updates --
------------------
local function SetValues(row, text)
	StatDisplay.Stats[row]:SetText(text)
end

local function ToggleRow(row, state)
	if state then
		StatDisplay.Stats[row]:Show()
	else
		StatDisplay.Stats[row]:Hide()
	end
end

local function GatherStats(stats)
    if GetStatText == nil then 
		RefreshStats()
	end
    return {GetStatText[stats[1]](), GetStatText[stats[2]]()}
end

local statVals
function StatDisplay:StatUpdate()
	if not UnitAffectingCombat("player") then
		self:CombatUpdate()
		return
	end
	-- print(watchedStats[1], watchedStats[2])
	statVals = GatherStats(watchedStats)
	SetValues(1, statVals[1])
	SetValues(2, statVals[2])
end

function StatDisplay:TalentUpdate()
	StatDisplay:SetDefaultStats()
	watchedStats = dbc.stats[GetActiveSpecGroup()]
	nibRealUI.watchedStats = watchedStats
	if InCombat then
		self:StatUpdate()
	end
end

function StatDisplay:CombatUpdate()
	InCombat = UnitAffectingCombat("player")
	if InCombat then
		StatDisplay:TalentUpdate()
		self:StatUpdate()
		self:ScheduleRepeatingTimer("StatUpdate", 1)
		ToggleRow(1, true)
		ToggleRow(2, true)
	else
		ToggleRow(1, false)
		ToggleRow(2, false)
		self:CancelTimer("StatUpdate")
	end
end

function StatDisplay:CreateFrames()
	self.SDFrame = CreateFrame("Frame", "RealUI_StatDisplay", RealUIPositionersBottomInfo)
	self.SDFrame:SetPoint("TOPLEFT", RealUIPositionersBottomInfo, "TOPLEFT", 4, ndbc.resolution == 1 and -2 or -3)
	self.SDFrame:SetPoint("BOTTOMRIGHT", RealUIPositionersBottomInfo, "BOTTOM", 0, 3)
	self.SDFrame:SetHeight(ndbc.resolution == 1 and 27 or 28)
	
	local font = db.smallfont and nibRealUI.font.pixeltiny or nibRealUI.font.pixel1
	self.Stats = {}
	self.Stats[1] = self.SDFrame:CreateFontString(nil, "OVERLAY")
	self.Stats[1]:SetPoint("TOPLEFT", self.SDFrame, "TOPLEFT", -0.5, -0.5)
	self.Stats[1]:SetFont(unpack(font))
	self.Stats[1]:SetTextColor(db.color.r, db.color.g, db.color.b)
	
	self.Stats[2] = self.SDFrame:CreateFontString(nil, "OVERLAY")
	self.Stats[2]:SetPoint("TOPLEFT", self.SDFrame, "TOPLEFT", -0.5, ndbc.resolution == 1 and -13.5 or -14.5)
	self.Stats[2]:SetFont(unpack(font))
	self.Stats[2]:SetTextColor(db.color.r, db.color.g, db.color.b)
	
	ToggleRow(1, false)
	ToggleRow(2, false)
end

--------------------
-- Options Window --
--------------------
local function stat_initialize(dropdown, level)
    if not level or level == 1 then
		for idx, entry in ipairs(StatTexts) do
			local info = UIDropDownMenu_CreateInfo()
			info.text = entry
			info.value = entry
			info.func = function(frame, ...)
				UIDropDownMenu_SetSelectedValue(dropdown, entry)
				for k,v in pairs(StatTexts) do
					if v == entry then
						dbc.stats[dropdown.spec][dropdown.stat] = Stats[k]
					end
				end
				StatDisplay:TalentUpdate()
			end
			UIDropDownMenu_AddButton(info, level)
		end
    end
end

function StatDisplay:RefreshOptions()
	local sdO = self.options
	local stats = self:GetCharStatTexts()
	local statKeys = {{},{}}
	for k,v in pairs(Stats) do
		if v == dbc.stats[1][1] then
			statKeys[1][1] = k
		end
		if v == dbc.stats[1][2] then
			statKeys[1][2] = k
		end
		if v == dbc.stats[2][1] then
			statKeys[2][1] = k
		end
		if v == dbc.stats[2][2] then
			statKeys[2][2] = k
		end
	end
	UIDropDownMenu_Initialize(sdO.ddP1, stat_initialize)
    UIDropDownMenu_SetSelectedValue(sdO.ddP1, statKeys[1][1])
    UIDropDownMenu_SetText(sdO.ddP1, stats[1][1])
	UIDropDownMenu_Initialize(sdO.ddP2, stat_initialize)
    UIDropDownMenu_SetSelectedValue(sdO.ddP2, statKeys[1][2])
    UIDropDownMenu_SetText(sdO.ddP2, stats[1][2])
	UIDropDownMenu_Initialize(sdO.ddS1, stat_initialize)
    UIDropDownMenu_SetSelectedValue(sdO.ddS1, statKeys[2][1])
    UIDropDownMenu_SetText(sdO.ddS1, stats[2][1])
	UIDropDownMenu_Initialize(sdO.ddS2, stat_initialize)
    UIDropDownMenu_SetSelectedValue(sdO.ddS2, statKeys[2][2])
    UIDropDownMenu_SetText(sdO.ddS2, stats[2][2])
end

local createTextButton = function (name, parent, width, height)
	local button = CreateFrame("Button", nil, parent)
	button:SetNormalFontObject(GameFontNormalSmall)
	button:SetHighlightFontObject(GameFontHighlightSmall)
	button:SetText(name)
	button:SetWidth(width)
	button:SetHeight(height)
	button:SetScript("OnEnter", buttonEnter)
	button:SetScript("OnLeave", buttonLeave)
	return button
end

function StatDisplay:CreateOptionsFrame()
	if self.options then return end
	
	self.options = CreateFrame("Frame", "RealUIStatDisplayOptions", UIParent)
	local sdO = self.options
	sdO:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	sdO:SetSize(460, 134)
	sdO:SetFrameLevel(5)
	sdO:SetFrameStrata("HIGH")
	sdO:Hide()
	tinsert(UISpecialFrames, "RealUIStatDisplayOptions") -- Close on "Esc"
	
	-- Close
	local close = CreateFrame("Button", nil, sdO, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", 6, 4)
	close:SetScript("OnClick", function() RealUIStatDisplayOptions:Hide() end)
	
	sdO.okay = createTextButton(L["Okay"], sdO, 100, 24)
	sdO.okay:SetPoint("BOTTOM", sdO, "BOTTOM", 0, 5)
	sdO.okay:SetScript("OnClick", function() RealUIStatDisplayOptions:Hide() end)
	nibRealUI:CreateBGSection(sdO, sdO.okay, sdO.okay)
	
	-- Header
	local header = nibRealUI:CreateFS(sdO, "CENTER")
	header:SetText("Stat Display")
	header:SetPoint("TOP", sdO, "TOP", 0, -9)
	
	-- Header Primary
	local hP1 = nibRealUI:CreateFS(sdO, "CENTER")
	hP1:SetPoint("TOPLEFT", sdO, "TOPLEFT", 3, -28)
	hP1:SetSize(235, 16)
	hP1:SetText(PRIMARY)
	hP1:SetTextColor(unpack(nibRealUI.media.colors.red))
	
	-- Header Secondary
	local hS1 = nibRealUI:CreateFS(sdO, "CENTER")
	hS1:SetPoint("TOPRIGHT", sdO, "TOPRIGHT", -1, -28)
	hS1:SetSize(235, 16)
	hS1:SetText(SECONDARY)
	hS1:SetTextColor(unpack(nibRealUI.media.colors.red))
	
	-- P1
	sdO.ddP1 = CreateFrame("Frame", "RealUIStatDisplayOptionsPrimary1", sdO, "UIDropDownMenuTemplate")
	UIDropDownMenu_SetWidth(sdO.ddP1, 184)
	sdO.ddP1:SetPoint("TOP", hP1, "BOTTOM", 0, -3)
	sdO.ddP1:SetFrameLevel(sdO:GetFrameLevel() + 2)
	sdO.ddP1:SetSize(235, 18)
	sdO.ddP1.spec = 1
	sdO.ddP1.stat = 1
	
	-- P2
	sdO.ddP2 = CreateFrame("Frame", "RealUIStatDisplayOptionsPrimary2", sdO, "UIDropDownMenuTemplate")
	UIDropDownMenu_SetWidth(sdO.ddP2, 184)
	sdO.ddP2:SetPoint("TOP", sdO.ddP1, "BOTTOM", 0, 11)
	sdO.ddP2:SetFrameLevel(sdO:GetFrameLevel() + 2)
	sdO.ddP2:SetSize(235, 18)
	sdO.ddP2.spec = 1
	sdO.ddP2.stat = 2
	
	nibRealUI:CreateBGSection(sdO, sdO.ddP1, sdO.ddP2, 14, -2, -16, 6)
	
	-- S1
	sdO.ddS1 = CreateFrame("Frame", "RealUIStatDisplayOptionsSecondary1", sdO, "UIDropDownMenuTemplate")
	UIDropDownMenu_SetWidth(sdO.ddS1, 184)
	sdO.ddS1:SetPoint("TOP", hS1, "BOTTOM", 0, -3)
	sdO.ddS1:SetFrameLevel(sdO:GetFrameLevel() + 2)
	sdO.ddS1:SetSize(235, 18)
	sdO.ddS1.spec = 2
	sdO.ddS1.stat = 1
	
	-- S2
	sdO.ddS2 = CreateFrame("Frame", "RealUIStatDisplayOptionsSecondary2", sdO, "UIDropDownMenuTemplate")
	UIDropDownMenu_SetWidth(sdO.ddS2, 184)
	sdO.ddS2:SetPoint("TOP", sdO.ddS1, "BOTTOM", 0, 11)
	sdO.ddS2:SetFrameLevel(sdO:GetFrameLevel() + 2)
	sdO.ddS2:SetSize(235, 18)
	sdO.ddS2.spec = 2
	sdO.ddS2.stat = 2
	
	nibRealUI:CreateBGSection(sdO, sdO.ddS1, sdO.ddS2, 14, -2, -16, 6)

	-- Skin
	if Aurora then
		local F = Aurora[1]
		F.SetBD(sdO)
		F.Reskin(sdO.okay)
		F.ReskinClose(close)
		F.ReskinDropDown(sdO.ddP1)
		F.ReskinDropDown(sdO.ddP2)
		F.ReskinDropDown(sdO.ddS1)
		F.ReskinDropDown(sdO.ddS2)
	end
	
	sdO:Show()
end

function StatDisplay:ShowOptionsWindow()
	if not StatDisplay.options then self:CreateOptionsFrame() end
	StatDisplay:RefreshOptions()
	StatDisplay.options:Show()
end

----------

function StatDisplay:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			color = {r = 1, g = 1, b = 1},
			smallfont = true,
		},
		char = {
			statDefaultsSet = {false, false},
			stats = {
				[1] = {},
				[2] = {},
			},
		},
	})
	db = self.db.profile
	dbc = self.db.char
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterHuDOptions(MODNAME, GetOptions)
end

function StatDisplay:OnEnable()
	self:CreateFrames()
	
	self:RegisterEvent("PLAYER_LOGIN", "TalentUpdate")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "TalentUpdate")
	self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", "TalentUpdate")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "TalentUpdate")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CombatUpdate")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CombatUpdate")
end