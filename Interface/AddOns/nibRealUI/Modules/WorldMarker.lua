local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local LSM = LibStub("LibSharedMedia-3.0")
local db, ndbc

local MODNAME = "WorldMarker"
local WorldMarker = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

local LoggedIn = false

local WMF = {}

local ButtonWidthExpanded = 20
local ButtonWidthCollapsed = 4

local MarkerColors = {
	[1] = {0.2, 	0.2,		1,		0.8},
	[2] = {0.2, 	0.9,		0.2,	0.8},
	[3] = {1, 		0.2,		1,		0.8},
	[4] = {1, 		0.2,		0.2,	0.8},
	[5] = {1, 		1,			0.2,	0.8},
	[6] = {0.3,		0.3,		0.3,	0.8},
}

-- Options
local table_AnchorPoints = {
	"BOTTOM",
	"BOTTOMLEFT",
	"BOTTOMRIGHT",
	"CENTER",
	"LEFT",
	"RIGHT",
	"TOP",
	"TOPLEFT",
	"TOPRIGHT",
}

local table_Strata = {
	"BACKGROUND",
	"LOW",
	"MEDIUM",
	"HIGH",
	"DIALOG",
}

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "WorldMarker",
		desc = "Quick access to World Markers.",
		childGroups = "tab",
		arg = MODNAME,
		order = 2315,
		args = {
			header = {
				type = "header",
				name = "WorldMarker",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Quick access to World Markers.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the WorldMarker module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					if not InCombatLockdown() then
						nibRealUI:SetModuleEnabled(MODNAME, value)
					else
						print("|cff00ffffRealUI: |r World Marker can't be enabled or disabled during combat.")
					end
				end,
				order = 30,
			},
		},
	}
	end
	return options
end



-- OnLeave
local function ButtonOnLeave(index)
	WMF.Buttons[index].mouseover = false
	WorldMarker:HighlightUpdate(WMF.Buttons[index])
end

-- OnEnter
local function ButtonOnEnter(index)
	WMF.Buttons[index].mouseover = true
	WorldMarker:HighlightUpdate(WMF.Buttons[index])
end

-- Toggle visibility of World Marker frame
function WorldMarker:UpdateVisibility()
	if ( (NeedRefreshed or not FramesCreated) and (not InCombatLockdown()) ) then
		-- Mod needs refreshing
		WorldMarker:RefreshMod()
	else
		if ( (GetNumGroupMembers() > 0) and (IsPartyLeader() or IsRaidLeader() or IsRaidOfficer()) and nibRealUI:GetModuleEnabled(MODNAME) ) then
		if 1 == 1 then
			-- Viable to use World Markers
			if ( not WMF.Parent:IsShown() and not InCombatLockdown() ) then
				-- Show only if out of combat
				WMF.Parent:Show()
			end
		else
			-- Not viable to use World Markers
			if ( WMF.Parent:IsShown() and not InCombatLockdown() ) then
				-- Hide if out of combat
				WMF.Parent:Hide()
			end
		end
	end
end

-- Fired when Exiting / Entering Combat
local LockdownTimer = CreateFrame("Frame")
local LockdownTimer_Elapsed = 0
LockdownTimer:Hide()
LockdownTimer:SetScript("OnUpdate", function(self, elapsed)
	LockdownTimer_Elapsed = LockdownTimer_Elapsed + elapsed
	if LockdownTimer_Elapsed >= 2 then
		if NeedRefreshed then
			WorldMarker:RefreshMod()
		else
			WorldMarker:UpdateVisibility()
		end
		LockdownTimer_Elapsed = 0
		LockdownTimer:Hide()
	end
end)

function WorldMarker:UpdateLockdown(...)
	LockdownTimer:Show()
end

function WorldMarker:HighlightUpdate(self)
	self.bg:SetWidth(self.mouseover and ButtonWidthExpanded or ButtonWidthCollapsed)
end

-- Set World Marker Position
function WorldMarker:UpdatePosition()
	local MMHeight = Minimap:GetHeight()
	-- Parent
	WMF.Parent:ClearAllPoints()
	WMF.Parent:SetPoint("TOPLEFT", _G["Minimap"], "TOPRIGHT", 0, 0)
	WMF.Parent:SetFrameStrata("BACKGROUND")
	WMF.Parent:SetFrameLevel(5)
	
	WMF.Parent:SetWidth(ButtonWidthExpanded)
	WMF.Parent:SetHeight(MMHeight)
	
	local totHeight, btnHeight = 0
	for i = 1, 6 do
		btnHeight = floor(MMHeight / 6) + 1
		WMF.Buttons[i]:ClearAllPoints()
		if i == 6 then
			WMF.Buttons[i]:SetPoint("TOPLEFT", WMF.Parent, "TOPLEFT", 0, -totHeight + 1)
			WMF.Buttons[i]:SetHeight(MMHeight - totHeight + 2)
			WMF.Buttons[i].bg:SetHeight(MMHeight - totHeight + 2)
		else
			WMF.Buttons[i]:SetPoint("TOPLEFT", WMF.Parent, "TOPLEFT", 0, -totHeight + 1)
			WMF.Buttons[i]:SetHeight(btnHeight)
			WMF.Buttons[i].bg:SetHeight(btnHeight)
		end
		WMF.Buttons[i]:SetWidth(ButtonWidthExpanded)
		totHeight = totHeight + btnHeight - 1
	end
end

-----------------
local function CreateButton(id)
	local frame = CreateFrame("Button", "RealUI_WorldMarker_Button"..tostring(id), WMF.Parent, "SecureActionButtonTemplate")
	
	-- frame:SetAttribute("type", "macro")
	frame:SetScript("OnEnter", function(self) ButtonOnEnter(id) end)
	frame:SetScript("OnLeave", function(self) ButtonOnLeave(id) end)
	
	frame.bg = CreateFrame("Frame", nil, frame)
	frame.bg:SetPoint("LEFT", frame, "LEFT", 0, 0)
	frame.bg:SetWidth(ButtonWidthCollapsed)
	nibRealUI:CreateBD(frame.bg, 0.8)
	frame.bg:SetBackdropColor(unpack(MarkerColors[id]))

	return frame
end

local function CreateFrames()
	if InCombatLockdown() or FramesCreated then return end
	
	-- Parent Frame
	WMF.Parent = CreateFrame("Frame", "RealUI_WorldMarker", _G["Minimap"])
	
	-- Buttons
	WMF.Buttons = {}
	-- Blue
	WMF.Buttons[1] = CreateButton(1)
	WMF.Buttons[1]:SetAttribute("macrotext", "/wm 1")
	
	-- Green
	WMF.Buttons[2] = CreateButton(2)
	WMF.Buttons[2]:SetAttribute("macrotext", "/wm 2")
	
	-- Purple
	WMF.Buttons[3] = CreateButton(3)
	WMF.Buttons[3]:SetAttribute("macrotext", "/wm 3")
	
	-- Red
	WMF.Buttons[4] = CreateButton(4)
	WMF.Buttons[4]:SetAttribute("macrotext", "/wm 4")
	
	-- Yellow
	WMF.Buttons[5] = CreateButton(5)
	WMF.Buttons[5]:SetAttribute("macrotext", "/wm 5")
	
	-- Clear All
	WMF.Buttons[6] = CreateButton(6)
	WMF.Buttons[6]:SetAttribute("macrotext", "/cwm all")
	
	FramesCreated = true
end

---------------
function WorldMarker:RefreshMod()
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end
	
	db = self.db.profile
	
	-- Create Frames if it has been delayed
	if not InCombatLockdown() and not FramesCreated then
		CreateFrames()
	end
	
	-- Refresh Mod
	if InCombatLockdown() or not FramesCreated then
		-- In combat or have no frames, set flag so we can refresh once combat ends
		NeedRefreshed = true
	else
		-- Ready to refresh
		NeedRefreshed = false
		
		WorldMarker:UpdatePosition()
		WorldMarker:UpdateVisibility()
	end
end

function WorldMarker:PLAYER_LOGIN()
	LoggedIn = true
	
	WorldMarker:RefreshMod()
end

function WorldMarker:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {},
	})
	db = self.db.profile
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterExtrasOptions(MODNAME, GetOptions)
end

function WorldMarker:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateVisibility")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateLockdown")
	self:RegisterEvent("UNIT_FLAGS", "UpdateVisibility")
	self:RegisterEvent("PARTY_LEADER_CHANGED", "UpdateVisibility")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "UpdateVisibility")
	self:RegisterEvent("RAID_ROSTER_UPDATE", "UpdateVisibility")

	if LoggedIn then WorldMarker:RefreshMod() end
end

function WorldMarker:OnDisable()
	self:UnregisterEvent("PLAYER_LOGIN")
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("UNIT_FLAGS")
	self:UnregisterEvent("PARTY_LEADER_CHANGED")
	self:UnregisterEvent("PARTY_MEMBERS_CHANGED")
	self:UnregisterEvent("RAID_ROSTER_UPDATE")

	NeedRefreshed = false
	
	if InCombatLockdown() then
		-- Trying to disable while in combat. Display message and block mouse input to World Markers.
		print("|cff00ffffRealUI: |r World Marker can't fully disable during combat. Please wait until you leave combat, then reload the UI (type: /rl)")
	else	
		WorldMarker:UpdateVisibility()
	end
end