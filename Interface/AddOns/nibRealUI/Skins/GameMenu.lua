local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

local mass
if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local _
local MODNAME = "GameMenu"
local GameMenu = nibRealUI:NewModule(MODNAME)

function GameMenu:Skin()
	-- Title text
	for i = 1, GameMenuFrame:GetNumRegions() do
		local region = select(i, GameMenuFrame:GetRegions())
		if region:GetObjectType() == "FontString" then
			if region:GetText() == MAINMENU_BUTTON then
				region:SetFont(unpack(nibRealUI.font.pixel1))
				region:SetTextColor(unpack(nibRealUI:GetClassColor(nibRealUI.class)))
				region:SetShadowColor(0, 0, 0, 0)
				region:SetPoint("TOP", GameMenuFrame, "TOP", 0, -10.5)
			end
		end
	end
	
	-- Button Backgrounds
	nibRealUI:CreateBGSection(GameMenuFrame, GameMenuButtonHelp, GameMenuButtonMacros)
	nibRealUI:CreateBGSection(GameMenuFrame, GameMenuButtonLogout, GameMenuButtonQuit)
	nibRealUI:CreateBGSection(GameMenuFrame, GameMenuButtonContinue, GameMenuButtonContinue)
end
----------

function GameMenu:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {},
	})
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
end

function GameMenu:OnEnable()
	if Aurora then
		self:Skin()
	end
end