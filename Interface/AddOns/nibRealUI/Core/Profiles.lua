local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

local mass
if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local function GetProfileInfo()
	local ResProfileTag = (nibRealUI.db.char.resolution == 2) and "-HR" or ""
	local LayoutProfileTag = (nibRealUI.db.char.layout.current == 2) and "-Healing" or ""
	local NewProfileRes = "RealUI" .. ResProfileTag
	local NewProfileLayout = "RealUI" .. ResProfileTag .. LayoutProfileTag

	return ResProfileTag, LayoutProfileTag, NewProfileRes, NewProfileLayout
end

function nibRealUI:Profiles_SetKeys()
	-- Refresh Key
	self.key = string.format("%s - %s", UnitName("player"), GetRealmName())
	local ResProfileTag, LayoutProfileTag, NewProfileRes, NewProfileLayout = GetProfileInfo()
	
	-- Addons that just need to be set to RealUI
	local nonLayoutAddonList = {
		"ChatterDB",
		"MasqueDB",
	}
	-- Any Addons which need a Layout profile change, also changes Res
	local LayoutAddonList = {
		"Bartender4DB",
		"GridDB",
	}
	-- Any Addons which aren't in the Layout list, but still need a Res profile change
	local ResAddonList = {
		"RavenDB",
		"SkadaDB",
		"IceCoreRealUIDB",
	}
	
	-- Set Addon profiles
	local function SetProfileKey(a, p)
		if _G[a] and _G[a]["profileKeys"] then 
			_G[a]["profileKeys"][self.key] = p
		end
	end
	for kn, vn in pairs(nonLayoutAddonList) do
		SetProfileKey(vn, "RealUI")
	end
	for kl, vl in pairs(LayoutAddonList) do
		SetProfileKey(vl, NewProfileLayout)
	end
	for kr, vr in pairs(ResAddonList) do
		SetProfileKey(vr, NewProfileRes)
	end
	
	-- MSBT
	if MSBTProfiles_SavedVars then
		if MSBTProfiles_SavedVars["profiles"][NewProfileRes] then
			MSBTProfiles_SavedVarsPerChar["currentProfileName"] = NewProfileRes
		end
	end
end

function nibRealUI:Profiles_SetLayout()
	local _, _, _, NewProfileLayout = GetProfileInfo()
	
	local LayoutAddonList = {
		Bartender4 = LibStub("AceAddon-3.0"):GetAddon("Bartender4", true),
		Grid = LibStub("AceAddon-3.0"):GetAddon("Grid", true),
	}
	
	for kl, vl in pairs(LayoutAddonList) do
		if vl then
			if vl.db then vl.db:SetProfile(NewProfileLayout) end
		end
	end
end

