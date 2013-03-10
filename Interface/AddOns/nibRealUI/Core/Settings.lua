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
local MiniPatchMajorVer = "73"
local table_MiniPatches = {1, 5, 6, 9, 10, 11, 12, 13, 16, 18}

local IWTextures = {
	Logo = [[Interface\AddOns\nibRealUI\Media\Logo.tga]],
}

local IWF = {}

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
	-- Graphics
	SetCVar("gxMultisample", 1)
	RestartGx()
	-- Sound
	SetCVar("Sound_EnableErrorSpeech", 0)
	-- Nameplates
	SetCVar("bloatTest", 0)
	SetCVar("bloatnameplates", 0)
	SetCVar("bloatthreat", 0)
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
function RealUI_RunStage1()
	dbc.installation.stage = -1
	
	if dbg.tags.firsttime then
		dbg.tags.firsttime = false

		-- Show Layout Changer tip once UI has reloaded
		dbg.tags.layouttip = true
		
		-- Addon Data
		nibRealUI:LoadAddonData()
	end
	
	-- Make Chat windows transparent (again)
	SetChatWindowAlpha(1, 0)
	SetChatWindowAlpha(2, 0)
	
	-- Addon Profiles
	nibRealUI:SetAddonProfileKeys()
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
		tinsert(dbg.minipatches, MiniPatchMajorVer.."r"..tostring(v))
	end
	
	DEFAULT_CHATFRAME_ALPHA = 0
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
		local NP = {}
		for k,v in ipairs(table_MiniPatches) do
			NP[v] = true
		end
		if dbg.minipatches ~= nil then
			for k,v in pairs(dbg.minipatches) do
				if v == "73r1" then NP[2] = false end
				if v == "73r5" then NP[5] = false end
				if v == "73r6" then NP[6] = false end
				if v == "73r9" then NP[9] = false end
				if v == "73r10" then NP[10] = false end
				if v == "73r11" then NP[11] = false end
				if v == "73r12" then NP[12] = false end
				if v == "73r13" then NP[13] = false end
				if v == "73r16" then NP[16] = false end
				if v == "73r18" then NP[18] = false end
			end
		end
		
		-- Run through MiniPatches
		local toPatch = {}
		local HasMPatched = false
		if dbg.minipatches == nil then dbg.minipatches = {} end
		
		if NP[2] then tinsert(toPatch, "73r1") end
		if NP[5] then tinsert(toPatch, "73r5") end
		if NP[6] then tinsert(toPatch, "73r6") end
		if NP[9] then tinsert(toPatch, "73r9") end
		if NP[10] then tinsert(toPatch, "73r10") end
		if NP[11] then tinsert(toPatch, "73r11") end
		if NP[12] then tinsert(toPatch, "73r12") end
		if NP[13] then tinsert(toPatch, "73r13") end
		if NP[16] then tinsert(toPatch, "73r16") end
		if NP[18] then tinsert(toPatch, "73r18") end
		
		for k,v in ipairs(toPatch) do
			if v then
				nibRealUI:MiniPatch(v)
				tinsert(dbg.minipatches, v)
				HasMPatched = true
			end
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