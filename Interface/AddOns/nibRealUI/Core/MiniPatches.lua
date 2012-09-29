local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

function nibRealUI:MiniPatch(ver)
	-- 3 action bars
	if ver == "71s3ab" then
		if IsAddOnLoaded("Bartender4") and Bartender4DB then
			if Bartender4DB["namespaces"]["ActionBars"]["profiles"]["RealUI-HR"]["actionbars"] then
				Bartender4DB["namespaces"]["ActionBars"]["profiles"]["RealUI-HR"]["actionbars"][3]["enabled"] = true
				Bartender4DB["namespaces"]["PetBar"]["profiles"]["RealUI-HR"]["position"]["y"] = -268.5
			end
			if Bartender4DB["namespaces"]["ActionBars"]["profiles"]["RealUI-HR-Healing"]["actionbars"] then
				Bartender4DB["namespaces"]["ActionBars"]["profiles"]["RealUI-HR-Healing"]["actionbars"][1]["position"]["y"] = 92
				Bartender4DB["namespaces"]["ActionBars"]["profiles"]["RealUI-HR-Healing"]["actionbars"][2]["position"]["y"] = 65
				Bartender4DB["namespaces"]["ActionBars"]["profiles"]["RealUI-HR-Healing"]["actionbars"][3]["enabled"] = true
				Bartender4DB["namespaces"]["MultiCast"]["profiles"]["RealUI-HR-Healing"]["position"]["y"] = 116
				Bartender4DB["namespaces"]["StanceBar"]["profiles"]["RealUI-HR-Healing"]["position"]["y"] = 114
				Bartender4DB["namespaces"]["Vehicle"]["profiles"]["RealUI-HR-Healing"]["position"]["y"] = 111
			end
		end
	end
	
	-- 7.3 r1
	if ver == "73r1" then
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["barHorizontalOffset"] = -4
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["barVerticalOffset"] = 33
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["scale"] = 0.745
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["widthModifier"] = -22
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["textVerticalOffset"] = 12
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Sunfire"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["barHorizontalOffset"] = -4
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["barVerticalOffset"] = 33
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["scale"] = 0.745
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["widthModifier"] = -22
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["textVerticalOffset"] = 14
			end
		end
	end
end