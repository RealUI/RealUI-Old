local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local media = LibStub("LibSharedMedia-3.0")
local db, ndbc

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
			timer = {
				type = "group",
				name = "Timer",
				inline = true,
				order = 50,
				args = {
					enabled = {
						type = "toggle",
						name = "Enabled",
						desc = "Enable/Disable the AFK Timer.",
						get = function() return db.timer.enabled end,
						set = function(info, value)
							db.timer.enabled = value
							ScreenSaver:AFKEvent()
						end,
						order = 10,
					},
					position = {
						name = "Position",
						type = "group",
						inline = true,
						order = 20,
						args = {
							xoffset = {
								type = "input",
								name = "X Offset",
								width = "half",
								order = 10,
								get = function(info) return tostring(db.timer.position.x) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.timer.position.x = value
									ScreenSaver:UpdateFrames()
								end,
							},
							yoffset = {
								type = "input",
								name = "Y Offset",
								width = "half",
								order = 20,
								get = function(info) return tostring(db.timer.position.y) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.timer.position.y = value
									ScreenSaver:UpdateFrames()
								end,
							},
							anchor = {
								type = "select",
								name = "Anchor",
								get = function(info) 
									for k,v in pairs(table_AnchorPoints) do
										if v == db.timer.position.anchor then return k end
									end
								end,
								set = function(info, value)
									db.timer.position.anchor = table_AnchorPoints[value]
									ScreenSaver:UpdateFrames()
								end,
								style = "dropdown",
								width = nil,
								values = table_AnchorPoints,
								order = 30,
							},
						},
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

-- Timer
function ScreenSaver:UpdateAFKTime(elapsed)
	local Hour = min(floor(elapsed * SecToHour), 99)
	local Min = mod(elapsed * SecToMin, 60)
	local Sec = mod(elapsed, 60)
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
	
	SSFrames.Timer.TextTime.text:SetText(timeStr)
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
		else
			OpacityLevel = db.general.opacity1
		end
		if SSFrames.BG:GetAlpha() ~= OpacityLevel then SSFrames.BG:SetAlpha(OpacityLevel) end
		
		-- Make sure Size is still good
		SSFrames.BG:SetWidth(UIParent:GetWidth() + 5000)
		SSFrames.BG:SetHeight(UIParent:GetHeight() + 2000)
	end
	
	if db.timer.enabled then
		-- Update AFK Time
		ScreenSaver:UpdateAFKTime(AFKTimer_Elapsed)
	end
	
	-- Check Auto AFK status
	if GetCVar("autoClearAFK") ~= "1" then ScreenSaver:AFKEvent() end
end)

-- Show/Hide Timer
function ScreenSaver:ToggleTimer(val)
	if val and db.timer.enabled then
		SSFrames.Timer:Show()
	else
		SSFrames.Timer:Hide()
	end
end

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
	if val then
		if not IsDark then
			IsDark = true
			
			SSFrames.BG:Show()
		end
	else
		if IsDark then
			IsDark = false
			
			SSFrames.BG:Hide()
		end
	end
end

-- Update AFK status
function ScreenSaver:AFKEvent()
	if GetCVar("autoClearAFK") ~= "1" then
		-- Disable ScreenSaver if Auto Clear AFK is disabled
		ScreenSaver:ToggleTimer(false)
		ScreenSaver:ToggleOverlay(false)
		ScreenSaver:ToggleWarning(false)
	elseif UnitIsAFK("player") then
		-- AFK
		if not AFKTimer:IsShown() then
			AFKTimer_Elapsed = 0
			AFKTimer_LastElapsed = 0
			SSFrames.BG:SetAlpha(db.general.opacity1)
			AFKTimer:Show()
		end
		
		if ( UnitAffectingCombat("player") and db.general.combatwarning ) then
			-- AFK and In Combat
			ScreenSaver:ToggleTimer(false)			-- Hide Timer
			if IsDark then
				ScreenSaver:ToggleOverlay(false)	-- Hide Screen Saver
				ScreenSaver:ToggleWarning(true)		-- Activate Warning				
			end
		else
			-- AFK and not In Combat
			ScreenSaver:ToggleTimer(true)			-- Show Timer
			if not IsDark then
				ScreenSaver:ToggleOverlay(true)		-- Show Screen Saver
				ScreenSaver:ToggleWarning(false)	-- Deactivate Warning
			end
		end
	else
		-- Not AFK
		AFKTimer_Elapsed = 0
		AFKTimer_LastElapsed = 0
		AFKTimer:Hide()
		
		ScreenSaver:ToggleTimer(false)		-- Hide Timer
		ScreenSaver:ToggleOverlay(false)	-- Hide Screen Saver
		ScreenSaver:ToggleWarning(false)	-- Deactivate Warning
	end
end

-- Frame Updates
function ScreenSaver:UpdateFont()
	SSFrames.Timer.Text1.text:SetFont(unpack(nibRealUI.font.pixel1))
	SSFrames.Timer.Text1.text:SetTextColor(1, 1, 1, 1)
	SSFrames.Timer.Text1.text:SetText("AFK")
	
	SSFrames.Timer.TextTime.text:SetFont(unpack(nibRealUI.font.pixel1))
	SSFrames.Timer.TextTime.text:SetTextColor(1, 1, 1, 1)
end

function ScreenSaver:UpdateFrames()
	-- Dark BG height/width
	SSFrames.BG:SetWidth(UIParent:GetWidth() + 5000)
	SSFrames.BG:SetHeight(UIParent:GetHeight() + 2000)
	SSFrames.BG:SetAlpha(db.general.opacity1)
	
	-- Timer Position
	SSFrames.Timer:SetPoint(db.timer.position.anchor, UIParent, db.timer.position.anchor, db.timer.position.x, db.timer.position.y)
	SSFrames.Timer.Line:SetPoint("BOTTOM", SSFrames.Timer, "BOTTOM", -1, nibRealUI.font.pixel1[2] + 2 + db.resolution[ndbc.resolution].liney)
	
	-- Timer text positions
	SSFrames.Timer.Text1.frame:SetPoint("BOTTOM", SSFrames.Timer, "BOTTOM", 0, 0)
	SSFrames.Timer.Text1.frame:SetWidth(30)
	SSFrames.Timer.Text1.frame:SetHeight(12)
	SSFrames.Timer.Text1.text:SetJustifyH("CENTER")
	SSFrames.Timer.Text1.text:SetPoint("BOTTOM", SSFrames.Timer.Text1.frame, "BOTTOM", 0.5, 0.5)
	
	SSFrames.Timer.TextTime.frame:SetPoint("BOTTOM", SSFrames.Timer, "BOTTOM", 0, nibRealUI.font.pixel1[2] + 2 + db.resolution[ndbc.resolution].liney + db.resolution[ndbc.resolution].timey)
	SSFrames.Timer.TextTime.frame:SetWidth(30)
	SSFrames.Timer.TextTime.frame:SetHeight(12)
	SSFrames.Timer.TextTime.text:SetJustifyH("CENTER")
	SSFrames.Timer.TextTime.text:SetPoint("BOTTOM", SSFrames.Timer.TextTime.frame, "BOTTOM", 0.5, 0.5)
end

-- Initialize / Refresh
function ScreenSaver:RefreshMod()
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end
	
	db = self.db.profile

	ScreenSaver:UpdateFrames()
	ScreenSaver:UpdateFont()
	
	ScreenSaver:AFKEvent()
end

function ScreenSaver:PLAYER_LOGIN()
	LoggedIn = true
	
	ScreenSaver:RefreshMod()
end

-- Frame Creation
local function CreateTextFrame(parent)
	local NewTextFrame = {frame = nil, text = nil}
	NewTextFrame.frame = CreateFrame("Frame", nil, parent)
	NewTextFrame.text = NewTextFrame.frame:CreateFontString(nil, "ARTWORK")
	return NewTextFrame
end

local function CreateArtFrame(parent)
	local NewArtFrame = {frame = nil, bg = nil}
	NewArtFrame.frame = CreateFrame("Frame", nil, parent)
	NewArtFrame.bg = NewArtFrame.frame:CreateTexture(nil, "ARTWORK")
	return NewArtFrame
end

function ScreenSaver:CreateFrames()
	SSFrames = {}

	-- Dark Background
	SSFrames.BG = CreateFrame("Frame", nil, UIParent)
	SSFrames.BG:SetAllPoints(UIParent)
	SSFrames.BG:SetFrameStrata("BACKGROUND")
	SSFrames.BG:SetFrameLevel(0)
	
	SSFrames.BG:SetBackdrop({
		bgFile = nibRealUI.media.textures.plain,
		edgeFile = "",
		edgeSize = 0, tile = false, tileSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	SSFrames.BG:SetBackdropColor(0, 0, 0, 1)
	
	SSFrames.BG:Hide()
	
	-- Timer Panel
	SSFrames.Timer = CreateFrame("Frame", "RealUI_ScreenSaver_Timer", UIParent)
	SSFrames.Timer:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	SSFrames.Timer:SetFrameStrata("MEDIUM")
	SSFrames.Timer:SetFrameLevel("2")
	
	SSFrames.Timer:SetWidth(db.resolution[ndbc.resolution].width)
	SSFrames.Timer:SetHeight(db.resolution[ndbc.resolution].height)
	
	SSFrames.Timer:Hide()
	
	SSFrames.Timer.Line = CreateFrame("Frame", nil, SSFrames.Timer)
	SSFrames.Timer.Line:SetHeight(3)
	SSFrames.Timer.Line:SetWidth(db.resolution[ndbc.resolution].width)
	SSFrames.Timer.Line:SetBackdrop({
		bgFile = nibRealUI.media.textures.plain, 
		edgeFile = nibRealUI.media.textures.plain, 
		tile = false, tileSize = 0, edgeSize = 1, 
		insets = { left = 1, right = 1, top = 1, bottom = 1	}
	})
	SSFrames.Timer.Line:SetBackdropColor(1, 1, 1, 1)
	SSFrames.Timer.Line:SetBackdropBorderColor(0, 0, 0, 1)
	
	-- Timer Texts	
	SSFrames.Timer.Text1 = CreateTextFrame(SSFrames.Timer)
	SSFrames.Timer.TextTime = CreateTextFrame(SSFrames.Timer)
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
			timer = {
				enabled = true,
				position = {anchor = "CENTER", x = 0, y = 0},
			},
			resolution = {
				[1] = {
					width = 26,
					height = 30,
					liney = 0,
					timey = 4,
				},
				[2] = {
					width = 30,
					height = 31,
					liney = 1,
					timey = 5,
				},
			},
		},
	})
	db = self.db.profile
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterExtrasOptions(MODNAME, GetOptions)

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