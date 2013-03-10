local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local StaggerBar = IceCore_CreateClass(IceUnitBar)

local nibIceHUD = _G.nibIceHUD

StaggerBar.prototype.barUpdateColor = "Stagger"

local tostring = tostring
local floor = math.floor
local min = math.min

local playerName = ""
local LightID = 124275
local ModerateID = 124274
local HeavyID = 124273
local StaggerID = 124255

local MinLevel = 10

function StaggerBar.prototype:init()
	StaggerBar.super.prototype.init(self, "Stagger", "player")

	self:SetDefaultColor("Stagger", 220, 200, 30)
	self.bTreatEmptyAsFull = false
end

function StaggerBar.prototype:Redraw()
	StaggerBar.super.prototype.Redraw(self)
	self:MyOnUpdate()
end

function StaggerBar.prototype:GetOptions()
	local opts = StaggerBar.super.prototype.GetOptions(self)
	opts.reverse.hidden = true
	return opts
end

function StaggerBar.prototype:GetDefaultSettings()
	local defaults =  StaggerBar.super.prototype.GetDefaultSettings(self)

	defaults.textVisible.lower = false
	defaults.offset = 2
	defaults.enabled = true
	defaults.textVerticalOffset = 0
	defaults.textHorizontalOffset = 0
	defaults.lockUpperTextAlpha = true
	defaults.bHideMarkerSettings = true
	defaults.showAsPercentOfMax = true
	defaults.bAllowExpand = false
	defaults.upperText = "St"

	return defaults
end

function StaggerBar.prototype:Enable(core)
	StaggerBar.super.prototype.Enable(self, core)

	playerName = UnitName("player")
	
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")

	self:UpdateShown()
end

function StaggerBar.prototype:Disable(core)
	StaggerBar.super.prototype.Disable(self, core)
end

function StaggerBar.prototype:CreateFrame()
	StaggerBar.super.prototype.CreateFrame(self)

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

function StaggerBar.prototype:UpdateShown()
	if ( (GetSpecialization() == 1) and not(UnitInVehicle("player")) and (UnitLevel("player") >= MinLevel) ) then
		self:Show(true)
	else
		self:Show(false)
	end
end

function StaggerBar.prototype:PLAYER_ENTERING_WORLD()
	self.guid = UnitGUID("player");
	self:UpdateStaggerBar()
end

function StaggerBar.prototype:ACTIVE_TALENT_GROUP_CHANGED()
	self:UpdateStaggerBar()
end

function StaggerBar.prototype:GetDebuffInfo()
	local amount = 0
	local duration = 0
	for i = 1, 40 do
		local debuffID = select(11, UnitDebuff(playerName, i))
		if debuffID == LightID or debuffID == ModerateID or debuffID == HeavyID then
			local spellName = select(1, UnitDebuff(playerName, i))
			duration = select(6, UnitAura(playerName, spellName, "", "HARMFUL"))
			amount = select(15, UnitAura(playerName, spellName, "", "HARMFUL"))
			break
		end
	end
	self.amount = amount or 0
	self.duration = duration or 0
end

function StaggerBar.prototype:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, spellID)
	if destName == playerName then
		if event == "SPELL_PERIODIC_DAMAGE" and spellID == StaggerID then
			self:UpdateStaggerBar()
		elseif event == "SWING_DAMAGE" then
			self:UpdateStaggerBar()
		elseif event == "SPELL_AURA_APPLIED" then
			self:UpdateStaggerBar()
		elseif event == "SPELL_AURA_REMOVED" then
			self:UpdateStaggerBar()
		end
	end
end

function StaggerBar.prototype:UpdateStaggerBar()
	self:GetDebuffInfo()
	
	local health = UnitHealth("player")
	local maxHealth = UnitHealthMax("player")
	local percent = min(self.amount / maxHealth * 100, 100)
	-- if Compounded
		-- if Current Health
			-- percent = math.min((amount * duration) / health * 100, 100);
		-- else
			-- percent = math.min((amount * duration) / maxHealth * 100, 100);
		-- end
	-- else
		-- if Current Health
			-- percent = math.min(amount / health * 100, 100);
		-- else
			-- percent = math.min(amount / maxHealth * 100, 100);
		-- end
	-- end
	
	if self.amount > 0 and self.duration <= 10 then
		self:UpdateBar(percent or 0, "Stagger")
		self:SetBottomText1(self.moduleSettings.upperText .. " " .. tostring(floor(percent * 100)) .. "%")
		self:UpdateShown()
	else
		self:UpdateBar(0, "Stagger")
		self:SetBottomText1("")
		self:Show(false)
	end
end

local _, unitClass = UnitClass("player")
if unitClass == "MONK" then
	nibIceHUD.StaggerBar = StaggerBar:new()
end
