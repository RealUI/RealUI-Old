local nibRealUI = LibStub("AceAddon-3.0"):NewAddon("nibRealUI", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("nibRealUI")
local LSM = LibStub("LibSharedMedia-3.0")
local db, dbc, dbg
_G.RealUI = nibRealUI

nibRealUI.verinfo = {
	[1] = 7,
	[2] = 4,
	[3] = 1,
}

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
		},
		minipatches = {},
		extrasettings = {
			skada = false,
		},
		resolution = 1,
	},
	char = {
		installation = {
			stage = 0,
			verinfo = {
				[1] = 0,
				[2] = 0,
				[3] = 0,
			},
		},
		layout = {
			current = 1,
			needchanged = false,
			spec = {1, 1},
		},
		resolution = 1,	-- So we can check to make sure each Char is on the correct Res
		cbResetNew = false,	-- Reset New items for cargBags on character's first load
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
				border = [[Interface\AddOns\nibRealUI\Media\Glow.tga]],
				background = [[Interface\AddOns\nibRealUI\Media\media\BG1.tga]],
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

TABLE_STRATAS = {
	"BACKGROUND",
	"LOW",
	"MEDIUM",
	"HIGH",
	"DIALOG",
	"TOOLTIP",
}

TABLE_OUTLINES = {
	"NONE",
	"OUTLINE",
	"THINOUTLINE",
	"THICKOUTLINE",
}

-- Memory Display
local function FormatMem(memory)
	if ( memory > 999 ) then
		return format("%.1f |cff%s%s|r", memory/1024, "ff8030", "MiB")
	else
		return format("%.1f |cff%s%s|r", memory, "80ff30", "KB")
	end
end

function nibRealUI:MemoryDisplay()
	local addons, total = {}, 0
	UpdateAddOnMemoryUsage()
	local memory = gcinfo()
	
	for i = 1, GetNumAddOns() do
		if ( IsAddOnLoaded(i) ) then
			table.insert(addons, { GetAddOnInfo(i), GetAddOnMemoryUsage(i) })
			total = total + GetAddOnMemoryUsage(i)
		end
	end
	
	table.sort(addons, (function(a, b) return a[2] > b[2] end))
	
	local userMem = format("|cff00ffffMemory usage: |r%.1f |cffff8030%s|r", total/1024, "MiB")
	print(userMem)
	print("-------------------------------")
	for key, val in pairs(addons) do
		if ( key <= 20 ) then
			print(FormatMem(val[2]).."  -  "..val[1])
		end
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
	local IsNewVer, IsOneMore = false, false
	
	if ( (CurVer[1] > OldVer[1]) or (CurVer[2] > OldVer[2]) ) then
		IsNewVer = true
	else
		IsOneMore = true
	end
	
	return IsNewVer, IsOneMore
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
	local resStr = GetCVar("gxResolution")
	local resHeight = tonumber(string.match(resStr, "%d+x(%d+)"))
	local resWidth = tonumber(string.match(resStr, "(%d+)x%d+"))
	if resHeight < 900 then
		return 1
	else
		return 2
	end
end

---- LAYOUTS
-- Profiles
function nibRealUI:SetAddonProfileKeys()
	-- Refresh Key
	self.key = string.format("%s - %s", UnitName("player"), GetRealmName())
	
	local ResProfileTag = (dbc.resolution == 2) and "-HR" or ""
	local LayoutProfileTag = (dbc.layout.current == 2) and "-Healing" or ""
	local NewProfileRes = "RealUI" .. ResProfileTag
	local NewProfileLayout = "RealUI" .. ResProfileTag .. LayoutProfileTag
	
	-- Addons that just need to be set to RealUI
	local nonLayoutAddonList = {
		"ChatterDB",
		"MasqueDB",
	}
	-- Any Addons which need a Layout profile change, also changes Res
	local LayoutAddonList = {
		"Bartender4DB",
		"GridDB",
	}
	-- Any Addons which aren't in the Layout list, but still need a Res profile change
	local ResAddonList = {
		"RavenDB",
		"SkadaDB",
		"IceCoreRealUIDB",
	}
	
	-- Set Addon profiles
	for kn, vn in pairs(nonLayoutAddonList) do
		if _G[vn] then
			if _G[vn]["profileKeys"] then 
				_G[vn]["profileKeys"][self.key] = "RealUI"
			end
		end
	end
	for kl, vl in pairs(LayoutAddonList) do
		if _G[vl] then
			if _G[vl]["profileKeys"] then 
				_G[vl]["profileKeys"][self.key] = NewProfileLayout
			end
		end
	end
	for kr, vr in pairs(ResAddonList) do
		if _G[vr] then
			if _G[vr]["profileKeys"] then 
				_G[vr]["profileKeys"][self.key] = NewProfileRes
			end
		end
	end
	
	-- MSBT
	if MSBTProfiles_SavedVars then
		if MSBTProfiles_SavedVars["profiles"][NewProfileRes] then
			MSBTProfiles_SavedVarsPerChar["currentProfileName"] = NewProfileRes
		end
	end
end

function nibRealUI:SetLayoutProfiles()
	local ResProfileTag = (dbc.resolution == 2) and "-HR" or ""
	local LayoutProfileTag = (dbc.layout.current == 2) and "-Healing" or ""
	local NewProfileLayout = "RealUI" .. ResProfileTag .. LayoutProfileTag
	
	local LayoutAddonList = {
		Bartender4 = LibStub("AceAddon-3.0"):GetAddon("Bartender4", true),
		Grid = LibStub("AceAddon-3.0"):GetAddon("Grid", true),
	}
	
	for kl, vl in pairs(LayoutAddonList) do
		if vl then
			if vl.db then vl.db:SetProfile(NewProfileLayout) end
		end
	end
end

-- Resolution Updates
function nibRealUI:SetResolution()
	nibRealUI:SetAddonProfileKeys()
end
function nibRealUI:UpdateResolution()
	if not InCombatLockdown() then
		nibRealUI:SetResolution()
		nibRealUI:ReloadUIDialog()
	end
end

-- Layout Updates
function nibRealUI:SetLayout()
	nibRealUI:SetLayoutProfiles()
	
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
	nibRealUI:GetModule("HuDConfig"):RegisterForUpdate("AB", 0.05)
end
function nibRealUI:UpdateLayout()
	if InCombatLockdown() then
		-- Store variable to change layout after combat ends
		dbc.layout.needchanged = true
		nibRealUI:Notification("RealUI", true, L["Layout will change after you leave combat."])
	else
		dbc.layout.needchanged = false
		nibRealUI:SetLayout()
	end
end

-- Lockdown check, out-of-combat updates
function nibRealUI:OOCUpdates()
	if not InCombatLockdown() then
		if dbc.layout.needchanged then nibRealUI:UpdateLayout() end
	end
end
local LockdownTimer = CreateFrame("Frame")
LockdownTimer.Elapsed = 0
LockdownTimer:Hide()
LockdownTimer:SetScript("OnUpdate", function(self, elapsed)
	LockdownTimer.Elapsed = LockdownTimer.Elapsed + elapsed
	if LockdownTimer.Elapsed >= 1 then
		if not InCombatLockdown() then
			nibRealUI:OOCUpdates()
			LockdownTimer.Elapsed = 0
			LockdownTimer:Hide()
		else
			LockdownTimer.Elapsed = 0
		end
	end
end)
function nibRealUI:UpdateLockdown(...)
	LockdownTimer:Show()
end

-- Events
function nibRealUI:VARIABLES_LOADED()
	nibRealUI:UpdateUIScale()
end

function nibRealUI:UPDATE_PENDING_MAIL()
	self:UnregisterEvent("UPDATE_PENDING_MAIL")
	CancelEmote()	-- Cancel Map Holding animation
end

function nibRealUI:PLAYER_ENTERING_WORLD()
	nibRealUI:SetChatPosition()
	nibRealUI:OOCUpdates()
end

function nibRealUI:UI_SCALE_CHANGED()
	nibRealUI:UpdateUIScale()
end

function nibRealUI:PLAYER_LOGIN()
	-- Load LOD AddOns
	LoadAddOn("alDamageMeter")
	if alDM_ResetCurrent then alDM_ResetCurrent() end
	LoadAddOn("nibIceHUD")
	
	-- Load any extra AddOn settings
	if IsAddOnLoaded("Skada") and not(dbg.extrasettings.skada) and dbg.tags.tutorialdone then
		self:LoadSkadaData()
		self:Notification("Skada detected", true, "Reload UI (/rl) to apply RealUI settings.")
	end
	
	-- Check if Installation/Patch is necessary
	nibRealUI:InstallProcedure()
	
	-- Tutorial
	if not dbg.tags.tutorialdone and dbg.tags.needtutorial and (nibRealUICharacter.installStage == -1) then
		nibRealUI:InitTutorial()
	end
end

function nibRealUI:ADDON_LOADED(event, addon)
	if addon ~= "nibRealUI" then return end
	
	-- Open before login to stop taint
	ToggleFrame(SpellBookFrame)
	PetJournal_LoadUI()
	
	-- Remove Interface Options cancel button because it = taint
	-- Remove the cancel button
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
	nibRealUI:RegisterChatCommand("memory", "MemoryDisplay")
	
	-- Done
	print(format("RealUI %s loaded.", nibRealUI:GetVerString(true)))
	print("|cffFFFFFFType |r|cFFFF8000/hud|r |cffFFFFFFto access the new HuD Configuration utility.|r")
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