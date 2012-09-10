local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

function IceCore_CreateClass(parent)
	local class = { prototype = {} }
	if parent then
		class.super = parent
		setmetatable(class.prototype, { __index = parent.prototype })
	end
	local mt = { __index = class.prototype }
	function class:new(...)
		local self = setmetatable({}, mt)
		if self.init then
			self:init(...)
		end
		return self
	end

	return class
end

local GetFramerate = _G.GetFramerate

IceCore = IceCore_CreateClass()

IceCore.Side = { Left = "LEFT", Right = "RIGHT" }
IceCore.BuffLimit = 40

IceCore.prototype.defaults = {}
IceCore.prototype.settings = nil
IceCore.prototype.nibIceHUDFrame = nil
IceCore.prototype.updatees = {}
IceCore.prototype.fastupdatees = {}
IceCore.prototype.update_elapsed = 0
IceCore.prototype.elements = {}
IceCore.prototype.enabled = nil
IceCore.prototype.presets = {}
IceCore.prototype.bConfigMode = false

-- Constructor --
function IceCore.prototype:init()
	nibIceHUD:Debug("IceCore.prototype:init()")

	self.nibIceHUDFrame = CreateFrame("Frame","nibIceHUDFrame", UIParent)
end

function IceCore.prototype:SetupDefaults()
-- DEFAULT SETTINGS
	local defaultPreset = "CleanCurves"
	self.defaults = {
		profile = {
			enable = true,
			gap = 150,
			verticalPos = -110,
			horizontalPos = 0,
			scale = 0.9,

			alphaooc = 0.3,
			alphaic = 0.6,
			alphaTarget = 0.4,
			alphaNotFull = 0.4,

			alphaoocbg = 0.2,
			alphaicbg = 0.3,
			alphaTargetbg = 0.25,
			alphaNotFullbg = 0.25,

			backgroundToggle = false,
			backgroundColor = {r = 0.5, g = 0.5, b = 0.5},
			barTexture = "Bar",
			barPreset = defaultPreset,
			fontFamily = "Arial Narrow",
			fontFamilyLarge = "Arial Narrow",
			fontSize = 8,
			fontSizeLarge = 16,
			fontOutline = "MONOCHROMEOUTLINE",
			debug = false,

			barBlendMode = "BLEND",
			barBgBlendMode = "BLEND",

			updatePeriod = 0.033,
		},
		global = {
			lastRunVersion = 0,
		},
	}

	self:LoadPresets()
	for k, v in pairs(self.presets[defaultPreset]) do
		self.defaults.profile[k] = v
	end

	-- get default settings from the modules
	self.defaults.profile.modules = {}
	for i = 1, table.getn(self.elements) do
		local name = self.elements[i]:GetElementName()
		self.defaults.profile.modules[name] = self.elements[i]:GetDefaultSettings()
	end

	if (table.getn(self.elements) > 0) then
		self.defaults.profile.colors = self.elements[1].defaultColors
	end
end

function IceCore.prototype:CheckDisplayUpdateMessage()
	local thisVersion
	thisVersion = 829
	if self.accountSettings.lastRunVersion < thisVersion then
		self.accountSettings.lastRunVersion = thisVersion
	end
end


function IceCore.prototype:Enable(userToggle)
	if userToggle then
		self.settings.enable = true
	end

	self:DrawFrame()

	for i = 1, table.getn(self.elements) do
		-- make sure there are settings for this bar (might not if we make a new profile with existing custom bars)
		if self.settings.modules[self.elements[i].elementName] then
			self.elements[i]:Create(self.nibIceHUDFrame)
			if (self.elements[i]:IsEnabled()) then
				self.elements[i]:Enable(true)
			end
		end
	end

	-- go through the list of loaded elements that don't have associated settings and dump them
	do
		local toRemove = {}
		for i = #self.elements, 1, -1 do
			if not self.settings.modules[self.elements[i]:GetElementName()] then
				toRemove[#toRemove + 1] = i
			end
		end
		for i=1,#toRemove do
			table.remove(self.elements, toRemove[i])
		end
	end

	for k,v in pairs(self.settings.modules) do
		if self.settings.modules[k].customBarType == "Bar" and IceCustomBar ~= nil then
			local newBar
			newBar = IceCustomBar:new()
			newBar.elementName = k
			self:AddNewDynamicModule(newBar, true)
		elseif self.settings.modules[k].customBarType == "CD" and IceCustomCDBar ~= nil then
			local newCD
			newCD = IceCustomCDBar:new()
			newCD.elementName = k
			self:AddNewDynamicModule(newCD, true)
		end
	end

	if self.settings.updatePeriod == nil then
		self.settings.updatePeriod = 0.033
	end
	self.settings.updatePeriod = nibIceHUD:Clamp(self.settings.updatePeriod, 0, 0.067)

	-- make sure the module options are re-generated. if we switched profiles, we don't want the old elements hanging around
	if nibIceHUD.optionsLoaded then
		nibIceHUD_Options:GenerateModuleOptions()
	end

	self.enabled = true
end

function IceCore.prototype:AddNewDynamicModule(module, hasSettings)
	if not hasSettings then
		self.settings.modules[module.elementName] = module:GetDefaultSettings()
	elseif type(hasSettings) == "table" then
		self.settings.modules[module.elementName] = nibIceHUD.deepcopy(hasSettings)
	end

	module:SetDatabase(self.settings)

	if not hasSettings or type(hasSettings) == "table" then
		local numExisting = self:GetNumCustomModules(module, module:GetDefaultSettings().customBarType)
		self:RenameDynamicModule(module, "MyCustom"..module:GetDefaultSettings().customBarType..(numExisting+1))
	end

	module:Create(self.nibIceHUDFrame)
	if (module:IsEnabled()) then
		module:Enable(true)
	end

	if nibIceHUD.optionsLoaded then
		nibIceHUD_Options:GenerateModuleOptions()
	end
end


function IceCore.prototype:GetNumCustomModules(exceptMe, customBarType)
	local num = 0
	local foundNum = 0

	for i=1,table.getn(self.elements) do
		if (self.elements[i] and self.elements[i] ~= exceptMe and
			customBarType == self.elements[i].moduleSettings.customBarType) then
			local str = self.elements[i].elementName:match("MyCustom"..(customBarType).."%d+")
			if str then
				foundNum = str:match("%d+")
			end

			num = max(num, foundNum)
		end
	end

	return num
end


function IceCore.prototype:DeleteDynamicModule(module)
	if module:IsEnabled() then
		module:Disable()
	end

	local ndx
	for i = 1,table.getn(self.elements) do
		if (self.elements[i] == module) then
			ndx = i
			break
		end
	end

	table.remove(self.elements,ndx)
	self.settings.modules[module.elementName] = nil

	if nibIceHUD.optionsLoaded then
		nibIceHUD_Options:GenerateModuleOptions()
	end
end


function IceCore.prototype:RenameDynamicModule(module, newName)
	self.settings.modules[newName] = self.settings.modules[module.elementName]
	self.settings.modules[module.elementName] = nil

	module.elementName = newName

	if nibIceHUD.optionsLoaded then
		nibIceHUD_Options:GenerateModuleOptions()
	end

	LibStub("AceConfigDialog-3.0"):SelectGroup("nibIceHUD", "modules", newName)
end


function IceCore.prototype:ProfileChanged()
	self:SetModuleDatabases()

	self:Redraw()
end


function IceCore.prototype:SetModuleDatabases()
	for i = 1, table.getn(self.elements) do
		self.elements[i]:SetDatabase(self.settings)
	end
end


function IceCore.prototype:Disable(userToggle)
	if userToggle then
		self.settings.enable = false
	end

	self:ConfigModeToggle(false)

	for i = 1, table.getn(self.elements) do
		if (self.elements[i]:IsEnabled()) then
			self.elements[i]:Disable(true)
		end
	end

	self.nibIceHUDFrame:Hide()
	self:EmptyUpdates()

	for i=#self.elements, 1, -1 do
		if self.elements[i].moduleSettings.customBarType ~= nil then
			table.remove(self.elements, i)
		end
	end

	self.enabled = false
end


function IceCore.prototype:IsEnabled()
	return self.enabled
end

function IceCore.prototype:DrawFrame()
	self.nibIceHUDFrame:SetFrameStrata("BACKGROUND")
	self.nibIceHUDFrame:SetWidth(self.settings.gap)
	self.nibIceHUDFrame:SetHeight(20)

	self:SetScale(self.settings.scale)

	self.nibIceHUDFrame:SetPoint("CENTER", self.settings.horizontalPos, self.settings.verticalPos)
	self.nibIceHUDFrame:Show()
end


function IceCore.prototype:Redraw()
	for i = 1, table.getn(self.elements) do
		self.elements[i]:Redraw()
	end
end


function IceCore.prototype:GetModuleOptions()
	local options = {}

	options["aaaClickPlus"] = {
		type = 'description',
		fontSize = 'large',
		name = L["Click the + next to |cffffdc42Module Settings|r to see the available modules that you can tweak.\n\nAlso notice that some modules have a + next to them. This will open up additional settings such as text tweaks and icon tweaks on that module."],
		order = 1
	}

	for i = 1, table.getn(self.elements) do
		local modName = self.elements[i]:GetElementName()
		local opt = self.elements[i]:GetOptions()
		options[modName] =  {
			type = 'group',
			desc = L["Module options"],
			name = modName,
			args = opt
		}
	end

	return options
end


function IceCore.prototype:GetColorOptions()
	local options = {}

	if #self.elements > 0 then
		for k, v in pairs(self.elements[1]:GetColors()) do
			options[k] =  {
				type = 'color',
				desc = k,
				name = k,
				get = function()
					return nibIceHUD.IceCore:GetColor(k)
				end,
				set = function(info, r, g, b)
					local color = k
					nibIceHUD.IceCore:SetColor(k, r, g, b)
				end
			}
		end
	end

	return options
end


-- Method to handle module registration
function IceCore.prototype:Register(element)
	assert(element, "Trying to register a nil module")
	nibIceHUD:Debug("Registering: " .. element:ToString())
	table.insert(self.elements, element)
end



-------------------------------------------------------------------------------
-- Configuration methods                                                     --
-------------------------------------------------------------------------------

function IceCore.prototype:GetVerticalPos()
	return self.settings.verticalPos
end
function IceCore.prototype:SetVerticalPos(value)
	self.settings.verticalPos = value
	self.nibIceHUDFrame:ClearAllPoints()
	self.nibIceHUDFrame:SetPoint("CENTER", self.settings.horizontalPos, self.settings.verticalPos)
end

function IceCore.prototype:GetHorizontalPos()
	return self.settings.horizontalPos
end
function IceCore.prototype:SetHorizontalPos(value)
	self.settings.horizontalPos = value
	self.nibIceHUDFrame:ClearAllPoints()
	self.nibIceHUDFrame:SetPoint("CENTER", self.settings.horizontalPos, self.settings.verticalPos)
end


function IceCore.prototype:GetGap()
	return self.settings.gap
end
function IceCore.prototype:SetGap(value)
	self.settings.gap = value
	self.nibIceHUDFrame:SetWidth(self.settings.gap)
	self:Redraw()
end


function IceCore.prototype:GetScale()
	return self.settings.scale
end
function IceCore.prototype:SetScale(value)
	self.settings.scale = value

	self.nibIceHUDFrame:SetScale(value)
end


function IceCore.prototype:GetAlpha(mode)
	if (mode == "IC") then
		return self.settings.alphaic
	elseif (mode == "Target") then
		return self.settings.alphaTarget
	elseif (mode == "NotFull") then
		return self.settings.alphaNotFull
	else
		return self.settings.alphaooc
	end
end
function IceCore.prototype:SetAlpha(mode, value)
	if (mode == "IC") then
		self.settings.alphaic = value
	elseif (mode == "Target") then
		self.settings.alphaTarget = value
	elseif (mode == "NotFull") then
		self.settings.alphaNotFull = value
	else
		self.settings.alphaooc = value
	end
	self:Redraw()
end


function IceCore.prototype:GetAlphaBG(mode)
	if (mode == "IC") then
		return self.settings.alphaicbg
	elseif (mode == "Target") then
		return self.settings.alphaTargetbg
	elseif (mode == "NotFull") then
		return self.settings.alphaNotFullbg
	else
		return self.settings.alphaoocbg
	end
end
function IceCore.prototype:SetAlphaBG(mode, value)
	if (mode == "IC") then
		self.settings.alphaicbg = value
	elseif (mode == "Target") then
		self.settings.alphaTargetbg = value
	elseif (mode == "NotFull") then
		self.settings.alphaNotFullbg = value
	else
		self.settings.alphaoocbg = value
	end
	self:Redraw()
end


function IceCore.prototype:GetBackgroundToggle()
	return self.settings.backgroundToggle
end
function IceCore.prototype:SetBackgroundToggle(value)
	self.settings.backgroundToggle = value
	self:Redraw()
end


function IceCore.prototype:GetBackgroundColor()
	local c = self.settings.backgroundColor
	return c.r, c.g, c.b
end
function IceCore.prototype:SetBackgroundColor(r, g, b)
	self.settings.backgroundColor.r = r
	self.settings.backgroundColor.g = g
	self.settings.backgroundColor.b = b
	self:Redraw()
end


function IceCore.prototype:GetBarTexture()
	return self.settings.barTexture
end
function IceCore.prototype:SetBarTexture(value)
	self.settings.barTexture = value
	self:Redraw()
end


function IceCore.prototype:GetBarBlendMode()
	return self.settings.barBlendMode
end
function IceCore.prototype:SetBarBlendMode(value)
	self.settings.barBlendMode = value
	self:Redraw()
end


function IceCore.prototype:GetBarBgBlendMode()
	return self.settings.barBgBlendMode
end
function IceCore.prototype:SetBarBgBlendMode(value)
	self.settings.barBgBlendMode = value
	self:Redraw()
end


function IceCore.prototype:GetBarWidth()
	return self.settings.barWidth
end
function IceCore.prototype:SetBarWidth(value)
	self.settings.barWidth = value
	self:Redraw()
end


function IceCore.prototype:GetBarHeight()
	return self.settings.barHeight
end
function IceCore.prototype:SetBarHeight(value)
	self.settings.barHeight = value
	self:Redraw()
end


function IceCore.prototype:GetBarProportion()
	return self.settings.barProportion
end
function IceCore.prototype:SetBarProportion(value)
	self.settings.barProportion = value
	self:Redraw()
end


function IceCore.prototype:GetBarSpace()
	return self.settings.barSpace
end
function IceCore.prototype:SetBarSpace(value)
	self.settings.barSpace = value
	self:Redraw()
end


function IceCore.prototype:GetBarPreset()
	return self.settings.barPreset
end
function IceCore.prototype:SetBarPreset(value)
	self.settings.barPreset = value
	self:ChangePreset(value)
	self:Redraw()
end
function IceCore.prototype:ChangePreset(value)
	self:SetBarTexture(self.presets[value].barTexture)
	self:SetBarHeight(self.presets[value].barHeight)
	self:SetBarWidth(self.presets[value].barWidth)
	self:SetBarSpace(self.presets[value].barSpace)
	self:SetBarProportion(self.presets[value].barProportion)
	self:SetBarBlendMode(self.presets[value].barBlendMode)
	self:SetBarBgBlendMode(self.presets[value].barBgBlendMode)

	nibIceHUD:NotifyOptionsChange()
end


function IceCore.prototype:GetFontSizeLarge()
	return self.settings.fontSizeLarge
end
function IceCore.prototype:SetFontSizeLarge(value)
	self.settings.fontSizeLarge = value
	self:Redraw()
end

function IceCore.prototype:GetFontSize()
	return self.settings.fontSize
end
function IceCore.prototype:SetFontSize(value)
	self.settings.fontSize = value
	self:Redraw()
end

function IceCore.prototype:GetFontOutline()
	return self.settings.fontOutline
end
function IceCore.prototype:SetFontOutline(value)
	self.settings.fontOutline = value
	self:Redraw()
end

function IceCore.prototype:GetFontFamilyLarge()
	return self.settings.fontFamilyLarge
end
function IceCore.prototype:SetFontFamilyLarge(value)
	self.settings.fontFamilyLarge = value
	self:Redraw()
end

function IceCore.prototype:GetFontFamily()
	return self.settings.fontFamily
end
function IceCore.prototype:SetFontFamily(value)
	self.settings.fontFamily = value
	self:Redraw()
end


function IceCore.prototype:GetDebug()
	return self.settings.debug
end
function IceCore.prototype:SetDebug(value)
	self.settings.debug = value
	nibIceHUD:SetDebugging(value)
end


function IceCore.prototype:GetColor(color)
	return self.settings.colors[color].r,
		   self.settings.colors[color].g,
		   self.settings.colors[color].b
end
function IceCore.prototype:SetColor(color, r, g, b)
	self.settings.colors[color].r = r
	self.settings.colors[color].g = g
	self.settings.colors[color].b = b

	self:Redraw()
end


function IceCore.prototype:IsInConfigMode()
	return self.bConfigMode
end

function IceCore.prototype:ConfigModeToggle(bWantConfig)
	if self.bConfigMode == bWantConfig then
		return
	end

	self.bConfigMode = bWantConfig

	if bWantConfig then
		for i = 1, table.getn(self.elements) do
			if self.elements[i]:IsEnabled() then
				self.elements[i].masterFrame:Show()
				self.elements[i].frame:Show()
				self.elements[i]:Redraw()
				if self.elements[i].IsBarElement then
					self.elements[i]:SetBottomText1(self.elements[i].elementName)
				end
			end
		end
	else
		for i = 1, table.getn(self.elements) do
			if not self.elements[i]:IsVisible() then
				self.elements[i].masterFrame:Hide()
				self.elements[i].frame:Hide()
			end

			-- blank the bottom text that we set before. if the module uses this text, it will reset itself on redraw
			if self.elements[i].IsBarElement and self.elements[i].frame then
				self.elements[i]:SetBottomText1()
			end

			self.elements[i]:Redraw()
		end
	end
end

function IceCore.prototype:UpdatePeriod()
	return self.settings.updatePeriod
end

function IceCore.prototype:SetUpdatePeriod(period)
	self.settings.updatePeriod = period
end

-- For elements that want to receive updates even when hidden
local FastModules = {
	["CastBar"] = true,
	["TargetCast"] = true,
	["TargetTargetCast"] = true,
	["FocusCast"] = true,
}
function IceCore.prototype:HandleUpdates()
	local update_period = self.settings.updatePeriod
	local elapsed = 1 / GetFramerate()
	
	self.update_elapsed = self.update_elapsed + elapsed
	
	-- Fast
	for module, func in pairs(self.updatees) do
		if FastModules[module.elementName] then
			func()
		end
	end
	
	-- Slow
	if (self.update_elapsed >= update_period) then
		for module, func in pairs(self.updatees) do
			if not FastModules[module.elementName] then
				func()
			end
		end
		
		self.update_elapsed = self.update_elapsed - update_period
	end
end

function IceCore.prototype:RequestUpdates(module, func)
	if self.updatees[module] ~= func then
		self.updatees[module] = func
	end
	
	local count = 0
	for k,v in pairs(self.updatees) do
		count = count + 1
	end

	if (count == 0) then
		self.nibIceHUDFrame:SetScript("OnUpdate", nil)
	else
		if not self.UpdateFunc then
			self.UpdateFunc = function() self:HandleUpdates() end
		end

		if self.nibIceHUDFrame:GetScript("OnUpdate") ~= self.UpdateFunc then
			self.nibIceHUDFrame:SetScript("OnUpdate", self.UpdateFunc)
		end
	end
end

function IceCore.prototype:IsUpdateSubscribed(module)
	return (self.updatees[module] ~= nil)
end

function IceCore.prototype:EmptyUpdates()
	self.nibIceHUDFrame:SetScript("OnUpdate", nil)
	self.updatees = {}
	self.fastupdatees = {}
end

-------------------------------------------------------------------------------
-- Presets                                                                   --
-------------------------------------------------------------------------------

function IceCore.prototype:LoadPresets()
	self.presets["CleanCurves"] = {
		barTexture = "CleanCurves",
		barWidth = 155,
		barHeight = 220,
		barProportion = 0.14,
		barSpace = 1,
		barBlendMode = "BLEND",
		barBgBlendMode = "BLEND",
	}
end

