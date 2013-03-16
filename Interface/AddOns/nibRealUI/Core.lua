local nibRealUI = LibStub("AceAddon-3.0"):NewAddon("nibRealUI", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("nibRealUI")
local LSM = LibStub("LibSharedMedia-3.0")
local db, dbc, dbg

local nibRealUI_Version = {
	[1] = 7,
	[2] = 3,
	[3] = 22,
}

-- Default Options
local defaults = {
	global = {
		verinfo = {
			[1] = 0,
			[2] = 0,
			[3] = 0,
		},
		tags = {
			firsttime = true,
			layouttip = false,
		},
		minipatches = {},
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
		},
		resolution = 1,	-- So we can check to make sure each Char is on the correct Res
		cbResetNew = false,	-- Reset New items for cargBags on character's first load
	},
	profile = {
		modules = {
			['*'] = true,
		},
		media = {
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
			textures = {
				plain = [[Interface\AddOns\nibRealUI\Media\Plain.tga]],
				border = [[Interface\AddOns\nibRealUI\Media\Glow.tga]],
				background = [[Interface\AddOns\nibRealUI\Media\media\BG1.tga]],
			},
		},
		other = {
			uiscaler = true,
		},
	},
}

function FindSpellID(SpellName)
	print("|cffffff20 SpellID tracking active. When |r|cffffffff"..SpellName.."|r|cffffff20 next activates, the SpellID will be printed in the chat window.|r")
	local f = CreateFrame("FRAME")
	f:RegisterEvent("UNIT_AURA")
	f:SetScript("OnEvent", function(self, event, ...)
		if ... == "player" then
			local spellID = select(11, UnitAura("player", SpellName))
			if spellID then
				print(SpellName..": #", spellID); 
				f:UnregisterEvent("UNIT_AURA")
			end
		end
	end)
end

-- Frame work
function nibRealUI:CreateBD(frame, alpha)
	frame:SetBackdrop({
		bgFile = nibRealUI.media.textures.plain, 
		edgeFile = nibRealUI.media.textures.plain, 
		edgeSize = 1, 
	})
	frame:SetBackdropColor(0, 0, 0, alpha or .5)
	frame:SetBackdropBorderColor(0, 0, 0)
end

function nibRealUI:CreateBG(frame, alpha)
	local f = frame
	if frame:GetObjectType() == "Texture" then f = frame:GetParent() end

	local bg = f:CreateTexture(nil, "BACKGROUND")
	bg:SetPoint("TOPLEFT", f, -1, 1)
	bg:SetPoint("BOTTOMRIGHT", f, 1, -1)
	bg:SetTexture(nibRealUI.media.textures.plain)
	bg:SetVertexColor(0, 0, 0, alpha or 1)

	return bg
end

function nibRealUI:CreateInnerBG(frame)
	local f = frame
	if frame:GetObjectType() == "Texture" then f = frame:GetParent() end

	local bg = f:CreateTexture(nil, "BACKGROUND")
	bg:SetPoint("TOPLEFT", frame, 1, -1)
	bg:SetPoint("BOTTOMRIGHT", frame, -1, 1)
	bg:SetTexture(nibRealUI.media.textures.plain)
	bg:SetVertexColor(0, 0, 0, 0)

	return bg
end

function nibRealUI:CreateFS(parent, justify, ...)
	--print("nibRealUI/Core:CreateFS parent; "..tostring(parent))
	local f = parent:CreateFontString(nil, "OVERLAY")
	local size
	if ... then 
		size = ...
	else
		size = nibRealUI.font.pixel1[2]
	end
	f:SetFont(nibRealUI.font.pixel1[1], size, nibRealUI.font.pixel1[3])
	f:SetShadowColor(0, 0, 0, 0)
	if justify then f:SetJustifyH(justify) end
	return f
end

local function FormatToDecimalPlaces(num, places)
	local placeValue = ("%%.%df"):format(places)
	return placeValue:format(num)
end

function nibRealUI:ReadableNumber(num)
	local ret = 0
	if not num then
		return 0
	elseif num >= 100000000 then
		ret = FormatToDecimalPlaces(num / 1000000, 0) .. "m" -- hundred million
	elseif num >= 10000000 then
		ret = FormatToDecimalPlaces(num / 1000000, 1) .. "m" -- ten million
	elseif num >= 1000000 then
		ret = FormatToDecimalPlaces(num / 1000000, 2) .. "m" -- million
	elseif num >= 100000 then
		ret = FormatToDecimalPlaces(num / 1000, 0) .. "k" -- hundred thousand
	elseif num >= 10000 then
		ret = FormatToDecimalPlaces(num / 1000, 1) .. "k" -- ten thousand
	elseif num >= 1000 then
		ret = FormatToDecimalPlaces(num / 1000, 2) .. "k" -- thousand
	else
		ret = num -- hundreds
	end
	return ret
end

-- Reload UI dialog
function nibRealUI:ReloadUIDialog()
	LibStub("AceConfigDialog-3.0"):Close("nibRealUI")

	-- Display Dialog
	StaticPopupDialogs["PUDRUIRELOADUI"] = {
		text = L["You need to Reload the UI for changes to take effect. Reload Now?"],
		button1 = "Yes",
		button2 = "No",
		OnAccept = function()
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		notClosableByLogout = false,
	}
	StaticPopup_Show("PUDRUIRELOADUI")
end

-- Font Retrieval
function nibRealUI:RetrieveFont(font)
	local font = LSM:Fetch("font", font)
	if font == nil then font = GameFontNormalSmall:GetFont() end
	return font
end

function nibRealUI:GetFont(fontID)
	local font = {}
	if fontID == "small" then
		if dbc.resolution == 1 then
			font = {self:RetrieveFont(self.media.font.pixel.lowres.small[1]), self.media.font.pixel.lowres.small[2], self.media.font.pixel.lowres.small[3]}
		else
			font = {self:RetrieveFont(self.media.font.pixel.highres.small[1]), self.media.font.pixel.highres.small[2], self.media.font.pixel.highres.small[3]}
		end
	elseif fontID == "large" then
		if dbc.resolution == 1 then
			font = {self:RetrieveFont(self.media.font.pixel.lowres.large[1]), self.media.font.pixel.lowres.large[2], self.media.font.pixel.lowres.large[3]}
		else
			font = {self:RetrieveFont(self.media.font.pixel.highres.large[1]), self.media.font.pixel.highres.large[2], self.media.font.pixel.highres.large[3]}
		end
	else
		font = self:RetrieveFont(self.media.font.standard[1])
	end
	return font
end

-- Opposite Faction
function nibRealUI:OtherFaction(f)
	if (f == "Horde") then
		return "Alliance"
	else
		return "Horde"
	end
end

-- Validate Offset
function nibRealUI:ValidateOffset(value, ...)
	local val = tonumber(value)
	local vmin, vmax = -5000, 5000
	if ... then vmin, vmax = ... end	
	if val == nil then val = 0 end
	val = max(val, vmin)
	val = min(val, vmax)
	return val
end

-- Class Color
function nibRealUI:GetClassColor(class, ...)
	if not RAID_CLASS_COLORS[class] then return {1, 1, 1} end
	local classColors = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
	local offset
	if not ... then
		offset = 0--(class == "PRIEST" and -0.2) or ((class == "ROGUE" or class == "MAGE" or class == "HUNTER") and -0.1) or 0
	else
		offset = 0
	end
	return {classColors.r * (1 + offset), classColors.g * (1 + offset), classColors.b * (1 + offset)}
end

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
		return string.format("|cffffa060%s|r.|cff70d0ff%s|r |cff60ff60r%s|r", dbg.verinfo[1], dbg.verinfo[2], dbg.verinfo[3])
	else
		return string.format("%s.%s", dbg.verinfo[1], dbg.verinfo[2])
	end
end
function nibRealUI:GetVerDifference(OldVer, CurVer)
	local IsNewVer, IsOneMore = false, false
	
	if ( CurVer[1] > OldVer[1] ) then
		IsNewVer = true
		IsOneMore = false
	elseif ( (CurVer[1] == OldVer[1]) and (CurVer[2] == OldVer[2]) ) then
		if ( (CurVer[2] > (OldVer[2] + 1)) ) then
			IsNewVer = true
			IsOneMore = false
		elseif ( (CurVer[2] == (OldVer[2] + 1)) ) then
			IsNewVer = true
			IsOneMore = true			
		end
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
		"ARKINVDB",
		"ChatterDB",
		"MapsterDB",
		"MasqueDB",
	}
	-- Any Addons which need a Layout profile change, also changes Res
	local LayoutAddonList = {
		"Bartender4DB",
		"GridDB",
	}
	-- Any Addons which aren't in the Layout list, but still need a Res profile change
	local ResAddonList = {
		"DXEDB",
		"IceCoreRealUIDB",
		"nibMinimapDB",
		"nibPointDisplayRUIDB",
		"nibSpellAlertConfigDB",
		"Omen3DB",
		"RavenDB",
		"SkadaDB",
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
end
function nibRealUI:UpdateLayout()
	if InCombatLockdown() then
		-- Store variable to change layout after combat ends
		dbc.layout.needchanged = true
		print("|cff00ffffRealUI:|r "..L["Layout will change after you leave combat."])
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
	-- Check if Installation/Patch is necessary
	nibRealUI:InstallProcedure()
end

function nibRealUI:ADDON_LOADED(event, addon)
	if addon ~= "nibRealUI" then return end
	
	-- Open before login to stop taint
	ToggleFrame(SpellBookFrame)
	PetJournal_LoadUI()
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
	
	---- Version Checking ----
	
	-- Set version to current version
	dbg.verinfo = nibRealUI_Version
	
	---- End Version Checking ----
	
	
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
	
	print(format("RealUI %s loaded.", nibRealUI:GetVerString(true)))
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