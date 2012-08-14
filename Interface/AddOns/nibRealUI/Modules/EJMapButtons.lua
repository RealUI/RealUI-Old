local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db

local MODNAME = "EJMapButtons"
local EJMapButtons = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

local _G = _G

-- Options
local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "EJ Map Buttons",
		desc = "Adjust Encounter Journal Map Buttons.",
		arg = MODNAME,
		order = 510,
		args = {
			header = {
				type = "header",
				name = "EJ Map Buttons",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Adjust Encounter Journal Map Buttons.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the EJ Map Buttons module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
				end,
				order = 30,
			},
			sep = {
				type = "description",
				name = " ",
				order = 40,
			},
			buttonscale = {
				type = "range",
				name = "Button Size",
				min = 0, max = 1, step = 0.05,
				isPercent = true,
				get = function(info) return db.buttonscale end,
				set = function(info, value) 
					db.buttonscale = value
				end,
				disabled = function() return not nibRealUI:GetModuleEnabled(MODNAME) end,
				order = 50,
			},
		},
	}
	end
	
	options.args.filterlist = filteropts
	return options
end

function EJMapButtons:UpdateButtonSize()
	local index, scale, newscale = 1, nil, 1
	
	if WorldMapBossButtonFrame and WorldMapBossButtonFrame.ready then
		scale = WorldMapBossButtonFrame:GetScale()
	end
	if not scale then return end
	
	if nibRealUI:GetModuleEnabled(MODNAME) then
		newscale = db.buttonscale
	end
	
	local button = _G["EJMapButton"..index]
	while button do	
		local _,_,_,x,y = button:GetPoint(1)
		button:SetScale(scale * db.buttonscale)
		if db.buttonscale ~= 1 then
			x = x * (1 / db.buttonscale)
			y = y * (1 / db.buttonscale)
			button:SetPoint("CENTER", WorldMapBossButtonFrame, "BOTTOMLEFT", x, y)
		end
		index = index + 1
		button = _G["EJMapButton"..index]
	end
end

function EJMapButtons:PLAYER_LOGIN()
	hooksecurefunc("EncounterJournal_AddMapButtons", function()
		EJMapButtons:UpdateButtonSize()
	end)
end

----
function EJMapButtons:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			buttonscale = 0.5,
		},
	})
	db = self.db.profile
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterExtrasOptions(MODNAME, GetOptions)
end

function EJMapButtons:OnEnable()
	self:RegisterEvent("PLAYER_LOGIN")
end

function EJMapButtons:OnDisable()
	self:UnregisterEvent("PLAYER_LOGIN")
end