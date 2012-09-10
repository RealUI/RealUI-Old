local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local RogueLegendary = IceCore_CreateClass(IceUnitBar)
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local nibIceHUD = _G.nibIceHUD

local fBaseTime = 6
local fEndTime = 0
local fDuration = 0
local fSpellID = 109949
local fName = ""

local s1BaseStacks = 50
local s1CurStacks = 0
local s1SpellID = 109941
local s1Name = ""

local s2BaseStacks = 50
local s2CurStacks = 0
local s2SpellID = 109959
local s2Name = ""

local s3BaseStacks = 50
local s3CurStacks = 0
local s3SpellID = 109955
local s3Name = ""

local isFActive = false
local isSActive = false
local CurSActive = 0

-- Constructor --
function RogueLegendary.prototype:init()
	RogueLegendary.super.prototype.init(self, "RogueLegendary", "player")

	self.moduleSettings = {}
	self.moduleSettings.desiredLerpTime = 0
	self.moduleSettings.shouldAnimate = false

	self:SetDefaultColor("RogueLegendaryStacks", 0.45, 0.45, 1)
	self:SetDefaultColor("RogueLegendaryFury", 1, 0.4, 0.4)

	self.bTreatEmptyAsFull = true
end

-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function RogueLegendary.prototype:Enable(core)
	RogueLegendary.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_AURA", "UpdateRogueLegendary")
	
	fName = GetSpellInfo(fSpellID)
	s1Name = GetSpellInfo(s1SpellID)
	s2Name = GetSpellInfo(s2SpellID)
	s3Name = GetSpellInfo(s3SpellID)
	
	if not self.moduleSettings.alwaysFullAlpha then
		self:Show(false)
	else
		self:UpdateRogueLegendary()
	end

	self:SetBottomText1("")
end

function RogueLegendary.prototype:Disable(core)
	RogueLegendary.super.prototype.Disable(self, core)
end

-- OVERRIDE
function RogueLegendary.prototype:GetDefaultSettings()
	local settings = RogueLegendary.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = true
	settings["shouldAnimate"] = false
	settings["side"] = IceCore.Side.Right
	settings["offset"] = 6
	settings["hideAnimationSettings"] = true
	settings["lockLowerFontAlpha"] = false
	settings["lowerTextString"] = ""
	settings["bAllowExpand"] = true
	
	return settings
end

-- OVERRIDE
function RogueLegendary.prototype:GetOptions()
	local opts = RogueLegendary.super.prototype.GetOptions(self)

	opts["textSettings"].args["upperTextString"]["desc"] = "The text to display under this bar. # will be replaced with the number of seconds remaining."
	opts["textSettings"].args["upperTextString"].hidden = false

	return opts
end

function RogueLegendary.prototype:CreateFrame()
	RogueLegendary.super.prototype.CreateFrame(self)
end

function RogueLegendary.prototype:RotateHorizontal()
	RogueLegendary.super.prototype.RotateHorizontal(self)

	self:RotateFrame(self.durationFrame)
end

function RogueLegendary.prototype:ResetRotation()
	RogueLegendary.super.prototype.ResetRotation(self)

	if self.durationFrame.anim then
		self.durationFrame.anim:Stop()
	end
end

-- 'Protected' methods --------------------------------------------------------
function RogueLegendary.prototype:GetBuffInfo(unitName, buffName)
	local name, _, _, count, _, duration, endTime = UnitAura(unitName, buffName)
	if name then
		return duration, endTime - GetTime(), count
	end
	return nil, nil
end

function RogueLegendary.prototype:MyOnUpdate()
	RogueLegendary.super.prototype.MyOnUpdate(self)
	if self.bUpdateRL then
		self:UpdateRogueLegendary(nil, "player", true)
	end
end

function RogueLegendary.prototype:UpdateRogueLegendary(event, unit, fromUpdate)
	if unit and unit ~= "player" then
		return
	end

	local now = GetTime()
	local fRemaining = nil
	local s1Active, s2Active, s3Active
	
	if not fromUpdate then
		fDuration, fRemaining = self:GetBuffInfo("player", fName)
		isFActive = fDuration ~= nil
		if isFActive then
			if not fRemaining then
				fEndTime = 0
			else
				fEndTime = fRemaining + now
			end
		end
		
		_, _, s1CurStacks = self:GetBuffInfo("player", s1Name)
		s1Active = (s1CurStacks ~= nil and s1CurStacks > 0)
		if s1Active then CurSActive = 1 end
		if not(s1Active) then
			_, _, s2CurStacks = self:GetBuffInfo("player", s2Name)
			s2Active = (s2CurStacks ~= nil and s2CurStacks > 0)
			if s2Active then CurSActive = 2 end
		end
		if not(s1Active) and not(s2Active) then
			_, _, s3CurStacks = self:GetBuffInfo("player", s3Name)
			s3Active = (s3CurStacks ~= nil and s3CurStacks > 0)
			if s3Active then CurSActive = 3 end
		end
		CurSActive = not(s1Active or s2Active or s3Active) and 0 or CurSActive
	end
	
	if isFActive or CurSActive > 0 then
		if not fromUpdate then
			self.bUpdateRL = true
		end
		self:Show(true)
		
		if isFActive then
			if not fRemaining then
				fRemaining = fEndTime - now
			end
			self:UpdateBar(fRemaining / fBaseTime or 0, "RogueLegendaryFury")
			self:SetBottomText1("F " .. string.format("%d", ceil(fRemaining)))
			
		elseif CurSActive > 0 then
			local CurStacks, CurBaseStacks
			if CurSActive == 1 then
				CurStacks, CurBaseStacks = s1CurStacks, s1BaseStacks
			elseif CurSActive == 2 then
				CurStacks, CurBaseStacks = s2CurStacks, s2BaseStacks
			else
				CurStacks, CurBaseStacks = s3CurStacks, s3BaseStacks
			end
			self:UpdateBar(CurStacks / CurBaseStacks or 0, "RogueLegendaryStacks")
			self:SetBottomText1("S " .. string.format("%d", ceil(CurStacks)))
		
		end
	else
		self:UpdateBar(0, "RogueLegendary")
		self:Show(false)
		self.bUpdateRL = false
	end
end

local _, unitClass = UnitClass("player")

-- Load us up
if unitClass == "ROGUE" then
	nibIceHUD.RogueLegendary = RogueLegendary:new()
end
