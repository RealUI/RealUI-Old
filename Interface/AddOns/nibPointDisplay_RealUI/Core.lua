local nibPointDisplay_RealUI = LibStub("AceAddon-3.0"):NewAddon("nibPointDisplay_RealUI", "AceConsole-3.0", "AceEvent-3.0", "AceBucket-3.0")
local media = LibStub("LibSharedMedia-3.0")
local db

nibPointDisplay_RealUI.Types = {
	["GENERAL"] = {
		name = "General",
		points = {
			[1] = {name = "Combo Points", id = "cp", barcount = 5},
		},
	},
	["DEATHKNIGHT"] = {
		name = "Death Knight",
		points = {
			[1] = {name = "Shadow Infusion", id = "si", barcount = 5},
			[2] = {name = "Bone Shield", id = "bs", barcount = 4},
		},
	},
	["DRUID"] = {
		name = "Druid",
		points = {
			[1] = {name = "Lunar Shower", id = "lus", barcount = 3},
			[2] = {name = "Lacerate", id = "lac", barcount = 3},
			[3] = {name = "Wild Mushroom", id = "wm", barcount = 3},
			[4] = {name = "Astral Alignment", id = "al", barcount = 3},
		},
	},
	["HUNTER"] = {
		name = "Hunter",
		points = {
			[1] = {name = "Ready Set Aim", id = "rsa", barcount = 5},
			[2] = {name = "Frenzy Effect", id = "fe", barcount = 5},
		},
	},
	["MAGE"] = {
		name = "Mage",
		points = {
			[1] = {name = "Arcane Blast", id = "ab", barcount = 4},
			[2] = {name = "Fingers of Frost", id = "ff", barcount = 2},
		},
	},
	["PALADIN"] = {
		name = "Paladin",
		points = {
			[1] = {name = "Holy Power", id = "hp", barcount = 3},
		},
	},
	["PRIEST"] = {
		name = "Priest",
		points = {
			[1] = {name = "Evangelism", id = "eva", barcount = 5},
			[2] = {name = "Shadow Orbs", id = "so", barcount = 3},
			[3] = {name = "Serendipity", id = "ser", barcount = 2},
			[4] = {name = "Dark Evangelism", id = "deva", barcount = 5},
			[5] = {name = "Mind Melt", id = "mm", barcount = 2},
		},
	},
	["ROGUE"] = {
		name = "Rogue",
		points = {
			[1] = {name = "Deadly Poison", id = "dp", barcount = 5},
		},
	},
	["SHAMAN"] = {
		name = "Shaman",
		points = {
			[1] = {name = "Maelstrom Weapon", id = "mw", barcount = 5},
			[2] = {name = "Lighting Shield", id = "ls", barcount = 6},
			[3] = {name = "Tidal Waves", id = "tw", barcount = 2},
			[4] = {name = "Water Shield", id = "ws", barcount = 3},
		},		
	},
	["WARLOCK"] = {
		name = "Warlock",
		points = {
			[1] = {name = "Soul Shards", id = "ss", barcount = 3},
			[2] = {name = "Molten Core", id = "mco", barcount = 3},
		},
	},
	["WARRIOR"] = {
		name = "Warrior",
		points = {
			[1] = {name = "Thunderstruck", id = "ts", barcount = 3},
			[2] = {name = "Meat Cleaver", id = "mc", barcount = 3},
			[3] = {name = "Sunder Armor", id = "sa", barcount = 3},
		},
	},
}
local Types = nibPointDisplay_RealUI.Types

local defaults = {
	profile = {
		updatespeed = 8,
		combatfader = {
			enabled = true,
			opacity = {
				incombat = 1,
				hurt = .8,
				target = .8,
				outofcombat = .3,
			},
		},
	-- CLASS
		["**"] = {
			types = {
			-- Point Display type
				["**"] = {
					enabled = true,
					configmode = {
						enabled = false,
						count = 2,
					},
					general = {
						hideui = false,
						hideempty = true,
						smarthide = false,
						hidein = {
							vehicle = true,
							spec = 1,	-- 1 = Disabled, 2 = Primary, 3 = Secondary
						},
						direction = {
							reverse = false,
						},
					},
					position = {
						x = 0,
						y = 0,
						framelevel = {
							strata = "MEDIUM",
							level = 2,
						},
					},
					bars = {
						custom = false,
						position = {
							gap = -2,
						},
						size = {
							width = 16,
							height = 16,
						},
						bg = {
							empty = {
								texture = "Round_Large_BG",
								color = {r = 1, g = 1, b = 1, a = 0.2},
							},
							full = {
								texture = "Round_Large_BG",
								color = {r = 1, g = 1, b = 1, a = 0.8},
								maxcolor = {r = 1, g = 1, b = 1, a = 1},
							},
						},
						surround = {
							texture = "Round_Large_Surround",
							color = {r = 0, g = 0, b = 0, a = 1},
						},
					},
				},
			},
		},
	},
}

---- Spell Info table
local SpellInfo = {
	["si"] = nil,
	["bs"] = nil,
	["lus"] = nil,
	["lac"] = nil,
	["al"] = nil,
	["rsa"] = nil,
	["fe"] = nil,
	["ab"] = nil,
	["ff"] = nil,
	["eva"] = nil,
	["deva"] = nil,
	["so"] = nil,
	["ser"] = nil,
	["dp"] = nil,
	["mw"] = nil,
	["ls"] = nil,
	["tw"] = nil,
	["ws"] = nil,
	["mco"] = nil,
	["ts"] = nil,
	["mc"] = nil,
	["sa"] = nil,
}

-- Point Display tables
local Frames = {}
local BG = {}

-- Points
local Points = {}
local PointsChanged = {}

local HolyPowerBG, HolyPowerSurround
local SoulShardBG


local LoggedIn = false
local PlayerClass
local PlayerSpec
local PlayerInCombat
local PlayerTargetHostile
local PlayerInInstance
local SmartHideConditions
local ValidClasses

-- Combat Fader
local CFFrame = CreateFrame("Frame")
local FadeTime = 0.25
local CFStatus = nil

-- Power 'Full' check
local power_check = {
	MANA = function()
		return UnitMana("player") < UnitManaMax("player")
	end,
	RAGE = function()
		return UnitMana("player") > 0
	end,
	ENERGY = function()
		return UnitMana("player") < UnitManaMax("player")
	end,
	RUNICPOWER = function()
		return UnitMana("player") > 0
	end,
}

-- Fade frame
local function FadeIt(self, NewOpacity)
	local CurrentOpacity = self:GetAlpha()
	if NewOpacity > CurrentOpacity then
		UIFrameFadeIn(self, FadeTime, CurrentOpacity, NewOpacity)
	elseif NewOpacity < CurrentOpacity then
		UIFrameFadeOut(self, FadeTime, CurrentOpacity, NewOpacity)
	end
end

-- Determine new opacity values for frames
function nibPointDisplay_RealUI:FadeFrames()
	for ic,vc in pairs(Types) do
		for it,vt in ipairs(Types[ic].points) do
			local NewOpacity
			local tid = Types[ic].points[it].id
			-- Retrieve opacity/visibility for current status
			NewOpacity = 1
			if db.combatfader.enabled then
				if CFStatus == "DISABLED" then
					NewOpacity = 1
				elseif CFStatus == "INCOMBAT" then
					NewOpacity = db.combatfader.opacity.incombat
				elseif CFStatus == "TARGET" then
					NewOpacity = db.combatfader.opacity.target
				elseif CFStatus == "HURT" then
					NewOpacity = db.combatfader.opacity.hurt
				elseif CFStatus == "OUTOFCOMBAT" then
					NewOpacity = db.combatfader.opacity.outofcombat
				end

				-- Fade Frame
				FadeIt(Frames[ic][tid].bgpanel.frame, NewOpacity)
			else
				-- Combat Fader disabled for this frame
				if Frames[ic][tid].bgpanel.frame:GetAlpha() < 1 then
					FadeIt(Frames[ic][tid].bgpanel.frame, NewOpacity)
				end
			end
		end
	end
	nibPointDisplay_RealUI:UpdatePointDisplay("ENABLE")
end

function nibPointDisplay_RealUI:UpdateCFStatus()
	local OldStatus = CFStatus
	
	-- Combat Fader based on status
	if UnitAffectingCombat("player") then
		CFStatus = "INCOMBAT"
	elseif UnitExists("target") then
		CFStatus = "TARGET"
	elseif UnitHealth("player") < UnitHealthMax("player") then
		CFStatus = "HURT"
	else
		local _, power_token = UnitPowerType("player")
		local func = power_check[power_token]
		if func and func() then
			CFStatus = "HURT"
		else
			CFStatus = "OUTOFCOMBAT"
		end
	end
	if CFStatus ~= OldStatus then nibPointDisplay_RealUI:FadeFrames() end
end

function nibPointDisplay_RealUI:UpdateCombatFader()
	CFStatus = nil
	nibPointDisplay_RealUI:UpdateCFStatus()
end

-- On combat state change
function nibPointDisplay_RealUI:CombatFaderCombatState()
	-- If in combat, then don't worry about health/power events
	if UnitAffectingCombat("player") then
		CFFrame:UnregisterEvent("UNIT_HEALTH")
		CFFrame:UnregisterEvent("UNIT_POWER")
		CFFrame:UnregisterEvent("UNIT_DISPLAYPOWER")
	else
		CFFrame:RegisterEvent("UNIT_HEALTH")
		CFFrame:RegisterEvent("UNIT_POWER")
		CFFrame:RegisterEvent("UNIT_DISPLAYPOWER")
	end
end

-- Register events for Combat Fader status
function nibPointDisplay_RealUI:UpdateCombatFaderEnabled()
	CFFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	CFFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	CFFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	CFFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	
	CFFrame:SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED" then
			nibPointDisplay_RealUI:CombatFaderCombatState()
			nibPointDisplay_RealUI:UpdateCFStatus()
		elseif event == "UNIT_HEALTH" or event == "UNIT_POWER" or event == "UNIT_DISPLAYPOWER" then
			local unit = ...
			if unit == "player" then
				nibPointDisplay_RealUI:UpdateCFStatus()
			end
		elseif event == "PLAYER_TARGET_CHANGED" then
			nibPointDisplay_RealUI:UpdateCFStatus()
		elseif event == "PLAYER_ENTERING_WORLD" then
			nibPointDisplay_RealUI:CombatFaderCombatState()
			nibPointDisplay_RealUI:UpdateCombatFader()
		end
	end)
	
	nibPointDisplay_RealUI:UpdateCombatFader()
	nibPointDisplay_RealUI:FadeFrames()
end

-- Update Point Bars
local PBTex = {}
local function SetPointBarTextures(shown, ic, it, tid, i)
	if tid == "hp" and db[ic].types[tid].bars.custom then
		PBTex.empty = HolyPowerBG[i]
		PBTex.full = HolyPowerBG[i]
		PBTex.surround = HolyPowerSurround[i]
	else
		PBTex.empty = BG[ic][tid].bars.empty
		PBTex.full = BG[ic][tid].bars.full
		PBTex.surround = BG[ic][tid].bars.surround
	end
	
	-- Visible Bar
	if shown then
		-- BG
		Frames[ic][tid].bars[i].bg:SetTexture(PBTex.full)
		
		-- Colors
		if Points[tid] < Types[ic].points[it].barcount then
			Frames[ic][tid].bars[i].bg:SetVertexColor(db[ic].types[tid].bars.bg.full.color.r, db[ic].types[tid].bars.bg.full.color.g, db[ic].types[tid].bars.bg.full.color.b, db[ic].types[tid].bars.bg.full.color.a)
		else
			Frames[ic][tid].bars[i].bg:SetVertexColor(db[ic].types[tid].bars.bg.full.maxcolor.r, db[ic].types[tid].bars.bg.full.maxcolor.g, db[ic].types[tid].bars.bg.full.maxcolor.b, db[ic].types[tid].bars.bg.full.maxcolor.a)
		end
		Frames[ic][tid].bars[i].surround:SetVertexColor(db[ic].types[tid].bars.surround.color.r, db[ic].types[tid].bars.surround.color.g, db[ic].types[tid].bars.surround.color.b, db[ic].types[tid].bars.surround.color.a)
	-- Empty Bar
	else
		-- BG
		Frames[ic][tid].bars[i].bg:SetTexture(PBTex.empty)
		Frames[ic][tid].bars[i].bg:SetVertexColor(db[ic].types[tid].bars.bg.empty.color.r, db[ic].types[tid].bars.bg.empty.color.g, db[ic].types[tid].bars.bg.empty.color.b, db[ic].types[tid].bars.bg.empty.color.a)
	end
	Frames[ic][tid].bars[i].surround:SetTexture(PBTex.surround)
end

function nibPointDisplay_RealUI:UpdatePointDisplay(...)
	local UpdateList
	if ... == "ENABLE" then
		-- Update everything
		UpdateList = Types
	else
		UpdateList = ValidClasses
	end
	
	-- Cycle through all Types that need updating
	for ic,vc in pairs(UpdateList) do
		-- Cycle through all Point Displays in current Type
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id
			
			-- Do we hide the Display
			if ((Points[tid] == 0)
				or (ic ~= PlayerClass and ic ~= "GENERAL") 
				or ((PlayerClass ~= "ROGUE") and (PlayerClass ~= "DRUID") and (ic == "GENERAL") and not UnitHasVehicleUI("player"))
				or (db[ic].types[tid].general.hidein.vehicle and UnitHasVehicleUI("player")) 
				or ((db[ic].types[tid].general.hidein.spec - 1) == PlayerSpec)
				or (db[ic].types[tid].general.smarthide and SmartHideConditions))
				and not db[ic].types[tid].configmode.enabled then
					-- Hide Display	
					Frames[ic][tid].bgpanel.frame:Hide()
			else
			-- Update the Display
				-- Update Bars if their Points have changed
				if PointsChanged[tid] then
					for i = 1, Types[ic].points[it].barcount do
						if Points[tid] == nil then Points[tid] = 0 end
						if Points[tid] >= i then
						-- Show bar and set textures to "Full"
							Frames[ic][tid].bars[i].frame:Show()
							SetPointBarTextures(true, ic, it, tid, i)
						else
							if db[ic].types[tid].general.hideempty then
							-- Hide "empty" bar
								Frames[ic][tid].bars[i].frame:Hide()
							else
							-- Show bar and set textures to "Empty"
								Frames[ic][tid].bars[i].frame:Show()
								SetPointBarTextures(false, ic, it, tid, i)
							end				
						end
						
					end
					-- Show the Display
					Frames[ic][tid].bgpanel.frame:Show()
					
					-- Flag as having been changed
					PointsChanged[tid] = false
				end
			end
		end
	end
end

-- Point retrieval
local function GetDebuffCount(SpellID, ...)
	local unit = ... or "target"
	local _,_,_,count,_,_,_,caster = UnitDebuff(unit, SpellID)
	if count == nil then count = 0 end
	if caster ~= "player" then count = 0 end	-- Only show Debuffs cast by me
	return count
end

local function GetBuffCount(SpellID, ...)
	local unit = ... or "player"
	local _,_,_,count = UnitAura(unit, SpellID)
	if count == nil then count = 0 end
	return count
end

function nibPointDisplay_RealUI:GetPoints(CurClass, CurType)
	local NewPoints
	-- General
	if CurClass == "GENERAL" then
		-- Combo Points
		if CurType == "cp" then
			NewPoints = GetComboPoints(UnitHasVehicleUI("player") and "vehicle" or "player", "target")
		end
	-- Death Knight
	elseif CurClass == "DEATHKNIGHT" then
		-- Shadow Infusion
		if CurType == "si" then
			NewPoints = GetBuffCount(SpellInfo[CurType], "pet")
		-- Bone Shield
		elseif CurType == "bs" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		end
	-- Druid
	elseif CurClass == "DRUID" then
		-- Lunar Shower
		if CurType == "lus" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Lacerate
		elseif CurType == "lac" then
			NewPoints = GetDebuffCount(SpellInfo[CurType])
		-- Wild Mushroom
		elseif CurType == "wm" then
			local WMCount = 0
			if PlayerClass == "DRUID" then
				if GetTotemTimeLeft(1) > 0 then WMCount = WMCount + 1 end
				if GetTotemTimeLeft(2) > 0 then WMCount = WMCount + 1 end
				if GetTotemTimeLeft(3) > 0 then WMCount = WMCount + 1 end
			end
			NewPoints = WMCount
		-- Astral Alignment
		elseif CurType == "al" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		end
	-- Hunter
	elseif CurClass == "HUNTER" then
		-- Thunderstruck
		if CurType == "rsa" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Frenzy Effect
		elseif CurType == "fe" then
			NewPoints = GetBuffCount(SpellInfo[CurType], "pet")
		end
	-- Mage
	elseif CurClass == "MAGE" then
		-- Arcane Blast
		if CurType == "ab" then
			NewPoints = GetDebuffCount(SpellInfo[CurType], "player")
		elseif CurType == "ff" then
			NewPoints = GetBuffCount(SpellInfo[CurType], "player")
		end
	-- Paladin
	elseif CurClass == "PALADIN" then
		-- Holy Power
		if CurType == "hp" then
			NewPoints = UnitPower("player", SPELL_POWER_HOLY_POWER)
		end
	-- Priest
	elseif CurClass == "PRIEST" then
		-- Evangelism
		if CurType == "eva" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Shadow Orb
		elseif CurType == "so" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Serendipity
		elseif CurType == "ser" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Dark Evangelism
		elseif CurType == "deva" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Mind Melt
		elseif CurType == "mm" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		end
	-- Rogue
	elseif CurClass == "ROGUE" then
		-- Deadly Poison
		if CurType == "dp" then
			NewPoints = GetDebuffCount(SpellInfo[CurType])
		end
	-- Shaman
	elseif CurClass == "SHAMAN" then
		-- Maelstrom Weapon
		if CurType == "mw" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Lightning Shield (Fulmination)
		elseif CurType == "ls" then
			NewPoints = max(GetBuffCount(SpellInfo[CurType]) - 3, 0)
		-- Tidal Waves
		elseif CurType == "tw" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Water Shield
		elseif CurType == "ws" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		end
	-- Warlock
	elseif CurClass == "WARLOCK" then
		-- Soul Shards
		if CurType == "ss" then
			NewPoints = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
		-- Molten Core
		elseif CurType == "mco" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		end
	-- Warrior
	elseif CurClass == "WARRIOR" then
		-- Thunderstruck
		if CurType == "ts" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Meat Cleaver
		elseif CurType == "mc" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Sunder Armor
		elseif CurType == "sa" then
			NewPoints = GetDebuffCount(SpellInfo[CurType])
		end
	end
	Points[CurType] = NewPoints
end

-- Update all valid Point Displays
function nibPointDisplay_RealUI:UpdatePoints(...)
	if not LoggedIn then return end
	
	local HasChanged = false
	local Enable = ...
	
	local UpdateList
	if ... == "ENABLE" then
		-- Update everything
		UpdateList = Types
	else
		UpdateList = ValidClasses
	end
	
	-- ENABLE update: Config Mode / Reset displays
	if Enable == "ENABLE" then
		HasChanged = true
		for ic,vc in pairs(Types) do
			for it,vt in ipairs(Types[ic].points) do
				local tid = Types[ic].points[it].id
				PointsChanged[tid] = true
				if ( db[ic].types[tid].enabled and db[ic].types[tid].configmode.enabled ) then
					-- If Enabled and Config Mode is on, then set points
					Points[tid] = db[ic].types[tid].configmode.count
				else
					Points[tid] = 0
				end
			end
		end
	end
	
	-- Normal update: Cycle through valid classes
	for ic,vc in pairs(UpdateList) do
		-- Cycle through point types for current class
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id
			if ( db[ic].types[tid].enabled and not db[ic].types[tid].configmode.enabled ) then
				-- Retrieve new point count
				local OldPoints = Points[tid]
				nibPointDisplay_RealUI:GetPoints(ic, tid)
				if Points[tid] ~= OldPoints then
					-- Points have changed, flag for updating
					HasChanged = true
					PointsChanged[tid] = true
				end
			end
		end
	end
	
	-- Update Point Displays
	if HasChanged then nibPointDisplay_RealUI:UpdatePointDisplay(Enable) end
end

-- Enable a Point Display
function nibPointDisplay_RealUI:EnablePointDisplay(c, t)
	nibPointDisplay_RealUI:UpdatePoints("ENABLE")
end

-- Disable a Point Display
function nibPointDisplay_RealUI:DisablePointDisplay(c, t)
	-- Set to 0 points
	Points[t] = 0
	PointsChanged[t] = true
	
	-- Update Point Displays
	nibPointDisplay_RealUI:UpdatePointDisplay("ENABLE")
end

-- Update frame positions/sizes
function nibPointDisplay_RealUI:UpdatePosition()
	for ic,vc in pairs(Types) do
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id
			---- BG Panel
			local Parent = UIParent
			
			Frames[ic][tid].bgpanel.frame:SetParent(Parent)
			Frames[ic][tid].bgpanel.frame:ClearAllPoints()
			Frames[ic][tid].bgpanel.frame:SetPoint("CENTER", Parent, "CENTER", db[ic].types[tid].position.x, db[ic].types[tid].position.y)
			Frames[ic][tid].bgpanel.frame:SetFrameStrata(db[ic].types[tid].position.framelevel.strata)
			Frames[ic][tid].bgpanel.frame:SetFrameLevel(db[ic].types[tid].position.framelevel.level)
			Frames[ic][tid].bgpanel.frame:SetWidth(10)
			Frames[ic][tid].bgpanel.frame:SetHeight(10)
			
			---- Point Bars
			local IsRev = db[ic].types[tid].general.direction.reverse
			local XPos, YPos, CPRatio, TWidth, THeight
			local Positions = {}
			local CPSize = {}
			
			-- Get total Width and Height of Point Display, and the size of each Bar
			TWidth = 0
			THeight = 0
			for i = 1, Types[ic].points[it].barcount do
				CPSize[i] = db[ic].types[tid].bars.size.width + db[ic].types[tid].bars.position.gap
				TWidth = TWidth + db[ic].types[tid].bars.size.width + db[ic].types[tid].bars.position.gap
			end
			
			-- Calculate position of each Bar
			for i = 1, Types[ic].points[it].barcount do
				local CurPos = 0
				local TVal = TWidth
				
				-- Add up position of each Bar in sequence
				if i == 1 then
					CurPos = (CPSize[i] / 2) - (TVal / 2)
				else
					for j = 1, i-1 do
						CurPos = CurPos + CPSize[j]
					end
					CurPos = CurPos + (CPSize[i] / 2) - (TVal / 2)
				end					
				
				-- Found Position of Bar
				Positions[i] = CurPos
			end
			
			-- Position each Bar
			for i = 1, Types[ic].points[it].barcount do
				local RevMult = 1
				if IsRev then RevMult = -1 end			
				
				Frames[ic][tid].bars[i].frame:SetParent(Frames[ic][tid].bgpanel.frame)
				Frames[ic][tid].bars[i].frame:ClearAllPoints()
				
				XPos = Positions[i] * RevMult
				YPos = 0
				
				Frames[ic][tid].bars[i].frame:SetPoint("CENTER", Frames[ic][tid].bgpanel.frame, "CENTER", XPos, YPos)
				
				Frames[ic][tid].bars[i].frame:SetFrameStrata(db[ic].types[tid].position.framelevel.strata)
				Frames[ic][tid].bars[i].frame:SetFrameLevel(db[ic].types[tid].position.framelevel.level + 2)
				Frames[ic][tid].bars[i].frame:SetWidth(db[ic].types[tid].bars.size.width)
				Frames[ic][tid].bars[i].frame:SetHeight(db[ic].types[tid].bars.size.height)
			end
		end
	end
end

-- Retrieve SharedMedia backgound
local function RetrieveBackground(background)
	background = media:Fetch("background", background, true)
	return background
end

local function VerifyBackground(background)
	local newbackground = ""
	if background and strlen(background) > 0 then 
		newbackground = RetrieveBackground(background)
		if background ~= "None" then
			if not newbackground then
				print("Background "..background.." was not found in SharedMedia.")
				newbackground = ""
			end
		end
	end	
	return newbackground
end

-- Retrieve Background textures and store in tables
function nibPointDisplay_RealUI:GetTextures()
	for ic,vc in pairs(Types) do
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id
			BG[ic][tid].bars.empty = VerifyBackground(db[ic].types[tid].bars.bg.empty.texture)
			BG[ic][tid].bars.full = VerifyBackground(db[ic].types[tid].bars.bg.full.texture)
			BG[ic][tid].bars.surround = VerifyBackground(db[ic].types[tid].bars.surround.texture)
		end
	end
end

-- Frame Creation
local function CreateFrames()
	for ic,vc in pairs(Types) do
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id
			
			-- BG Panel
			local FrameName = "nibPointDisplay_RealUI_Frames_"..tid
			Frames[ic][tid].bgpanel.frame = CreateFrame("Frame", FrameName, UIParent)
			
			Frames[ic][tid].bgpanel.bg = Frames[ic][tid].bgpanel.frame:CreateTexture(nil, "ARTWORK")
			Frames[ic][tid].bgpanel.bg:SetAllPoints(Frames[ic][tid].bgpanel.frame)
			
			Frames[ic][tid].bgpanel.frame:Hide()
			
			-- Point bars
			for i = 1, Types[ic].points[it].barcount do
				local BarFrameName = "nibPointDisplay_RealUI_Frames_"..tid.."_bar"..tostring(i)
				Frames[ic][tid].bars[i].frame = CreateFrame("Frame", BarFrameName, UIParent)
				
				Frames[ic][tid].bars[i].bg = Frames[ic][tid].bars[i].frame:CreateTexture(nil, "ARTWORK")
				Frames[ic][tid].bars[i].bg:SetAllPoints(Frames[ic][tid].bars[i].frame)
				
				Frames[ic][tid].bars[i].surround = Frames[ic][tid].bars[i].frame:CreateTexture(nil, "ARTWORK")
				Frames[ic][tid].bars[i].surround:SetAllPoints(Frames[ic][tid].bars[i].frame)
				
				Frames[ic][tid].bars[i].frame:Show()
			end
		end
	end
end

-- Table creation
local function CreateTables()
	-- Frames
	wipe(Frames)
	wipe(BG)
	wipe(Points)
	wipe(PointsChanged)
	
	for ic,vc in pairs(Types) do
		-- Insert Class header
		tinsert(Frames, ic); Frames[ic] = {};
		tinsert(BG, ic); BG[ic] = {};
		
		for it,vt in ipairs(Types[ic].points) do	-- Iterate through Types table
			local tid = Types[ic].points[it].id
			
			-- Insert point type (ie "cp") into table and fill out table
			-- Frames
			tinsert(Frames[ic], tid)
			tinsert(BG[ic], tid)
			
			Frames[ic][tid] = {
				bgpanel = {frame = nil, bg = nil},
				bars = {},				
			}
			BG[ic][tid] = {
				bars = {},
			}
			for i = 1, Types[ic].points[it].barcount do
				Frames[ic][tid].bars[i] = {frame = nil, bg = nil, surround = nil}
				BG[ic][tid].bars[i] = {empty = "", full = "", surround = ""}
			end
			
			-- Points			
			Points[tid] = 0
			
			-- Set up Points Changed table
			PointsChanged[tid] = false
		end
	end
end

function nibPointDisplay_RealUI:ProfChange()
	if not LoggedIn then return end
	
	db = self.db.profile
	nibPointDisplay_RealUI:ConfigRefresh()
	nibPointDisplay_RealUI:Refresh()
end

-- Refresh nibPointDisplay_RealUI
function nibPointDisplay_RealUI:Refresh()
	if not LoggedIn then return end

	nibPointDisplay_RealUI:UpdateSpec()
	nibPointDisplay_RealUI:UpdateCombatFaderEnabled()
	nibPointDisplay_RealUI:GetTextures()
	nibPointDisplay_RealUI:UpdatePosition()
	nibPointDisplay_RealUI:UpdatePoints("ENABLE")
end

-- Hide default UI frames
function nibPointDisplay_RealUI:HideUIElements()
	if db["GENERAL"].types["cp"].enabled and db["GENERAL"].types["cp"].general.hideui then
		for i = 1,5 do
			_G["ComboPoint"..i]:Hide()
			_G["ComboPoint"..i]:SetScript("OnShow", function(self) self:Hide() end)
		end
	end
	
	if db["PALADIN"].types["hp"].enabled and db["PALADIN"].types["hp"].general.hideui then
		local HPF = _G["PaladinPowerBar"]
		if HPF then
			HPF:Hide()
			HPF:SetScript("OnShow", function(self) self:Hide() end)
		end
	end
	
	if db["WARLOCK"].types["ss"].enabled and db["WARLOCK"].types["ss"].general.hideui then
		local SSF = _G["ShardBarFrame"]
		if SSF then
			SSF:Hide()
			SSF:SetScript("OnShow", function(self) self:Hide() end)
		end
	end
end

function nibPointDisplay_RealUI:UpdateSpec()
	PlayerSpec = GetActiveTalentGroup()
end

function nibPointDisplay_RealUI:UpdateSmartHideConditions()
	if PlayerInCombat or PlayerTargetHostile or PlayerInInstance then
		SmartHideConditions = false
	else
		SmartHideConditions = true
	end
	nibPointDisplay_RealUI:UpdatePoints("ENABLE")
end

function nibPointDisplay_RealUI:PLAYER_TARGET_CHANGED()
	PlayerTargetHostile = (UnitIsEnemy("player", "target") or UnitCanAttack("player", "target"))
	nibPointDisplay_RealUI:UpdateSmartHideConditions()
end

function nibPointDisplay_RealUI:PLAYER_REGEN_DISABLED()
	PlayerInCombat = true
	nibPointDisplay_RealUI:UpdateSmartHideConditions()
end

function nibPointDisplay_RealUI:PLAYER_REGEN_ENABLED()
	PlayerInCombat = false
	nibPointDisplay_RealUI:UpdateSmartHideConditions()
end

function nibPointDisplay_RealUI:PLAYER_ENTERING_WORLD()
	PlayerInInstance = IsInInstance()
	nibPointDisplay_RealUI:UpdateSpec()
	nibPointDisplay_RealUI:UpdatePosition()
	nibPointDisplay_RealUI:UpdateSmartHideConditions()
end

function nibPointDisplay_RealUI:PLAYER_LOGIN()
	PlayerClass = select(2, UnitClass("player"))
	
	-- Build Class list to run updates on
	ValidClasses = {
		["GENERAL"] = true,
		[PlayerClass] = true,
	},
	
	-- Register Media
	media:Register("background", "Round_Large_BG", [[Interface\Addons\nibPointDisplay_RealUI\Media\Round_Large_BG]])
	media:Register("background", "Round_Large_Surround", [[Interface\Addons\nibPointDisplay_RealUI\Media\Round_Large_Surround]])
	media:Register("background", "Round_Small_BG", [[Interface\Addons\nibPointDisplay_RealUI\Media\Round_Small_BG]])
	media:Register("background", "Round_Small_Surround", [[Interface\Addons\nibPointDisplay_RealUI\Media\Round_Small_Surround]])
	media:Register("background", "Round_Larger_BG", [[Interface\Addons\nibPointDisplay_RealUI\Media\Round_Larger_BG]])
	media:Register("background", "Round_Larger_Surround", [[Interface\Addons\nibPointDisplay_RealUI\Media\Round_Larger_Surround]])
	media:Register("background", "Soul_Shard", [[Interface\Addons\nibPointDisplay_RealUI\Media\SoulShard]])
	media:Register("background", "Soul_Shard2_BG", [[Interface\Addons\nibPointDisplay_RealUI\Media\SoulShard2_BG]])
	media:Register("background", "Soul_Shard2_Surround", [[Interface\Addons\nibPointDisplay_RealUI\Media\SoulShard2_Surround]])
	
	HolyPowerBG = {[[Interface\Addons\nibPointDisplay_RealUI\Media\HolyPower1_BG]], [[Interface\Addons\nibPointDisplay_RealUI\Media\HolyPower2_BG]], [[Interface\Addons\nibPointDisplay_RealUI\Media\HolyPower3_BG]]}
	HolyPowerSurround = {[[Interface\Addons\nibPointDisplay_RealUI\Media\HolyPower1_Surround]], [[Interface\Addons\nibPointDisplay_RealUI\Media\HolyPower2_Surround]], [[Interface\Addons\nibPointDisplay_RealUI\Media\HolyPower3_Surround]]}
	
	-- Get Spell Info
	-- Death Knight
	SpellInfo["si"] = GetSpellInfo(91342)		-- Shadow Infusion
	SpellInfo["bs"] = GetSpellInfo(49222)		-- Bone Shield
	-- Druid
	SpellInfo["lus"] = GetSpellInfo(81192)		-- Lunar Shower
	SpellInfo["lac"] = GetSpellInfo(33745)		-- Lacerate
	SpellInfo["al"] = GetSpellInfo(90164)		-- Astral Alignment
	-- Hunter
	SpellInfo["rsa"] = GetSpellInfo(82925)		-- Ready, Set, Aim...
	SpellInfo["fe"] = GetSpellInfo(19615)		-- Frenzy Effect
	-- Mage
	SpellInfo["ab"] = GetSpellInfo(36032)		-- Arcane Blast
	SpellInfo["ff"] = GetSpellInfo(44544)		-- Fingers of Frost
	-- Priest
	SpellInfo["eva"] = GetSpellInfo(81661)		-- Evangelism
	SpellInfo["so"] = GetSpellInfo(77487)		-- Shadow Orb
	SpellInfo["ser"] = GetSpellInfo(63735)		-- Serendipity
	SpellInfo["deva"] = GetSpellInfo(87118)		-- Dark Evangelism
	SpellInfo["mm"] = GetSpellInfo(87160)		-- Mind Melt
	-- Rogue	
	SpellInfo["dp"] = GetSpellInfo(2818)		-- Deadly Poison
	-- Shaman
	SpellInfo["mw"] = GetSpellInfo(65986)		-- Maelstrom Weapon
	SpellInfo["ls"] = GetSpellInfo(324)			-- Lightning Shield
	SpellInfo["tw"] = GetSpellInfo(53390)		-- Tidal Waves
	SpellInfo["ws"] = GetSpellInfo(52128)		-- Water Shield
	-- Warlock
	SpellInfo["mco"] = GetSpellInfo(71165)		-- Molten Core
	-- Warrior
	SpellInfo["ts"] = GetSpellInfo(87096)		-- Thunderstruck
	SpellInfo["mc"] = GetSpellInfo(85739)		-- Meat Cleaver
	SpellInfo["sa"] = GetSpellInfo(58567)		-- Sunder Armor
		
	-- Hide Elements
	nibPointDisplay_RealUI:HideUIElements()
	
	-- Register Events
	-- Throttled Events
	local EventList = {
		"UNIT_COMBO_POINTS",
		"VEHICLE_UPDATE",
		"UNIT_AURA",
	}		
	if ( PlayerClass == "DEATHKNIGHT" or PlayerClass == "HUNTER" ) then
		tinsert(EventList, "UNIT_PET")
	end
	if (PlayerClass == "DRUID") then
		tinsert(EventList, "PLAYER_TOTEM_UPDATE")
	end
	if (PlayerClass == "PALADIN") then
		tinsert(EventList, "UNIT_POWER")
	end
	if (PlayerClass == "WARLOCK") then
		tinsert(EventList, "UNIT_POWER")
		tinsert(EventList, "UNIT_DISPLAYPOWER")
	end	
	local UpdateSpeed = (1 / db.updatespeed)
	self:RegisterBucketEvent(EventList, UpdateSpeed, "UpdatePoints")	
	
	-- Flag as Logged In
	LoggedIn = true
	
	-- Refresh Addon
	nibPointDisplay_RealUI:Refresh()
end

function nibPointDisplay_RealUI:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("nibPointDisplayRUIDB", defaults, "Default")
		
	self.db.RegisterCallback(self, "OnProfileChanged", "ProfChange")
	self.db.RegisterCallback(self, "OnProfileCopied", "ProfChange")
	self.db.RegisterCallback(self, "OnProfileReset", "ProfChange")
	
	nibPointDisplay_RealUI:SetUpInitialOptions()
	
	db = self.db.profile
	
	CreateTables()
	CreateFrames()
	
	-- Turn off Config Mode
	for ic,vc in pairs(Types) do
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id
			db[ic].types[tid].configmode.enabled = false
		end
	end
	
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "UpdateSpec")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
end