local SliceAndDice = IceCore_CreateClass(IceUnitBar)

local nibIceHUD = _G.nibIceHUD

local GlyphSpellId = 56810

local baseTime = 12
local gapPerComboPoint = 6
local maxComboPoints = 5
local sndEndTime = 0
local sndDuration = 0

local CurrMaxSnDDuration = 0
local PotentialSnDDuration = 0

-- Constructor --
function SliceAndDice.prototype:init()
	SliceAndDice.super.prototype.init(self, "SliceAndDice", "player")

	self.moduleSettings = {}

	self:SetDefaultColor("SliceAndDice", 0.75, 1, 0.2)
	self:SetDefaultColor("SliceAndDicePotential", 1, 1, 1)

	self.bTreatEmptyAsFull = true
end

-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function SliceAndDice.prototype:Enable(core)
	SliceAndDice.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_AURA", "UpdateSliceAndDice")
	self:RegisterEvent("UNIT_COMBO_POINTS", "UpdateDurationBar")

	if not self.moduleSettings.alwaysFullAlpha then
		self:Show(false)
	else
		self:UpdateSliceAndDice()
	end

	self:SetBottomText1("")
end

function SliceAndDice.prototype:Toggle(vis)
	if ( vis and (UnitLevel("player") > 14) ) then
		self:Show(true)
	else
		self:Show(false)
	end
end

function SliceAndDice.prototype:TargetChanged()
	SliceAndDice.super.prototype.TargetChanged(self)
	self:UpdateDurationBar()
	self:UpdateSliceAndDice()
end

function SliceAndDice.prototype:Disable(core)
	SliceAndDice.super.prototype.Disable(self, core)
end

-- OVERRIDE
function SliceAndDice.prototype:GetDefaultSettings()
	local settings = SliceAndDice.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = true
	settings["lowThreshold"] = 0
	settings["side"] = IceCore.Side.Right
	settings["offset"] = 6
	settings["upperText"]="SnD"
	settings["showAsPercentOfMax"] = true
	settings["durationAlpha"] = 0.6
	settings["lockLowerFontAlpha"] = false
	settings["lowerTextString"] = ""
	settings["lowerTextVisible"] = false

	return settings
end

-- OVERRIDE
function SliceAndDice.prototype:GetOptions()
	local opts = SliceAndDice.super.prototype.GetOptions(self)

	opts["textSettings"].args["upperTextString"]["desc"] = "The text to display under this bar. # will be replaced with the number of Slice and Dice seconds remaining."
	opts["textSettings"].args["upperTextString"].hidden = false

	opts["showAsPercentOfMax"] =
	{
		type = 'toggle',
		name = "Show bar as % of maximum",
		desc = "If this is checked, then the SnD buff time shows as a percent of the maximum attainable (taking set bonuses and talents into account). Otherwise, the bar always goes from full to empty when applying SnD no matter the duration.",
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
		name = "Potential SnD time bar alpha",
		desc = "What alpha value to use for the bar that displays how long your SnD will last if you activate it. (This gets multiplied by the bar's current alpha to stay in line with the bar on top of it)",
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

function SliceAndDice.prototype:CreateFrame()
	SliceAndDice.super.prototype.CreateFrame(self)

	self:CreateDurationBar()
end

function SliceAndDice.prototype:CreateDurationBar()
	self.durationFrame = self:BarFactory(self.durationFrame, "BACKGROUND","ARTWORK")

	-- Rokiyo: Do we need to call this here?
	self.CurrScale = 0

	self.durationFrame.bar:SetVertexColor(self:GetColor("SliceAndDicePotential", self.moduleSettings.durationAlpha))
	self.durationFrame.bar:SetHeight(0)

	self:UpdateBar(1, "undef")

	-- force update the bar...if we're in here, then either the UI was just loaded or the player is jacking with the options.
	-- either way, make sure the duration bar matches accordingly
	self:UpdateDurationBar()
end

-- 'Protected' methods --------------------------------------------------------

function SliceAndDice.prototype:GetBuffDuration(unitName, buffName)
	local i = 1
	local buff, rank, texture, count, type, duration, endTime, remaining
	buff, rank, texture, count, type, duration, endTime = UnitBuff(unitName, i)

	while buff do
		if (texture and string.match(texture, buffName)) then
			if endTime and not remaining then
				remaining = endTime - GetTime()
			end
			return duration, remaining
		end

		i = i + 1;

		buff, rank, texture, count, type, duration, endTime = UnitBuff(unitName, i)
	end

	return nil, nil
end

function SliceAndDice.prototype:MyOnUpdate()
	SliceAndDice.super.prototype.MyOnUpdate(self)
	if self.bUpdateSnd then
		self:UpdateSliceAndDice(nil, self.unit, true)
	end
	if self.target then
		self:UpdateDurationBar()
	end
end

function SliceAndDice.prototype:UpdateSliceAndDice(event, unit, fromUpdate)
	if unit and unit ~= self.unit then
		return
	end

	local now = GetTime()
	local remaining = nil

	if not fromUpdate then
		sndDuration, remaining = self:GetBuffDuration(self.unit, "Ability_Rogue_SliceDice")

		if not remaining then
			sndEndTime = 0
		else
			sndEndTime = remaining + now
		end
	end

	if sndEndTime and sndEndTime >= now then
		if not fromUpdate then
			self.bUpdateSnd = true
		end

		self:Toggle(true)
		if not remaining then
			remaining = sndEndTime - now
		end
		local denominator = (self.moduleSettings.showAsPercentOfMax and CurrMaxSnDDuration or sndDuration)
		self:UpdateBar(denominator ~= 0 and remaining / denominator or 0, "SliceAndDice")

		formatString = self.moduleSettings.upperText or ''
	else
		self:UpdateBar(0, "SliceAndDice")

		if (GetComboPoints(self.unit, "target") == 0) or not UnitExists("target") then
			if self.bIsVisible then
				self.bUpdateSnd = nil
			end

			if not self.moduleSettings.alwaysFullAlpha then
				self:Show(false)
			end
		end
	end

	-- somewhat redundant, but we also need to check potential remaining time
	if (remaining ~= nil) or PotentialSnDDuration > 0 then
		local potText = " (" .. PotentialSnDDuration .. ")"
		self:SetBottomText1(self.moduleSettings.upperText .. " " .. tostring(floor(remaining or 0)) .. (self.moduleSettings.durationAlpha ~= 0 and potText or ""))
	end
end

function SliceAndDice.prototype:UpdateDurationBar(event, unit)
	if unit and unit ~= self.unit then
		return
	end

	local points
	points = GetComboPoints(self.unit, "target")
	
	local scale

	-- first, set the cached upper limit of SnD duration
	CurrMaxSnDDuration = self:GetMaxBuffTime(maxComboPoints)

	if event then
		self:UpdateSliceAndDice()
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
		PotentialSnDDuration = self:GetMaxBuffTime(points)

		-- compute the scale from the current number of combo points
		scale = nibIceHUD:Clamp(PotentialSnDDuration / CurrMaxSnDDuration, 0, 1)

		-- sadly, animation uses bar-local variables so we can't use the animation for 2 bar textures on the same bar element
		if (self.moduleSettings.reverse) then
			scale = 1 - scale
		end

		self.durationFrame.bar:SetVertexColor(self:GetColor("SliceAndDicePotential", self.moduleSettings.durationAlpha))
		self:SetBarCoord(self.durationFrame, scale)
	end

	if sndEndTime < GetTime() then
		local potText = " (" .. PotentialSnDDuration .. ")"
		self:SetBottomText1(self.moduleSettings.upperText .. " 0" .. (self.moduleSettings.durationAlpha ~= 0 and potText or ""))
	end
end

function SliceAndDice.prototype:GetMaxBuffTime(numComboPoints)
	local maxduration

	if numComboPoints == 0 then
		return 0
	end

	maxduration = baseTime + ((numComboPoints - 1) * gapPerComboPoint)

	return maxduration
end

function SliceAndDice.prototype:OutCombat()
	SliceAndDice.super.prototype.OutCombat(self)

	self:UpdateSliceAndDice()
end

local _, unitClass = UnitClass("player")

-- Load us up
if unitClass == "ROGUE" then
	nibIceHUD.SliceAndDice = SliceAndDice:new()
end
