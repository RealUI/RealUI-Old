local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local BurningEmbersBar = IceCore_CreateClass(IceUnitBar)
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local nibIceHUD = _G.nibIceHUD

function BurningEmbersBar.prototype:init()
	BurningEmbersBar.super.prototype.init(self, "BurningEmbersBar", "player")

	self:SetDefaultColor("BurningEmbers", 233, 43, 12)
	self.bTreatEmptyAsFull = false
	self.power = 0
	self.maxPower = 0
	self.powerPercent = 0
	self.powerIndex = SPELL_POWER_BURNING_EMBERS
	self.powerName = "BURNING_EMBERS"
end

function BurningEmbersBar.prototype:Redraw()
	BurningEmbersBar.super.prototype.Redraw(self)
	self:MyOnUpdate()
end

function BurningEmbersBar.prototype:GetOptions()
	local opts = BurningEmbersBar.super.prototype.GetOptions(self)
	opts.reverse.hidden = true
	return opts
end

function BurningEmbersBar.prototype:GetDefaultSettings()
	local defaults =  BurningEmbersBar.super.prototype.GetDefaultSettings(self)

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
	defaults.bAllowExpand = false

	return defaults
end

function BurningEmbersBar.prototype:Enable(core)
	BurningEmbersBar.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_POWER", "UpdateBurningEmbers")
	self:RegisterEvent("UNIT_MAXPOWER", "UpdateBurningEmbers")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "UpdateShown")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateShown")

	self:UpdateShown()
end

function BurningEmbersBar.prototype:Disable(core)
	BurningEmbersBar.super.prototype.Disable(self, core)
end

function BurningEmbersBar.prototype:CreateFrame()
	BurningEmbersBar.super.prototype.CreateFrame(self)

	self:UpdateShown()
	self:UpdateAlpha()
end

function BurningEmbersBar.prototype:UpdateShown()
	if ( (GetSpecialization() == 3) and UnitExists("target") and UnitCanAttack("player", "target") and not(UnitIsDeadOrGhost("target")) and not(UnitInVehicle("player")) ) then
		self:Show(true)
	else
		self:Show(false)
	end
end

function BurningEmbersBar.prototype:UseTargetAlpha(scale)
	return UnitPower("player", SPELL_POWER_BURNING_EMBERS) ~= 0 and self.combat
end

function BurningEmbersBar.prototype:UpdateBurningEmbers()
	self.power = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true)
	self.maxPower = UnitPowerMax("player", SPELL_POWER_BURNING_EMBERS, true)
	local numEmbers = floor(self.power / MAX_POWER_PER_EMBER);

	if ( self.power >= MAX_POWER_PER_EMBER ) then
		self.power = mod(self.power, MAX_POWER_PER_EMBER)-- * numEmbers);
	end

	if self.power > 0 then
		self.powerPercent = self.power / MAX_POWER_PER_EMBER
	else
		self.powerPercent = 0
	end
	
	self:UpdateBar(self.powerPercent, "BurningEmbers")--, 1)
end

function BurningEmbersBar.prototype:MyOnUpdate()
	self:Update()

	self:UpdateBurningEmbers()
	--self:UpdateBar(0.5, self.SetDefaultColor)
	self:UpdateAlpha()
end

local _, unitClass = UnitClass("player")
if unitClass == "WARLOCK" then
	nibIceHUD.BurningEmbersBar = BurningEmbersBar:new()
end
