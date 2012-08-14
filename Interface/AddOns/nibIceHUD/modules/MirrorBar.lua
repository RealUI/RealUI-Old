local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local MirrorBarAdv = IceCore_CreateClass(IceBarElement)

local MB = {}

-- constructor
function MirrorBarAdv.prototype:init()
	MirrorBarAdv.super.prototype.init(self, "MirrorBarAdv")
	
	self:SetDefaultColor("EXHAUSTION", 	1, 0.9, 0)
	self:SetDefaultColor("BREATH", 		0, 0.5, 1)
	self:SetDefaultColor("DEATH", 		1, 0.7, 0)
	self:SetDefaultColor("FEIGNDEATH", 	1, 0.9, 0)
	
	MB.timers = {
		["EXHAUSTION"] =	{},
		["BREATH"] =		{},
		["DEATH"] =			{},
		["FEIGNDEATH"] =	{},
	}
	
	MB.currenttimer = 1
	MB.timerlist = {
		[1] = "EXHAUSTION",
		[2] = "BREATH",
		[3] = "DEATH",
		[4] = "FEIGNDEATH",
	}
	MB.looptime = 1

	self.bTreatEmptyAsFull = true
end

-- default settings
function MirrorBarAdv.prototype:GetDefaultSettings()
	local defaults = MirrorBarAdv.super.prototype.GetDefaultSettings(self)
	
	defaults.enabled = false
	defaults.lockUpperTextAlpha = false
	defaults.shouldAnimate = false
	defaults.hideAnimationSettings = true
	defaults.offset = 2
	defaults.side = IceCore.Side.Left
	return defaults
end

-- Next Timer
local function SetNextTimer()
	local nextt = 1
	for i = (MB.currenttimer + 1), 5 do
		-- Try to find an active timer higher on the list than current timer
		if not(i > 4) then
			if MB.timers[MB.timerlist[i]].active then
				nextt = i
				break
			end
		-- Else, find first active timer
		else
			for k,v in ipairs(MB.timerlist) do
				if MB.timers[v].active then
					nextt = k
					break
				end	
			end
			break
		end
	end
	MB.currenttimer = nextt
end

-- OnUpdate
function MirrorBarAdv.prototype:OnUpdate(elapsed)
	MirrorBarAdv.super.prototype.MyOnUpdate(self)
	
	MB.loopelapsed = MB.loopelapsed + elapsed
	MB.elapsed = MB.elapsed + elapsed
	
	if MB.elapsed < (1 / 30) then return end
	
	-- Update Timer values
	for k,v in ipairs(MB.timerlist) do
		if MB.timers[v].active then
			MB.timers[v].value = MB.timers[v].value + (MB.timers[v].scale * ((GetTime() - MB.timers[v].lastTime) * 1000))
			MB.timers[v].lastTime = GetTime()
		end	
	end
	MB.elapsed = 0
	
	-- Cycle through Timers, update Values
	local LoopUpdate = false
	if MB.loopelapsed >= MB.looptime then
		MB.loopelapsed = 0
		SetNextTimer()
		LoopUpdate = true
	end
	
	local curTimer = MB.timers[MB.timerlist[MB.currenttimer]]
	
	-- Active Timer?
	if curTimer.paused then return end
	if not curTimer.active then return end
	
	if LoopUpdate then
		-- Time remaining
		curTimer.timeRemaining = floor(curTimer.value / 1000)
		curTimer.timeRemaining = nibIceHUD:Clamp(curTimer.timeRemaining, 0, curTimer.max / 1000)
		curTimer.remaining = string.format("%d", curTimer.timeRemaining)
	end
	
	-- Scale
	scale = (curTimer.max ~= 0) and (curTimer.value / curTimer.max) or 0
	scale = nibIceHUD:Clamp(scale, 0, 1)
	
	-- Update bar
	self:UpdateBar(scale, MB.timerlist[MB.currenttimer])

	self:SetBottomText1(curTimer.label)
	self:SetBottomText2(curTimer.remaining)
end

-- Update Visibility
function MirrorBarAdv.prototype:UpdateShown()
	local show = false
	if not(UnitIsDead("player") or UnitIsGhost("player") or UnitChannelInfo("player") or UnitCastingInfo("player") or UnitInVehicle("player")) then
		for k,v in pairs(MB.timers) do
			if MB.timers[k].active then
				show = true
				break
			end
		end
	end
	self:Show(show)
	if not show then
		MB.loopelapsed = 1
		MB.currenttimer = 1
	end
end

-- Spell Cast
function MirrorBarAdv.prototype:ShownUpdate(event, ...)
	local unit = ... or "player"
	if unit == "player" then
		self:UpdateShown()
	end
end

-- Mirror Start
function MirrorBarAdv.prototype:MirrorStart(event, timer, value, maxValue, scale, paused, label)
	MB.timers[timer].active = true
	MB.timers[timer].value = value
	MB.timers[timer].max = maxValue
	MB.timers[timer].scale = scale
	MB.timers[timer].paused = (paused > 0)
	MB.timers[timer].label = label
	MB.timers[timer].lastTime = GetTime()
	
	self:UpdateShown()
	self.frame:SetScript("OnUpdate", function(this, arg1, ...) self:OnUpdate(arg1) end)
end

-- Mirror Stop
function MirrorBarAdv.prototype:MirrorStop(event, timer)
	MB.timers[timer].active = false
	MB.timers[timer].current = 0
	MB.timers[timer].max = 1
	
	self:UpdateShown()
end

-- Mirror Pause
function MirrorBarAdv.prototype:MirrorPause(event, paused)
	for k,v in pairs(MB.timers) do
		MB.timers[k].paused = (paused > 0)
	end
end

-- enable plugin
function MirrorBarAdv.prototype:Enable(core)
	MirrorBarAdv.super.prototype.Enable(self, core)

	self:RegisterEvent("MIRROR_TIMER_START", "MirrorStart")
	self:RegisterEvent("MIRROR_TIMER_STOP", "MirrorStop")
	self:RegisterEvent("MIRROR_TIMER_PAUSE", "MirrorPause")
	
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
		"PLAYER_DEAD",
		"PLAYER_ALIVE",
		"PLAYER_UNGHOST",
	}
	for i,v in pairs(ShownEvents) do
		self:RegisterEvent(v, "ShownUpdate")
	end
	
	MB.loopelapsed = 1
	MB.elapsed = 1
	self:Show(false)
	
	-- hide blizz mirror bar
	UIParent:UnregisterEvent("MIRROR_TIMER_START");
end

-- disable plugin
function MirrorBarAdv.prototype:Disable(core)
	MirrorBarAdv.super.prototype.Disable(self, core)

	self:UnregisterAllEvents()
	UIParent:RegisterEvent("MIRROR_TIMER_START");
end

-- Load us up
nibIceHUD.MirrorBarAdv = MirrorBarAdv:new()