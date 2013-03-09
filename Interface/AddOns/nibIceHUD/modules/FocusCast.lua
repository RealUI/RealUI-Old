local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local FocusCast = IceCore_CreateClass(IceCastBar)
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

-- Constructor --
function FocusCast.prototype:init()
	FocusCast.super.prototype.init(self, "FocusCast")

	self:SetDefaultColor("CastNotInterruptible", 1, 0, 0)
	
	self.unit = "focus"
end


-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function FocusCast.prototype:GetDefaultSettings()
	local settings = FocusCast.super.prototype.GetDefaultSettings(self)

	settings["side"] = IceCore.Side.Right
	settings["offset"] = -3
	settings["scale"] = 0.7
	settings["flashInstants"] = "Never"
	settings["flashFailures"] = "Never"
	settings["shouldAnimate"] = false
	settings["hideAnimationSettings"] = true
	settings["displayNonInterruptible"] = true
	settings["enabled"] = false
	settings["barVerticalOffset"] = 35

	return settings
end


-- OVERRIDE
function FocusCast.prototype:Enable(core)
	FocusCast.super.prototype.Enable(self, core)

	self:RegisterEvent("PLAYER_FOCUS_CHANGED", "FocusChanged")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE", "SpellCastInterruptible")
	self:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE", "SpellCastNotInterruptible")
end

function FocusCast.prototype:FocusChanged(event, unit)
	if not (UnitExists(self.unit)) then
		self:StopBar()
		return
	end

	local spell, _, _, _, _, _, _, _, notInterruptibleCast = UnitCastingInfo(self.unit)
	if (spell) then
		self.notInterruptible = notInterruptibleCast
		self:StartBar(IceCastBar.Actions.Cast)
		return
	end

	local channel, _, _, _, _, _, _, notInterruptibleChannel = UnitChannelInfo(self.unit)
	if (channel) then
		self.notInterruptible = notInterruptibleChannel
		self:StartBar(IceCastBar.Actions.Channel)
		return
	end

	self:StopBar()
end

function FocusCast.prototype:GetOptions()
	local opts = FocusCast.super.prototype.GetOptions(self)

	return opts
end

function FocusCast.prototype:SpellCastInterruptible(event, unit)
	if unit and unit ~= self.unit then
		return
	end

	self.notInterruptible = false
	self:UpdateInterruptibleColor()
end

function FocusCast.prototype:SpellCastNotInterruptible(event, unit)
	if unit and unit ~= self.unit then
		return
	end

	self.notInterruptible = true
	self:UpdateInterruptibleColor()
end


function FocusCast.prototype:UpdateBar(scale, color, alpha)
	FocusCast.super.prototype.UpdateBar(self, scale, color, alpha)
	self:UpdateInterruptibleColor()
end

function FocusCast.prototype:StartBar(action, message)
	local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castId, notInterruptible = UnitCastingInfo(self.unit)
	if not (spell) then
		spell, rank, displayName, icon, startTime, endTime, isTradeSkill, notInterruptible = UnitChannelInfo(self.unit)
	end

	if not spell then
		return
	end

	self.notInterruptible = notInterruptible

	FocusCast.super.prototype.StartBar(self, action, message)
end

function FocusCast.prototype:UpdateInterruptibleColor()
	if self.moduleSettings.displayNonInterruptible then
		if self.notInterruptible then
			self.barFrame.bar:SetVertexColor(self:GetColor("CastNotInterruptible"))
		else
			self.barFrame.bar:SetVertexColor(self:GetColor(self:GetCurrentCastingColor()))
		end
	end
end

-------------------------------------------------------------------------------


-- Load us up
nibIceHUD.FocusCast = FocusCast:new()
