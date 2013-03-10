local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local ShroomBar = IceCore_CreateClass(IceUnitBar)

local nibIceHUD = _G.nibIceHUD

ShroomBar.prototype.barUpdateColor = "WildMushrooms"

local tostring = tostring
local floor = math.floor

local ShroomID = 88747	-- Wild Mushrooms
local ShroomName = ""
local BloomID = 102791	-- Wild Mushrooms: Bloom
local RejuvID = 774		-- Rejuvenation
local MaxHealthPercent = 0.33
local OverHealPercent = 0.25
local MaxNumShrooms = 3
local MinLevel = 84

function ShroomBar.prototype:init()
	ShroomBar.super.prototype.init(self, "WildMushrooms", "player")

	self:SetDefaultColor("WildMushrooms", 255, 200, 65)
	self.bTreatEmptyAsFull = false
	self.CurrentOverheal = 0
	self.MaxOverheal = 0
	self.BloomPercent = 0
	self.CurrentNumShrooms = 0
	self.AreShroomsDown = false
end

function ShroomBar.prototype:Redraw()
	ShroomBar.super.prototype.Redraw(self)
	self:MyOnUpdate()
end

function ShroomBar.prototype:GetOptions()
	local opts = ShroomBar.super.prototype.GetOptions(self)
	opts.reverse.hidden = true
	return opts
end

function ShroomBar.prototype:GetDefaultSettings()
	local defaults =  ShroomBar.super.prototype.GetDefaultSettings(self)

	defaults.textVisible.lower = false
	defaults.offset = 2
	defaults.enabled = true
	defaults.textVerticalOffset = 0
	defaults.textHorizontalOffset = 0
	defaults.lockUpperTextAlpha = true
	defaults.bHideMarkerSettings = true
	defaults.showAsPercentOfMax = true
	defaults.bAllowExpand = false
	defaults.upperText = "WM"

	return defaults
end

function ShroomBar.prototype:Enable(core)
	ShroomBar.super.prototype.Enable(self, core)

	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	
	ShroomName = GetSpellInfo(ShroomID)

	self:UpdateShown()
end

function ShroomBar.prototype:Disable(core)
	ShroomBar.super.prototype.Disable(self, core)
end

function ShroomBar.prototype:CreateFrame()
	ShroomBar.super.prototype.CreateFrame(self)

	self:UpdateShown()
	self:UpdateAlpha()
end

local function ReadableNumber(num, places)
    local ret
    local placeValue = ("%%.%df"):format(places or 0)
    if not num then
        return 0
    elseif num >= 1000000 then
        ret = placeValue:format(num / 1000000) .. "M" -- million
    elseif num >= 1000 then
        ret = placeValue:format(num / 1000) .. "k" -- thousand
    else
        ret = num -- hundreds
    end
    return ret
end

function ShroomBar.prototype:UpdateShown()
	if ( (GetSpecialization() == 4) and not(UnitInVehicle("player")) and (UnitLevel("player") >= MinLevel) and (self.CurrentOverheal > 0) and (self.CurrentNumShrooms > 0) ) then
		self:Show(true)
	else
		self:Show(false)
	end
end

function ShroomBar.prototype:PLAYER_ENTERING_WORLD()
	self.guid = UnitGUID("player");
	self:UpdateShroomBar()
end

function ShroomBar.prototype:ACTIVE_TALENT_GROUP_CHANGED()
	self:UpdateShroomBar()
end

function ShroomBar.prototype:UNIT_SPELLCAST_SUCCEEDED(_, unitID, spellName, spellRank, lineID, spellID)
	if ( unitID == "player" ) then
		if ( spellID == ShroomID ) then -- Wild Mushroom
			self.MaxOverheal = UnitHealthMax("player") * MaxHealthPercent
			self.AreShroomsDown = true
			if ( self.CurrentNumShrooms < MaxNumShrooms ) then
				self.CurrentNumShrooms = self.CurrentNumShrooms + 1
			end
			self.CurrentOverheal = 0
			self:UpdateShroomBar()
		
		elseif ( spellID == BloomID) then --Wild Mushroom: Bloom
			self.AreShroomsDown = false
			self.CurrentNumShrooms = 0
			self.CurrentOverheal = 0
			self:UpdateShroomBar()
		end
	end
end

function ShroomBar.prototype:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, ...)
	if ( sourceGUID == self.guid ) then
		if ( event == "SPELL_PERIODIC_HEAL" ) then
			local spellID, spellName, spellSchool, amount, overhealing, absorbed, critical = select(1, ...)
			if ( spellID == RejuvID and self.AreShroomsDown) then -- Rejuvenation
				if ( self.CurrentOverheal < self.MaxOverheal ) then
					self.CurrentOverheal = self.CurrentOverheal + (overhealing * OverHealPercent)
					if ( self.CurrentOverheal >= self.MaxOverheal ) then 
						self.CurrentOverheal = self.MaxOverheal
					end
					self.BloomPercent = (self.CurrentOverheal / self.MaxOverheal) * 100
					self:UpdateShroomBar()
				end
			end
		end
	end
end

function ShroomBar.prototype:UpdateShroomBar()
	if (self.CurrentOverheal > 0) then
		local denominator = (self.moduleSettings.showAsPercentOfMax and self.MaxOverheal or self.CurrentOverheal)
		self:UpdateBar(denominator ~= 0 and self.CurrentOverheal / denominator or 0, "WildMushrooms")
		self:SetBottomText1(self.moduleSettings.upperText .. " " .. ReadableNumber(self.CurrentOverheal))
		self:UpdateShown()
	else
		self:UpdateBar(0, "WildMushrooms")
		self:SetBottomText1("")
		self:Show(false)
	end
end

local _, unitClass = UnitClass("player")
if unitClass == "DRUID" then
	nibIceHUD.ShroomBar = ShroomBar:new()
end
