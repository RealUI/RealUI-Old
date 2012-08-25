local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local DemonicFuryBar = IceCore_CreateClass(IceUnitBar)

local nibIceHUD = _G.nibIceHUD

DemonicFuryBar.prototype.barUpdateColor = "DemonicFury"

function DemonicFuryBar.prototype:init()
	DemonicFuryBar.super.prototype.init(self, "DemonicFuryBar", "player")

	self:SetDefaultColor("DemonicFury", 160, 53, 255)
	self:SetDefaultColor("DemonicFuryActive", 224, 50, 255)
	self.bTreatEmptyAsFull = false
	self.power = 0
	self.maxPower = 0
	self.powerPercent = 0
	self.powerIndex = SPELL_POWER_DEMONIC_FURY
	self.powerName = "DEMONIC_FURY"
end

function DemonicFuryBar.prototype:Redraw()
	DemonicFuryBar.super.prototype.Redraw(self)
	self:MyOnUpdate()
end

function DemonicFuryBar.prototype:GetOptions()
	local opts = DemonicFuryBar.super.prototype.GetOptions(self)
	opts.reverse.hidden = true
	return opts
end

function DemonicFuryBar.prototype:GetDefaultSettings()
	local defaults =  DemonicFuryBar.super.prototype.GetDefaultSettings(self)

	defaults.textVisible.lower = false
	defaults.offset = 2
	defaults.enabled = true
	defaults.usesDogTagStrings = false
	defaults.textVerticalOffset = 5
	defaults.textHorizontalOffset = 0
	defaults.shouldAnimate = false
	defaults.hideAnimationSettings = true
	defaults.lockUpperTextAlpha = false
	defaults.bHideMarkerSettings = true
	defaults.markers[1] = {
		position = 0,
		color = {r=1, g=0, b=0, a=1},
		height = 1,
	}
	defaults.bAllowExpand = false

	return defaults
end

function DemonicFuryBar.prototype:Enable(core)
	DemonicFuryBar.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_POWER", "UpdateDemonicFury")
	self:RegisterEvent("UNIT_MAXPOWER", "UpdateDemonicFury")
--	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "UpdateShown")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "UpdateShown")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateShown")
	self:RegisterEvent("UNIT_AURA", "isActive")

	self:UpdateShown()
end

function DemonicFuryBar.prototype:Disable(core)
	DemonicFuryBar.super.prototype.Disable(self, core)
end

function DemonicFuryBar.prototype:CreateFrame()
	DemonicFuryBar.super.prototype.CreateFrame(self)

	self:UpdateShown()
	self:UpdateAlpha()
end

function DemonicFuryBar.prototype:UpdateShown()
	if  GetSpecialization() == 2 then
		self:Show(true)
	else
		self:Show(false)
	end
end

function DemonicFuryBar.prototype:UseTargetAlpha(scale)
	return UnitPower("player", SPELL_POWER_DEMONIC_FURY) ~= 0 and self.combat
end

function DemonicFuryBar.prototype:isActive()
	if ( UnitBuff("player", "Metamorphosis") ) then
		return true
	else
		return false
	end
end

function DemonicFuryBar.prototype:UpdateDemonicFury()
	self.power = UnitPower("player", SPELL_POWER_DEMONIC_FURY)
	self.maxPower = UnitPowerMax("player", SPELL_POWER_DEMONIC_FURY)

	if self.power > 0 then
		self.powerPercent = self.power / self.maxPower
	else
		self.powerPercent = 0
	end
	
	if self:isActive() then
		self:UpdateBar(self.powerPercent, "DemonicFuryActive")--, 1)
	else
		self:UpdateBar(self.powerPercent, "DemonicFury")--, 1)
	end

	self:PositionMarker(1, 0.2)
end

function DemonicFuryBar.prototype:MyOnUpdate()
	self:Update()

	self:UpdateDemonicFury()
--	self:UpdateBar(0.5, self.barUpdateColor, 1)
	self:UpdateAlpha()
end

local _, unitClass = UnitClass("player")
if unitClass == "WARLOCK" and GetSpecialization() == 2 then
	nibIceHUD.DemonicFuryBar = DemonicFuryBar:new()
end
