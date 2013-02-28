local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
TargetInvuln = IceCore_CreateClass(IceUnitBar)

local max = math.max
local strform = string.format

TargetInvuln.prototype.buffName = nil
TargetInvuln.prototype.buffRemaining = 0
TargetInvuln.prototype.buffDuration = 0

local AuraTexCoord = {0.1, 0.9, 0.1, 0.9}

local GetNumPartyMembers, GetNumRaidMembers = GetNumGroupMembers, GetNumGroupMembers

local InvulnList= {
	-- Anti-Magic Shell
	48707,
	-- Hand of Protection
	10278,
	-- Divine Shield
	642,
	-- Deterrence
	19263,
	-- Spell Reflection
	23920,
	-- Ice Block
	45438,
	-- Pain Suppression
	33206,
	-- Cloak of Shadows
	31224,
	-- Hand of Freedom
	1044,
	-- Dispersion
	47585,
	-- Bladestorm
	46924,
	-- Grounding Totem Effect
	8178,
	-- Aura Mastery
	31821,
	-- Lichborne
	49039,
	-- Killing Spree
	51690,
}

-- Constructor --
function TargetInvuln.prototype:init(moduleName, unit)
	if moduleName == nil or unit == nil then
		TargetInvuln.super.prototype.init(self, "TargetInvuln", "target")
	else
		TargetInvuln.super.prototype.init(self, moduleName, unit)
	end

	self.moduleSettings = {}
	self:SetDefaultColor("CC:Invuln", 0.99, 0.99, 0.99)

	self.buffList = {}
	self:PopulateSpellList(self.buffList, InvulnList, "Invuln")

	self.previousbuff = nil
	self.previousbuffTarget = nil
	self.previousbuffTime = nil
end

-- grabs the list of CC's and pulls the localized spell name using the wow api
function TargetInvuln.prototype:PopulateSpellList(buffListVar, ccList, ccName)
	local spellName

	for i = 1, #ccList do
		spellName = GetSpellInfo(ccList[i])

		if spellName and spellName ~= "" then
			buffListVar[spellName] = ccName
		end
	end
end

-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function TargetInvuln.prototype:Enable(core)
	TargetInvuln.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_AURA", "UpdateTargetBuffs")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateTargetBuffs")

	if not self.moduleSettings.alwaysFullAlpha then
		self:Show(false)
	else
		self:UpdateTargetBuffs()
	end

	self:SetBottomText1("")
	self:SetBottomText2("")
end

function TargetInvuln.prototype:Disable(core)
	TargetInvuln.super.prototype.Disable(self, core)
end

function TargetInvuln.prototype:TargetChanged()
	TargetInvuln.super.prototype.TargetChanged(self)
	self:UpdateTargetBuffs(nil, "target", nil)
end

-- OVERRIDE
function TargetInvuln.prototype:GetDefaultSettings()
	local settings = TargetInvuln.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = false
	settings["lowThreshold"] = 0
	settings["side"] = IceCore.Side.Right
	settings["offset"] = 3
	settings["displayAuraIcon"] = false
	settings["auraIconXOffset"] = 0
	settings["auraIconYOffset"] = 0
	settings["auraIconSize"] = 27

	return settings
end

-- OVERRIDE
function TargetInvuln.prototype:GetOptions()
	local opts = TargetInvuln.super.prototype.GetOptions(self)

	opts["lowThreshold"] = nil
	opts["textSettings"].args["upperTextString"] = nil
	opts["textSettings"].args["lowerTextString"] = nil
	
	opts["iconSettings"] = {
		type = 'group',
		name = "|c"..self.configColor..L["Icon Settings"].."|r",
		args = {
			displayAuraIcon = {
				type = 'toggle',
				name = L["Display aura icon"],
				desc = L["Whether or not to display an icon for the aura that this bar is tracking"],
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
				name = L["Aura icon horizontal offset"],
				desc = L["Adjust the horizontal position of the aura icon"],
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
				name = L["Aura icon vertical offset"],
				desc = L["Adjust the vertical position of the aura icon"],
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
				desc = L["Adjusts the size of the aura icon for this bar"],
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

function TargetInvuln.prototype:CreateFrame()
	TargetInvuln.super.prototype.CreateFrame(self)
end

-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function TargetInvuln.prototype:CreateFrame()
	TargetInvuln.super.prototype.CreateFrame(self)

	self.frame.bottomUpperText:SetWidth(self.settings.gap + 30)
	
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

function TargetInvuln.prototype:PositionIcons()
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

function TargetInvuln.prototype:GetMaxbuffDuration(unitName, buffNames, oldIcon)
	local i = 1
	local buff, rank, texture, count, buffType, duration, endTime, unitCaster = UnitAura(unitName, i, "HELPFUL")
	local result = {nil, nil, nil, nil}
	local remaining

	while buff do
		remaining = endTime - GetTime()

		if (duration == 0) and (remaining < 0) then
			duration = 100000
			remaining = 100000
		end

		if buffNames[buff] then
			if result[0] then
				if result[2] <= remaining then
					result = {buff, duration, remaining, texture or oldIcon}
				end
			else
				result = {buff, duration, remaining, texture or oldIcon}
			end
		end

		i = i + 1

		buff, rank, texture, count, buffType, duration, endTime, unitCaster = UnitAura(unitName, i, "HELPFUL")
	end

	return unpack(result)
end

function TargetInvuln.prototype:UpdateTargetBuffs(event, unit, isUpdate)
	if unit and (unit ~= self.unit) then return end
	
	local name, duration, remaining, icon

	if not isUpdate then
		self.buffName, self.buffDuration, self.buffRemaining, self.buffIcon = self:GetMaxbuffDuration(self.unit, self.buffList, self.buffTexture)
	else
		self.buffRemaining = max(0, self.buffRemaining - (GetTime() - self.lastUpdateTime))
		if self.buffRemaining <= 0 then
			self.buffName = nil
		end
	end
	self.lastUpdateTime = GetTime()

	name = self.buffName
	duration = self.buffDuration
	remaining = self.buffRemaining
	icon = self.buffIcon

	local targetName = UnitName(self.unit)

	if (name ~= nil) then
		if not isUpdate then
			if not nibIceHUD.IceCore:IsUpdateSubscribed(self) then
				if not self.UpdateCustomBarFunc then
					self.UpdateCustomBarFunc = function() self:UpdateTargetBuffs(nil, self.unit, true) end
				end
				nibIceHUD.IceCore:RequestUpdates(self, self.UpdateCustomBarFunc)
			end
			
			self.barFrame.icon:SetTexture(icon or "")
			self:Toggle(true)
		end

		if (duration ~= nil and duration >= 0) then
			self:UpdateBar(duration ~= 0 and remaining / duration or 0, "CC:" .. self.buffList[name])
			self:SetBottomText2(strform("%d", ceil(remaining)))
		else
			self:UpdateBar(0, "CC:" .. self.buffList[name])
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

function TargetInvuln.prototype:Toggle(vis)
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
nibIceHUD.TargetInvuln = TargetInvuln:new()
