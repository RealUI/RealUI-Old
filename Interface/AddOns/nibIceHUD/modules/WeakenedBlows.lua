local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local WeakenedBlows = IceCore_CreateClass(IceUnitBar)

local nibIceHUD = _G.nibIceHUD

local fEndTime = 0
local fDuration = 0
local fSpellID = 115798
local fName = ""
local isAura = false
local isTank = false
--print("1: "..tostring(isTank))

--[[ function WeakenedBlows.prototype:checkRole()
	--WeakenedBlows.super.prototype.checkRole(self)
	print("2: "..tostring(isTank))
	
	local spec = GetSpecialization()
	local role = select(6, GetSpecializationInfo(spec)) or "None"
	if role and role == "TANK" then
		isTank = true
	else
		isTank = false
		self:Disable()
	end
	print("3: "..tostring(isTank))
end ]]

-- Constructor --
function WeakenedBlows.prototype:init()
	WeakenedBlows.super.prototype.init(self, "WeakenedBlows", "target")


	self.moduleSettings = {}
	self.moduleSettings.desiredLerpTime = 0
	self.moduleSettings.shouldAnimate = false

	self:SetDefaultColor("WeakenedBlowsStacks", 0.45, 0.45, 1)
	self:SetDefaultColor("WeakenedBlowsFury", 1, 0.4, 0.4)

	self.bTreatEmptyAsFull = true
end

-- 'Public' methods -----------------------------------------------------------
function WeakenedBlows.prototype:isTankUpdate()
	local role = self:checkRole()
	--print("3: "..tostring(role))
	if role and role == "TANK" then
		isTank = true
	else
		isTank = false
	end
end

-- OVERRIDE
function WeakenedBlows.prototype:Enable(core)
	WeakenedBlows.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_AURA", "UpdateWeakenedBlows")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "isTankUpdate")
	
	fName = GetSpellInfo(fSpellID)
	
	self:UpdateWeakenedBlows()

	self:SetBottomText1("WB")
	
	--print("4: "..tostring(isTank))
end

function WeakenedBlows.prototype:Disable(core)
	WeakenedBlows.super.prototype.Disable(self, core)
end

function WeakenedBlows.prototype:TargetChanged()
	WeakenedBlows.super.prototype.TargetChanged(self)
	self:UpdateWeakenedBlows()
end

-- OVERRIDE
function WeakenedBlows.prototype:GetDefaultSettings()
	local settings = WeakenedBlows.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = true
	settings["shouldAnimate"] = false
	settings["side"] = IceCore.Side.Right
	settings["offset"] = 6
	settings["hideAnimationSettings"] = true
	settings["lockLowerFontAlpha"] = false
	settings["lowerTextString"] = ""
	settings["bAllowExpand"] = true
	--settings["buffOrDebuff"] = "Debuff"
	
	return settings
end

-- OVERRIDE
function WeakenedBlows.prototype:GetOptions()
	local opts = WeakenedBlows.super.prototype.GetOptions(self)

	opts["textSettings"].args["upperTextString"]["desc"] = "The text to display under this bar. # will be replaced with the number of seconds remaining."
	opts["textSettings"].args["upperTextString"].hidden = false

	return opts
end

function WeakenedBlows.prototype:CreateFrame()
	WeakenedBlows.super.prototype.CreateFrame(self)
end

function WeakenedBlows.prototype:RotateHorizontal()
	WeakenedBlows.super.prototype.RotateHorizontal(self)

	self:RotateFrame(self.durationFrame)
end

function WeakenedBlows.prototype:ResetRotation()
	WeakenedBlows.super.prototype.ResetRotation(self)

	if self.durationFrame.anim then
		self.durationFrame.anim:Stop()
	end
end

-- 'Protected' methods --------------------------------------------------------
function WeakenedBlows.prototype:GetBuffInfo(unitName, buffName)
	local name, _, _, _, _, duration, endTime = UnitDebuff(unitName, buffName)
	if name then
		return duration, endTime - GetTime(), endTime
	end
	return nil, nil
end

function WeakenedBlows.prototype:MyOnUpdate()
	WeakenedBlows.super.prototype.MyOnUpdate(self)
	if self.bUpdateWB then
		self:UpdateWeakenedBlows(nil, "target", true)
	end
end

function WeakenedBlows.prototype:UpdateWeakenedBlows(event, unit, fromUpdate)
	self:Show(isTank)
	
	if unit and unit ~= "target" then
		return
	end

	local now = GetTime()
	local fRemaining = nil

	if not fromUpdate then
		fDuration, fRemaining = self:GetBuffInfo("target", fName)
		isAura = (fDuration ~= nil)
		if isAura then
			if not fRemaining then
				fEndTime = 0
			else
				fEndTime = fRemaining + now
			end
		end
	end
	
	if isAura then
		if not fromUpdate then
			self.bUpdateWB = true
		end
		self:Show(true)
		
		if not fRemaining then
			fRemaining = fEndTime - now
		end
		self:UpdateBar(fRemaining / fDuration or 0, "WeakenedBlowsFury")
		self:SetBottomText1(string.format("%d WB", ceil(fRemaining)))
	else
		self:UpdateBar(0, "WeakenedBlows")
		self:Show(false)
		self.bUpdateWB = false
	end
end

-- Load for tanks only
local _, unitClass = UnitClass("player")
if (unitClass == "DEATHKNIGHT" or unitClass == "DRUID" or unitClass == "PALADIN" or unitClass == "WARRIOR" or unitClass == "MONK") then
	nibIceHUD.WeakenedBlows = WeakenedBlows:new()
end
