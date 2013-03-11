local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

function nibRealUI:MiniPatch(ver)
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
		
		
	elseif ver == "73r9" then
		if IsAddOnLoaded("nibPointDisplay_RealUI") and nibPointDisplayRUIDB then
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["ROGUE"]["types"]["dp"]["bars"]["bg"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["ROGUE"]["types"]["dp"]["bars"]["bg"]["full"] = {
					["color"] = {
						["a"] = 1,
						["r"] = 0.8235294117647058,
						["g"] = 0.8235294117647058,
						["b"] = 0,
					},
					["maxcolor"] = {
						["r"] = 0.9411764705882353,
						["g"] = 0.9411764705882353,
						["b"] = 0,
					},
					["texture"] = "Round_Small_BG",
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["tp"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["tp"]["position"] = {
					["y"] = -52,
					["x"] = -66,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["sz"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["sz"]["position"] = {
					["y"] = -25,
					["x"] = -83,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["vm"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["vm"]["position"] = {
					["y"] = -52,
					["x"] = -63,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["chi"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["chi"]["position"] = {
					["y"] = -39,
					["x"] = -64,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["WARLOCK"]["types"]["be"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["WARLOCK"]["types"]["be"]["position"] = {
					["y"] = -38,
					["x"] = -70,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["ROGUE"]["types"]["dp"]["bars"]["bg"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["ROGUE"]["types"]["dp"]["bars"]["bg"]["full"] = {
					["color"] = {
						["a"] = 1,
						["r"] = 0.8235294117647058,
						["g"] = 0.8235294117647058,
						["b"] = 0,
					},
					["maxcolor"] = {
						["r"] = 0.9411764705882353,
						["g"] = 0.9411764705882353,
						["b"] = 0,
					},
					["texture"] = "Round_Small_BG",
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["ROGUE"]["types"]["dp"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["ROGUE"]["types"]["dp"]["position"] = {
					["y"] = -51,
					["x"] = -79,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["tp"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["tp"]["position"] = {
					["y"] = -52,
					["x"] = -66,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["sz"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["sz"]["position"] = {
					["y"] = -22,
					["x"] = -97,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["vm"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["vm"]["position"] = {
					["y"] = -52,
					["x"] = -78,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["chi"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["chi"]["position"] = {
					["y"] = -37,
					["x"] = -74,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["WARLOCK"]["types"]["be"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["WARLOCK"]["types"]["be"]["position"] = {
					["y"] = -38,
					["x"] = -88,
				}
			end
		end
		
		
	elseif ver == "73r10" then
		if IsAddOnLoaded("nibPointDisplay_RealUI") and nibPointDisplayRUIDB then
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["ROGUE"]["types"]["dp"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["ROGUE"]["types"]["dp"]["position"] = {
					["y"] = -51,
					["x"] = 79,
				}
			end
		end
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["DemonicFuryBar"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["DemonicFuryBar"]["alwaysFullAlpha"] = true
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["DemonicFuryBar"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["DemonicFuryBar"]["alwaysFullAlpha"] = true
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["BurningEmbersBar"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["BurningEmbersBar"]["alwaysFullAlpha"] = true
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["BurningEmbersBar"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["BurningEmbersBar"]["alwaysFullAlpha"] = true
			end
		end
		
		
	elseif ver == "73r11" then
		if IsAddOnLoaded("nibPointDisplay_RealUI") and nibPointDisplayRUIDB then
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["ROGUE"]["types"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["ROGUE"]["types"]["dp"] = {
					["bars"] = {
						["bg"] = {
							["full"] = {
								["color"] = {["a"] = 1, ["r"] = 0.8627450980392157, ["g"] = 0, ["b"] = 0},
								["maxcolor"] = {["r"] = 0.9882352941176471, ["g"] = 0, ["b"] = 0},
							},
						},
					},
					["general"] = {
						["direction"] = {["reverse"] = true},
					},
					["position"] = {
						["y"] = -37,
						["x"] = 56,
						["framelevel"] = {["level"] = 4},
					},
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["ROGUE"]["types"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["ROGUE"]["types"]["dp"] = {
					["bars"] = {
						["bg"] = {
							["full"] = {
								["color"] = {["a"] = 1, ["r"] = 0.8627450980392157, ["g"] = 0, ["b"] = 0},
								["maxcolor"] = {["r"] = 0.9882352941176471, ["g"] = 0, ["b"] = 0},
							},
						},
					},
					["general"] = {
						["direction"] = {["reverse"] = true},
					},
					["position"] = {
						["y"] = -37,
						["x"] = 76,
						["framelevel"] = {["level"] = 4},
					},
				}
			end
		end
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["BanditsGuile"] = {
					["offset"] = 2,
					["scale"] = 0.745,
					["textVisible"] = {["lower"] = false},
					["barHorizontalOffset"] = 5,
					["barVerticalOffset"] = 33,
					["textVerticalOffset"] = 12,
					["textHorizontalOffset"] = 12,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "LEFT",
					["widthModifier"] = -22,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-1"] = nil
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-2"] = nil
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-3"] = nil
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["TargetInvuln"] = {
					["barVerticalOffset"] = 32,
					["forceJustifyText"] = "LEFT",
					["lockLowerTextAlpha"] = true,
					["scale"] = 0.75,
					["textHorizontalOffset"] = 60,
					["displayAuraIcon"] = true,
					["widthModifier"] = -16,
					["auraIconYOffset"] = -7,
					["textVerticalOffset"] = 22,
					["barHorizontalOffset"] = 12,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["auraIconXOffset"] = -49,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["TargetCC"] = {
					["enabled"] = true,
					["forceJustifyText"] = "LEFT",
					["textHorizontalOffset"] = 8,
					["displayAuraIcon"] = true,
					["auraIconXOffset"] = -128.5,
					["lockLowerTextAlpha"] = true,
					["auraIconYOffset"] = -29,
					["textVerticalOffset"] = 0,
					["barVerticalOffset"] = 15,
					["myTagVersion"] = 3,
					["scale"] = 0.85,
					["barHorizontalOffset"] = 4,
				}
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["BanditsGuile"] = {
					["offset"] = 2,
					["scale"] = 0.745,
					["textVisible"] = {["lower"] = false},
					["barHorizontalOffset"] = 5,
					["barVerticalOffset"] = 33,
					["textVerticalOffset"] = 14,
					["textHorizontalOffset"] = 13,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "LEFT",
					["widthModifier"] = -22,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-1"] = nil
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-2"] = nil
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-3"] = nil
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["TargetInvuln"] = {
					["forceJustifyText"] = "LEFT",
					["lockLowerTextAlpha"] = true,
					["auraIconYOffset"] = -7,
					["textVerticalOffset"] = 22,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["displayAuraIcon"] = true,
					["textHorizontalOffset"] = 59,
					["auraIconSize"] = 28,
					["widthModifier"] = -16,
					["barVerticalOffset"] = 32,
					["barHorizontalOffset"] = 12,
					["scale"] = 0.75,
					["auraIconXOffset"] = -50,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["TargetCC"] = {
					["forceJustifyText"] = "LEFT",
					["displayAuraIcon"] = true,
					["auraIconYOffset"] = -30,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["lockLowerTextAlpha"] = true,
					["textHorizontalOffset"] = 8,
					["auraIconSize"] = 28,
					["auraIconXOffset"] = -128.5,
					["barVerticalOffset"] = 15,
					["scale"] = 0.85,
					["barHorizontalOffset"] = 4,
				}
			end
		end
		
		
	elseif ver == "73r12" then
		-- See r13
		
		
	elseif ver == "73r13" then
		if IsAddOnLoaded("Masque") and MasqueDB then
			if MasqueDB["profiles"]["RealUI"]["Groups"]["Masque"] then
				MasqueDB["profiles"]["RealUI"]["Groups"]["Masque"]["Backdrop"] = true
			end
			if MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4"] then
				MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4"]["Backdrop"] = true
			end
			if MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_1"] then
				MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_1"]["Backdrop"] = true
			end
			if MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_2"] then
				MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_2"]["Backdrop"] = true
			end
			if MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_3"] then
				MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_3"]["Backdrop"] = true
			end
			if MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_4"] then
				MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_4"]["Backdrop"] = true
			end
			if MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_5"] then
				MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_5"]["Backdrop"] = true
			end
			if MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_6"] then
				MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_6"]["Backdrop"] = true
			end
			if MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_PetBar"] then
				MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_PetBar"]["Backdrop"] = true
			end
			if MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_Vehicle"] then
				MasqueDB["profiles"]["RealUI"]["Groups"]["Bartender4_Vehicle"]["Backdrop"] = true
			end
		end
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-TasteBlood"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-TasteBlood"]["buffToTrack"] = "56636"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-TasteBlood"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-TasteBlood"]["buffToTrack"] = "56636"
			end
		end
		
		
	elseif ver == "73r16" then
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Enrage"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Enrage"]["buffToTrack"] = "12880"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Enrage"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Enrage"]["buffToTrack"] = "12880"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Enrage2"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Enrage2"]["buffToTrack"] = "12880"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Enrage2"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Enrage2"]["buffToTrack"] = "12880"
			end
		end
		
		
	elseif ver == "73r18" then
		if IsAddOnLoaded("nibPointDisplay_RealUI") and nibPointDisplayRUIDB then
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["DRUID"]["types"]["wm"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["DRUID"]["types"]["wm"]["position"] = {
					["y"] = -69,
					["x"] = -76,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["DRUID"]["types"]["wm"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["DRUID"]["types"]["wm"]["position"] = {
					["y"] = -69,
					["x"] = -96,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["chi"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["chi"]["position"] = {
					["y"] = -39,
					["x"] = -63,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["chi"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["chi"]["position"] = {
					["y"] = -37,
					["x"] = -68,
				}
			end
		end
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Harmony"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Harmony"]["buffToTrack"] = "100977"
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Harmony"]["textHorizontalOffset"] = 16
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Harmony"]["textVerticalOffset"] = 4
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Harmony"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Harmony"]["buffToTrack"] = "100977"
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Harmony"]["textHorizontalOffset"] = 19
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Harmony"]["textVerticalOffset"] = 5
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["WildMushrooms"] = {
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 33,
					["forceJustifyText"] = "LEFT",
					["textVerticalOffset"] = 12,
					["scale"] = 0.745,
					["myTagVersion"] = 3,
					["widthModifier"] = -22,
					["barHorizontalOffset"] = 5,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["Stagger"] = {
					["scale"] = 0.715,
					["textVerticalOffset"] = 25,
					["myTagVersion"] = 3,
					["textHorizontalOffset"] = 3,
					["widthModifier"] = -28,
					["forceJustifyText"] = "LEFT",
					["barVerticalOffset"] = 39,
					["barHorizontalOffset"] = 13,
				}
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["WildMushrooms"] = {
					["scale"] = 0.745,
					["lockUpperTextAlpha"] = true,
					["textVerticalOffset"] = 15,
					["myTagVersion"] = 3,
					["textHorizontalOffset"] = -2,
					["barHorizontalOffset"] = 5,
					["forceJustifyText"] = "LEFT",
					["barVerticalOffset"] = 33,
					["widthModifier"] = -22,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["Stagger"] = {
					["barVerticalOffset"] = 39,
					["widthModifier"] = -28,
					["scale"] = 0.715,
					["textVerticalOffset"] = 24,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["textHorizontalOffset"] = 3,
					["barHorizontalOffset"] = 13,
				}
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mon-Shuffle"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mon-Shuffle"]["barColor"] = {
					["a"] = 1,
					["r"] = 0.8627450980392157,
					["g"] = 0.4313725490196079,
					["b"] = 0,
				}
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mon-Shuffle"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mon-Shuffle"]["barColor"] = {
					["a"] = 1,
					["r"] = 0.8627450980392157,
					["g"] = 0.4313725490196079,
					["b"] = 0,
				}
			end
		end
		if IsAddOnLoaded("Raven") and RavenDB then
			if RavenDB["profiles"]["RealUI"]["BarGroups"]["PlayerBuffs"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["PlayerBuffs"]["filterTimeLeft"] = 67
				RavenDB["profiles"]["RealUI"]["BarGroups"]["PlayerBuffs"]["filterDuration"] = 67
			end
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["PlayerBuffs"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["PlayerBuffs"]["filterTimeLeft"] = 67
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["PlayerBuffs"]["filterDuration"] = 67
			end
		end
		
	elseif ver == "73r19" then
		if IsAddOnLoaded("Raven") and RavenDB then
			if RavenDB["global"]["SpellLists"] then
				RavenDB["global"]["SpellLists"]["ClassBuffs"] = {
					["#121153"] = true,
					["#121471"] = true,
					["#13877"] = true,
					["#108208"] = true,
				}
			end
			if RavenDB["global"]["SpellLists"]["PlayerExclusions"] then
				RavenDB["global"]["SpellLists"]["PlayerExclusions"]["#121153"] = true
				RavenDB["global"]["SpellLists"]["PlayerExclusions"]["#121471"] = true
				RavenDB["global"]["SpellLists"]["PlayerExclusions"]["#108208"] = true
			end
			if RavenDB["global"]["SpellLists"]["TargetExclusions"] then
				RavenDB["global"]["SpellLists"]["TargetExclusions"]["#91023"] = true
			end
			if RavenDB["global"]["Settings"] then
				RavenDB["global"]["Settings"]["WeaponEnchants"] = {
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["pointH"] = 14.99997265772085,
					["showNoDuration"] = true,
					["pointYT"] = 0.4857143463059572,
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["pointX"] = 0.5,
					["pointW"] = 168.9999885429524,
					["pointXR"] = 0.3994047706772935,
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["pointY"] = 0.4999999657259233,
				}
			end
			if RavenDB["profiles"]["RealUI"]["BarGroups"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["ClassBuffs"] = {
					["timeAlign"] = "LEFT",
					["spacingX"] = -9,
					["barHeight"] = 5,
					["configuration"] = 10,
					["showNoDuration"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["hideLabel"] = true,
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["iconAlign"] = "RIGHT",
					["filterCooldownTable"] = "ClassBuffs",
					["pointX"] = 0.446428589789684,
					["timeFormat"] = 23,
					["showBuff"] = true,
					["name"] = "ClassBuffs",
					["anchorY"] = -18,
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["showClasses"] = {
						["DEATHKNIGHT"] = true,
						["WARRIOR"] = true,
						["PALADIN"] = true,
						["MAGE"] = true,
						["PRIEST"] = true,
						["WARLOCK"] = true,
						["SHAMAN"] = true,
						["DRUID"] = true,
						["MONK"] = true,
						["HUNTER"] = true,
					},
					["spacingY"] = -9,
					["filterBuff"] = false,
					["hideSpark"] = false,
					["filterBuffTable"] = "ClassBuffs",
					["pointH"] = 36.99996014634375,
					["iconSize"] = 37,
					["iconOffset"] = 8,
					["filterBuffSpells"] = true,
					["anchorFrame"] = "RealUI_Positioners_CenterAuras",
					["detectBuffs"] = true,
					["auto"] = true,
					["pointXR"] = 0.5315475900268606,
					["pointW"] = 37.00001862648837,
					["parentFrame"] = "oUF_RealUIPlayer_Overlay",
					["pointY"] = 0.4466666918009897,
					["timeInset"] = 16,
					["barWidth"] = 20,
					["showResting"] = false,
					["hideBar"] = true,
					["pointYT"] = 0.5180952516008563,
					["anchorPoint"] = "BOTTOMLEFT",
					["bars"] = {
					},
					["timeOffset"] = 14,
					["iconInset"] = -15,
				}
				RavenDB["profiles"]["RealUI"]["BarGroups"]["WeaponEnchants"] = {
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["showNoDuration"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["pointXR"] = 0.5470238191123905,
					["pointH"] = 14.99997265772085,
					["showClasses"] = {
						["DEATHKNIGHT"] = true,
						["WARRIOR"] = true,
						["PALADIN"] = true,
						["MAGE"] = true,
						["PRIEST"] = true,
						["WARLOCK"] = true,
						["HUNTER"] = true,
						["DRUID"] = true,
						["MONK"] = true,
						["SHAMAN"] = true,
					},
					["auto"] = false,
					["merged"] = true,
					["pointX"] = 0.352380951564903,
					["timeFormat"] = 23,
					["pointY"] = 0.9304761320470502,
					["name"] = "WeaponEnchants",
					["mergeInto"] = "ClassBuffs",
					["pointW"] = 168.9999885429524,
					["bars"] = {
						{
							["barLabel"] = "Lethal Poison Missing",
							["uniqueID"] = "031113-135214-0",
							["enableBar"] = true,
							["sorder"] = 1,
							["action"] = "Lethal Poison Missing",
							["barType"] = "Notification",
						}, -- [1]
						{
							["barLabel"] = "Non-Lethal Poison Missing",
							["uniqueID"] = "031113-135214-1",
							["enableBar"] = true,
							["sorder"] = 2,
							["action"] = "Non-Lethal Poison Missing",
							["barType"] = "Notification",
						}, -- [2]
					},
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["pointYT"] = 0.05523817998483021,
				}
			end
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["ClassBuffs"] = {
					["timeAlign"] = "LEFT",
					["spacingX"] = -9,
					["barHeight"] = 5,
					["configuration"] = 10,
					["showNoDuration"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["hideLabel"] = true,
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["iconAlign"] = "RIGHT",
					["filterCooldownTable"] = "ClassBuffs",
					["pointX"] = 0.446428589789684,
					["timeFormat"] = 23,
					["showBuff"] = true,
					["name"] = "ClassBuffs",
					["anchorY"] = -18,
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["showClasses"] = {
						["DEATHKNIGHT"] = true,
						["WARRIOR"] = true,
						["PALADIN"] = true,
						["MAGE"] = true,
						["PRIEST"] = true,
						["WARLOCK"] = true,
						["SHAMAN"] = true,
						["DRUID"] = true,
						["MONK"] = true,
						["HUNTER"] = true,
					},
					["spacingY"] = -9,
					["filterBuff"] = false,
					["hideSpark"] = false,
					["filterBuffTable"] = "ClassBuffs",
					["pointH"] = 36.99996014634375,
					["iconSize"] = 37,
					["iconOffset"] = 8,
					["filterBuffSpells"] = true,
					["anchorFrame"] = "RealUI_Positioners_CenterAuras",
					["detectBuffs"] = true,
					["auto"] = true,
					["pointXR"] = 0.5315475900268606,
					["pointW"] = 37.00001862648837,
					["parentFrame"] = "oUF_RealUIPlayer_Overlay",
					["pointY"] = 0.4466666918009897,
					["timeInset"] = 16,
					["barWidth"] = 20,
					["showResting"] = false,
					["hideBar"] = true,
					["pointYT"] = 0.5180952516008563,
					["anchorPoint"] = "BOTTOMLEFT",
					["bars"] = {
					},
					["timeOffset"] = 14,
					["iconInset"] = -15,
				}
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["WeaponEnchants"] = {
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["pointH"] = 14.99997265772085,
					["mergeInto"] = "ClassBuffs",
					["showNoDuration"] = true,
					["name"] = "WeaponEnchants",
					["auto"] = false,
					["pointYT"] = 0.05523817998483021,
					["merged"] = true,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["pointX"] = 0.352380951564903,
					["pointW"] = 168.9999885429524,
					["showClasses"] = {
						["DEATHKNIGHT"] = true,
						["WARRIOR"] = true,
						["PALADIN"] = true,
						["MAGE"] = true,
						["PRIEST"] = true,
						["WARLOCK"] = true,
						["HUNTER"] = true,
						["DRUID"] = true,
						["MONK"] = true,
						["SHAMAN"] = true,
					},
					["pointXR"] = 0.5470238191123905,
					["timeFormat"] = 23,
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
						{
							["barLabel"] = "Lethal Poison Missing",
							["uniqueID"] = "031113-135214-0",
							["enableBar"] = true,
							["sorder"] = 1,
							["action"] = "Lethal Poison Missing",
							["barType"] = "Notification",
						}, -- [1]
						{
							["barLabel"] = "Non-Lethal Poison Missing",
							["uniqueID"] = "031113-135214-1",
							["enableBar"] = true,
							["sorder"] = 2,
							["action"] = "Non-Lethal Poison Missing",
							["barType"] = "Notification",
						}, -- [2]
					},
					["pointY"] = 0.9304761320470502,
				}
			end
			if RavenDB["profiles"]["RealUI"]["Conditions"] then
				RavenDB["profiles"]["RealUI"]["Conditions"]["ROGUE"] = {
					["Lethal Poison Missing"] = {
						["associatedSpell"] = "#2823",
						["tests"] = {
							["Player Status"] = {
								["inInstance"] = true,
								["isMounted"] = 0,
								["inGroup"] = true,
								["inBattleground"] = true,
								["checkLevel"] = true,
								["inArena"] = true,
								["inCombat"] = 0,
							},
						},
					},
					["Non-Lethal Poison Missing"] = {
						["associatedSpell"] = "#5761",
						["tests"] = {
							["Player Status"] = {
								["inInstance"] = true,
								["isMounted"] = 0,
								["inGroup"] = true,
								["checkLevel"] = true,
								["inArena"] = true,
								["inBattleground"] = true,
							},
						},
					},
				}
			end
			if RavenDB["profiles"]["RealUI-HR"]["Conditions"] then
				RavenDB["profiles"]["RealUI-HR"]["Conditions"]["ROGUE"] = {
					["Lethal Poison Missing"] = {
						["associatedSpell"] = "#2823",
						["tests"] = {
							["Player Status"] = {
								["inInstance"] = true,
								["isMounted"] = 0,
								["inGroup"] = true,
								["inBattleground"] = true,
								["checkLevel"] = true,
								["inArena"] = true,
								["inCombat"] = 0,
							},
						},
					},
					["Non-Lethal Poison Missing"] = {
						["associatedSpell"] = "#5761",
						["tests"] = {
							["Player Status"] = {
								["inInstance"] = true,
								["isMounted"] = 0,
								["inGroup"] = true,
								["checkLevel"] = true,
								["inArena"] = true,
								["inBattleground"] = true,
							},
						},
					},
				}
			end
		end
		
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Hemorrhage(G)"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Hemorrhage(G)"] = nil
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Hemorrhage(G)"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Hemorrhage(G)"] = nil
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-FindWeakness"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-FindWeakness"]["buffToTrack"] = "91023"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-FindWeakness"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-FindWeakness"]["buffToTrack"] = "91023"
			end
		end
		
	end
end