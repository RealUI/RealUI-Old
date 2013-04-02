local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local LSM = LibStub("LibSharedMedia-3.0")
local db
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

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
			gap1 = {
				name = " ",
				type = "description",
				order = 31,
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
			gap2 = {
				name = " ",
				type = "description",
				order = 51,
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
		--[[ Tooltip mods by Alza mostly ]]
		ITEM_LEVEL = "|cff00ffffilvl: %d|r" -- Blue color

		if GetLocale() == "enUS" or GetLocale() == "enGB" then
			ITEM_BIND_ON_EQUIP = "BoE"
			ITEM_BIND_ON_PICKUP = "BoP"
			ITEM_BIND_ON_USE = "Bind on use"
			ITEM_CLASSES_ALLOWED = "Class: %s"
			ITEM_CONJURED = "Conjured"
			ITEM_CREATED_BY = "" -- No creator name
			ITEM_LEVEL_AND_MIN = "Level: %d (min: %d)"
			ITEM_LEVEL_RANGE = "Requires level: %d - %d"
			ITEM_LEVEL_RANGE_CURRENT = "Requires level: %d - %d (%d)"
			ITEM_LIMIT_CATEGORY_MULTIPLE = "BoE: %s (%d)"
			if not(IsAddOnLoaded("Pawn")) then
				ITEM_MOD_AGILITY = "%c%s Agility"
				ITEM_MOD_AGILITY_SHORT = "Agility"
				ITEM_MOD_ARMOR_PENETRATION_RATING = "ARP +%s"
				ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT = "ARP"
				ITEM_MOD_ATTACK_POWER = "AP +%s"
				ITEM_MOD_BLOCK_RATING = "Block rating +%s"
				ITEM_MOD_BLOCK_RATING_SHORT = "Block rating"
				ITEM_MOD_BLOCK_VALUE = "Block value +%s"
				ITEM_MOD_BLOCK_VALUE_SHORT = "Block value"
				ITEM_MOD_CRIT_MELEE_RATING = "Crit (melee) +%s"
				ITEM_MOD_CRIT_MELEE_RATING_SHORT = "Crit (melee)"
				ITEM_MOD_CRIT_RANGED_RATING = "Crit (ranged) +%s"
				ITEM_MOD_CRIT_RANGED_RATING_SHORT = "Crit (ranged)"
				ITEM_MOD_CRIT_RATING = "Crit +%s"
				ITEM_MOD_CRIT_RATING_SHORT = "Crit"
				ITEM_MOD_CRIT_SPELL_RATING = "Crit (spell) +%s"
				ITEM_MOD_CRIT_SPELL_RATING_SHORT = "Crit (spell)"
				ITEM_MOD_DAMAGE_PER_SECOND_SHORT = "DPS"
				ITEM_MOD_DEFENSE_SKILL_RATING = "Defence +%s"
				ITEM_MOD_DEFENSE_SKILL_RATING_SHORT = "Defence"
				ITEM_MOD_DODGE_RATING = "Dodge +%s"
				ITEM_MOD_DODGE_RATING_SHORT = "Dodge"
				ITEM_MOD_EXPERTISE_RATING = "Expertise +%s"
				ITEM_MOD_EXPERTISE_RATING_SHORT = "Expertise"
				ITEM_MOD_FERAL_ATTACK_POWER = "Feral AP +%s"
				ITEM_MOD_FERAL_ATTACK_POWER_SHORT = "Feral AP"
				ITEM_MOD_HASTE_MELEE_RATING = "Haste (melee) +%s"
				ITEM_MOD_HASTE_MELEE_RATING_SHORT = "Haste (melee)"
				ITEM_MOD_HASTE_RANGED_RATING = "Haste (ranged) +%s"
				ITEM_MOD_HASTE_RANGED_RATING_SHORT = "Haste (ranged)"
				ITEM_MOD_HASTE_RATING = "Haste +%s"
				ITEM_MOD_HASTE_RATING_SHORT = "Haste"
				ITEM_MOD_HASTE_SPELL_RATING = "Haste (spell) +%s"
				ITEM_MOD_HASTE_SPELL_RATING_SHORT = "Haste (spell)"
				ITEM_MOD_HEALTH = "%c%s Health"
				ITEM_MOD_HEALTH_REGEN = "%d Hp5"
				ITEM_MOD_HEALTH_REGEN_SHORT = "Hp5"
				ITEM_MOD_HEALTH_REGENERATION = "%d Hp5"
				ITEM_MOD_HEALTH_REGENERATION_SHORT = "Hp5"
				ITEM_MOD_HIT_MELEE_RATING = "Hit (melee) +%s"
				ITEM_MOD_HIT_MELEE_RATING_SHORT = "Hit (melee)"
				ITEM_MOD_HIT_RANGED_RATING = "Hit (ranged) +%s"
				ITEM_MOD_HIT_RANGED_RATING_SHORT = "Hit (ranged)"
				ITEM_MOD_HIT_RATING = "Hit +%s"
				ITEM_MOD_HIT_RATING_SHORT = "Hit"
				ITEM_MOD_HIT_SPELL_RATING = "Hit (spell) +%s"
				ITEM_MOD_HIT_SPELL_RATING_SHORT = "Hit (spell)"
				ITEM_MOD_HIT_TAKEN_RATING = "Miss +%s"
				ITEM_MOD_HIT_TAKEN_RATING_SHORT = "Miss"
				ITEM_MOD_HIT_TAKEN_SPELL_RATING = "Spell miss +%s"
				ITEM_MOD_HIT_TAKEN_SPELL_RATING_SHORT = "Spell miss"
				ITEM_MOD_HIT_TAKEN_MELEE_RATING = "Melee miss +%s"
				ITEM_MOD_HIT_TAKEN_MELEE_RATING_SHORT = "Melee miss"
				ITEM_MOD_HIT_TAKEN_RANGED_RATING = "Ranged miss +%s"
				ITEM_MOD_HIT_TAKEN_RANGED_RATING_SHORT = "Ranged miss"
				ITEM_MOD_INTELLECT = "%c%s Intellect"
				ITEM_MOD_MANA = "%c%s Mana"
				ITEM_MOD_MANA_REGENERATION = "+%d Mp5"
				ITEM_MOD_MANA_REGENERATION_SHORT = "Mp5"
				ITEM_MOD_MASTERY_RATING = "Mastery +%s"
				ITEM_MOD_MELEE_ATTACK_POWER_SHORT = "AP (melee)"
				ITEM_MOD_PARRY_RATING = "Parry +%s"
				ITEM_MOD_RANGED_ATTACK_POWER = "AP (ranged) +%s"
				ITEM_MOD_RANGED_ATTACK_POWER_SHORT = "AP (ranged)"
				ITEM_MOD_RESILIENCE_RATING = "Resi +%s"
				ITEM_MOD_RESILIENCE_RATING_SHORT = "Resi"
				ITEM_MOD_SPELL_DAMAGE_DONE = "Spellpower +%s"
				ITEM_MOD_SPELL_DAMAGE_DONE_SHORT = "Spellpower"
				ITEM_MOD_SPELL_HEALING_DONE = "Healing +%s"
				ITEM_MOD_SPELL_HEALING_DONE_SHORT = "Healing"
				ITEM_MOD_SPELL_POWER = "Spellpower +%s"
				ITEM_MOD_SPELL_PENETRATION = "Spell Penetration +%s"
				
				ARMOR_TEMPLATE = "Armor: %s"
				DAMAGE_TEMPLATE = "Damage: %s - %s"
				DPS_TEMPLATE = "%s DPS"
				DURABILITY_TEMPLATE = "Durability: %d/%d"
				SHIELD_BLOCK_TEMPLATE = "Block: %d"
			end
			
			ITEM_OPENABLE = "Open!"
			ITEM_RACES_ALLOWED = "Race: %s"
			ITEM_RANDOM_ENCHANT = "Random enchant"
			ITEM_RESIST_ALL = "%c%d All resistances"
			ITEM_RESIST_SINGLE = "Resist: %c%d %s"
			ITEM_SIGNABLE = "Sign!"
			ITEM_SOCKETABLE = "" -- No gem info line
			ITEM_SOCKET_BONUS = "Bonus: %s"
			ITEM_SOLD_COLON = "Sold:"
			ITEM_SPELL_CHARGES = "%d charges"
			ITEM_SPELL_TRIGGER_ONPROC = "Proc:"
			ITEM_STARTS_QUEST = "Starts quest"
			ITEM_WRONG_CLASS = "Wrong class!"
			ITEM_UNSELLABLE = "Can't be sold"
			SELL_PRICE = "Price"

			EMPTY_SOCKET_RED = "red"
			EMPTY_SOCKET_YELLOW = "yellow"
			EMPTY_SOCKET_BLUE = "blue"
			EMPTY_SOCKET_META = "meta"
			EMPTY_SOCKET_NO_COLOR = "prismatic"

			--[[ Loot mods ]]

			LOOT_ITEM = "%s + %s"
			LOOT_ITEM_MULTIPLE = "%s + % sx%d"
			LOOT_ITEM_SELF = "+ %s"
			LOOT_ITEM_SELF_MULTIPLE = "+ %s x%d"
			LOOT_ITEM_PUSHED_SELF = "+ %s"
			LOOT_ITEM_PUSHED_SELF_MULTIPLE = "+ %s x%d"
			LOOT_MONEY = "|cff00a956+|r |cffffffff%s"
			YOU_LOOT_MONEY = "|cff00a956+|r |cffffffff%s"
			LOOT_MONEY_SPLIT = "|cff00a956+|r |cffffffff%s"
			LOOT_ROLL_ALL_PASSED = "|HlootHistory:%d|h[Loot]|h: All passed on %s"
			LOOT_ROLL_PASSED_AUTO = "%s passed %s (auto)"
			LOOT_ROLL_PASSED_AUTO_FEMALE = "%s passed %s (auto)"
			LOOT_ROLL_PASSED_SELF = "|HlootHistory:%d|h[Loot]|h: passed %s"
			LOOT_ROLL_PASSED_SELF_AUTO = "|HlootHistory:%d|h[Loot]|h: passed %s (auto)"
			-- |cff818181 on roll type
			--[[LOOT_ROLL_WON_NO_SPAM_DE = "|HlootHistory:%d|h[Loot]|h: %s (Disenchant - %d) Won: %s"
			LOOT_ROLL_WON_NO_SPAM_GREED = "|HlootHistory:%d|h[Loot]|h: %s (Greed - %d) Won: %s"
			LOOT_ROLL_WON_NO_SPAM_NEED = "|HlootHistory:%d|h[Loot]|h: %s (Need - %d) Won: %s"
			LOOT_ROLL_YOU_WON_NO_SPAM_DE = "|HlootHistory:%d|h[Loot]|h: You (Disenchant - %d) Won: %s"
			LOOT_ROLL_YOU_WON_NO_SPAM_GREED = "|HlootHistory:%d|h[Loot]|h: You (Greed - %d) Won: %s"
			LOOT_ROLL_YOU_WON_NO_SPAM_NEED = "|HlootHistory:%d|h[Loot]|h: You (Need - %d) Won: %s"]]

			--[[ Chat mods ]]

			ACHIEVEMENT_BROADCAST = "%s achieved %s!"
			BN_INLINE_TOAST_FRIEND_OFFLINE = "\124TInterface\\FriendsFrame\\UI-Toast-ToastIcons.tga:16:16:0:0:128:64:2:29:34:61\124t%s has gone |cffff0000offline|r."
			BN_INLINE_TOAST_FRIEND_ONLINE = "\124TInterface\\FriendsFrame\\UI-Toast-ToastIcons.tga:16:16:0:0:128:64:2:29:34:61\124t%s has come |cff00ff00online|r."
			CHAT_BN_WHISPER_GET = "From %s:\32"
			CHAT_BN_WHISPER_INFORM_GET = "To %s:\32"
			CHAT_FLAG_AFK = "[AFK] "
			CHAT_FLAG_DND = "[DND] "
			CHAT_YOU_CHANGED_NOTICE = "|Hchannel:%d|h[%s]|h"
			ERR_FRIEND_OFFLINE_S = "%s has gone |cffff0000offline|r."
			ERR_FRIEND_ONLINE_SS = "|Hplayer:%s|h[%s]|h has come |cff00ff00online|r."
			ERR_SKILL_UP_SI = "%s |cff1eff00%d|r"
			FACTION_STANDING_DECREASED = "%s -%d"
			FACTION_STANDING_INCREASED = "%s +%d"
			FACTION_STANDING_INCREASED_ACH_BONUS = "%s +%d (+%.1f)"
			FACTION_STANDING_INCREASED_ACH_PART = "(+%.1f)"
			FACTION_STANDING_INCREASED_BONUS = "%s + %d (+%.1f RAF)"
			FACTION_STANDING_INCREASED_DOUBLE_BONUS = "%s +%d (+%.1f RAF) (+%.1f)"
			FACTION_STANDING_INCREASED_REFER_PART = "(+%.1f RAF)"
			FACTION_STANDING_INCREASED_REST_PART = "(+%.1f Rested)"

			--[[ Text colours ]]

			NORMAL_QUEST_DISPLAY = "|cffffffff%s|r"
			TRIVIAL_QUEST_DISPLAY = "|cffffffff%s (low level)|r"
			
			ERR_AUCTION_SOLD_S = "|cff1eff00%s|r |cffffffffsold.|r"
		end
		-- [[ Misc ]]
		
		COPPER_AMOUNT = "%d\124TInterface\\MoneyFrame\\UI-CopperIcon:0:0:2:0\124t"
		SILVER_AMOUNT = "%d\124TInterface\\MoneyFrame\\UI-SilverIcon:0:0:2:0\124t"
		GOLD_AMOUNT = "%d\124TInterface\\MoneyFrame\\UI-GoldIcon:0:0:2:0\124t"
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
	CHAT_TAB_HIDE_DELAY = 0.2
	CHAT_FRAME_FADE_TIME = 0.1
	CHAT_FRAME_FADE_OUT_TIME = 0.5
	
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
	local maxTabs = ChatFrame11Tab and 11 or NUM_CHAT_WINDOWS
	for i = 1, maxTabs do
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

function Chat:PET_BATTLE_OPENING_START()
	if db.tabs.enabled then
		Chat:UpdateTabs(false)
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
	nibRealUI:RegisterModuleOptions(MODNAME, GetOptions)
end

function Chat:OnEnable() 
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("VARIABLES_LOADED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PET_BATTLE_OPENING_START")
end