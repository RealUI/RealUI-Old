local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local media = LibStub("LibSharedMedia-3.0")
local db, ndb, ndbc
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local MODNAME = "ScreenSaver"
local ScreenSaver = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

local LoggedIn

local SSFrames

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

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Screen Saver",
		desc = "Dims the screen when you are AFK.",
		childGroups = "tab",
		arg = MODNAME,
		order = 1903,
		args = {
			header = {
				type = "header",
				name = "Screen Saver",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Dims the screen when you are AFK.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Screen Saver module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value)
					nibRealUI:SetModuleEnabled(MODNAME, value)
				end,
				order = 30,
			},
			gap1 = {
				name = " ",
				type = "description",
				order = 31,
			},
			general = {
				type = "group",
				name = "General",
				inline = true,
				order = 40,
				args = {
					opacity1 = {
						type = "range",
						name = "Initial Dim",
						desc = "How dark to set the gameworld when you go AFK.",
						min = 0, max = 1, step = 0.05,
						isPercent = true,
						get = function(info) return db.general.opacity1 end,
						set = function(info, value) db.general.opacity1 = value end,
						order = 10,
					},
					opacity2 = {
						type = "range",
						name = "5min+ Dim",
						desc = "How dark to set the gameworld after 5 minutes of being AFK.",
						min = 0, max = 1, step = 0.05,
						isPercent = true,
						get = function(info) return db.general.opacity2 end,
						set = function(info, value) db.general.opacity2 = value end,
						order = 20,
					},
					combatwarning = {
						type = "toggle",
						name = "Combat Warning",
						desc = "Play a warning sound if you enter combat while AFK.",
						get = function() return db.general.combatwarning end,
						set = function(info, value)
							db.general.combatwarning = value
						end,
						order = 30,
					},
				},
			},
			gap2 = {
				name = " ",
				type = "description",
				order = 41,
			},
			panel = {
				type = "group",
				name = "Panel",
				inline = true,
				order = 50,
				args = {
					opacity = {
						type = "range",
						name = "Opacity",
						min = 0, max = 1, step = 0.05,
						isPercent = true,
						get = function(info) return db.panel.opacity end,
						set = function(info, value) db.panel.opacity = value; ScreenSaver:UpdateFrames() end,
						order = 10,
					},
					automove = {
						type = "toggle",
						name = "Auto Move",
						desc = "Reposition the Panel up and down the screen once every minute.",
						get = function() return db.panel.automove end,
						set = function(info, value)
							db.panel.automove = value
						end,
						order = 20,
					},
				},
			},
		},
	}
	end
	return options
end

local SecToMin = 1/60
local SecToHour = SecToMin * SecToMin

local SSFrame = nil
local IsDark = false
local IsWarning = false
local AFKTimer_Elapsed = 0
local AFKTimer_LastElapsed = 0
local OpacityLevel = 0
local AFKLevel = 0

-- Timer
function ScreenSaver:UpdateAFKTime(elapsed)
	local Hour = min(floor(elapsed * SecToHour), 99)
	local Min = mod(elapsed * SecToMin, 60)
	local Sec = floor(mod(elapsed, 60))
	local timeStr = ""
	
	if Hour >= 1 then
		timeStr = string.format("%dh", Hour)
	elseif Min >= 10 then
		timeStr = string.format("%dm", Min)
	elseif Min >= 1 then
		timeStr = string.format("%d:%02d", Min, Sec)
	else
		timeStr = string.format("%ds", Sec)
	end
	
	SSFrames.time:SetText("|cffC0C0C0"..timeStr.."|r")
	
	if mod(Sec, 60) == 0 then
		self:RepositionPanel(true)
	end
end

local AFKTimer = CreateFrame("Frame")
AFKTimer:Hide()
AFKTimer:SetScript("OnUpdate", function(self, elapsed)
	AFKTimer_Elapsed = AFKTimer_Elapsed + elapsed
	
	if AFKTimer_Elapsed > AFKTimer_LastElapsed + 1 then
		-- Functions to be done once a second
		AFKTimer_LastElapsed = AFKTimer_Elapsed
		
		-- Set BG opacity
		if AFKTimer_Elapsed > 300 then
			OpacityLevel = db.general.opacity2
			AFKLevel = 2
		else
			OpacityLevel = db.general.opacity1
			AFKLevel = 1
		end
		if not( UnitAffectingCombat("player") and db.general.combatwarning ) and GetCVar("autoClearAFK") == "1" then
			if SSFrames.bg:GetAlpha() ~= OpacityLevel then 
				UIFrameFadeIn(SSFrames.bg, 0.2, SSFrames.bg:GetAlpha(), OpacityLevel)
				ScreenSaver:ToggleOverlay(true)
			end
		end
		
		-- Make sure Size is still good
		SSFrames.bg:SetWidth(UIParent:GetWidth() + 5000)
		SSFrames.bg:SetHeight(UIParent:GetHeight() + 2000)
		SSFrames.panel:SetWidth(UIParent:GetWidth())
		
		-- Update AFK Time
		ScreenSaver:UpdateAFKTime(AFKTimer_Elapsed)
	
		-- Check Auto AFK status
		if GetCVar("autoClearAFK") ~= "1" then ScreenSaver:AFKEvent() end
	end
end)

-- Show/Hide Warning
function ScreenSaver:ToggleWarning(val)
	if val then
		if not IsWarning then
			IsWarning = true
			
			-- Play warning sound if Screen Saver is active and you get put into combat
			if UnitAffectingCombat("player") and db.general.combatwarning then
				PlaySoundFile([[Interface\AddOns\nibRealUI\Media\ScreenSaver\ZingAlarm.mp3]])
			end
		end
	else
		if IsWarning then
			IsWarning = false
		end
	end
end

-- Show/Hide Screen Saver
function ScreenSaver:ToggleOverlay(val)
	if val and GetCVar("autoClearAFK") == "1" then
		if not IsDark then
			IsDark = true
			
			-- Fade In Screen Saver
			self:RepositionPanel()
			UIFrameFadeIn(SSFrames.bg, 0.2, 0, db.general["opacity"..AFKLevel])
			UIFrameFadeIn(SSFrames.panel, 0.2, 0, 1)
			AFKTimer:Show()
		end
	else
		if IsDark then
			IsDark = false
			
			-- Fade Out Screen Saver
			local function bgHide()
				SSFrames.bg:Hide()
			end
			local bgFadeInfo = {
				mode = "OUT",
				timeToFade = 0.2,
				finishedFunc = bgHide,
				startAlpha = SSFrames.bg:GetAlpha(),
			}
			UIFrameFade(SSFrames.bg, bgFadeInfo)
			
			local function panelHide()
				SSFrames.panel:Hide()
				if not UnitIsAFK("player") then
					SSFrames.time:SetText("0s")
				end
			end
			local panelFadeInfo = {
				mode = "OUT",
				timeToFade = 0.2,
				finishedFunc = panelHide,
			}
			UIFrameFade(SSFrames.panel, panelFadeInfo)
			
			-- Hide Screen Saver if we're not AFK
			if not UnitIsAFK("player") then
				AFKTimer:Hide()
			end
		end
	end
end

-- Update AFK status
function ScreenSaver:AFKEvent()
	if GetCVar("autoClearAFK") ~= "1" then
		-- Disable ScreenSaver if Auto Clear AFK is disabled
		ScreenSaver:ToggleOverlay(false)
		ScreenSaver:ToggleWarning(false)
		AFKLevel = 0
	elseif UnitIsAFK("player") then
		-- AFK
		if not AFKTimer:IsShown() then
			AFKTimer_Elapsed = 0
			AFKTimer_LastElapsed = 0
			if not( UnitAffectingCombat("player") and db.general.combatwarning ) then
				UIFrameFadeIn(SSFrames.bg, 0.2, SSFrames.bg:GetAlpha(), db.general.opacity1)
				UIFrameFadeIn(SSFrames.panel, 0.2, 0, 1)
			end
			AFKTimer:Show()
			AFKLevel = 1
		end
		
		if ( UnitAffectingCombat("player") and db.general.combatwarning ) then
			-- AFK and In Combat
			if IsDark then
				ScreenSaver:ToggleOverlay(false)	-- Hide Screen Saver
				ScreenSaver:ToggleWarning(true)		-- Activate Warning				
			end
		else
			-- AFK and not In Combat
			if not IsDark then
				ScreenSaver:ToggleOverlay(true)		-- Show Screen Saver
				ScreenSaver:ToggleWarning(false)	-- Deactivate Warning
				AFKLevel = 1
			end
		end
	else
		-- Not AFK
		AFKTimer_Elapsed = 0
		AFKTimer_LastElapsed = 0
		AFKTimer:Hide()
		AFKLevel = 0
		
		ScreenSaver:ToggleOverlay(false)	-- Hide Screen Saver
		ScreenSaver:ToggleWarning(false)	-- Deactivate Warning
	end
end

function ScreenSaver:RepositionPanel(...)
	if ... and not db.panel.automove then return end
	SSFrames.panel:ClearAllPoints()
	SSFrames.panel:SetPoint("BOTTOM", UIParent, "CENTER", 0, math.random(
		ndb.positions[ndbc.resolution]["HuDY"] + (ndb.positions[ndbc.resolution]["HuDHeight"] / 2),
		(UIParent:GetHeight() / 2) - 180
	))
end

-- Frame Updates
function ScreenSaver:UpdateFrames()
	SSFrames.panel:SetBackdropColor(0.075, 0.075, 0.075, db.panel.opacity)
	
	-- Make sure Size is still good
	SSFrames.bg:SetWidth(UIParent:GetWidth() + 5000)
	SSFrames.bg:SetHeight(UIParent:GetHeight() + 2000)
	
	SSFrames.panel:SetSize(UIParent:GetWidth(), 21)
end

-- Initialize / Refresh
function ScreenSaver:RefreshMod()
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end
	
	db = self.db.profile
	ndb = nibRealUI.db.profile

	ScreenSaver:UpdateFrames()
	ScreenSaver:AFKEvent()
end

function ScreenSaver:PLAYER_LOGIN()
	LoggedIn = true
	
	ScreenSaver:RefreshMod()
end

-- Frame Creation
function ScreenSaver:CreateFrames()
	SSFrames = {}

	-- Dark Background
	SSFrames.bg = CreateFrame("Frame", nil, UIParent)
	SSFrames.bg:SetAllPoints(UIParent)
	SSFrames.bg:SetFrameStrata("BACKGROUND")
	SSFrames.bg:SetFrameLevel(0)
	SSFrames.bg:SetBackdrop({
		bgFile = nibRealUI.media.textures.plain,
	})
	SSFrames.bg:SetBackdropColor(0, 0, 0, 1)
	SSFrames.bg:SetAlpha(0)
	SSFrames.bg:Hide()
	
	-- SS Panel
	SSFrames.panel = CreateFrame("Frame", "RealUIScreenSaver", UIParent)
	SSFrames.panel:SetFrameStrata("MEDIUM")
	SSFrames.panel:SetFrameLevel("1")
	self:RepositionPanel()
	SSFrames.panel:SetSize(UIParent:GetWidth(), 21)
	nibRealUI:CreateBD(SSFrames.panel)
	SSFrames.panel:SetBackdropColor(0.075, 0.075, 0.075, db.panel.opacity)
	SSFrames.panel:SetAlpha(0)
	SSFrames.panel:Hide()
	
	SSFrames.panel.left = SSFrames.panel:CreateTexture(nil, "ARTWORK")
	SSFrames.panel.left:SetTexture(unpack(nibRealUI:GetClassColor(nibRealUI.class)))
	SSFrames.panel.left:SetPoint("LEFT", SSFrames.panel, "LEFT", 0, 0)
	SSFrames.panel.left:SetHeight(19)
	SSFrames.panel.left:SetWidth(4)
	
	SSFrames.panel.right = SSFrames.panel:CreateTexture(nil, "ARTWORK")
	SSFrames.panel.right:SetTexture(unpack(nibRealUI:GetClassColor(nibRealUI.class)))
	SSFrames.panel.right:SetPoint("RIGHT", SSFrames.panel, "RIGHT", 0, 0)
	SSFrames.panel.right:SetHeight(19)
	SSFrames.panel.right:SetWidth(4)
	
	-- Timer
	SSFrames.label = nibRealUI:CreateFS(SSFrames.panel, "CENTER")
	SSFrames.label:SetPoint("RIGHT", SSFrames.panel, "CENTER", 15, 0)
	local classColorStr = nibRealUI:ColorTableToStr(nibRealUI:GetClassColor(nibRealUI.class))
	SSFrames.label:SetText("|cffffffffAFK |r|cff"..classColorStr.."TIME:")
	SSFrames.label:SetFont(unpack(nibRealUI.font.pixeltiny))
	
	SSFrames.time = nibRealUI:CreateFS(SSFrames.panel, "LEFT")
	SSFrames.time:SetPoint("LEFT", SSFrames.panel, "CENTER", 15, 0)
	SSFrames.time:SetFont(unpack(nibRealUI.font.pixeltiny))
	SSFrames.time:SetText("0s")
end

----
function ScreenSaver:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			general = {
				opacity1 = 0.30,
				opacity2 = 0.50,
				combatwarning = true,
			},
			panel = {
				opacity = 0.9,
				automove = true,
			},
		},
	})
	db = self.db.profile
	ndb = nibRealUI.db.profile
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterModuleOptions(MODNAME, GetOptions)

	ScreenSaver:CreateFrames()
	
	self:RegisterEvent("PLAYER_LOGIN")
end

function ScreenSaver:OnEnable()
	self:RegisterEvent("PLAYER_FLAGS_CHANGED", "AFKEvent")
	self:RegisterEvent("WORLD_MAP_UPDATE", "AFKEvent")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "AFKEvent")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "AFKEvent")	
	
	if LoggedIn then 
		ScreenSaver:RefreshMod()
	end
end

function ScreenSaver:OnDisable()
	self:UnregisterEvent("PLAYER_FLAGS_CHANGED")
	self:UnregisterEvent("WORLD_MAP_UPDATE")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	
	AFKTimer_Elapsed = 0
	AFKTimer_LastElapsed = 0
	AFKTimer:Hide()
	ScreenSaver:ToggleTimer(false)
	ScreenSaver:ToggleOverlay(false)
	ScreenSaver:ToggleWarning(false)
end