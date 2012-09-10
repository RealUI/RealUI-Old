local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local MODNAME = "ActionBarExtras"
local ActionBarExtras = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

local EnteredWorld = false
local Bar4, Bar4Profile, BSB, BTB

local Textures = {
	PetBar = {
		surround = [[Interface\Addons\nibRealUI\Media\Doodads\PetBar_Surround]],
		background = [[Interface\Addons\nibRealUI\Media\Doodads\PetBar_Background]],
	},
}

local PetBarDoodad

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
		name = "Action Bar Extras",
		desc = "Adds some extra features to the Action Bars.",
		arg = MODNAME,
		childGroups = "tab",
		disabled = function() return not(Bar4) end,
		order = 103,
		args = {
			header = {
				type = "header",
				name = "Action Bar Extras",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Adds some extra features to the Action Bars.",
				fontSize = "medium",
				order = 20,
			},
			desc2 = {
				type = "description",
				name = " ",
				order = 21,
			},
			desc3 = {
				type = "description",
				name = "Note: You will need to reload the UI (/rl) for some changes to take effect.",
				order = 22,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Action Bar Extras module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
					nibRealUI:ReloadUIDialog()
				end,
				order = 30,
			},
			petbar = {
				name = "Pet Bar Indicator",
				type = "group",
				inline = true,
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				order = 50,
				args = {
					enabled = {
						type = "toggle",
						name = "Enabled",
						width = "full",
						get = function(info) return db.petbar.enabled end,
						set = function(info, value) 
							db.petbar.enabled = value 
							ActionBarExtras:UpdatePetBar()
						end,
						order = 10,
					},
				},
			},
			stancebar = {
				name = "Stance Bar Centering",
				type = "group",
				inline = true,
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				order = 60,
				args = {
					enabled = {
						type = "toggle",
						name = "Enabled",
						width = "full",
						get = function(info) return db.stancebar.enabled end,
						set = function(info, value) 
							db.stancebar.enabled = value 
							nibRealUI:ReloadUIDialog()
						end,
						order = 10,
					},
					x = {
						type = "input",
						name = "X Offset",
						width = "half",
						order = 20,
						get = function(info) return tostring(db.stancebar.xoffset) end,
						set = function(info, value)
							value = nibRealUI:ValidateOffset(value)
							db.stancebar.xoffset = value
							ActionBarExtras:UpdateStanceBar()
						end,
					},
				},
			},
			totembar = {
				name = "Totem Bar Improvements",
				type = "group",
				inline = true,
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				order = 70,
				args = {
					enabled = {
						type = "toggle",
						name = "Enabled",
						width = "full",
						get = function(info) return db.totembar.enabled end,
						set = function(info, value) 
							db.totembar.enabled = value
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

---- TotemBar functions
local TotemTimers = {
	Texts = {},
}

-- OnUpdate
local function TotemOnUpdate(self)
	local time = GetTime()
	
	if time > self.lastupdate + 0.2 then
		local TimeLeft = GetTotemTimeLeft(self.TotemID)
		if TimeLeft > 0 then
			-- Totem active, show/update
			local NewTimeString = string.format(SecondsToTimeAbbrev(TimeLeft))
			NewTimeString = gsub(NewTimeString, " ", "")
			
			self.text:SetText(NewTimeString)
			self.bar:SetValue(TimeLeft)
			self.bar:Show()
			
			self.lastupdate = time
		else
			-- Totem inactive, hide
			self.text:SetText("")
			self.bar:Hide()
			--self:Hide()
		end
	end
end

-- OnEvent
local function TotemOnEvent(self, event, TotemID)
	if TotemID ~= self.TotemID then
		return
	end
	
	-- Find which Totem Page we're on
	local page = 1
	for p = 1, 3 do
		local mcap = _G["MultiCastActionPage"..p]
		if mcap then
			if mcap:IsShown() then page = p end
		end
	end
	
	-- Show this page's button if it has a duration
	local _, _, start, duration = GetTotemInfo(TotemID)
	if ( (duration > 0) and (self.Page == page) ) then
		self.start = start
		self.duration = duration
		self.bar:SetMinMaxValues(0, duration)
		self:Show()
	else
		self:Hide()
		self.bar:Hide()
	end
end

-- Refresh all Totem timers
local function ReupdateTotems()
	for i = 1, 12 do
		TotemOnEvent(TotemTimers.Texts[i], "PLAYER_TOTEM_UPDATE", TotemTimers.Texts[i].TotemID)
	end
end

-- Destroy Totem
local function KillTotem(self, button)
	if (button ~= "RightButton") then return end
	if ( (self:GetName() == "MultiCastActionButton1") or (self:GetName() == "MultiCastActionButton5") or (self:GetName() == "MultiCastActionButton9") ) then
		DestroyTotem(2)
	elseif ( (self:GetName() == "MultiCastActionButton2") or (self:GetName() == "MultiCastActionButton6") or (self:GetName() == "MultiCastActionButton10") ) then
		DestroyTotem(1)
	elseif ( (self:GetName() == "MultiCastActionButton3") or (self:GetName() == "MultiCastActionButton7") or (self:GetName() == "MultiCastActionButton11") ) then
		DestroyTotem(3)
	elseif ( (self:GetName() == "MultiCastActionButton4") or (self:GetName() == "MultiCastActionButton8") or (self:GetName() == "MultiCastActionButton12") ) then
		DestroyTotem(4)
	end
end

local TotemBarSetup = false
local TotemNeedUpdate
function ActionBarExtras:UpdateTotemBar()
	if not((nibRealUI.class == "SHAMAN") and db.totembar.enabled and nibRealUI:GetModuleEnabled(MODNAME) and BTB) or TotemBarSetup then return end
	if InCombatLockdown() then TotemNeedUpdate = true; return end
	TotemNeedUpdate = false
	
	-- Create Timers
	local TotemColors = {
		[1] = {r = 0.3, g = 0.55, b = 0.15},
		[2] = {r = 0.8, g = 0.4, b = 0.13},
		[3] = {r = 0.2, g = 0.55, b = 0.7},
		[4] = {r = 0.7, g = 0.3, b = 0.9},
	}
	local TotemOrder = {[1] = 2, [2] = 1, [3] = 3, [4] = 4}
	
	for i = 1, 4 do
		for j = 1, 4 do
			local buid = ((j - 1) * 4) + i
			local bu = _G["MultiCastActionButton"..buid]
			
			-- Text
			local TotemText = CreateFrame("Frame", nil, bu)
			TotemTimers.Texts[buid] = TotemText
			
			TotemText:SetParent(bu)
			TotemText:SetAllPoints(bu)
			TotemText:SetScale(1/0.9)
			TotemText:SetFrameStrata("MEDIUM")
			TotemText:SetFrameLevel(10)
			
			TotemText.TotemID = TotemOrder[i]
			TotemText.ButtonID = buid
			TotemText.Page = j
			TotemText.lastupdate = 0		
			
			TotemText.text = TotemText:CreateFontString(nil, "OVERLAY")
			TotemText.text:SetPoint("BOTTOM", TotemText, "BOTTOM", .5, 2)
			TotemText.text:SetWidth(TotemText:GetWidth() + 4)
			TotemText.text:SetFont(unpack(nibRealUI.font.pixel1))
			TotemText.text:SetJustifyH("CENTER")
			TotemText.text:SetTextColor(1, 1, 1)
			
			-- StatusBar
			local SBar = CreateFrame("StatusBar", nil, bu)
			SBar:Hide()
			SBar:SetPoint("TOPLEFT", bu, "BOTTOMLEFT", 1, 5)
			SBar:SetPoint("TOPRIGHT", bu, "BOTTOMRIGHT", -1, 5)
			SBar:SetHeight(4)
			SBar:SetFrameStrata("MEDIUM")
			SBar:SetFrameLevel(10)
			
			SBar:SetStatusBarTexture(nibRealUI.media.textures.plain)
			SBar:GetStatusBarTexture():SetHorizTile(false)
			SBar:SetBackdrop({bgFile = nibRealUI.media.textures.plain, tile = false, tileSize = 0, insets = {left = -1, right = -1, top = -1, bottom = -1},})
			SBar:SetBackdropColor(0, 0, 0, 0.75)
			SBar:SetStatusBarColor(TotemColors[i].r, TotemColors[i].g, TotemColors[i].b)
			
			TotemText.bar = SBar
			
			-- Events
			TotemText:SetScript("OnEvent", TotemOnEvent)
			TotemText:SetScript("OnUpdate", TotemOnUpdate)
			TotemText:SetScript("OnHide", function(self) 
				self.start = nil
				self.duration = nil
				self.bar:Hide()
			end)
			TotemText:SetScript("OnShow", function(self)
				if ( not self.start or not self.duration ) then
					return self:Hide()
				end
			end)
			TotemText:RegisterEvent("PLAYER_TOTEM_UPDATE")
			TotemOnEvent(TotemText, "PLAYER_TOTEM_UPDATE", TotemText.TotemID)
		end
	end
	
	-- Set Textures
	for i = 1, 4 do
		local bu = _G["MultiCastSlotButton"..i]
		
		select(2, bu:GetRegions()):Hide()
		
		bu:ClearAllPoints()
		
		if i ~= 1 then
			bu:SetPoint("LEFT", _G["MultiCastSlotButton"..i-1], "RIGHT", 1, 0)
		end
		
		nibRealUI:CreateBD(bu, 0)
	end

	MultiCastSlotButton1:SetPoint("LEFT", MultiCastSummonSpellButton, "RIGHT", 1, 0)

	MultiCastSummonSpellButtonNormalTexture:SetVertexColor(0, 0, 0, 0)
	MultiCastSummonSpellButton:SetPushedTexture("")
	MultiCastSummonSpellButton:SetCheckedTexture("")
	MultiCastSummonSpellButtonIcon:SetTexCoord(.08, .92, .08, .92)
	MultiCastSummonSpellButtonHighlight:SetAlpha(0)
	nibRealUI:CreateBD(MultiCastSummonSpellButton, 0)

	MultiCastRecallSpellButton:ClearAllPoints()
	MultiCastRecallSpellButton:SetPoint("LEFT", MultiCastSlotButton4, "RIGHT", 1, 0)
	MultiCastRecallSpellButtonNormalTexture:SetVertexColor(0, 0, 0, 0)
	MultiCastRecallSpellButton:SetPushedTexture("")
	MultiCastRecallSpellButton:SetCheckedTexture("")
	MultiCastRecallSpellButtonIcon:SetTexCoord(.08, .92, .08, .92)
	MultiCastRecallSpellButtonHighlight:SetAlpha(0)
	nibRealUI:CreateBD(MultiCastRecallSpellButton, 0)

	for i = 1, 12 do
		local bu = _G["MultiCastActionButton"..i]
		
		bu:RegisterForClicks("LeftButtonUp")
		bu:HookScript("OnMouseUp", KillTotem)

		bu:SetPushedTexture("")
		select(14, bu:GetRegions()):Hide()
		bu:SetNormalTexture("")
		bu.SetNormalTexture = function() end
		_G["MultiCastActionButton"..i.."Icon"]:SetTexCoord(.08, .92, .08, .92)

		nibRealUI:CreateBD(bu, 0)
	end
	
	-- Finalize Totem Bar
	if MultiCastActionBarFrame then
		MultiCastActionBarFrame:SetScript("OnUpdate", nil)
		MultiCastActionBarFrame:SetScript("OnShow", ReupdateTotems)
		MultiCastActionBarFrame:SetScript("OnHide", nil)
	 
		MultiCastActionBarFrame.SetParent = function() end
		--MultiCastActionBarFrame.SetPoint = function() end
		MultiCastRecallSpellButton.SetPoint = function() end
	end
	
	ReupdateTotems()
	
	TotemBarSetup = true
end

---- StanceBar functions
local StanceNeedUpdate
function ActionBarExtras:UpdateStanceBar()
	if not(db.stancebar.enabled and nibRealUI:GetModuleEnabled(MODNAME) and Bar4 and BSB) then return end
	if not BSB.bar then return end
	if InCombatLockdown() then StanceNeedUpdate = true; return end
	StanceNeedUpdate = false
	
	local NumStances = GetNumShapeshiftForms()
	if NumStances < 1 then return end
	
	Bar4Profile = Bartender4DB["profileKeys"][nibRealUI.key]
	local sbP = Bartender4DB["namespaces"]["StanceBar"]["profiles"][Bar4Profile]["padding"]
	local sbS = Bartender4DB["namespaces"]["StanceBar"]["profiles"][Bar4Profile]["position"]["scale"]
	local sbW = (NumStances * 30) + ((NumStances - 1) * sbP)
	local sbX = floor(-(sbW / 2) * sbS) + 0.5 + db.stancebar.xoffset
	
	Bartender4DB["namespaces"]["StanceBar"]["profiles"][Bar4Profile]["position"]["x"] = sbX
	BSB.bar:ApplyConfig(Bartender4DB["namespaces"]["StanceBar"]["profiles"][Bar4Profile])
end

---- PetBar functions
function ActionBarExtras:TogglePetBar()
	if not PetBarDoodad then return end
	
	if ( db.petbar.enabled and nibRealUI:GetModuleEnabled(MODNAME) and (UnitExists("Pet") and not UnitInVehicle("player")) and nibRealUI.db.char.layout.current == 1 ) then
		PetBarDoodad:Show()
	else
		PetBarDoodad:Hide()
	end
end

function ActionBarExtras:UpdatePetBar()
	if not PetBarDoodad then return end
	
	-- Color
	local color = nibRealUI:GetClassColor(nibRealUI.class)
	PetBarDoodad.surround:SetVertexColor(1, 1, 1, 1)
	PetBarDoodad.background:SetVertexColor(color[1], color[2], color[3], 0.85)
	
	-- Size/Position
	Bar4Profile = Bartender4DB["profileKeys"][nibRealUI.key]
	local pbX = Bartender4DB["namespaces"]["PetBar"]["profiles"][Bar4Profile]["position"]["x"]
	local pbY = Bartender4DB["namespaces"]["PetBar"]["profiles"][Bar4Profile]["position"]["y"]
	local pbA = Bartender4DB["namespaces"]["PetBar"]["profiles"][Bar4Profile]["position"]["point"]
	PetBarDoodad:ClearAllPoints()
	PetBarDoodad:SetPoint(pbA, "UIParent", pbA, floor(pbX + 132), floor(pbY - 18))
end

local function MakePetBarDoodad()
	-- PetBar
	PetBarDoodad = CreateFrame("Frame", nil, UIParent)
	
	PetBarDoodad:ClearAllPoints()
	PetBarDoodad:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
	PetBarDoodad:SetFrameStrata("BACKGROUND")
	PetBarDoodad:SetFrameLevel(1)
	PetBarDoodad:SetHeight(32)
	PetBarDoodad:SetWidth(64)
	
	PetBarDoodad:RegisterEvent("PLAYER_ENTERING_WORLD")
	PetBarDoodad:RegisterEvent("UNIT_PET")
	PetBarDoodad:SetScript("OnEvent", function(self)
		ActionBarExtras:UpdatePetBar()
	end)
	
	PetBarDoodad.surround = PetBarDoodad:CreateTexture(nil, "ARTWORK")
	PetBarDoodad.surround:SetAllPoints(PetBarDoodad)
	PetBarDoodad.surround:SetTexture(Textures.PetBar.surround)
	
	PetBarDoodad.background = PetBarDoodad:CreateTexture(nil, "ARTWORK")
	PetBarDoodad.background:SetAllPoints(PetBarDoodad)
	PetBarDoodad.background:SetTexture(Textures.PetBar.background)
end

---- Lockdown
local LT = CreateFrame("Frame")
LT:Hide()
LT.e = 0
LT:SetScript("OnUpdate", function(s, e)
	s.e = s.e + e
	if s.e > 1 then
		if not InCombatLockdown() then
			if StanceNeedUpdate then ActionBarExtras:UpdateStanceBar() end
			s.e = 0
			s:Hide()
		else
			s.e = 0
		end
	end
end)
function ActionBarExtras:PLAYER_REGEN_ENABLED()
	if StanceNeedUpdate or TotemNeedUpdate then 
		LT:Show()
	end
end

----
function ActionBarExtras:RefreshMod()
	if not(nibRealUI:GetModuleEnabled(MODNAME) and Bar4) then return end
	
	db = self.db.profile
	
	if not PetBarDoodad then MakePetBarDoodad() end
	self:UpdatePetBar()
	self:TogglePetBar()
	self:UpdateStanceBar()
	self:UpdateTotemBar()
end

local function ClassColorsUpdate()
	if not(nibRealUI:GetModuleEnabled(MODNAME) and Bar4) then return end
	
	ActionBarExtras:UpdatePetBar()
end

function ActionBarExtras:UPDATE_SHAPESHIFT_FORMS()
	self:UpdateStanceBar()
end

function ActionBarExtras:UNIT_PET()
	self:TogglePetBar()
end

function ActionBarExtras:PLAYER_ENTERING_WORLD()
	if not Bar4 then return end
	
	self:UpdateStanceBar()
	self:TogglePetBar()
	
	if EnteredWorld then return end
	
	self:RegisterEvent("UNIT_PET")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	
	self:RefreshMod()
	
	if CUSTOM_CLASS_COLORS then
		CUSTOM_CLASS_COLORS:RegisterCallback(ClassColorsUpdate)
	end
	
	EnteredWorld = true
end

function ActionBarExtras:PLAYER_LOGIN()
	if IsAddOnLoaded("Bartender4") and Bartender4DB then
		Bar4 = LibStub("AceAddon-3.0"):GetAddon("Bartender4", true)
		BSB = Bar4:GetModule("StanceBar", true)
		BTB = Bar4:GetModule("MultiCast", true)
	end
	
	-- Totem Hook needs to happen early
	if not((nibRealUI.class == "SHAMAN") and db.totembar.enabled and nibRealUI:GetModuleEnabled(MODNAME) and BTB) or TotemBarSetup then return end
	hooksecurefunc("MultiCastActionButton_Update", function(actionbutton)
		if not InCombatLockdown() then actionbutton:SetAllPoints(actionbutton.slotButton) end
	end)
end

function ActionBarExtras:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			petbar = {
				enabled = true,
			},
			stancebar = {
				enabled = true,
				xoffset = -5,
			},
			totembar = {
				enabled = true,
			},
		},
	})
	db = self.db.profile

	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterPlainOptions(MODNAME, GetOptions)
end

function ActionBarExtras:OnEnable()	
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	if EnteredWorld then 
		self:RefreshMod()
	end
end

function ActionBarExtras:OnDisable()
	self:TogglePetBar()
end