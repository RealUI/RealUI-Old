local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
nibIceHUD = LibStub("AceAddon-3.0"):NewAddon("nibIceHUD", "AceConsole-3.0")

local nibIceHUD = nibIceHUD

local SML = LibStub("LibSharedMedia-3.0")
local ACR = LibStub("AceConfigRegistry-3.0")
local ConfigDialog = LibStub("AceConfigDialog-3.0")
local AceGUI = LibStub("AceGUI-3.0")
local AceSerializer = LibStub("AceSerializer-3.0", 1)

local pendingModuleLoads = {}
local bReadyToRegisterModules = false

nibIceHUD.CurrTagVersion = 3
nibIceHUD.debugging = false

nibIceHUD.WowVer = select(4, GetBuildInfo())

nibIceHUD.validBarList = { "CleanCurves" }
nibIceHUD.validCustomModules = {Bar="Buff/Debuff watcher", CD="Ability cooldown bar"}

local function deepcopy(object)
	local lookup_table = {}
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end
		local new_table = {}
		lookup_table[object] = new_table
		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end
		return setmetatable(new_table, getmetatable(object))
	end
	return _copy(object)
end

nibIceHUD.deepcopy = deepcopy

nibIceHUD.Location = "Interface\\AddOns\\nibIceHUD"

StaticPopupDialogs["NIBICEHUD_CUSTOM_BAR_CREATED"] =
{
	text = L["A custom bar has been created and can be configured through Module Settings => MyCustomBar. It is highly recommended that you change the bar name of this module so that it's easier to identify."],
	button1 = OKAY,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 0,
	OnShow = function(self)
		self:SetFrameStrata("TOOLTIP")
	end,
	OnHide = function(self)
		self:SetFrameStrata("DIALOG")
	end,
}

StaticPopupDialogs["NIBICEHUD_CUSTOM_CD_CREATED"] =
{
	text = L["A custom cooldown bar has been created and can be configured through Module Settings => MyCustomCD. It is highly recommended that you change the bar name of this module so that it's easier to identify."],
	button1 = OKAY,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 0,
	OnShow = function(self)
		self:SetFrameStrata("TOOLTIP")
	end,
	OnHide = function(self)
		self:SetFrameStrata("DIALOG")
	end,
}

StaticPopupDialogs["NIBICEHUD_DELETE_CUSTOM_MODULE"] =
{
	text = L["Are you sure you want to delete this module? This will remove all settings associated with it and cannot be un-done."],
	button1 = YES,
	button2 = NO,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 0,
	OnShow = function(self)
		self:SetFrameStrata("TOOLTIP")
	end,
	OnHide = function(self)
		self:SetFrameStrata("DIALOG")
	end,
	OnAccept = function(self)
		nibIceHUD.IceCore:DeleteDynamicModule(self.data)
		self.data = nil
	end,
}

StaticPopupDialogs["NIBICEHUD_CHANGED_PROFILE_COMBAT"] = {
	text = L["You have changed nibIceHUD profiles while in combat. This can cause problems due to Blizzard's secure frame policy. You may need to reload your UI to repair nibIceHUD."],
	button1 = OKAY,
	OnShow = function(self)
		self:SetFrameStrata("TOOLTIP")
	end,
	OnHide = function(self)
		self:SetFrameStrata("DIALOG")
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 0
}

function nibIceHUD:OnInitialize()
	self:SetDebugging(false)
	self:Debug("nibIceHUD:OnInitialize()")

	self.IceCore = IceCore:new()
	self:RegisterPendingModules()
	self.IceCore:SetupDefaults()
	bReadyToRegisterModules = true

	self.db = LibStub("AceDB-3.0"):New("IceCoreRealUIDB", self.IceCore.defaults, true)
	if not self.db or not self.db.global or not self.db.profile then
		print(L["Error: nibIceHUD database not loaded correctly.  Please exit out of WoW and delete the database file (nibIceHUD.lua) found in: \\World of Warcraft\\WTF\\Account\\<Account Name>>\\SavedVariables\\"])
		return
	end

	self.db.RegisterCallback(self, "OnProfileShutdown", "PreProfileChanged")
	self.db.RegisterCallback(self, "OnProfileChanged", "PostProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "ProfileReset")
	self.db.RegisterCallback(self, "OnProfileCopied", "ProfileCopied")

	self:NotifyNewDb()

	ConfigDialog:SetDefaultSize("nibIceHUD", 750, 650)
	self:RegisterChatCommand("icehud", function()
		nibIceHUD:OpenConfig()
	end)
	self:RegisterChatCommand("rl", function() ReloadUI() end)
	
	if SML then
		SML.RegisterCallback(self, "LibSharedMedia_Registered", "UpdateMedia")
	end
end


function nibIceHUD:NotifyNewDb()
	self.IceCore.accountSettings = self.db.global
	self.IceCore.settings = self.db.profile
	self.IceCore:SetModuleDatabases()

	self.IceCore:CheckDisplayUpdateMessage()
end


function nibIceHUD:NotifyOptionsChange()
	if ACR then
		ACR:NotifyChange("nibIceHUD")
	end
end

function nibIceHUD:OnEnable(isFirst)
	self:Debug("nibIceHUD:OnEnable()")

	if self.db.profile.enable then
		self.IceCore:Enable()
	end

	-- Add dual-spec support
	local LibDualSpec = LibStub('LibDualSpec-1.0', true)
	if LibDualSpec then
		LibDualSpec:EnhanceDatabase(self.db, "nibIceHUD")
	end

	if isFirst then
		self:SetDebugging(self.IceCore:GetDebug())
		self.debugFrame = ChatFrame2
	end
end

-- blizzard interface options
local blizOptionsPanel = CreateFrame("FRAME", "nibIceHUDConfigPanel", UIParent)
blizOptionsPanel.name = "nibIceHUD"
blizOptionsPanel.button = CreateFrame("BUTTON", "nibIceHUDOpenConfigButton", blizOptionsPanel, "UIPanelButtonTemplate")
blizOptionsPanel.button:SetText("Open nibIceHUD configuration")
blizOptionsPanel.button:SetWidth(240)
blizOptionsPanel.button:SetHeight(30)
blizOptionsPanel.button:SetScript("OnClick", function(self) HideUIPanel(InterfaceOptionsFrame) HideUIPanel(GameMenuFrame) nibIceHUD:OpenConfig() end)
blizOptionsPanel.button:SetPoint('TOPLEFT', blizOptionsPanel, 'TOPLEFT', 20, -20)
InterfaceOptions_AddCategory(blizOptionsPanel)

function nibIceHUD:OpenConfig()
	if not ConfigDialog then return end

	if not self:LoadOptions() then
		return
	end

	if ConfigDialog.OpenFrames["nibIceHUD"] ~= nil then
		ConfigDialog:Close("nibIceHUD")
	else
		ConfigDialog:Open("nibIceHUD")
	end
end

function nibIceHUD:LoadOptions()
	if not self.optionsLoaded then
		local loaded, reason = LoadAddOn("nibIceHUD_Options")
		if not loaded then
			print("Failed to load options module. Reason: " .. reason)
			return false
		else
			self.optionsLoaded = true
		end
	end

	return true
end

function nibIceHUD:Debug(msg)
	if self.debugging then
		self.debugFrame:AddMessage(msg)
	end
end

function nibIceHUD:SetDebugging(bIsDebugging)
	self.debugging = bIsDebugging
end

-- rounding stuff
function nibIceHUD:MathRound(num, idp)
	if not num then
		return nil
	end

	local mult = 10^(idp or 0)
	return math.floor(num  * mult + 0.5) / mult
end

function nibIceHUD:GetBuffCount(unit, ability, onlyMine, matchByName)
	return nibIceHUD:GetAuraCount("HELPFUL", unit, ability, onlyMine, matchByName)
end

function nibIceHUD:GetDebuffCount(unit, ability, onlyMine, matchByName)
	return nibIceHUD:GetAuraCount("HARMFUL", unit, ability, onlyMine, matchByName)
end

function nibIceHUD:GetAuraCount(auraType, unit, ability, onlyMine, matchByName)
	if not unit then
		return 0
	end

	if unit == "main hand weapon" or unit == "off hand weapon" then
		local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges
			= GetWeaponEnchantInfo()

		if unit == "main hand weapon" and hasMainHandEnchant then
			return mainHandCharges
		elseif unit == "off hand weapon" and hasOffHandEnchant then
			return offHandCharges
		end

		return 0
	end

	local i = 1
	local name, _, texture, applications = UnitAura(unit, i, auraType..(onlyMine and "|PLAYER" or ""))
	while name do
		if (not matchByName and string.match(texture:upper(), ability:upper()))
			or (matchByName and string.match(name:upper(), ability:upper())) then
			return applications
		end

		i = i + 1
		name, _, texture, applications = UnitAura(unit, i, auraType..(onlyMine and "|PLAYER" or ""))
	end

	return 0
end

do
	local retval = {}

	function nibIceHUD:HasBuffs(unit, spellIDs)
		for i=1, #spellIDs do
			retval[i] = false
		end

		local i = 1
		local name, _, texture, applications, _, _, _, _, _, _, auraID = UnitAura(unit, i)
		while name do
			for i=1, #spellIDs do
				if spellIDs[i] == auraID then
					retval[i] = applications == 0 and true or applications
					break
				end
			end

			i = i + 1
			name, _, texture, applications, _, _, _, _, _, _, auraID = UnitAura(unit, i)
		end

		return retval
	end
end

function nibIceHUD:OnDisable()
	nibIceHUD.IceCore:Disable()
end

function nibIceHUD:PreProfileChanged(db)
	if UnitAffectingCombat("player") then
		StaticPopup_Show("NIBICEHUD_CHANGED_PROFILE_COMBAT")
	end
	self.IceCore:Disable()
end

function nibIceHUD:PostProfileChanged(db, newProfile)
	self:NotifyNewDb()
	if self.db.profile.enable then
		self.IceCore:Enable()
	end
end

function nibIceHUD:ProfileReset()
	ReloadUI()
end
function nibIceHUD:ProfileCopied()
	ReloadUI()
end

function nibIceHUD:Clamp(value, min, max)
	if value < min then
		value = min
	elseif value > max then
		value = max
	elseif value ~= value or not (value >= min and value <= max) then -- check for nan...
		value = min
	end

	return value
end

function nibIceHUD:ShouldSwapToVehicle(...)
	local arg1, arg2 = ...
	
	if (arg1 == "player") then
		if (arg2) then
			return true
		end
	end

	if (UnitHasVehicleUI("player")) then
		return true
	end
end

function nibIceHUD:xor(val1, val2)
	return val1 and not val2 or val2 and not val1
end

function nibIceHUD:GetSelectValue(info, val)
	for k,v in pairs(info.option.values) do
		if v == val then
			return k
		end
	end

	return 1
end

function nibIceHUD:Register(element)
	assert(element, "Trying to register a nil module")
	if not bReadyToRegisterModules then
		pendingModuleLoads[#pendingModuleLoads+1] = element
	else
		self.IceCore:Register(element)
	end
end

function nibIceHUD:RegisterPendingModules()
	for i=1, #pendingModuleLoads do
		self.IceCore:Register(pendingModuleLoads[i])
	end
	pendingModuleLoads = {}
end

function nibIceHUD:UpdateMedia(event, mediatype, key)
	if not self.db.profile or not self.IceCore.enabled then
		return
	end

	if mediatype == "font" then
		if key == self.db.profile.fontFamily then
			nibIceHUD.IceCore:SetFontFamily(key)
		end
	elseif mediatype == "statusbar" then
		if self.TargetOfTarget and self.TargetOfTarget.moduleSettings.enabled and key == self.TargetOfTarget.moduleSettings.texture then
			self.TargetOfTarget:Redraw()
		end
	end
end

function nibIceHUD:CreateCustomModuleAndNotify(moduleKey, settings)
	local newMod = nil
	local popupMsg
	if moduleKey == "Bar" then -- custom bar
		newMod = IceCustomBar:new()
		popupMsg = "NIBICEHUD_CUSTOM_BAR_CREATED"
	elseif moduleKey == "CD" then -- cooldown bar
		newMod = IceCustomCDBar:new()
		popupMsg = "NIBICEHUD_CUSTOM_CD_CREATED"
	end

	if newMod ~= nil then
		nibIceHUD.IceCore:AddNewDynamicModule(newMod, settings)
		ConfigDialog:SelectGroup("nibIceHUD", "modules", newMod.elementName)
		StaticPopup_Show(popupMsg)
	end
end