local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local Rapture = IceCore_CreateClass(IceUnitBar)
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local nibIceHUD = _G.nibIceHUD

local raptureTime = 12
local raptureID = 47755
local playerName = ""

-- Constructor --
function Rapture.prototype:init()
	Rapture.super.prototype.init(self, "Rapture", "player")

	self.moduleSettings = {}
	self.moduleSettings.desiredLerpTime = 0
	self.moduleSettings.shouldAnimate = false

	self:SetDefaultColor("Rapture", 1, 1, 1)

	self.bTreatEmptyAsFull = true
	
	self.lastRaptureEnd = 0
end

-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function Rapture.prototype:Enable(core)
	Rapture.super.prototype.Enable(self, core)

	playerName = UnitName("player")
	
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	self:Show(false)
	self:SetBottomText1("")
end

function Rapture.prototype:Disable(core)
	Rapture.super.prototype.Disable(self, core)
end

-- OVERRIDE
function Rapture.prototype:GetDefaultSettings()
	local settings = Rapture.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = true
	settings["shouldAnimate"] = false
	settings["desiredLerpTime"] = nil
	settings["lowThreshold"] = 0
	settings["side"] = IceCore.Side.Right
	settings["offset"] = 6
	settings["upperText"]="Ra"
	settings["lockLowerFontAlpha"] = false
	settings["lowerTextString"] = ""
	settings["lowerTextVisible"] = false
	settings["hideAnimationSettings"] = true

	return settings
end

-- OVERRIDE
function Rapture.prototype:GetOptions()
	local opts = Rapture.super.prototype.GetOptions(self)

	opts["textSettings"].args["upperTextString"]["desc"] = "The text to display under this bar. # will be replaced with the remaining time until Rapture can be used again."
	opts["textSettings"].args["upperTextString"].hidden = false

	return opts
end

function Rapture.prototype:CreateFrame()
	Rapture.super.prototype.CreateFrame(self)
end


-- 'Protected' methods --------------------------------------------------------

function Rapture.prototype:MyOnUpdate()
	Rapture.super.prototype.MyOnUpdate(self)
	
	if not self.lastRaptureEnd then self.lastRaptureEnd = 0 end
	
	local CurTime = GetTime()
	if (self.lastRaptureEnd > CurTime) then
		local remaining = self.lastRaptureEnd - CurTime
		self:UpdateBar(remaining / raptureTime or 0, "Rapture")
		self:SetBottomText1(self.moduleSettings.upperText .. " " .. tostring(ceil(remaining or 0)))
	else
		self:Show(false)
	end
end

function Rapture.prototype:SPELL_ENERGIZE(sourceName, destName, spellID)
	if destName == playerName and sourceName == playerName and spellID == raptureID then
		self.lastRaptureEnd = GetTime() + raptureTime
		self:Show(true)
	end
end

function Rapture.prototype:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, dstFlags2, spellID, ...)
	if event == "SPELL_ENERGIZE" then
		self:SPELL_ENERGIZE(sourceName, destName, spellID)
	end
end

function Rapture.prototype:OutCombat()
	Rapture.super.prototype.OutCombat(self)
end

-- Load us up
local _, unitClass = UnitClass("player")
if unitClass == "PRIEST" then
	nibIceHUD.Rapture = Rapture:new()
end
