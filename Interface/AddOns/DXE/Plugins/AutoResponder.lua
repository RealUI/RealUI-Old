-- Auto Responder for whispers during encounters
--------------------------------------------

local addon = DXE
local L = addon.L

local ipairs, pairs = ipairs, pairs
local remove,wipe = table.remove,table.wipe
local match,len,format,split,find = string.match,string.len,string.format,string.split,string.find
local GetTime = GetTime

local NID = addon.NID
local CE
local AR = {}
local interval = 15
local MODS = {
	bigwigs = "^<BW>",
	dbm = "^<Deadly Boss Mods>",
	dbm2 = "^<DBM>",
	dxe = "^DXE Autoresponder",
} -- don't respond to addon whispers

local defaults = {
	profile = {enabled = false},
}
----------------------------------
-- INITIALIZATION
----------------------------------

local module = addon:NewModule("AutoResponder","AceEvent-3.0")
addon.AutoResponder = module

local db,pfl

function module:RefreshProfile() pfl = db.profile end

function module:OnInitialize()
	self.db = addon.db:RegisterNamespace("AutoResponder", defaults)
	db = self.db
	pfl = db.profile

	db.RegisterCallback(self, "OnProfileChanged", "RefreshProfile")
	db.RegisterCallback(self, "OnProfileCopied", "RefreshProfile")
	db.RegisterCallback(self, "OnProfileReset", "RefreshProfile")

	addon.RegisterCallback(self,"SetActiveEncounter","Set")
end


---------------------------------------------
-- Chat Frame Filter
---------------------------------------------
function module:whisperfilter()

	local function BOSS_MOD_FILTER(self,event,msg)
		if type(msg) == "string" then
			for k,v in pairs(MODS) do
				if find(msg,v) then return true end
			end
			if find(msg,"^dxestatus") then return true end
		end
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", BOSS_MOD_FILTER)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", BOSS_MOD_FILTER)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", BOSS_MOD_FILTER)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", BOSS_MOD_FILTER)
end

---------------------------------------------
-- Encounter Load/Start/Stop
---------------------------------------------
function module:Set(_,data)
	if pfl.enabled then
		addon.RegisterCallback(self,"StartEncounter","Start")
		addon.RegisterCallback(self,"StopEncounter","Stop")
		if AR then wipe(AR) end
		CE = data
		AR.boss = CE.name
		AR.msg = format(L["DXE Autoresponder: Currently fighting %s. Send \"dxestatus\" for details."],AR.boss)
		AR.throttle = {} -- who whispered us
	end
end

function module:Start(_,...)
	self:RegisterEvent("CHAT_MSG_WHISPER")
	self:RegisterEvent("CHAT_MSG_BN_WHISPER")
	self:whisperfilter()
end

function module:Stop()
	self:UnregisterEvent("CHAT_MSG_WHISPER")
	self:UnregisterEvent("CHAT_MSG_BN_WHISPER")

end

---------------------------------------------
-- Responder
---------------------------------------------
do
	local function helper()
		local elapsed = addon.Pane.timer.left:GetText()
		local alive = 0
		local percent = "n.a."

		for i = 1, GetNumRaidMembers() do
			alive = alive + ((UnitIsDeadOrGhost("raid"..i) and 0) or 1)
		end

		local hp,hpmax = UnitHealth(AR.boss),UnitHealthMax(AR.boss)
		if hp ~= 0 and hpmax ~=0 then
			percent = hp / hpmax * 100
		end
		return elapsed,alive,percent
	end

	local function send(recip, msg, realid)
		if realid then
			BNSendWhisper(recip, msg)
		else
			SendChatMessage(msg, "WHISPER", nil, recip)
		end
	end

	function module:responder(msg, sender, realid)
		for k,v in pairs(MODS) do
			if find(msg,v) then return true end
		end

		if not AR.throttle[sender] then
			AR.throttle[sender] = 0
		end

		if find(msg,"^dxestatus") then
			local dur,alive,percent = helper()
			AR.status = format(L["DXE Autoresponder: Boss %s (%s%%), %s min elapsed, %s/%s alive"],AR.boss,percent,dur,alive,GetNumRaidMembers())
			send(sender, AR.status, realid)
		else
			if GetTime() > AR.throttle[sender]+interval then
				send(sender, AR.msg, realid)
				AR.throttle[sender] = GetTime()
			end
		end
	end
end

---------------------------------------------
-- Events
---------------------------------------------
do
	function module:CHAT_MSG_WHISPER(_, msg, sender)
		self:responder(msg, sender, false)
	end

	function module:CHAT_MSG_BN_WHISPER(_, msg, ...)
		local realid = select(12, ...)
		self:responder(msg, realid, true)
	end
end
