local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local MODNAME = "CombatFader"
local CombatFader = nibRealUI:NewModule(MODNAME, "AceEvent-3.0", "AceBucket-3.0")

local _G = getfenv(0)
local _

local LoggedIn = false
local FirstLog = true

local FadeTime = 0.25
local status = "INCOMBAT"
local frames

-- Options
local curFList = {}
local function GetFrameList(element)
	local cnt = 1
	wipe(curFList)
	for k, v in pairs(db.elements[element].frames) do
		curFList[cnt] = k
		cnt = cnt + 1
	end
	return curFList
end

local function GetEnabledFrame(element, key)
	return db.elements[element].frames[curFList[key]]
end

local function SetEnabledFrame(element, key, value)
	db.elements[element].frames[curFList[key]] = value
end

local options
local function GetOptions()
	if not options then 
		options = {
			type = "group",
			name = "Combat Fader",
			desc = "Controls the fading of frames based on player status.",
			childGroups = "tree",
			arg = MODNAME,
			order = 315,
			args = {
				header = {
					type = "header",
					name = "Combat Fader",
					order = 10,
				},
				desc = {
					type = "description",
					name = "Controls the fading of frames based on player status.",
					fontSize = "medium",
					order = 15,
				},
				enabled = {
					type = "toggle",
					name = "Enabled",
					desc = "Enable/Disable the Combat Fader module.",
					get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
					set = function(info, value) 
						nibRealUI:SetModuleEnabled(MODNAME, value)
						if ( nibRealUI:GetModuleEnabled(MODNAME) ) then
							CombatFader:RefreshMod()
						end
					end,
					order = 20,
				},
			},
		}
	end
	
	-- Elements
	local elementOrder, elementOpts = 30, {}
	for ke, ve in pairs(db.elements) do
		if ke ~= "raven" then
			elementOpts[ke] = {
				type = "group",
				name = db.elements[ke].name,
				disabled = function() if (IsAddOnLoaded("oUF") and nibRealUI:GetModuleEnabled(MODNAME)) then return false else return true end end,
				order = elementOrder,
				args = {
					header = {
						type = "header",
						name = db.elements[ke].name,
						order = 10,
					},
					enabled = {
						type = "toggle",
						name = "Enabled",
						get = function(info) return db.elements[ke].enabled end,
						set = function(info, value)
							db.elements[ke].enabled = value
							CombatFader:OptionsRefresh()
						end,
						order = 20,
					},
					opacity = {
						type = "group",
						name = "Opacity",
						inline = true,
						disabled = function() return not db.elements[ke].enabled end,
						order = 30,
						args = {},
					},
					frames = {
						type = "multiselect",
						name = "Frames",
						width = "full",
						get = function(info, key) return GetEnabledFrame(ke, key) end,
						set = function(info, key, value) SetEnabledFrame(ke, key, value) end,
						values = function(info) return GetFrameList(ke) end,
						order = 40,
					},
				},
			}
			
			-- Opacity
			local opacityOpts = {}
			if not db.elements[ke].inverse then
				opacityOpts = {
					incombat = {
						type = "range",
						name = "In-combat",
						min = 0, max = 1, step = 0.05,
						isPercent = true,
						get = function(info) return db.elements[ke].opacity.incombat end,
						set = function(info, value)
							db.elements[ke].opacity.incombat = value
							CombatFader:OptionsRefresh()
						end,
						order = 10,
					},
					hurt = {
						type = "range",
						name = "Hurt",
						min = 0, max = 1, step = 0.05,
						isPercent = true,
						get = function(info) return db.elements[ke].opacity.hurt end,
						set = function(info, value) 
							db.elements[ke].opacity.hurt = value
							CombatFader:OptionsRefresh()
						end,
						order = 20,
					},
					target = {
						type = "range",
						name = "Target-selected",
						min = 0, max = 1, step = 0.05,
						isPercent = true,
						get = function(info) return db.elements[ke].opacity.target end,
						set = function(info, value)
							db.elements[ke].opacity.target = value
							CombatFader:OptionsRefresh()
						end,
						order = 30,
					},
					outofcombat = {
						type = "range",
						name = "Out-of-combat",
						min = 0, max = 1, step = 0.05,
						isPercent = true,
						get = function(info) return db.elements[ke].opacity.outofcombat end,
						set = function(info, value)
							db.elements[ke].opacity.outofcombat = value
							CombatFader:OptionsRefresh()
						end,
						order = 40,
					},
				}
			else
				opacityOpts = {
					incombat = {
						type = "range",
						name = "In-combat",
						min = 0, max = 1, step = 0.05,
						isPercent = true,
						get = function(info) return db.elements[ke].opacity.incombat end,
						set = function(info, value)
							db.elements[ke].opacity.incombat = value
							CombatFader:OptionsRefresh()
						end,
						order = 10,
					},
					harmtarget = {
						type = "range",
						name = "Attackable Target",
						min = 0, max = 1, step = 0.05,
						isPercent = true,
						get = function(info) return db.elements[ke].opacity.harmtarget end,
						set = function(info, value)
							db.elements[ke].opacity.harmtarget = value
							CombatFader:OptionsRefresh()
						end,
						order = 20,
					},
					outofcombat = {
						type = "range",
						name = "Out-of-combat",
						min = 0, max = 1, step = 0.05,
						isPercent = true,
						get = function(info) return db.elements[ke].opacity.outofcombat end,
						set = function(info, value)
							db.elements[ke].opacity.outofcombat = value
							CombatFader:OptionsRefresh()
						end,
						order = 30,
					},
				}
			end
			elementOpts[ke].args.opacity.args = opacityOpts
			
			elementOrder = elementOrder + 10
		end
	end
	
	for key, val in pairs(elementOpts) do
		options.args[key] = (type(val) == "function") and val() or val
	end
	
	return options
end

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
	RUNIC_POWER = function()
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
function CombatFader:FadeFrames()
	local NewOpacity
	for k,v in pairs(db.elements) do
		if db.elements[k].enabled then
			-- Retrieve Element's opacity/visibility for current status
			NewOpacity = 1
			if status == "INCOMBAT" then
				if db.elements[k].opacity.incombat ~= nil then
					NewOpacity = db.elements[k].opacity.incombat
				end
			elseif status == "TARGET" then
				if (db.elements[k].opacity.harmtarget == nil and db.elements[k].opacity.target ~= nil) then
					NewOpacity = db.elements[k].opacity.target
				elseif db.elements[k].opacity.harmtarget ~= nil then
					NewOpacity = db.elements[k].opacity.outofcombat
				end
			elseif status == "HARMTARGET" then
				if db.elements[k].opacity.harmtarget ~= nil then
					NewOpacity = db.elements[k].opacity.harmtarget
				else
					if db.elements[k].opacity.target ~= nil then
						NewOpacity = db.elements[k].opacity.target
					end
				end
			elseif status == "HURT" then
				if (db.elements[k].opacity.harmtarget == nil and db.elements[k].opacity.hurt ~= nil) then
					NewOpacity = db.elements[k].opacity.hurt
				end
			elseif status == "OUTOFCOMBAT" then
				if db.elements[k].opacity.outofcombat ~= nil then
					NewOpacity = db.elements[k].opacity.outofcombat
				end
			end

			-- Fade Frames
			if db.elements[k].frames then
				local frame
				for k2, v2 in pairs(db.elements[k].frames) do
					if db.elements[k].frames[k2] then
						frame = _G[k2]
						if frame then FadeIt(frame, NewOpacity) end
					end
				end
			end
		end
	end
end

-- Update current status
function CombatFader:UpdateStatus()
	local OldStatus = status
	if UnitAffectingCombat("player") then
		status = "INCOMBAT"					-- InCombat - Priority 1
	elseif UnitExists("target") then
		if UnitCanAttack("player", "target") then
			status = "HARMTARGET"			-- HarmTarget - Priority 2
		else
			status = "TARGET"				-- Target - Priority 3
		end
	elseif UnitHealth("player") < UnitHealthMax("player") then
		status = "HURT"						-- Hurt - Priority 4
	else
		local _, power_token = UnitPowerType("player")
		local func = power_check[power_token]
		if func and func() then
			status = "HURT"
		else
			status = "OUTOFCOMBAT"			-- OutOfCombat - Priority 5
		end
	end
	if status ~= OldStatus then CombatFader:FadeFrames() end		
end

function CombatFader:HurtEvent(units)
	if not units then return end
	
	if units.player then CombatFader:UpdateStatus() end
end

-- On combat state change
function CombatFader:UpdateCombatState(event)
	-- If in combat, then don't worry about health/power events
	if UnitAffectingCombat("player") and not FirstLog then
		self:UnregisterAllBuckets()
	else
		self:RegisterBucketEvent({"UNIT_HEALTH", "UNIT_POWER", "UNIT_DISPLAYPOWER"}, 0.1, "HurtEvent")
		if event == "PLAYER_REGEN_DISABLED" or event == "PLAYER_REGEN_ENABLED" then
			FirstLog = false
		end
	end
	CombatFader:UpdateStatus()
end

----
function CombatFader:RefreshMod()
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end

	db = self.db.profile
	
	status = nil
	CombatFader:UpdateStatus()
	CombatFader:FadeFrames()
end

function CombatFader:OptionsRefresh()
	status = nil
	CombatFader:UpdateStatus()
end

function CombatFader:PLAYER_ENTERING_WORLD()
	LoggedIn = true

	CombatFader:UpdateCombatState()
	CombatFader:FadeFrames()
end

function CombatFader:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
    self.db:RegisterDefaults({
        profile = {
            elements = {
				["**"] = {
					enabled = true,
					opacity = {
						incombat = 1,
						hurt = 0.8,
						target = 0.8,
						outofcombat = 0.3,
					},
				},
				unitframes = {
					name = "Unit Frames",
					frames = {
						["oUF_RealUIPlayer_Overlay"] = true,
						["oUF_RealUITarget_Overlay"] = true,
						["oUF_RealUIFocus_Overlay"] = true,
						["oUF_RealUIFocusTarget_Overlay"] = true,
						["oUF_RealUITargetTarget_Overlay"] = true,
						--["oUF_RealUIMaintank_Overlay"] = true,
					},
				},
				watchframe = {
					name = "Watch Frame",
					inverse = true,
					frames = {
						["WatchFrame"] = true,
					},
					opacity = {
						incombat = 0.5,
						harmtarget = 0.75,
						outofcombat = 1,
					},
				},
			},
        },
    })
	db = self.db.profile
    
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterPlainOptions(MODNAME, GetOptions)
end

function CombatFader:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateStatus")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateCombatState")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "UpdateCombatState")
	CombatFader:UpdateCombatState()
	
	if LoggedIn then CombatFader:RefreshMod() end
end

function CombatFader:OnDisable()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("PLAYER_TARGET_CHANGED")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	self:UnregisterAllBuckets()
end