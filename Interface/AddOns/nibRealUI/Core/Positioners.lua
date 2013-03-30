local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db, ndb, ndbc

local MODNAME = "Positioners"
local Positioners = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

-- local options
-- local function GetOptions()
	-- if not options then options = {
		-- type = "group",
		-- name = "Positioners",
		-- desc = "Controls the position of RealUI elements.",
		-- arg = MODNAME,
		-- order = 1615,
		-- args = {},
	-- };
	-- end
	-- return options;
-- end

local PF = {}
local HuDVO = -96

local function GetPositionData(pT)
	local point, parent, rPoint, x, y, width, height, xKeyTable, yKeyTable, widthKeyTable, heightKeyTable =
			pT[1], pT[2], pT[3], pT[4], pT[5], pT[6], pT[7], pT[8], pT[9], pT[10], pT[11]
	
	local xAdj, yAdj, widthAdj, heightAdj = 0, 0, 0, 0
	if xKeyTable then
		for k,v in pairs(xKeyTable) do
			xAdj = xAdj + ndb.positions[ndbc.resolution][v]
		end
	end
	if yKeyTable then
		for k,v in pairs(yKeyTable) do
			yAdj = yAdj + ndb.positions[ndbc.resolution][v]
		end
	end
	if widthKeyTable then
		for k,v in pairs(widthKeyTable) do
			widthAdj = widthAdj + ndb.positions[ndbc.resolution][v]
		end
	end
	if heightKeyTable then
		for k,v in pairs(heightKeyTable) do
			heightAdj = heightAdj + ndb.positions[ndbc.resolution][v]
		end
	end
	
	return point, parent, rPoint, x + xAdj, y + yAdj, width + widthAdj, height + heightAdj
end

function nibRealUI:UpdatePositioners()
	local positioners = {}
	for k, v in pairs(db[ndbc.resolution].positioners) do
		positioners[k] = v
	end
	for k, v in pairs(db[ndbc.resolution].class) do
		positioners[k] = v[nibRealUI.class]
	end
	for k, v in pairs(positioners) do
		local point, parent, rPoint, x, y, width, height = GetPositionData(v)
		PF[k]:ClearAllPoints()
		PF[k]:SetPoint(point, parent, rPoint, x, y)
		PF[k]:SetSize(width, height)
	end
end

local function CreatePositionerFrame(point, parent, rpoint, x, y, w, h, name)
	local frame = CreateFrame("Frame", name, _G[parent])
	frame:SetPoint(point, _G[parent], rpoint, x, y)
	frame:SetHeight(h)
	frame:SetWidth(w)
	
	-- frame.bg = frame:CreateTexture(nil, "OVERLAY")
	-- frame.bg:SetAllPoints(frame)
	-- frame.bg:SetTexture(0, 1, 1, 0.2)
	
	return frame
end

local function CreatePositioners()
	local positioners = {}
	for k, v in pairs(db[ndbc.resolution].positioners) do
		positioners[k] = v
	end
	for k, v in pairs(db[ndbc.resolution].class) do
		positioners[k] = v[nibRealUI.class]
	end
	for k, v in pairs(positioners) do
		local point, parent, rPoint, x, y, width, height = GetPositionData(v)
		PF[k] = CreatePositionerFrame(
			point, parent, rPoint, x, y, width, height, "RealUIPositioners"..k
		)
	end
end

function Positioners:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			[1] = {
				positioners = {
					-- 						{point, parent, rpoint, x, y, width, height, xKeyTable, yKeyTable, widthKeyTable, heightKeyTable},
					["Center"] =			{"CENTER", 	"UIParent",	"CENTER", 0, 0, 2, 2, 		nil, 		{"HuDY"}, nil, nil},
					["HuD"] =				{"CENTER", 	"UIParent",	"CENTER", 0, HuDVO, 0, 2,	{"HuDX"},	{"HuDY"}, {"HuDWidth"}, nil},
					["SpellAlerts"] =		{"CENTER", 	"UIParent",	"CENTER", 0, 0, -110, 140, 	{"HuDX"},	{"HuDY"}, {"HuDWidth"}, nil},
					["BottomInfo"] =		{"TOP", 	"UIParent",	"CENTER", 0, -96, -132, 27, {"HuDX"},	{"HuDY"}, {"HuDWidth"}, nil},
					["UnitFrames"] =		{"CENTER", 	"UIParent",	"CENTER", 0, 0, 80, 2, 		{"HuDX"}, 	{"HuDY"}, {"HuDWidth", "UFHorizontal"}, nil},
					["LayoutBottomItem"] =	{"CENTER", 	"UIParent",	"CENTER", 0, -133, 342, 1, 	nil,		{"HuDY", "BIY"}, nil, nil},
				},
				class = {
					["CenterAuras"] = {
						['*'] =				{"CENTER", 	"UIParent",	"CENTER", 0, 0, -100, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["DEATHKNIGHT"] =	{"CENTER", 	"UIParent",	"CENTER", -14, 0, -70, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["DRUID"] =			{"CENTER", 	"UIParent",	"CENTER", 0, 0, -96, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["HUNTER"] =		{"CENTER", 	"UIParent",	"CENTER", -10, 0, -62, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["MAGE"] =			{"CENTER", 	"UIParent",	"CENTER", -12, 0, -84, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["MONK"] =			{"CENTER", 	"UIParent",	"CENTER", 4, 0, -84, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["PRIEST"] =		{"CENTER", 	"UIParent",	"CENTER", 0, 0, -96, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["ROGUE"] =			{"CENTER", 	"UIParent",	"CENTER", 6, 0, -96, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["SHAMAN"] =		{"CENTER", 	"UIParent",	"CENTER", -15, 0, -68, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["WARLOCK"] =		{"CENTER", 	"UIParent",	"CENTER", -12, 0, -76, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["WARRIOR"] =		{"CENTER", 	"UIParent",	"CENTER", 8, 0, -96, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
					},
				},
			},
			[2] = {
				positioners = {
					-- 						{point, parent, rpoint, x, y, width, height, xKeyTable, yKeyTable, widthKeyTable, heightKeyTable},
					["Center"] =			{"CENTER", 	"UIParent",	"CENTER", 0, 0, 2, 2, 		nil,		{"HuDY"}, nil, nil},
					["HuD"] =				{"CENTER", 	"UIParent",	"CENTER", 0, HuDVO, 0, 2, 	{"HuDX"}, 	{"HuDY"}, {"HuDWidth"}, nil},
					["SpellAlerts"] =		{"CENTER", 	"UIParent",	"CENTER", 0, 0, -160, 140, 	{"HuDX"},	{"HuDY"}, {"HuDWidth"}, nil},
					["BottomInfo"] =		{"TOP", 	"UIParent",	"CENTER", 0, -95, -132, 28, {"HuDX"},	{"HuDY"}, {"HuDWidth"}, nil},
					["UnitFrames"] =		{"CENTER", 	"UIParent",	"CENTER", 0, 0, 80, 2, 		{"HuDX"},	{"HuDY"}, {"HuDWidth", "UFHorizontal"}, nil},
					["LayoutBottomItem"] =	{"CENTER", 	"UIParent",	"CENTER", 0, -133, 342, 1,	nil,		{"HuDY", "BIY"}, nil, nil},
				},
				class = {
					["CenterAuras"] = {
						['*'] =				{"CENTER",	"UIParent",	"CENTER", 0, 0, -100, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["DEATHKNIGHT"] =	{"CENTER",	"UIParent",	"CENTER", -14, 0, -70, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["DRUID"] =			{"CENTER",	"UIParent",	"CENTER", 0, 0, -96, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["HUNTER"] =		{"CENTER",	"UIParent",	"CENTER", -10, 0, -62, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["MAGE"] =			{"CENTER",	"UIParent",	"CENTER", -12, 0, -84, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["MONK"] =			{"CENTER",	"UIParent",	"CENTER", 4, 0, -84, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["PRIEST"] =		{"CENTER",	"UIParent",	"CENTER", 0, 0, -96, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["ROGUE"] =			{"CENTER",	"UIParent",	"CENTER", 6, 0, -96, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["SHAMAN"] =		{"CENTER",	"UIParent",	"CENTER", -15, 0, -68, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["WARLOCK"] =		{"CENTER",	"UIParent",	"CENTER", -12, 0, -76, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
						["WARRIOR"] =		{"CENTER",	"UIParent",	"CENTER", 8, 	0, -96, 2, 	{"HuDX"}, {"HuDY"}, {"HuDWidth"}, nil},
					},
				},
			},
		}
	})
	db = self.db.profile
	ndb = nibRealUI.db.profile
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(true)
	-- nibRealUI:RegisterPlainOptions(MODNAME, GetOptions)
	
	CreatePositioners()
end