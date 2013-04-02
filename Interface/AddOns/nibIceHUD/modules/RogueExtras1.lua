local RogueExtras1 = IceCore_CreateClass(IceUnitBar)
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local nibIceHUD = _G.nibIceHUD

local playerSpec = 0

local tottBaseTime = 6
local tottEndTime = 0
local tottDuration = 0
local tottSpellID = 57933
local tottName = ""
local tottIcon = nil

local arBaseTime = 15
local arGlyphBonusSec = 5
local arEndTime = 0
local arDuration = 0
local arGlyphSpellId = 56808
local arSpellID = 13750
local arName = ""
local arIcon = nil

local sdBaseTime = 6
local sdGlyphBonusSec = 2
local sdEndTime = 0
local sdDuration = 0
local sdGlyphSpellId = 63253
local sdSpellID = 51713
local sdName = ""
local sdIcon = nil

local vndBaseTime = 30
local vndGlyphBonusSec = 5
local vndEndTime = 0
local vndDuration = 0
local vndGlyphSpellId = 63249
local vndSpellID = 79140
local vndName = ""
local vndIcon = nil

local ActiveAuras = {
	["ToTT"] = false,
	["AR"] = false,
	["SD"] = false,
	["VND"] = false
}

local CurrMaxARDuration = 0
local CurrMaxVNDDuration = 0
local CurrMaxSDDuration = 0

local AuraTexCoord = {0.1, 0.9, 0.1, 0.9}

-- Constructor --
function RogueExtras1.prototype:init()
	RogueExtras1.super.prototype.init(self, "RogueExtras1", "player")

	self.moduleSettings = {}

	self:SetDefaultColor("RogueExtras1AR", 0.9, 0.65, 0.25)
	self:SetDefaultColor("RogueExtras1ToTT", 0.3, 0.8, 0.3)
	self:SetDefaultColor("RogueExtras1SD", 0.12, 0.5, 0.85)
	self:SetDefaultColor("RogueExtras1VND", 1, 0.475, 0.3)

	self.bTreatEmptyAsFull = true
end

-- 'Public' methods -----------------------------------------------------------

-- OVERRIDE
function RogueExtras1.prototype:Enable(core)
	RogueExtras1.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_AURA", "UpdateRogueExtras1")
	self:RegisterEvent("GLYPH_UPDATED", "GetMaxBuffTimes")
	self:RegisterEvent("GLYPH_ADDED", "GetMaxBuffTimes")
	self:RegisterEvent("GLYPH_DISABLED", "GetMaxBuffTimes")
	self:RegisterEvent("GLYPH_REMOVED", "GetMaxBuffTimes")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "UpdateSpec")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "UpdateSpec")
	
	local ShownEvents = {
		"UNIT_SPELLCAST_SENT",
		"UNIT_SPELLCAST_START",
		"UNIT_SPELLCAST_STOP",
		"UNIT_SPELLCAST_FAILED",
		"UNIT_SPELLCAST_INTERRUPTED",
		"UNIT_SPELLCAST_DELAYED",
		"UNIT_SPELLCAST_SUCCEEDED",
		"UNIT_SPELLCAST_CHANNEL_START",
		"UNIT_SPELLCAST_CHANNEL_UPDATE",
		"UNIT_SPELLCAST_CHANNEL_STOP",
	}
	for i,v in pairs(ShownEvents) do
		self:RegisterEvent(v, "ShownUpdate")
	end
	
	tottName = GetSpellInfo(tottSpellID)
	arName = GetSpellInfo(arSpellID)
	sdName = GetSpellInfo(sdSpellID)
	vndName = GetSpellInfo(vndSpellID)
	
	self:GetMaxBuffTimes()
	self:UpdateSpec()
	
	if not self.moduleSettings.alwaysFullAlpha then
		self:Show(false)
	else
		self:UpdateRogueExtras1()
	end

	self:SetBottomText1("")
	self:SetBottomText2("")
end

function RogueExtras1.prototype:Disable(core)
	RogueExtras1.super.prototype.Disable(self, core)
end

function RogueExtras1.prototype:TargetChanged()
	RogueExtras1.super.prototype.TargetChanged(self)
	self:UpdateRogueExtras1(nil, "target", nil)
end

-- OVERRIDE
function RogueExtras1.prototype:GetDefaultSettings()
	local settings = RogueExtras1.super.prototype.GetDefaultSettings(self)

	settings["enabled"] = true
	settings["showAsPercentOfMax"] = true
	settings["displayAuraIcon"] = false
	settings["auraIconXOffset"] = 0
	settings["auraIconYOffset"] = 0
	settings["auraIconSize"] = 27

	return settings
end

-- OVERRIDE
function RogueExtras1.prototype:GetOptions()
	local opts = RogueExtras1.super.prototype.GetOptions(self)

	opts["textSettings"].args["upperTextString"]["desc"] = "The text to display under this bar. # will be replaced with the number of seconds remaining."
	opts["textSettings"].args["upperTextString"].hidden = false

	opts["showAsPercentOfMax"] =
	{
		type = 'toggle',
		name = "Show bar as % of maximum",
		desc = "If this is checked, then the buff time shows as a percent of the maximum attainable (taking set bonuses and talents into account). Otherwise, the bar always goes from full to empty when applying no matter the duration.",
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

function RogueExtras1.prototype:CreateFrame()
	RogueExtras1.super.prototype.CreateFrame(self)
end

-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function RogueExtras1.prototype:CreateFrame()
	RogueExtras1.super.prototype.CreateFrame(self)
	
	local layout = RealUI and RealUI.db.char.resolution or 1
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

function RogueExtras1.prototype:PositionIcons()
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

function RogueExtras1.prototype:GetBuffDuration(unitName, buffName, buffID, oldIcon)
	local name, _, icon, _, _, duration, endTime, _, _, _, spellID = UnitAura(unitName, buffName)
	if name and spellID == buffID then
		return duration, endTime - GetTime(), oldIcon or icon
	end
	return nil, nil
end

function RogueExtras1.prototype:GetDebuffDuration(unitName, buffName, buffID)
	local name, _, icon, _, _, duration, endTime, caster, _, _, spellID = UnitDebuff("target", buffName)
	if name and spellID == buffID and caster == "player" then
		return duration, endTime - GetTime(), icon
	end
	return nil, nil
end

function RogueExtras1.prototype:MyOnUpdate()
	RogueExtras1.super.prototype.MyOnUpdate(self)
	if self.bUpdateRE then
		self:UpdateRogueExtras1(nil, nil, true)
	end
end

function RogueExtras1.prototype:UpdateRogueExtras1(event, unit, fromUpdate)
	if unit and ((unit ~= "player") and (unit ~= "target")) then
		return
	end

	local now = GetTime()
	local tottRemaining, arRemaining, sdRemaining, vndRemaining = nil, nil, nil, nil
	
	if not fromUpdate then
		if unit and (unit == "player") then
			tottDuration, tottRemaining, tottIcon = self:GetBuffDuration("player", tottName, tottSpellID, tottIcon)
			if not tottRemaining then
				tottEndTime = 0
			else
				tottEndTime = tottRemaining + now
			end
			
			if playerSpec == 2 then
				arDuration, arRemaining, arIcon = self:GetBuffDuration("player", arName, arSpellID, arIcon)
				if not arRemaining then
					arEndTime = 0
				else
					arEndTime = arRemaining + now
				end
			end
			
			if playerSpec == 3 then
				sdDuration, sdRemaining, sdIcon = self:GetBuffDuration("player", sdName, sdSpellID, sdIcon)
				if not sdRemaining then
					sdEndTime = 0
				else
					sdEndTime = sdRemaining + now
				end
			end
		elseif (unit and (unit == "target")) and (playerSpec == 1) then
			vndDuration, vndRemaining, vndIcon = self:GetDebuffDuration("player", vndName, vndSpellID, vndIcon)
			if not vndRemaining then
				vndEndTime = 0
			else
				vndEndTime = vndRemaining + now
			end
		end
	end
	
	ActiveAuras["ToTT"] = (tottEndTime and tottEndTime >= now)
	ActiveAuras["AR"] = (arEndTime and arEndTime >= now)
	ActiveAuras["SD"] = (sdEndTime and sdEndTime >= now)
	ActiveAuras["VND"] = (vndEndTime and vndEndTime >= now)
	
	if ActiveAuras["AR"] or ActiveAuras["ToTT"] or ActiveAuras["SD"] or ActiveAuras["VND"] then
		if not fromUpdate then
			self.bUpdateRE = true
			self.barFrame.icon:SetTexture(ActiveAuras["AR"] and (arIcon or "") or ActiveAuras["SD"] and (sdIcon or "") or ActiveAuras["VND"] and (vndIcon or "") or ActiveAuras["ToTT"] and (tottIcon or ""))
			self:Toggle(true)
		end
		
		local currRemaining, currName = nil, ""
		if ActiveAuras["AR"] then
			if not arRemaining then
				arRemaining = arEndTime - now
			end
			self:UpdateBar(denominator ~= 0 and arRemaining / CurrMaxARDuration or 0, "RogueExtras1AR")
			currRemaining = arRemaining
			currName = arName
			
		elseif ActiveAuras["SD"] then
			if not sdRemaining then
				sdRemaining = sdEndTime - now
			end
			self:UpdateBar(sdDuration ~= 0 and sdRemaining / CurrMaxSDDuration or 0, "RogueExtras1SD")
			currRemaining = sdRemaining
			currName = sdName
			
		elseif ActiveAuras["VND"] then
			if not vndRemaining then
				vndRemaining = vndEndTime - now
			end
			self:UpdateBar(vndDuration ~= 0 and vndRemaining / CurrMaxVNDDuration or 0, "RogueExtras1VND")
			currRemaining = vndRemaining
			currName = vndName
			
		elseif ActiveAuras["ToTT"] then
			if not tottRemaining then
				tottRemaining = tottEndTime - now
			end
			self:UpdateBar(tottDuration ~= 0 and tottRemaining / tottBaseTime or 0, "RogueExtras1ToTT")
			currRemaining = tottRemaining
			currName = tottName
			
		end

		if (currRemaining ~= nil) then
			if self.moduleSettings.textVisible.lower then
				self:SetBottomText1(currName)
				self:SetBottomText2(string.format("%d", ceil(currRemaining)))
			else
				self:SetBottomText1(currName .. ": " .. string.format("%d", ceil(currRemaining)))
			end
		end
	else
		self:UpdateBar(0, "RogueExtras1")
		self:Toggle(false)
		self.bUpdateRE = false
	end
end

function RogueExtras1.prototype:GetMaxBuffTimes()
	local maxARDuration = arBaseTime
	if self:HasGlyphBonus(arGlyphSpellId) then
		maxARDuration = maxARDuration + arGlyphBonusSec
	end
	CurrMaxARDuration = maxARDuration
	
	local maxSDDuration = sdBaseTime
	if self:HasGlyphBonus(sdGlyphSpellId) then
		maxSDDuration = maxSDDuration + sdGlyphBonusSec
	end
	CurrMaxSDDuration = maxSDDuration
	
	local maxVNDDuration = vndBaseTime
	if self:HasGlyphBonus(vndGlyphSpellId) then
		maxVNDDuration = maxVNDDuration + vndGlyphBonusSec
	end
	CurrMaxVNDDuration = maxVNDDuration
	
	self:UpdateRogueExtras1()
end

function RogueExtras1.prototype:HasGlyphBonus(spellID)
	for i = 1, GetNumGlyphSockets() do
		local enabled, _, _, spell = GetGlyphSocketInfo(i)
		if enabled and spell == spellID then
			return true
		end
	end
	return false
end

function RogueExtras1.prototype:OutCombat()
	RogueExtras1.super.prototype.OutCombat(self)

	self:UpdateRogueExtras1()
end

-- Spell Cast
function RogueExtras1.prototype:ShownUpdate(event, ...)
	local unit = ... or "player"
	if unit == "player" then
		local show = not(UnitCastingInfo("player")) and (ActiveAuras["ToTT"] or ActiveAuras["AR"] or ActiveAuras["SD"] or ActiveAuras["VND"])
		self:Toggle(show)
	end
end

function RogueExtras1.prototype:Toggle(vis)
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

function RogueExtras1.prototype:UpdateSpec()
	playerSpec = GetSpecialization()
	self:UpdateRogueExtras1()
end

local _, unitClass = UnitClass("player")

-- Load us up
if unitClass == "ROGUE" then
	nibIceHUD.RogueExtras1 = RogueExtras1:new()
end
