-- Original code from aTooltip by Alza, modified code from FreeUI by Haleth

local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db, ndbc
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local MODNAME = "Tooltip"
local Tooltip = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

local LoggedIn = false

-- Options
local table_AnchorPoints = {
	"BOTTOM",
	"BOTTOMLEFT",
	"BOTTOMRIGHT",
	"CENTER",
	"LEFT",
	"RIGHT",
	"TOP",
	"TOPLEFT",
	"TOPRIGHT",
}

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = MODNAME,
		desc = "Modifies the appearance of the Tooltip window.",
		childGroups = "tab",
		arg = MODNAME,
		order = 2015,
		args = {
			header = {
				type = "header",
				name = "Tooltip",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Modifies the appearance of the Tooltip window.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Tooltip module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
				end,
				order = 30,
			},
			position = {
				name = "Position",
				type = "group",
				inline = true,
				order = 40,
				args = {
					cursor = {
						type = "toggle",
						name = "Cursor",
						width = "full",
						desc = "Position the Tooltip at the Cursor.",
						get = function() return db.position.cursor end,
						set = function(info, value) 
							db.position.cursor = value
						end,
						order = 10,
					},
					manual = {
						name = "Custom Location",
						type = "group",
						inline = true,
						disabled = function() return db.position.cursor end,
						order = 20,
						args = {
							x = {
								type = "input",
								name = "X Offset",
								width = "half",
								order = 10,
								get = function(info) return tostring(db.position.manual[4]) end,
								set = function(info, value)
									db.position.manual[4] = value
								end,
							},
							y = {
								type = "input",
								name = "Y Offset",
								width = "half",
								order = 20,
								get = function(info) return tostring(db.position.manual[5]) end,
								set = function(info, value)
									db.position.manual[5] = value
								end,
							},
							anchor = {
								type = "select",
								name = "Anchor",
								get = function(info) 
									for k,v in pairs(table_AnchorPoints) do
										if v == db.position.manual[1] then return k end
									end
								end,
								set = function(info, value)
									db.position.manual[1] = table_AnchorPoints[value]
									db.position.manual[3] = table_AnchorPoints[value]
								end,
								style = "dropdown",
								width = nil,
								values = table_AnchorPoints,
								order = 30,
							},
						},
					},
				},
			},
			font = {
				name = "Font",
				type = "group",
				inline = true,
				order = 50,
				args = {
					size = {
						type = "range",
						name = "Size",
						min = 6, max = 32, step = 1,
						get = function(info) return db.font.size end,
						set = function(info, value) 
							db.font.size = value
							Tooltip:SetupFonts()
						end,
						order = 10,
					},
				},
			},
		},
	}
	end
	
	return options
end

local UnitReactionColor = {
    { 1.0, 0.0, 0.0 },
    { 1.0, 0.0, 0.0 },
    { 1.0, 0.5, 0.0 },
    { 1.0, 1.0, 0.0 },
    { 0.0, 1.0, 0.0 },
    { 0.0, 1.0, 0.0 },
    { 0.0, 1.0, 0.0 },
    { 0.0, 1.0, 0.0 },
}

--PVP_ENABLED = ""

local pName = UnitName("player")

-- Talents (code from TipTop by Seerah)
local talentsGUID
local talents = {}
function Tooltip:TalentQuery()
	if CanInspect("mouseover") then
		if UnitName("mouseover") ~= pName and UnitLevel("mouseover") > 9 then
			local talentline = nil
			for i = 1, GameTooltip:NumLines() do
				local left, leftText
				left = _G["GameTooltipTextLeft"..i]
				leftText = left:GetText()
				if leftText then
					if strsub(leftText, 1, 3) == "S: " then
						talentline = 1
					end
				end
			end
			if not talentline then
				if InspectFrame and InspectFrame:IsShown() then
					GameTooltip:AddLine("S: Inspect Frame is open")
				elseif Examiner and Examiner:IsShown() then
					GameTooltip:AddLine("S: Examiner frame is open")
				else
					talentsGUID = UnitGUID("mouseover")
					NotifyInspect("mouseover")
					GameTooltip:AddLine("S: ...")
					Tooltip:RegisterEvent("INSPECT_READY")
				end
				GameTooltip:Show()
			end
		end
	end
end

function Tooltip:TalentText()
	local specID, spec, left, leftText
	if UnitExists("mouseover") then
		specID = GetInspectSpecialization("mouseover")
		_, spec = GetSpecializationInfoByID(specID)
		for i = 1, GameTooltip:NumLines() do
			left = _G[GameTooltip:GetName().."TextLeft"..i]
			leftText = left:GetText()
			if strsub(leftText, 1, 3) == "S: " then
				if spec then
					left:SetFormattedText("S: %s", spec)
				else
					left:SetText("S: None")
				end
			end
			GameTooltip:Show()
		end
	end
	Tooltip:UnregisterEvent("INSPECT_READY")
	specID, spec = nil
end

function Tooltip:INSPECT_READY(event, arg)
	if talentsGUID == arg then
		self:TalentText()
	end
end

-- Position
function Tooltip:SetupPosition()
	hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self, parent)
		if db.position.cursor then
			self:SetOwner(parent, "ANCHOR_CURSOR")
		else
			self:SetOwner(parent, "ANCHOR_NONE")
			self:SetPoint(unpack(db.position.manual))
		end
	end)
end

-- Background
function Tooltip:SetupBackground()
	local tooltips = {
		"GameTooltip",
		"ItemRefTooltip",
		"ItemRefShoppingTooltip1",
		"ItemRefShoppingTooltip2",
		"ShoppingTooltip1",
		"ShoppingTooltip2",
		"ShoppingTooltip3",
		"WorldMapTooltip",
		"ChatMenu",
		"EmoteMenu",
		"LanguageMenu",
		"VoiceMacroMenu",
	}

	for i = 1, #tooltips do
		local t = _G[tooltips[i]]
		t:SetBackdrop(nil)
		local bg = CreateFrame("Frame", nil, t)
		bg:SetPoint("TOPLEFT")
		bg:SetPoint("BOTTOMRIGHT")
		bg:SetFrameLevel(t:GetFrameLevel()-1)
		bg:SetBackdrop({
			bgFile = nibRealUI.media.textures.plain, 
			edgeFile = nibRealUI.media.textures.plain, 
			tile = false, tileSize = 0, edgeSize = 1, 
			insets = { left = 1, right = 1, top = 1, bottom = 1	}
		})
		bg:SetBackdropColor(0, 0, 0, 0.85)
		bg:SetBackdropBorderColor(0, 0, 0, 1)
	end
end

-- Fonts
function Tooltip:SetupFonts()
	-- Code from TipTop by Seerah
	local font = nibRealUI.font.standard
	local resSizeExtra = db.resolution[ndbc.resolution].fontsize
	local fontSize = db.font.size + resSizeExtra
	
	GameTooltipHeaderText:SetFont(font, fontSize + 1)
	GameTooltipText:SetFont(font, fontSize)
	GameTooltipTextSmall:SetFont(font, fontSize - 2)
	ShoppingTooltip1TextLeft1:SetFont(font, fontSize -2)
	ShoppingTooltip1TextLeft2:SetFont(font, fontSize)
	ShoppingTooltip1TextLeft3:SetFont(font, fontSize -2)
	ShoppingTooltip2TextLeft1:SetFont(font, fontSize -2)
	ShoppingTooltip2TextLeft2:SetFont(font, fontSize)
	ShoppingTooltip2TextLeft3:SetFont(font, fontSize -2)
	ShoppingTooltip3TextLeft1:SetFont(font, fontSize -2)
	ShoppingTooltip3TextLeft2:SetFont(font, fontSize)
	ShoppingTooltip3TextLeft3:SetFont(font, fontSize -2)
	
	for i = 1, ShoppingTooltip1:NumLines() do
		_G["ShoppingTooltip1TextRight"..i]:SetFont(font, fontSize -2)
	end
	for i = 1, ShoppingTooltip2:NumLines() do
		_G["ShoppingTooltip2TextRight"..i]:SetFont(font, fontSize -2)
	end
	for i = 1, ShoppingTooltip3:NumLines() do
		_G["ShoppingTooltip3TextRight"..i]:SetFont(font, fontSize -2)
	end
	if GameTooltipMoneyFrame1 then
		GameTooltipMoneyFrame1PrefixText:SetFont(font, fontSize)
		GameTooltipMoneyFrame1SuffixText:SetFont(font, fontSize)
		GameTooltipMoneyFrame1CopperButtonText:SetFont(font, fontSize)
		GameTooltipMoneyFrame1SilverButtonText:SetFont(font, fontSize)
		GameTooltipMoneyFrame1GoldButtonText:SetFont(font, fontSize)
	end
end

-- Statusbar
function Tooltip:SetupStatusbar()
	hooksecurefunc("HealthBar_OnValueChanged", function(self)
		self:SetStatusBarColor(.3, 1, .3)
	end)

	local sb = _G["GameTooltipStatusBar"]
	sb:SetHeight(3)
	sb:ClearAllPoints()
	sb:SetPoint("BOTTOMLEFT", GameTooltip, "BOTTOMLEFT", 1, 1)
	sb:SetPoint("BOTTOMRIGHT", GameTooltip, "BOTTOMRIGHT", -1, 1)
	sb:SetStatusBarTexture(nibRealUI.media.textures.plain)

	local sep = GameTooltipStatusBar:CreateTexture(nil, "ARTWORK")
	sep:SetHeight(1)
	sep:SetPoint("BOTTOMLEFT", 0, 3)
	sep:SetPoint("BOTTOMRIGHT", 0, 3)
	sep:SetTexture(nibRealUI.media.textures.plain)
	sep:SetVertexColor(0, 0, 0)
end

-- Unit Styling
function Tooltip:UPDATE_MOUSEOVER_UNIT()
	Tooltip:UnregisterEvent("INSPECT_READY")
	Tooltip:TalentQuery()
end

function Tooltip:SetupUnitStyling()
	local classification = {
		worldboss = "",
		rareelite = "R+",
		elite = "+",
		rare = "R",
	}

	local function Hex(r, g, b)
		return string.format('|cff%02x%02x%02x', r * 255, g * 255, b * 255)
	end

	local function GetColor(unit)
		local r, g, b = 1, 1, 1

		if UnitIsPlayer(unit) then
			local _, class = UnitClass(unit)
			r, g, b = unpack(nibRealUI:GetClassColor(class or "WARRIOR", true))
		elseif UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) or UnitIsDead(unit) then
			r, g, b = .6, .6, .6
		else
			r, g, b = unpack(UnitReactionColor[UnitReaction("player", unit) or 5])
		end

		return Hex(r, g, b)
	end

	local function OnTooltipSetUnit(self)
		local lines = self:NumLines()
		local name, unit = self:GetUnit()
		if not unit or not name then return end

		local race = UnitRace(unit) or ""
		local level = UnitLevel(unit) or ""
		local c = UnitClassification(unit)
		local crtype = UnitCreatureType(unit)
		local unitName, unitRealm = UnitName(unit)

		if(level and level==-1) then
			if(c=="worldboss") then
				level = "|cffff0000Boss|r"
			else
				level = "|cffff0000??|r"
			end
		end

		local color = GetColor(unit)
		
		if unitRealm and unitRealm ~= "" then
			_G["GameTooltipTextLeft1"]:SetFormattedText(color.."%s - %s", name, unitRealm)
		else
			_G["GameTooltipTextLeft1"]:SetText(color..name)
		end

		if(UnitIsPlayer(unit)) then
			local InGuild = GetGuildInfo(unit)
			if(InGuild) then
				_G["GameTooltipTextLeft2"]:SetFormattedText("%s", InGuild)
			end

			local n = InGuild and 3 or 2
			_G["GameTooltipTextLeft"..n]:SetFormattedText("%s %s", level, race)
		else
			for i = 2, lines do
				local line = _G["GameTooltipTextLeft"..i]
				local text = line:GetText() or ""
				if((level and text:find("^"..LEVEL)) or (crtype and text:find("^"..crtype))) then
					line:SetFormattedText("%s%s %s", level, classification[c] or "", crtype or "")
					break
				end
			end
		end

		-- Target Line
		local tunit = unit.."target"
		if(UnitExists(tunit) and unit~="player") then
			local color = GetColor(tunit)
			local text = ""

			if(UnitName(tunit)==UnitName("player")) then
				text = "T: > YOU <"
			else
				text = "T: "..UnitName(tunit)
			end

			self:AddLine(color..text)
		end
	end
	GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)
end

----
function Tooltip:RefreshMod()
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end
	
	db = self.db.profile
	
	-- Refresh Mod
	self:SetupPosition()
	self:SetupBackground()
	self:SetupFonts()
	self:SetupStatusbar()
	self:SetupUnitStyling()
end

function Tooltip:PLAYER_LOGIN()
	LoggedIn = true

	self:RefreshMod()
end

function Tooltip:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			position = {
				cursor = false,
				manual = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -42, 220},
			},
			font = {
				size = 11,
			},
			resolution = {
				[1] = {
					fontsize = 0,
				},
				[2] = {
					fontsize = 1,
				},
			},
		},
	})
	db = self.db.profile
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterPlainOptions(MODNAME, GetOptions)
	
	self:RegisterEvent("PLAYER_LOGIN")
end

function Tooltip:OnEnable()	
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	if LoggedIn then self:RefreshMod() end
end

function Tooltip:OnDisable()
	self:UnregisterEvent("PLAYER_LOGIN")
end