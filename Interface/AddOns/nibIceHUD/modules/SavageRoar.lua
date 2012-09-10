local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local SavageRoar = IceCore_CreateClass(IceUnitBar)
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local nibIceHUD = _G.nibIceHUD

local baseTime = 18
local gapPerComboPoint = 6
local maxComboPoints = 5
local SREndTime = 0
local SRDuration = 0

local CurrMaxSRDuration = 0
local PotentialSRDuration = 0

-- Constructor --
function SavageRoar.prototype:init()
	SavageRoar.super.prototype.init(self, "SavageRoar", "player")

	self.moduleSettings = {}
	self.moduleSettings.desiredLerpTime = 0
	self.moduleSettings.shouldAnimate = false

	self:SetDefaultColor("SavageRoar", 0.75, 1, 0.2)
	self:SetDefaultColor("SavageRoarPotential", 1, 1, 1)

	self.bTreatEmptyAsFull = true
end

-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function SavageRoar.prototype:Enable(core)
	SavageRoar.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_AURA", "UpdateSavageRoar")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "TargetChanged")
	self:RegisterEvent("UNIT_COMBO_POINTS", "UpdateDurationBar")

	if not self.moduleSettings.alwaysFullAlpha then
		self:Show(false)
	else
		self:UpdateSavageRoar()
	end

	self:SetBottomText1("")
end

function SavageRoar.prototype:Toggle(vis)
	local Form = GetShapeshiftFormID()
	local UL = UnitLevel("player")
	if ( vis and (Form == CAT_FORM) and (UL >= 76) ) then
		self:Show(true)
	else
		self:Show(false)
	end
end

function SavageRoar.prototype:TargetChanged()
	SavageRoar.super.prototype.TargetChanged(self)
	self:UpdateDurationBar()
	self:UpdateSavageRoar()
end

function SavageRoar.prototype:Disable(core)
	SavageRoar.super.prototype.Disable(self, core)
end

-- OVERRIDE
function SavageRoar.prototype:GetDefaultSettings()
	local settings = SavageRoar.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = true
	settings["shouldAnimate"] = false
	settings["desiredLerpTime"] = nil
	settings["lowThreshold"] = 0
	settings["side"] = IceCore.Side.Right
	settings["offset"] = 6
	settings["upperText"]="SR"
	settings["showAsPercentOfMax"] = true
	settings["durationAlpha"] = 0.6
	settings["lockLowerFontAlpha"] = false
	settings["lowerTextString"] = ""
	settings["lowerTextVisible"] = false
	settings["hideAnimationSettings"] = true
	settings["bAllowExpand"] = true

	return settings
end

-- OVERRIDE
function SavageRoar.prototype:GetOptions()
	local opts = SavageRoar.super.prototype.GetOptions(self)

	opts["textSettings"].args["upperTextString"]["desc"] = "The text to display under this bar. # will be replaced with the number of Slice and Dice seconds remaining."
	opts["textSettings"].args["upperTextString"].hidden = false

	opts["showAsPercentOfMax"] =
	{
		type = 'toggle',
		name = L["Show bar as % of maximum"],
		desc = "If this is checked, then the SR buff time shows as a percent of the maximum attainable (taking set bonuses and talents into account). Otherwise, the bar always goes from full to empty when applying SR no matter the duration.",
		get = function()
			return self.moduleSettings.showAsPercentOfMax
		end,
		set = function(info, v)
			self.moduleSettings.showAsPercentOfMax = v
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end
	}

	opts["durationAlpha"] =
	{
		type = "range",
		name = "Potential SR time bar alpha",
		desc = "What alpha value to use for the bar that displays how long your SR will last if you activate it. (This gets multiplied by the bar's current alpha to stay in line with the bar on top of it)",
		min = 0,
		max = 100,
		step = 5,
		get = function()
			return self.moduleSettings.durationAlpha * 100
		end,
		set = function(info, v)
			self.moduleSettings.durationAlpha = v / 100.0
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end
	}

	return opts
end

function SavageRoar.prototype:CreateFrame()
	SavageRoar.super.prototype.CreateFrame(self)

	self:CreateDurationBar()
end

function SavageRoar.prototype:CreateDurationBar()
	self.durationFrame = self:BarFactory(self.durationFrame, "BACKGROUND","ARTWORK")

	-- Rokiyo: Do we need to call this here?
	self.CurrScale = 0

	self.durationFrame.bar:SetVertexColor(self:GetColor("SavageRoarPotential", self.moduleSettings.durationAlpha))
	self.durationFrame.bar:SetHeight(0)

	self:UpdateBar(1, "undef")

	-- force update the bar...if we're in here, then either the UI was just loaded or the player is jacking with the options.
	-- either way, make sure the duration bar matches accordingly
	self:UpdateDurationBar()
end


-- 'Protected' methods --------------------------------------------------------

function SavageRoar.prototype:GetBuffDuration(unitName)
	local name,_,_,_,_, duration, expirationTime = UnitAura(unitName, GetSpellInfo(52610))
	if name then
		return duration, expirationTime
	else
		return nil, nil
	end
end

function SavageRoar.prototype:MyOnUpdate()
	SavageRoar.super.prototype.MyOnUpdate(self)
	if self.bUpdateSR then
		self:UpdateSavageRoar(nil, self.unit, true)
	end
	if self.target then
		self:UpdateDurationBar()
	end
end

function SavageRoar.prototype:UpdateSavageRoar(event, unit, fromUpdate)
	if unit and unit ~= self.unit then
		return
	end

	local now = GetTime()
	local remaining = nil

	if not fromUpdate then
		SRDuration, remaining = self:GetBuffDuration(self.unit)

		if not remaining then
			SREndTime = 0
		else
			SREndTime = remaining	-- + now
		end
	end

	if SREndTime and SREndTime >= now then
		if not fromUpdate then
			self.bUpdateSR = true
		end

		self:Toggle(true)
		if not remaining then
			remaining = SREndTime - now
		end
		local denominator = (self.moduleSettings.showAsPercentOfMax and CurrMaxSRDuration or SRDuration)
		self:UpdateBar(denominator ~= 0 and remaining / denominator or 0, "SavageRoar")

		formatString = self.moduleSettings.upperText or ''
	else
		self:UpdateBar(0, "SavageRoar")

		if (GetComboPoints(self.unit, "target") == 0) or not UnitExists("target") then
			if self.bIsVisible then
				self.bUpdateSR = nil
			end

			if not self.moduleSettings.alwaysFullAlpha then
				self:Show(false)
			end
		end
	end

	-- somewhat redundant, but we also need to check potential remaining time
	if (remaining ~= nil) or PotentialSRDuration > 0 then
		local potText = " (" .. PotentialSRDuration .. ")"
		self:SetBottomText1(self.moduleSettings.upperText .. " " .. tostring(floor(remaining or 0)) .. (self.moduleSettings.durationAlpha ~= 0 and potText or ""))
	end
end

function SavageRoar.prototype:UpdateDurationBar(event, unit)
	if unit and unit ~= self.unit then
		return
	end

	local points
	points = GetComboPoints(self.unit, "target")

	local scale

	-- first, set the cached upper limit of SR duration
	CurrMaxSRDuration = self:GetMaxBuffTime(maxComboPoints)

	if event then
		self:UpdateSavageRoar()
	end

	-- player doesn't want to show the percent of max or the alpha is zeroed out, so don't bother with the duration bar
	if not self.moduleSettings.showAsPercentOfMax or self.moduleSettings.durationAlpha == 0 or (points == 0 and not self:IsVisible()) then
		self.durationFrame:Hide()
		return
	end
	self.durationFrame:Show()

	-- if we have combo points and a target selected, go ahead and show the bar so the duration bar can be seen
	if points > 0 and UnitExists("target") then
		self:Toggle(true)
	end

	if self.moduleSettings.durationAlpha > 0 then
		PotentialSRDuration = self:GetMaxBuffTime(points)

		-- compute the scale from the current number of combo points
		scale = nibIceHUD:Clamp(PotentialSRDuration / CurrMaxSRDuration, 0, 1)

		-- sadly, animation uses bar-local variables so we can't use the animation for 2 bar textures on the same bar element
		if (self.moduleSettings.reverse) then
			scale = 1 - scale
		end

		self.durationFrame.bar:SetVertexColor(self:GetColor("SavageRoarPotential", self.moduleSettings.durationAlpha))
		self:SetBarCoord(self.durationFrame, scale)
	end

	if SREndTime < GetTime() then
		local potText = " (" .. PotentialSRDuration .. ")"
		self:SetBottomText1(self.moduleSettings.upperText .. " 0" .. (self.moduleSettings.durationAlpha > 0 and potText or ""))
	end
end

function SavageRoar.prototype:GetMaxBuffTime(numComboPoints)
	local maxduration

	if numComboPoints == 0 then
		return 0
	end

	maxduration = baseTime + ((numComboPoints - 1) * gapPerComboPoint)

	return maxduration
end

function SavageRoar.prototype:OutCombat()
	SavageRoar.super.prototype.OutCombat(self)

	self:UpdateSavageRoar()
end

local _, unitClass = UnitClass("player")

-- Load us up
if unitClass == "DRUID" then
	nibIceHUD.SavageRoar = SavageRoar:new()
end
