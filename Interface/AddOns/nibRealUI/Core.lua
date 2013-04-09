local nibRealUI = LibStub("AceAddon-3.0"):NewAddon("nibRealUI", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("nibRealUI")
local LSM = LibStub("LibSharedMedia-3.0")
local db, dbc, dbg
_G.RealUI = nibRealUI

nibRealUI.verinfo = {
	[1] = 7,
	[2] = 4,
	[3] = 5,
}

-- nibRealUI.oocFunctionOrder = {}
nibRealUI.oocFunctions = {}

nibRealUI.defaultpositions = {
	-- Low Res
	[1] = {
		["Nothing"] = 0,
		["HuDX"] = 0,
		["HuDY"] = -38,
		["BIY"] = 0,
		["UFHorizontal"] = 0,
		["ActionBarsX"] = -171.5,
		["ActionBarsY"] = -155.5,
		["HuDWidth"] = 282,		-- Outer edge of CastBar to TargetCastBar
		["HuDHeight"] = 182,	-- Top to Bottom of CastBar
		["UFWidth"] = 223,
	},
	-- High Res
	[2] = {
		["Nothing"] = 0,
		["HuDX"] = 0,
		["HuDY"] = -38,
		["BIY"] = 0,
		["UFHorizontal"] = 0,
		["ActionBarsX"] = -171.5,
		["ActionBarsY"] = -155.5,
		["HuDWidth"] = 282,		-- Outer edge of CastBar to TargetCastBar
		["HuDHeight"] = 182,	-- Top to Bottom of CastBar
		["UFWidth"] = 243,
	},
}

-- Default Options
local defaults = {
	global = {
		tags = {
			firsttime = true,
			needtutorial = true,
			tutorialdone = false,
			ldOptimized = false,
		},
		messages = {
			ldOptimized = false,
		},
		minipatches = {},
		extrasettings = {
			skada = false,
		},
		resolution = 1,
	},
	char = {
		layout = {
			current = 1,
			needchanged = false,
			spec = {1, 1},
		},
		resolution = 1,		-- So we can check to make sure each Char is on the correct Res
	},
	profile = {
		modules = {
			['*'] = true,
		},
		-- Control positioning and sizes of RealUI elements
		positions = nibRealUI.defaultpositions,
		addonControl = {
			actionBars = true,
			grid = true,
			msbt = true,
		},
		-- Media
		media = {
			backgroundalpha = 0.8,
			textures = {
				plain = [[Interface\AddOns\nibRealUI\Media\Plain.tga]],
				plain80 = [[Interface\AddOns\nibRealUI\Media\Plain80.tga]],
				border = [[Interface\AddOns\nibRealUI\Media\Plain.tga]],
			},
			colors = {
				red = {0.75, 0.2, 0.2, 1},
			},
			font = {
				standard = {"Standard"},
				pixel = {
					lowres = {
						small = {"pixel_lr_small", 8, "MONOCHROMEOUTLINE"},
						large = {"pixel_lr_large", 8, "MONOCHROMEOUTLINE"},
					},
					highres = {
						small = {"pixel_hr_small", 8, "MONOCHROMEOUTLINE"},
						large = {"pixel_hr_large", 8, "MONOCHROMEOUTLINE"},
					},
				},
			},
		},
		-- Other
		other = {
			uiscaler = true,
		},
	},
}

function nibRealUI:SetLDOptimizations()
	db.positions[2]["HuDWidth"] = 328
	db.positions[2]["UFHorizontal"] = 10
	dbg.tags.ldOptimized = true
end

function nibRealUI:LDOptimizationCheck()
	local resWidth, resHeight = nibRealUI:GetResolutionVals()
	if (resWidth >= 1600) and (resHeight >= 1050) and not(dbg.tags.ldOptimized) and (dbc.resolution == 2) then
		StaticPopupDialogs["PUDRUILDOC"] = {
			text = "|cff85e0ff"..L["RealUI Large Display Optimizations"].."|r\n\n|cffffffff"..L["RealUI has been optimized for large displays."].."\n\n"..L["Reload UI now to apply these changes?"],
			button1 = "Yes",
			button2 = "No",
			OnAccept = function()
				local dbp, dp = db.positions, self.defaultpositions
				if (dbp[2]["HuDWidth"] == dp[2]["HuDWidth"]) and (dbp[2]["UFHorizontal"] == dp[2]["UFHorizontal"]) then
					nibRealUI:SetLDOptimizations()
				end
				dbg.tags.ldOptimized = true
				self:GetModule("HuDConfig"):RegisterForUpdate("AB")
				nibRealUI:ReloadUIDialog()
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = false,
			notClosableByLogout = false,
		}
		StaticPopup_Show("PUDRUILDOC")
	end
end

-- Version info retrieval
function nibRealUI:GetVerString(...)
	if ... then
		return string.format("|cFFFF8000%s|r.|cFF00D8FF%s|r |cff30ff30r%s|r", nibRealUI.verinfo[1], nibRealUI.verinfo[2], nibRealUI.verinfo[3])
	else
		return string.format("%s.%s", nibRealUI.verinfo[1], nibRealUI.verinfo[2])
	end
end
function nibRealUI:GetVerDifference(OldVer, CurVer)
	local IsNewVer = false
	
	if ( (CurVer[1] > OldVer[1]) or (CurVer[2] > OldVer[2]) ) then
		IsNewVer = true
	end
	
	return IsNewVer
end

-- UI Scaler
local ScaleOptionsHidden
function nibRealUI:UpdateUIScale()
	if db.other.uiscaler and not nibRealUI.uiscalechanging then
		nibRealUI.uiscalechanging = true
		local scale = 768 / string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")
		if scale < .64 then
			UIParent:SetScale(scale)
		else
			SetCVar("uiScale", scale)
		end
		if not ScaleOptionsHidden then
			_G["Advanced_UseUIScale"]:Hide()
			_G["Advanced_UIScaleSlider"]:Hide()
			ScaleOptionsHidden = true
		end
		nibRealUI.uiscalechanging = false
	end
end

-- Recommended resolution
function nibRealUI:GetRecommendedResolution()
	local resWidth, resHeight = self:GetResolutionVals()
	return (resHeight < 900) and 1 or 2
end

-- Resolution Updates
function nibRealUI:SetResolution()
	nibRealUI:Profiles_SetKeys()
end
function nibRealUI:UpdateResolution()
	if not InCombatLockdown() then
		nibRealUI:SetResolution()
		nibRealUI:ReloadUIDialog()
	end
end

-- Layout Updates
function nibRealUI:SetLayout()
	nibRealUI:Profiles_SetLayout()
	
	-- FrameMover
	if nibRealUI:GetModuleEnabled("FrameMover") then
		local FM = nibRealUI:GetModule("FrameMover", true)
		if FM then FM:MoveAddons() end
	end
	
	-- ActionBarExtras
	if nibRealUI:GetModuleEnabled("ActionBarExtras") then
		local ABE = nibRealUI:GetModule("ActionBarExtras", true)
		if ABE then ABE:RefreshMod() end
	end
	
	-- Grid Layout changer
	if nibRealUI:GetModuleEnabled("GridLayout") then
		local GL = nibRealUI:GetModule("GridLayout", true)
		if GL then GL:Update() end
	end
	
	-- Layout Button (For Installation)
	if nibRealUI:GetModuleEnabled("InfoLine") then
		local IL = nibRealUI:GetModule("InfoLine", true)
		if IL then IL:Refresh() end
	end
	
	-- HuD Config
	nibRealUI:GetModule("HuDConfig"):RegisterForUpdate("AB")

	dbc.layout.needchanged = false
end
function nibRealUI:UpdateLayout()
	if InCombatLockdown() then
		if not self.oocFunctions["SetLayout"] then
			self:RegisterLockdownUpdate("SetLayout", function() nibRealUI:SetLayout() end)
			dbc.layout.needchanged = true
		end
		nibRealUI:Notification("RealUI", true, L["Layout will change after you leave combat."])
	else
		self.oocFunctions["SetLayout"] = nil
		nibRealUI:SetLayout()
	end
end

-- Lockdown check, out-of-combat updates
function nibRealUI:LockdownUpdates()
	if not InCombatLockdown() then
		local stillProcessing
		for k, fun in pairs(self.oocFunctions) do
			self.oocFunctions[k] = nil
			if type(fun) == "function" then
				fun()
				stillProcessing = true
				break
			end
		end
		if not stillProcessing then
			self:CancelTimer(self.lockdownTimer)
			self.lockdownTimer = nil
		end
	end
end
function nibRealUI:UpdateLockdown(...)
	if not self.lockdownTimer then self.lockdownTimer = self:ScheduleRepeatingTimer("LockdownUpdates", 0.5) end
end
function nibRealUI:RegisterLockdownUpdate(id, fun, ...)
	local retVal = ...
	if not InCombatLockdown() then
		self.oocFunctions[id] = nil
		fun(retVal)
	else
		self.oocFunctions[id] = function() fun(retVal) end
	end
end

-- Events
function nibRealUI:VARIABLES_LOADED()
	nibRealUI:UpdateUIScale()
end

function nibRealUI:UPDATE_PENDING_MAIL()
	self:UnregisterEvent("UPDATE_PENDING_MAIL")
	CancelEmote()	-- Cancel Map Holding animation
end

local lastGarbageCollection = 0
function nibRealUI:PLAYER_ENTERING_WORLD()
	nibRealUI:SetChatPosition()
	nibRealUI:LockdownUpdates()
	self:ScheduleTimer(function() 
		local now = GetTime()
		if now >= lastGarbageCollection + 600 then
			collectgarbage("collect")
			lastGarbageCollection = now
		end
	end, 1)
end

function nibRealUI:UI_SCALE_CHANGED()
	nibRealUI:UpdateUIScale()
end

function nibRealUI:PLAYER_LOGIN()
	-- Load LOD AddOns
	if not IsAddOnLoaded("Skada") then
		LoadAddOn("alDamageMeter")
		if alDM_ResetCurrent then alDM_ResetCurrent() end
	end
	LoadAddOn("nibIceHUD")
	
	-- Load any extra AddOn settings
	self:LoadSkadaData()

	-- Large Display optimization check
	if (nibRealUICharacter and nibRealUICharacter.installStage == -1) then
		self:LDOptimizationCheck()
	end
	
	-- Check if Installation/Patch is necessary
	self:InstallProcedure()
	
	-- Tutorial
	if not dbg.tags.tutorialdone and dbg.tags.needtutorial and (nibRealUICharacter and nibRealUICharacter.installStage == -1) then
		self:InitTutorial()
	end

	-- Do we need a Layout change?
	if dbc.layout.needchanged then
		nibRealUI:UpdateLayout()
	end
end

function nibRealUI:ADDON_LOADED(event, addon)
	if addon ~= "nibRealUI" then return end
	
	-- Open before login to stop taint
	ToggleFrame(SpellBookFrame)
	PetJournal_LoadUI()
	
	-- Remove Interface Options cancel button because it = taint
	InterfaceOptionsFrameCancel:Hide()
	InterfaceOptionsFrameOkay:SetAllPoints(InterfaceOptionsFrameCancel)

	-- Make clicking cancel the same as clicking okay
	InterfaceOptionsFrameCancel:SetScript("OnClick", function()
		InterfaceOptionsFrameOkay:Click()
	end)
end

function nibRealUI:OnInitialize()
	-- Initialize settings, options, slash commands
	self.db = LibStub("AceDB-3.0"):New("nibRealUIDB", defaults, "RealUI")
	db = self.db.profile
	dbc = self.db.char
	dbg = self.db.global
	self.media = db.media
	
	-- Vars
	self.realm = GetRealmName()
	self.faction = UnitFactionGroup("player")
	self.class = select(2, UnitClass("player"))
	self.name = UnitName("player")
	self.key = string.format("%s - %s", self.name, self.realm)
	
	-- Profile change
	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")
	
	-- Initial Options setup
	nibRealUI:SetUpInitialOptions()
	
	-- Register events
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("UI_SCALE_CHANGED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateLockdown")
	self:RegisterEvent("VARIABLES_LOADED")
	self:RegisterEvent("UPDATE_PENDING_MAIL")
	
	-- Chat Commands
	self:RegisterChatCommand("real", function() nibRealUI:OpenOptions() end)
	self:RegisterChatCommand("realui", function() nibRealUI:OpenOptions() end)
	self:RegisterChatCommand("memory", "MemoryDisplay")
	self:RegisterChatCommand("rl", function() ReloadUI() end)

	-- Synch user's settings
	if dbg.tags.firsttime then
		SetCVar("synchronizeSettings", 1)
		SetCVar("synchronizeConfig", 1)
		SetCVar("synchronizeBindings", 1)
		SetCVar("synchronizeMacros", 1)
	end
	
	-- Done
	print(format("RealUI %s loaded.", nibRealUI:GetVerString(true)))
	if dbg.tags.ldOptimized and not dbg.messages.ldOptimized then
		print(L["Large Display optimizations set."])
		dbg.messages.ldOptimized = true
	end
	if nibRealUICharacter and nibRealUICharacter.installStage == -1 then
		print("|cffFFFFFFType |r|cFFFF8000/hud|r |cffFFFFFFto access the new HuD Configuration utility.|r")
	end
end

function nibRealUI:GetModuleEnabled(module)
	return db.modules[module]
end

function nibRealUI:SetModuleEnabled(module, value)
	local old = db.modules[module]
	db.modules[module] = value
	if old ~= value then
		if value then
			self:EnableModule(module)
		else
			self:DisableModule(module)
		end
	end
end

function nibRealUI:Refresh()	
	db = self.db.profile
	dbc = self.db.char
	dbg = self.db.global
	self.media = db.media
	
	for key, val in self:IterateModules() do
		if self:GetModuleEnabled(key) and not val:IsEnabled() then
			self:EnableModule(key)
		elseif not self:GetModuleEnabled(key) and val:IsEnabled() then
			self:DisableModule(key)
		end
		if val.RefreshMod then
			if type(val.RefreshMod) == "function" and val:IsEnabled() then
				val:RefreshMod()
			end
		end
	end	
	nibRealUI:ConfigRefresh()
	nibRealUI:ReloadUIDialog()
end