local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db

local MODNAME = "GridLayout"
local GridLayout = nibRealUI:NewModule(MODNAME, "AceEvent-3.0", "AceBucket-3.0")

local NeedUpdate = false

--
local Grid, GLM, GLF, GFM, GSM, GSHM

local CurMapID = 0

local SizeByMapID = {
	[401] = 40,		-- AV
	[443] = 10,		-- WSG
	[461] = 15,		-- AB
	[482] = 15,		-- EotS
	[501] = 40,		-- Wintergrasp
	[512] = 15,		-- SotA
	[540] = 40,		-- IoC
	[626] = 10,		-- TP
	[708] = 40,		-- Tol Barad
	[736] = 10,		-- BoG
}

-- Options
local table_GroupSizes = {
	"10",
	"15",
	"25",
	"40",
}

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Grid Layout Changer",
		desc = "Automatic changing of Grid's Layout based on the group/battleground you are in.",
		disabled = function() if not GLM or not GFM then return true end end,
		childGroups = "tab",
		arg = MODNAME,
		order = 718,
		args = {
			header = {
				type = "header",
				name = "Grid Layout Changer",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Automatic changing of Grid's Layout based on your group's size and location.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Grid Layout Changer module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
				end,
				order = 30,
			},
			dps = {
				type = "group",
				name = "DPS/Tank Layout",
				desc = "Grid Layout settings to apply to the RealUI DPS/Tank Layout.",
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				childGroups = "tab",
				order = 40,
				args = {
					standards = {
						type = "group",
						name = "Standard Settings",
						order = 10,
						args = {
							note = {
								type = "description",
								name = "Standard Settings to apply to all Grid Layouts. Specific Grid Layouts may override these settings if they are enabled.",
								fontSize = "medium",
								order = 10,
							},
							width = {
								type = "group",
								name = "Unit Width",
								inline = true,
								order = 20,
								args = {
									normal = {
										type = "input",
										name = "Normal",
										desc = "Unit Width to use for standard groups.",
										width = "half",
										order = 10,
										get = function(info) return tostring(db.dps.standards.width.normal) end,
										set = function(info, value)
											value = nibRealUI:ValidateOffset(value, 20, 200)
											db.dps.standards.width.normal = value
											GridLayout:Update()
										end,
									},
								},
							},
							layout = {
								type = "group",
								name = "Unit Layout",
								inline = true,
								order = 30,
								args = {
									horizontalgroups = {
										type = "toggle",
										name = "Horizontal Groups",
										desc = "Enabled: Use Horizontal Groups. Disabled: Use Vertical Groups.",
										get = function() return db.dps.standards.layout.horizontalgroups end,
										set = function(info, value) 
											db.dps.standards.layout.horizontalgroups = value
											GridLayout:Update()
										end,
										order = 10,
									},
								},
							},
						},
					},
					pve = {
						type = "group",
						name = "PvE",
						order = 20,
						args = {
							raid = {
								type = "group",
								name = "Raid",
								inline = true,
								disabled = function() if db.dps.raid.enabled then return false else return true end end,
								order = 10,
								args = {
									note = {
										type = "description",
										name = "Automatically adjusts Grid's layout to match the Raid size.",
										fontSize = "medium",
										order = 10,
									},
									enabled = {
										type = "toggle",
										name = "Enabled",
										desc = "Enable/Disable the automatic adjustment of Grid's Raid layout to match the Raid size.",
										get = function() return db.dps.raid.enabled end,
										set = function(info, value) 
											db.dps.raid.enabled = value
											GridLayout:Update()
										end,
										order = 20,
									},
									maxsize = {
										type = "select",
										name = "Max Size",
										desc = "Largest group size to set Grid to.",
										get = function(info) 
											for k_ts,v_ts in pairs(table_GroupSizes) do
												if v_ts == db.dps.raid.maxsize then return k_ts end
											end
										end,
										set = function(info, value)
											db.dps.raid.maxsize = table_GroupSizes[value]
											GridLayout:Update()
										end,
										style = "dropdown",
										width = nil,
										values = table_GroupSizes,
										order = 30,
									},
									--sep1 = {
									--	type = "description",
									--	name = " ",
									--	order = 35,
									--},
									horizontalgroups = {
										type = "toggle",
										name = "Horizontal Groups",
										desc = "Enabled: Use Horizontal Groups while in a Raid. Disabled: Use Vertical Groups while in a Raid.",
										get = function() return db.dps.raid.horizontalgroups end,
										set = function(info, value) 
											db.dps.raid.horizontalgroups = value
											GridLayout:Update()
										end,
										order = 40,
									},
									--sep2 = {
									--	type = "description",
									--	name = " ",
									--	order = 45,
									--},
									super = {
										type = "input",
										name = "40-man Width",
										desc = "Unit Width for 40-man raids.",
										width = "half",
										order = 50,
										get = function(info) return tostring(db.dps.raid.superwidth) end,
										set = function(info, value)
											value = nibRealUI:ValidateOffset(value, 20, 200)
											db.dps.raid.superwidth = value
											GridLayout:Update()
										end,
									},
								},
							},
							party = {
								type = "group",
								name = "Party",
								order = 20,
								args = {
									note = {
										type = "description",
										name = "Automatically adjusts Grid's layout based on whether you or your party have pets.\n\n No pets = By Group 5.\n Pets = By Group 5 w/pets.",
										fontSize = "medium",
										order = 10,
									},
									enabled = {
										type = "toggle",
										name = "Enabled",
										desc = "Enable/Disable the automatic adjustment to Grid's Party layout",
										get = function() return db.dps.party.enabled end,
										set = function(info, value) 
											db.dps.party.enabled = value
										end,
										order = 20,
									},
								},
							},
						},
					},
					pvp = {
						type = "group",
						name = "Battlegrounds",
						order = 30,
						args = {
							bg = {
								type = "group",
								name = "Battlegrounds",
								inline = true,
								disabled = function() if db.dps.bg.enabled then return false else return true end end,
								order = 10,
								args = {
									note = {
										type = "description",
										name = "Automatically adjusts Grid's layout to match the Battleground's team size.",
										fontSize = "medium",
										order = 10,
									},
									enabled = {
										type = "toggle",
										name = "Enabled",
										desc = "Enable/Disable the automatic adjustment of Grid's Battleground layout to match the Battleground's team size.",
										get = function() return db.dps.bg.enabled end,
										set = function(info, value) 
											db.dps.bg.enabled = value
											GridLayout:Update()
										end,
										order = 20,
									},
									maxsize = {
										type = "select",
										name = "Max Size",
										desc = "Largest group size to set Grid to.",
										get = function(info) 
											for k_ts,v_ts in pairs(table_GroupSizes) do
												if v_ts == db.dps.bg.maxsize then return k_ts end
											end
										end,
										set = function(info, value)
											db.dps.bg.maxsize = table_GroupSizes[value]
											GridLayout:Update()
										end,
										style = "dropdown",
										width = nil,
										values = table_GroupSizes,
										order = 30,
									},
									--sep1 = {
									--	type = "description",
									--	name = " ",
									--	order = 35,
									--},
									horizontalgroups = {
										type = "toggle",
										name = "Horizontal Groups",
										desc = "Enabled: Use Horizontal Groups while in a BG. Disabled: Use Vertical Groups while in a BG.",
										get = function() return db.dps.bg.horizontalgroups end,
										set = function(info, value) 
											db.dps.bg.horizontalgroups = value
											GridLayout:Update()
										end,
										order = 40,
									},
									--sep2 = {
									--	type = "description",
									--	name = " ",
									--	order = 45,
									--},
									super = {
										type = "input",
										name = "40-man Width",
										desc = "Unit Width for 40-man battleground groups.",
										width = "half",
										order = 50,
										get = function(info) return tostring(db.dps.bg.superwidth) end,
										set = function(info, value)
											value = nibRealUI:ValidateOffset(value, 20, 200)
											db.dps.bg.superwidth = value
											GridLayout:Update()
										end,
									},
								},
							},
							arena = {
								type = "group",
								name = "Arena",
								order = 20,
								args = {
									note = {
										type = "description",
										name = "Automatically adjusts Grid's Arena layout based on whether you or your arena team has pets.\n\n No pets = By Group 5.\n Pets = By Group 5 w/pets.",
										fontSize = "medium",
										order = 10,
									},
									enabled = {
										type = "toggle",
										name = "Enabled",
										desc = "Enable/Disable the automatic adjustment to Grid's Arena layout",
										get = function() return db.dps.arena.enabled end,
										set = function(info, value) 
											db.dps.arena.enabled = value
										end,
										order = 20,
									},
								},
							},
						},
					},
				},
			},
			healing = {
				type = "group",
				name = "Healing Layout",
				desc = "Grid Layout settings to apply to the RealUI Healing Layout.",
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				childGroups = "tab",
				order = 50,
				args = {
					standards = {
						type = "group",
						name = "Standard Settings",
						order = 10,
						args = {
							note = {
								type = "description",
								name = "Standard Settings to apply to all Grid Layouts. Specific Grid Layouts may override these settings if they are enabled.",
								fontSize = "medium",
								order = 10,
							},
							width = {
								type = "group",
								name = "Unit Width",
								inline = true,
								order = 20,
								args = {
									normal = {
										type = "input",
										name = "Normal",
										desc = "Unit Width to use for standard groups.",
										width = "half",
										order = 10,
										get = function(info) return tostring(db.healing.standards.width.normal) end,
										set = function(info, value)
											value = nibRealUI:ValidateOffset(value, 20, 200)
											db.healing.standards.width.normal = value
											GridLayout:Update()
										end,
									},
								},
							},
							layout = {
								type = "group",
								name = "Unit Layout",
								inline = true,
								order = 30,
								args = {
									horizontalgroups = {
										type = "toggle",
										name = "Horizontal Groups",
										desc = "Enabled: Use Horizontal Groups. Disabled: Use Vertical Groups.",
										get = function() return db.healing.standards.layout.horizontalgroups end,
										set = function(info, value) 
											db.healing.standards.layout.horizontalgroups = value
											GridLayout:Update()
										end,
										order = 10,
									},
								},
							},
						},
					},
					pve = {
						type = "group",
						name = "PvE",
						order = 20,
						args = {
							raid = {
								type = "group",
								name = "Raid",
								inline = true,
								disabled = function() if db.healing.raid.enabled then return false else return true end end,
								order = 10,
								args = {
									note = {
										type = "description",
										name = "Automatically adjusts Grid's layout to match the Raid size.",
										fontSize = "medium",
										order = 10,
									},
									enabled = {
										type = "toggle",
										name = "Enabled",
										desc = "Enable/Disable the automatic adjustment of Grid's Raid layout to match the Raid size.",
										get = function() return db.healing.raid.enabled end,
										set = function(info, value) 
											db.healing.raid.enabled = value
											GridLayout:Update()
										end,
										order = 20,
									},
									maxsize = {
										type = "select",
										name = "Max Size",
										desc = "Largest group size to set Grid to.",
										get = function(info) 
											for k_ts,v_ts in pairs(table_GroupSizes) do
												if v_ts == db.healing.raid.maxsize then return k_ts end
											end
										end,
										set = function(info, value)
											db.healing.raid.maxsize = table_GroupSizes[value]
											GridLayout:Update()
										end,
										style = "dropdown",
										width = nil,
										values = table_GroupSizes,
										order = 30,
									},
									--sep1 = {
									--	type = "description",
									--	name = " ",
									--	order = 35,
									--},
									horizontalgroups = {
										type = "toggle",
										name = "Horizontal Groups",
										desc = "Enabled: Use Horizontal Groups while in a Raid. Disabled: Use Vertical Groups while in a Raid.",
										get = function() return db.healing.raid.horizontalgroups end,
										set = function(info, value) 
											db.healing.raid.horizontalgroups = value
											GridLayout:Update()
										end,
										order = 40,
									},
									--sep2 = {
									--	type = "description",
									--	name = " ",
									--	order = 45,
									--},
									super = {
										type = "input",
										name = "40-man Width",
										desc = "Unit Width for 40-man raids.",
										width = "half",
										order = 50,
										get = function(info) return tostring(db.healing.raid.superwidth) end,
										set = function(info, value)
											value = nibRealUI:ValidateOffset(value, 20, 200)
											db.healing.raid.superwidth = value
											GridLayout:Update()
										end,
									},
								},
							},
							party = {
								type = "group",
								name = "Party",
								order = 20,
								args = {
									note = {
										type = "description",
										name = "Automatically adjusts Grid's layout based on whether you or your party have pets.\n\n No pets = By Group 5.\n Pets = By Group 5 w/pets.",
										fontSize = "medium",
										order = 10,
									},
									enabled = {
										type = "toggle",
										name = "Enabled",
										desc = "Enable/Disable the automatic adjustment to Grid's Party layout",
										get = function() return db.healing.party.enabled end,
										set = function(info, value) 
											db.healing.party.enabled = value
										end,
										order = 20,
									},
								},
							},
						},
					},
					pvp = {
						type = "group",
						name = "Battlegrounds",
						order = 30,
						args = {
							bg = {
								type = "group",
								name = "Battlegrounds",
								inline = true,
								disabled = function() if db.healing.bg.enabled then return false else return true end end,
								order = 10,
								args = {
									note = {
										type = "description",
										name = "Automatically adjusts Grid's layout to match the Battleground's team size.",
										fontSize = "medium",
										order = 10,
									},
									enabled = {
										type = "toggle",
										name = "Enabled",
										desc = "Enable/Disable the automatic adjustment of Grid's Battleground layout to match the Battleground's team size.",
										get = function() return db.healing.bg.enabled end,
										set = function(info, value) 
											db.healing.bg.enabled = value
											GridLayout:Update()
										end,
										order = 20,
									},
									maxsize = {
										type = "select",
										name = "Max Size",
										desc = "Largest group size to set Grid to.",
										get = function(info) 
											for k_ts,v_ts in pairs(table_GroupSizes) do
												if v_ts == db.healing.bg.maxsize then return k_ts end
											end
										end,
										set = function(info, value)
											db.healing.bg.maxsize = table_GroupSizes[value]
											GridLayout:Update()
										end,
										style = "dropdown",
										width = nil,
										values = table_GroupSizes,
										order = 30,
									},
									--sep1 = {
									--	type = "description",
									--	name = " ",
									--	order = 35,
									--},
									horizontalgroups = {
										type = "toggle",
										name = "Horizontal Groups",
										desc = "Enabled: Use Horizontal Groups while in a BG. Disabled: Use Vertical Groups while in a BG.",
										get = function() return db.healing.bg.horizontalgroups end,
										set = function(info, value) 
											db.healing.bg.horizontalgroups = value
											GridLayout:Update()
										end,
										order = 40,
									},
									--sep2 = {
									--	type = "description",
									--	name = " ",
									--	order = 45,
									--},
									super = {
										type = "input",
										name = "40-man Width",
										desc = "Unit Width for 40-man battleground groups.",
										width = "half",
										order = 50,
										get = function(info) return tostring(db.healing.bg.superwidth) end,
										set = function(info, value)
											value = nibRealUI:ValidateOffset(value, 20, 200)
											db.healing.bg.superwidth = value
											GridLayout:Update()
										end,
									},
								},
							},
							arena = {
								type = "group",
								name = "Arena",
								order = 20,
								args = {
									note = {
										type = "description",
										name = "Automatically adjusts Grid's Arena layout based on whether you or your arena team has pets.\n\n No pets = By Group 5.\n Pets = By Group 5 w/pets.",
										fontSize = "medium",
										order = 10,
									},
									enabled = {
										type = "toggle",
										name = "Enabled",
										desc = "Enable/Disable the automatic adjustment to Grid's Arena layout",
										get = function() return db.healing.arena.enabled end,
										set = function(info, value) 
											db.healing.arena.enabled = value
										end,
										order = 20,
									},
								},
							},
						},
					},
				},
			},
		},
	}
	end
	return options
end

------------------------
---- Layout Updates ----
------------------------
-- Fired when Exiting combat
local LockdownTimer = CreateFrame("Frame")
LockdownTimer.Elapsed = 0
LockdownTimer:Hide()
LockdownTimer:SetScript("OnUpdate", function(self, elapsed)
	LockdownTimer.Elapsed = LockdownTimer.Elapsed + elapsed
	if LockdownTimer.Elapsed >= 1 then
		if not InCombatLockdown() then
			if NeedUpdate then GridLayout:Update() end
			LockdownTimer.Elapsed = 0
			LockdownTimer:Hide()
		else
			-- Repeat timer until combat restrictions are lifted
			LockdownTimer.Elapsed = 0
		end
	end
end);

function GridLayout:UpdateLockdown(...)
	LockdownTimer:Show()
end

-- Reload Grid Layout
local function ReloadGridLayout()
	local ReloadLayoutTimer = CreateFrame("Frame")
	ReloadLayoutTimer:Show()
	ReloadLayoutTimer.Elapsed = 0
	ReloadLayoutTimer:SetScript("OnUpdate", function(self, elapsed)
		ReloadLayoutTimer.Elapsed = ReloadLayoutTimer.Elapsed + elapsed
		if ReloadLayoutTimer.Elapsed >= 0.5 then
			if not InCombatLockdown() then
				if GFM.db.profile.frameWidth ~= NewWidth then
					GridLayout:SendMessage("Grid_ReloadLayout")
				end
				ReloadLayoutTimer.Elapsed = 0
				ReloadLayoutTimer:Hide()
			else
				-- Repeat timer until combat restrictions are lifted
				ReloadLayoutTimer.Elapsed = 0
			end
		end
	end);
end

-- Set Frame Width
local function SetGridFrameWidth(NewWidth)
	local ResizeTimer = CreateFrame("Frame")
	ResizeTimer:Show()
	ResizeTimer.Elapsed = 0
	ResizeTimer:SetScript("OnUpdate", function(self, elapsed)
		ResizeTimer.Elapsed = ResizeTimer.Elapsed + elapsed
		if ResizeTimer.Elapsed >= 0.5 then
			if not InCombatLockdown() then
				if GFM.db.profile.frameWidth ~= NewWidth then
					GFM.db.profile.frameWidth = NewWidth
					GFM:ResizeAllFrames()
					ReloadGridLayout()
				end
				
				ResizeTimer.Elapsed = 0
				ResizeTimer:Hide()
			else
				-- Repeat timer until combat restrictions are lifted
				ResizeTimer.Elapsed = 0
			end
		end
	end);
end

-- Update Grid Layout
function GridLayout:Update()
	if ( (not nibRealUI:GetModuleEnabled(MODNAME)) or not(GLM and GFM) ) then return end

	-- Combat Lockdown checking
	if InCombatLockdown() then
		NeedUpdate = true
		return
	end
	NeedUpdate = false
	---
	
	local LayoutDB
	local NewLayout
	
	-- Get Instance type
	local _, instanceType, difficultyIndex, _, maxPlayers = GetInstanceInfo()
	
	-- Get Map ID
	if not WorldMapFrame:IsShown() then
		CurMapID = GetCurrentMapAreaID()
	end
	
	-- In Tol Barad or Wintergrasp
	local InTB, InWG, In40 = false, false, false
	local _, _, WGActive = GetWorldPVPAreaInfo(1)
	if ( (CurMapID == 708) and UnitInRaid("player") ) then
		InTB = true
	elseif ( (CurMapID == 501) and WGActive and UnitInRaid("player") ) then
		InWG = true
	end
	
	-- Which RealUI Layout we're working on
	if nibRealUI.db.char.layout.current == 1 then
		LayoutDB = db.dps
	else
		LayoutDB = db.healing
	end
	
	-- Find new Grid Layout
	-- Battleground
	if ( ((instanceType == "pvp") or InTB or InWG) and LayoutDB.bg.enabled ) then
		local RaidSize = maxPlayers or 40
		local NewSize = math.min(RaidSize, tonumber(LayoutDB.bg.maxsize))
		
		if NewSize == 10 then
			NewLayout = Grid.L["By Group 10"]
		elseif NewSize == 15 then
			NewLayout = Grid.L["By Group 15"]
		elseif NewSize == 25 then
			NewLayout = Grid.L["By Group 25"]
		elseif NewSize == 40 then
			NewLayout = Grid.L["By Group 40"]
		end
		
		-- Change Grid Layout
		local NewHoriz = LayoutDB.bg.horizontalgroups
		if ( NewLayout and ((NewLayout ~= GLM.db.profile.layouts.bg) or (NewHoriz ~= GLM.db.profile.horizontal)) ) then
			GLM.db.profile.layouts.bg = NewLayout
			GLM.db.profile.horizontal = NewHoriz
			GLM:ReloadLayout()
		end
		
		-- Adjust Grid Frame Width
		local NewWidth
		if NewLayout == Grid.L["By Group 40"] then
			NewWidth = LayoutDB.bg.superwidth
		else
			NewWidth = LayoutDB.standards.width.normal
		end
		SetGridFrameWidth(NewWidth)
		
	-- 5 man group - Adjust w/pets
	elseif ( (instanceType == "arena" and LayoutDB.arena.enabled) or ((instanceType == "party" or nil) and LayoutDB.party.enabled) ) then
		local HasPet = UnitExists("pet") or UnitExists("partypet1") or UnitExists("partypet2") or UnitExists("partypet3") or UnitExists("partypet4")
		if HasPet then 
			NewLayout = Grid.L["By Group 5 w/Pets"]
		else
			NewLayout = Grid.L["By Group 5"]
		end
		
		-- Change Grid Layout
		local NewHoriz = LayoutDB.standards.layout.horizontalgroups
		if ( (instanceType == "arena") and ((NewLayout ~= GLM.db.profile.layouts.arena) or (NewHoriz ~= GLM.db.profile.horizontal)) ) then
			GLM.db.profile.layouts.arena = NewLayout
			GLM.db.profile.horizontal = NewHoriz
			GLM:ReloadLayout()
		elseif ( (instanceType == "party" or nil) and ((NewLayout ~= GLM.db.profile.layouts.party) or (NewHoriz ~= GLM.db.profile.horizontal)) ) then
			GLM.db.profile.layouts.party = NewLayout
			GLM.db.profile.horizontal = NewHoriz
			GLM:ReloadLayout()
		end
		
		-- Adjust Grid Frame Width
		SetGridFrameWidth(LayoutDB.standards.width.normal)

	-- Raid
	elseif (instanceType == "raid"  and LayoutDB.raid.enabled) then
		if difficultyIndex == 3 or 5 then
			NewLayout = Grid.L["By Group 10"]
		elseif difficultyIndex == 4 or 5 or 7 then
			NewLayout = Grid.L["By Group 25"]
		end

		-- Change Grid Layout
		local NewHoriz = LayoutDB.standards.layout.horizontalgroups
		if ( (difficultyIndex == 3 or 5) and ((NewLayout ~= GLM.db.profile.layouts.raid_10) or (NewHoriz ~= GLM.db.profile.horizontal)) ) then
			GLM.db.profile.layouts.raid_10 = NewLayout
			GLM.db.profile.horizontal = NewHoriz
			GLM:ReloadLayout()
		elseif ( (difficultyIndex == 4 or 5 or 7) and ((NewLayout ~= GLM.db.profile.layouts.raid_25) or (NewHoriz ~= GLM.db.profile.horizontal)) ) then
			GLM.db.profile.layouts.raid_25 = NewLayout
			GLM.db.profile.horizontal = NewHoriz
			GLM:ReloadLayout()
		end
		
		-- Adjust Grid Frame Width
		SetGridFrameWidth(LayoutDB.standards.width.normal)

		-- If not BG, Arena, Raid or Dungeon, then set normal values
	else
		local difficulty = GetRaidDifficulty()
		local raidSize = GetNumGroupMembers()
		local newSize = math.min(raidSize, tonumber(LayoutDB.bg.maxsize))

		if newSize > 25 then
			NewLayout = Grid.L["By Group 40"]
		elseif newSize > 15 then
			NewLayout = Grid.L["By Group 25"]
		elseif newSize > 10 then
			NewLayout = Grid.L["By Group 15"]
		elseif newSize > 5 then
			NewLayout = Grid.L["By Group 10"]
		else--if newSize <= 5 then
			NewLayout = Grid.L["By Group 5"]
		end

		-- Change Grid Layout
		local NewHoriz = LayoutDB.standards.layout.horizontalgroups
		if ( (difficulty == 1 or 3) and ((NewLayout ~= GLM.db.profile.layouts.raid_10) or (NewHoriz ~= GLM.db.profile.horizontal)) ) then
			GLM.db.profile.layouts.raid_10 = NewLayout
			GLM.db.profile.horizontal = NewHoriz
			GLM:ReloadLayout()
		elseif ( (difficulty == 2 or 4) and ((NewLayout ~= GLM.db.profile.layouts.raid_25) or (NewHoriz ~= GLM.db.profile.horizontal)) ) then
			GLM.db.profile.layouts.raid_25 = NewLayout
			GLM.db.profile.horizontal = NewHoriz
			GLM:ReloadLayout()
		end

		-- Adjust Grid Frame Width
		local NewWidth
		if NewLayout == Grid.L["By Group 40"] then
			NewWidth = LayoutDB.raid.superwidth
		else
			NewWidth = LayoutDB.standards.width.normal
		end
		SetGridFrameWidth(NewWidth)
	end
	
	-- FrameMover
	if nibRealUI:GetModuleEnabled("FrameMover") then
		local FM = nibRealUI:GetModule("FrameMover", true)
		if FM then FM:MoveAddons() end
	end
end

function GridLayout:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			dps = {
				standards = {
					width = {
						normal = 66,
					},
					layout = {
						horizontalgroups = true,
					},
				},
				raid = {
					enabled = true,
					maxsize = "40",
					horizontalgroups = false,
					superwidth = 47,
				},
				party = {
					enabled = true,
				},
				bg = {
					enabled = true,
					maxsize = "40",
					horizontalgroups = false,
					superwidth = 47,
				},
				arena = {
					enabled = true,
				},
			},
			healing = {
				standards = {
					width = {
						normal = 66,
					},
					layout = {
						horizontalgroups = false,
					},
				},
				raid = {
					enabled = true,
					maxsize = "40",
					horizontalgroups = false,
					superwidth = 47,
				},
				party = {
					enabled = true,
				},
				bg = {
					enabled = true,
					maxsize = "40",
					horizontalgroups = false,
					superwidth = 47,
				},
				arena = {
					enabled = true,
				},
			},
			healthupdates = {
				enabled = true,
				frequency = 10,
			},
		},
	})
	db = self.db.profile
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterPlainOptions(MODNAME, GetOptions)
	
	-- Find Grid / modules
	if IsAddOnLoaded("Grid") then
		Grid = _G.Grid
		if Grid then 
			GLM = Grid:GetModule("GridLayout", true)
			GFM = Grid:GetModule("GridFrame", true)
			GSM = Grid:GetModule("GridStatus", true)
			if GSM then GSHM = GSM:GetModule("GridStatusHealth", true) end
			GLF = _G["GridLayoutFrame"]
		end
	end
end

function GridLayout:OnEnable()
	if not(GLM and GFM) then return end
	
	self:RegisterBucketEvent({"PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA", "GROUP_ROSTER_UPDATE", "UNIT_PET"}, 1.1, "Update")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateLockdown")
	
	WorldMapFrame:HookScript("OnHide", function() GridLayout:Update() end)
	GridLayout:Update()
end

function GridLayout:OnDisable()
	self:UnregisterAllBuckets()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	WorldMapFrame:HookScript("OnHide", function() end)
end