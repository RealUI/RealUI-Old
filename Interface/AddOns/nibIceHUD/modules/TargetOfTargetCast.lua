local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local TargetTargetCast = IceCore_CreateClass(IceCastBar)
TargetTargetCast.prototype.scheduledEvent = nil
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local SelfDisplayModeOptions = {"Hide", "Normal"}

-- Constructor --
function TargetTargetCast.prototype:init()
	TargetTargetCast.super.prototype.init(self, "TargetTargetCast")

	self.unit = "targettarget"
end


-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function TargetTargetCast.prototype:GetDefaultSettings()
	local settings = TargetTargetCast.super.prototype.GetDefaultSettings(self)

	settings["side"] = IceCore.Side.Right
	settings["offset"] = 13
	settings["flashInstants"] = "Never"
	settings["flashFailures"] = "Never"
	settings["shouldAnimate"] = false
	settings["hideAnimationSettings"] = true
	settings["enabled"] = false
	settings["barVerticalOffset"] = 35
	settings["scale"] = 0.7
	settings["selfDisplayMode"] = "Normal"

	return settings
end


-- OVERRIDE
function TargetTargetCast.prototype:Enable(core)
	TargetTargetCast.super.prototype.Enable(self, core)

	self.scheduledEvent = self:ScheduleRepeatingTimer("UpdateTargetTarget", 0.1)
end

function TargetTargetCast.prototype:Disable(core)
	TargetTargetCast.super.prototype.Disable(self, core)

	self:CancelTimer(self.scheduledEvent, true)
end

function TargetTargetCast.prototype:UpdateTargetTarget()
	if not (UnitExists(self.unit)) then
		self:StopBar()
		return
	end

	if self.moduleSettings.selfDisplayMode == "Hide" and UnitIsUnit("player", self.unit) then
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


function TargetTargetCast.prototype:GetOptions()
	local opts = TargetTargetCast.super.prototype.GetOptions(self)

	opts["selfDisplayMode"] = {
		type = 'select',
		name = L["Self Display Mode"],
		desc = L["What this bar should do whenever the player is the TargetOfTarget"],
		get = function(info)
			return nibIceHUD:GetSelectValue(info, self.moduleSettings.selfDisplayMode)
		end,
		set = function(info, value)
			self.moduleSettings.selfDisplayMode = info.option.values[value]
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		values = SelfDisplayModeOptions,
		order = 44,
	}

	return opts
end

-------------------------------------------------------------------------------


-- Load us up
nibIceHUD.TargetTargetCast = TargetTargetCast:new()
