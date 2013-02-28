local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local L = LibStub("AceLocale-3.0"):GetLocale("nibRealUI")
local LSM = LibStub("LibSharedMedia-3.0")
local db, dbc, dbg

local nibRealUICharacter_defaults = {
	initialized = false,
	needchatmoved = true,
	resolution = 1,
}

-- Minipatch list. These get flagged on a PrimaryInstall as not being required.
local table_MiniPatches = {
	"73r1",
	"73r5",
	"73r6",
	"73r9",
	"73r10",
	"73r11",
}

local table_Addons = {
--	{"ACP", "ACP_Data"},
	{"ArkInventory", "ARKINVDB"},
	{"Bartender4", "Bartender4DB"},
--	{"BugSack", "BugSackDB"},
	{"DXE", "DXEDB"},
	{"Grid", "GridDB"},
	{"Mapster", "MapsterDB"},
	{"Masque", "MasqueDB"},
	{"MikScrollingBattleText", "MSBTProfiles_SavedVars"},
	{"nibIceHUD", "IceCoreRealUIDB"},
	{"nibMinimap", "nibMinimapDB"},
	{"nibPointDisplay_RealUI", "nibPointDisplayRUIDB"},
	{"nibSpellAlertConfig", "nibSpellAlertConfigDB"},
	{"Omen", "Omen3DB"},
	{"Raven", "RavenDB"},
	{"Skada", "SkadaDB"},
}

local IWTextures = {
	Logo = [[Interface\AddOns\nibRealUI\Media\Logo.tga]],
	Line = [[Interface\AddOns\nibRealUI\Media\Install\Line.tga]],
	LineVert = [[Interface\AddOns\nibRealUI\Media\Install\LineVert.tga]],
	Warning = [[Interface\AddOns\nibRealUI\Media\Install\Warning.tga]],
	WarningGlow = [[Interface\AddOns\nibRealUI\Media\Install\Warning_Glow.tga]],
}

local IWF = {}
local Use3AB = false

---- Misc functions
-- Set default Chat frame position (called from Core.lua "PLAYER_ENTERING_WORLD")
function nibRealUI:SetChatPosition()	
	if nibRealUICharacter.needchatmoved then
		ChatFrame1:ClearAllPoints()
		ChatFrame1:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 6, 32)
		ChatFrame1:SetFrameLevel(15)
		ChatFrame1:SetHeight(145)
		ChatFrame1:SetWidth(400)
		ChatFrame1:SetUserPlaced(true)
		FCF_SavePositionAndDimensions(ChatFrame1)
		nibRealUICharacter.needchatmoved = false
	end
end

-- CVars
local function SetDefaultCVars()
	-- Screenshots
	SetCVar("screenshotFormat", "jpg")				-- JPG format
	SetCVar("screenshotQuality", "10")				-- Highest quality
	-- Help
	SetCVar("showGameTips", 0)						-- Turn off Loading Screen Tips
	SetCVar("showTutorials", 0)						-- Turn off Tutorials
	SetCVar("UberTooltips", 1)						-- Turn on Enhanced Tooltips
	SetCVar("scriptErrors", 1)						-- Turn on Display Lua Errors
	-- Controls
	SetCVar("deselectOnClick", 1)					-- Turn off Sticky Targeting (inverted)
	-- Combat
	SetCVar("displaySpellActivationOverlays", 1)	-- Turn on Spell Alerts
	-- Display
	SetCVar("emphasizeMySpellEffects", 0)			-- Turn off Emphasize My Spell Effects
	SetCVar("SpellTooltip_DisplayAvgValues", 0)		-- Turn off Display Points As Average
	-- Social
	SetCVar("chatBubbles", 0)						-- Turn off Chat Bubbles
	SetCVar("chatBubblesParty", 0)					-- Turn off Party Chat Bubbles
	SetCVar("chatStyle", "classic")					-- Chat Style = "Classic"
	SetCVar("conversationMode", "inline")			-- Conversation Mode = "In-line"
	-- Names
	SetCVar("UnitNameNPC", 1)						-- Turn on NPC Names
	SetCVar("UnitNamePlayerPVPTitle", 0)			-- Turn off PvP Player Titles
	SetCVar("UnitNameEnemyGuardianName", 1)			-- Turn on Enemy Pet Names
	SetCVar("UnitNameEnemyTotemName", 1)			-- Turn on Enemy Totem Names
	-- Buffs and Debuffs
	SetCVar("consolidateBuffs", 0)					-- Turn off Consolidated Buffs
	-- Camera
	SetCVar("cameraYawSmoothSpeed", 210)
	SetCVar("cameraView", 1)						-- Camera Stlye
	SetCVar("cameraDistanceMax", 50)				-- Camera Max Distance
	SetCVar("cameraDistanceMaxFactor", 2)			-- Camera Follow Speed
	-- Quality of Life
	SetCVar("guildShowOffline", 0)					-- Hide Offline Guild Members
	SetCVar("profanityFilter", 0)					-- Turn off Profanity Filter
	-- Combat Text
	if IsAddOnLoaded("MikScrollingBattleText") then
		SetCVar("enableCombatText", 0)				-- Turn off Combat Text
		SetCVar("CombatDamage", 0)					-- Turn off Combat Text - Damage
		SetCVar("CombatHealing", 0)					-- Turn off Combat Text - Healing
	end
end

-- Initial Settings
local function InitialSettings()
	---- Chat
	-- Lock chat frames
	for i = 1,10 do
		local cf = _G["ChatFrame"..i]
		if cf then FCF_SetLocked(cf, 1) end
    end	
	-- Set all chat channels to color player names by class
	for k, v in pairs(ChatTypeInfo) do
		SetChatColorNameByClass(k, true)
	end	
	-- Make Chat windows transparent
	SetChatWindowAlpha(1, 0)
	SetChatWindowAlpha(2, 0)
	
	-- Initial Settings done
	nibRealUICharacter.initialized = true
end

---- Primary Installation
---- Stage 1
local WTFState = false

function RealUI_RunStage1()
	dbc.installation.stage = -1
	
	if dbg.tags.firsttime then
		dbg.tags.firsttime = false

		-- Show Layout Changer tip
		dbg.tags.layouttip = true
	end
	
	-- Make Chat windows transparent (again)
	SetChatWindowAlpha(1, 0)
	SetChatWindowAlpha(2, 0)
	
	-- Addon Profiles
	nibRealUI:SetAddonProfileKeys()
end

local function SetWTFCheck(val)
	if val then
		IWF.addoninfo:Hide()
		IWF.texts["wtfcheck"]:Hide()
		IWF.texts["wtfcheck"].line:Hide()
		IWF.texts["wtfnote1"]:Hide()
		IWF.texts["wtfnote1"].line:Hide()
		IWF.texts["wtfnote2"]:Hide()
		IWF.texts["wtfnote3"]:Hide()
		IWF.warning:Hide()
		IWF.warningglow:Hide()
		WTFState = true
	else
		IWF.addoninfo:Show()
		IWF.texts["wtfcheck"].text:SetText(L["WTF folder integrity check"])
		IWF.texts["wtfcheck"]:Show()
		IWF.texts["wtfcheck"].line:Show()
		IWF.texts["wtfnote1"]:Show()
		IWF.texts["wtfnote1"].line:Show()
		IWF.texts["wtfnote2"]:Show()
		IWF.texts["wtfnote3"]:Show()
		IWF.warning:Show()
		IWF.warningglow:Show()
		IWF.warningglow.aniGroup:Play()
		WTFState = false
	end
end

local function CreateNewIWAddonText(i)
	IWF.addoninfo.texts[i] = CreateFrame("Frame", nil, IWF.addoninfo)
	IWF.addoninfo.texts[i]:SetParent(IWF.addoninfo)
	IWF.addoninfo.texts[i]:SetPoint("TOPLEFT", IWF.addoninfo, "TOPLEFT", 0, -((i - 1) * (nibRealUI.font.pixel1[2] + 4) + 8) + 0.5)
	IWF.addoninfo.texts[i]:SetFrameStrata("DIALOG")
	IWF.addoninfo.texts[i]:SetFrameLevel(IWF.addoninfo:GetFrameLevel() + 1)
	IWF.addoninfo.texts[i]:SetWidth(IWF.addoninfo:GetWidth())
	IWF.addoninfo.texts[i]:SetHeight(nibRealUI.font.pixel1[2])
	
	IWF.addoninfo.texts[i].text = IWF.addoninfo.texts[i]:CreateFontString()
	IWF.addoninfo.texts[i].text:SetAllPoints(IWF.addoninfo.texts[i])
	IWF.addoninfo.texts[i].text:SetJustifyH("LEFT")
	IWF.addoninfo.texts[i].text:SetFont(unpack(nibRealUI.font.pixel1))
	
	IWF.addoninfo:SetHeight(i * (nibRealUI.font.pixel1[2] + 4))
end

local CurAddonTextPos = 1
local function PrintAddonStatus(str, ...)
	if not IWF.addoninfo.texts[CurAddonTextPos] then 
		CreateNewIWAddonText(CurAddonTextPos)
	end
	if ... == "ok" then
		IWF.addoninfo.texts[CurAddonTextPos].text:SetFormattedText("|cffdfdfdf%s|r... |cff00ff00%s|r", str, L["OK!"])
	elseif ... == "failed" then
		IWF.addoninfo.texts[CurAddonTextPos].text:SetFormattedText("|cffdfdfdf%s|r... |cffff0000%s|r", str, L["FAILED!"])
	end
	CurAddonTextPos = CurAddonTextPos + 1
end

local function CreateIWTextFrame(position, ...)
	local frame = CreateFrame("Frame", nil, IWF)
	frame:SetParent(IWF)
	frame:SetPoint(unpack(position))
	frame:SetFrameStrata("DIALOG")
	frame:SetFrameLevel(IWF:GetFrameLevel() + 2)
	frame:SetWidth(400)
	frame:SetHeight(nibRealUI.font.pixel1[2])
	
	frame.text = frame:CreateFontString()
	frame.text:SetAllPoints(frame)
	frame.text:SetJustifyH("LEFT")
	if ... then
		frame.text:SetFont(unpack(nibRealUI.font.pixellarge))
	else
		frame.text:SetFont(unpack(nibRealUI.font.pixel1))
	end
	
	return frame
end

local function CreateIWTextureFrame(texture, width, height, position, color)
	local frame = CreateFrame("Frame", nil, IWF)
	frame:SetParent(IWF)
	frame:SetPoint(unpack(position))
	frame:SetFrameStrata("DIALOG")
	frame:SetFrameLevel(IWF:GetFrameLevel() + 1)
	frame:SetWidth(width)
	frame:SetHeight(height)
	
	frame.bg = frame:CreateTexture()
	frame.bg:SetAllPoints(frame)
	frame.bg:SetTexture(texture)
	frame.bg:SetVertexColor(unpack(color))
	
	return frame
end

local function CreateInstallWindow()
	-- Background
	IWF = CreateFrame("Frame", nil, UIParent)
	IWF:EnableMouse(true)
	IWF:SetParent(UIParent)
	IWF:SetPoint("CENTER", UIParent, "CENTER")
	IWF:SetFrameStrata("DIALOG")
	IWF:SetFrameLevel(0)
	IWF:SetWidth(UIParent:GetWidth() + 2000)
	IWF:SetHeight(UIParent:GetHeight() + 2000)
	IWF:SetBackdrop({
		bgFile = "Interface\\AddOns\\nibRealUI\\Media\\Plain",
		insets = {left = 0, right = 0, top = 0, bottom = 0},
		edgeFile = "",
		edgeSize = 0
	})
	IWF:SetBackdropColor(0, 0, 0, 0.9)
	
	-- Addon Info
	IWF.addoninfo = CreateFrame("Frame", nil, IWF)
	IWF.addoninfo:Hide()
	IWF.addoninfo:SetPoint("LEFT", IWF, "CENTER", 100, 6)
	IWF.addoninfo:SetFrameStrata("DIALOG")
	IWF.addoninfo:SetFrameLevel(IWF:GetFrameLevel() + 4)
	IWF.addoninfo:SetWidth(190)
	IWF.addoninfo.texts = {}
	
	-- Texts
	IWF.texts = {}
	IWF.texts["wtfcheck"] = CreateIWTextFrame({"BOTTOMLEFT", IWF.addoninfo, "TOPLEFT", 0, 15})
	IWF.texts["wtfcheck"]:Hide()
	IWF.texts["wtfcheck"].line = CreateIWTextureFrame(IWTextures.Line, 256, 16, {"BOTTOMLEFT", IWF.texts["wtfcheck"], "BOTTOMLEFT", -2, -8}, {1, 1, 1, 1})
	IWF.texts["wtfcheck"].line:Hide()
	
	IWF.texts["wtfnote1"] = CreateIWTextFrame({"TOPLEFT", IWF.addoninfo, "BOTTOMLEFT", 0, -27})
	IWF.texts["wtfnote1"].text:SetFormattedText("%s|cffa0a0ff %s |r%s", L["Your"], L["WTF folder"], L["is missing addon settings."])
	IWF.texts["wtfnote1"]:Hide()
	IWF.texts["wtfnote1"].line = CreateIWTextureFrame(IWTextures.Line, 256, 16, {"BOTTOMLEFT", IWF.texts["wtfnote1"], "TOPLEFT", -2, 6}, {1, 1, 1, 1})
	IWF.texts["wtfnote1"].line:Hide()
	
	IWF.texts["wtfnote2"] = CreateIWTextFrame({"BOTTOMLEFT", IWF.texts["wtfnote1"], "BOTTOMLEFT", 0, -(nibRealUI.font.pixel1[2] + 7)})
	IWF.texts["wtfnote2"].text:SetFormattedText("%s|cffa0a0ff %s |r", L["Exit WoW and visit"], "wowinterface.com")
	IWF.texts["wtfnote2"]:Hide()
	
	IWF.texts["wtfnote3"] = CreateIWTextFrame({"BOTTOMLEFT", IWF.texts["wtfnote2"], "BOTTOMLEFT", 0, -(nibRealUI.font.pixel1[2] + 4)})
	IWF.texts["wtfnote3"].text:SetFormattedText("%s %s", L["for Installation"], L["Troubleshooting."])
	IWF.texts["wtfnote3"]:Hide()
	
	IWF.warning = CreateIWTextureFrame(IWTextures.Warning, 100, 100, {"LEFT", IWF, "CENTER", 330, 0}, {1, 1, 1, 1})
	IWF.warning:Hide()
	IWF.warningglow = CreateIWTextureFrame(IWTextures.WarningGlow, 100, 100, {"CENTER", IWF.warning, "CENTER", 0, 0}, {1, 1, 1, 1})
	IWF.warningglow:Hide()
	IWF.warningglow.aniGroup = IWF.warningglow:CreateAnimationGroup() 
	IWF.warningglow.aniGroup:SetLooping("REPEAT")
	IWF.warningglow.aniin = IWF.warningglow.aniGroup:CreateAnimation("Alpha")
	IWF.warningglow.aniin:SetDuration(1)
	IWF.warningglow.aniin:SetChange(1)
	IWF.warningglow.aniin:SetOrder(2)
	IWF.warningglow.aniout = IWF.warningglow.aniGroup:CreateAnimation("Alpha")
	IWF.warningglow.aniout:SetDuration(1)
	IWF.warningglow.aniout:SetChange(-1)
	IWF.warningglow.aniout:SetOrder(1)
	
	-- Button
	IWF.install = CreateFrame("Button", "RealUI_Install", IWF, "SecureActionButtonTemplate")
	IWF.install:SetPoint("CENTER", IWF, "CENTER", 0, 0)
	IWF.install:SetWidth(110)
	IWF.install:SetHeight(50)
	IWF.install:SetNormalFontObject(NumberFontNormal)
	IWF.install:SetText(L["INSTALL"])
	IWF.install:RegisterForClicks("LeftButtonUp")
	IWF.install:SetScript("OnClick", function()
		RealUI_RunStage1()
		ReloadUI()
	end)
	
	if Aurora then
		local F = unpack(Aurora)
		F.Reskin(IWF.install)
		
		-- Button Highlight
		IWF.installhighlight = CreateFrame("Frame", nil, IWF)
		IWF.installhighlight:SetPoint("CENTER", IWF, "CENTER", 0, 0)
		IWF.installhighlight:SetWidth(108)
		IWF.installhighlight:SetHeight(48)
		IWF.installhighlight:SetBackdrop({
			bgFile = nibRealUI.media.textures.plain, 
			edgeFile = nibRealUI.media.textures.plain, 
			tile = false, tileSize = 0, edgeSize = 1, 
			insets = { left = 1, right = 1, top = 1, bottom = 1	}
		})
		IWF.installhighlight:SetBackdropColor(0,0,0,0.1)
		IWF.installhighlight:SetBackdropBorderColor(unpack(nibRealUI:GetClassColor(nibRealUI.class, true)))
	end
	
	-- Logo
	IWF.logo = CreateIWTextureFrame(IWTextures.Logo, 32, 32, {"CENTER", IWF, "CENTER", 0, 55}, {1, 1, 1, 1})
end

local function InstallationStage1()
	---- Create Installation Window
	CreateInstallWindow()
	
	---- First Time
	print("First Time? "..tostring(dbg.tags.firsttime))
	if dbg.tags.firsttime then
		-- CVars
		SetDefaultCVars()
		
		-- Resolution
		local newRes = nibRealUI:GetRecommendedResolution()
		dbg.resolution = newRes
		dbc.resolution = newRes
		nibRealUICharacter.resolution = newRes
	end
	
	---- Initial Character Settings
	if not nibRealUICharacter.initialized then
		InitialSettings()
		dbc.resolution = dbg.resolution
		nibRealUICharacter.resolution = dbg.resolution
	end
	
	---- Set MiniPatch flags
	dbg.minipatches = {}
	for k,v in ipairs(table_MiniPatches) do
		tinsert(dbg.minipatches, v)
	end
	
	---- Check WTF Folder
	local OKCount = 0
	local AddonCount = 0
	-- Initialize DXE
	if IsAddOnLoaded("DXE_Loader") and not IsAddOnLoaded("DXE") then
		SlashCmdList.DXE()
	end
	-- Run through Addons
	for k,a in ipairs(table_Addons) do
		local addon = table_Addons[k][1]
		local db = _G[table_Addons[k][2]]
		if IsAddOnLoaded(addon) then
			AddonCount = AddonCount + 1
			if db then
				if db["profiles"] and db["profiles"]["RealUI"] then
					PrintAddonStatus(addon, "ok")
					OKCount = OKCount + 1
				else
					PrintAddonStatus(addon, "failed")
				end
			else
				PrintAddonStatus(addon, "failed")
			end
		end
	end
	if OKCount == AddonCount then
		SetWTFCheck(true)
	else
		SetWTFCheck(false)
	end
	
	--
	DEFAULT_CHATFRAME_ALPHA = 0
	if not WTFState then
		-- -- Disable Install Button
		-- IWF.install:Disable()
		-- IWF.installhighlight:SetBackdropColor(0.1, 0.1, 0.1, 0.25)
		-- IWF.installhighlight:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
		-- IWF.abcheck:Hide()
	end
end

---- Process
local function PrimaryInstallation()
	if dbc.installation.stage > -1 then
		InstallationStage1()
	end
end

-- Mini Patch
local function MiniPatchInstallation()
	local CurVer = dbg.verinfo
	if CurVer[1] == 7 and CurVer[2] == 3 then
		-- Find out which Mini Patches are needed
		local NP = {
			[2] = true,
			[5] = true,
			[6] = true,
			[9] = true,
			[10] = true,
			[11] = true,
		}
		if dbg.minipatches ~= nil then
			for k,v in pairs(dbg.minipatches) do
				if v == "73r1" then NP[2] = false end
				if v == "73r5" then NP[5] = false end
				if v == "73r6" then NP[6] = false end
				if v == "73r9" then NP[9] = false end
				if v == "73r10" then NP[10] = false end
				if v == "73r11" then NP[11] = false end
			end
		end
		
		-- Run through MiniPatches
		local HasMPatched = false
		if dbg.minipatches == nil then dbg.minipatches = {} end
		if NP[2] then
			nibRealUI:MiniPatch("73r1")
			tinsert(dbg.minipatches, "73r1")
			HasMPatched = true
		end
		if NP[5] then
			nibRealUI:MiniPatch("73r5")
			tinsert(dbg.minipatches, "73r5")
			HasMPatched = true
		end
		if NP[6] then
			nibRealUI:MiniPatch("73r6")
			tinsert(dbg.minipatches, "73r6")
			HasMPatched = true
		end
		if NP[9] then
			nibRealUI:MiniPatch("73r9")
			tinsert(dbg.minipatches, "73r9")
			HasMPatched = true
		end
		if NP[10] then
			nibRealUI:MiniPatch("73r10")
			tinsert(dbg.minipatches, "73r10")
			HasMPatched = true
		end
		if NP[11] then
			nibRealUI:MiniPatch("73r11")
			tinsert(dbg.minipatches, "73r11")
			HasMPatched = true
		end
		
		-- Reload UI
		if HasMPatched then
			StaticPopupDialogs["PUDRUIMP"] = {
				text = "|cff85e0ff"..L["RealUI Mini Patch"].."|r\n\n|cffffffff"..L["RealUI's settings have been updated."].."\n\n"..L["Reload UI now to apply these changes?"],
				button1 = "Yes",
				button2 = "No",
				OnAccept = function()
					ReloadUI()
				end,
				timeout = 0,
				whileDead = true,
				hideOnEscape = false,
				notClosableByLogout = false,
			}
			StaticPopup_Show("PUDRUIMP")
			
			return true
		else
			return false
		end
	end
end

local function CharToGlobalResolution()
	local msg = "|cff85e0ff"..L["RealUI Layout Resolution"].."|r\n\n|cffffffff"..L["This character's Layout Resolution needs to be updated to match the global setting."].."\n\n"..L["Reload UI now to apply these changes?"]
	
	StaticPopupDialogs["PUDRUICGR"] = {
		text = msg,
		button1 = "Yes",
		button2 = "No",
		OnAccept = function()
			dbc.resolution = dbg.resolution
			nibRealUICharacter.resolution = dbg.resolution
			nibRealUI:SetAddonProfileKeys()
			ReloadUI()
		end,
		OnCancel = function()
			dbg.resolution = dbc.resolution
			nibRealUICharacter.resolution = dbc.resolution
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = false,
		notClosableByLogout = false,
	}
	StaticPopup_Show("PUDRUICGR")
end

---- Install Procedure
function nibRealUI:InstallProcedure()
	db = self.db.profile
	dbc = self.db.char
	dbg = self.db.global
	
	-- Set Char defaults
	if not nibRealUICharacter then
		nibRealUICharacter = nibRealUICharacter_defaults
	end

	---- Version checking
	local CurVer, OldVer = dbg.verinfo, dbc.installation.verinfo
	local IsNewVer, IsOneMore = nibRealUI:GetVerDifference(OldVer, CurVer)
	dbc.installation.verinfo = CurVer	
	
	-- Primary Stages
	if dbc.installation.stage > -1 then
		PrimaryInstallation()
	-- Mini Patch	
	else
		local MiniPatching = MiniPatchInstallation()
		
		if not MiniPatching then
			-- Check Resolution
			if (not dbg.tags.firsttime) and (dbc.resolution ~= dbg.resolution) then
				CharToGlobalResolution()
			end
		end
	end
end