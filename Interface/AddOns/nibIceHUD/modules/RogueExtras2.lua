local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local RogueExtras2 = IceCore_CreateClass(IceUnitBar)
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local nibIceHUD = _G.nibIceHUD

local playerSpec = 0

local tottBaseTime = 6
local tottEndTime = 0
local tottDuration = 0
local tottSpellID = 57933
local tottName = ""

local arDuration = 0
local arEndTime = 0
local arSpellID = 13750
local arName = ""

local sdDuration = 0
local sdEndTime = 0
local sdSpellID = 51713
local sdName = ""

local vndDuration = 0
local vndEndTime = 0
local vndSpellID = 79140
local vndName = ""

local ActiveAuras = {
	["ToTT"] = false,
	["AR"] = false,
	["SD"] = false,
	["VND"] = false
}

local AuraTexCoord = {0.1, 0.9, 0.1, 0.9}

-- Constructor --
function RogueExtras2.prototype:init()
	RogueExtras2.super.prototype.init(self, "RogueExtras2", "player")

	self.moduleSettings = {}
	self.moduleSettings.desiredLerpTime = 0
	self.moduleSettings.shouldAnimate = false

	self:SetDefaultColor("RogueExtras2ToTT", 0.3, 0.8, 0.3)

	self.bTreatEmptyAsFull = true
end

-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function RogueExtras2.prototype:Enable(core)
	RogueExtras2.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_AURA", "UpdateRogueExtras2")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "UpdateSpec")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "UpdateSpec")
	
	local ShownEvents = {
		"UNIT_SPELLCAST_SENT",
		"UNIT_SPELLCAST_START",
		"UNIT_SPELLCAST_STOP",
		"UNIT_SPELLCAST_FAILED",
		"UNIT_SPELLCAST_INTERRUPTED",
		"UNIT_SPELLCAST_DELAYED",
		"UNIT_SPELLCAST_SUCCEEDED",
		"UNIT_SPELLCAST_CHANNEL_START",
		"UNIT_SPELLCAST_CHANNEL_UPDATE",
		"UNIT_SPELLCAST_CHANNEL_STOP",
	}
	for i,v in pairs(ShownEvents) do
		self:RegisterEvent(v, "ShownUpdate")
	end
	self:RegisterEvent("PLAYER_FOCUS_CHANGED", "ShownUpdate")
	
	tottName = GetSpellInfo(tottSpellID)
	arName = GetSpellInfo(arSpellID)
	sdName = GetSpellInfo(sdSpellID)
	vndName = GetSpellInfo(vndSpellID)
	
	self:UpdateSpec()
	
	if not self.moduleSettings.alwaysFullAlpha then
		self:Show(false)
	else
		self:UpdateRogueExtras2()
	end

	self:SetBottomText1("")
end

function RogueExtras2.prototype:Disable(core)
	RogueExtras2.super.prototype.Disable(self, core)
end

function RogueExtras2.prototype:TargetChanged()
	RogueExtras2.super.prototype.TargetChanged(self)
	self:UpdateRogueExtras2(nil, "target", nil)
end

-- OVERRIDE
function RogueExtras2.prototype:GetDefaultSettings()
	local settings = RogueExtras2.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = true
	settings["hideAnimationSettings"] = true
	
	return settings
end

-- OVERRIDE
function RogueExtras2.prototype:GetOptions()
	local opts = RogueExtras2.super.prototype.GetOptions(self)

	opts["textSettings"].args["upperTextString"]["desc"] = "The text to display under this bar. # will be replaced with the number of seconds remaining."
	opts["textSettings"].args["upperTextString"].hidden = false

	return opts
end

function RogueExtras2.prototype:CreateFrame()
	RogueExtras2.super.prototype.CreateFrame(self)
end

function RogueExtras2.prototype:RotateHorizontal()
	RogueExtras2.super.prototype.RotateHorizontal(self)

	self:RotateFrame(self.durationFrame)
end

function RogueExtras2.prototype:ResetRotation()
	RogueExtras2.super.prototype.ResetRotation(self)

	if self.durationFrame.anim then
		self.durationFrame.anim:Stop()
	end
end

-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function RogueExtras2.prototype:CreateFrame()
	RogueExtras2.super.prototype.CreateFrame(self)
end

function RogueExtras2.prototype:GetBuffDuration(unitName, buffName, buffID)
	local name, _, _, _, _, duration, endTime, _, _, _, spellID = UnitAura(unitName, buffName)
	if name and spellID == buffID then
		return duration, endTime - GetTime()
	end
	return nil, nil
end

function RogueExtras2.prototype:GetDebuffDuration(unitName, buffName, buffID)
	local name, _, icon, _, _, duration, endTime, caster, _, _, spellID = UnitDebuff("target", buffName)
	if name and spellID == buffID and caster == "player" then
		return duration, endTime - GetTime(), icon
	end
	return nil, nil
end

function RogueExtras2.prototype:MyOnUpdate()
	RogueExtras2.super.prototype.MyOnUpdate(self)
	if self.bUpdateRE then
		self:UpdateRogueExtras2(nil, nil, true)
	end
end

function RogueExtras2.prototype:UpdateRogueExtras2(event, unit, fromUpdate)
	if unit and ((unit ~= "player") and (unit ~= "target")) then
		return
	end

	local now = GetTime()
	local tottRemaining, arRemaining, sdRemaining, vndRemaining = nil, nil, nil, nil

	if not fromUpdate then
		if unit and (unit == "player") then
			if playerSpec == 2 then
				arDuration, arRemaining = self:GetBuffDuration("player", arName, arSpellID)
				if not arRemaining then
					arEndTime = 0
				else
					arEndTime = arRemaining + now
				end
			end
			
			if playerSpec == 3 then
				sdDuration, sdRemaining = self:GetBuffDuration("player", sdName, sdSpellID)
				if not sdRemaining then
					sdEndTime = 0
				else
					sdEndTime = sdRemaining + now
				end
			end
		elseif (unit and (unit == "target")) and (playerSpec == 1) then
			vndDuration, vndRemaining, vndIcon = self:GetDebuffDuration("player", vndName, vndSpellID)
			if not vndRemaining then
				vndEndTime = 0
			else
				vndEndTime = vndRemaining + now
			end
		end
		
		if (arEndTime and arEndTime >= now) or (sdEndTime and sdEndTime >= now) or (vndEndTime and vndEndTime >= now) then
			tottDuration, tottRemaining = self:GetBuffDuration("player", tottName, tottSpellID)
			if not tottRemaining then
				tottEndTime = 0
			else
				tottEndTime = tottRemaining + now
			end
		end
	end
	
	ActiveAuras["ToTT"] = (tottEndTime and tottEndTime >= now)
	ActiveAuras["AR"] = (arEndTime and arEndTime >= now)
	ActiveAuras["SD"] = (sdEndTime and sdEndTime >= now)
	ActiveAuras["VND"] = (vndEndTime and vndEndTime >= now)
	
	if (ActiveAuras["AR"] or ActiveAuras["SD"] or ActiveAuras["VND"]) and ActiveAuras["ToTT"] then
		if not fromUpdate then
			self.bUpdateRE = true
			self:Toggle(true)
		end
		
		if not tottRemaining then
			tottRemaining = tottEndTime - now
		end
		self:UpdateBar(tottDuration ~= 0 and tottRemaining / tottBaseTime or 0, "RogueExtras2ToTT")

		self:SetBottomText1(tottName .. ": " .. string.format("%d", ceil(tottRemaining)))
	else
		self:UpdateBar(0, "RogueExtras2")
		self:Toggle(false)
		self.bUpdateRE = false
	end
end

function RogueExtras2.prototype:OutCombat()
	RogueExtras2.super.prototype.OutCombat(self)

	self:UpdateRogueExtras2()
end

-- Spell Cast
function RogueExtras2.prototype:ShownUpdate(event, ...)
	local unit = ... or "focus"
	if unit == "focus" then
		local show = not(UnitCastingInfo("focus")) and (ActiveAuras["AR"] or ActiveAuras["SD"] or ActiveAuras["VND"]) and ActiveAuras["ToTT"]
		self:Toggle(show)
	end
end

function RogueExtras2.prototype:Toggle(vis)
	if vis and (ActiveAuras["AR"] or ActiveAuras["SD"] or ActiveAuras["VND"]) and ActiveAuras["ToTT"] then
		self:Show(true)
	else
		self:Show(false)
	end
end

function RogueExtras2.prototype:UpdateSpec()
	playerSpec = GetSpecialization()
	self:UpdateRogueExtras2()
end

local _, unitClass = UnitClass("player")

-- Load us up
if unitClass == "ROGUE" then
	nibIceHUD.RogueExtras2 = RogueExtras2:new()
end
