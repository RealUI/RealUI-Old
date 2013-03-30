-- needs to not be local so that we can inherit from it
TargetCC = IceCore_CreateClass(IceUnitBar)

local max = math.max
local ceil = math.ceil
local strform = string.format

TargetCC.prototype.debuffName = nil
TargetCC.prototype.debuffRemaining = 0
TargetCC.prototype.debuffDuration = 0

local AuraTexCoord = {0.1, 0.9, 0.1, 0.9}

local StunCCList = {
	-- kidney shot
	408,
	-- cheap shot
	1833,
	-- shadowfury
	30283,
	-- hammer of justice
	853,
	-- impact
	12355,
	-- blackout
	44415,
	-- intimidation
	19577,
	-- charge stun
	7922,
	-- concussion blow
	12809,
	-- bash
	5211,
	-- Maim
	22570,
	-- pounce
	9005,
	-- war stomp
	20549,
	-- deep freeze
	44572,
	-- shockwave
	46968,
	-- Gnaw
	47481,
    -- Fists of Fury
    113656,
}

local IncapacitateCCList = {
	-- Repentance
	20066,
	-- sap
	6770,
	-- gouge
	1776,
	-- blind
	2094,
	-- Wyvern Sting
	19386,
	-- Scatter Shot
	19503,
	-- Sleep
	700,
	-- Polymorph
	118,
	-- Polymorph: Pig
	28272,
	-- Polymorph: Turtle
	28271,
	-- Polymorph: Penguin
	59634,
	-- Hibernate
	2637,
	-- Freezing Trap Effect
	3355,
	-- Holy Word: Chastise
	88625,
	-- Banish
	710,
	-- Shackle Undead
	9484,
	-- Cyclone
	33786,
	-- Hungering Cold
	49203,
	-- Seduction
	6358,
	-- Turn Evil
	10326,
    -- Paralysis
    115078,
}

local FearCCList = {
	-- Psychic Scream
	8122,
	-- Fear
	5782,
	-- Howl of Terror
	5484,
	-- Death Coil
	6789,
	-- Intimidating Shout
	5246,
	-- Hex
	51514,
	-- Scare Beast
	1513,
}

local SilenceCCList = {
	-- Avenger's Shield with Daze  (unsure, need to test if this is needed with the Glyph, otherwise 31935 covers it)
	63529,
	-- Avenger's Shield without Daze glyph
	31935,
	-- Silence
	15487,
	-- Silencing Shot
	34490,
	-- Spell Lock
	19647,
	-- Gag Order
	18498,
	-- Arcane Torrent
	50613,
	-- Arcane Torrent
	28730,
	-- Arcane Torrent
	25046,
	-- Improved Kick
	18425,
	-- Improved Counterspell
	55021,
	-- Strangulate
	47476,
	-- Garotte - Silence
	1330,
	-- Disarm
	676,
	-- Dismantle
	51722,
	-- Psychic Horror
	64058,
	-- Elemental Disruption (weapon enchant)
	74208,
    -- Grapple Weapon
    117368,
}

local RootCCList = {
	-- -- Entangling Roots
	-- 339,
	-- -- Entangling Roots - Nature's Grasp
	-- 16689,
	-- -- Frost Nova
	-- 122,
	-- -- Earthbind Effect
	-- 64695,
	-- -- Shattered Barrier
	-- 55080,
	-- -- Imp Hamstring
	-- 23694,
	-- -- Freeze
	-- 33395,
	-- -- Entrapment 2 sec
	-- 19185,
	-- -- Entrapment 4 sec
	-- 64803,
	-- -- Web
	-- 4167,
	-- -- Pin
	-- 50245,
	-- -- Venom Web Spray
	-- 54706,
	-- -- Chains of Ice
	-- 45524,
}


-- Constructor --
function TargetCC.prototype:init(moduleName, unit)
	if moduleName == nil or unit == nil then
		TargetCC.super.prototype.init(self, "TargetCC", "target")
	else
		TargetCC.super.prototype.init(self, moduleName, unit)
	end

	self.moduleSettings = {}

	self:SetDefaultColor("CC:Stun", 0.85, 0.55, 0.2)
	self:SetDefaultColor("CC:Incapacitate", 0.90, 0.6, 0.2)
	self:SetDefaultColor("CC:Fear", 0.85, 0.2, 0.65)
	self:SetDefaultColor("CC:Silence", 1, 0.5, 0.04)
	self:SetDefaultColor("CC:Root", .1, 0.5, 1)

	self.debuffList = {}
	self:PopulateSpellList(self.debuffList, StunCCList, "Stun")
	self:PopulateSpellList(self.debuffList, IncapacitateCCList, "Incapacitate")
	self:PopulateSpellList(self.debuffList, FearCCList, "Fear")
	self:PopulateSpellList(self.debuffList, SilenceCCList, "Silence")
	self:PopulateSpellList(self.debuffList, RootCCList, "Root")

	self.previousDebuff = nil
	self.previousDebuffTarget = nil
	self.previousDebuffTime = nil
end

-- grabs the list of CC's and pulls the localized spell name using the wow api
function TargetCC.prototype:PopulateSpellList(debuffListVar, ccList, ccName)
	local spellName

	for i=1, #ccList do
		spellName = GetSpellInfo(ccList[i])

		if spellName and spellName ~= "" then
			debuffListVar[spellName] = ccName
		end
	end
end

-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function TargetCC.prototype:Enable(core)
	TargetCC.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_AURA", "UpdateTargetDebuffs")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateTargetDebuffs")

	if not self.moduleSettings.alwaysFullAlpha then
		self:Show(false)
	else
		self:UpdateTargetDebuffs()
	end

	self:SetBottomText1("")
	self:SetBottomText2("")
end

function TargetCC.prototype:Disable(core)
	TargetCC.super.prototype.Disable(self, core)
end

function TargetCC.prototype:TargetChanged()
	TargetCC.super.prototype.TargetChanged(self)
	self:UpdateTargetDebuffs(nil, "target", nil)
end

-- OVERRIDE
function TargetCC.prototype:GetDefaultSettings()
	local settings = TargetCC.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = false
	settings["lowThreshold"] = 0
	settings["side"] = IceCore.Side.Right
	settings["offset"] = 2
	settings["displayAuraIcon"] = false
	settings["auraIconXOffset"] = 0
	settings["auraIconYOffset"] = 0
	settings["auraIconSize"] = 27

	return settings
end

-- OVERRIDE
function TargetCC.prototype:GetOptions()
	local opts = TargetCC.super.prototype.GetOptions(self)

	opts["lowThresholdColor"] = nil
	opts["textSettings"].args["upperTextString"] = nil
	opts["textSettings"].args["lowerTextString"] = nil

	opts["iconSettings"] = {
		type = 'group',
		name = "|c"..self.configColor.."Icon Settings".."|r",
		args = {
			displayAuraIcon = {
				type = 'toggle',
				name = "Display aura icon",
				desc = "Whether or not to display an icon for the aura that this bar is tracking",
				get = function()
					return self.moduleSettings.displayAuraIcon
				end,
				set = function(info, v)
					self.moduleSettings.displayAuraIcon = v
					if self.barFrame.icon then
						if v then
							self.barFrame.icon:Show()
						else
							self.barFrame.icon:Hide()
						end
					end
				end,
				disabled = function()
					return not self.moduleSettings.enabled
				end,
				order = 51,
			},

			auraIconXOffset = {
				type = 'range',
				min = -250,
				max = 250,
				step = 0.5,
				name = "Aura icon horizontal offset",
				desc = "Adjust the horizontal position of the aura icon",
				get = function()
					return self.moduleSettings.auraIconXOffset
				end,
				set = function(info, v)
					self.moduleSettings.auraIconXOffset = v
					self:PositionIcons()
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.displayAuraIcon
				end,
				order = 52,
			},

			auraIconYOffset = {
				type = 'range',
				min = -250,
				max = 250,
				step = 0.5,
				name = "Aura icon vertical offset",
				desc = "Adjust the vertical position of the aura icon",
				get = function()
					return self.moduleSettings.auraIconYOffset
				end,
				set = function(info, v)
					self.moduleSettings.auraIconYOffset = v
					self:PositionIcons()
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.displayAuraIcon
				end,
				order = 53,
			},

			auraIconSize = {
				type = 'range',
				min = 16,
				max = 32,
				step = 1,
				name = "Aura icon size",
				desc = "Adjusts the size of the aura icon for this bar",
				get = function()
					return self.moduleSettings.auraIconSize
				end,
				set = function(info, v)
					self.moduleSettings.auraIconSize = v
					self:PositionIcons()
				end,
				disabled = function()
					return not self.moduleSettings.enabled or not self.moduleSettings.displayAuraIcon
				end,
				order = 54,
			},
		},
	}

	return opts
end

-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function TargetCC.prototype:CreateFrame()
	TargetCC.super.prototype.CreateFrame(self)

	local layout = RealUI.db.char.resolution
	self.frame.bottomUpperText:SetWidth(self.settings["gap"..layout] + 30)
	
	if not self.barFrame.icon then
		self.barFrame.icon = self.frame:CreateTexture(nil, "OVERLAY")
		self.barFrame.icon:SetTexture("Interface\\Icons\\Spell_Frost_Frost")
		self.barFrame.icon:SetTexCoord(unpack(AuraTexCoord))
		
		self.barFrame.iconborder = CreateFrame("Frame", nil, self.frame)
	end
	self:PositionIcons()
	
	self.barFrame.icon:Hide()
	self.barFrame.iconborder:Hide()
end

function TargetCC.prototype:PositionIcons()
	if not self.barFrame or not self.barFrame.icon then
		return
	end
	
	if not self.moduleSettings.auraIconSize then self.moduleSettings.auraIconSize = 27 end
	local scaleSize = (1 / self.moduleSettings.scale)
	local size = self.moduleSettings.auraIconSize * scaleSize
	local posX = self.moduleSettings.auraIconXOffset * scaleSize
	local posY = self.moduleSettings.auraIconYOffset * scaleSize
	
	self.barFrame.icon:ClearAllPoints()
	self.barFrame.icon:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", posX, posY)
	self.barFrame.icon:SetWidth(size)
	self.barFrame.icon:SetHeight(size)
	
	self.barFrame.iconborder:ClearAllPoints()
	self.barFrame.iconborder:SetFrameStrata(self.frame:GetFrameStrata())
	self.barFrame.iconborder:SetFrameLevel(self.frame:GetFrameLevel() + 2)
	self.barFrame.iconborder:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", posX, posY)
	self.barFrame.iconborder:SetWidth(size)
	self.barFrame.iconborder:SetHeight(size)
	
	self.barFrame.iconborder:SetBackdrop({
		bgFile = [[Interface\AddOns\nibIceHUD\textures\Plain]], 
		edgeFile = [[Interface\AddOns\nibIceHUD\textures\Plain]], 
		tile = false, tileSize = 0, edgeSize = scaleSize, 
		insets = { left = scaleSize, right = scaleSize, top = scaleSize, bottom = scaleSize	}
	})
	self.barFrame.iconborder:SetBackdropColor(0, 0, 0, 0)
	self.barFrame.iconborder:SetBackdropBorderColor(0, 0, 0, 1)
end

function TargetCC.prototype:GetMaxDebuffDuration(unitName, debuffNames, oldIcon)
	local i = 1
	local debuff, rank, texture, count, debuffType, duration, endTime = UnitAura(unitName, i, "HARMFUL")
	local result = {nil, nil, nil, nil}
	local remaining

	while debuff do
		remaining = endTime - GetTime()
		
		if (duration == 0) and (remaining < 0) then
			duration = 100000
			remaining = 100000
		end
		
		if debuffNames[debuff] then
			if result[0] then
				if result[2] < remaining then
					result = {debuff, duration, remaining, texture or oldIcon}
				end
			else
				result = {debuff, duration, remaining, texture or oldIcon}
			end
		end

		i = i + 1

		debuff, rank, texture, count, debuffType, duration, endTime = UnitAura(unitName, i, "HARMFUL")
	end

	return unpack(result)
end

local name, duration, remaining, icon
function TargetCC.prototype:UpdateTargetDebuffs(event, unit, isUpdate)
	if unit and (unit ~= self.unit) then return end
	
	if not isUpdate then
		self.debuffName, self.debuffDuration, self.debuffRemaining, self.buffIcon = self:GetMaxDebuffDuration(self.unit, self.debuffList, self.buffIcon)
	else
		self.debuffRemaining = max(0, self.debuffRemaining - (GetTime() - self.lastUpdateTime))
		if self.debuffRemaining <= 0 then
			self.debuffName = nil
		end
	end
	self.lastUpdateTime = GetTime()

	name = self.debuffName
	duration = self.debuffDuration
	remaining = self.debuffRemaining
	icon = self.buffIcon

	local targetName = UnitName(self.unit)
	
	if (name ~= nil) then
		if not isUpdate then
			if not nibIceHUD.IceCore:IsUpdateSubscribed(self) then
				if not self.UpdateCustomBarFunc then
					self.UpdateCustomBarFunc = function() self:UpdateTargetDebuffs(nil, self.unit, true) end
				end
				nibIceHUD.IceCore:RequestUpdates(self, self.UpdateCustomBarFunc)
			end
			
			self.barFrame.icon:SetTexture(icon or "")
			self:Toggle(true)
		end
		
		if (duration ~= nil and duration > 0) then
			self:UpdateBar(duration ~= 0 and remaining / duration or 0, "CC:" .. self.debuffList[name])
			self:SetBottomText2(strform("%.1f", remaining))
		else
			self:UpdateBar(0, "CC:" .. self.debuffList[name])
			self:SetBottomText2("")
		end

		self:SetBottomText1(name)
		
		-- In case we haven't yet subscribed (bug)
		if not nibIceHUD.IceCore:IsUpdateSubscribed(self) then
			if self.UpdateCustomBarFunc ~= nil then
				nibIceHUD.IceCore:RequestUpdates(self, self.UpdateCustomBarFunc)
			end
		end
	else
		self:UpdateBar(0, "CC:")
		self:Toggle(false)
		nibIceHUD.IceCore:RequestUpdates(self, nil)
	end
end

function TargetCC.prototype:Toggle(vis)
	if vis then
		self:Show(true)
		if nibIceHUD.IceCore:IsInConfigMode() or self.moduleSettings.displayAuraIcon then
			self.barFrame.icon:Show()
			self.barFrame.iconborder:Show()
		end
	else
		self:Show(false)
		self.barFrame.icon:Hide()
		self.barFrame.iconborder:Hide()
	end
end

-- Load us up
nibIceHUD.TargetCC = TargetCC:new()
