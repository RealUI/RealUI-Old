local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local Vengeance = IceCore_CreateClass(IceUnitBar)
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local VENGEANCE_SPELL_ID = 93098	-- To get name of Vengeance buff

Vengeance.prototype.current = nil
Vengeance.prototype.max = nil

-- Readable Numbers
local function FormatToDecimalPlaces(num, places)
	local placeValue = ("%%.%df"):format(places)
	return placeValue:format(num)
end

local function ReadableNumber(num)
	local ret = 0
	if not num then
		return 0
	elseif num >= 100000000 then
		ret = FormatToDecimalPlaces(num / 1000000, 0) .. "m" -- hundred million
	elseif num >= 10000000 then
		ret = FormatToDecimalPlaces(num / 1000000, 1) .. "m" -- ten million
	elseif num >= 1000000 then
		ret = FormatToDecimalPlaces(num / 1000000, 2) .. "m" -- million
	elseif num >= 100000 then
		ret = FormatToDecimalPlaces(num / 1000, 0) .. "k" -- hundred thousand
	elseif num >= 10000 then
		ret = FormatToDecimalPlaces(num / 1000, 1) .. "k" -- ten thousand
	elseif num >= 1000 then
		ret = FormatToDecimalPlaces(num / 1000, 2) .. "k" -- thousand
	else
		ret = num -- hundreds
	end
	return ret
end

-- constructor
function Vengeance.prototype:init()
	Vengeance.super.prototype.init(self, "Vengeance", "player")

	self.current = 0
	self:SetDefaultColor("Vengeance", 1, 1, 1)

	self.bTreatEmptyAsFull = true
end

-- default settings
function Vengeance.prototype:GetDefaultSettings()
	local defaults = Vengeance.super.prototype.GetDefaultSettings(self)
	defaults.enabled = false
	defaults.lockUpperTextAlpha = false
	defaults.shouldAnimate = false
	defaults.hideAnimationSettings = true
	defaults.offset = 5
	defaults.side = IceCore.Side.Left
	return defaults
end

-- enable plugin
function Vengeance.prototype:Enable(core)
	Vengeance.super.prototype.Enable(self, core)

	-- Avoiding iteration where I can
	self:RegisterEvent("UNIT_AURA", "UpdateCurrent")
	self:RegisterEvent("UNIT_MAXHEALTH", "UpdateMax")

	self:UpdateMax()
end

-- disable plugin
function Vengeance.prototype:Disable(core)
	Vengeance.super.prototype.Disable(self, core)

	self:UnregisterAllEvents()
end

-- scan the tooltip and extract the vengeance value
do
	-- making these local as they're not used anywhere else
	local regions = {}
	local spellName = GetSpellInfo(VENGEANCE_SPELL_ID)
	local tooltipBuffer = CreateFrame("GameTooltip","tooltipBuffer",nil,"GameTooltipTemplate")
	tooltipBuffer:SetOwner(WorldFrame, "ANCHOR_NONE")

	-- suggested by Antiarc as a way to repopulate the same table instead of repeatedly creating a new one
	local function makeTable(t, ...)
		wipe(t)
		for i = 1, select("#", ...) do
			t[i] = select(i, ...)
		end
	end

	function Vengeance.prototype:UpdateCurrent(event, unit)
		if (unit and (unit ~= self.unit)) then
			return
		end

		local name = UnitAura(self.unit, spellName)
		if name then
			-- Buff found, copy it into the buffer for scanning
			tooltipBuffer:ClearLines()
			tooltipBuffer:SetUnitBuff(self.unit, name)

			-- Grab all regions, stuff em into our table
			makeTable(regions, tooltipBuffer:GetRegions())

			-- Convert FontStrings to strings, replace anything else with ""
			for i=1, #regions do
				local region = regions[i]
				regions[i] = region:GetObjectType() == "FontString" and region:GetText() or ""
			end

			-- Find the number, save it
			self.current = tonumber(string.match(table.concat(regions),"%d+")) or 0
		else
			self.current = 0
		end

		self:Update()
	end
end

function Vengeance.prototype:UpdateMax(event, unit)
	if (unit and (unit ~= self.unit)) then
		return
	end
	
	local Stam, MaxHealth, BaseHealth = UnitStat(self.unit, 3), UnitHealthMax(self.unit)
	if Stam < 20 then
		BaseHealth = MaxHealth - Stam
	else
		BaseHealth = MaxHealth - ((Stam - 19) * 10) - 6
	end
	local MaxVeng = MaxHealth --floor(Stam + (BaseHealth / 10))
	
	self.max = MaxVeng
	self:Update()
end

function Vengeance.prototype:Update()
	Vengeance.super.prototype.Update(self)

	if self.current == 0 then
		self:Show(false)
		return
	else
		self:Show(true)
	end

	self:UpdateBar(self.current / self.max, "Vengeance")
	self:SetBottomText1("V " .. tostring(ReadableNumber(self.current)))
end

-- Load for tanks only
local _, unitClass = UnitClass("player")
if (unitClass == "DEATHKNIGHT" or unitClass == "DRUID" or unitClass == "PALADIN" or unitClass == "WARRIOR" or unitClass == "MONK") then
	nibIceHUD.Vengeance = Vengeance:new()
end