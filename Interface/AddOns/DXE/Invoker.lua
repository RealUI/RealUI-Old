--[[
	The invoker executes commands in encounter data

	Terminology:

	A command line is every sequential pair of values (1,2), (3,4), (5,6), etc. in a command list
	A command list is an array of command lines
	A command bundle is an array of command lists

	Valid commands are:
		expect 				= {"<token or value> ... <token_n or value_n>","<op>","<token' or value'> ... <token_n' or value_n'>"}
		quash 				= "<alert>"
		set 					= {<var> = <token or value>, ..., <var_n> = <token_n or value_n> }
		alert 				= "<alert>"
		scheduletimer	   = {"<timer>",<token or number>}
		canceltimer 		= "<timer>"
		resettimer 			= [BOOLEAN]
		tracing 				= {<name>,...,<name_n>}
		unittracing		= {"boss1",...,"boss4"}
		proximitycheck 	= {"<token>",[10,11,18, or 28]}
		outproximitycheck	= {"<token>",[10,11,18, or 28]}
		raidicon 			= "<raidicon>"
		removeraidicon    = "<token>"
		arrow 				= "<arrow>"
		removearrow 		= "<token>"
		removeallarrows	= [BOOLEAN]
		invoke            = command bundle
		defeat            = [BOOLEAN]
		insert            = {"<userdata>", value},
		wipe              = "<userdata>"
		batchalert        = {"<alert>",...,"<alert_n>"}
		batchquash        = {"<alert>",...,"<alert_n>"}
		quashall          = [BOOLEAN]
		schedulealert     = {"<alert>",<token or number>}
		repeatalert       = {"<alert>",<token or number>}
		cancelalert       = "<alert>"
]]

local addon = DXE
local L = addon.L
local NID = addon.NID
local SN = addon.SN
local unit_to_unittarget = addon.Roster.unit_to_unittarget
local targetof = addon.targetof

local GetTime = GetTime
local wipe,concat = table.wipe,table.concat
local type,next,select = type,next,select
local ipairs,pairs,unpack = ipairs,pairs,unpack
local tostring,tonumber = tostring,tonumber
local band,bor = bit.band,bit.bor
local match,gmatch,gsub,find,split = string.match,string.gmatch,string.gsub,string.find,string.split
local UnitGUID, UnitName, UnitExists, UnitIsUnit = UnitGUID, UnitName, UnitExists, UnitIsUnit
local UnitBuff,UnitDebuff = UnitBuff,UnitDebuff

local pfl,key,CE,alerts,raidicons,arrows,announces

local function RefreshProfile(db) pfl = db.profile end
addon:AddToRefreshProfile(RefreshProfile)

-- Temp variable environment
local userdata = {}

-- Command line handlers
local handlers = {}

---------------------------------------------
-- TABLE POOL
---------------------------------------------

local cache = {}
setmetatable(cache,{__mode = "k"})
local new = function()
	local t = next(cache)
	if t then
		cache[t] = nil
		return t
	else
		return {}
	end
end

local del = function(t)
	wipe(t)
	cache[t] = true
	return nil
end

---------------------------------------------
-- INITIALIZATION
---------------------------------------------

local module = addon:NewModule("Invoker","AceEvent-3.0","AceTimer-3.0")

addon.Invoker = module
local HW = addon.HW
local Alerts = addon.Alerts
local Arrows = addon.Arrows
local RaidIcons = addon.RaidIcons
-- command bundles executed upon events
local event_to_bundle = {}
local eventtype_to_bundle = {}
local combatbundle_to_filter = {}
local eventbundle_to_filter = {}

--[===[@debug@
local debug

local debugDefaults = {
	-- Related to function names
	Alerts = true,
	REG_EVENT = false,
	["handlers.set"] = false,
	replace_funcs = false,
	insert = false,
	tabinsert = true,
	tabupdate = true,
	wipe = false,
	wipe_container = false,
	["target.bossunit"] = false,
	["target.OBJECT_TARGET"] = false,
	["target.OBJECT_FOCUS"] = false,
	["target.StartPolling"] = false,
	["target.TeardownTarget"] = false,
	["target.failsafe"] = false,
	["target.scan"] = false,
	["target.try"] = false,
	["target.UNIT_TARGET"] = false,
	["target.fire"] = false,
}

--@end-debug@]===]

function module:OnInitialize()
	addon.RegisterCallback(self,"SetActiveEncounter","OnSet")
	addon.RegisterCallback(self,"StartEncounter","OnStart")
	addon.RegisterCallback(self,"StopEncounter","OnStop")

	--[===[@debug@
	self.db = addon.db:RegisterNamespace("Invoker", {
		global = {
			debug = debugDefaults
		},
	})

	debug = addon:CreateDebugger("Invoker",self.db.global,debugDefaults)
	--@end-debug@]===]
end

---------------------------------------------
-- EVENT TUPLES
---------------------------------------------

local tuple = {}

local function SetTuple(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16)
	tuple['1']  = a1  or "nil"
	tuple['2']  = a2  or "nil"
	tuple['3']  = a3  or "nil"
	tuple['4']  = a4  or "nil"
	tuple['5']  = a5  or "nil"
	tuple['6']  = a6  or "nil"
	tuple['7']  = a7  or "nil"
	tuple['8']  = a8  or "nil"
	tuple['9']  = a9  or "nil"
	tuple['10'] = a10 or "nil"
	tuple['11'] = a11 or "nil"
	tuple['12'] = a12 or "nil"
	tuple['13'] = a13 or "nil"
	tuple['14'] = a14 or "nil"
	tuple['15'] = a15 or "nil"
	tuple['16'] = a16 or "nil"

end

---------------------------------------------
-- CONTROLS
---------------------------------------------

function module:OnStart(_,...)
	if not CE then return end
	if next(eventtype_to_bundle) then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED","COMBAT_EVENT")
	end
	for event in pairs(event_to_bundle) do
		self:RegisterEvent(event,"REG_EVENT")
	end
	addon:SetTracing(CE.onactivate.tracing)
	-- Reset colors if not acquired
	for i,hw in ipairs(HW) do
		if hw:IsOpen() and not hw.tracer:First() then
			hw:SetInfoBundle("",1,1)
			hw:ApplyNeutralColor()
		end
	end
	if CE.onstart then
		self:InvokeCommands(CE.onstart,...)
	end
	if CE.enrage then
		self:Enrage(CE.enrage)
	end
end

function module:OnStop()
	if not CE then return end
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	for event in pairs(event_to_bundle) do
		self:UnregisterEvent(event)
	end
	self:ResetUserData()
	Alerts:QuashByPattern("^invoker")
	Arrows:RemoveAll()
	RaidIcons:RemoveAll()
	--self:TeardownTarget()
	self:RemoveAllTimers()
	self:ResetAlertData()
end

---------------------------------------------
-- ENRAGE HANDLER
---------------------------------------------
--[[
	Syntax in Encounters.lua:
	local data = {
		...
		enrage = {
			time10n = 600,
			time25n = 600,
			time10h = 600,
			time25h = 600,
		},
		...
	},
]]

do
	local diff_to_key = {
		[1] = "time10n",
		[2] = "time25n",
		[3] = "time10h",
		[4] = "time25h",
	}
	function module:Enrage(info)
		if not info then return end
		local diff = addon:GetRaidDifficulty()
		local key = diff_to_key[diff]

		local time = info[key] or nil
		local text = select(1, GetSpellInfo(8599))
		local icon = "Interface\\Icons\\Spell_Shadow_UnholyFrenzy"

		if time and time > 0 then
			Alerts:Dropdown("invoker_enrage",text,time,15,nil,"RED",nil,nil,icon)
		end
	end
end

---------------------------------------------
-- REPLACES
---------------------------------------------

local ReplaceTokens

local function next_series_value(series,key)
	local ix,n = key.."_index",#series
	local i = userdata[ix]
	if i > n and not series.loop then
		i = n
	else
		i = ((i-1)%n)+1 -- Handles looping
		userdata[ix] = userdata[ix] + 1
	end
	return series[i]
end

local upvalue = ""

do
	local function tft()
		return HW[1].tracer:First() and HW[1].tracer:First().."target" or ""
	end
	-- targetchecks (code from BigWigs, thanks!)
	local t = nil
	local function buildTable()
		t = {
			"boss1", "boss2", "boss3", "boss4",
			"target", "targettarget",
			"focus", "focustarget",
			"mouseover", "mouseovertarget",
			"party1target", "party2target", "party3target", "party4target"
		}
		for i = 1, 25 do t[#t+1] = string.format("raid%dtarget", i) end
	end
	local function findTargetByGUID(id)
		local idType = type(id)
		if not t then buildTable() end
		for i, unit in next, t do
			if UnitExists(unit) and not UnitIsPlayer(unit) then
				local unitId = UnitGUID(unit)
				if idType == "number" then unitId = tonumber(unitId:sub(7, 10), 16) end
				if unitId == id then return unit end
			end
		end
	end

	local function GetUnitIdByGUID(mob)
		return findTargetByGUID(mob)
	end

	local function checkTarget(GUID)
		local mobId = GetUnitIdByGUID(GUID)
		if mobId then
			local player = UnitName(mobId.."target")
			if player then return player else return 0 end
		end
	end
	-- end targetchecks

	local RepFuncs = {
		playerguid = function() return addon.PGUID end,
		playername = function() return addon.PNAME end,
		vehicleguid  = function() return UnitGUID("vehicle") or "" end,
		vehiclenames = function() return concat(addon:VehicleNames(),", ") end,
		difficulty = function() return addon:GetRaidDifficulty() end,
		-- First health watcher
		tft = tft,
		tft_unitexists = function() return not not UnitExists(tft()) end,
		tft_isplayer = function() return not not UnitIsUnit(tft(),"player") end,
		tft_unitname = function() return UnitName(tft()) end,
		srcname_or_YOU = function() return addon.PGUID == tuple['1'] and L.alert["YOU"] or tuple['2'] end,
		dstname_or_YOU = function() return addon.PGUID == tuple['4'] and L.alert["YOU"] or tuple['5'] end,
		upvalue = function() return upvalue end,
		--- Functions with passable arguments
		-- Get's an alert's timeleft. Note: Add support if timeleft is ever used on a tagged alert
		timeleft = function(id,delta) return Alerts:GetTimeleft("invoker"..id) + (tonumber(delta) or 0) end,
		npcid = function(guid) return NID[guid] or "" end,
		playerdebuff = function(debuff) return not not UnitDebuff("player",debuff) end,
		playerdebuffdur = function(debuff) local x = select(7,UnitDebuff("player",debuff)) - GetTime() return format("%d",x) end,
		playerbuff = function(buff) return not not UnitBuff("player",buff) end,
		playerbuffdur = function(buff) local x = select(7,UnitBuff("player",buff)) - GetTime() return format("%d",x) end,
		debuffstacks = function(unit,debuff) local c = select(4,UnitDebuff(unit,debuff)) return c end,
		buffstacks = function(unit,buff) local c = select(4,UnitBuff(unit,buff)) return c end,
		hasicon = function(unit,icon) return RaidIcons:HasIcon(unit,icon) end,
		closest = function(container) return addon:FindClosestUnit(userdata[container]) end,
		channeldur = function(unit) local name,sub,text,texture,start,finish = UnitChannelInfo(unit) if start and finish then return (finish - start) / 1000 else return 0 end end,
		castdur = function(unit) local name,sub,text,texture,start,finish = UnitChannelInfo(unit) if start and finish then return (finish - start) / 1000 else return 0 end end,
		gethp = function(unit) local hp,hpmax = UnitHealth(unit),UnitHealthMax(unit) if hp and hpmax then return hp / hpmax * 100 else return 0 end end,
		getup = function(unit) local up,upmax = UnitPower(unit),UnitPowerMax(unit) if up and upmax then return up / upmax * 100 else return 0 end end,
		getap = function(unit) local ap = UnitPower(unit, ALTERNATE_POWER_INDEX) if ap then return ap else return 0 end end,
		gettarget = function(guid) return checkTarget(guid) end,
		list = function(container) local s ="" for i,v in ipairs(userdata[container]) do s = s..v.." " end gsub(s,"%s$","") return s end,
		guidisplayertarget = function(guid) return UnitGUID("playertarget") == guid end,
		tabread = function(tab,key) local t = userdata[tab] return t[key] or 0 end,
	}

	-- Add funcs for the other health watchers
	do
		for i=2,4 do
			local tft = function() return HW[i].tracer:First() and HW[i].tracer:First().."target" or "" end
			local tft_unitexists = function() return not not UnitExists(tft()) end
			local tft_isplayer = function() return not not UnitIsUnit(tft(),"player") end
			local tft_unitname = function() return UnitName(tft()) end
			RepFuncs["tft"..i] = tft
			RepFuncs["tft"..i.."_unitexists"] = tft_unitexists
			RepFuncs["tft"..i.."_isplayer"] = tft_isplayer
			RepFuncs["tft"..i.."_unitname"] = tft_unitname
		end
	end

	--[===[@debug@
	function module:GetRepFuncs()
		return RepFuncs
	end
	--@end-debug@]===]

	local replace_nums = tuple

	local function replace_vars(str)
		local val = userdata[str]
		if type(val) == "table" then
			val = next_series_value(val,str)
		end
		return val
	end

	local function replace_funcs(str)
		if find(str,"|") then
			local func,args = match(str,"^([^|]+)|(.+)")
			func = RepFuncs[func]
			if not func then return end
			--[===[@debug@
			debug("replace_funcs",format("func: %s ret: %s",str,tostring(func(split("|",args)))))
			--@end-debug@]===]
			return tostring(func(split("|",args)))
		else
			local func = RepFuncs[str]
			if not func then return end
			--[===[@debug@
			debug("replace_funcs",format("func: %s ret: %s",str,tostring(func())))
			--@end-debug@]===]
			return tostring(func())
		end
	end

	-- Replaces special tokens with values
	-- IMPORTANT: replace_funcs goes last
	function ReplaceTokens(str)
		if type(str) ~= "string" then return str end
		str = gsub(str,"#(.-)#",replace_nums)
		str = gsub(str,"<(.-)>",replace_vars)
		str = gsub(str,"&(.-)&",replace_funcs)
		return str
	end
end

---------------------------------------------
-- PREFILTER
-- for: alert, announce, arrow, raidicon
---------------------------------------------

local shortcuts = {
	srcself = function() return addon.PGUID == tuple['1'] end,
	srcother = function() return addon.PGUID ~= tuple['1'] end,
	dstself = function() return addon.PGUID == tuple['4'] end,
	dstother = function() return addon.PGUID ~= tuple['4'] end,
}

-- returns <var> or false
-- if false, then break execution in the command handler
local function prefilter(info,command)
	-- var is info
	if type(info) ~= "table" then return info end
	-- inlined expect
	local expect = info.expect
	if expect and not handlers.expect(expect) then
		return false
	end
	for k,cond in pairs(shortcuts) do
		if info[k] and cond() then
			handlers[command](info[k])
		end
	end
	-- var is the first index
	-- if nil, then break execution in the command handler
	return info[1]
end

---------------------------------------------
-- CONDITIONS
-- Credits to PitBull4's debug for this idea
---------------------------------------------

do
	local ops = {}

	ops['=='] = function(a, b) return a == b end
	ops['~='] = function(a, b) return a ~= b end
	ops['find'] = function(a,b) return find(a,b) end

	-- Intended to be used on numbers

	ops['>'] = function(a, b)
		a,b = tonumber(a),tonumber(b)
		if not a or not b then return false
		else return a > b end
	end

	ops['>='] = function(a, b)
		a,b = tonumber(a),tonumber(b)
		if not a or not b then return false
		else return a >= b end
	end

	ops['<'] = function(a, b)
		a,b = tonumber(a),tonumber(b)
		if not a or not b then return false
		else return a < b end
	end

	ops['<='] = function(a, b)
		a,b = tonumber(a),tonumber(b)
		if not a or not b then return false
		else return a <= b end
	end

	local t = {}
	for k, v in pairs(ops) do t[#t+1] = k end
	for _, k in ipairs(t) do
		ops["not_" .. k] = function(a, b)
			return not ops[k](a, b)
		end
	end

	--[===[@debug@
	function module:GetConditions()
		return ops
	end
	--@end-debug@]===]

	local t = {}
	-- @ADD TO HANDLERS
	handlers.expect = function(info)
		if #info == 3 then
			return ops[info[2]](ReplaceTokens(info[1]),ReplaceTokens(info[3]))
		else
			-- there are at least two triplets
			--
			-- left to right association
			-- ex. (((a and b) or c) and d)
			--
			-- XXX A XXX A XXX A XXX
			--
			-- 3*x          + (x-1)           = 4x - 1 = total number
			-- ^					 ^
			-- num triplets    num logical ops

			local nres = (#info + 1) / 4
			for i=1,nres do
				-- left index of triplet
				local j = 4*i - 3
				local v1,op,v2 = info[j],info[j+1],info[j+2]
				local v = ops[op](ReplaceTokens(v1),ReplaceTokens(v2))
				t[i] = v
			end
			local ret = t[1]
			for i=2,nres do
				local ix = (i-1)*4
				local log_op = info[ix]
				if log_op == "AND" then
					ret = ret and t[i]
				elseif log_op == "OR" then
					ret = ret or t[i]
				end
			end
			return ret
		end
	end
end

---------------------------------------------
-- USERDATA
---------------------------------------------

do
	local wipeins = {} -- var -> handles

	local alert_keys = {
		"text",
		"time",
		"time10n",
		"time10h",
		"time25n",
		"time25h",
	}

	for i=2,9 do
		alert_keys[#alert_keys+1] = "text"..i
		alert_keys[#alert_keys+1] = "time"..i
	end

	function module:ResetUserData()
		wipe(userdata)
		for k,handle in pairs(wipeins) do
			module:CancelTimer(handle)
			wipeins[k] = nil
		end

		-- Copy alert time/text series into userdata
		-- time[2-9], text[2-9], time10n, time10h, time25n, time25h
		if CE.alerts then
			for var,info in pairs(CE.alerts) do
				for _,key in ipairs(alert_keys) do
					-- add userdata variable for this alert key
					local v = info[key]
					if type(v) == "table" then
						-- prepend '_' for safety
						-- ex. "_boltwarntime2"
						local ud_key = "_"..var..key
						userdata[ud_key] = v
						userdata[ud_key.."_index"] = 1
					end
				end
			end
		end

		if CE.userdata then
			-- Copy defaults into userdata
			for k,v in pairs(CE.userdata) do
				if type(v) == "table" then
					-- Indexing for series
					userdata[k.."_index"] = 1
					if v.type == "series" then
						userdata[k] = v
					elseif v.type == "container" then
						userdata[k] = {}
					end
				else
					userdata[k] = v
				end
			end
		end
	end

	-- @ADD TO HANDLERS
	handlers.set = function(info)
		for k,v in pairs(info) do
			local flag = true
			if type(v) == "string" then
				-- Increment/Decrement support
				if find(v,"^INCR") then
					local delta = tonumber(match(v,"^INCR|(%d+)"))
					userdata[k] = userdata[k] + delta
					flag = false
				elseif find(v,"^DECR") then
					local delta = tonumber(match(v,"^DECR|(%d+)"))
					userdata[k] = userdata[k] - delta
					flag = false
				else
					v = ReplaceTokens(v)
				end
			end
			if flag then
				--[===[@debug@
				debug("handlers.set","var: <%s> before: %s after: %s",k,userdata[k],v)
				--@end-debug@]===]
				if type(v) == "table" then
					-- Indexing for series
					userdata[k.."_index"] = 1
					if v.type == "series" then
						userdata[k] = v
					elseif v.type == "container" then
						userdata[k] = {}
					end
				else
					userdata[k] = v
				end
			end
		end
		return true
	end

	local function wipe_container(k)
		wipeins[k] = nil
		wipe(userdata[k])
		--[===[@debug@
		debug("wipe_container","var: %s table values: %s",k,table.concat(userdata[k],", "))
		--@end-debug@]===]
	end

	-- @ADD TO HANDLERS
	handlers.insert = function(info)
		local k,v = info[1],info[2]
		v = ReplaceTokens(v)
		local t = userdata[k]
		t[#t+1] = v

		local ct = CE.userdata[k]
		if ct.wipein and not wipeins[k] then
			wipeins[k] = module:ScheduleTimer(wipe_container,ct.wipein,k)
		end

		--[===[@debug@
		debug("insert","var: %s value: %s table values: %s",k,v,table.concat(userdata[k],", "))
		--@end-debug@]===]

		return true
	end

	handlers.tabinsert = function(info)
		local t,k,v = info[1],info[2],info[3]
		k = ReplaceTokens(k)
		v = ReplaceTokens(v)
		local tab = userdata[t]
		tab[k] = v

		--[===[@debug@
		debug("tabinsert","tab: %s key: %s value: %s",t,k,v)
		--@end-debug@]===]

		return true
	end

	handlers.tabupdate = function(info)
		local t,k,v = info[1],info[2],info[3]
		k = ReplaceTokens(k)
		local tab = userdata[t]
		local oldv = tab[k]

		if find(v,"^INCR") then
			local delta = tonumber(match(v,"^INCR|(%d+)"))
			tab[k] = tab[k] + delta
		elseif find(v,"^DECR") then
			local delta = tonumber(match(v,"^DECR|(%d+)"))
			tab[k] = tab[k] - delta
		else
			v = ReplaceTokens(v)
			tab[k] = v
		end
		--[===[@debug@
		debug("tabupdate","tab: %s key: %s value: %s was: %s",t,k,v,oldv)
		--@end-debug@]===]

		return true
	end


	-- @ADD TO HANDLERS
	handlers.wipe = function(info)
		wipe(userdata[info])
		--[===[@debug@
		debug("wipe","var: %s table values: %s",info,table.concat(userdata[info],", "))
		--@end-debug@]===]
		return true
	end
end

---------------------------------------------
-- ALERTS
---------------------------------------------

do
	local throttles = {}
	local counters = {}

	function module:ResetAlertData()
		wipe(throttles)
		wipe(counters)
	end

	local diff_to_key = {
		[1] = "time10n",
		[2] = "time25n",
		[3] = "time10h",
		[4] = "time25h",
	}

	local function resolve_time(time,var,key)
		if type(time) == "table" then
			return next_series_value(time,"_"..var..key)
		elseif type(time) == "string" then
			return tonumber(ReplaceTokens(time))
		else
			return time
		end
	end

	local function resolve_text(text,var,key)
		if type(text) == "table" then
			return next_series_value(text,"_"..var..key)
		else
			return ReplaceTokens(text)
		end
	end

	local function getid(var)
		local tag = ReplaceTokens(alerts[var].tag) or ""
		return "invoker"..var..tag
	end

	-- @ADD TO HANDLERS
	handlers.alert = function(info)
		local var = prefilter(info,"alert")
		if not var then return true end

		local stgs = pfl.Encounters[key][var]
		if stgs.enabled then
			local defn = alerts[var]

			-- Throttling
			if defn.throttle then
				-- Initialize to 0 if non-existant
				throttles[var] = throttles[var] or 0
				-- Check throttle
				local t = GetTime()
				if throttles[var] + defn.throttle < t then
					throttles[var] = t
				else
					-- Failed throttle, exit out
					return true
				end
			end

			if defn.expect and not handlers.expect(defn.expect) then
				-- failed expect condition
				return true
			end

			local id = getid(var)
			local behavior = defn.behavior
			if behavior == "overwrite" then
				Alerts:QuashByPattern(id)
			elseif behavior == "singleton" then
				if Alerts:IsActive(id) then return true end
			end

			local text,time
			-- Check to use specified text
			if info.text then
				local key = "text"..info.text
				local new_text = defn[key]
				text = resolve_text(new_text,var,key)
			end
			-- Replace text if it is still nil
			if not text then text = resolve_text(defn.text,var,"text") end

			-- Time precedence
			-- 1. specified
			-- 2. difficulty
			-- 3. default

			-- Check to use specified time
			if info.time then
				local key = "time"..info.time
				local new_time = defn[key]
				time = resolve_time(new_time,var,key)
			end

			-- Check for difficulty time
			if not time then
				local diff = addon:GetRaidDifficulty()
				local key = diff_to_key[diff]
				local new_time = defn[key]
				time = new_time and resolve_time(new_time,var,key)
			end

			-- Replace time if it still nil
			if not time then
				time = resolve_time(defn.time,var,"time")
			end

			local flashtime = stgs.flashtime or defn.flashtime

			-- Tag
			local tag = ReplaceTokens(defn.tag) or ""
			-- counters
			if stgs.counter then
				local c = counters[var] or 0
				c = c + 1
				text = text.." "..c
				counters[var] = c
			end
			--[===[@debug@
			debug("Alerts","id: %s var: %s text: %s time: %s flashtime: %s sound: %s color1: %s color2: %s tag: %s",id,var,text,time,defn.flashtime,stgs.sound,stgs.color1,stgs.color2,tag)
			--@end-debug@]===]
			-- Sanity check
			if not time or time < 0 then return true end
			-- Pass in appropriate arguments
			if defn.type == "dropdown" then
				Alerts:Dropdown(id,text,time,flashtime,stgs.sound,stgs.color1,stgs.color2,stgs.flashscreen,defn.icon,stgs.audiocd)
			elseif defn.type == "centerpopup" then
				Alerts:CenterPopup(id,text,time,flashtime,stgs.sound,stgs.color1,stgs.color2,stgs.flashscreen,defn.icon,stgs.audiocd)
			elseif defn.type == "simple" then
				Alerts:Simple(text,time,stgs.sound,stgs.color1,stgs.flashscreen,defn.icon)
			elseif defn.type == "absorb" then
				Alerts:Absorb(id,text,defn.textformat,time,flashtime,stgs.sound,stgs.color1,stgs.color2,stgs.flashscreen,defn.icon,
							  defn.values[tuple['7']],ReplaceTokens(defn.npcid))
			end
		end
		return true
	end

	handlers.batchalert = function(info)
		for _,info in ipairs(info) do handlers.alert(info) end
		return true
	end

	handlers.quash = function(info)
		Alerts:QuashByPattern(getid(info))
		--[===[@debug@
		debug("Alerts","QUASH: id: %s ",info)
		--@end-debug@]===]
		return true
	end

	handlers.quashpattern = function(info)
		local pattern = ReplaceTokens(info)
		Alerts:QuashByPattern(pattern)
		--[===[@debug@
		debug("Alerts","QUASHPATTERN: pattern: %s ",pattern)
		--@end-debug@]===]
		return true
	end

	handlers.batchquash = function(info)
		for _,var in ipairs(info) do handlers.quash(var) end
		return true
	end

	handlers.quashall = function(info)
		Alerts:QuashByPattern("^invoker")
		return true
	end

	handlers.settimeleft = function(info)
		local var,time = info[1],info[2]
		local id = getid(var)
		if type(time) == "string" then
			time = tonumber(ReplaceTokens(time))
		end
		if not time or time < 0 then return true end
		Alerts:SetTimeleft(id,time)
		return true
	end
end

---------------------------------------------
-- SCHEDULING
---------------------------------------------

do
	local reg_timers = {}
	local alert_timers = {}

	function module:RemoveAllTimers()
		for name in pairs(reg_timers) do handlers.canceltimer(name) end
		for var in pairs(alert_timers) do handlers.cancelalert(var) end
		-- Just to be safe
		self:CancelAllTimers()
	end

	local function schedule(info,timers,firefunc,cancelfunc,schedulefunc,store_args)
		local id,time = info[1],info[2]
		handlers[cancelfunc](id)
		timers[id] = new()

		if type(time) == "string" then
			time = tonumber(ReplaceTokens(time))
		end

		if not time or time < 0 then return true end

		if store_args then
			local args = new()
			-- Only need the first 7 (up to spellID)
			args[1],args[2],args[3],args[4],args[5],args[6],args[7] =
			tuple['1'],tuple['2'],tuple['3'],tuple['4'],tuple['5'],tuple['6'],tuple['7']

			timers[id].args = args
		end

		timers[id].handle = module[schedulefunc](module,firefunc,time,id)
	end

	local function cancel(info,timers)
		if timers[info] then
			module:CancelTimer(timers[info].handle,true)
			if timers[info].args then
				timers[info].args = del(timers[info].args)
			end
			timers[info] = del(timers[info])
		end
	end

	function module:FireTimer(name)
		-- Don't wipe reg_timers[name], it could be rescheduled
		self:InvokeCommands(CE.timers[name],unpack(reg_timers[name].args))
	end

	-- @ADD TO HANDLERS
	handlers.scheduletimer = function(info)
		schedule(info,reg_timers,"FireTimer","canceltimer","ScheduleTimer",true)
		return true
	end

	-- @ADD TO HANDLERS
	handlers.canceltimer = function(info)
		cancel(info,reg_timers)
		return true
	end

	function module:FireAlert(info)
		if alert_timers[info].args then
			SetTuple(unpack(alert_timers[info].args))
		end
		handlers.alert(info)
	end

	-- @ADD TO HANDLERS
	handlers.schedulealert = function(info)
		schedule(info,alert_timers,"FireAlert","cancelalert","ScheduleTimer",true)
		return true
	end

	-- @ADD TO HANDLERS
	handlers.repeatalert = function(info)
		schedule(info,alert_timers,"FireAlert","cancelalert","ScheduleRepeatingTimer",false)
		return true
	end

	-- @ADD TO HANDLERS
	handlers.cancelalert = function(info)
		cancel(info,alert_timers)
		return true
	end
end

---------------------------------------------
-- ENGAGE TIMER
---------------------------------------------

do
	-- @ADD TO HANDLERS
	handlers.resettimer = function(info)
		addon:ResetTimer()
		return true
	end
end

---------------------------------------------
-- TRACING
---------------------------------------------

do
	-- @ADD TO HANDLERS
	handlers.tracing = function(info)
		addon:SetTracing(info)
		return true
	end

	handlers.unittracing = function(info)
		addon:SetTracing(info)
		return true
	end
end



---------------------------------------------
-- PROXIMITY CHECKING
---------------------------------------------

do
	local ProximityFuncs = addon:GetProximityFuncs()

	-- @ADD TO HANDLERS
	handlers.proximitycheck = function(info)
		local target,range = info[1],info[2]
		target = ReplaceTokens(target)
		return ProximityFuncs[range](target)
	end

	handlers.outproximitycheck = function(info)
		local target,range = info[1],info[2]
		target = ReplaceTokens(target)
		return not ProximityFuncs[range](target)
	end
end

---------------------------------------------
-- ARROWS
---------------------------------------------

do
	-- @ADD TO HANDLERS
	handlers.arrow = function(info)
		local var = prefilter(info,"arrow")
		if not var then return true end

		local stgs = pfl.Encounters[key][var]
		if stgs.enabled then
			local defn = arrows[var]
			local unit = ReplaceTokens(defn.unit)
			if UnitExists(unit) then
				Arrows:AddTarget(unit,defn.persist,defn.action,defn.msg,defn.spell,stgs.sound,defn.fixed,
									 defn.xpos,defn.ypos,defn.range1,defn.range2,defn.range3)
			end
		end
		return true
	end

	-- @ADD TO HANDLERS
	handlers.removearrow = function(info)
		info = ReplaceTokens(info)
		Arrows:RemoveTarget(info)
		return true
	end

	-- @ADD TO HANDLERS
	handlers.removeallarrows = function(info)
		Arrows:RemoveAll()
		return true
	end
end

---------------------------------------------
-- RAID ICONS
---------------------------------------------

do
	--[[
		 0 = no icon
		 1 = Yellow 4-point Star
		 2 = Orange Circle
		 3 = Purple Diamond
		 4 = Green Triangle
		 5 = White Crescent Moon
		 6 = Blue Square
		 7 = Red "X" Cross
		 8 = White Skull
	]]

	local function is_guid(str)
		return type(str) == "string" and #str == 18 and str:find("%xx%x+")
	end

	-- @ADD TO HANDLERS
	handlers.raidicon = function(info)
		local var = prefilter(info,"raidicon")
		if not var then return true end

		local stgs = pfl.Encounters[key][var]
		if addon:IsPromoted() and stgs.enabled then
			local defn = raidicons[var]
			local unit = ReplaceTokens(defn.unit)
			if UnitExists(unit) then
				if defn.type == "FRIENDLY" then
					RaidIcons:MarkFriendly(unit,defn.icon,defn.persist)
				elseif defn.type == "MULTIFRIENDLY" then
					RaidIcons:MultiMarkFriendly(var,unit,defn.icon,defn.persist,defn.reset,defn.total)
				end
			elseif is_guid(unit) then
				if defn.type == "ENEMY" then
					RaidIcons:MarkEnemy(unit,defn.icon,defn.persist,defn.remove)
				elseif defn.type == "MULTIENEMY" then
					RaidIcons:MultiMarkEnemy(var,unit,defn.icon,defn.persist,defn.remove,defn.reset,defn.total)
				end
			end
		end
		return true
	end

	-- @ADD TO HANDLERS
	handlers.removeraidicon = function(info)
		local unit = ReplaceTokens(info)
		if UnitExists(unit) then
			RaidIcons:RemoveIcon(unit)
		end
		return true
	end
end

---------------------------------------------
-- TARGET
---------------------------------------------

do

	--[[
	Target function
	How this will work:
	"target",{
		source = "#1#", -- this is mandatory
		wait = <time>, -- in seconds e.g. 0.2
		raidicon = <raidicon>,
		announce = <announce>,
		arrow = <arrow>,
		alerts = {
			self = <alert>,
			other = <alert>,
			unknown = <alert>,
		}
	}
	]]

	--Here goes actual functions (stolen from DBM and BigWigs, thanks)
	local info

	local function fire(unit)
		if UnitExists(unit) then
			upvalue = UnitName(unit)
			if info.raidicon then
				handlers.raidicon(info.raidicon)
			end
			if info.arrow then
				handlers.arrow(info.arrow)
			end
			if UnitIsUnit(unit,"player") then
				if info.announce then
					handlers.announce(info.announce)
				end
				if info.alerts and info.alerts.self then
					handlers.alert(info.alerts.self)
				end
			else
				if info.alerts and info.alerts.other then
					handlers.alert(info.alerts.other)
				end
			end
		end
	end

	local function checkt(sGUID)
		local t = nil
		local function buildTable()
			t = {
				"boss1", "boss2", "boss3", "boss4",
				"target", "targettarget",
				"focus", "focustarget",
				"mouseover", "mouseovertarget",
				"party1target", "party2target", "party3target", "party4target"
			}
			for i = 1, 25 do t[#t+1] = string.format("raid%dtarget", i) end
		end
		if not t then
			buildTable()
		end

		local targetname = nil
		for i, unit in next, t do
			if UnitGUID(unit) == sGUID then
				targetname = UnitName(unit.."target")
				break
			end
		end

		if targetname then
			fire(targetname)
		elseif not targetname then
			if info.alerts and info.alerts.unknown then
				handlers.alert(info.alerts.unknown)
			end
		end
	end

	handlers.target = function(_info)
		info = _info
		local sguid = ReplaceTokens(info.source)
		if info.wait then
			module:ScheduleTimer(checkt,info.wait,sguid)
		else
			return true
		end
		return true
	end
end

--[[
do
	-- "target",{
	--		unit = <unit>			  -- OPTIONAL
	--		npcid = <npcid>,		  -- OPTIONAL
	-- 	raidicon = <raidicon>, -- fired when target exists
	--		announce = <announce>, -- fired when target is self 	  	-- condition: target exists
	--		arrow = <arrow>, 		  -- fired when target exists
	--		alerts = {
	--			self = <alert>,     -- fired when target is self 		-- condition: target exists
	--			other = <alert>,    -- fired when target is not self 	-- condition: target exists
	--			unknown = <alert>,  -- fired when target doesn't exist
	--		},
	-- }

	-- If a rogue is targeted by Defile and then vanishes then Lich King will recast
	-- it on a different person

	-- Scenario 1
	-- 1. npc triggers SPELL_CAST_START or SPELL_CAST_SUCCESS and srcFlags indicate that the npc is target or focus
	-- 2. Register for UNIT_TARGET. The following could happen:
	-- 	a. UNIT_TARGET is triggered for the boss within 0.3s so fire everything and teardown.
	--				OR
	--		b. UNIT_TARGET is not triggered within 0.3s because the npc did not change targets or focus/target was
	--			lost on the npc (unlikely to happen). If the npc is still a valid unit then fire everything for its
	--			target. Otherwise, scan	raidNtarget for the npc and fire everything for raidNtargettarget.

	-- Scenario 2
	-- 1. npc triggers SPELL_CAST_START or SPELL_CAST_SUCCESS and the npc is not a valid unit
	-- 2. Store npc's current target's guid. If there is no current target then fire info.alerts.unknown if it exists and stop execution.
	-- 3. Schedule a repeating timer every 0.05s	for a target change. Schedule a fail-safe for 0.3s later.
	-- 4. When a target changed is detected then fire everything.

	-- tuple['3'] is srcFlags
	-- Only call from a SPELL_CAST_START or SPELL_CAST_SUCCESS

	local FAILSAFE_TIME = 0.3
	local TRY_REPEAT_TIME = 0.05
	local MAX_TRIES = 6
	local OBJECT_TARGET = COMBATLOG_OBJECT_TARGET
	local OBJECT_FOCUS  = COMBATLOG_OBJECT_FOCUS
	local ut_unit			-- Assigned focus/target for UNIT_TARGET
	local info				-- Cached info
	local last_guid		-- GUID to check against for a target switch
	local tries				-- How many times a poll has been done to check for a target swich
	local try_handle		-- Handle for polling
	local cancel_handle	-- Handle for failsafe

	local function fire(unit)
		--[===[@debug@
		debug("target.fire","unit: %s UnitName: %s",unit,UnitName(unit or ""))
		--@end-debug@]===]
		if UnitExists(unit) then
			upvalue = UnitName(unit)
			if info.raidicon then
				handlers.raidicon(info.raidicon)
			end
			if info.arrow then
				handlers.arrow(info.arrow)
			end
			if UnitIsUnit(unit,"player") then
				if info.announce then
					handlers.announce(info.announce)
				end
				if info.alerts and info.alerts.self then
					handlers.alert(info.alerts.self)
				end
			else
				if info.alerts and info.alerts.other then
					handlers.alert(info.alerts.other)
				end
			end
		else
			if info.alerts and info.alerts.unknown then
				handlers.alert(info.alerts.unknown)
			end
		end
	end

	function module:UNIT_TARGET(_,unit)
		if unit == ut_unit then
			local npcid = NID[UnitGUID(unit)]
			--[===[@debug@
			debug("target.UNIT_TARGET","unit: %s npcid: %s",unit,npcid)
			--@end-debug@]===]
			if info.npcid == npcid then
				fire(targetof[unit])
				self:TeardownTarget()
			end
		end
	end

	local function scan(npcid)
		--[===[@debug@
		debug("target.scan","Invoked")
		--@end-debug@]===]
		for _,unit in pairs(unit_to_unittarget) do
				if	 UnitExists(unit)
				and NID[UnitGUID(unit)] == npcid
				and UnitExists(targetof[unit]) then
				return targetof[unit]
			end
		end
	end

	local function try()
		tries = tries + 1
		local unit = scan(info.npcid)
		local cancel

		--[===[@debug@
		debug("target.try","tries: %s UnitName: %s",tries,UnitName(unit or ""))
		--@end-debug@]===]

		-- target changed
		if unit and UnitGUID(unit) ~= last_guid then
			fire(unit)
			cancel = true
		end

		if cancel then
			module:TeardownTarget()
		elseif tries == MAX_TRIES then
			-- failsafe fire on current target
			fire(unit or "")
			module:TeardownTarget()
		end
	end

	local function failsafe()
		--[===[@debug@
		debug("target.failsafe","Invoked")
		--@end-debug@]===]
		fire(targetof[ut_unit])
		cancel_handle = nil
		module:TeardownTarget()
	end

	function module:TeardownTarget()
		if try_handle then
			self:CancelTimer(try_handle)
			try_handle = nil
		end
		if cancel_handle then
			self:CancelTimer(cancel_handle)
			cancel_handle = nil
		end
		self:UnregisterEvent("UNIT_TARGET")
		--[===[@debug@
		debug("target.TeardownTarget","Invoked")
		--@end-debug@]===]
	end

	-- @ADD TO HANDLERS
	handlers.target = function(_info)
		info = _info
		module:TeardownTarget()
		if info.unit then
			module:RegisterEvent("UNIT_TARGET")
			ut_unit = info.unit
			cancel_handle = module:ScheduleTimer(failsafe,FAILSAFE_TIME)
			--[===[@debug@
			debug("target.bossunit","UnitName: %s",UnitName(targetof[info.unit]))
			--@end-debug@]===]
		elseif band(tuple['3'],OBJECT_TARGET) == OBJECT_TARGET then
			module:RegisterEvent("UNIT_TARGET")
			ut_unit = "target"
			cancel_handle = module:ScheduleTimer(failsafe,FAILSAFE_TIME)
			--[===[@debug@
			debug("target.OBJECT_TARGET","UnitName: %s",UnitName("targettarget"))
			--@end-debug@]===]
		elseif band(tuple['3'],OBJECT_FOCUS) == OBJECT_FOCUS then
			module:RegisterEvent("UNIT_TARGET")
			ut_unit = "focus"
			cancel_handle = module:ScheduleTimer(failsafe,FAILSAFE_TIME)
			--[===[@debug@
			debug("target.OBJECT_FOCUS","UnitName: %s",UnitName("focustarget"))
			--@end-debug@]===]
		else
			local unit = scan(info.npcid)
			if unit then last_guid = UnitGUID(unit)
			else last_guid = nil end
			try_handle = module:ScheduleRepeatingTimer(try,TRY_REPEAT_TIME)
			tries = 0
			--[===[@debug@
			debug("target.StartPolling","UnitName: %s last_guid: %s",UnitName(unit or ""),last_guid)
			--@end-debug@]===]
		end
		return true
	end
end]]

---------------------------------------------
-- ANNOUNCES
---------------------------------------------

do
	local SendChatMessage = SendChatMessage

	-- @ADD TO HANDLERS
	handlers.announce = function(info)
		local var = prefilter(info,"announce")
		if not var then return true end

		local stgs = pfl.Encounters[key][var]
		if stgs.enabled then
			local defn = announces[var]
			if defn.type == "SAY" then
				local msg = ReplaceTokens(defn.msg)
				SendChatMessage(msg,"SAY")
			end
		end
		return true
	end
end

---------------------------------------------
-- INVOKING
---------------------------------------------

do
	local flag = true

	-- @param bundle Command bundles
	-- @param ... arguments passed with the event
	function module:InvokeCommands(bundle,...)
		if flag then SetTuple(...) end
		for _,list in ipairs(bundle) do
			for i=1,#list,2 do
				local type,info = list[i],list[i+1]
				local handler = handlers[type]
				-- Make sure handler exists in case of an unsupported command
				if handler and not handler(info) then break end
			end
		end
	end

	-- @ADD TO HANDLERS
	handlers.invoke = function(info)
		-- tuple has already been set
		flag = false; module:InvokeCommands(info); flag = true
		return true
	end
end

---------------------------------------------
-- EVENTS
---------------------------------------------

do
	local throttles = {}  -- bundle -> throttle time
	local times = {}      -- bundle -> last time

	local function main_event_handler(bundles,bundle_to_filter,attr_handles,...)
		if not bundles then return end
		for _,bundle in ipairs(bundles) do
			local skip = false
			if throttles[bundle] then
				times[bundle] = times[bundle] or 0
				local t = GetTime()
				if times[bundle] + throttles[bundle] < t then
					times[bundle] = t
				else
					skip = true
				end
			end
			if not skip then
				local filter = bundle_to_filter[bundle]
				local flag = true
				for attr,data in pairs(filter) do
					-- all conditions have to pass for the bundle to fire
					if not attr_handles[attr](data,...) then
						flag = false
						break
					end
				end
				if flag then
					module:InvokeCommands(bundle,...)
				end
			end
		end
	end

	local TYPE_PLAYER = COMBATLOG_OBJECT_TYPE_PLAYER
	local TYPE_NPC = COMBATLOG_OBJECT_TYPE_NPC

	local combat_attr_handles = {
		spellid = function(hash,...)
			local spellid = select(7,...)
			return hash[spellid]
		end,

		spellid2 = function(hash,...)
			local spellid2 = select(10,...)
			return hash[spellid2]
		end,

		spellname = function(hash,...)
			local spellname = select(8,...)
			return hash[spellname]
		end,

		spellname2 = function(hash,...)
			local spellname2 = select(11,...)
			return hash[spellname2]
		end,

		srcnpcid = function(hash,...)
			local srcguid = ...
			return hash[NID[srcguid]]
		end,

		dstnpcid = function(hash,...)
			local dstguid = select(4,...)
			return hash[NID[dstguid]]
		end,

		srcisplayertype = function(bool,...)
			local _,_,srcflags = ...
			return (band(srcflags,TYPE_PLAYER) == TYPE_PLAYER) == bool
		end,

		srcisnpctype = function(bool,...)
			local _,_,srcflags = ...
			return (band(srcflags,TYPE_NPC) == TYPE_NPC) == bool
		end,

		srcisplayerunit = function(bool,...)
			local srcguid = ...
			return (srcguid == addon.PGUID) == bool
		end,

		dstisplayertype = function(bool,...)
			local dstflags = select(6,...)
			return (band(dstflags,TYPE_PLAYER) == TYPE_PLAYER) == bool
		end,

		dstisnpctype = function(bool,...)
			local dstflags = select(6,...)
			return (band(dstflags,TYPE_NPC) == TYPE_NPC) == bool
		end,

		dstisplayerunit = function(bool,...)
			local dstguid = select(4,...)
			return (dstguid == addon.PGUID) == bool
		end,
	}

	local combat_transforms = {
		spellname = function(spellid) return SN[spellid] end,
		spellname2 = function(spellid) return SN[spellid] end,
	}

	local weare42 = tonumber((select(4, GetBuildInfo()))) > 40100
	if weare42 then
		function module:COMBAT_EVENT(event,timestamp,eventtype,hideCaster,srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2, ...)
			main_event_handler(eventtype_to_bundle[eventtype],combatbundle_to_filter,combat_attr_handles, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		end
	else
		function module:COMBAT_EVENT(event,timestamp,eventtype,hideCaster,...)
			main_event_handler(eventtype_to_bundle[eventtype],combatbundle_to_filter,combat_attr_handles,...)
		end
	end

	local REG_ALIASES = {
		YELL = "CHAT_MSG_MONSTER_YELL",
		EMOTE = "CHAT_MSG_RAID_BOSS_EMOTE",
		WHISPER = "CHAT_MSG_RAID_BOSS_WHISPER",
	}

	local reg_attr_handles = {
		msg = function(hash,...)
			local msg = ...
			for str in pairs(hash) do
				if find(msg,str) then
					return true
				end
			end
		end,

		spellname = function(hash,...)
			local _,spell = ...
			return hash[spell]
		end,

		npcname = function(hash,...)
			local _,npcname = ...
			return hash[npcname]
		end,
	}

	local reg_transforms = {
		spellname = function(spellid) return SN[spellid] end,
	}

	function module:REG_EVENT(event,...)
		main_event_handler(event_to_bundle[event],eventbundle_to_filter,reg_attr_handles,...)
	end

	local function to_hash(work,trans)
		if type(work) ~= "table" then
			if trans then work = trans(work) end
			return {[work] = true}
		else
			-- work is an array
			local t = {}
			for k,v in pairs(work) do
				if trans then v = trans(v) end
				t[v] = true
			end
			return t
		end
	end

	-- filter structure = {
	-- 	[attribute] = {
	-- 		[value] = true,
	--			...
	--			[valueN] = true,
	--		},
	--    .
	--    .
	--    .
	-- 	[attributeN] = {
	-- 		[value] = true,
	--			...
	--			[valueN] = true,
	--		},
	-- }


	local function create_filter(info,handles,transforms)
		local filter = {}
		for attr in pairs(handles) do
			if info[attr] then
				if type(info[attr]) == "boolean" then
					filter[attr] = info[attr]
				else
					filter[attr] = to_hash(info[attr],transforms[attr])
				end
			end
		end
		return filter
	end

	function module:AddEventData()
		if not CE.events then return end
		-- Iterate over events table
		for _,info in ipairs(CE.events) do
			if info.type == "combatevent" then
				local t = eventtype_to_bundle[info.eventtype]
				if not t then
					t = {}
					eventtype_to_bundle[info.eventtype] = t
				end
				t[#t+1] = info.execute

				combatbundle_to_filter[info.execute] = create_filter(info,combat_attr_handles,combat_transforms)
			elseif info.type == "event" then
				local event = REG_ALIASES[info.event] or info.event
				local t = event_to_bundle[event]
				if not t then
					t = {}
					event_to_bundle[event] = t
				end
				t[#t+1] = info.execute

				eventbundle_to_filter[info.execute] = create_filter(info,reg_attr_handles,reg_transforms)
			end
			if info.throttle then throttles[info.execute] = info.throttle end
		end
	end

	function module:WipeEvents()
		wipe(event_to_bundle)
		wipe(eventtype_to_bundle)
		wipe(combatbundle_to_filter)
		wipe(eventbundle_to_filter)
		wipe(throttles)
		wipe(times)
		self:UnregisterAllEvents()
	end
end


---------------------------------------------
-- TRACER ACQUIRES
---------------------------------------------
-- Holds command bundles
local AcquiredBundles = {}
local UnitIsDead = UnitIsDead

function module:HW_TRACER_ACQUIRED(_,unit,npcid)
	if AcquiredBundles[npcid] and not UnitIsDead(unit) then
		self:InvokeCommands(AcquiredBundles[npcid])
	end
end

-- Each entry in
function module:SetOnAcquired()
	wipe(AcquiredBundles)
	local onacquired = CE.onacquired
	if not onacquired then return end
	for npcid,bundle in pairs(onacquired) do
		AcquiredBundles[npcid] = bundle
	end
end

addon.RegisterCallback(module,"HW_TRACER_ACQUIRED")

---------------------------------------------
-- API
---------------------------------------------

function module:OnSet(_,data)
	--[===[@debug@
	assert(type(data) == "table","Expected 'data' table as argument #1 in OnSet. Got '"..tostring(data).."'")
	--@end-debug@]===]
	-- Set upvalues
	CE = data
	arrows = CE.arrows
	raidicons = CE.raidicons
	alerts = CE.alerts
	announces = CE.announces
	key = CE.key
	-- Wipe events
	self:WipeEvents()
	-- Register events
	self:AddEventData()
	-- Copy data.userdata to userdata upvalue
	self:ResetUserData()
	-- OnAcquired
	self:SetOnAcquired()
end
