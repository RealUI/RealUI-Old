local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

local mass
if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local _
local MODNAME = "MiscSkins"
local MiscSkins = nibRealUI:NewModule(MODNAME)

function MiscSkins:Skin()
	local F, C
	if Aurora then 
		F = Aurora[1]
		C = Aurora[2]
	end

	-- Clique
	if Aurora and CliqueSpellTab then
		local tab = CliqueSpellTab
		F.ReskinTab(CliqueSpellTab)

		tab:SetCheckedTexture(C.media.checked)

		local bg = CreateFrame("Frame", nil, tab)
		bg:SetPoint("TOPLEFT", -1, 1)
		bg:SetPoint("BOTTOMRIGHT", 1, -1)
		bg:SetFrameLevel(tab:GetFrameLevel()-1)
		F.CreateBD(bg)

		F.CreateSD(tab, 5, 0, 0, 0, 1, 1)

		select(6, tab:GetRegions()):SetTexCoord(.08, .92, .08, .92)
	end
end
----------

function MiscSkins:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {},
	})
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
end

function MiscSkins:OnEnable()
	self:Skin()
end