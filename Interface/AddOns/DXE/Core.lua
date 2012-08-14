---------------------------------------------
-- DEFAULTS
---------------------------------------------

--[===[@debug@
local debug

local debugDefaults = {
	CheckForEngage = true,
	CombatStop = false,
	CHAT_MSG_MONSTER_YELL = false,
	RAID_ROSTER_UPDATE = false,
	PARTY_MEMBERS_CHANGED = false,
	BlockBossEmotes = false,
	TriggerDefeat = false,
	UNIT_NAME_UPDATE = false,
	INSTANCE_ENCOUNTER_ENGAGE_UNIT = true,
}
--@end-debug@]===]

local defaults = {
	global = {
		Locked = true,
		AdvancedMode = false,
		-- NPC id -> Localized name
		L_NPC = {},
		--[===[@debug@
		debug = debugDefaults,
		--@end-debug@]===]
		motd_read_v = false,
	},
	profile = {
		Enabled = true,
		Positions = {},
		Dimensions = {},
		Scales = {},
		Encounters = {},
		Globals = {
			BarTexture = "Blizzard",
			Font = "Franklin Gothic Medium",
			TimerFont = "Bastardus Sans",
			Border = "Blizzard Tooltip",
			BorderColor = {0.33,0.33,0.33,1},
			BorderEdgeSize = 8,
			BackgroundColor = {0,0,0,0.8},
			BackgroundInset = 2,
			BackgroundTexture = "Blizzard Tooltip"
		},
		Pane = {
			Show = true,
			Scale = 1,
			Width = 220,
			OnlyInRaid = false,
			OnlyInParty = false,
			OnlyInRaidInstance = false,
			OnlyInPartyInstance = false,
			OnlyIfRunning = false,
			OnlyOnMouseover = false,
			BarGrowth = "AUTOMATIC",
			FontColor = {1,1,1,1},
			TitleFontSize = 10,
			HealthFontSize = 12,
			NeutralColor = {0,0,1,1},
			LostColor = {0.66,0.66,0.66,1},
			BarSpacing = 0,
		},
		Misc = {
			BlockBossEmoteMessages = false,
			BlockRaidWarningMessages = false,
			BlockBossEmoteFrame = false,
			BlockRaidWarningFrame = false,
		},
		Windows = {
			TitleBarColor = {0,0,0.82,1},
			Proxtype = "RADAR",
		},
		Proximity = {
			AutoPopup = true,
			AutoHide = true,
			BarAlpha = 0.4,
			Range = 10,
			Delay = 0.05,
			ClassFilter = {['*'] = true},
			Invert = false,
			Dummy = false,
			Rows = 5,
			NameFontSize = 9,
			TimeFontSize = 9,
			NameOffset = -12,
			NameAlignment = "CENTER",
			TimeOffset = -12,
			IconPosition = "LEFT",
			DotSize = 12,
			RaidIcons = "REPLACE",
		},
		AlternatePower = {
			AutoPopup = true,
			AutoHide = true,
			BarAlpha = 0.4,
			Threshold = 1,
			Delay = 0.5, -- raised delay for less cpu pain
			ClassFilter = {['*'] = true},
			Invert = false,
			Dummy = false,
			Rows = 5,
			NameFontSize = 9,
			TimeFontSize = 9,
			NameOffset = -12,
			NameAlignment = "CENTER",
			TimeOffset = -12,
			IconPosition = "LEFT",
		},
		Sounds = {
			ALERT1 = "Bell Toll Alliance",
			ALERT2 = "Bell Toll Horde",
			ALERT3 = "Low Mana",
			ALERT4 = "Low Health",
			ALERT5 = "Zing Alarm",
			ALERT6 = "Wobble",
			ALERT7 = "Bottle",
			ALERT8 = "Lift Me",
			ALERT9 = "Neo Beep",
			ALERT10 = "PvP Flag Taken",
			ALERT11 = "Bad Press",
			ALERT12 = "Run Away",
			VICTORY = "FF1 Victory",
		},
		CustomSounds = {},
	},
}

---------------------------------------------
-- INITIALIZATION
---------------------------------------------

local addon = LibStub("AceAddon-3.0"):NewAddon("DXE","AceEvent-3.0","AceTimer-3.0","AceComm-3.0","AceSerializer-3.0")
_G.DXE = addon
addon.version = 635
addon:SetDefaultModuleState(false)
addon.callbacks = LibStub("CallbackHandler-1.0"):New(addon)
addon.defaults = defaults

---------------------------------------------
-- UPVALUES
---------------------------------------------

local wipe,remove,sort = table.wipe,table.remove,table.sort
local match,find,gmatch,sub = string.match,string.find,string.gmatch,string.sub
local _G,select,tostring,type,tonumber = _G,select,tostring,type,tonumber
local GetTime,GetNumRaidMembers,GetNumPartyMembers,GetRaidRosterInfo = GetTime,GetNumRaidMembers,GetNumPartyMembers,GetRaidRosterInfo
local UnitName,UnitGUID,UnitIsEnemy,UnitClass,UnitAffectingCombat,UnitHealth,UnitHealthMax,UnitIsFriend,UnitIsDead,UnitIsConnected =
		UnitName,UnitGUID,UnitIsEnemy,UnitClass,UnitAffectingCombat,UnitHealth,UnitHealthMax,UnitIsFriend,UnitIsDead,UnitIsConnected
local UnitInVehicle = UnitInVehicle
local rawget,unpack = rawget,unpack

local db,gbl,pfl

---------------------------------------------
-- LIBS
---------------------------------------------

local AceTimer = LibStub("AceTimer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("DXE")
local SM = LibStub("LibSharedMedia-3.0")
local LDS = LibStub("LibDualSpec-1.0",true)

-- Localized spell names
local SN = setmetatable({},{
	__index = function(t,k)
		if type(k) ~= "number" then return "nil" end
		local name = GetSpellInfo(k)
		t[k] = name
		if not name then
			geterrorhandler()("Invalid spell name attempted to be retrieved")
			return tostring(k)
		end
		return name
	end,
})

-- Spell textures - caching is unnecessary
local ST = setmetatable({},{
	__index = function(t,k)
		if type(k) ~= "number" then return "nil" end
		local texture = select(3,GetSpellInfo(k))
		if not texture then
			geterrorhandler()("Invalid spell texture attempted to be retrieved")
			return "Interface\\Buttons\\WHITE8X8"
		end
		return texture
	end,
})
-- Localized Encounter Journal Entries
-- Input: sectionID
-- Output: Localized name of section
local EJSN = setmetatable({},{
	__index = function(t,k)
		if type(k) ~= "number" then return "nil" end
		local name = select(1,EJ_GetSectionInfo(k))
		if not name then
			geterrorhandler()("Invalid EJ section attempted to be retrieved")
			return tostring(k)
		end
		return name
	end,
})
-- Encounter Journal textures
local EJST = setmetatable({},{
	__index = function(t,k)
		if type(k) ~= "number" then return "nil" end
		local texture = select(4,EJ_GetSectionInfo(k))
		if not texture then
			geterrorhandler()("Invalid spell texture attempted to be retrieved")
			return "Interface\\Buttons\\WHITE8X8"
		end
		return texture
	end,
})

-- NPC IDs
local GUID_LENGTH = 18
local UT_NPC = 3
local UT_VEHICLE = 5

-- 12484 is the version that China got the new format, so doing it this way works
-- for both China and 4.0.x
local NEW_GUID_FORMAT = tonumber((select(2,GetBuildInfo()))) >= 12484

local NID = setmetatable({},{
	__index = function(t,guid)
		if type(guid) ~= "string" or #guid ~= GUID_LENGTH or not guid:find("%xx%x+") then return end
		local ut = tonumber(sub(guid,5,5),16) % 8
		local isNPC = ut == UT_NPC or ut == UT_VEHICLE
		local npcid
		if NEW_GUID_FORMAT then
			npcid = isNPC and tonumber(sub(guid,7,10),16)
		else
			npcid = isNPC and tonumber(sub(guid,9,12),16)
		end
		t[guid] = npcid
		return npcid
	end,
})

-- Color name
local class_to_color = {}
for class,color in pairs(RAID_CLASS_COLORS) do
	class_to_color[class] = ("|cff%02x%02x%02x"):format(color.r * 255, color.g * 255, color.b * 255)
end

local CN = setmetatable({}, {__index =
	function(t, unit)
		local class = select(2,UnitClass(unit))
		if not class then return unit end
		local name = UnitName(unit)
		local prev = rawget(t,name)
		if prev then return prev end
		t[name] = class_to_color[class]..name.."|r"
		return t[name]
	end,
})

do
	local embeds = {
		L = L,
		LDS = LDS,
		SN = SN,
		NID = NID,
		CN = CN,
		SM = SM,
		ST = ST,
		EJSN = EJSN,
		EJST = EJST,
	}
	for k,v in pairs(embeds) do addon[k] = v end
end

---------------------------------------------
-- UTILITY
---------------------------------------------

local ipairs,pairs = ipairs,pairs

local util = {}
addon.util = util

local function tablesize(t)
	local n = 0
	for _ in pairs(t) do n = n + 1 end
	return n
end

local function search(t,value,i)
	for k,v in pairs(t) do
		if i then
			if type(v) == "table" and v[i] == value then return k end
		elseif v == value then return k end
	end
end

local function blend(c1, c2, factor)
	local r = (1-factor) * c1.r + factor * c2.r
	local g = (1-factor) * c1.g + factor * c2.g
	local b = (1-factor) * c1.b + factor * c2.b
	return r,g,b
end

local function safecall(func,...)
	local success,err = pcall(func,...)
	if not success then geterrorhandler()(err) end
	return success
end

util.tablesize = tablesize
util.search = search
util.blend = blend
util.safecall = safecall

---------------------------------------------
-- MODULES
---------------------------------------------

function addon:EnableAllModules()
	for name in self:IterateModules() do
		self:EnableModule(name)
	end
end

function addon:DisableAllModules()
	for name in self:IterateModules() do
		self:DisableModule(name)
	end
end

---------------------------------------------
-- PROXIMITY CHECKING
---------------------------------------------

do
	-- 18 yards
	local bandages = {
		[34722] = true, -- Heavy Frostweave Bandage
		[34721] = true, -- Frostweave Bandage
		[21991] = true, -- Heavy Netherweave Bandage
		[21990] = true, -- Netherweave Bandage
		[14530] = true, -- Heavy Runecloth Bandage
		[14529] = true, -- Runecloth Bandage
		[8545] = true, -- Heavy Mageweave Bandage
		[8544] = true, -- Mageweave Bandage
		[6451] = true, -- Heavy Silk Bandage
		[6450] = true, -- Silk Bandage
		[3531] = true, -- Heavy Wool Bandage
		[3530] = true, -- Wool Bandage
		[2581] = true, -- Heavy Linen Bandage
		[1251] = true, -- Linen Bandage
	}
	-- CheckInteractDistance(unit,i)
	-- 2 = Trade, 11.11 yards
	-- 3 = Duel, 9.9 yards
	-- 4 = Follow, 28 yards

	local IsItemInRange = IsItemInRange
	local knownBandage
	-- Keys refer to yards
	local ProximityFuncs = {
		[10] = function(unit) return CheckInteractDistance(unit,3) end,
		[11] = function(unit) return CheckInteractDistance(unit,2) end,
		[18] = function(unit)
			if knownBandage then
				return IsItemInRange(knownBandage,unit) == 1
			else
				for itemid in pairs(bandages) do
					if IsItemInRange(itemid,unit) == 1 then
						knownBandage = itemid
						return true
					end
				end
				-- default to 11
				return CheckInteractDistance(unit,2)
			end
		end,
		[28] = function(unit) return CheckInteractDistance(unit,4) end,
	}

	function addon:GetProximityFuncs()
		return ProximityFuncs
	end
end

function addon:ShowProximity()
	if pfl.Windows.Proxtype == "RADAR" then
		addon:Radar()
	else
		addon:Proximity()
	end
end

function addon:UpdateProximityProfile()
	if pfl.Windows.Proxtype == "RADAR" then
		addon:UpdateRadarSettings()
	else
		addon:UpdateProximitySettings()
	end
end

---------------------------------------------
-- RAID DIFFICULTY
---------------------------------------------

function addon:GetRaidDifficulty()
	local diff
	local _, type, index, _, _, heroic, dynamic = GetInstanceInfo()
	if type == "raid" then
		if dynamic then
			diff = index
			if heroic == 1 and diff <= 2 then
				diff = diff + 2
			end
		else
			diff = index
		end
	end
	return diff
end

---------------------------------------------
-- FUNCTION THROTTLING
---------------------------------------------

do
	-- Error margin added to ScheduleTimer to ensure it fires after the throttling period
	local _epsilon = 0.2
	-- @param _postcall A boolean determining whether or not the function is called
	-- 		           after the end of the throttle period if called during it. If this
	--					     is set to true the function should not be passing in arguments
	--         		     because they will be lost
	local function ThrottleFunc(_obj,_func,_time,_postcall)
		--[===[@debug@
		assert(type(_func) == "string","Expected _func to be a string")
		assert(type(_obj) == "table","Expected _obj to be a table")
		assert(type(_obj[_func]) == "function","Expected _obj[func] to be a function")
		assert(type(_time) == "number","Expected _time to be a number")
		assert(type(_postcall) == "boolean","Expected _postcall to be a boolean")
		assert(AceTimer.embeds[_obj],"Expected obj to be AceTimer embedded")
		--@end-debug@]===]
		local _old_func = _obj[_func]
		local _last,_handle = GetTime() - _time
		_obj[_func] = function(self,...)
			local _t = GetTime()
			if _last + _time > _t then
				if _postcall and not _handle then
					_handle = self:ScheduleTimer(_func,_last + _time - _t + _epsilon)
				end
				return
			end
			_last = _t
			self:CancelTimer(_handle,true)
			_handle = nil
			return _old_func(self,...)
		end
	end

	addon.ThrottleFunc = ThrottleFunc
end

---------------------------------------------
-- ENCOUNTER MANAGEMENT
-- Credits to RDX
---------------------------------------------
local EDB = {}
addon.EDB = EDB
-- Current encounter data
local CE
-- Received database
local RDB

local DEFEAT_NID
local DEFEAT_NIDS

local RegisterQueue = {}
local Initialized = false
function addon:RegisterEncounter(data)
	local key = data.key

	-- Convert version
	data.version = type(data.version) == "string" and tonumber(data.version:match("%d+")) or data.version

	-- Add to queue if we're not loaded yet
	if not Initialized then RegisterQueue[key] = data return end

	--[===[@debug@
	local success = safecall(self.ValidateData,self,data)
	if not success then return end
	--@end-debug@]===]

	-- Upgrading
	if RDB[key] and RDB[key] ~= data then
		if RDB[key].version <= data.version then
			local version = RDB[key].version
			RDB[key] = nil
			if version == data.version then
				-- Don't need to do anything
				return
			else
				self:UnregisterEncounter(key)
			end
		else
			-- RDB version is higher
			return
		end
	end

	-- Unregister before registering the same encounter
	if EDB[key] then error("Encounter "..key.." already exists - Requires unregistering") return end

	-- Only encounters with field key have options
	if key ~= "default" then
		self:AddEncounterDefaults(data)
		self:RefreshDefaults()
		self.callbacks:Fire("OnRegisterEncounter",data)
		self:UpdateTriggers()
	end

	EDB[key] = data
end

--- Remove an encounter previously added with RegisterEncounter.
function addon:UnregisterEncounter(key)
	if key == "default" or not EDB[key] then return end

	-- Swap to default if we're trying to unregister the current encounter
	if CE.key == key then self:SetActiveEncounter("default") end

	self:UpdateTriggers()
	self.callbacks:Fire("OnUnregisterEncounter",EDB[key])
	EDB[key] = nil
end

--- Get the name of the currently-active encounter
function addon:GetActiveEncounter()
	return CE and CE.key or "default"
end

function addon:SetCombat(flag,event,func)
	if flag then self:RegisterEvent(event,func) end
end

function addon:OpenWindows()
	local encdb = pfl.Encounters[CE.key]
	local proxdb = encdb and encdb.proxwindow
	-- proximity window
	if proxdb and proxdb.enabled then
		local range = proxdb.proxoverride and proxdb.proxrange
		if pfl.Windows.Proxtype == "RADAR" then
			self:Radar(true,range)
		else
			self:Proximity(true,range)
		end
	end
	-- alternate power bar window
	local apbdb = encdb and encdb.apbwindow
	if apbdb and apbdb.enabled then
		local threshold = apbdb.apboverride and apbdb.apbthreshold
		self:AlternatePower(true,range)
	end
end

do
	local frame = CreateFrame("Frame")
	local DEFEAT_YELL
	local DEFEAT_TBL = {}

	frame:SetScript("OnEvent",function(self,event,msg)
		if find(msg,DEFEAT_YELL) then addon:TriggerDefeat() end
	end)

	function addon:ResetDefeat()
		wipe(DEFEAT_TBL)
		DEFEAT_NID = nil
		DEFEAT_NIDS = nil
		DEFEAT_YELL = nil
		frame:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
	end

	function addon:ResetDefeatTbl()
		for k in pairs(DEFEAT_TBL) do DEFEAT_TBL[k] = false end
	end

	function addon:TriggerDefeat()
		self.callbacks:Fire("TriggerDefeat",CE)
		self:StopEncounter()
		PlaySoundFile(SM:Fetch("sound",pfl.Sounds.VICTORY))
		if pfl.Proximity.AutoHide then
			self:HideProximity()
			self:HideRadar()
		end
		--[===[@debug@
		debug("TriggerDefeat","key: %s",CE.key)
		--@end-debug@]===]
	end

	function addon:SetDefeat(defeat)
		if not defeat then return end
		if type(defeat) == "number" then
			DEFEAT_NID = defeat
		elseif type(defeat) == "string" then
			DEFEAT_YELL = defeat
		elseif type(defeat) == "table" then
			for k,v in ipairs(defeat) do
				if type(v) == "number" then
					DEFEAT_TBL[v] = false
				elseif type(v) == "string" then
					DEFEAT_YELL = v
				end
			end
			DEFEAT_NIDS = DEFEAT_TBL
		end

		if DEFEAT_YELL then frame:RegisterEvent("CHAT_MSG_MONSTER_YELL") end
	end
end

--- Change the currently-active encounter.
function addon:SetActiveEncounter(key)
	--[===[@debug@
	assert(type(key) == "string","String expected in SetActiveEncounter")
	--@end-debug@]===]
	-- Check the new encounter
	if not EDB[key] then return end
	-- Already set to this encounter
	if CE and CE.key == key then return end

	CE = EDB[key]
	addon.CE = CE

	self:SetTracerStart(false)
	self:SetTracerStop(false)

	self:StopEncounter()

	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	self:UnregisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")

	self.Pane.SetFolderValue(key)

	self:OpenWindows()

	self:CloseAllHW()
	self:ResetSortedTracing()

	self:ResetDefeat()

	if CE.onactivate then
		local oa = CE.onactivate
		self:SetTracerStart(oa.tracerstart)
		self:SetTracerStop(oa.tracerstop)

		-- Either could exist but not both
		self:SetSortedTracing(oa.sortedtracing)
		self:SetTracing(oa.tracing or oa.unittracing)

		self:SetCombat(oa.combatstop,"PLAYER_REGEN_ENABLED","CombatStop")
		self:SetCombat(oa.combatstart,"PLAYER_REGEN_DISABLED","CombatStart")

		self:SetDefeat(oa.defeat)
	end

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")

	-- For the empty encounter
	self:ShowFirstHW()
	self:LayoutHealthWatchers()
	self.callbacks:Fire("SetActiveEncounter",CE)
end

--Backup method to detect combat start (should eventually replace combatstart)
function addon:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	-- Get any boss' name
	local boss1 = UnitName("boss1")
	local boss2 = UnitName("boss2")
	local boss3 = UnitName("boss3")
	local boss4 = UnitName("boss4")

	--[===[@debug@
	debug("INSTANCE_ENCOUNTER_ENGAGE_UNIT","boss1-4: %s,%s,%s,%s",boss1,boss2,boss3,boss4)
	--@end-debug@]===]

	-- we have a correct active encounter so start the CE
	if (CE.name == boss1 or  CE.name == boss2 or CE.name == boss3 or CE.name == boss4) and not self:IsRunning() then
		self:StartEncounter()
		--[===[@debug@
		debug("INSTANCE_ENCOUNTER_ENGAGE_UNIT","CE %s was good and started",CE.name)
		--@end-debug@]===]
	-- we don't have a CE or wrong CE, so we need to compare the npcid from bossX to the scan ids in Encounters.lua
	elseif not self:IsRunning() and (CE.name ~= boss1 and CE.name ~= boss2 and CE.name ~= boss3 and CE.name ~= boss4) or not CE or CE.key == "default" then
		--[===[@debug@
		debug("INSTANCE_ENCOUNTER_ENGAGE_UNIT","no running and no CE")
		--@end-debug@]===]

		-- helper
		local function add_data(tbl,info,key)
			if type(info) == "table" then
				-- Info contains ids
				for _,id in ipairs(info) do
					tbl[id] = key
				end
			else
				-- Info is the id
				tbl[info] = key
			end
		end

		local id1,id2,id3,id4
		if boss1 then id1 = tonumber((UnitGUID("boss1")):sub(7, 10), 16) end
		if boss2 then id2 = tonumber((UnitGUID("boss2")):sub(7, 10), 16) end
		if boss3 then id3 = tonumber((UnitGUID("boss3")):sub(7, 10), 16) end
		if boss4 then id4 = tonumber((UnitGUID("boss4")):sub(7, 10), 16) end
		--[===[@debug@
		debug("INSTANCE_ENCOUNTER_ENGAGE_UNIT","ids1-4: %s %s %s %s",id1,id2,id3,id4)
		--@end-debug@]===]

		local EDBids = {}
		for key, data in addon:IterateEDB() do
			if data.triggers then
				local scan = data.triggers.scan
				if scan then
					add_data(EDBids,scan,key)
				end
			end
		end

		for k,v in pairs({id1,id2,id3,id4}) do
			if v then
				if EDBids[v] then
					local key = EDBids[v]
					--[===[@debug@
					debug("INSTANCE_ENCOUNTER_ENGAGE_UNIT","id found: %s, key: %s",v,key)
					--@end-debug@]===]
					self:SetActiveEncounter(key)
					self:StopEncounter()
					self:StartEncounter()
					return true
				end
			end
		end
	end
end

-- Start the current encounter
function addon:StartEncounter(...)
	if self:IsRunning() then return end
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self.callbacks:Fire("StartEncounter",...)
	self:StartTimer()
	self:StartSortedTracing()
	self:UpdatePaneVisibility()
	self:PauseScanning()
end

-- Stop the current encounter
function addon:StopEncounter()
	if not self:IsRunning() then return end
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self.callbacks:Fire("StopEncounter")
	self:ClearSortedTracing()
	self:StopSortedTracing()
	self:StopTimer()
	self:UpdatePaneVisibility()
	self:ResumeScanning()
	self:ResetDefeatTbl()
end

do
	local function iter(t,i)
		local k,v = next(t,i)
		if k == "default" then return next(t,k)
		else return k,v end
	end

	function addon:IterateEDB()
		return iter,EDB
	end
end

---------------------------------------------
-- ROSTER
---------------------------------------------
local Roster = {}
addon.Roster = Roster

local rID,pID = {},{}
for i=1,40 do
	rID[i] = "raid"..i
	if i <= 4 then
		pID[i] = "party"..i
	end
end

local targetof = setmetatable({},{
	__index = function(t,k)
		if type(k) ~= "string" then return end
		t[k] = k.."target"
		return t[k]
	end
})
addon.targetof = targetof

local refreshFuncs = {
	name_to_unit = function(t,id)
		t[UnitName(id)] = id
	end,
	guid_to_unit = function(t,id)
		local guid = id == "player" and addon.PGUID or UnitGUID(id)
		t[guid] = id
	end,
	unit_to_unittarget = function(t,id)
		t[id] = targetof[id]
	end,
	name_to_class = function(t,id)
		t[UnitName(id)] = select(2,UnitClass(id))
	end,
}

for k in pairs(refreshFuncs) do
	Roster[k] = {}
end

local numOnline = 0
local numMembers = 0
local prevGroupType = "NONE"
local RosterHandle
addon.GroupType = "NONE"
function addon:RAID_ROSTER_UPDATE()
	--[===[@debug@
	debug("RAID_ROSTER_UPDATE","Invoked")
	--@end-debug@]===]

	local tmpOnline,tmpMembers = 0,GetNumRaidMembers()
	if tmpMembers > 0 then
		addon.GroupType = "RAID"
	else
		tmpMembers = GetNumPartyMembers()
		addon.GroupType = tmpMembers > 0 and "PARTY" or "NONE"
	end

	-- Switches to default if we leave a group
	if prevGroupType ~= "NONE" and addon.GroupType == "NONE" then
		self:SetActiveEncounter("default")
	end
	prevGroupType = addon.GroupType

	if not RosterHandle and tmpMembers > 0 then
		-- Refresh roster tables every half minute to detect offline players
		RosterHandle = self:ScheduleRepeatingTimer("RAID_ROSTER_UPDATE",30)
	elseif tmpMembers == 0 then
		self:CancelTimer(RosterHandle,true)
		RosterHandle = nil
	end

	for k,t in pairs(Roster) do
		wipe(t)
		refreshFuncs[k](t,"player")
	end

	if addon.GroupType == "RAID" then
		for i=1,tmpMembers do
			local name, rank, _, _, _, _, _, online = GetRaidRosterInfo(i)
			if online then
				local unit = rID[i]
				tmpOnline = tmpOnline + 1
				for k,t in pairs(Roster) do
					refreshFuncs[k](t,unit)
				end
			end
		end
	elseif addon.GroupType == "PARTY" then
		for i=1,tmpMembers do
			local name,online = UnitName(pID[i]),UnitIsConnected(pID[i])
			if online then
				local unit = pID[i]
				--[===[@debug@
				debug("PARTY_MEMBERS_CHANGED","name: %s unit: %s guid: %s",name,unit,UnitGUID(unit))
				--@end-debug@]===]
				tmpOnline = tmpOnline + 1
				for k,t in pairs(Roster) do
					refreshFuncs[k](t,unit)
				end
			end
		end
	end

	--- Number of member differences

	if tmpMembers ~= numMembers then
		self:UpdatePaneVisibility()
		self:RefreshVersionList()
	end

	numMembers = tmpMembers

	--- Number of ONLINE member differences

	--[[
	if tmpOnline > numOnline then
	end
	]]

	if tmpOnline < numOnline then
		self:CleanVersions()
	end

	numOnline = tmpOnline
end

function addon:IsPromoted()
	return IsRaidLeader() or IsRaidOfficer()
end

function addon:VehicleNames()
	local names = {}
	for name in pairs(Roster.name_to_unit) do
		if UnitInVehicle(name) then
			names[#names+1] = name
		end
	end
	return names
end

---------------------------------------------
-- TRIGGERING
---------------------------------------------

local TRGS_NPCID = {} -- NPC ids activations. Source: data.triggers.scan
local TRGS_YELL = {} -- Yell activations. Source: data.triggers.yell

do
	local function add_data(tbl,info,key)
		if type(info) == "table" then
			-- Info contains ids
			for _,id in ipairs(info) do
				tbl[id] = key
			end
		else
			-- Info is the id
			tbl[info] = key
		end
	end

	local function BuildTriggerLists()
		local zone = GetRealZoneText()
		local scanFlag,yellFlag = false,false
		for key, data in addon:IterateEDB() do
			if data.zone == zone then
				if data.triggers then
					local scan = data.triggers.scan
					if scan then
						add_data(TRGS_NPCID,scan,key)
						scanFlag = true
					end
					local yell = data.triggers.yell
					if yell then
						add_data(TRGS_YELL,yell,key)
						yellFlag = true
					end
				end
			end
		end
		return scanFlag,yellFlag
	end

	local ScanHandle
	function addon:PauseScanning()
		if ScanHandle then self:CancelTimer(ScanHandle); ScanHandle = nil end
	end

	function addon:ResumeScanning()
		if not ScanHandle then ScanHandle = self:ScheduleRepeatingTimer("ScanUpdate",5) end
	end

	function addon:UpdateTriggers()
		-- Clear trigger tables
		wipe(TRGS_NPCID)
		wipe(TRGS_YELL)
		self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
		self:CancelTimer(ScanHandle,true)
		ScanHandle = nil
		-- Build trigger lists
		local scan, yell = BuildTriggerLists()
		self.TriggerZone = scan or yell
		-- Start invokers
		if scan then ScanHandle = self:ScheduleRepeatingTimer("ScanUpdate",5) end
		if yell then self:RegisterEvent("CHAT_MSG_MONSTER_YELL") end
	end
	addon:ThrottleFunc("UpdateTriggers",1,true)
end


function addon:Scan()
	for _,unit in pairs(Roster.unit_to_unittarget) do
		if UnitExists(unit) then
			local guid = UnitGUID(unit)
			local npcid = NID[guid]
			if TRGS_NPCID[npcid] and not UnitIsDead(unit) then
				return TRGS_NPCID[npcid]
			end
		end
	end
end

function addon:ScanUpdate()
	local key = self:Scan()
	if key then self:SetActiveEncounter(key) end
end

---------------------------------------------
-- PLAYER CONSTANTS
---------------------------------------------

function addon:SetPGUID(n)
	if n == 0 then return end
	self.PGUID = UnitGUID("player")
	if not self.PGUID then self:ScheduleTimer("SetPGUID",1,n-1) end
end

function addon:SetPlayerConstants()
	self.PGUID = UnitGUID("player")
	-- Just to be safe
	if not self.PGUID then self:ScheduleTimer("SetPGUID",1,5) end
	self.PNAME = UnitName("player")
end

---------------------------------------------
-- GENERIC EVENTS
---------------------------------------------

function addon:PLAYER_ENTERING_WORLD()
	self:UpdatePaneVisibility()
	self:UpdateTriggers()
	self:StopEncounter()
end

---------------------------------------------
-- WARNING BLOCKS
-- Credits: BigWigs
---------------------------------------------

local forceBlockDisable

function addon:AddMessageFilters()
	local OTHER_BOSS_MOD_PTN = "%*%*%*"
	local OTHER_BOSS_MOD_PTN2 = "DBM"
	local OTHER_BOSS_MOD_PTN3 = "<BW>"

	local RaidWarningFrame_OnEvent = RaidWarningFrame:GetScript("OnEvent")
	RaidWarningFrame:SetScript("OnEvent", function(self,event,msg,...)
		if not forceBlockDisable and pfl.Misc.BlockRaidWarningFrame and
			type(msg) == "string" and (find(msg,OTHER_BOSS_MOD_PTN) or find(msg,OTHER_BOSS_MOD_PTN2) or find(msg,OTHER_BOSS_MOD_PTN3))then
			-- Do nothing
		else
			return RaidWarningFrame_OnEvent(self,event,msg,...)
		end
	end)

	local RaidBossEmoteFrame_OnEvent = RaidBossEmoteFrame:GetScript("OnEvent")
	RaidBossEmoteFrame:SetScript("OnEvent", function(self,event,msg,name,...)
		if not forceBlockDisable and pfl.Misc.BlockBossEmoteFrame
			and type(name) == "string" and addon.TriggerZone then
			-- Do nothing
		else
			return RaidBossEmoteFrame_OnEvent(self,event,msg,name,...)
		end
	end)

	local function OTHER_BOSS_MOD_FILTER(self,event,msg)
		if not forceBlockDisable and pfl.Misc.BlockRaidWarningMessages
			and type(msg) == "string" and (find(msg,OTHER_BOSS_MOD_PTN) or find(msg,OTHER_BOSS_MOD_PTN2) or find(msg,OTHER_BOSS_MOD_PTN3)) then
			return true
		end
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", OTHER_BOSS_MOD_FILTER)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", OTHER_BOSS_MOD_FILTER)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", OTHER_BOSS_MOD_FILTER)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", OTHER_BOSS_MOD_FILTER)

	local function RAID_BOSS_FILTER(self,event,msg,name)
		if not forceBlockDisable and pfl.Misc.BlockBossEmoteMessages
			and type(name) == "string" and addon.TriggerZone then
			return true
		end
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_BOSS_EMOTE",RAID_BOSS_FILTER)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_BOSS_WHISPER",RAID_BOSS_FILTER)

	self.AddMessageFilters = nil
end

---------------------------------------------
-- MotD
---------------------------------------------
function addon:DisplayMOTD()
	local really = false
	if not really then return end

	local lastv = gbl.motd_read_v
	local motd_text = "This is the release version for Patch 4.3. All Dragon Soul encounters are included. Some timers may be incorrect due to changes from ptr to live.\n\n If you forcefully load the Dragon Soul encounter files before 4.3 is live, expect to see some errors."
	local motd = format("|cff99ff33DXE Information|r\n Welcome to DXE v%s.\n\n %s \n\n This message will only display once.",addon.version,motd_text)
	if not lastv or lastv < addon.version then
		StaticPopupDialogs["DXE_MOTD"] = {
		text = "%s",
		button1 = "ok",
		OnAccept = function()
			gbl.motd_read_v = addon.version
			return
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		}
		StaticPopup_Show("DXE_MOTD",motd)
	end
end

---------------------------------------------
-- MAIN
---------------------------------------------


-- Replace default Print
local print,format = print,string.format
function addon:Print(s)
	print(format("|cff99ff33DXE|r: %s",s)) -- 0.6, 1, 0.2
end

do
	local funcs = {}
	function addon:AddToRefreshProfile(func)
		--[===[@debug@
		assert(type(func) == "function")
		--@end-debug@]===]
		funcs[#funcs+1] = func
	end

	function addon:RefreshProfilePointers()
		for k,func in ipairs(funcs) do func(db) end
	end

	function addon:RefreshProfile()
		pfl = db.profile
		-- Has to go before pointers are refreshed
		self:LoadAllScales()
		self:LoadAllDimensions()

		self:RefreshProfilePointers()

		self:LoadAllPositions()
		self.Pane:SetScale(pfl.Pane.Scale)
		self:LayoutHealthWatchers()
		self:SkinPane()
		self:UpdatePaneVisibility()

		self[pfl.Enabled and "Enable" or "Disable"](self)
	end
end

-- Initialization
function addon:OnInitialize()
	Initialized = true

	-- Database
	self.db = LibStub("AceDB-3.0"):New("DXEDB",self.defaults)
	if LDS then LDS:EnhanceDatabase(self.db,"DXE") end
	db = self.db
	gbl,pfl = db.global,db.profile

	self:RefreshProfilePointers()

	-- Options
	db.RegisterCallback(self, "OnProfileChanged", "RefreshProfile")
	db.RegisterCallback(self, "OnProfileCopied", "RefreshProfile")
	db.RegisterCallback(self, "OnProfileReset", "RefreshProfile")

	--[===[@debug@
	debug = self:CreateDebugger("Core",gbl,debugDefaults)
	--@end-debug@]===]

	-- Received database
	RDB = self.db:RegisterNamespace("RDB", {global = {}}).global
	self.RDB = RDB

	-- Pane
	self:CreatePane()
	self:SkinPane()

	self:SetupSlashCommands()

	-- The default encounter
	self:RegisterEncounter({key = "default", name = L["Default"], title = L["Default"]})
	self:SetActiveEncounter("default")

	--[===[@debug@
	-- Register addon/received encounter data
	for key,data in pairs(RegisterQueue) do
		if RDB[key] and RDB[key].version > data.version then
			self:RegisterEncounter(RDB[key])
		else
			self:RegisterEncounter(data)
			RDB[key] = nil
		end

		RegisterQueue[key] = nil
	end
	--@end-debug@]===]

	-- The rest that don't exist
	for key,data in pairs(RDB) do
		-- nil out old RDB data that uses data.name as the key
		if key:find("[A-Z]") then
			RDB[key] = nil
		elseif not EDB[key] then
			self:RegisterEncounter(data)
		end
	end

	RegisterQueue = nil

	self:AddMessageFilters()

	self:SetEnabledState(pfl.Enabled)
	self:Print(L["Loaded - Type |cffffff00/dxe|r for slash commands"])
	self.OnInitialize = nil
end

function addon:OnEnable()
	-- Patch to refresh Pane texture
	self:NotifyAllMedia()

	forceBlockDisable = false
	self:SetPlayerConstants()
	self:UpdateTriggers()
	addon:UpdateLock()
	self:LayoutHealthWatchers()

	-- Events
	self:RegisterEvent("RAID_ROSTER_UPDATE")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED","RAID_ROSTER_UPDATE")
	self:RAID_ROSTER_UPDATE()
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA","UpdateTriggers")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	self:SetActiveEncounter("default")
	self:EnableAllModules()
	self:RegisterComm("DXE")
	self:UpdatePaneVisibility()
	self:BroadcastAllVersions()
	self:DisplayMOTD()
end

function addon:OnDisable()
	forceBlockDisable = true
	self:UpdateLockedFrames("Hide")
	self:StopEncounter()
	self:SetActiveEncounter("default")
	self.Pane:Hide()
	self:DisableAllModules()
	RosterHandle = nil
end

function addon:RefreshDefaults()
	self.db:RegisterDefaults(defaults)
end

---------------------------------------------
-- SCALES
---------------------------------------------

do
	local frameNames = {}

	function addon:SaveScale(f)
		pfl.Scales[f:GetName()] = f:GetScale()
	end

	-- Used after the profile is changed
	function addon:LoadAllScales()
		for name in pairs(frameNames) do
			self:LoadScale(name)
		end
	end

	function addon:LoadScale(name)
		local f = _G[name]
		if not f then return end
		frameNames[name] = true
		f:SetScale(pfl.Scales[name] or 1)
	end

	function addon:RegisterDefaultScale(f)
		defaults.profile.Scales[f:GetName()] = f:GetScale()
		self:RefreshDefaults()
	end
end

---------------------------------------------
-- DIMENSIONS
---------------------------------------------

do
	local frameNames = {}

	function addon:SaveDimensions(f)
		local name = f:GetName()
		local dims = pfl.Dimensions[name]
		dims.width = f:GetWidth()
		dims.height = f:GetHeight()
	end

	-- Used after the profile is changed
	function addon:LoadAllDimensions()
		for name in pairs(frameNames) do
			self:LoadDimensions(name)
		end
	end

	function addon:LoadDimensions(name)
		local f = _G[name]
		if not f then return end
		frameNames[name] = true
		local dims = pfl.Dimensions[name]
		if not dims then
			pfl.Dimensions[name] = {
				width = f:GetWidth(),
				height = f:GetHeight(),
			}
		else
			f:SetWidth(dims.width)
			f:SetHeight(dims.height)
		end
	end

	function addon:RegisterDefaultDimensions(f)
		local dims = {}
		dims.width = f:GetWidth()
		dims.height = f:GetHeight()
		defaults.profile.Dimensions[f:GetName()] = dims
		self:RefreshDefaults()
	end
end

---------------------------------------------
-- POSITIONING
---------------------------------------------

do
	local frameNames = {}

	function addon:SavePosition(f)
		local point, relativeTo, relativePoint, xOfs, yOfs = f:GetPoint()
		local name = f:GetName()
		local pos = pfl.Positions[name]
		pos.point = point
		pos.relativeTo = relativeTo and relativeTo:GetName()
		pos.relativePoint = relativePoint
		pos.xOfs = xOfs
		pos.yOfs = yOfs
		f:SetUserPlaced(false)
	end

	-- Used after the profile is changed
	function addon:LoadAllPositions()
		for name in pairs(frameNames) do
			self:LoadPosition(name)
		end
	end

	function addon:LoadPosition(name)
		local f = _G[name]
		if not f then return end
		frameNames[name] = true
		f:ClearAllPoints()
		local pos = pfl.Positions[name]
		if not pos then
			f:SetPoint("CENTER",UIParent,"CENTER",0,0)
			pfl.Positions[name] = {
				point = "CENTER",
				relativeTo = "UIParent",
				relativePoint = "CENTER",
				xOfs = 0,
				yOfs = 0,
			}
		else
			f:SetPoint(pos.point,_G[pos.relativeTo] or UIParent,pos.relativePoint,pos.xOfs,pos.yOfs)
		end
	end

	local function StartMovingShift(self)
		if IsShiftKeyDown() then
			if self.__redirect then
				self.__redirect:StartMoving()
			else
				self:StartMoving()
			end
		end
	end

	local function StartMoving(self)
		if self.__redirect then
			self.__redirect:StartMoving()
		else
			self:StartMoving()
		end
	end

	local function StopMoving(self)
		if self.__redirect then
			self.__redirect:StopMovingOrSizing()
			addon:SavePosition(self.__redirect)
		else
			self:StopMovingOrSizing()
			addon:SavePosition(self)
		end
	end

	-- Registers saving positions in database
	function addon:RegisterMoveSaving(frame,point,relativeTo,relativePoint,xOfs,yOfs,withShift,redirect)
		--[===[@debug@
		assert(type(frame) == "table","expected 'frame' to be a table")
		assert(frame.IsObjectType and frame:IsObjectType("Region"),"'frame' is not a blizzard frame")
		if redirect then
			assert(type(redirect) == "table","expected 'redirect' to be a table")
			assert(redirect.IsObjectType and redirect:IsObjectType("Region"),"'frame' is not a blizzard frame")
		end
		--@end-debug@]===]
		frame.__redirect = redirect
		if withShift then
			frame:SetScript("OnMouseDown",StartMovingShift)
		else
			frame:SetScript("OnMouseDown",StartMoving)
		end
		frame:SetScript("OnMouseUp",StopMoving)

		-- Add default position
		local pos = {
			point = point,
			relativeTo = relativeTo,
			relativePoint = relativePoint,
			xOfs = xOfs,
			yOfs = yOfs,
		}

		defaults.profile.Positions[redirect and redirect:GetName() or frame:GetName()] = pos
		self:RefreshDefaults()
	end
end

---------------------------------------------
-- TOOLTIP TEXT
---------------------------------------------

do
	local function OnEnter(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if self._ttTitle then GameTooltip:AddLine(self._ttTitle,nil,nil,nil,true) end
		if self._ttText then GameTooltip:AddLine(self._ttText,1,1,1,true) end
		GameTooltip:Show()
	end

	local function OnLeave(self)
		GameTooltip:Hide()
	end

	function addon:AddTooltipText(obj,title,text)
		obj._ttTitle = title
		obj._ttText = text
		obj:HookScript("OnEnter",OnEnter)
		obj:HookScript("OnLeave",OnLeave)
	end
end

---------------------------------------------
-- CONFIG
---------------------------------------------

function addon:ToggleConfig()
	if not addon.Options then
		if select(6,GetAddOnInfo("DXE_Options")) == "MISSING" then self:Print((L["Missing %s"]):format("DXE_Options")) return end
		if not IsAddOnLoaded("DXE_Options") then self.Loader:Load("DXE_Options") end
	end
	addon.Options:ToggleConfig()
end

---------------------------------------------
-- COMMS
---------------------------------------------

function addon:SendWhisperComm(target,commType,...)
	--[===[@debug@
	assert(type(target) == "string")
	assert(type(commType) == "string")
	--@end-debug@]===]
	self:SendCommMessage("DXE",self:Serialize(commType,...),"WHISPER",target)
end

function addon:SendRaidComm(commType,...)
	--[===[@debug@
	assert(type(commType) == "string")
	--@end-debug@]===]
	if addon.GroupType == "NONE" then return end
	self:SendCommMessage("DXE",self:Serialize(commType,...),addon.GroupType)
end

function addon:OnCommReceived(prefix, msg, dist, sender)
	if (dist ~= "RAID" and dist ~= "PARTY" and dist ~= "WHISPER") or sender == self.PNAME then return end
	if (dist == "RAID" or dist == "WHISPER") and find(msg,"^DXEVersionRequest") then
		self:WhisperAddonVersion(sender)
	end
	self:DispatchComm(sender, self:Deserialize(msg))
end

function addon:DispatchComm(sender,success,commType,...)
	if success then
		local callback = "OnComm"..commType
		self.callbacks:Fire(callback,commType,sender,...)
	end
end

function addon:WhisperAddonVersion(target)
	local msg = format("DXEVersionReply:%s",tostring(addon.version))
	self:SendCommMessage("DXE",msg,"WHISPER",target)
end

---------------------------------------------
-- ENCOUNTER DEFAULTS
---------------------------------------------

do
	local EncDefaults = {
		alerts = {
			L = L["Bars"],
			order = 100,
			defaultEnabled = true ,
			defaults = {
				color1 = "Clear",
				color2 = "Off",
				sound = "None",
				flashscreen = false,
				counter = false,
				flashtime = 5,
				audiocd = false,
			},
		},
		raidicons = {
			L = L["Raid Icons"],
			order = 200,
			defaultEnabled = true,
			defaults = {},
		},
		arrows = {
			L = L["Arrows"],
			order = 300,
			defaultEnabled = true,
			defaults = {
				sound = "None",
			},
		},
		announces = {
			L = L["Announces"],
			order = 400,
			defaultEnabled = true,
			defaults = {},
		},

		-- always add options
		windows = {
			L = L["Windows"],
			order = 500,
			override = true,
			list = {
				proxwindow = {
					defaultEnabled = false,
					varname = L["Proximity"],
					options = {
						-- var => default value
						proxoverride = false,
						proxrange = 10,
					},
				},
				apbwindow = {
					defaultEnabled = false,
					varname = L["Alternate Power"],
					options = {
						-- var => default value
						apboverride = false,
						apbthreshold = 10,
					},
				},
			}
		}
	}

	addon.EncDefaults = EncDefaults

	function addon:AddEncounterDefaults(data)
		local defaults = {}
		self.defaults.profile.Encounters[data.key] = defaults

		------------------------------------------------------------
		-- Sound upgrading from versions < 375
		if pfl.Encounters[data.key] then
			for var,info in pairs(pfl.Encounters[data.key]) do
				if type(info) == "table" then
					if info.sound and info.sound:find("^DXE ALERT%d+") then
						info.sound = (info.sound:gsub("DXE ",""))
					end
				elseif type(info) == "boolean" then
					-- It should never be a boolean
					pfl.Encounters[data.key][var] = nil
				end
			end
		end
		------------------------------------------------------------

		for optionType,optionInfo in pairs(EncDefaults) do
			local optionData = data[optionType]
			if optionData and not optionInfo.override then
				for var,info in pairs(optionData) do
					defaults[var] = {}
					-- Add setting defaults
					defaults[var].enabled = optionInfo.defaultEnabled

					----------------------------------------------------
					-- Special case
					-- When an alert with type 'simple' is changed to 'centerpopup', color1 can get "stuck" on 'Clear'
					-- Reset color1 if this happens
					if optionType == "alerts" then
						local db = pfl.Encounters[data.key]
						if db and db[var]
							and (info.type == "centerpopup" or info.type == "dropdown")
							and db[var].color1 == "Clear" then
							db[var].color1 = nil
						end
					end
					----------------------------------------------------
					for k,varDefault in pairs(EncDefaults[optionType].defaults) do
						defaults[var][k] = info[k] or varDefault
					end
				end
			end
		end

		for var,winData in pairs(EncDefaults.windows.list) do
			defaults[var] = {}
			if data.windows and data.windows[var] then
				defaults[var].enabled = data.windows[var]
			else
				defaults[var].enabled = winData.defaultEnabled
			end

			-- options
			if winData.options then
				for optvar,value in pairs(winData.options) do
					if data.windows and data.windows[optvar] then
						defaults[var][optvar] = data.windows[optvar]
					else
						defaults[var][optvar] = value
					end
				end
			end
		end
	end
end

---------------------------------------------
-- REGEN START/STOPPING
---------------------------------------------

do
	local dead
	local started = 0
	-- PLAYER_REGEN_ENABLED
	function addon:CombatStop()
		--[===[@debug@
		debug("CombatStop","Invoked")
		--@end-debug@]===]
		if UnitHealth("player") > 0 and not UnitAffectingCombat("player") then
			-- If this doesn't work then scan the raid for units in combat
			if dead then
				self:ScheduleTimer("CombatStop",4)
				dead = nil
				return
			end
			local key = self:Scan()
			if not key then
				-- Shouldn't wipe in less than 4 seconds after engaging
				if GetTime() > started + 4 then
					self:StopEncounter()
				else
					self:ScheduleTimer("CombatStop",5)
				end
				return
			end
			self:ScheduleTimer("CombatStop",2)
		elseif UnitIsDead("player") then
			dead = true
			self:ScheduleTimer("CombatStop",2)
		end
	end

	-- PLAYER_REGEN_DISABLED
	function addon:CombatStart()
		local key = self:Scan()
		if key then
			started = GetTime()
			self:StartEncounter()
		elseif UnitAffectingCombat("player") then
			self:ScheduleTimer("CombatStart", 0.2)
		end
	end
end

---------------------------------------------
-- SHARED EVENTS
---------------------------------------------

local weare42 = tonumber((select(4, GetBuildInfo()))) > 40100
function addon:COMBAT_LOG_EVENT_UNFILTERED(_, _,eventtype, _, ...)
	if eventtype ~= "UNIT_DIED" then return end
	local dstGUID
	if weare42 then
		dstGUID = select(5, ...)
	else
		dstGUID = select(4, ...)
	end

	local npcid = NID[dstGUID]
	if not npcid then return end

	-- Update HWs
	self:HWDead(npcid)

	if not DEFEAT_NID then return end
	if DEFEAT_NID == npcid then
		addon:TriggerDefeat()
	elseif DEFEAT_NIDS and DEFEAT_NIDS[npcid] == false then
		DEFEAT_NIDS[npcid] = true
		local flag = true
		for k,v in pairs(DEFEAT_NIDS) do
			if not v then flag = false; break end
		end
		if flag then addon:TriggerDefeat() end
	end
end


function addon:CHAT_MSG_MONSTER_YELL(_,msg,...)
	if self:IsRunning() then return end
	--[===[@debug@
	debug("CHAT_MSG_MONSTER_YELL",msg,...)
	--@end-debug@]===]
	for fragment,key in pairs(TRGS_YELL) do
		if find(msg,fragment) then
			self:SetActiveEncounter(key)
			self:StopEncounter()
			self:StartEncounter(msg)
		end
	end
end

---------------------------------------------
-- SLASH COMMANDS
---------------------------------------------

function addon:SetupSlashCommands()
	DXE_SLASH_HANDLER = function(msg)
		local cmd = msg:match("[^ ]*"):lower()
		if cmd == L["enable"]:lower() then
			addon.db.profile.Enabled = true
			addon:Enable()
			local ACR = LibStub("AceConfigRegistry-3.0",true)
			if ACR then ACR:NotifyChange("DXE") end
		elseif cmd == L["disable"]:lower() then
			addon.db.profile.Enabled = false
			addon:Disable()
			local ACR = LibStub("AceConfigRegistry-3.0",true)
			if ACR then ACR:NotifyChange("DXE") end
		elseif cmd == L["config"]:lower() then
			addon:ToggleConfig()
		elseif cmd == L["version"]:lower() then
			addon:VersionCheck()
		elseif cmd == L["proximity"]:lower() then
			addon:ShowProximity()
		else
			ChatFrame1:AddMessage("|cff99ff33"..L["DXE Slash Commands"].."|r: |cffffff00/dxe|r |cffffd200<"..L["option"]..">|r")
			ChatFrame1:AddMessage(" |cffffd200"..L["enable"].."|r - "..L["Enable addon"])
			ChatFrame1:AddMessage(" |cffffd200"..L["disable"].."|r - "..L["Disable addon"])
			ChatFrame1:AddMessage(" |cffffd200"..L["config"].."|r - "..L["Toggles configuration"])
			ChatFrame1:AddMessage(" |cffffd200"..L["version"].."|r - "..L["Show version check window"])
			ChatFrame1:AddMessage(" |cffffd200"..L["proximity"].."|r - "..L["Show proximity window"])
		end
	end
	self.SetupSlashCommands = nil
end
