local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local LSM = LibStub("LibSharedMedia-3.0")
local db

local MODNAME = "Chat"
local Chat = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

local LoggedIn = false

-- Options
local function ValidateLevel(value)
	val = tonumber(value)
	if val == nil then val = 1 end
	if val < 1 then val = 1 elseif val > 85 then val = 85 end
	return val
end

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Chat",
		desc = "Modifies the appearance of the Chat window.",
		childGroups = "tab",
		arg = MODNAME,
		order = 308,
		args = {
			header = {
				type = "header",
				name = "Chat",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Modifies the appearance of the Chat window. See Chatter options for other Chat modifications.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Chat module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
					nibRealUI:ReloadUIDialog()
				end,
				order = 30,
			},
			tabs = {
				name = "Tabs",
				type = "group",
				inline = true,
				order = 40,
				args = {
					enabled = {
						type = "toggle",
						name = "Enabled",
						desc = "Skins the Chat Tabs.",
						get = function() return db.tabs.enabled end,
						set = function(info, value) 
							db.tabs.enabled = value
							nibRealUI:ReloadUIDialog()
						end,
						order = 10,
					},
					colors = {
						name = "Colors",
						type = "group",
						inline = true,
						disabled = function() return not db.tabs.enabled end,
						order = 20,
						args = {
							normal = {
								type = "color",
								name = "Normal",
								hasAlpha = false,
								get = function(info,r,g,b)
									return db.tabs.colors.normal[1], db.tabs.colors.normal[2], db.tabs.colors.normal[3]
								end,
								set = function(info,r,g,b)
									db.tabs.colors.normal[1] = r
									db.tabs.colors.normal[2] = g
									db.tabs.colors.normal[3] = b
									Chat:UpdateTabs()
								end,
								order = 10,
							},
							sep1 = {
								type = "description",
								name = " ",
								order = 20,
							},
							highlight = {
								type = "color",
								name = "Highlight",
								hasAlpha = false,
								get = function(info,r,g,b)
									return db.tabs.colors.highlight[1], db.tabs.colors.highlight[2], db.tabs.colors.highlight[3]
								end,
								set = function(info,r,g,b)
									db.tabs.colors.highlight[1] = r
									db.tabs.colors.highlight[2] = g
									db.tabs.colors.highlight[3] = b
									Chat:UpdateTabs()
								end,
								disabled = function()
									if db.tabs.colors.classcolorhighlight then return true else return false; end 
								end,
								order = 30,
							},
							classcolorhighlight = {
								type = "toggle",
								name = "Class Color Highlight",
								desc = "Use your Class Color for the highlight text.",
								get = function() return db.tabs.colors.classcolorhighlight end,
								set = function(info, value) 
									db.tabs.colors.classcolorhighlight = value
									Chat:UpdateTabs()
								end,
								order = 40,
							},
							sep2 = {
								type = "description",
								name = " ",
								order = 50,
							},
							flash = {
								type = "color",
								name = "Flash",
								hasAlpha = false,
								get = function(info,r,g,b)
									return db.tabs.colors.flash[1], db.tabs.colors.flash[2], db.tabs.colors.flash[3]
								end,
								set = function(info,r,g,b)
									db.tabs.colors.flash[1] = r
									db.tabs.colors.flash[2] = g
									db.tabs.colors.flash[3] = b
									Chat:UpdateTabs()
								end,
								order = 60,
							},
						},
					},
				},
			},
			strings = {
				name = "Strings",
				type = "group",
				inline = true,
				order = 60,
				args = {
					enabled = {
						type = "toggle",
						name = "Enabled",
						desc = "Shortens some long messages.",
						get = function() return db.strings.enabled end,
						set = function(info, value) 
							db.strings.enabled = value
							nibRealUI:ReloadUIDialog()
						end,
						order = 10,
					},
				},
			},
		},
	}
	end
	return options
end

local UClass, UClassColors

local _COPPER_AMOUNT
local _SILVER_AMOUNT
local _GOLD_AMOUNT
local _YOU_LOOT_MONEY
local _YOU_LOOT_MONEY_GUILD
local _LOOT_MONEY_SPLIT
local _LOOT_MONEY_SPLIT_GUILD

----------------------
---- CHAT STRINGS ----
----------------------
function Chat:MAIL_CLOSED()
	Chat:ChangeStrings(true)
end

function Chat:MAIL_SHOW()
	COPPER_AMOUNT = _COPPER_AMOUNT
	SILVER_AMOUNT = _SILVER_AMOUNT
	GOLD_AMOUNT = _GOLD_AMOUNT
end

function Chat:ChangeStrings(enabled)
	-- Loot
	if enabled then
		-- Currency
		COPPER_AMOUNT = "%d|cFF954F28"..COPPER_AMOUNT_SYMBOL.."|r"
		SILVER_AMOUNT = "%d|cFFC0C0C0"..SILVER_AMOUNT_SYMBOL.."|r"
		GOLD_AMOUNT = "%d|cFFF0D440"..GOLD_AMOUNT_SYMBOL.."|r"
		
		-- Loot
		YOU_LOOT_MONEY = "+%s"
		YOU_LOOT_MONEY_GUILD = "+%s (%s)"
		LOOT_MONEY_SPLIT = "+%s"
		LOOT_MONEY_SPLIT_GUILD = "+%s (%s)"
	else
		-- Currency
		COPPER_AMOUNT = _COPPER_AMOUNT
		SILVER_AMOUNT = _SILVER_AMOUNT
		GOLD_AMOUNT = _GOLD_AMOUNT
		
		-- Loot
		YOU_LOOT_MONEY = _YOU_LOOT_MONEY
		YOU_LOOT_MONEY_GUILD = _YOU_LOOT_MONEY_GUILD
		LOOT_MONEY_SPLIT = _LOOT_MONEY_SPLIT
		LOOT_MONEY_SPLIT_GUILD = _LOOT_MONEY_SPLIT_GUILD
	end
end

----------------
---- ALPHAS ----
----------------
function Chat:UpdateAlphas()
	-- Set alphas
	CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
	CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0
	CHAT_FRAME_TAB_ALERTING_NOMOUSE_ALPHA = 1
	
	CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
	CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 0.75
	CHAT_FRAME_TAB_ALERTING_MOUSEOVER_ALPHA = 1
	
	CHAT_TAB_SHOW_DELAY = 0.2
	CHAT_TAB_HIDE_DELAY = 1
	CHAT_FRAME_FADE_TIME = 0.1
	CHAT_FRAME_FADE_OUT_TIME = 1
	
	for i = 1, 10 do
		FCFTab_UpdateAlpha(_G["ChatFrame"..i])
	end
	
	DEFAULT_CHATFRAME_ALPHA = 0
end

--------------
---- TABS ----
--------------
-- Tab Style update
local TStyleColors = {}
local function UpdateTabStyle(self, style)
	-- Retrieve FontString of tab
	if self.GetFontString then
		self = self:GetFontString()
	else
		self = self:GetParent():GetFontString()
	end
	
	-- Color
	if style == "selected" then style = "highlight" end
	if ((style == "highlight") and db.tabs.colors.classcolorhighlight) then
		TStyleColors = UClassColors
	else
		TStyleColors = db.tabs.colors[style]
	end
	
	-- Set new colors
	self:SetFont(unpack(nibRealUI.font.pixel1))
	self:SetTextColor(unpack(TStyleColors))
	self:SetShadowColor(0, 0, 0, 0)
end

-- Chat Tab mouse-events
local function ChatTab_OnLeave(self)
	Chat:UpdateTabs(true)
end

local function ChatTab_OnEnter(self)
	UpdateTabStyle(self, "highlight")
end

local function ChatTabFlash_OnHide(self)
	UpdateTabStyle(self, "normal")
end

local function ChatTabFlash_OnShow(self)
	UpdateTabStyle(self, "flash")
	UIFrameFlashStop(self.glow)
end

-- Tab update
function Chat:UpdateTabs(SimpleUpdate)
	local chat, tab, flash
	for i = 1, NUM_CHAT_WINDOWS do
		chat = _G["ChatFrame"..i]
		tab = _G["ChatFrame"..i.."Tab"]
		flash = _G["ChatFrame"..i.."TabFlash"]
		
		if not SimpleUpdate then
			-- Hide regular Chat Tab textures
			_G["ChatFrame"..i.."TabLeft"]:Hide()
			_G["ChatFrame"..i.."TabMiddle"]:Hide()
			_G["ChatFrame"..i.."TabRight"]:Hide()
			_G["ChatFrame"..i.."TabHighlightLeft"]:Hide()
			_G["ChatFrame"..i.."TabHighlightMiddle"]:Hide()
			_G["ChatFrame"..i.."TabHighlightRight"]:Hide()

			-- Hook Tab
			tab:SetScript("OnEnter", ChatTab_OnEnter)
			tab:SetScript("OnLeave", ChatTab_OnLeave)
		end
		
		-- Update Selected
		_G["ChatFrame"..i.."TabSelectedLeft"]:Hide()
		_G["ChatFrame"..i.."TabSelectedMiddle"]:Hide()
		_G["ChatFrame"..i.."TabSelectedRight"]:Hide()		
		
		-- Update Tab Appearance
		if chat == SELECTED_CHAT_FRAME then
			UpdateTabStyle(tab, "selected")
		elseif tab.alerting then
			UpdateTabStyle(tab, "flash")
		else
			UpdateTabStyle(tab, "normal")
		end
		
		chat:SetSpacing(1)
	end
end

-- Chat Window creation
local function NewChatWindow()
	Chat:UpdateTabs(false)
end

-- Hook FCF
local function HookFCF()
	-- Tab Click
	local Orig_FCF_Tab_OnClick = FCF_Tab_OnClick
	FCF_Tab_OnClick = function(...)
		-- Click the Tab
		Orig_FCF_Tab_OnClick(...)
		-- Update Tabs
		Chat:UpdateTabs(true)
	end

	-- New Window
	hooksecurefunc("FCF_OpenNewWindow", NewChatWindow)
	
	-- Window Close
	hooksecurefunc("FCF_Close", function(self, fallback)
		local frame = fallback or self
		UIParent.Hide(_G[frame:GetName().."Tab"])
		FCF_Tab_OnClick(_G["ChatFrame1Tab"], "LeftButton")
	end)
	
	-- Flash
	-- Start
	hooksecurefunc("FCF_StartAlertFlash", function(chatFrame)
		ChatTabFlash_OnShow(_G[chatFrame:GetName().."Tab"])
	end)
	-- Stop
	hooksecurefunc("FCF_StopAlertFlash", function(chatFrame)
		ChatTabFlash_OnHide(_G[chatFrame:GetName().."Tab"])
	end)
	
	-- New UpdateColors function, stop it!
	FCFTab_UpdateColors = function(...) end
end

-----------------------
local function ClassColorsUpdate()
	UClassColors = nibRealUI:GetClassColor(UClass)
	if db.tabs.enabled then
		Chat:UpdateTabs(true)
	end
end

function Chat:RefreshMod()
	-- Tabs
	if db.tabs.enabled then
		Chat:UpdateTabs(false)
		GENERAL_CHAT_DOCK.overflowButton:SetAlpha(CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA)
	end
	
	-- Appearance
	Chat:UpdateAlphas()
end

function Chat:VARIABLES_LOADED()
	_COPPER_AMOUNT = COPPER_AMOUNT
	_SILVER_AMOUNT = SILVER_AMOUNT
	_GOLD_AMOUNT = GOLD_AMOUNT
	nibRealUI.goldstr = _GOLD_AMOUNT
	_YOU_LOOT_MONEY = YOU_LOOT_MONEY
	_YOU_LOOT_MONEY_GUILD = YOU_LOOT_MONEY_GUILD
	_LOOT_MONEY_SPLIT = LOOT_MONEY_SPLIT
	_LOOT_MONEY_SPLIT_GUILD = LOOT_MONEY_SPLIT_GUILD
end

function Chat:PLAYER_ENTERING_WORLD()
	if db.strings.enabled then
		Chat:ChangeStrings(true)
	else
		Chat:ChangeStrings(false)
	end
end

function Chat:PLAYER_LOGIN()
	UClass = select(2, UnitClass("player"))
	UClassColors = nibRealUI:GetClassColor(UClass)
	
	self:RefreshMod()
	
	if db.tabs.enabled then
		HookFCF()
	end
	
	if CUSTOM_CLASS_COLORS then
		CUSTOM_CLASS_COLORS:RegisterCallback(ClassColorsUpdate)
	end
	
	-- Hide IM selector if BCM is enabled
	if IsAddOnLoaded("BasicChatMods") then
		_G["InterfaceOptionsSocialPanelChatStyle"]:Hide()
	end
end

function Chat:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			["**"] = {
				enabled = true,
			},
			tabs = {
				colors = {
					["normal"] = {1, 1, 1},
					classcolorhighlight = true,
					["highlight"] = {1, 1, 1},
					["flash"] = {1, 1, 0},
				},
			},
			strings = {
			},
		},
	})
	db = self.db.profile
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterPlainOptions(MODNAME, GetOptions)
end

function Chat:OnEnable() 
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("VARIABLES_LOADED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end