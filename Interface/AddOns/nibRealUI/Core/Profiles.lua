local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

local mass
if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

function nibRealUI:Profiles_SetKeys()
	-- Refresh Key
	self.key = string.format("%s - %s", UnitName("player"), GetRealmName())
	
	local ResProfileTag = (self.db.char.resolution == 2) and "-HR" or ""
	local LayoutProfileTag = (self.db.char.layout.current == 2) and "-Healing" or ""
	local NewProfileRes = "RealUI" .. ResProfileTag
	local NewProfileLayout = "RealUI" .. ResProfileTag .. LayoutProfileTag
	
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
	for kn, vn in pairs(nonLayoutAddonList) do
		if _G[vn] then
			if _G[vn]["profileKeys"] then 
				_G[vn]["profileKeys"][self.key] = "RealUI"
			end
		end
	end
	for kl, vl in pairs(LayoutAddonList) do
		if _G[vl] then
			if _G[vl]["profileKeys"] then 
				_G[vl]["profileKeys"][self.key] = NewProfileLayout
			end
		end
	end
	for kr, vr in pairs(ResAddonList) do
		if _G[vr] then
			if _G[vr]["profileKeys"] then 
				_G[vr]["profileKeys"][self.key] = NewProfileRes
			end
		end
	end
	
	-- MSBT
	if MSBTProfiles_SavedVars then
		if MSBTProfiles_SavedVars["profiles"][NewProfileRes] then
			MSBTProfiles_SavedVarsPerChar["currentProfileName"] = NewProfileRes
		end
	end
end

function nibRealUI:Profiles_SetLayout()
	local ResProfileTag = (self.db.char.resolution == 2) and "-HR" or ""
	local LayoutProfileTag = (self.db.char.layout.current == 2) and "-Healing" or ""
	local NewProfileLayout = "RealUI" .. ResProfileTag .. LayoutProfileTag
	
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

