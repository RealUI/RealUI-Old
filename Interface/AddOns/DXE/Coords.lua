local addon = DXE

local MapDims
local sort = table.sort
local GetPlayerMapPosition = GetPlayerMapPosition
local SetMapToCurrentZone = SetMapToCurrentZone
local GetCurrentMapDungeonLevel = GetCurrentMapDungeonLevel
local GetMapInfo = GetMapInfo

function addon:GetPlayerMapPosition(unit)
	local x,y = GetPlayerMapPosition(unit)
	if x <= 0 and y <= 0 then
		SetMapToCurrentZone()
		x,y = GetPlayerMapPosition(unit)
	end
	return x,y
end

-- Computes the distance between the player and unit in game yards
-- Intended to be used when the player and unit are in the same map
-- Supported: Ulduar, Naxxramas, The Eye of Eternity, The Obsidian Sanctum, Trial of the Crusader
function addon:GetDistanceToUnit(unit,fx2,fy2)
	local x1,y1 = self:GetPlayerMapPosition("player")
	local x2,y2

	local list = MapDims[GetMapInfo()]
	if not list then return end
	local level = GetCurrentMapDungeonLevel()
	local dims = list[level]
	if not dims then
		-- Zoning in and out will set the dungeon level to 0 so
		-- we need some special handling to get to the dungeon
		-- level we want
		if level == 0 and list[1] then
			SetMapToCurrentZone()
			level = GetCurrentMapDungeonLevel()
			dims = list[level]
			if not dims then return end
		else return end
	end

	if fx2 and fy2 then
		x2,y2 = fx2,fy2
	else
		x2,y2 = self:GetPlayerMapPosition(unit)
	end

	local dx = (x2 - x1) * dims.w
	local dy = (y2 - y1) * dims.h

	return (dx*dx + dy*dy)^(0.5),dx,dy -- dx*dx is faster than dx^2
end

local function comp(a,b)
	return addon:GetDistanceToUnit(a) < addon:GetDistanceToUnit(b)
end

-- @param units an array of units
function addon:FindClosestUnit(units)
	sort(units,comp)
	return units[1]
end

-------------------------
-- MAP DIMENSIONS
-------------------------

MapDims= {
	Ulduar = {
		[1] = {w = 3064.9614761023, h = 2039.5413309668}, 	-- Expedition Base Camp
		[2] = {w = 624.19069622949, h = 415.89374357805}, 	-- Antechamber of Ulduar
		[3] = {w = 1238.37427179,   h = 823.90183235628}, 	-- Conservatory of Life
		[4] = {w = 848.38069183829, h = 564.6688835337}, 	-- Prison of Yogg-Saron
		[5] = {w = 1460.4694647684, h = 974.65312886234},  -- Spark of Imagination
		[6] = {w = 576.71549337896, h = 384.46653291368},  -- The Mind's Eye (Under Yogg)
	},
	Naxxramas = {
		[1] = {w = 1018.3655494957, h = 679.40523953718}, -- Construct
		[2] = {w = 1019.1310739251, h = 679.18864376555}, -- Arachnid
		[3] = {w = 1118.1083638787, h = 744.57895516418}, -- Military
		[4] = {w = 1117.0809918236, h = 745.97398439776}, -- Plague
		[5] = {w = 1927.3190541014, h = 1284.6530841959}, -- Entrance
		[6] = {w = 610.62737087301, h = 407.3875157986},  -- KT/Sapphiron
	},
	TheObsidianSanctum = {
		[0] = {w = 1081.6334214432, h = 721.79860069158},
	},
	TheEyeofEternity = {
		[1] = {w = 400.728405332355, h = 267.09113174487},
	},
	TheArgentColiseum = {
		[1] = {w = 344.20785972537, h = 229.57961178118},
		[2] = {w = 688.60679691348, h = 458.95801567569},
	},
	VaultofArchavon = {
		[1] = {w = 842.2254908359, h = 561.59878021123},
	},
	IcecrownCitadel = {
		[1] = {w = 1262.8025621533, h = 841.91669450207}, -- The Lower Citadel
		[2] = {w = 993.25701607873, h = 662.58829476644}, -- The Rampart of Skulls
		[3] = {w = 181.83564716405, h = 121.29684810833}, -- Deathbringer's Rise
		[4] = {w = 720.60965618252, h = 481.1621506613},  -- The Frost Queen's Lair
		[5] = {w = 1069.6156745738, h = 713.83371679543}, -- The Upper Reaches
		[6] = {w = 348.05218433541, h = 232.05964286208}, -- Royal Quarters
		[7] = {w = 272.80314344785, h = 181.89449398676}, -- The Frozen Throne
	},
	TheRubySanctum = {
		[0] = {w = 752.083, h = 502.09}, -- The Ruby Sanctumn
	},
    -- Credits to: http://kle.klguild.org
    TheBastionofTwilight = {
        [1] = { w = 1078.33402252197, h = 718.889984130859}, -- LibMapData, Halfus + Dragons
        [2] = { w = 778.343017578125, h = 518.894958496094}, -- LibMapData, Council + Cho'gall
        [3] = { w = 1042.34202575684, h = 694.894958496094}, -- LibMapData, Sinestra
        },
    BlackwingDescent = {
        [1] = { w = 849.69401550293, h = 566.462341070175}, -- LibMapData
        [2] = { w = 999.69297790527, h = 666.462005615234}, -- LibMapData
        },
    ThroneoftheFourWinds = {
        -- I am aware that there is only 1 entry here. However throne returns a 1 not a zero when getting num levels.
        [1] = { w = 1514.534846, h = 1080.831578}, -- IsItemInRange
        --[1] = {w = 1500.0, h = 1000.0}, -- LibMapData
    },
	Firelands = {
		[1] = { w = 1587.49993896484, h = 1058.3332824707}, -- The Firelands
		[2] = { w = 375.0, h = 250.0}, -- Anvil of Conflagration
		[3] = { w = 1440.0, h = 960}, -- Sulfron Keep
	},
	DragonSoul = {
		[1] = { w = 3106.7084960938, h = 2063.0651855469},
		[2] = { w = 397.49887572464, h = 264.99992263558},
		[3] = { w = 427.50311666243, h = 285.00046747363},
		[4] = { w = 185.19921875, h = 123.466796875},
		[5] = { w = 1.5, h = 1},
		[6] = { w = 1.5, h = 1},
		[7] = { w = 1108.3515625, h = 738.900390625},
	}, -- thanks libmapdata
	--[===[@debug@
	Ironforge = {
		[0] = {w = 790.574581, h = 527.049720},
	},
	CrystalsongForest = {
		[0] = {h = 1690.7871577616, w = 2535.2561460507 }, -- IsSpellInRange
		--[0] = {h= 1814.590295101352, w= 2722.916513743646}, -- map data
	},
	SholazarBasin = {
		[0] = {h = 2706.6519588552, w = 4058.5947384336}, -- IsSpellInRange
		--[0] = {h = 2904.178067737769, w = 4356.249510482578}, -- map data
	},
	DunMorogh = {
		[0] = {h = 3283.346244075043, w = 4925.000979131685}, -- IsSpellInRange
		--[0] = {h = 3061.074929413, w = 4606.3254134678}, -- game engine
	},
	--@end-debug@]===]
}
