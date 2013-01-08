local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

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
	elseif ver == "73r5" then
		if IsAddOnLoaded("nibRealUI") and nibRealUIDB then
			if nibRealUIDB["namespaces"]["FrameMover"]["profiles"]["RealUI"]["uiframes"]["achievementalert"] then
				nibRealUIDB["namespaces"]["FrameMover"]["profiles"]["RealUI"]["uiframes"]["achievementalert"]["move"] = false
			end
		end
	elseif ver == "73r6" then
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mon-RisingSunKick"] = {
					["shouldAnimate"] = false,
					["class"] = "MONK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.3882352941176471,
						["b"] = 0,
					},
					["barHorizontalOffset"] = 3,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "RSK",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 5,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["scale"] = 0.775,
					["barVerticalOffset"] = 27.5,
					["forceJustifyText"] = "RIGHT",
					["side"] = "RIGHT",
					["buffToTrack"] = "107428",
					["buffTimerDisplay"] = "seconds",
					["textHorizontalOffset"] = -1,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["lockUpperTextAlpha"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
				}
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mon-RisingSunKick"] = {
					["shouldAnimate"] = false,
					["class"] = "MONK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.3882352941176471,
						["b"] = 0,
					},
					["barHorizontalOffset"] = 3,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "RSK",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 5,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["scale"] = 0.775,
					["barVerticalOffset"] = 27.5,
					["forceJustifyText"] = "RIGHT",
					["side"] = "RIGHT",
					["buffToTrack"] = "107428",
					["buffTimerDisplay"] = "seconds",
					["textHorizontalOffset"] = -6,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["lockUpperTextAlpha"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
				}
			end
		end
	end
end