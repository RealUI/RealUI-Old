local name, ns = ...
local cfg = ns.cfg
local layoutSize = cfg.size == "large" and "large" or "small"

-- Unit Frames Sizes
local unit_sizes = {
	small = {
		player = 		{width = 224, height = 22},
		pet = 			{width = 10, height = 22},
		focus = 		{width = 158, height = 10},
		focustarget = 	{width = 148, height = 10},
		target = 		{width = 224, height = 22},
		targettarget = 	{width = 158, height = 10},
		tank = 			{width = 158, height = 10},
	},
	large = {
		player = 		{width = 244, height = 22},
		pet = 			{width = 11, height = 22},
		focus = 		{width = 168, height = 10},
		focustarget = 	{width = 158, height = 10},
		target = 		{width = 244, height = 22},
		targettarget = 	{width = 168, height = 10},
		tank = 			{width = 168, height = 10},
	},
}

-- Frame background
local framebd = {
	edgeFile = "", edgeSize = 0,
	bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
	insets = {left = 0, right = 0, top = 0, bottom = 0}
}

local framebackdrop = function(parent, anchor) 
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetFrameStrata("LOW")
	frame:SetPoint("TOPLEFT", anchor, "TOPLEFT")
	frame:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMRIGHT")
	frame:SetBackdrop(framebd)
	frame:SetBackdropColor(1, .5, .5, 0)
	frame:SetBackdropBorderColor(0, 0, 0, 0)
	return frame
end

ns.bd = framebackdrop
-------------------

local OnEnter = function(self)
	UnitFrame_OnEnter(self)
end

local OnLeave = function(self)
	UnitFrame_OnLeave(self)
end

--------------------

local dropdown = CreateFrame('Frame', name .. 'DropDown', UIParent, 'UIDropDownMenuTemplate')

local function DisplayFocusPopUp()
	StaticPopupDialogs["RUIFOCUSHELP"] = {
		text = "Use Shift+Click to set focus.",
		button1 = OKAY,
		OnAccept = function() return end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		notClosableByLogout = false,
	}
	StaticPopup_Show("RUIFOCUSHELP")
end

hooksecurefunc("UnitPopup_OnClick",function(self)
	local button = self.value
	if button == "SET_FOCUS" or button == "CLEAR_FOCUS" then
		if StaticPopup1 then
			StaticPopup1:Hide()
			DisplayFocusPopUp()
		end
	end
end)

local function menu(self)
	dropdown:SetParent(self)
	return ToggleDropDownMenu(1, nil, dropdown, 'cursor', 0, 0)
end

local init = function(self)
	local unit = self:GetParent().unit
	local menu, name, id
	
	if (not unit) then
		return
	end
	
	if (UnitIsUnit(unit, "player")) then
		menu = "SELF"
	elseif (UnitIsUnit(unit, "vehicle")) then
		menu = "VEHICLE"
	elseif (UnitIsUnit(unit, "pet")) then
		menu = "PET"
	elseif (UnitIsPlayer(unit)) then
		id = UnitInRaid(unit)
		if(id) then
			menu = "RAID_PLAYER"
			name = GetRaidRosterInfo(id)
		elseif(UnitInParty(unit)) then
			menu = "PARTY"
		else
			menu = "PLAYER"
		end
	else
		menu = "TARGET"
		name = RAID_TARGET_ICON
	end
	
	if (menu) then
		UnitPopup_ShowMenu(self, menu, unit, name, id)
	end
end

UIDropDownMenu_Initialize(dropdown, init, 'MENU')

-----------------------

local Shared = function(self, unit)
	self.menu = menu
	
	self.framebd = ns.bd(self, self)
	
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:RegisterForClicks"AnyUp"
	
  	if cfg.focus then
	   local ModKey = cfg.focuskey
	   local MouseButton = 1
	   local key = ModKey .. '-type' .. (MouseButton or '')
	   if(self.unit == 'focus') then
		  self:SetAttribute(key, 'macro')
		  self:SetAttribute('macrotext', '/clearfocus')
		else
		  self:SetAttribute(key, 'focus')
		end
	end
end

local LF = CreateFrame("Frame")
LF:RegisterEvent("VARIABLES_LOADED")
LF:SetScript("OnEvent", function()
	LF:UnregisterEvent("VARIABLES_LOADED")
	
	if nibRealUICharacter then
		if nibRealUICharacter.resolution then
			layoutSize = (nibRealUICharacter.resolution == 2) and "large" or "small"
		end
	end
	
	local UnitSpecific = {
		player = function(self, ...)
			Shared(self, ...)
			self:SetSize(unit_sizes[layoutSize].player.width, unit_sizes[layoutSize].player.height)
		end,
		
		focus = function(self, ...)
			Shared(self, ...)
			self:SetSize(unit_sizes[layoutSize].focus.width, unit_sizes[layoutSize].focus.height)
		end,
		
		focustarget = function(self, ...)
			Shared(self, ...)
			self:SetSize(unit_sizes[layoutSize].focustarget.width, unit_sizes[layoutSize].focustarget.height)
		end,
		
		pet = function(self, ...)
			Shared(self, ...)
			self:SetSize(unit_sizes[layoutSize].pet.width, unit_sizes[layoutSize].pet.height)
		end,
		
		target = function(self, ...)
			Shared(self, ...)
			self:SetSize(unit_sizes[layoutSize].target.width, unit_sizes[layoutSize].target.height)
		end,
		
		targettarget = function(self, ...)
			Shared(self, ...)
			self:SetSize(unit_sizes[layoutSize].targettarget.width, unit_sizes[layoutSize].targettarget.height)
		end,
		
		-- tank = function(self, ...)
			-- Shared(self, ...)
			-- self:SetSize(unit_sizes[layoutSize].tank.width, unit_sizes[layoutSize].tank.height)
		-- end,
	}

	oUF:RegisterStyle("RealUI", Shared)

	for unit,layout in next, UnitSpecific do
		oUF:RegisterStyle('RealUI - ' .. unit:gsub("^%l", string.upper), layout)
	end

	local spawnHelper = function(self, unit, ...)
		if (UnitSpecific[unit]) then
			self:SetActiveStyle('RealUI - ' .. unit:gsub("^%l", string.upper))
		elseif(UnitSpecific[unit:match('[^%d]+')]) then 
			self:SetActiveStyle('RealUI - ' .. unit:match('[^%d]+'):gsub("^%l", string.upper))
		else
			self:SetActiveStyle'RealUI'
		end
		
		local object = self:Spawn(unit)
		object:SetPoint(...)
		return object
	end

	oUF:Factory(function(self)
		spawnHelper(self, "player", "CENTER", cfg.unit_positions[layoutSize].player.x, cfg.unit_positions[layoutSize].player.y)
		spawnHelper(self, "pet", "RIGHT", "oUF_RealUIPlayer", cfg.unit_positions[layoutSize].pet.x, cfg.unit_positions[layoutSize].pet.y)
		spawnHelper(self, "focus", "RIGHT", "oUF_RealUIPlayer", cfg.unit_positions[layoutSize].focus.x, cfg.unit_positions[layoutSize].focus.y)
		spawnHelper(self, "focustarget", "RIGHT", "oUF_RealUIFocus", cfg.unit_positions[layoutSize].focustarget.x, cfg.unit_positions[layoutSize].focustarget.y)
		spawnHelper(self, "target", "CENTER", cfg.unit_positions[layoutSize].target.x, cfg.unit_positions[layoutSize].target.y)
		spawnHelper(self, "targettarget", "LEFT", "oUF_RealUITarget", cfg.unit_positions[layoutSize].targettarget.x, cfg.unit_positions[layoutSize].targettarget.y)
		
		-- Main Tank
		-- if cfg.showtank then
			-- self:SetActiveStyle("RealUI - Tank")
			
			-- local tank = self:SpawnHeader('oUF_MainTank', nil, 'raid',
					-- 'oUF-initialConfigFunction', ([[
						-- self:SetWidth(%d)
						-- self:SetHeight(%d)
					-- ]]):format(unit_sizes[layoutSize].tank.width, unit_sizes[layoutSize].tank.height),
					-- 'showRaid', true,
					-- 'groupFilter', 'MAINTANK',
					-- 'yOffset', 0,
					-- 'point' , 'BOTTOM'
				-- )
			-- tank:SetPoint("LEFT", self.units.target, cfg.unit_positions[layoutSize].tank.x, cfg.unit_positions[layoutSize].tank.y)
		-- end
		
		ns.overlayinit()
	end)
end)