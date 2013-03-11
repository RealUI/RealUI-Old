local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db, ndbc

local MODNAME = "Positioners"
local Positioners = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

local PF = {}

local CenterY = {
	[1] = -37,
	[2] = -38,
}

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Positioners",
		desc = "Controls the position of RealUI elements.",
		arg = MODNAME,
		order = 1615,
		args = {},
	};
	end
	return options;
end

local function CreatePositionerFrame(point, parent, rpoint, x, y, w, h, name)
	local frame = CreateFrame("Frame", name, _G[parent])
	frame:SetPoint(point, _G[parent], rpoint, x, y)
	frame:SetHeight(h)
	frame:SetWidth(w)
	
	return frame
end

local function CreatePositioners()
	for k, v in pairs(db[ndbc.resolution].positioners) do
		local fTable = v[nibRealUI.class]
		PF[k] = CreatePositionerFrame(fTable[1], fTable[2], fTable[3], fTable[4], fTable[5], fTable[6] + db[ndbc.resolution].sizes[fTable[8]], fTable[7] + db[ndbc.resolution].sizes[fTable[9]], "RealUI_Positioners_"..k)
	end
end

-- function Positioners:PLAYER_LOGIN()
	
-- end

function Positioners:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			[1] = {
				sizes = {
					["Nothing"] = 0,
					["HUDWidth"] = 268,
				},
				positioners = {
					["CenterAuras"] = {
						-- 			{point, parent, rpoint, x, y, width, height, width + sizes, height + sizes},
						['*'] =		{"CENTER", "UIParent", "CENTER", 0, CenterY[1], -100, 2, "HUDWidth", "Nothing"},
						["ROGUE"] =	{"CENTER", "UIParent", "CENTER", 0, CenterY[1], -88, 2, "HUDWidth", "Nothing"},
					},
				},
			},
			[2] = {
				sizes = {
					["Nothing"] = 0,
					["HUDWidth"] = 308,
				},
				positioners = {
					["CenterAuras"] = {
						-- 			{point, parent, rpoint, x, y, width, height, width + sizes, height + sizes},
						['*'] =		{"CENTER", "UIParent", "CENTER", 0, CenterY[2], -100, 2, "HUDWidth", "Nothing"},
						["ROGUE"] =	{"CENTER", "UIParent", "CENTER", 0, CenterY[2], -88, 2, "HUDWidth", "Nothing"},
					},
				},
			},
		}
	})
	db = self.db.profile
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(true)
	-- nibRealUI:RegisterPlainOptions(MODNAME, GetOptions)
	
	CreatePositioners()
	-- self:RegisterEvent("PLAYER_LOGIN")
end