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
	
	-- 7.2 r1
	if ver == "72r1" then
		if IsAddOnLoaded("ACP") and ACP_Data then
			if ACP_Data["sorter"] then
				ACP_Data["sorter"] = "Titles"
			end
		end
		if IsAddOnLoaded("BugSack") and BugSackDB then
			if BugSackDB["mute"] then
				BugSackDB["mute"] = false
			end
		end
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-DK-BloodPlague"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-DK-BloodPlague"]["spec"] = {
					["spec3"] = true,
					["spec4"] = false,
					["spec1"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-DK-BloodPlague"]["class"] = "Death Knight"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-DK-FrostFever"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-DK-FrostFever"]["spec"] = {
					["spec4"] = false,
					["spec3"] = true,
					["spec1"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-DK-FrostFever"]["class"] = "Death Knight"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-DK-FrostFever(Blood)"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-DK-FrostFever(Blood)"]["spec"] = {
					["spec3"] = false,
					["spec4"] = false,
					["spec1"] = true,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-DK-FrostFever(Blood)"]["class"] = "Death Knight"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Berserk"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Berserk"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Berserk"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Harmony"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Harmony"]["spec"] = {
					["spec3"] = false,
					["spec1"] = false,
					["spec4"] = true,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Harmony"]["buffToTrack"] = "100977"
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Harmony"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-InsectSwarm"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-InsectSwarm"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-InsectSwarm"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Lacerate"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Lacerate"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Lacerate"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Moonfire"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Moonfire"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Moonfire"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Pulverize"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Pulverize"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Pulverize"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Rake"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Rake"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Rake"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Rip"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Rip"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Rip"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-TigersFury"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-TigersFury"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-TigersFury"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Hun-BlackArrow"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Hun-BlackArrow"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Hun-BlackArrow"]["class"] = "Hunter"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Hun-SerpentSting"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Hun-SerpentSting"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Hun-SerpentSting"]["class"] = "Hunter"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-ArcaneBlast"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-ArcaneBlast"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-ArcaneBlast"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-FingersFrost"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-FingersFrost"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-FingersFrost"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Frostfire(G)"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Frostfire(G)"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Frostfire(G)"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Ignite"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Ignite"]["spec"] = {
					["spec3"] = false,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Ignite"]["buffToTrack"] = "12654"
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Ignite"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-LivingBomb"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-LivingBomb"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-LivingBomb"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Pyroblast"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Pyroblast"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Pyroblast"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Pyroblast!"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Pyroblast!"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mag-Pyroblast!"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mon-DizzyingHaze"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mon-DizzyingHaze"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mon-DizzyingHaze"]["class"] = "Monk"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mon-Shuffle"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mon-Shuffle"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mon-Shuffle"]["class"] = "Monk"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-ArdentDefender"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-ArdentDefender"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-ArdentDefender"]["class"] = "Paladin"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-AvengingWrath"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-AvengingWrath"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-AvengingWrath"]["class"] = "Paladin"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-DivineProtection"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-DivineProtection"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-DivineProtection"]["class"] = "Paladin"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-HolyAvenger"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-HolyAvenger"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-HolyAvenger"]["class"] = "Paladin"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-Inquisition"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-Inquisition"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pal-Inquisition"]["class"] = "Paladin"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-DarkEvangelism"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-DarkEvangelism"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-DarkEvangelism"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-DevPlague"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-DevPlague"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-DevPlague"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-EmpoweredShadow"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-EmpoweredShadow"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-EmpoweredShadow"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-Evangelism"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-Evangelism"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-Evangelism"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-MindSpike"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-MindSpike"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-MindSpike"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-SWP"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-SWP"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-SWP"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-VampTouch"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-VampTouch"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Pri-VampTouch"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-1"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-1"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-1"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-2"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-2"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-2"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-3"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-3"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-BanditsGuile-3"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Envenom"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Envenom"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Envenom"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-FindWeakness"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-FindWeakness"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-FindWeakness"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Hemorrhage"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Hemorrhage"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Hemorrhage"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Hemorrhage(G)"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Hemorrhage(G)"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Hemorrhage(G)"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Recuperate"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Recuperate"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Recuperate"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Recuperate-Sub"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Recuperate-Sub"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Recuperate-Sub"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Revealing"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Revealing"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Revealing"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Rupture"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Rupture"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Rog-Rupture"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Sha-EarthShock"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Sha-EarthShock"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Sha-EarthShock"]["class"] = "Shaman"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Sha-FlameShock"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Sha-FlameShock"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Sha-FlameShock"]["class"] = "Shaman"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Sha-FrostShock"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Sha-FrostShock"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Sha-FrostShock"]["class"] = "Shaman"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-BoA"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-BoA"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-BoA"]["class"] = "Warlock"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-BoD"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-BoD"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-BoD"]["class"] = "Warlock"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-Corruption"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-Corruption"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-Corruption"]["class"] = "Warlock"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-Immolate"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-Immolate"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-Immolate"]["class"] = "Warlock"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-UAffliction"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-UAffliction"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-UAffliction"]["class"] = "Warlock"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-ShadowAndFlame"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-ShadowAndFlame"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Wlock-ShadowAndFlame"]["class"] = "Warlock"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-DeadlyCalm"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-DeadlyCalm"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-DeadlyCalm"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Enrage"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Enrage"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Enrage"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Enrage2"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Enrage2"]["spec"] = {
					["spec3"] = false,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Enrage2"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Hamstring"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Hamstring"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Hamstring"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-MeatCleaver"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-MeatCleaver"]["spec"] = {
					["spec3"] = false,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-MeatCleaver"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-TasteBlood"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-TasteBlood"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-TasteBlood"]["buffToTrack"] = "56638"
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-TasteBlood"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Victorious"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Victorious"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-War-Victorious"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-DK-BloodPlague"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-DK-BloodPlague"]["spec"] = {
					["spec3"] = true,
					["spec4"] = false,
					["spec1"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-DK-BloodPlague"]["class"] = "Death Knight"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-DK-FrostFever"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-DK-FrostFever"]["spec"] = {
					["spec4"] = false,
					["spec3"] = true,
					["spec1"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-DK-FrostFever"]["class"] = "Death Knight"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-DK-FrostFever(Blood)"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-DK-FrostFever(Blood)"]["spec"] = {
					["spec3"] = false,
					["spec4"] = false,
					["spec1"] = true,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-DK-FrostFever(Blood)"]["class"] = "Death Knight"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Berserk"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Berserk"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Berserk"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Harmony"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Harmony"]["spec"] = {
					["spec3"] = false,
					["spec1"] = false,
					["spec4"] = true,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Harmony"]["buffToTrack"] = "100977"
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Harmony"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-InsectSwarm"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-InsectSwarm"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-InsectSwarm"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Lacerate"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Lacerate"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Lacerate"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Moonfire"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Moonfire"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Moonfire"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Pulverize"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Pulverize"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Pulverize"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Rake"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Rake"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Rake"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Rip"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Rip"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Rip"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Sunfire"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Sunfire"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Sunfire"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-TigersFury"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-TigersFury"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = true,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-TigersFury"]["class"] = "Druid"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Hun-BlackArrow"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Hun-BlackArrow"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Hun-BlackArrow"]["class"] = "Hunter"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Hun-SerpentSting"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Hun-SerpentSting"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Hun-SerpentSting"]["class"] = "Hunter"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-ArcaneBlast"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-ArcaneBlast"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-ArcaneBlast"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-FingersFrost"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-FingersFrost"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-FingersFrost"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Frostfire(G)"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Frostfire(G)"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Frostfire(G)"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Ignite"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Ignite"]["spec"] = {
					["spec3"] = false,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Ignite"]["buffToTrack"] = "12654"
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Ignite"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-LivingBomb"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-LivingBomb"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-LivingBomb"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Pyroblast"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Pyroblast"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Pyroblast"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Pyroblast!"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Pyroblast!"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mag-Pyroblast!"]["class"] = "Mage"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mon-DizzyingHaze"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mon-DizzyingHaze"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mon-DizzyingHaze"]["class"] = "Monk"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mon-Shuffle"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mon-Shuffle"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mon-Shuffle"]["class"] = "Monk"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-ArdentDefender"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-ArdentDefender"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-ArdentDefender"]["class"] = "Paladin"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-AvengingWrath"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-AvengingWrath"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-AvengingWrath"]["class"] = "Paladin"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-DivineProtection"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-DivineProtection"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-DivineProtection"]["class"] = "Paladin"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-HolyAvenger"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-HolyAvenger"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-HolyAvenger"]["class"] = "Paladin"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-Inquisition"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-Inquisition"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pal-Inquisition"]["class"] = "Paladin"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-DarkEvangelism"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-DarkEvangelism"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-DarkEvangelism"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-DevPlague"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-DevPlague"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-DevPlague"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-EmpoweredShadow"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-EmpoweredShadow"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-EmpoweredShadow"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-Evangelism"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-Evangelism"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-Evangelism"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-MindSpike"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-MindSpike"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-MindSpike"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-SWP"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-SWP"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-SWP"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-VampTouch"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-VampTouch"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Pri-VampTouch"]["class"] = "Priest"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-1"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-1"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-1"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-2"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-2"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-2"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-3"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-3"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-BanditsGuile-3"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Envenom"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Envenom"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Envenom"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-FindWeakness"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-FindWeakness"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-FindWeakness"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Hemorrhage"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Hemorrhage"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Hemorrhage"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Hemorrhage(G)"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Hemorrhage(G)"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Hemorrhage(G)"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Recuperate"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Recuperate"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Recuperate"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Recuperate-Sub"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Recuperate-Sub"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Recuperate-Sub"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Revealing"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Revealing"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Revealing"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Rupture"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Rupture"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Rog-Rupture"]["class"] = "Rogue"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Sha-EarthShock"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Sha-EarthShock"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Sha-EarthShock"]["class"] = "Shaman"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Sha-FlameShock"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Sha-FlameShock"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Sha-FlameShock"]["class"] = "Shaman"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Sha-FrostShock"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Sha-FrostShock"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Sha-FrostShock"]["class"] = "Shaman"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-BoA"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-BoA"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-BoA"]["class"] = "Warlock"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-BoD"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-BoD"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-BoD"]["class"] = "Warlock"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-Corruption"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-Corruption"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-Corruption"]["class"] = "Warlock"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-Immolate"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-Immolate"]["spec"] = {
					["spec3"] = true,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-Immolate"]["class"] = "Warlock"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-UAffliction"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-UAffliction"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-UAffliction"]["class"] = "Warlock"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-ShadowAndFlame"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-ShadowAndFlame"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Wlock-ShadowAndFlame"]["class"] = "Warlock"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-DeadlyCalm"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-DeadlyCalm"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-DeadlyCalm"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Enrage"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Enrage"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Enrage"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Enrage2"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Enrage2"]["spec"] = {
					["spec3"] = false,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Enrage2"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Hamstring"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Hamstring"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Hamstring"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-MeatCleaver"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-MeatCleaver"]["spec"] = {
					["spec3"] = false,
					["spec1"] = false,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-MeatCleaver"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-TasteBlood"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-TasteBlood"]["spec"] = {
					["spec3"] = false,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = false,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-TasteBlood"]["buffToTrack"] = "56638"
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-TasteBlood"]["class"] = "Warrior"
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Victorious"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Victorious"]["spec"] = {
					["spec3"] = true,
					["spec1"] = true,
					["spec4"] = false,
					["spec2"] = true,
				}
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-War-Victorious"]["class"] = "Warrior"
			end
		end
		if IsAddOnLoaded("nibPointDisplay_RealUI") and nibPointDisplayRUIDB then
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["WARRIOR"]["types"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["WARRIOR"]["types"]["tb"] = {
					["position"] = {
						["y"] = -31,
						["x"] = -48,
					},
					["bars"] = {
						["position"] = {
							["gap"] = -3,
						},
						["bg"] = {
							["full"] = {
								["color"] = {
									["r"] = 0.807843137254902,
									["g"] = 0.5333333333333333,
									["b"] = 0.1215686274509804,
								},
								["maxcolor"] = {
									["g"] = 0.6627450980392157,
									["b"] = 0.1490196078431373,
								},
							},
						},
					},
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["WARRIOR"]["types"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["WARRIOR"]["types"]["tb"] = {
					["position"] = {
						["y"] = -31,
						["x"] = -68,
					},
					["bars"] = {
						["position"] = {
							["gap"] = -3,
						},
						["bg"] = {
							["full"] = {
								["color"] = {
									["r"] = 0.807843137254902,
									["g"] = 0.5333333333333333,
									["b"] = 0.1215686274509804,
								},
								["maxcolor"] = {
									["g"] = 0.6627450980392157,
									["b"] = 0.1490196078431373,
								},
							},
						},
					},
				}
			end
		end
		if IsAddOnLoaded("Raven") and RavenDB then
			if RavenDB["profiles"]["RealUI"]["BarGroups"]["ToTDebuffs"] then
				RavenDB["profiles"]["RealUI"]["BarGroups"]["ToTDebuffs"]["parentFrame"] = "oUF_RealUITargetTarget_Overlay"
			end
			if RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["ToTDebuffs"] then
				RavenDB["profiles"]["RealUI-HR"]["BarGroups"]["ToTDebuffs"]["parentFrame"] = "oUF_RealUITargetTarget_Overlay"
			end
		end
	end
end