local TargetCast = IceCore_CreateClass(IceCastBar)
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

TargetCast.prototype.notInterruptible = false

-- Constructor --
function TargetCast.prototype:init()
	TargetCast.super.prototype.init(self, "TargetCast")

	self:SetDefaultColor("CastNotInterruptible", 1, 0, 0)

	self.unit = "target"
end

function TargetCast.prototype:Enable(core)
	TargetCast.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE", "SpellCastInterruptible")
	self:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE", "SpellCastNotInterruptible")
end


function TargetCast.prototype:SpellCastInterruptible(event, unit)
	if unit and unit ~= self.unit then
		return
	end

	self.notInterruptible = false
	self:UpdateInterruptibleColor()
end

function TargetCast.prototype:SpellCastNotInterruptible(event, unit)
	if unit and unit ~= self.unit then
		return
	end

	self.notInterruptible = true
	self:UpdateInterruptibleColor()
end

function TargetCast.prototype:UpdateBar(scale, color, alpha)
	TargetCast.super.prototype.UpdateBar(self, scale, color, alpha)
	self:UpdateInterruptibleColor()
end

function TargetCast.prototype:UpdateInterruptibleColor()
	if self.moduleSettings.displayNonInterruptible then
		if self.notInterruptible then
			self.barFrame.bar:SetVertexColor(self:GetColor("CastNotInterruptible"))
		else
			self.barFrame.bar:SetVertexColor(self:GetColor(self:GetCurrentCastingColor()))
		end
	end
end


-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function TargetCast.prototype:GetDefaultSettings()
	local settings = TargetCast.super.prototype.GetDefaultSettings(self)

	settings["side"] = IceCore.Side.Right
	settings["offset"] = 3
	settings["flashInstants"] = "Never"
	settings["flashFailures"] = "Never"
	settings["displayNonInterruptible"] = true

	return settings
end


-- OVERRIDE
function TargetCast.prototype:TargetChanged(unit)
	TargetCast.super.prototype.TargetChanged(self, unit)

	if not (self.target) then
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


function TargetCast.prototype:GetOptions()
	local opts = TargetCast.super.prototype.GetOptions(self)

	opts["displayNonInterruptible"] = {
		type = 'toggle',
		name = "Display non-interruptible color",
		desc = "Toggles whether or not to show the CastNonInterruptible color for this bar when a cast is non-interruptible",
		width = 'double',
		get = function()
			return self.moduleSettings.displayNonInterruptible
		end,
		set = function(info, v)
			self.moduleSettings.displayNonInterruptible = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 30
	}

	return opts
end

function TargetCast.prototype:StartBar(action, message)
	local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castId, notInterruptible = UnitCastingInfo(self.unit)
	if not (spell) then
		spell, rank, displayName, icon, startTime, endTime, isTradeSkill, notInterruptible = UnitChannelInfo(self.unit)
	end

	if not spell then
		return
	end

	self.notInterruptible = notInterruptible

	TargetCast.super.prototype.StartBar(self, action, message)
end

-------------------------------------------------------------------------------


-- Load us up
nibIceHUD.TargetCast = TargetCast:new()
