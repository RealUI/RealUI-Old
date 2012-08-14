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
	
	-- 7.1 r2
	if ver == "71r2" then
		if IsAddOnLoaded("OmniCC") and OmniCC4Config then
			if OmniCC4Config["groupSettings"]["base"] then
				OmniCC4Config["groupSettings"]["base"]["fontSize"] = 16
				OmniCC4Config["groupSettings"]["base"]["xOff"] = 2
				OmniCC4Config["groupSettings"]["base"]["tenthsDuration"] = 0
				OmniCC4Config["groupSettings"]["base"]["styles"] = {
					["hours"] = {
						["scale"] = 1,
					},
				}
				OmniCC4Config["groupSettings"]["base"]["fontFace"] = "Interface\\Addons\\SharedMedia_MyMedia\\font\\standard.ttf"
			end
			if OmniCC4Config["groupSettings"]["Totems"] then
				OmniCC4Config["groupSettings"]["Totems"]["fontSize"] = 16
				OmniCC4Config["groupSettings"]["Totems"]["xOff"] = 1
				OmniCC4Config["groupSettings"]["Totems"]["yOff"] = 1
				OmniCC4Config["groupSettings"]["Totems"]["styles"] = {
					["hours"] = {
						["scale"] = 1,
					},
				}
				OmniCC4Config["groupSettings"]["Totems"]["fontFace"] = "Interface\\Addons\\SharedMedia_MyMedia\\font\\standard.ttf"
			end
		end
	end
	
	-- 7.1 r3
	if ver == "71r3" then
		if IsAddOnLoaded("nibMinimap") and nibMinimapDB then
			if nibMinimapDB["profiles"]["RealUI-HR"]["information"]["font"] then
				nibMinimapDB["profiles"]["RealUI-HR"]["information"]["font"]["gap"] = 6
			end
		end
		if IsAddOnLoaded("Raven") and RavenDB then
			local TBE3Table = {
				["name"] = "TargetBuffsExtraPvP",
				["merged"] = true,
				["mergeInto"] = "TargetBuffs",
				["bars"] = {},
				["showInstance"] = false,
				["showFishing"] = false,
				["showSolo"] = false,
				["showNoDuration"] = true,
				["showCombat"] = false,
				["showFriendly"] = false,
				["auto"] = true,
				["detectBuffs"] = true,
				["detectBuffsMonitor"] = "target",
				["detectBuffsCastBy"] = "anyone",
				["filterBuffTable"] = "PlayerDebuffExclusions",
				["filterCooldownTable"] = "PlayerDebuffExclusions",
				["filterDebuffTable"] = "PlayerDebuffExclusions",
				["pointH"] = 14.99997265772085,
				["pointW"] = 168.9999885429524,
				["pointX"] = 0.4613095799129233,
				["pointXR"] = 0.4380951907643702,
				["pointY"] = 0.9257142289172442,
				["pointYT"] = 0.06000008311463615,
				["timeFormat"] = 23,
				["borderColor"] = {["a"] = 1, ["b"] = 1, ["g"] = 1, ["r"] = 1},
				["backdropFill"] = {["a"] = 1, ["b"] = 1, ["g"] = 1, ["r"] = 1},
				["backdropColor"] = {["a"] = 1, ["b"] = 1, ["g"] = 1, ["r"] = 1},
			}
			if RavenDB["profiles"]["RealUI"]["BarGroups"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["TargetBuffsExtraPvP"] = TBE3Table
			end
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["TargetBuffsExtraPvP"] = TBE3Table
			end
			if RavenDB["profiles"]["RealUI"]["BarGroups"]["Buffs"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["Buffs"]["anchorFrame"] = nil
				RavenDB["profiles"]["RealUI"]["BarGroups"]["Buffs"]["parentFrame"] = nil
			end
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["Buffs"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["Buffs"]["anchorFrame"] = nil
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["Buffs"]["parentFrame"] = nil
			end
		end
	end
	
	-- 7.1 r4
	if ver == "71r4" then
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			local NotInRangeColor = {["b"] = 0.3529411764705882, ["g"] = 0.3529411764705882, ["r"] = 0.3529411764705882}
			local NotInterruptColor = {["b"] = 0.4313725490196079, ["g"] = 0.4313725490196079, ["r"] = 0.7843137254901961}
			if IceCoreRealUIDB["profiles"]["RealUI"]["colors"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["colors"]["CastNotInRange"] = NotInRangeColor
				IceCoreRealUIDB["profiles"]["RealUI"]["colors"]["CastNotInterruptible"] = NotInterruptColor
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["colors"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["colors"]["CastNotInRange"] = NotInRangeColor
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["colors"]["CastNotInterruptible"] = NotInterruptColor
			end
		end
		if IsAddOnLoaded("Raven") and RavenDB then
			if RavenDB["profiles"]["RealUI"]["BarGroups"]["TargetBuffsExtraPvP"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["TargetBuffsExtraPvP"]["showParty"] = true
				RavenDB["profiles"]["RealUI"]["BarGroups"]["TargetBuffsExtraPvP"]["showRaid"] = true
				RavenDB["profiles"]["RealUI"]["BarGroups"]["TargetBuffsExtraPvP"]["showNotInstance"] = true
			end
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["TargetBuffsExtraPvP"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["TargetBuffsExtraPvP"]["showParty"] = true
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["TargetBuffsExtraPvP"]["showRaid"] = true
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["TargetBuffsExtraPvP"]["showNotInstance"] = true
			end
		end
	end
	
	-- 7.1 r7
	if ver == "71r7" then
		if IsAddOnLoaded("Raven") and RavenDB then
			if RavenDB["profiles"]["RealUI"]["BarGroups"]["PlayerBuffs"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["PlayerBuffs"]["parentFrame"] = "oUF_RealUIPlayer_Overlay"
			end
			if RavenDB["profiles"]["RealUI"]["BarGroups"]["PlayerDebuffs"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["PlayerDebuffs"]["parentFrame"] = "oUF_RealUIPlayer_Overlay"
			end
			if RavenDB["profiles"]["RealUI"]["BarGroups"]["TargetBuffs"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["TargetBuffs"]["parentFrame"] = "oUF_RealUITarget_Overlay"
			end
			if RavenDB["profiles"]["RealUI"]["BarGroups"]["TargetDebuffs"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["TargetDebuffs"]["parentFrame"] = "oUF_RealUITarget_Overlay"
			end
			if RavenDB["profiles"]["RealUI"]["BarGroups"]["FocusBuffs"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["FocusBuffs"]["parentFrame"] = "oUF_RealUIFocus_Overlay"
			end
			if RavenDB["profiles"]["RealUI"]["BarGroups"]["FocusDebuffs"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["FocusDebuffs"]["parentFrame"] = "oUF_RealUIFocus_Overlay"
			end
			if RavenDB["profiles"]["RealUI"]["BarGroups"]["ToTDebuffs"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["ToTDebuffs"]["parentFrame"] = "oUF_RealUITargettarget_Overlay"
			end
			
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["PlayerBuffs"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["PlayerBuffs"]["parentFrame"] = "oUF_RealUIPlayer_Overlay"
			end
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["PlayerDebuffs"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["PlayerDebuffs"]["parentFrame"] = "oUF_RealUIPlayer_Overlay"
			end
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["TargetBuffs"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["TargetBuffs"]["parentFrame"] = "oUF_RealUITarget_Overlay"
			end
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["TargetDebuffs"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["TargetDebuffs"]["parentFrame"] = "oUF_RealUITarget_Overlay"
			end
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["FocusBuffs"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["FocusBuffs"]["parentFrame"] = "oUF_RealUIFocus_Overlay"
			end
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["FocusDebuffs"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["FocusDebuffs"]["parentFrame"] = "oUF_RealUIFocus_Overlay"
			end
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["ToTDebuffs"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["ToTDebuffs"]["parentFrame"] = "oUF_RealUITargettarget_Overlay"
			end
		end
	end
	
	-- 7.1 r8
	if ver == "71r8" then
		if IsAddOnLoaded("nibPointDisplay_RealUI") and nibPointDisplayRUIDB then
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["PALADIN"]["types"]["hp"]["position"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["PALADIN"]["types"]["hp"]["position"]["y"] = -114
				nibPointDisplayRUIDB["profiles"]["RealUI"]["PALADIN"]["types"]["hp"]["position"]["x"] = 0
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["PALADIN"]["types"]["hp"]["bars"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["PALADIN"]["types"]["hp"]["bars"]["size"] = {["height"] = 64, ["width"] = 64,}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["PALADIN"]["types"]["hp"]["bars"]["bg"]["full"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["PALADIN"]["types"]["hp"]["bars"]["bg"]["full"]["color"] = {["a"] = 0.9, ["b"] = 0.5, ["r"] = 1, ["g"] = 1,}
				nibPointDisplayRUIDB["profiles"]["RealUI"]["PALADIN"]["types"]["hp"]["bars"]["bg"]["full"]["maxcolor"] = {["b"] = 0.2, ["r"] = 1, ["g"] = 1,}
			end
			
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["PALADIN"]["types"]["hp"]["position"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["PALADIN"]["types"]["hp"]["position"]["y"] = -114
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["PALADIN"]["types"]["hp"]["position"]["x"] = 0
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["PALADIN"]["types"]["hp"]["bars"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["PALADIN"]["types"]["hp"]["bars"]["size"] = {["height"] = 64, ["width"] = 64,}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["PALADIN"]["types"]["hp"]["bars"]["bg"]["full"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["PALADIN"]["types"]["hp"]["bars"]["bg"]["full"]["color"] = {["a"] = 0.9, ["b"] = 0.5, ["r"] = 1, ["g"] = 1,}
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["PALADIN"]["types"]["hp"]["bars"]["bg"]["full"]["maxcolor"] = {["b"] = 0.2, ["r"] = 1, ["g"] = 1,}
			end
		end
	end
	
	-- 7.1 r9
	if ver == "71r9" then
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["updatePeriod"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["updatePeriod"] = 0.0334
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["updatePeriod"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["updatePeriod"] = 0.0334
			end
		end
		
		if IsAddOnLoaded("Bartender4") and Bartender4DB then
			local EABProf = {["version"] = 3, ["position"] = {["y"] = -10, ["x"] = -32, ["point"] = "TOP"}}
			if Bartender4DB["namespaces"]["ExtraActionBar"]["profiles"] then
				Bartender4DB["namespaces"]["ExtraActionBar"]["profiles"]["RealUI"] = EABProf
				Bartender4DB["namespaces"]["ExtraActionBar"]["profiles"]["RealUI-HR"] = EABProf
				Bartender4DB["namespaces"]["ExtraActionBar"]["profiles"]["RealUI-Healing"] = EABProf
				Bartender4DB["namespaces"]["ExtraActionBar"]["profiles"]["RealUI-HR-Healing"] = EABProf
			end
		end
	end
	
	-- 7.1 r10
	if ver == "71r10" then
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["RogueExtras1"] = {
					["barVerticalOffset"] = 15,
					["forceJustifyText"] = "RIGHT",
					["textHorizontalOffset"] = -6,
					["displayAuraIcon"] = true,
					["auraIconXOffset"] = 24,
					["barHorizontalOffset"] = -4,
					["auraIconYOffset"] = -29,
					["scale"] = 0.85,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["auraIconSize"] = 28,
					["lockLowerTextAlpha"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["RogueExtras2"] = {
					["barVerticalOffset"] = 32,
					["side"] = "LEFT",
					["forceJustifyText"] = "RIGHT",
					["textHorizontalOffset"] = -16,
					["barHorizontalOffset"] = -12,
					["scale"] = 0.75,
					["widthModifier"] = -16,
					["myTagVersion"] = 3,
					["textVerticalOffset"] = 4,
					["offset"] = 3,
					["barFontSize"] = 8,
					["textVisible"] = {["lower"] = false},
					["enabled"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["RogueLegendary"] = {
					["barVerticalOffset"] = 45,
					["side"] = "LEFT",
					["scale"] = 0.6849999999999999,
					["textHorizontalOffset"] = -1,
					["widthModifier"] = -34,
					["textVerticalOffset"] = 28,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "LEFT",
					["barHorizontalOffset"] = 21,
				}
				if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["SliceAndDice"] then
					IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["SliceAndDice"]["textHorizontalOffset"] = 8
				end
				if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-1"] then
					IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-1"]["textHorizontalOffset"] = 12
				end
				if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-2"] then
					IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-2"]["textHorizontalOffset"] = 11
				end
				if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-3"] then
					IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-3"]["textHorizontalOffset"] = 12
				end
				if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Envenom"] then
					IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Envenom"]["textHorizontalOffset"] = 12
				end
				if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Recuperate"] then
					IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Recuperate"]["textHorizontalOffset"] = 5
					IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Recuperate"]["talentGroups"] = 3
				end
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Recuperate-Sub"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["talentGroups"] = 4,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 1,
						["b"] = 0.5529411764705883,
					},
					["barHorizontalOffset"] = 5,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "R",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "LEFT",
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["exactMatch"] = true,
					["barFontSize"] = 8,
					["myTagVersion"] = 3,
					["lowerText"] = "",
					["buffOrDebuff"] = "buff",
					["barVerticalOffset"] = 33,
					["scale"] = 0.745,
					["side"] = "LEFT",
					["buffToTrack"] = "73651",
					["textVerticalOffset"] = 12,
					["textHorizontalOffset"] = 12,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["auraIconXOffset"] = 40,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["enabled"] = true,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["class"] = "ROGUE",
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-FindWeakness"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["talentGroups"] = 4,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["barHorizontalOffset"] = 13,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "F",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "debuff",
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["textVerticalOffset"] = 20,
					["trackOnlyMine"] = true,
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["scale"] = 0.715,
					["barVerticalOffset"] = 39,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "91021",
					["auraIconXOffset"] = 40,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = 5,
					["shouldUseOverride"] = false,
					["widthModifier"] = -28,
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["enabled"] = true,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["class"] = "ROGUE",
				}
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["RogueExtras1"] = {
					["barVerticalOffset"] = 15,
					["forceJustifyText"] = "RIGHT",
					["textHorizontalOffset"] = -6,
					["displayAuraIcon"] = true,
					["auraIconXOffset"] = 25,
					["barHorizontalOffset"] = -4,
					["auraIconYOffset"] = -30,
					["scale"] = 0.85,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["auraIconSize"] = 28,
					["lockLowerTextAlpha"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["RogueExtras2"] = {
					["offset"] = 3,
					["AuraIconSize"] = 27,
					["barHorizontalOffset"] = -12,
					["scale"] = 0.75,
					["textVerticalOffset"] = 3,
					["myTagVersion"] = 3,
					["barVerticalOffset"] = 32,
					["side"] = "LEFT",
					["textHorizontalOffset"] = -16,
					["widthModifier"] = -16,
					["textVisible"] = {
						["lower"] = false,
					},
					["forceJustifyText"] = "RIGHT",
					["barFontSize"] = 8,
					["enabled"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["RogueLegendary"] = {
					["forceJustifyText"] = "LEFT",
					["textVerticalOffset"] = 34,
					["myTagVersion"] = 3,
					["offset"] = 2,
					["side"] = "LEFT",
					["widthModifier"] = -34,
					["barHorizontalOffset"] = 21,
					["barVerticalOffset"] = 45,
					["scale"] = 0.6849999999999999,
				}
				if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["SliceAndDice"] then
					IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["SliceAndDice"]["textHorizontalOffset"] = 6
				end
				if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-1"] then
					IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-1"]["textHorizontalOffset"] = 13
				end
				if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-2"] then
					IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-2"]["textHorizontalOffset"] = 12
				end
				if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-3"] then
					IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-3"]["textHorizontalOffset"] = 13
				end
				if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Envenom"] then
					IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Envenom"]["textHorizontalOffset"] = 14
				end
				if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Recuperate"] then
					IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Recuperate"]["textHorizontalOffset"] = 6
					IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Recuperate"]["talentGroups"] = 3
				end
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Recuperate-Sub"] = {
					["shouldAnimate"] = false,
					["class"] = "ROGUE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["talentGroups"] = 4,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.5529411764705883,
						["g"] = 1,
						["r"] = 0,
					},
					["barHorizontalOffset"] = 5,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "R",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "buff",
					["scale"] = 0.745,
					["alwaysFullAlpha"] = false,
					["exactMatch"] = true,
					["trackOnlyMine"] = true,
					["myTagVersion"] = 3,
					["offset"] = 2,
					["auraIconXOffset"] = 40,
					["barVerticalOffset"] = 33,
					["lockUpperTextAlpha"] = true,
					["side"] = "LEFT",
					["buffToTrack"] = "73651",
					["forceJustifyText"] = "LEFT",
					["textHorizontalOffset"] = 13,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textVerticalOffset"] = 14,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerText"] = "",
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-FindWeakness"] = {
					["shouldAnimate"] = false,
					["class"] = "ROGUE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["talentGroups"] = 4,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0,
						["b"] = 0,
					},
					["barHorizontalOffset"] = 13,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "F",
					["lowerText"] = "",
					["scale"] = 0.715,
					["offset"] = 2,
					["alwaysFullAlpha"] = false,
					["textVerticalOffset"] = 24,
					["barFontSize"] = 8,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "LEFT",
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 39,
					["buffOrDebuff"] = "debuff",
					["side"] = "LEFT",
					["buffToTrack"] = "91021",
					["buffTimerDisplay"] = "seconds",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = 6,
					["auraIconXOffset"] = 40,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["exactMatch"] = true,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
				}
			end
			
		end
		
		if IsAddOnLoaded("Raven") and RavenDB then
			if RavenDB["global"]["SpellLists"]["TargetExclusions"] then
				RavenDB["global"]["SpellLists"]["TargetExclusions"]["#79140"] = true
				RavenDB["global"]["SpellLists"]["TargetExclusions"]["#91021"] = true
			end
			if RavenDB["global"]["SpellLists"]["PlayerExclusions"] then
				RavenDB["global"]["SpellLists"]["PlayerExclusions"]["#13750"] = true
				RavenDB["global"]["SpellLists"]["PlayerExclusions"]["#51713"] = true
				RavenDB["global"]["SpellLists"]["PlayerExclusions"]["#57933"] = true
				RavenDB["global"]["SpellLists"]["PlayerExclusions"]["#109941"] = true
				RavenDB["global"]["SpellLists"]["PlayerExclusions"]["#109949"] = true
				RavenDB["global"]["SpellLists"]["PlayerExclusions"]["#109955"] = true
				RavenDB["global"]["SpellLists"]["PlayerExclusions"]["#109959"] = true
			end
		end
	end
end