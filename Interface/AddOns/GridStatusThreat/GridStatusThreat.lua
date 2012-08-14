-- -------------------------------------------------------------------------- --
-- GridStatusThreat by kunda                                                  --
-- -------------------------------------------------------------------------- --

local GridRoster = Grid:GetModule("GridRoster")
local GridStatus = Grid:GetModule("GridStatus")
local L = GridStatusThreat_Locales

local AceTimer = LibStub("AceTimer-3.0")
local Timer

local GridStatusThreat = Grid:GetModule("GridStatus"):NewModule("GridStatusThreat")
GridStatusThreat.menuName = "Threat"

local _G = _G
local math_floor = _G.math.floor
local UnitExists = _G.UnitExists
local UnitDetailedThreatSituation = _G.UnitDetailedThreatSituation

local targetunitid
local threatPercent
local threatText
local statuscolorGraphic
local statuscolorText

GridStatusThreat.defaultDB = {
	debug = false,
	color_fix_t = { r = 1, g = 0.5, b = 0, a = 1 },
	color_fix_m = { r = 0.5, g = 1, b = 0.5, a = 1 },
	color_fix_l = { r = 0.6, g = 0.6, b = 0.6, a = 1 },
	threat1 = 50,
	threat2 = 70,
	threat3 = 90,
	classcol = false,
	threatcol = true,
	fixedcol = false,
	fixedcolrgb = { r = 1, g = 1, b = 1, a = 1 },
	alert_threat_graphic = {
		text = L["Threat"],
		enable = true,
		priority = 90,
		range = false,
		color = { r = 0, g = 0, b = 0, a = 1 },
	},
	alert_threat_text = {
		text = L["Threat: Text"],
		enable = true,
		priority = 90,
		range = false,
		color = { r = 0, g = 0, b = 0, a = 1 },
	}
}

GridStatusThreat.options = false

function GridStatusThreat:Menu()
	return {
		["threat_color"] = {
			type = "group",
			name = L["Threatcolors"],
			desc = L["Specify colors for the different threat conditions."],
			order = 100,
			args = {
			["threat_color1"] = {
				type = "color",
				name = string.format(L["Top Threat (>=%s%%)"],GridStatusThreat.db.profile.threat3),
				desc = L["Top Threat"]..".",
				order = 100.1,
				hasAlpha = true,
				get = function()
					local s = GridStatusThreat.db.profile.color_fix_t
					return s.r, s.g, s.b, s.a
				end,
				set = function(_,r,g,b,a)
					local s = GridStatusThreat.db.profile.color_fix_t
					s.r, s.g, s.b, s.a = r, g, b, a
				end
				},
			["threat_color2"] = {
				type = "color",
				name = string.format(L["Middle Threat (>=%s%% and <%s%%)"],GridStatusThreat.db.profile.threat2,GridStatusThreat.db.profile.threat3),
				desc = L["Middle Threat"]..".",
				order = 100.2,
				hasAlpha = true,
				get = function()
					local s = GridStatusThreat.db.profile.color_fix_m
					return s.r, s.g, s.b, s.a
				end,
				set = function(_,r,g,b,a)
					local s = GridStatusThreat.db.profile.color_fix_m
					s.r, s.g, s.b, s.a = r, g, b, a
				end
				},
			["threat_color3"] = {
				type = "color",
				name = string.format(L["Low Threat (>=%s%% and <%s%%)"],GridStatusThreat.db.profile.threat1,GridStatusThreat.db.profile.threat2),
				desc = L["Low Threat (Start)"]..".",
				order = 100.3,
				hasAlpha = true,
				get = function()
					local s = GridStatusThreat.db.profile.color_fix_l
					return s.r, s.g, s.b, s.a
				end,
				set = function(_,r,g,b,a)
					local s = GridStatusThreat.db.profile.color_fix_l
					s.r, s.g, s.b, s.a = r, g, b, a
				end
				},
			},
		},
		["threat_header2"] = {
			type = "header",
			name = L["Text options:"],
			order = 101
			},
		["threat_textcolor"] = {
			type = "group",
			name = L["Textcolor"],
			desc = L["Specify textcolor."],
			order = 102,
			args = {
			["threat_textcolor_threat"] = {
				type = "toggle",
				name = L["Threatcolor"],
				desc = L["Threatcolor"]..".",
				order = 102.1,
				get = function()
					return GridStatusThreat.db.profile.threatcol
				end,
				set = function()
					GridStatusThreat.db.profile.threatcol = not GridStatusThreat.db.profile.threatcol
					GridStatusThreat.db.profile.classcol = false
					GridStatusThreat.db.profile.fixedcol = false
				end
				},
			["threat_textcolor_class"] = {
				type = "toggle",
				name = L["Classcolor"],
				desc = L["Classcolor"]..".",
				order = 102.2,
				get = function()
					return GridStatusThreat.db.profile.classcol
				end,
				set = function()
					GridStatusThreat.db.profile.classcol = not GridStatusThreat.db.profile.classcol
					GridStatusThreat.db.profile.threatcol = false
					GridStatusThreat.db.profile.fixedcol = false
				end
				},
			["threat_textcolor_fixed"] = {
				type = "toggle",
				name = L["Fixed color"],
				desc = L["Fixed color"]..".",
				order = 102.3,
				get = function()
					return GridStatusThreat.db.profile.fixedcol
				end,
				set = function()
					GridStatusThreat.db.profile.fixedcol = not GridStatusThreat.db.profile.fixedcol
					GridStatusThreat.db.profile.classcol = false
					GridStatusThreat.db.profile.threatcol = false
				end
				},
			["threat_textcolor_fixedselect"] = {
				type = "color",
				name = L["Select fixed color"]..":",
				desc = L["Select fixed color"]..".",
				disabled = function() return not GridStatusThreat.db.profile.fixedcol end,
				order = 102.4,
				hasAlpha = true,
				get = function()
					local s = GridStatusThreat.db.profile.fixedcolrgb
					return s.r, s.g, s.b, s.a
				end,
				set = function(_, r,g,b,a)
					local s = GridStatusThreat.db.profile.fixedcolrgb
					s.r, s.g, s.b, s.a = r, g, b, a
				end
				}
			}
		}
	}
end

local function ThreatUpdate()
	local settings = GridStatusThreat.db.profile.alert_threat_graphic
	local opt = GridStatusThreat.db.profile

	for guid, unitid in GridRoster:IterateRoster() do

		targetunitid = unitid.."target"
		threatPercent = 0

		if UnitExists(targetunitid) then
			local _, _, threat = UnitDetailedThreatSituation(unitid, targetunitid)
			if threat then
				threatPercent = threat
			end
		end

		if threatPercent >= opt.threat1 then
			if threatPercent >= 100 then
				statuscolorGraphic = { r = 1, g = 0, b = 0, a = 1 }
				threatText = L["AGGRO"]
			elseif threatPercent >= opt.threat3 then
				statuscolorGraphic = opt.color_fix_t
				threatText = math_floor(threatPercent).."%"
			elseif threatPercent >= opt.threat2 then
				statuscolorGraphic = opt.color_fix_m
				threatText = math_floor(threatPercent).."%"
			else
				statuscolorGraphic = opt.color_fix_l
				threatText = math_floor(threatPercent).."%"
			end

			statuscolorText = statuscolorGraphic
			if opt.classcol then
				statuscolorText = GridStatus:UnitColor(guid)
			elseif opt.fixedcol then
				statuscolorText = opt.fixedcolrgb
			end

			GridStatusThreat.core:SendStatusGained(guid, "alert_threat_graphic",
				settings.priority,
				(settings.range and 40),
				statuscolorGraphic,
				nil)
			GridStatusThreat.core:SendStatusGained(guid, "alert_threat_text",
				settings.priority,
				(settings.range and 40),
				statuscolorText,
				threatText)
		else
			GridStatusThreat.core:SendStatusLost(guid, "alert_threat_graphic")
			GridStatusThreat.core:SendStatusLost(guid, "alert_threat_text")
		end
	end
end

function GridStatusThreat:OnInitialize()
	self.super.OnInitialize(self)
	local menu = self:Menu()
	self:RegisterStatus("alert_threat_graphic", L["Threat"], menu, true)
	self:RegisterStatus("alert_threat_text", L["Threat: Text"], menu, true)
	GridStatus.options.args["alert_threat_graphic"].args["color"] = nil
	GridStatus.options.args["alert_threat_text"] = nil
end

function GridStatusThreat:OnStatusEnable(status)
	if status == "alert_threat_graphic" then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
		ThreatUpdate()
	end
end

function GridStatusThreat:OnStatusDisable(status)
	if status == "alert_threat_graphic" then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		self.core:SendStatusLostAllUnits("alert_threat_graphic")
		self.core:SendStatusLostAllUnits("alert_threat_text")
	end
end

function GridStatusThreat:PLAYER_REGEN_DISABLED()
	if Timer then return end
	Timer = AceTimer:ScheduleRepeatingTimer(ThreatUpdate, 0.5)
end

function GridStatusThreat:PLAYER_REGEN_ENABLED()
	self.core:SendStatusLostAllUnits("alert_threat_graphic")
	self.core:SendStatusLostAllUnits("alert_threat_text")
	AceTimer:CancelTimer(Timer, true)
	Timer = nil
end