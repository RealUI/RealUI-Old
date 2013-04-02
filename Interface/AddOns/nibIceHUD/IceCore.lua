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
			gap1 = 114,
			gap2 = 114,

			alphaooc = 0.3,
			alphaic = 0.8,
			alphaTarget = 0.4,
			alphaNotFull = 0.7,

			alphaoocbg = 0.25,
			alphaicbg = 0.5,
			alphaTargetbg = 0.4,
			alphaNotFullbg = 0.4,

			backgroundToggle = false,
			backgroundColor = {r = 0.5, g = 0.5, b = 0.5},
			barTexture = "Bar",
			barPreset = defaultPreset,
			
			fontFamily1 = "pixel_lr_small",
			fontFamilyLarge1 = "pixel_lr_small",
			fontSize1 = 8,
			fontSizeLarge1 = 16,
			fontOutline1 = "MONOCHROMEOUTLINE",
			
			fontFamily2 = "pixel_hr_small",
			fontFamilyLarge2 = "pixel_lr_small",
			fontSize2 = 8,
			fontSizeLarge2 = 16,
			fontOutline2 = "MONOCHROMEOUTLINE",
			
			debug = false,

			barBlendMode = "BLEND",
			barBgBlendMode = "BLEND",
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
		end
	end

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
	local layout = RealUI and RealUI.db.char.resolution or 1
	self.nibIceHUDFrame:SetFrameStrata("BACKGROUND")
	self.nibIceHUDFrame:SetWidth(self.settings["gap"..layout])
	self.nibIceHUDFrame:SetHeight(20)
	self.nibIceHUDFrame:SetPoint("CENTER", _G.RealUIPositionersHuD, "CENTER", 0, 0)
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
		fontSize = 'medium',
		name = "Click the + next to |cffffdc42Module Settings|r to see the available modules that you can tweak.\n\nAlso notice that some modules have a + next to them. This will open up additional settings such as text tweaks and icon tweaks on that module.",
		order = 1
	}
	
	options["ClassAuras"] = {
		type = 'group',
		name = "Class Auras",
		args = {},
	}
	for k,v in pairs(RAID_CLASS_COLORS) do
		options["ClassAuras"].args[k] = {
			type = 'group',
			name = k,
			args = {},
		}
	end
	for i = 1, table.getn(self.elements) do
		local modName = self.elements[i]:GetElementName()
		local opt = self.elements[i]:GetOptions()
		local class = self.elements[i].moduleSettings.class
		if class and class ~= "ALL" then
			options["ClassAuras"].args[class].args[modName] = {
				type = 'group',
				desc = "Module options",
				name = modName,
				args = opt
			}
		else
			options[modName] =  {
				type = 'group',
				desc = "Module options",
				name = modName,
				args = opt
			}
		end
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

function IceCore.prototype:GetGap(layout)
	return self.settings["gap"..layout]
end
function IceCore.prototype:SetGap(value, layout)
	self.settings["gap"..layout] = value
	self.nibIceHUDFrame:SetWidth(self.settings["gap"..layout])
	self:Redraw()
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


function IceCore.prototype:GetFontSizeLarge(layout)
	return self.settings["fontSizeLarge"..layout]
end
function IceCore.prototype:SetFontSizeLarge(value, layout)
	self.settings["fontSizeLarge"..layout] = value
	self:Redraw()
end

function IceCore.prototype:GetFontSize(layout)
	return self.settings["fontSize"..layout]
end
function IceCore.prototype:SetFontSize(value, layout)
	self.settings["fontSize"..layout] = value
	self:Redraw()
end

function IceCore.prototype:GetFontOutline(layout)
	return self.settings["fontOutline"..layout]
end
function IceCore.prototype:SetFontOutline(value, layout)
	self.settings["fontOutline"..layout] = value
	self:Redraw()
end

function IceCore.prototype:GetFontFamilyLarge(layout)
	return self.settings["fontFamilyLarge"..layout]
end
function IceCore.prototype:SetFontFamilyLarge(value, layout)
	self.settings["fontFamilyLarge"..layout] = value
	self:Redraw()
end

function IceCore.prototype:GetFontFamily(layout)
	return self.settings["fontFamily"..layout]
end
function IceCore.prototype:SetFontFamily(value, layout)
	self.settings["fontFamily"..layout] = value
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

-- For elements that want to receive updates even when hidden
local FastModules = {
	["CastBar"] = true,
	["TargetCast"] = true,
	["TargetTargetCast"] = true,
	["FocusCast"] = true,
	["TargetCC"] = true,
	["TargetInvuln"] = true,
}
function IceCore.prototype:HandleUpdates()
	local update_period = 0.033
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

