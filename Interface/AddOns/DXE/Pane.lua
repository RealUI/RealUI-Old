local addon = DXE;
local L = addon.L;
local gbl, pf1

local function RefreshProfile(db)
	gbl, pfl = db.global, db.profile
end
addon:AddToRefreshProfile(RefreshProfile)

---------------------------------------------
-- UTILS
---------------------------------------------

local function search(t,value,i)
	for k,v in pairs(t) do
		if i then
			if type(v) == "table" and v[i] == value then return k end
		elseif v == value then return k end
	end
end

---------------------------------------------
-- PANE
---------------------------------------------
local Pane

function addon:ScalePaneAndCenter()
	local x,y = Pane:GetCenter()
	local escale = Pane:GetEffectiveScale()
	x,y = x*escale,y*escale
	Pane:SetScale(pfl.Pane.Scale)
	escale = Pane:GetEffectiveScale()
	x,y = x/escale,y/escale
	Pane:ClearAllPoints()
	Pane:SetPoint("CENTER",UIParent,"BOTTOMLEFT",x,y)
	addon:SavePosition(Pane)
end

function addon:SetPaneWidth()
	Pane:SetWidth(pfl.Pane.Width)
end

function addon:UpdatePaneVisibility()
	if pfl.Pane.Show then
		local op = 0
		local instanceType = select(2,IsInInstance())
		op = op + (pfl.Pane.OnlyInRaid and (addon.GroupType == "RAID"	and 1  or 0) or 1)
		op = op + (pfl.Pane.OnlyInParty and ((addon.GroupType == "PARTY" or addon.GroupType == "RAID") and 2 or 0) or  2)
		op = op + (pfl.Pane.OnlyInRaidInstance	and (instanceType == "raid" and 4  or 0) or 4)
		op = op + (pfl.Pane.OnlyInPartyInstance and (instanceType == "party"	and 8  or 0) or 8)
		op = op + (pfl.Pane.OnlyIfRunning and (self:IsRunning() and 16 or 0) or 16)
		local show = op == 31
		Pane[show and "Show" or "Hide"](Pane)

		-- Fading
		UIFrameFadeRemoveFrame(Pane)
		local fadeTable = Pane.fadeTable
		fadeTable.fadeTimer = 0
		local a = pfl.Pane.OnlyOnMouseover and (addon.Pane.MouseIsOver and 1 or 0) or 1
		local p_a = Pane:GetAlpha()
		if not show and p_a > 0 then
			fadeTable.startAlpha = p_a
			fadeTable.endAlpha = 0
			fadeTable.finishedFunc = Pane.Hide
			UIFrameFade(Pane,fadeTable)
		elseif show and a ~= p_a then
			fadeTable.startAlpha = p_a
			fadeTable.endAlpha = a
			UIFrameFade(Pane,fadeTable)
		end
	else
		self.Pane:SetAlpha(0)
		self.Pane:Hide()
	end
end

do
	local size = 17
	local buttons = {}
	--- Adds a button to the encounter pane
	-- @param normal The normal texture for the button
	-- @param highlight The highlight texture for the button
	-- @param onclick The function of the OnClick script
	-- @param anchor SetPoints the control LEFT, anchor, RIGHT
	function addon:AddPaneButton(normal,highlight,OnClick,name,text)
		local control = CreateFrame("Button",nil,self.Pane)
		control:SetWidth(size)
		control:SetHeight(size)
		control:SetPoint("LEFT",buttons[#buttons] or self.Pane.timer,"RIGHT")
		control:SetScript("OnClick",OnClick)
		control:RegisterForClicks("AnyUp")
		control:SetNormalTexture(normal)
		control:SetHighlightTexture(highlight)
		self:AddTooltipText(control,name,text)
		control:HookScript("OnEnter",function(self) addon.Pane.MouseIsOver = true; addon:UpdatePaneVisibility() end)
		control:HookScript("OnLeave",function(self) addon.Pane.MouseIsOver = false; addon:UpdatePaneVisibility()end)

		buttons[#buttons+1] = control
		return control
	end
end

-- Idea based off RDX's Pane
function addon:CreatePane()
	Pane = CreateFrame("Frame","DXEPane",UIParent)
	Pane:SetAlpha(0)
	Pane:Hide()
	Pane:SetClampedToScreen(true)
	addon:RegisterBackground(Pane)
	Pane.border = CreateFrame("Frame",nil,Pane)
	Pane.border:SetAllPoints(true)
	addon:RegisterBorder(Pane.border)
	Pane:SetWidth(pfl.Pane.Width)
	Pane:SetHeight(25)
	Pane:EnableMouse(true)
	Pane:SetMovable(true)
	Pane:SetPoint("CENTER")
	Pane:SetScale(pfl.Pane.Scale)
	self:RegisterMoveSaving(Pane,"CENTER","UIParent","CENTER",nil,nil,true)
	self:LoadPosition("DXEPane")
	Pane:SetUserPlaced(false)
	self:AddTooltipText(Pane,"Pane",L["|cffffff00Shift + Click|r to move"])
	local function OnUpdate() addon:LayoutHealthWatchers() end
	Pane:HookScript("OnMouseDown",function(self) self:SetScript("OnUpdate",OnUpdate) end)
	Pane:HookScript("OnMouseUp",function(self) self:SetScript("OnUpdate",nil) end)
	Pane:HookScript("OnEnter",function(self) self.MouseIsOver = true; addon:UpdatePaneVisibility() end)
	Pane:HookScript("OnLeave",function(self) self.MouseIsOver = false; addon:UpdatePaneVisibility() end)
	Pane.fadeTable = {timeToFade = 0.5, finishedArg1 = Pane}
  	self.Pane = Pane

	Pane.timer = addon.Timer:New(Pane,19,11)
	Pane.timer:SetPoint("BOTTOMLEFT",5,2)

	local PaneTextures = "Interface\\AddOns\\DXE\\Textures\\Pane\\"

	-- Add StartStop control
	Pane.startStop = self:AddPaneButton(
		PaneTextures.."Stop",
		PaneTextures.."Stop",
		function(self,button)
			if button == "LeftButton" then
				addon:StopEncounter()
			elseif button == "RightButton" then
				addon.Alerts:QuashByPattern("^custom")
			end
		end,
		L["Stop"],
		L["|cffffff00Click|r stops the current encounter"].."\n"..L["|cffffff00Right-Click|r stops all custom bars"]
	)

	-- Add Config control
	Pane.config = self:AddPaneButton(
		PaneTextures.."Menu",
		PaneTextures.."Menu",
		function() self:ToggleConfig() end,
		L["Configuration"],
		L["Toggles the settings window"]
	)

	-- Create dropdown menu for folder
	local selector = self:CreateSelectorDropDown()
	Pane.SetFolderValue = function(key)
		UIDropDownMenu_SetSelectedValue(selector,key)
	end
	-- Add Folder control
	Pane.folder = self:AddPaneButton(
		PaneTextures.."Folder",
		PaneTextures.."Folder",
		function() ToggleDropDownMenu(1,nil,selector,Pane.folder,0,0) end,
		L["Selector"],
		L["Activates an encounter"]
	)

	Pane.lock = self:AddPaneButton(
		PaneTextures.."Locked",
		PaneTextures.."Locked",
		function() self:ToggleLock() end,
		L["Locking"],
		L["Toggle frame anchors"]
	)

	local windows = self:CreateWindowsDropDown()
	Pane.windows = self:AddPaneButton(
		PaneTextures.."Windows",
		PaneTextures.."Windows",
		function() ToggleDropDownMenu(1,nil,windows,Pane.windows,0,0) end,
		L["Windows"],
		L["Make windows visible"]
	)

	self:CreateHealthWatchers(Pane)

	self.CreatePane = nil
end

function addon:SkinPane()
	local db = pfl.Pane

	-- Health watchers
	for i,hw in ipairs(addon.HW) do
		hw:SetNeutralColor(db.NeutralColor)
		hw:SetLostColor(db.LostColor)
		hw:ApplyNeutralColor()

		hw.title:SetFont(hw.title:GetFont(),db.TitleFontSize)
		hw.title:SetVertexColor(unpack(db.FontColor))
		hw.health:SetFont(hw.health:GetFont(),db.HealthFontSize)
		hw.health:SetVertexColor(unpack(db.FontColor))
	end
end

---------------------------------------------
-- HEALTH WATCHERS
---------------------------------------------
local HW = {}
addon.HW = HW
local DEAD = DEAD:upper()

-- Holds a list of tables
-- Each table t has three values
-- t[1] = npcid
-- t[2] = last known perc
local SortedCache = {}
local SeenNIDS = {}
--[===[@debug@
addon.SortedCache = SortedCache
addon.SeenNIDS = SeenNIDS
--@end-debug@]===]

-- Currently, only four are needed. We don't want to clutter the screen
local UNKNOWN = _G.UNKNOWN
function addon:CreateHealthWatchers(Pane)
	local function OnMouseDown() if IsShiftKeyDown() then Pane:StartMoving() end end
	local function OnMouseUp() Pane:StopMovingOrSizing(); addon:SavePosition(Pane) end

	local function OnAcquired(self,event,unit)
		local goal = self:GetGoal()
		if not self:IsTitleSet() then
			if type(goal) == "number" then
				-- Should only enter once per name
				local name = UnitName(unit)
				if name ~= UNKNOWN then
					gbl.L_NPC[goal] = name
					self:SetTitle(name)
				end
			elseif type(goal) == "string" then
				local name = UnitName(goal)
				if name ~= UNKNOWN then
					self:SetTitle(name)
				end
			end
		end
		addon.callbacks:Fire("HW_TRACER_ACQUIRED",unit,goal)
	end

	for i=1,4 do
		local hw = addon.HealthWatcher:New(Pane)
		self:AddTooltipText(hw,"Pane",L["|cffffff00Shift + Click|r to move"])
		hw:HookScript("OnEnter",function(self) Pane.MouseIsOver = true; addon:UpdatePaneVisibility() end)
		hw:HookScript("OnLeave",function(self) Pane.MouseIsOver = false; addon:UpdatePaneVisibility()end)
		hw:SetScript("OnMouseDown",OnMouseDown)
		hw:SetScript("OnMouseUp",OnMouseUp)
		hw:SetParent(Pane)
		hw:SetCallback("HW_TRACER_ACQUIRED",OnAcquired)
		HW[i] = hw
	end

	for i=1,4 do
		HW[i]:SetCallback("HW_TRACER_UPDATE",function(self,event,unit) addon:TRACER_UPDATE(unit) end)
		HW[i]:EnableUpdates()
	end

	self.CreateHealthWatchers = nil
end

function addon:CloseAllHW()
	for i=1,4 do HW[i]:Close(); HW[i]:Hide() end
end

function addon:ShowFirstHW()
	if not HW[1]:IsShown() then
		HW[1]:SetInfoBundle("",1)
		HW[1]:ApplyNeutralColor()
		HW[1]:SetTitle(addon.CE.title)
		HW[1]:Show()
	end
end

do
	local n = 0
	local handle
	local e = 1e-10
	local UNACQUIRED = 1

	--[[
	Convert percentages to negatives so we can achieve something like
		HW[4] => Neutral color
		HW[3] => DEAD
		HW[2] => DEAD
		HW[1] => 56%
	]]

	-- Stable sort by comparing npc ids
	-- When comparing two percentages we convert back to positives
	local function sortFunc(a,b)
		local v1,v2 = a[2],b[2] -- health perc
		if v1 == v2 then
			return a[1] < b[1] -- npc ids
		elseif v1 < 0 and v2 < 0 then
			return -v1 < -v2
		else
			return v1 < v2
		end
	end

	local function Execute()
		for _,unit in pairs(Roster.unit_to_unittarget) do
			-- unit could not exist and still return a valid guid
			if UnitExists(unit) then
				local npcid = NID[UnitGUID(unit)]
				if npcid then
					SeenNIDS[npcid] = true
					local k = search(SortedCache,npcid,1)
					if k then
						local h,hm = UnitHealth(unit),UnitHealthMax(unit)
						if hm == 0 then hm = 1 end
						SortedCache[k][2] = -(h / hm)
					end
				end
			end
		end

		sort(SortedCache,sortFunc)

		local flag -- Whether or not we should layout health watchers
		for i=1,n do
			if i <= 4 then
				local hw,info = HW[i],SortedCache[i]
				local npcid,perc = info[1],info[2]
				-- Conditional is entered sparsely during a fight
				if perc ~= UNACQUIRED and hw:GetGoal() ~= npcid and SeenNIDS[npcid] then
					hw:SetTitle(gbl.L_NPC[npcid] or "...")
					-- Has been acquired
					if perc then
						if perc < 0 then
							hw:SetInfoBundle(format("%0.0f%%", -perc*100), -perc)
							hw:ApplyLostColor()
						else
							hw:SetInfoBundle(DEAD,0)
						end
					-- Hasn't been acquired
					else
						hw:SetInfoBundle("",1)
						hw:ApplyNeutralColor()
					end
					hw:Track("npcid",npcid)
					hw:Open()
					if not hw:IsShown() then
						hw:Show()
						flag = true
					end
				end
			else break end
		end
		if flag then addon:LayoutHealthWatchers() end
	end

	function addon:StartSortedTracing()
		if n == 0 or handle then return end
		handle = self:ScheduleRepeatingTimer(Execute,0.5)
	end

	function addon:StopSortedTracing()
		if not handle then return end
		self:CancelTimer(handle,true)
		handle = nil
	end

	function addon:ClearSortedTracing()
		wipe(SeenNIDS)
		for i in ipairs(SortedCache) do
			SortedCache[i][2] = UNACQUIRED
		end
	end

	function addon:ResetSortedTracing()
		wipe(SeenNIDS)
		self:StopSortedTracing()
		for i in ipairs(SortedCache) do
			SortedCache[i][1] = nil
			SortedCache[i][2] = UNACQUIRED
		end
		n = 0
	end

	function addon:SetSortedTracing(npcids)
		if not npcids then return end
		n = #npcids
		for i,npcid in ipairs(npcids) do
			SortedCache[i] = SortedCache[i] or {}
			SortedCache[i][1] = npcid
			SortedCache[i][2] = UNACQUIRED
		end
		for i=n+1,#SortedCache do SortedCache[i] = nil end
	end
end

-- Units dead
function addon:HWDead(npcid)
	-- Health watchers
	for i,hw in ipairs(HW) do
		if hw:IsOpen() and hw:GetGoal() == npcid then
			hw:SetInfoBundle(DEAD,0,0)
			local k = search(SortedCache,npcid,1)
			if k then SortedCache[k][2] = 0 end
			break
		end
	end
end

do
	local registered = nil
	local units = {} -- unit => hw
	function addon:SetTracing(targets)
		if not targets then return end
		self:ResetSortedTracing()
		wipe(units)
		if registered then
			self:UnregisterEvent("UNIT_NAME_UPDATE")
			registered = nil
		end
		local n = 0
		for i,tgt in ipairs(targets) do
			-- Prevents overwriting
			local hw = HW[i]
			if hw:GetGoal() ~= tgt then
				if targets.powers and targets.powers[i] then
					hw:ShowPower()
				end
				hw:SetTitle(gbl.L_NPC[tgt] or "...")
				hw:SetInfoBundle("",1,1)
				hw:ApplyNeutralColor()
				if type(tgt) == "number" then
					hw:Track("npcid",tgt)
				elseif type(tgt) == "string" then
					if not registered then
						self:RegisterEvent("UNIT_NAME_UPDATE")
						registered = true
					end
					hw:Track("unit",tgt)
					units[tgt] = hw
				end
				hw:Open()
				hw:Show()
			end
			n = n + 1
		end
		for i=n+1,4 do
			HW[i]:Close()
			HW[i]:Hide()
		end
		self:LayoutHealthWatchers()
	end

	-- Occasionally UnitName("boss1") == UnitName("boss2")
	function addon:UNIT_NAME_UPDATE(unit)
		if units[unit] then
			--[===[@debug@
			debug("UNIT_NAME_UPDATE","unit: %s",unit)
			--@end-debug@]===]
			units[unit]:SetTitle(UnitName(unit))
		end
	end
end

function addon:LayoutHealthWatchers()
	local anchor = Pane
	local point, point2
	local relpoint, relpoint2
	local growth = pfl.Pane.BarGrowth
	local mult = 1 -- set to -1 when growing down
	if growth == "AUTOMATIC" then
		local midY = (GetScreenHeight()/2)*UIParent:GetEffectiveScale()
		local x,y = Pane:GetCenter()
		local s = Pane:GetEffectiveScale()
		x,y = x*s,y*s
		if y > midY then
			mult = -1
			point,relpoint = "TOPLEFT","BOTTOMLEFT"
			point2,relpoint2 = "TOPRIGHT","BOTTOMRIGHT"
		else
			point,relpoint = "BOTTOMLEFT","TOPLEFT"
			point2,relpoint2 = "BOTTOMRIGHT","TOPRIGHT"
		end
	elseif growth == "UP" then
		point,relpoint = "BOTTOMLEFT","TOPLEFT"
		point2,relpoint2 = "BOTTOMRIGHT","TOPRIGHT"
	elseif growth == "DOWN" then
		mult = -1
		point,relpoint = "TOPLEFT","BOTTOMLEFT"
		point2,relpoint2 = "TOPRIGHT","BOTTOMRIGHT"
	end
	for i,hw in ipairs(self.HW) do
		if hw:IsShown() then
			hw:ClearAllPoints()
			hw:SetPoint(point,anchor,relpoint,0,mult*pfl.Pane.BarSpacing)
			hw:SetPoint(point2,anchor,relpoint2,0,mult*pfl.Pane.BarSpacing)
			anchor = hw
		end
	end
end

do
	-- Throttling is needed because sometimes bosses pulsate in and out of combat at the start.
	-- UnitAffectingCombat can return false at the start even if the boss is moving towards a player.

	-- The time to wait (seconds) before it auto stops the encounter after auto starting
	local throttle = 5
	-- The last time the encounter was auto started + throttle time
	local last = 0
	function addon:TRACER_UPDATE(unit)
		local time,running = GetTime(),self:IsRunning()
		if self:IsTracerStart() and not running and UnitIsFriend(addon.targetof[unit],"player") then
			self:StartEncounter()
			last = time + throttle
		elseif (UnitIsDead(unit) or not UnitAffectingCombat(unit)) and self:IsTracerStop() and running and last < time then
			self:StopEncounter()
		end
	end
end

do
	local AutoStart,AutoStop
	function addon:SetTracerStart(val)
		AutoStart = not not val
	end

	function addon:SetTracerStop(val)
		AutoStop = not not val
	end

	function addon:IsTracerStart()
		return AutoStart
	end

	function addon:IsTracerStop()
		return AutoStop
	end
end

---------------------------------------------
-- LOCK
---------------------------------------------

do
	local LockableFrames = {}
	function addon:RegisterForLocking(frame)
		--[===[@debug@
		assert(type(frame) == "table","expected 'frame' to be a table")
		assert(frame.IsObjectType and frame:IsObjectType("Region"),"'frame' is not a blizzard frame")
		--@end-debug@]===]
		LockableFrames[frame] = true
		self:UpdateLockedFrames()
	end

	function addon:CreateLockableFrame(name,width,height,text)
		--[===[@debug@
		assert(type(name) == "string","expected 'name' to be a string")
		assert(type(width) == "number" and width > 0,"expected 'width' to be a number > 0")
		assert(type(height) == "number" and height > 0,"expected 'height' to be a number > 0")
		assert(type(text) == "string","expected 'text' to be a string")
		--@end-debug@]===]
		local frame = CreateFrame("Frame","DXE"..name,UIParent)
		frame:EnableMouse(true)
		frame:SetMovable(true)
		frame:SetUserPlaced(false)
		addon:RegisterBackground(frame)
		frame.border = CreateFrame("Frame",nil,frame)
		frame.border:SetAllPoints(true)
		addon:RegisterBorder(frame.border)
		frame:SetWidth(width)
		frame:SetHeight(height)
		LockableFrames[frame] = true
		self:UpdateLockedFrames()

		local desc = frame:CreateFontString(nil,"ARTWORK")
		desc:SetShadowOffset(1,-1)
		desc:SetPoint("BOTTOM",frame,"TOP")
		self:RegisterFontString(desc,9)
		desc:SetText(text)
		return frame
	end

	function addon:UpdateLock()
		self:UpdateLockedFrames()
		if gbl.Locked then
			self:SetLocked()
		else
			self:SetUnlocked()
		end
	end

	function addon:ToggleLock()
		gbl.Locked = not gbl.Locked
		self:UpdateLock()
	end

	function addon:UpdateLockedFrames(func)
		func = func or (gbl.Locked and "Hide" or "Show")
		for frame in pairs(LockableFrames) do frame[func](frame) end
	end

	function addon:SetLocked()
		self.Pane.lock:SetNormalTexture("Interface\\Addons\\DXE\\Textures\\Pane\\Locked")
		self.Pane.lock:SetHighlightTexture("Interface\\Addons\\DXE\\Textures\\Pane\\Locked")
	end

	function addon:SetUnlocked()
		self.Pane.lock:SetNormalTexture("Interface\\Addons\\DXE\\Textures\\Pane\\Unlocked")
		self.Pane.lock:SetHighlightTexture("Interface\\Addons\\DXE\\Textures\\Pane\\Unlocked")
	end
end

---------------------------------------------
-- SELECTOR
---------------------------------------------

do
	local UIDropDownMenu_CreateInfo = UIDropDownMenu_CreateInfo
	local function closeall() CloseDropDownMenus(1) end

	local function OnClick(self)
		addon:SetActiveEncounter(self.value)
		CloseDropDownMenus()
	end

	local YELLOW = "|cffffff00"

	local work,list = {},{}
	local info

	local function Initialize(self,level)
		wipe(work)
		wipe(list)

		level = level or 1

		if level == 1 then
			info = UIDropDownMenu_CreateInfo()
			info.isTitle = true
			info.text = L["Encounter Selector"]
			info.notCheckable = true
			info.justifyH = "LEFT"
			UIDropDownMenu_AddButton(info,1)

			info = UIDropDownMenu_CreateInfo()
			info.text = L["Default"]
			info.value = "default"
			info.func = OnClick
			info.colorCode = YELLOW
			info.owner = self
			UIDropDownMenu_AddButton(info,1)

			for key,data in addon:IterateEDB() do
				work[data.category or data.zone] = true
			end
			for cat in pairs(work) do
				list[#list+1] = cat
			end

			sort(list)

			for _,cat in ipairs(list) do
				info = UIDropDownMenu_CreateInfo()
				info.text = cat
				info.value = cat
				info.hasArrow = true
				info.notCheckable = true
				info.owner = self
				UIDropDownMenu_AddButton(info,1)
			end

			info = UIDropDownMenu_CreateInfo()
			info.notCheckable = true
			info.justifyH = "LEFT"
			info.text = L["Cancel"]
			info.func = closeall
			UIDropDownMenu_AddButton(info,1)
		elseif level == 2 then
			local cat = UIDROPDOWNMENU_MENU_VALUE

			for key,data in addon:IterateEDB() do
				if (data.category or data.zone) == cat then
					list[#list+1] = data.name
					work[data.name] = key
				end
			end

			sort(list)

			for _,name in ipairs(list) do
				info = UIDropDownMenu_CreateInfo()
				info.hasArrow = false
				info.text = name
				info.owner = self
				info.value = work[name]
				info.func = OnClick
				UIDropDownMenu_AddButton(info,2)
			end
		end
	end

	function addon:CreateSelectorDropDown()
		local selector = CreateFrame("Frame", "DXEPaneSelector", UIParent, "UIDropDownMenuTemplate")
		UIDropDownMenu_Initialize(selector, Initialize, "MENU")
		UIDropDownMenu_SetSelectedValue(selector,"default")
		return selector
	end
end

---------------------------------------------
-- PANE FUNCTIONS
---------------------------------------------
do
	local isRunning,elapsedTime

	-- @return number >= 0
	function addon:GetElapsedTime()
		return elapsedTime
	end

	--- Returns whether or not the timer is running
	-- @return A boolean
	function addon:IsRunning()
		return isRunning
	end

	local function OnUpdate(self,elapsed)
		elapsedTime = elapsedTime + elapsed
		self:SetTime(elapsedTime)
	end

	--- Starts the Pane timer
	function addon:StartTimer()
		elapsedTime = 0
		self.Pane.timer:SetScript("OnUpdate",OnUpdate)
		isRunning = true
	end

	--- Stops the Pane timer
	function addon:StopTimer()
		self.Pane.timer:SetScript("OnUpdate",nil)
		isRunning = false
	end

	--- Resets the Pane timer
	function addon:ResetTimer()
		elapsedTime = 0
		self.Pane.timer:SetTime(0)
	end
end

