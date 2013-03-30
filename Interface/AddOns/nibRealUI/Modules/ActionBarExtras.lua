local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local MODNAME = "ActionBarExtras"
local ActionBarExtras = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

local EnteredWorld = false
local Bar4, Bar4Profile

local Textures = {
	PetBar = {
		top = [[Interface\Addons\nibRealUI\Media\Doodads\PetBarTop]],
		bottom = [[Interface\Addons\nibRealUI\Media\Doodads\PetBarBottom]],
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
				name = "Adds extra features to the Action Bars.",
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
			gap1 = {
				name = " ",
				type = "description",
				order = 31,
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
		},
	}
	end
	return options
end

function ActionBarExtras:SetFonts()
	for i = 1, 120 do
		button = _G["BT4Button"..i];
		if button then
			local name = button:GetName();
			local count = _G[name.."Count"];
			local hotkey = _G[name.."HotKey"];
			
			if count then
				count:SetFont(unpack(nibRealUI.font.pixeltiny))
			end
			hotkey:SetFont(unpack(nibRealUI.font.pixeltiny))
		end
	end
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
	PetBarDoodad.top:SetVertexColor(unpack(color))
	
	-- Size/Position
	Bar4Profile = Bartender4DB["profileKeys"][nibRealUI.key]
	local pbX = Bartender4DB["namespaces"]["PetBar"]["profiles"][Bar4Profile]["position"]["x"]
	local pbY = Bartender4DB["namespaces"]["PetBar"]["profiles"][Bar4Profile]["position"]["y"]
	local pbA = Bartender4DB["namespaces"]["PetBar"]["profiles"][Bar4Profile]["position"]["point"]
	PetBarDoodad:ClearAllPoints()
	PetBarDoodad:SetPoint(pbA, "UIParent", pbA, floor(pbX) + 132, floor(pbY) - 18)
end

local function MakePetBarDoodad()
	-- PetBar
	PetBarDoodad = CreateFrame("Frame", nil, UIParent)
	
	PetBarDoodad:ClearAllPoints()
	PetBarDoodad:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
	PetBarDoodad:SetFrameStrata("BACKGROUND")
	PetBarDoodad:SetFrameLevel(1)
	PetBarDoodad:SetHeight(32)
	PetBarDoodad:SetWidth(32)
	
	PetBarDoodad:RegisterEvent("PLAYER_ENTERING_WORLD")
	PetBarDoodad:RegisterEvent("UNIT_PET")
	PetBarDoodad:SetScript("OnEvent", function(self)
		ActionBarExtras:UpdatePetBar()
	end)
	
	PetBarDoodad.top = PetBarDoodad:CreateTexture(nil, "ARTWORK")
	PetBarDoodad.top:SetAllPoints(PetBarDoodad)
	PetBarDoodad.top:SetTexture(Textures.PetBar.top)
	
	PetBarDoodad.bottom = PetBarDoodad:CreateTexture(nil, "ARTWORK")
	PetBarDoodad.bottom:SetAllPoints(PetBarDoodad)
	PetBarDoodad.bottom:SetTexture(Textures.PetBar.bottom)
end

----
function ActionBarExtras:RefreshMod()
	if not(nibRealUI:GetModuleEnabled(MODNAME) and Bar4) then return end
	
	db = self.db.profile
	
	if not PetBarDoodad then MakePetBarDoodad() end
	self:UpdatePetBar()
	self:TogglePetBar()
	self:SetFonts()
end

local function ClassColorsUpdate()
	if not(nibRealUI:GetModuleEnabled(MODNAME) and Bar4) then return end
	
	ActionBarExtras:UpdatePetBar()
end

function ActionBarExtras:UNIT_PET()
	self:TogglePetBar()
end

function ActionBarExtras:PLAYER_ENTERING_WORLD()
	if not Bar4 then return end
	
	self:TogglePetBar()
	
	if EnteredWorld then return end
	
	self:RegisterEvent("UNIT_PET")
	
	self:RefreshMod()
	
	if CUSTOM_CLASS_COLORS then
		CUSTOM_CLASS_COLORS:RegisterCallback(ClassColorsUpdate)
	end
	
	EnteredWorld = true
end

function ActionBarExtras:PLAYER_LOGIN()
	if IsAddOnLoaded("Bartender4") and Bartender4DB then
		Bar4 = LibStub("AceAddon-3.0"):GetAddon("Bartender4", true)
	end
end

function ActionBarExtras:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			petbar = {
				enabled = true,
			},
		},
	})
	db = self.db.profile

	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterModuleOptions(MODNAME, GetOptions)
end

function ActionBarExtras:OnEnable()	
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	self:SetFonts()
	if EnteredWorld then 
		self:RefreshMod()
	end
end

function ActionBarExtras:OnDisable()
	self:TogglePetBar()
end