-- Many of the IDs were verified on live & beta, but some are interpolated.

local MAJOR, MINOR = "LibReforgingInfo-1.0", 3

local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end


-- offset is the id of the spirit -> dodge reforge
-- this is the value used in 4.0.3a.
local offset = 113

local SPI = 1
local DODGE = 2
local PARRY = 3
local HIT = 4
local CRIT = 5
local HASTE = 6
local EXP = 7
local MASTERY = 8

-- Array of long stat names. Index = number returned by GetReforgedStatIDs.
lib.StatNames = {
	ITEM_MOD_SPIRIT_SHORT,
	ITEM_MOD_DODGE_RATING_SHORT,
	ITEM_MOD_PARRY_RATING_SHORT,
	ITEM_MOD_HIT_RATING_SHORT,
	ITEM_MOD_CRIT_RATING_SHORT,
	ITEM_MOD_HASTE_RATING_SHORT,
	ITEM_MOD_EXPERTISE_RATING_SHORT,
	ITEM_MOD_MASTERY_RATING_SHORT
}

-- Array of short stat names. Index = number returned by GetReforgedStatIDs.
lib.ShortStatNames = {
	ITEM_MOD_SPIRIT_SHORT,
	STAT_DODGE,
	STAT_PARRY,
	ITEM_MOD_HIT_RATING_SHORT,
	ITEM_MOD_CRIT_RATING_SHORT,
	STAT_HASTE,
	STAT_EXPERTISE,
	STAT_MASTERY
}

-- List of all possible reforgings.
-- First entry has id <offset>, so the order is important!
-- Each entry has the form {decreased stat, increased stat}
local reforgeIDs = {
	{SPI, DODGE},
	{SPI, PARRY},
	{SPI, HIT},
	{SPI, CRIT},
	{SPI, HASTE},
	{SPI, EXP},
	{SPI, MASTERY},
	
	{DODGE, SPI},
	{DODGE, PARRY},
	{DODGE, HIT},
	{DODGE, CRIT},
	{DODGE, HASTE},
	{DODGE, EXP},
	{DODGE, MASTERY},
	
	{PARRY, SPI},
	{PARRY, DODGE},
	{PARRY, HIT},
	{PARRY, CRIT},
	{PARRY, HASTE},
	{PARRY, EXP},
	{PARRY, MASTERY},
	
	{HIT, SPI},
	{HIT, DODGE},
	{HIT, PARRY},
	{HIT, CRIT},
	{HIT, HASTE},
	{HIT, EXP},
	{HIT, MASTERY},
	
	{CRIT, SPI},
	{CRIT, DODGE},
	{CRIT, PARRY},
	{CRIT, HIT},
	{CRIT, HASTE},
	{CRIT, EXP},
	{CRIT, MASTERY},
	
	{HASTE, SPI},
	{HASTE, DODGE},
	{HASTE, PARRY},
	{HASTE, HIT},
	{HASTE, CRIT},
	{HASTE, EXP},
	{HASTE, MASTERY},
	
	{EXP, SPI},
	{EXP, DODGE},
	{EXP, PARRY},
	{EXP, HIT},
	{EXP, CRIT},
	{EXP, HASTE},
	{EXP, MASTERY},
	
	{MASTERY, SPI},
	{MASTERY, DODGE},
	{MASTERY, PARRY},
	{MASTERY, HIT},
	{MASTERY, CRIT},
	{MASTERY, HASTE},
	{MASTERY, EXP},
}

-- Returns information about the reforging with the given id.
-- Returns numbers for the stats.
-- @param id Reforging ID as returned by GetReforgeID
-- @return decreased stat number, increased stat number
function lib:GetReforgedStatIDs(id)
	local rid = id - offset + 1
	local info = reforgeIDs[rid]
	if info then
		return info[1], info[2]
	else
		return nil, nil
	end
end

-- Returns information about the reforging with the given id.
-- Returns long stat names.
-- @param id Reforging ID as returned by GetReforgeID
-- @return decreased stat name, increased stat name
function lib:GetReforgedStatNames(id)
	local minus, plus = lib:GetReforgedStatIDs(id)
	if minus and plus then
		return lib.StatNames[minus], lib.StatNames[plus]
	else
		return nil, nil
	end
end

-- Returns information about the reforging with the given id.
-- Returns short stat names.
-- @param id Reforging ID as returned by GetReforgeID
-- @return decreased stat name, increased stat name
function lib:GetReforgedStatShortNames(id)
	local minus, plus = lib:GetReforgedStatIDs(id)
	if minus and plus then
		return lib.ShortStatNames[minus], lib.ShortStatNames[plus]
	else
		return nil, nil
	end
end

-- Extracts the Reforging ID from the item string or item link.
-- @param itemString An item string or item link
-- @return The reforging ID if the item is reforged, nil otherwise
function lib:GetReforgeID(itemString)
	local id = tonumber(itemString:match("item:%d+:%d+:%d+:%d+:%d+:%d+:%-?%d+:%-?%d+:%d+:(%d+)"))
	return (id ~= 0) and id or nil
end

-- Checks if the given item is reforged
-- @param itemString An item string or item link
-- @return true if the item is reforged, false otherwise
function lib:IsItemReforged(itemString)
	local id = lib:GetReforgeID(itemString)
	return id ~= nil
end
