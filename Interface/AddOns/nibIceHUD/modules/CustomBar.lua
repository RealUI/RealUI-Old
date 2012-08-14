local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
IceCustomBar = IceCore_CreateClass(IceUnitBar)

local nibIceHUD = _G.nibIceHUD

local floor = _G.floor
local ceil = _G.ceil
local strform = _G.string.format
local tostring = _G.tostring
local GetTime = _G.GetTime

local validUnits = {"player", "target", "focus", "pet", "vehicle", "targettarget", "main hand weapon", "off hand weapon"}
local buffOrDebuff = {"buff", "debuff"}
local customClassSelect = {"ALL", "DEATHKNIGHT", "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR"}
local validBuffTimers = {"none", "seconds", "minutes:seconds", "minutes"}

local _, uClass = UnitClass("player")

IceCustomBar.prototype.auraDuration = -1
IceCustomBar.prototype.auraEndTime = -1
IceCustomBar.prototype.bIsAura = false

-- Constructor --
function IceCustomBar.prototype:init()
	IceCustomBar.super.prototype.init(self, "MyCustomBar", "player")
	self.textColorOverride = true
end

-- 'Public' methods -----------------------------------------------------------
-- OVERRIDE
function IceCustomBar.prototype:Enable(core)
	self.validClass = (uClass == self.moduleSettings.class) or (self.moduleSettings.class == "ALL")
	
	-- Not a valid class? Don't set up the bar
	if not self.validClass then return end
	
	-- Enable this bar
	IceCustomBar.super.prototype.Enable(self, core)

	-- Register events
	self:RegisterEvent("UNIT_AURA", "UpdateCustomBarEvent")
	self:RegisterEvent("UNIT_PET", "UpdateCustomBarEvent")
	self:RegisterEvent("PLAYER_PET_CHANGED", "UpdateCustomBarEvent")
	self:RegisterEvent("PLAYER_FOCUS_CHANGED", "UpdateCustomBarEvent")
	
	-- First show to update bar
	self:Show(true)
	self.unit = self.moduleSettings.myUnit
	self:UpdateCustomBar(self.unit)
	
	-- Set up text colors
	self:FixupTextColors()
	self:SetCustomTextColor(self.frame.bottomUpperText, self.moduleSettings.upperTextColor)
	self:SetCustomTextColor(self.frame.bottomLowerText, self.moduleSettings.lowerTextColor)
end

function IceCustomBar.prototype:FixupTextColors()
	if not self.moduleSettings.upperTextColor then
		self.moduleSettings.upperTextColor = {r=1, g=1, b=1}
	end
	if not self.moduleSettings.lowerTextColor then
		self.moduleSettings.lowerTextColor = {r=1, g=1, b=1}
	end
end

function IceCustomBar.prototype:TargetChanged()
	IceCustomBar.super.prototype.TargetChanged(self)

	self:UpdateCustomBar(self.unit)
end

function IceCustomBar.prototype:Disable(core)
	nibIceHUD.IceCore:RequestUpdates(self, nil)

	IceCustomBar.super.prototype.Disable(self, core)
end

-- OVERRIDE
function IceCustomBar.prototype:GetDefaultSettings()
	local settings = IceCustomBar.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = true
	settings["lowThreshold"] = 0
	settings["side"] = IceCore.Side.Right
	settings["offset"] = 8
	settings["upperText"]=""
	settings["lockLowerFontAlpha"] = false
	settings["lowerText"] = ""
	settings["lowerTextVisible"] = false
	settings["customBarType"] = "Bar"
	settings["buffToTrack"] = ""
	settings["myUnit"] = "player"
	settings["buffOrDebuff"] = "buff"
	settings["talentGroups"] = 7
	settings["class"] = "ALL"
	settings["barColor"] = {r=1, g=0, b=0, a=1}
	settings["trackOnlyMine"] = true
	settings["hideAnimationSettings"] = true
	settings["buffTimerDisplay"] = "minutes"
	settings["maxDuration"] = 0
	settings["lowerTextColor"] = {r=1, g=1, b=1}
	settings["upperTextColor"] = {r=1, g=1, b=1}

	return settings
end

function IceCustomBar.prototype:CreateBar()
	IceCustomBar.super.prototype.CreateBar(self)
end

function IceCustomBar.prototype:Redraw()
	IceCustomBar.super.prototype.Redraw(self)

	self:UpdateCustomBar(self.unit)
end

-- OVERRIDE
function IceCustomBar.prototype:GetOptions()
	local opts = IceCustomBar.super.prototype.GetOptions(self)

	opts.textSettings.args.upperTextString.hidden = false
	opts.textSettings.args.lowerTextString.hidden = false
	opts.lowThresholdColor = nil

	opts["customHeader"] = {
		type = 'header',
		name = L["Custom bar settings"],
		order = 30.1,
	}

	opts["deleteme"] = {
		type = 'execute',
		name = L["Delete me"],
		desc = L["Deletes this custom module and all associated settings. Cannot be undone!"],
		func = function()
			local dialog = StaticPopup_Show("NIBICEHUD_DELETE_CUSTOM_MODULE")
			if dialog then
				dialog.data = self
			end
		end,
		order = 20.1,
	}

	opts["duplicateme"] = {
		type = 'execute',
		name = L["Duplicate me"],
		desc = L["Creates a new module of this same type and with all the same settings."],
		func = function()
			nibIceHUD:CreateCustomModuleAndNotify(self.moduleSettings.customBarType, self.moduleSettings)
		end,
		order = 20.2,
	}

	opts["type"] = {
		type = "description",
		name = string.format("%s %s", L["Module type:"], tostring(self:GetBarTypeDescription("Bar"))),
		order = 21,
	}

	opts["name"] = {
		type = 'input',
		name = L["Bar name"],
		desc = L["The name of this bar (must be unique!).\n\nRemember to press ENTER after filling out this box with the name you want or it will not save."],
		get = function()
			return self.elementName
		end,
		set = function(info, v)
			if v~= "" then
				nibIceHUD.IceCore:RenameDynamicModule(self, v)
			end
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		usage = "<a name for this bar>",
		order = 30.3,
	}

	opts["unitToTrack"] = {
		type = 'select',
		values = validUnits,
		name = L["Unit to track"],
		desc = L["Select which unit that this bar should be looking for buffs/debuffs on"],
		get = function(info)
			return nibIceHUD:GetSelectValue(info, self.moduleSettings.myUnit)
		end,
		set = function(info, v)
			self.moduleSettings.myUnit = info.option.values[v]
			self.unit = info.option.values[v]
			self:Redraw()
			self:UpdateCustomBar(self.unit)
			nibIceHUD:NotifyOptionsChange()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 30.4,
	}

	opts["buffOrDebuff"] = {
		type = 'select',
		values = buffOrDebuff,
		name = L["Buff or debuff?"],
		desc = L["Whether we are tracking a buff or debuff"],
		get = function(info)
			return nibIceHUD:GetSelectValue(info, self.moduleSettings.buffOrDebuff)
		end,
		set = function(info, v)
			self.moduleSettings.buffOrDebuff = info.option.values[v]
			self:Redraw()
			self:UpdateCustomBar(self.unit)
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.unit == "main hand weapon" or self.unit == "off hand weapon"
		end,
		order = 30.5,
	}

	opts["buffToTrack"] = {
		type = 'input',
		name = L["Aura to track"],
		desc = L["Which buff/debuff this bar will be tracking.\n\nRemember to press ENTER after filling out this box with the name you want or it will not save."],
		get = function()
			return self.moduleSettings.buffToTrack
		end,
		set = function(info, v)
			local orig = v
			-- if tonumber(v) ~= nil then
				-- v = GetSpellInfo(tonumber(v))
			-- end
			if v == nil then
				v = orig
			end
			if self.moduleSettings.buffToTrack == self.moduleSettings.upperText then
				self.moduleSettings.upperText = v
			end
			self.moduleSettings.buffToTrack = v
			self:Redraw()
			self:UpdateCustomBar(self.unit)
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.unit == "main hand weapon" or self.unit == "off hand weapon"
		end,
		usage = "<which buff to track>",
		order = 30.6,
	}
	
	opts["talentGroups"] = {
		type = 'input',
		name = "Talent Groups",
		desc = "Which Talent Groups to show this Bar in. This is a Binary option. 7 = all talent groups.",
		get = function()
			return tostring(self.moduleSettings.talentGroups)
		end,
		set = function(info, v)
			if v == nil then v = 7 end
			v = tonumber(v) or 7
			v = min(v, 7)
			v = max(v, 1)

			self.moduleSettings.talentGroups = v
			self:UpdateCustomBar(self.unit)
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 30.65,
	}
	
	opts["class"] = {
		type = 'select',
		name = "Class",
		desc = "Which Class to show this bar in.",
		values = customClassSelect,
		get = function(info)
			return nibIceHUD:GetSelectValue(info, self.moduleSettings.class)
		end,
		set = function(info, v)
			self.moduleSettings.class = customClassSelect[v]
			self:UpdateCustomBar(self.unit)
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 30.66,
	}

	opts["trackOnlyMine"] = {
		type = 'toggle',
		name = L["Only track auras by me"],
		desc = L["Checking this means that only buffs or debuffs that the player applied will trigger this bar"],
		get = function()
			return self.moduleSettings.trackOnlyMine
		end,
		set = function(info, v)
			self.moduleSettings.trackOnlyMine = v
			self:Redraw()
			self:UpdateCustomBar(self.unit)
		end,
		disabled = function()
			return not self.moduleSettings.enabled or self.unit == "main hand weapon" or self.unit == "off hand weapon"
		end,
		order = 30.7,
	}

	opts["barColor"] = {
		type = 'color',
		name = L["Bar color"],
		desc = L["The color for this bar"],
		get = function()
			return self:GetBarColor()
		end,
		set = function(info, r,g,b)
			self.moduleSettings.barColor.r = r
			self.moduleSettings.barColor.g = g
			self.moduleSettings.barColor.b = b
			self.barFrame.bar:SetVertexColor(self:GetBarColor())
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 30.8,
	}

	opts["buffTimerDisplay"] = {
		type = 'select',
		name = L["Buff timer display"],
		desc = L["How to display the buff timer next to the name of the buff on the bar"],
		get = function(info)
			return nibIceHUD:GetSelectValue(info, self.moduleSettings.buffTimerDisplay)
		end,
		set = function(info, v)
			self.moduleSettings.buffTimerDisplay = info.option.values[v]
			self:UpdateCustomBar()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		values = validBuffTimers,
		order = 31
	}

	opts["maxDuration"] = {
		type = 'input',
		name = L["Maximum duration"],
		desc = L["Maximum Duration for the bar (the bar will remained full if it has longer than maximum remaining).  Leave 0 for spell duration.\n\nRemember to press ENTER after filling out this box with the name you want or it will not save."],
		get = function()
			return self.moduleSettings.maxDuration
		end,
		set = function(info, v)
			if not v or not tonumber(v) then
				v = 0
			end
			self.moduleSettings.maxDuration = v
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		usage = "<the maximum duration for a bar>",
		order = 31.1,
	}

	opts.textSettings.args.upperTextColor = {
		type = "color",
		name = L["Upper Text Color"],
		get = function()
			self:FixupTextColors()
			return self.moduleSettings.upperTextColor.r, self.moduleSettings.upperTextColor.g, self.moduleSettings.upperTextColor.b, 1
		end,
		set = function(info, r,g,b)
			self.moduleSettings.upperTextColor.r = r
			self.moduleSettings.upperTextColor.g = g
			self.moduleSettings.upperTextColor.b = b
			self:SetCustomTextColor(self.frame.bottomUpperText, self.moduleSettings.upperTextColor)
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 13.9,
	}

	opts.textSettings.args.lowerTextColor = {
		type = "color",
		name = L["Lower Text Color"],
		get = function()
			return self.moduleSettings.lowerTextColor.r, self.moduleSettings.lowerTextColor.g, self.moduleSettings.lowerTextColor.b, 1
		end,
		set = function(info, r,g,b)
			self.moduleSettings.lowerTextColor.r = r
			self.moduleSettings.lowerTextColor.g = g
			self.moduleSettings.lowerTextColor.b = b
			self:SetCustomTextColor(self.frame.bottomLowerText, self.moduleSettings.lowerTextColor)
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 14.9,
	}

	return opts
end

function IceCustomBar.prototype:GetBarColor()
	return self.moduleSettings.barColor.r, self.moduleSettings.barColor.g, self.moduleSettings.barColor.b, self.alpha
end

-- 'Protected' methods --------------------------------------------------------

function IceCustomBar.prototype:GetAuraDuration(unitName, buffName)
	if not unitName or not buffName then
		return nil
	end

	if unitName == "main hand weapon" or unitName == "off hand weapon" then
		local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges
			= GetWeaponEnchantInfo()

		if unitName == "main hand weapon" and hasMainHandEnchant then
			local duration =
				(self.auraDuration == nil or (mainHandExpiration/1000) > self.auraDuration) and (mainHandExpiration/1000)
				or self.auraDuration

			local slotId, mainHandTexture = GetInventorySlotInfo("MainHandSlot")
			return duration, mainHandExpiration/1000, mainHandCharges, GetInventoryItemTexture("player", slotId)
		elseif unitName == "off hand weapon" and hasOffHandEnchant then
			local duration =
				(self.auraDuration == nil or (offHandExpiration/1000) > self.auraDuration) and (offHandExpiration/1000)
				or self.auraDuration

			local slotId, offHandTexture = GetInventorySlotInfo("SecondaryHandSlot")
			return duration, offHandExpiration/1000, offHandCharges, GetInventoryItemTexture("player", slotId)
		end

		return nil
	end

	local i = 1
	local remaining
	local isBuff = self.moduleSettings.buffOrDebuff == "buff" and true or false
	local buffFilter = (isBuff and "HELPFUL" or "HARMFUL") .. (self.moduleSettings.trackOnlyMine and "|PLAYER" or "")
	local buff, rank, texture, count, type, duration, endTime, unitCaster, _, _, spellId = UnitAura(unitName, i, buffFilter)
	local isMine = unitCaster == "player"
	local validId = true
	
	while buff do
		if (self.moduleSettings.buffToTrack == "89775") then
			validId = spellId == 89775
		else
			validId = true
		end
		
		if self.moduleSettings.maxDuration and self.moduleSettings.maxDuration ~= 0 then
			duration = self.moduleSettings.maxDuration
		end
		
		if ((buff:upper() == buffName:upper()) and (validId) and ((not self.moduleSettings.trackOnlyMine) or isMine)) then
			if endTime and not remaining then
				remaining = endTime - GetTime()
			end
			return duration, remaining, count, texture, endTime
		end

		i = i + 1;

		buff, rank, texture, count, type, duration, endTime, unitCaster, _, _, spellId = UnitAura(unitName, i, buffFilter)
		isMine = unitCaster == "player"
	end

	return nil
end

function IceCustomBar.prototype:UpdateCustomBarEvent(event, unit)
	self:UpdateCustomBar(unit)
end

function IceCustomBar.prototype:UpdateTotems(event, totem)
	self:UpdateCustomBar(self.unit)
end

function IceCustomBar.prototype:UpdateCustomBar(unit, fromUpdate)
	if self.validClass then
		if unit and (unit ~= self.unit) and not (self.unit == "main hand weapon" or self.unit == "off hand weapon") then
			return
		end
		
		local now = GetTime()
		local remaining = nil
		local count = 0
		local auraIcon = nil
		local endTime = 0
		
		-- Get new Aura info
		if not fromUpdate then
			if tonumber(self.moduleSettings.buffToTrack) == nil then
				-- Buff Name
				self.auraDuration, remaining, count, auraIcon, endTime =
					self:GetAuraDuration(self.unit, self.moduleSettings.buffToTrack)
			else
				-- SpellID
				self.auraDuration, remaining, count, auraIcon, endTime =
					self:GetAuraDuration(self.unit, GetSpellInfo(self.moduleSettings.buffToTrack))
			end

			if endTime == 0 then
				self.bIsAura = true
				self.auraDuration = 1
				self.auraEndTime = 0
				remaining = 1
			elseif not remaining then
				self.bIsAura = false
				self.auraEndTime = -1
			else
				self.bIsAura = false
				self.auraEndTime = remaining + now
			end
		end

		-- Update bar
		if self.auraEndTime ~= nil and (self.auraEndTime == 0 or self.auraEndTime >= now) then
			-- Show bar and subscribe to updates
			if not fromUpdate then
				if not nibIceHUD.IceCore:IsUpdateSubscribed(self) then
					if not self.UpdateCustomBarFunc then
						self.UpdateCustomBarFunc = function() self:UpdateCustomBar(unit, true) end
					end
					
					-- self.handlesOwnUpdates = true
					nibIceHUD.IceCore:RequestUpdates(self, self.UpdateCustomBarFunc)
				end
				self:Show(true)
			end
			
			-- Get remaining time
			if not remaining then
				if self.auraEndTime == 0 then
					remaining = self.auraDuration
				else
					remaining = self.auraEndTime - now
				end
			end
			
			-- Update bar
			self:UpdateBar(self.auraDuration ~= 0 and remaining / self.auraDuration or 0, "undef")
			
			-- In case we haven't yet subscribed (bug)
			if not nibIceHUD.IceCore:IsUpdateSubscribed(self) then
				if self.UpdateCustomBarFunc ~= nil then
					nibIceHUD.IceCore:RequestUpdates(self, self.UpdateCustomBarFunc)
				end
			end
		else
			-- Hide bar and unsubscribe from updates
			self:UpdateBar(0, "undef")
			self:Show(false)
			-- self.handlesOwnUpdates = false
			nibIceHUD.IceCore:RequestUpdates(self, nil)
		end
		
		-- Update text
		if (remaining ~= nil) then
			local buffString = ""
			if self.moduleSettings.buffTimerDisplay == "seconds" then
				buffString = tostring(ceil(remaining or 0))
			else
				local seconds = ceil(remaining)%60
				local minutes = ceil(remaining)/60

				if self.moduleSettings.buffTimerDisplay == "minutes:seconds" then
					buffString = floor(minutes) .. ":" .. strform("%02d", seconds)
				elseif self.moduleSettings.buffTimerDisplay == "minutes" then
					if minutes > 1 then
						buffString = ceil(minutes) .. "m"
					else
						buffString = ceil(remaining)
					end
				end
			end
			if self.moduleSettings.forceJustifyText ~= "RIGHT" then
				self:SetBottomText1(self.moduleSettings.upperText .. (not self.bIsAura and (" " .. buffString) or ""))
			else
				self:SetBottomText1((not self.bIsAura and (buffString .. " ") or "") .. self.moduleSettings.upperText)
			end
		else
			self.auraBuffCount = 0
			self:SetBottomText1(self.moduleSettings.upperText)
		end

		self:SetBottomText2(self.moduleSettings.lowerText)
		self.barFrame.bar:SetVertexColor(self:GetBarColor())
	else
		-- Not valid class
		self:UpdateBar(0, "undef")
		nibIceHUD.IceCore:RequestUpdates(self, nil)
		self:Show(false)
		
		-- Hide completely (so we only see current class bars in Config Mode)
		self.masterFrame:Hide()
		self.frame:Hide()
	end
end

function IceCustomBar.prototype:OutCombat()
	IceCustomBar.super.prototype.OutCombat(self)

	self:UpdateCustomBar(self.unit)
end

local hex2bin = {
	[0] = "000",
	[1] = "100",
	[2] = "010",
	[3] = "110",
	[4] = "001",
	[5] = "101",
	[6] = "011",
	[7] = "111",
}
function IceCustomBar.prototype:RetrieveTableFromBinary(v)
	if v == nil then v = 7 end
	v = min(v, 7)
	v = max(v, 1)
	
	local s = hex2bin[v]
	
	local binarray = {}
	for i = 1, 3 do
		if strsub(s, i, i) == "0" then
			binarray[i] = false
		else
			binarray[i] = true
		end
	end
	
	return binarray
end

function IceCustomBar.prototype:Show(bShouldShow)
	if not bShouldShow then
		IceCustomBar.super.prototype.Show(self, false)
		return
	end
	
	local HideTalent = false
	local TalentTree = GetPrimaryTalentTree() or 0
	local TalentGroups = self:RetrieveTableFromBinary(self.moduleSettings.talentGroups)
	if TalentTree > 0 then
		if not TalentGroups[TalentTree] then HideTalent = true end
	end
	
	if HideTalent then
		IceCustomBar.super.prototype.Show(self, false)
	else
		if self.moduleSettings.displayWhenEmpty then
			if not self.bIsVisible then
				IceCustomBar.super.prototype.Show(self, true)
			end
		else
			IceCustomBar.super.prototype.Show(self, bShouldShow)
		end
	end
end
