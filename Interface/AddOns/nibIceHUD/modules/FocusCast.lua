local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local FocusCast = IceCore_CreateClass(IceCastBar)

-- Constructor --
function FocusCast.prototype:init()
	FocusCast.super.prototype.init(self, "FocusCast")

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
	settings["enabled"] = false
	settings["barVerticalOffset"] = 35

	return settings
end


-- OVERRIDE
function FocusCast.prototype:Enable(core)
	FocusCast.super.prototype.Enable(self, core)

	self:RegisterEvent("PLAYER_FOCUS_CHANGED", "FocusChanged")
end


function FocusCast.prototype:FocusChanged(event, unit)
	if not (UnitExists(self.unit)) then
		self:StopBar()
		return
	end

	local spell = UnitCastingInfo(self.unit)
	if (spell) then
		self:StartBar(IceCastBar.Actions.Cast)
		return
	end

	local channel = UnitChannelInfo(self.unit)
	if (channel) then
		self:StartBar(IceCastBar.Actions.Channel)
		return
	end

	self:StopBar()
end


function FocusCast.prototype:GetOptions()
	local opts = FocusCast.super.prototype.GetOptions(self)

	return opts
end

-------------------------------------------------------------------------------


-- Load us up
nibIceHUD.FocusCast = FocusCast:new()
