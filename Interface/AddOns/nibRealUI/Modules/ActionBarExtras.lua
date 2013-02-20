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
		},
	}
	end
	return options
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
	if StanceNeedUpdate then 
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
	end
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