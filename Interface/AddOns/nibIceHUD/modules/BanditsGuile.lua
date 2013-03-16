local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local BanditsGuile = IceCore_CreateClass(IceUnitBar)

local nibIceHUD = _G.nibIceHUD

local SinisterStrikeID = 1752
local RevealingStrikeID = 84617
local RedirectID = 73981

local maxBGDuration = 15

local bgSpellIDs = {84745, 84746, 84747}
local bgNames = {"", "", ""}
local bgText = {[0] = "B", [1] = "S", [2] = "M", [3] = "D"}

local bgDuration, bgEndTime

local bgState = 0
local bgSwingCount = 0
local bgTimerActive = false
local lastTargetGUID = nil
local hasTargetChanged = false

local isCRogue = false

-- Constructor --
function BanditsGuile.prototype:init()
	BanditsGuile.super.prototype.init(self, "BanditsGuile", "player")

	self.moduleSettings = {}
	self.moduleSettings.desiredLerpTime = 0
	self.moduleSettings.shouldAnimate = false

	self:SetDefaultColor("BanditsGuile0", 1, 1, 1)
	self:SetDefaultColor("BanditsGuile1", 0, 0.8, 0)
	self:SetDefaultColor("BanditsGuile2", 0.8, 0.8, 0)
	self:SetDefaultColor("BanditsGuile3", 0.95, 0, 0)
	self:SetDefaultColor("BanditsGuileSwings", 1, 1, 1)

	self.bTreatEmptyAsFull = true
end

-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function BanditsGuile.prototype:Enable(core)
	BanditsGuile.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_AURA", "UpdateBanditsGuile")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "OnTalentChanged")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "OnTalentChanged")
	
	isCRogue = self:isCombatRogue()
	
	for i = 1, 3 do
		bgNames[i] = GetSpellInfo(bgSpellIDs[i])
	end

	if not self.moduleSettings.alwaysFullAlpha then
		self:Show(false)
	else
		self:UpdateBanditsGuile()
	end

	self:SetBottomText1("")
end

function BanditsGuile.prototype:Toggle(vis)
	if ( vis and isCRogue ) then
		self:Show(true)
	else
		self:Show(false)
	end
end

function BanditsGuile.prototype:TargetChanged()
	BanditsGuile.super.prototype.TargetChanged(self)
	
	if UnitExists("target") then
		hasTargetChanged = true
		if not UnitAffectingCombat("player") then
			-- Reset BG bar if changing targets and out of combat
			bgState = 0
			bgSwingCount = 0
		end
	end
	
	self:UpdateSwingBar()
	self:UpdateBanditsGuile()
end

function BanditsGuile.prototype:Disable(core)
	BanditsGuile.super.prototype.Disable(self, core)
end

-- OVERRIDE
function BanditsGuile.prototype:GetDefaultSettings()
	local settings = BanditsGuile.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = true
	settings["lowThreshold"] = 0
	settings["side"] = IceCore.Side.Left
	settings["offset"] = 6
	settings["showAsPercentOfMax"] = true
	settings["swingAlpha"] = 0.5
	settings["lowerTextVisible"] = false
	settings["bAllowExpand"] = true

	return settings
end

-- OVERRIDE
function BanditsGuile.prototype:GetOptions()
	local opts = BanditsGuile.super.prototype.GetOptions(self)

	opts["textSettings"].args["upperTextString"].hidden = false

	opts["swingAlpha"] =
	{
		type = "range",
		name = "BG swings alpha",
		desc = "What alpha value to use for the bar that displays how many swings until the next BG state. (This gets multiplied by the bar's current alpha to stay in line with the bar on top of it)",
		min = 0,
		max = 100,
		step = 5,
		get = function()
			return self.moduleSettings.swingAlpha * 100
		end,
		set = function(info, v)
			self.moduleSettings.swingAlpha = v / 100.0
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end
	}

	return opts
end

function BanditsGuile.prototype:CreateFrame()
	BanditsGuile.super.prototype.CreateFrame(self)

	self:CreateSwingBar()
end

function BanditsGuile.prototype:CreateSwingBar()
	self.swingFrame = self:BarFactory(self.swingFrame, "MEDIUM","ARTWORK")

	self.CurrScale = 0

	self.swingFrame.bar:SetVertexColor(self:GetColor("BanditsGuileSwings", self.moduleSettings.swingAlpha))
	self.swingFrame.bar:SetHeight(0)

	self:UpdateBar(1, "undef")

	self:UpdateSwingBar()
end

-- 'Protected' methods --------------------------------------------------------

function BanditsGuile.prototype:GetBuffDuration(unitName, buffName)
	local name, _, _, count, _, duration, endTime = UnitAura(unitName, buffName)
	if name then
		return duration, endTime - GetTime()
	end
	return nil, nil
end

function BanditsGuile.prototype:MyOnUpdate()
	BanditsGuile.super.prototype.MyOnUpdate(self)
	if self.bUpdateBG then
		self:UpdateBanditsGuile(nil, "player", true)
	end
end

function BanditsGuile.prototype:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	local arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13 = ...;
	
	if (arg5 ~= UnitName("player")) then
		return
	end
	
	if (arg2 == "SPELL_DAMAGE") and ((arg12 == SinisterStrikeID) or (arg12 == RevealingStrikeID)) then
		if not hasTargetChanged or not lastTargetGUID then
			lastTargetGUID = UnitGUID("target")
		end
		if hasTargetChanged and lastTargetGUID then
			if (lastTargetGUID ~= UnitGUID("target")) then
				bgState = 0
				bgSwingCount = 0
				lastTargetGUID = nil
				hasTargetChanged = false
			else
				hasTargetChanged = false
			end
		end
		
		bgSwingCount = bgSwingCount + 1
		self:UpdateSwingBar()
	end
	if ((arg2 == "SPELL_AURA_REMOVED") or (arg2 == "SPELL_AURA_APPLIED")) and ((arg12 == bgSpellIDs[3]) or (arg12 == bgSpellIDs[2]) or (arg12 == bgSpellIDs[1])) then
		bgSwingCount = 0
		self:UpdateSwingBar()
	end
	if (arg2 == "SPELL_CAST_SUCCESS") and (arg12 == RedirectID) then
		hasTargetChanged = false
		self:UpdateSwingBar()
	end
end

function BanditsGuile.prototype:UpdateBanditsGuile(event, unit, fromUpdate)
	if unit and unit ~= "player" then
		return
	end

	local now = GetTime()
	local remaining = nil
	if not fromUpdate then
		bgState = 0
		for i = 1, 3 do
			bgDuration, remaining = self:GetBuffDuration("player", bgNames[i])
			if remaining then
				bgState = i
				break
			end
		end
		if not remaining then
			bgEndTime = 0
		else
			bgEndTime = remaining + now
		end
	end

	if (((bgEndTime) and (bgEndTime >= now) and bgState > 0) or (bgSwingCount > 0)) and UnitExists("target") then
		if not fromUpdate then
			self.bUpdateBG = true
			self:Toggle(true)
		end
		
		if not(remaining) and ((bgEndTime) and (bgEndTime >= now)) then
			remaining = bgEndTime - now
		end
		
		if remaining then
			self:UpdateBar(remaining / maxBGDuration or 0, "BanditsGuile"..bgState)
		else
			self:UpdateBar(0, "BanditsGuile0")
		end

		local swingText = (bgState < 3) and " (" .. bgSwingCount .. ")"
		self:SetBottomText1(bgText[bgState] .. " " .. tostring(floor(remaining or 0)) .. ((self.moduleSettings.swingAlpha ~= 0) and swingText or ""))
		bgTimerActive = true
	else
		self:UpdateBar(0, "BanditsGuile1")
		if self.bIsVisible then
			self.bUpdateBG = nil
		end
		if not self.moduleSettings.alwaysFullAlpha then
			self:Show(false)
		end
		bgTimerActive = false
	end
end

function BanditsGuile.prototype:UpdateSwingBar(event, unit)
	if unit and unit ~= "player" then
		return
	end
	
	-- player doesn't want to show the percent of max or the alpha is zeroed out, so don't bother with the swing bar
	if not(self.moduleSettings.showAsPercentOfMax) or (self.moduleSettings.swingAlpha == 0) or (bgSwingCount == 0 and not self:IsVisible()) or (bgState == 3) then
		self.swingFrame:Hide()
		return
	end
	self.swingFrame:Show()

	-- if we have swings and a target selected, go ahead and show the bar so the swing bar can be seen
	if (bgSwingCount > 0) and (bgState < 3) and UnitExists("target") then
		self:Toggle(true)
	end

	local scale = nibIceHUD:Clamp(bgSwingCount / 4, 0, 1)
	if (self.moduleSettings.reverse) then
		scale = 1 - scale
	end
	
	self.swingFrame.bar:SetVertexColor(self:GetColor("BanditsGuileSwings", self.moduleSettings.swingAlpha))
	self:SetBarCoord(self.swingFrame, scale)
	
	self:UpdateBanditsGuile(nil, "player", true)
end

function BanditsGuile.prototype:OutCombat()
	BanditsGuile.super.prototype.OutCombat(self)

	self:UpdateBanditsGuile()
end

local _, unitClass = UnitClass("player")

function BanditsGuile.prototype:OnTalentChanged()
	isCRogue = self:isCombatRogue()
end

function BanditsGuile.prototype:isCombatRogue()
	if unitClass ~= "ROGUE" then
		return false
	end
	local spec = GetSpecialization()
	return spec == 2
end

-- Load us up
if unitClass == "ROGUE" then
	nibIceHUD.BanditsGuile = BanditsGuile:new()
end
