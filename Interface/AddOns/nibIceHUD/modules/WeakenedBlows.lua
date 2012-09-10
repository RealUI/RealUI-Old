local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local WeakenedBlows = IceCore_CreateClass(IceUnitBar)
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local nibIceHUD = _G.nibIceHUD


-- Constructor --
function WeakenedBlows.prototype:init()
	WeakenedBlows.super.prototype.init(self, "WeakenedBlows", "target")


	self.moduleSettings = {}
	self.moduleSettings.desiredLerpTime = 0
	self.moduleSettings.shouldAnimate = false

	self:SetDefaultColor("WeakenedBlowsColor", 0.45, 0.45, 1)
	self.bTreatEmptyAsFull = true

	self.endTime = 0
	self.duration = 0
	self.remaining = 0
	self.name = "Weakened Blows"
	self.isAura = false
	self.isTank = false
end

function WeakenedBlows.prototype:Redraw()
	WeakenedBlows.super.prototype.Redraw(self)
	self:MyOnUpdate()
end

function WeakenedBlows.prototype:GetOptions()
	local opts = WeakenedBlows.super.prototype.GetOptions(self)

	opts["textSettings"].args["upperTextString"]["desc"] = "The text to display under this bar. # will be replaced with the number of seconds remaining."
	opts["textSettings"].args["upperTextString"].hidden = false

	return opts
end

function WeakenedBlows.prototype:GetDefaultSettings()
	local defaults = WeakenedBlows.super.prototype.GetDefaultSettings(self)

	defaults.enabled = true
	defaults.shouldAnimate = false
	defaults.side = IceCore.Side.Right
	defaults.offset = 2
	defaults.hideAnimationSettings = true
	defaults.lockLowerFontAlpha = false
	defaults.lowerTextString = ""
	defaults.bAllowExpand = true
	--defaults.buffOrDebuff = "Debuff"
	
	return defaults
end

function WeakenedBlows.prototype:isTankUpdate()
	local role = self:checkRole()
	--print("3: "..tostring(role))
	if role and role == "TANK" then
		self.isTank = true
	else
		self.isTank = false
	end
end

function WeakenedBlows.prototype:Enable(core)
	WeakenedBlows.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_AURA", "isActive")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "isTankUpdate")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateWeakenedBlows")

	self:UpdateShown()
	self:UpdateWeakenedBlows()
	--print("4: "..tostring(self.isTank))
end

function WeakenedBlows.prototype:Disable(core)
	WeakenedBlows.super.prototype.Disable(self, core)
end

function WeakenedBlows.prototype:CreateFrame()
	WeakenedBlows.super.prototype.CreateFrame(self)
	
	self:UpdateShown()
end

function WeakenedBlows.prototype:UpdateShown()
	if self.isTank then
		self:Show(true)
	else
		self:Show(false)
	end
end

function WeakenedBlows.prototype:isActive()
	if ( UnitDebuff("target", "Weakened Blows") ) then
		return true
	else
		return false
	end
end

function WeakenedBlows.prototype:GetBuffInfo(unitName, buffName)
	local name, _, _, _, _, duration, endTime = UnitDebuff(unitName, buffName)
	--print(name.." : "..duration.." : "..endTime)
	if name then
		return duration, endTime - GetTime(), endTime
	end
	return nil, nil
end

function WeakenedBlows.prototype:UpdateWeakenedBlows(event, unit, fromUpdate)
	if unit and unit ~= "target" then
		return
	end

	self.duration, self.remaining, self.endTime = self:GetBuffInfo("target", self.name)
	
	if self.isActive() then
		if not self.remaining then
			self.remaining = self.endTime - GetTime()
		end
		self:UpdateBar(self.remaining / self.duration or 0, "WeakenedBlowsColor")
		self:SetBottomText1(string.format("%d WB", ceil(self.remaining)))
	else
--		self:UpdateBar(0, "WeakenedBlowsColor")
		self:Show(false)
	end
end

function WeakenedBlows.prototype:MyOnUpdate()
	WeakenedBlows.super.prototype.MyOnUpdate(self)
	self:Update()
	
	self:UpdateWeakenedBlows(nil, "target", true)
end

-- Load for tanks only
local _, unitClass = UnitClass("player")
if (unitClass == "DEATHKNIGHT" or unitClass == "DRUID" or unitClass == "PALADIN" or unitClass == "WARRIOR" or unitClass == "MONK") then
	nibIceHUD.WeakenedBlows = WeakenedBlows:new()
end
