local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

function nibRealUI:LoadAddonData()

--------------------
---- BugGrabber ----
--------------------
BugGrabberDB = {
	["stopnag"] = 50001,
	["throttle"] = true,
	["limit"] = 50,
	["errors"] = {},
	["save"] = false,
	["session"] = 1,
}






--------------------
---- Bartender4 ----
--------------------
Bartender4DB = {
	["namespaces"] = {
		["ActionBars"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["actionbars"] = {
						{
							["showgrid"] = true,
							["skin"] = {
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["ID"] = "PixelSkin",
								["Backdrop"] = false,
							},
							["fadeoutalpha"] = 0,
							["version"] = 3,
							["position"] = {
								["y"] = -186.5,
								["x"] = -171.5,
								["point"] = "CENTER",
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["custom"] = true,
								["customdata"] = "[mod:ctrl][target=focus,exists][harm,nodead][combat][group:party][group:raid][vehicleui]show;hide",
							},
						}, -- [1]
						{
							["showgrid"] = true,
							["skin"] = {
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["ID"] = "PixelSkin",
								["Backdrop"] = false,
							},
							["version"] = 3,
							["fadeoutalpha"] = 0.25,
							["position"] = {
								["y"] = -213.5,
								["x"] = -171.5,
								["point"] = "CENTER",
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["custom"] = true,
								["customdata"] = "[mod:ctrl][combat]show;[target=focus,exists][harm,nodead][group:party][group:raid][vehicleui]fade;hide",
								["vehicleui"] = false,
							},
							["states"] = {
								["default"] = 2,
								["actionbar"] = true,
								["stance"] = {
									["ROGUE"] = {
										["stealth"] = 8,
									},
									["DRUID"] = {
										["prowl"] = 3,
										["cat"] = 3,
										["bear"] = 4,
										["moonkin"] = 2,
										["treeoflife"] = 2,
									},
								},
							},
						}, -- [2]
						{
							["showgrid"] = true,
							["skin"] = {
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["ID"] = "PixelSkin",
								["Backdrop"] = false,
							},
							["padding"] = -9,
							["fadeoutalpha"] = 0.25,
							["position"] = {
								["y"] = -240.5,
								["x"] = -171.5,
								["point"] = "CENTER",
							},
							["version"] = 3,
							["hidemacrotext"] = true,
							["visibility"] = {
								["customdata"] = "[mod:ctrl][combat]show;[target=focus,exists][harm,nodead][group:party][group:raid][vehicleui]fade;hide",
								["custom"] = true,
								["possess"] = false,
								["always"] = false,
								["nocombat"] = false,
								["vehicleui"] = false,
							},
						}, -- [3]
						{
							["showgrid"] = true,
							["skin"] = {
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["ID"] = "PixelSkin",
								["Backdrop"] = false,
							},
							["enabled"] = false,
							["padding"] = -9,
							["version"] = 3,
							["position"] = {
								["y"] = -267.5,
								["x"] = -171.5,
								["point"] = "CENTER",
							},
							["fadeoutalpha"] = 0.25,
							["hidemacrotext"] = true,
							["visibility"] = {
								["custom"] = true,
								["customdata"] = "[mod:ctrl][combat]show;[target=focus,exists][harm,nodead][group:party][group:raid][vehicleui]fade;hide",
								["possess"] = false,
								["nocombat"] = false,
								["vehicleui"] = false,
							},
						}, -- [4]
						{
							["showgrid"] = true,
							["rows"] = 12,
							["fadeout"] = true,
							["skin"] = {
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["ID"] = "PixelSkin",
								["Backdrop"] = false,
							},
							["padding"] = -9,
							["version"] = 3,
							["position"] = {
								["y"] = 334.5,
								["x"] = -37,
								["point"] = "RIGHT",
							},
							["fadeoutalpha"] = 0,
							["hidemacrotext"] = true,
							["visibility"] = {
								["custom"] = true,
								["customdata"] = "[mod:ctrl]show;fade",
								["vehicleui"] = false,
							},
						}, -- [5]
						{
							["showgrid"] = true,
							["rows"] = 12,
							["fadeout"] = true,
							["skin"] = {
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["ID"] = "PixelSkin",
								["Backdrop"] = false,
							},
							["padding"] = -9,
							["version"] = 3,
							["position"] = {
								["y"] = 10.5,
								["x"] = -37,
								["point"] = "RIGHT",
							},
							["fadeoutalpha"] = 0,
							["hidemacrotext"] = true,
							["visibility"] = {
								["custom"] = true,
								["customdata"] = "[mod:ctrl]show;fade",
								["vehicleui"] = false,
							},
						}, -- [6]
						{
							["showgrid"] = true,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Backdrop"] = false,
								["Gloss"] = 0.5,
							},
							["version"] = 3,
							["position"] = {
								["y"] = 260.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["vehicleui"] = false,
							},
						}, -- [7]
						{
							["showgrid"] = true,
							["skin"] = {
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["ID"] = "PixelSkin",
								["Backdrop"] = false,
							},
							["fadeoutalpha"] = 0,
							["version"] = 3,
							["position"] = {
								["y"] = 290.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["vehicleui"] = false,
							},
						}, -- [8]
						{
							["showgrid"] = true,
							["skin"] = {
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["ID"] = "PixelSkin",
								["Backdrop"] = false,
							},
							["fadeoutalpha"] = 0,
							["version"] = 3,
							["position"] = {
								["y"] = 320.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["custom"] = false,
								["customdata"] = "",
								["vehicleui"] = false,
							},
						}, -- [9]
						{
							["showgrid"] = true,
							["skin"] = {
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["ID"] = "PixelSkin",
								["Backdrop"] = false,
							},
							["fadeoutalpha"] = 0,
							["version"] = 3,
							["position"] = {
								["y"] = 350.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["custom"] = false,
								["customdata"] = "",
								["vehicleui"] = false,
							},
						}, -- [10]
					},
				},
				["RealUI-HR-Healing"] = {
					["actionbars"] = {
						{
							["showgrid"] = true,
							["position"] = {
								["y"] = 92,
								["x"] = -171.5,
								["point"] = "BOTTOM",
							},
							["version"] = 3,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["custom"] = true,
								["customdata"] = "[mod:ctrl][target=focus,exists][harm,nodead][combat][group:party][group:raid][vehicleui]show;hide",
							},
							["fadeoutalpha"] = 0,
						}, -- [1]
						{
							["showgrid"] = true,
							["version"] = 3,
							["position"] = {
								["y"] = 65,
								["x"] = -171.5,
								["point"] = "BOTTOM",
							},
							["fadeoutalpha"] = 0.25,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["customdata"] = "[mod:ctrl][combat]show;[target=focus,exists][harm,nodead][group:party][group:raid][vehicleui]fade;hide",
								["custom"] = true,
								["vehicleui"] = false,
							},
							["states"] = {
								["stance"] = {
									["DRUID"] = {
										["prowl"] = 3,
										["cat"] = 3,
										["bear"] = 4,
										["moonkin"] = 2,
										["treeoflife"] = 2,
									},
									["ROGUE"] = {
										["stealth"] = 8,
									},
								},
								["default"] = 2,
								["actionbar"] = true,
							},
						}, -- [2]
						{
							["showgrid"] = true,
							["position"] = {
								["y"] = 38,
								["x"] = -171.5,
								["point"] = "BOTTOM",
							},
							["version"] = 3,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["custom"] = true,
								["always"] = false,
								["possess"] = false,
								["customdata"] = "[mod:ctrl][combat]show;[target=focus,exists][harm,nodead][group:party][group:raid][vehicleui]fade;hide",
								["nocombat"] = false,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0.25,
						}, -- [3]
						{
							["enabled"] = false,
							["showgrid"] = true,
							["version"] = 3,
							["fadeoutalpha"] = 0.25,
							["position"] = {
								["y"] = 38,
								["x"] = -171.5,
								["point"] = "BOTTOM",
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["custom"] = true,
								["customdata"] = "[mod:ctrl][combat]show;[target=focus,exists][harm,nodead][group:party][group:raid][vehicleui]fade;hide",
								["possess"] = false,
								["nocombat"] = false,
								["vehicleui"] = false,
							},
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
						}, -- [4]
						{
							["showgrid"] = true,
							["rows"] = 12,
							["version"] = 3,
							["fadeoutalpha"] = 0,
							["position"] = {
								["y"] = 334.5,
								["x"] = -37,
								["point"] = "RIGHT",
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["customdata"] = "[mod:ctrl]show;fade",
								["custom"] = true,
								["vehicleui"] = false,
							},
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
						}, -- [5]
						{
							["showgrid"] = true,
							["rows"] = 12,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["fadeout"] = true,
							["version"] = 3,
							["position"] = {
								["y"] = 10.5,
								["x"] = -37,
								["point"] = "RIGHT",
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["customdata"] = "[mod:ctrl]show;fade",
								["custom"] = true,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [6]
						{
							["version"] = 3,
							["showgrid"] = true,
							["position"] = {
								["y"] = 260.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["vehicleui"] = false,
							},
							["skin"] = {
								["Gloss"] = 0.5,
								["Backdrop"] = false,
								["ID"] = "PixelSkin",
							},
						}, -- [7]
						{
							["version"] = 3,
							["fadeoutalpha"] = 0,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 290.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["vehicleui"] = false,
							},
							["showgrid"] = true,
						}, -- [8]
						{
							["version"] = 3,
							["fadeoutalpha"] = 0,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 320.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["customdata"] = "",
								["custom"] = false,
								["vehicleui"] = false,
							},
							["showgrid"] = true,
						}, -- [9]
						{
							["version"] = 3,
							["fadeoutalpha"] = 0,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 350.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["customdata"] = "",
								["custom"] = false,
								["vehicleui"] = false,
							},
							["showgrid"] = true,
						}, -- [10]
					},
				},
				["RealUI-Healing"] = {
					["actionbars"] = {
						{
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["position"] = {
								["y"] = 65,
								["x"] = -171.5,
								["point"] = "BOTTOM",
							},
							["version"] = 3,
							["showgrid"] = true,
							["hidemacrotext"] = true,
							["padding"] = -9,
							["visibility"] = {
								["custom"] = true,
								["customdata"] = "[mod:ctrl][target=focus,exists][harm,nodead][combat][group:party][group:raid][vehicleui]show;hide",
							},
							["fadeoutalpha"] = 0,
						}, -- [1]
						{
							["showgrid"] = true,
							["fadeoutalpha"] = 0.25,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["version"] = 3,
							["position"] = {
								["y"] = 38,
								["x"] = -171.5,
								["point"] = "BOTTOM",
							},
							["hidemacrotext"] = true,
							["padding"] = -9,
							["visibility"] = {
								["customdata"] = "[mod:ctrl][combat]show;[target=focus,exists][harm,nodead][group:party][group:raid][vehicleui]fade;hide",
								["custom"] = true,
								["vehicleui"] = false,
							},
							["states"] = {
								["actionbar"] = true,
								["default"] = 2,
								["stance"] = {
									["ROGUE"] = {
										["stealth"] = 8,
									},
									["DRUID"] = {
										["prowl"] = 3,
										["cat"] = 3,
										["bear"] = 4,
										["moonkin"] = 2,
										["treeoflife"] = 2,
									},
								},
							},
						}, -- [2]
						{
							["enabled"] = false,
							["showgrid"] = true,
							["position"] = {
								["y"] = 38,
								["x"] = -171.5,
								["point"] = "BOTTOM",
							},
							["version"] = 3,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["hidemacrotext"] = true,
							["padding"] = -9,
							["visibility"] = {
								["custom"] = true,
								["possess"] = false,
								["always"] = false,
								["customdata"] = "[mod:ctrl][combat]show;[target=focus,exists][harm,nodead][group:party][group:raid][vehicleui]fade;hide",
								["nocombat"] = false,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0.25,
						}, -- [3]
						{
							["enabled"] = false,
							["showgrid"] = true,
							["position"] = {
								["y"] = 38,
								["x"] = -171.5,
								["point"] = "BOTTOM",
							},
							["fadeoutalpha"] = 0,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["hidemacrotext"] = true,
							["padding"] = -9,
							["visibility"] = {
								["custom"] = true,
								["possess"] = false,
								["customdata"] = "[mod:ctrl][combat]show;[target=focus,exists][harm,nodead][group:party][group:raid][vehicleui]fade;hide",
								["nocombat"] = false,
								["vehicleui"] = false,
							},
							["version"] = 3,
						}, -- [4]
						{
							["showgrid"] = true,
							["rows"] = 12,
							["buttons"] = 9,
							["position"] = {
								["y"] = 178.5,
								["x"] = -37,
								["point"] = "RIGHT",
							},
							["version"] = 3,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["hidemacrotext"] = true,
							["padding"] = -9,
							["visibility"] = {
								["customdata"] = "[mod:ctrl]show;fade",
								["custom"] = true,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [5]
						{
							["showgrid"] = true,
							["rows"] = 12,
							["buttons"] = 9,
							["position"] = {
								["y"] = 178.5,
								["x"] = -7,
								["point"] = "LEFT",
							},
							["version"] = 3,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["customdata"] = "[mod:ctrl]show;fade",
								["custom"] = true,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [6]
						{
							["version"] = 3,
							["showgrid"] = true,
							["skin"] = {
								["Gloss"] = 0.5,
								["Backdrop"] = false,
								["ID"] = "PixelSkin",
							},
							["padding"] = -8,
							["visibility"] = {
								["vehicleui"] = false,
							},
							["position"] = {
								["y"] = 260.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
						}, -- [7]
						{
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["version"] = 3,
							["showgrid"] = true,
							["position"] = {
								["y"] = 290.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [8]
						{
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["version"] = 3,
							["showgrid"] = true,
							["position"] = {
								["y"] = 320.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["customdata"] = "",
								["custom"] = false,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [9]
						{
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["version"] = 3,
							["showgrid"] = true,
							["position"] = {
								["y"] = 350.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["customdata"] = "",
								["custom"] = false,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [10]
					},
				},
				["RealUI"] = {
					["actionbars"] = {
						{
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["version"] = 3,
							["fadeoutalpha"] = 0,
							["position"] = {
								["y"] = -186.5,
								["x"] = -171.5,
								["point"] = "CENTER",
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["custom"] = true,
								["customdata"] = "[mod:ctrl][target=focus,exists][harm,nodead][combat][group:party][group:raid][vehicleui]show;hide",
							},
							["showgrid"] = true,
						}, -- [1]
						{
							["showgrid"] = true,
							["fadeoutalpha"] = 0,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["version"] = 3,
							["position"] = {
								["y"] = -213.5,
								["x"] = -171.5,
								["point"] = "CENTER",
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["customdata"] = "[mod:ctrl][combat]show;[target=focus,exists][harm,nodead][group:party][group:raid][vehicleui]fade;hide",
								["custom"] = true,
								["vehicleui"] = false,
							},
							["states"] = {
								["actionbar"] = true,
								["default"] = 2,
								["stance"] = {
									["DRUID"] = {
										["prowl"] = 3,
										["cat"] = 3,
										["bear"] = 4,
										["moonkin"] = 2,
										["treeoflife"] = 2,
									},
									["ROGUE"] = {
										["stealth"] = 8,
									},
								},
							},
						}, -- [2]
						{
							["enabled"] = false,
							["showgrid"] = true,
							["position"] = {
								["y"] = -240.5,
								["x"] = -171.5,
								["point"] = "CENTER",
							},
							["version"] = 3,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["custom"] = true,
								["always"] = false,
								["possess"] = false,
								["customdata"] = "[mod:ctrl][combat]show;[target=focus,exists][harm,nodead][group:party][group:raid][vehicleui]fade;hide",
								["nocombat"] = false,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [3]
						{
							["enabled"] = false,
							["showgrid"] = true,
							["position"] = {
								["y"] = -267.5,
								["x"] = -171.5,
								["point"] = "CENTER",
							},
							["version"] = 3,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["custom"] = true,
								["possess"] = false,
								["customdata"] = "[mod:ctrl][combat]show;[target=focus,exists][harm,nodead][group:party][group:raid][vehicleui]fade;hide",
								["nocombat"] = false,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [4]
						{
							["showgrid"] = true,
							["rows"] = 12,
							["buttons"] = 9,
							["position"] = {
								["y"] = 128.5,
								["x"] = -37,
								["point"] = "RIGHT",
							},
							["version"] = 3,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
									["Backdrop"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										0, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["customdata"] = "[mod:ctrl]show;fade",
								["custom"] = true,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [5]
						{
							["showgrid"] = true,
							["rows"] = 12,
							["buttons"] = 9,
							["position"] = {
								["y"] = 128.5,
								["x"] = -7,
								["point"] = "LEFT",
							},
							["version"] = 3,
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["padding"] = -9,
							["hidemacrotext"] = true,
							["visibility"] = {
								["customdata"] = "[mod:ctrl]show;fade",
								["custom"] = true,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [6]
						{
							["version"] = 3,
							["showgrid"] = true,
							["skin"] = {
								["Gloss"] = 0.5,
								["Backdrop"] = false,
								["ID"] = "PixelSkin",
							},
							["padding"] = -8,
							["visibility"] = {
								["vehicleui"] = false,
							},
							["position"] = {
								["y"] = 260.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
						}, -- [7]
						{
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["version"] = 3,
							["showgrid"] = true,
							["position"] = {
								["y"] = 290.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [8]
						{
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["version"] = 3,
							["showgrid"] = true,
							["position"] = {
								["y"] = 320.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["customdata"] = "",
								["custom"] = false,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [9]
						{
							["skin"] = {
								["ID"] = "PixelSkin",
								["Colors"] = {
									["Normal"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Pushed"] = {
										0, -- [1]
										0, -- [2]
										0, -- [3]
										0.4900000095367432, -- [4]
									},
									["Highlight"] = {
										0.3529411764705882, -- [1]
										0.3529411764705882, -- [2]
										0.3529411764705882, -- [3]
										1, -- [4]
									},
									["Gloss"] = {
										1, -- [1]
										1, -- [2]
										1, -- [3]
										1, -- [4]
									},
									["Border"] = {
										0, -- [1]
										0.5607843137254902, -- [2]
										0, -- [3]
										1, -- [4]
									},
								},
								["Backdrop"] = false,
							},
							["version"] = 3,
							["showgrid"] = true,
							["position"] = {
								["y"] = 350.5,
								["x"] = -177.5,
								["point"] = "CENTER",
							},
							["padding"] = -8,
							["visibility"] = {
								["customdata"] = "",
								["custom"] = false,
								["vehicleui"] = false,
							},
							["fadeoutalpha"] = 0,
						}, -- [10]
					},
				},
			},
		},
		["LibDualSpec-1.0"] = {
		},
		["ExtraActionBar"] = {
			["profiles"] = {
				["RealUI"] = {
					["version"] = 3,
					["position"] = {
						["y"] = -110,
						["x"] = 240,
						["point"] = "CENTER",
					},
				},
				["RealUI-HR-Healing"] = {
					["version"] = 3,
					["position"] = {
						["y"] = -110,
						["x"] = 240,
						["point"] = "CENTER",
					},
				},
				["RealUI-Healing"] = {
					["version"] = 3,
					["position"] = {
						["y"] = -110,
						["x"] = 240,
						["point"] = "CENTER",
					},
				},
				["RealUI-HR"] = {
					["position"] = {
						["y"] = -110,
						["x"] = 240,
						["point"] = "CENTER",
					},
					["version"] = 3,
				},
			},
		},
		["MicroMenu"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["enabled"] = false,
					["position"] = {
						["y"] = 5.500012616809954,
						["x"] = -130.9999864342934,
						["point"] = "TOP",
						["scale"] = 1,
					},
					["version"] = 3,
					["skin"] = {
						["ID"] = "Entropy: Silver",
						["Backdrop"] = false,
						["Gloss"] = 0.25,
					},
					["fadeoutalpha"] = 0,
				},
				["RealUI-HR-Healing"] = {
					["enabled"] = false,
					["fadeoutalpha"] = 0,
					["skin"] = {
						["Gloss"] = 0.25,
						["Backdrop"] = false,
						["ID"] = "Entropy: Silver",
					},
					["version"] = 3,
					["position"] = {
						["y"] = 5.500012616809954,
						["x"] = -130.9999864342934,
						["point"] = "TOP",
						["scale"] = 1,
					},
				},
				["RealUI-Healing"] = {
					["enabled"] = false,
					["fadeoutalpha"] = 0,
					["skin"] = {
						["Gloss"] = 0.25,
						["Backdrop"] = false,
						["ID"] = "Entropy: Silver",
					},
					["position"] = {
						["y"] = 5.500012616809954,
						["x"] = -130.9999864342934,
						["point"] = "TOP",
						["scale"] = 1,
					},
					["version"] = 3,
				},
				["RealUI"] = {
					["enabled"] = false,
					["version"] = 3,
					["position"] = {
						["y"] = 5.500012616809954,
						["x"] = -130.9999864342934,
						["point"] = "TOP",
						["scale"] = 1,
					},
					["skin"] = {
						["ID"] = "Entropy: Silver",
						["Backdrop"] = false,
						["Gloss"] = 0.25,
					},
					["fadeoutalpha"] = 0,
				},
			},
		},
		["XPBar"] = {
			["profiles"] = {
				["RealUI-HR-Healing"] = {
					["fadeoutalpha"] = 0,
					["version"] = 3,
					["position"] = {
						["y"] = 3.999969916464124,
						["x"] = 374.4348705856189,
						["point"] = "TOPLEFT",
					},
				},
				["RealUI"] = {
					["version"] = 3,
					["fadeoutalpha"] = 0,
					["position"] = {
						["y"] = 3.999969916464124,
						["x"] = 374.4348705856189,
						["point"] = "TOPLEFT",
					},
				},
				["RealUI-Healing"] = {
					["fadeoutalpha"] = 0,
					["version"] = 3,
					["position"] = {
						["y"] = 3.999969916464124,
						["x"] = 374.4348705856189,
						["point"] = "TOPLEFT",
					},
				},
				["RealUI-HR"] = {
					["fadeoutalpha"] = 0,
					["position"] = {
						["y"] = 3.999969916464124,
						["x"] = 374.4348705856189,
						["point"] = "TOPLEFT",
					},
					["version"] = 3,
				},
			},
		},
		["MultiCast"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["visibility"] = {
						["customdata"] = "[mod:ctrl][target=focus,exists][harm,nodead][combat][group:party][group:raid][vehicleui]show;hide",
						["custom"] = true,
					},
					["version"] = 3,
					["position"] = {
						["y"] = -163,
						["x"] = -88.5,
						["point"] = "CENTER",
						["scale"] = 0.9,
					},
				},
				["RealUI-HR-Healing"] = {
					["version"] = 3,
					["visibility"] = {
						["customdata"] = "[mod:ctrl][target=focus,exists][harm,nodead][combat][group:party][group:raid][vehicleui]show;hide",
						["custom"] = true,
					},
					["position"] = {
						["scale"] = 0.9,
						["x"] = -88.5,
						["point"] = "BOTTOM",
						["y"] = 116,
					},
				},
				["RealUI-Healing"] = {
					["visibility"] = {
						["customdata"] = "[mod:ctrl][target=focus,exists][harm,nodead][combat][group:party][group:raid][vehicleui]show;hide",
						["custom"] = true,
					},
					["version"] = 3,
					["position"] = {
						["y"] = 89,
						["x"] = -88.5,
						["point"] = "BOTTOM",
						["scale"] = 0.9000000357627869,
					},
				},
				["RealUI"] = {
					["visibility"] = {
						["customdata"] = "[mod:ctrl][target=focus,exists][harm,nodead][combat][group:party][group:raid][vehicleui]show;hide",
						["custom"] = true,
					},
					["version"] = 3,
					["position"] = {
						["y"] = -162.5,
						["x"] = -88.5,
						["point"] = "CENTER",
						["scale"] = 0.9,
					},
				},
			},
		},
		["BlizzardArt"] = {
		},
		["BagBar"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["enabled"] = false,
					["skin"] = {
						["ID"] = "Entropy: Adamantite",
					},
					["position"] = {
						["y"] = 1.500006712564641,
						["x"] = 58.50000987555336,
						["point"] = "CENTER",
					},
					["version"] = 3,
				},
				["RealUI-HR-Healing"] = {
					["enabled"] = false,
					["skin"] = {
						["ID"] = "Entropy: Adamantite",
					},
					["version"] = 3,
					["position"] = {
						["y"] = 1.500006712564641,
						["x"] = 58.50000987555336,
						["point"] = "CENTER",
					},
				},
				["RealUI-Healing"] = {
					["enabled"] = false,
					["skin"] = {
						["ID"] = "Entropy: Adamantite",
					},
					["version"] = 3,
					["position"] = {
						["y"] = 1.500006712564641,
						["x"] = 58.50000987555336,
						["point"] = "CENTER",
					},
				},
				["RealUI"] = {
					["enabled"] = false,
					["skin"] = {
						["ID"] = "Entropy: Adamantite",
					},
					["version"] = 3,
					["position"] = {
						["y"] = 1.500006712564641,
						["x"] = 58.50000987555336,
						["point"] = "CENTER",
					},
				},
			},
		},
		["StanceBar"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["version"] = 3,
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Pushed"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.4900000095367432, -- [4]
							},
							["Highlight"] = {
								0.3529411764705882, -- [1]
								0.3529411764705882, -- [2]
								0.3529411764705882, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0, -- [1]
								0.5607843137254902, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
						},
						["ID"] = "PixelSkin",
						["Backdrop"] = false,
					},
					["fadeoutalpha"] = 0,
					["padding"] = -7,
					["visibility"] = {
						["custom"] = true,
						["customdata"] = "[mod:ctrl][target=focus,exists][harm,nodead][combat][group:party][group:raid][vehicleui]show;hide",
					},
					["position"] = {
						["y"] = -164.5,
						["x"] = -19.5,
						["point"] = "CENTER",
						["scale"] = 1,
					},
				},
				["RealUI-HR-Healing"] = {
					["fadeoutalpha"] = 0,
					["position"] = {
						["y"] = 114,
						["x"] = -19.5,
						["point"] = "BOTTOM",
						["scale"] = 1,
					},
					["skin"] = {
						["ID"] = "PixelSkin",
						["Colors"] = {
							["Normal"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Pushed"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.4900000095367432, -- [4]
							},
							["Highlight"] = {
								0.3529411764705882, -- [1]
								0.3529411764705882, -- [2]
								0.3529411764705882, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0, -- [1]
								0.5607843137254902, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
						},
						["Backdrop"] = false,
					},
					["padding"] = -7,
					["visibility"] = {
						["custom"] = true,
						["customdata"] = "[mod:ctrl][target=focus,exists][harm,nodead][combat][group:party][group:raid][vehicleui]show;hide",
					},
					["version"] = 3,
				},
				["RealUI-Healing"] = {
					["version"] = 3,
					["skin"] = {
						["ID"] = "PixelSkin",
						["Colors"] = {
							["Normal"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Pushed"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.4900000095367432, -- [4]
							},
							["Highlight"] = {
								0.3529411764705882, -- [1]
								0.3529411764705882, -- [2]
								0.3529411764705882, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0, -- [1]
								0.5607843137254902, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
						},
						["Backdrop"] = false,
					},
					["fadeoutalpha"] = 0,
					["padding"] = -7,
					["visibility"] = {
						["custom"] = true,
						["customdata"] = "[mod:ctrl][target=focus,exists][harm,nodead][combat][group:party][group:raid][vehicleui]show;hide",
					},
					["position"] = {
						["y"] = 87,
						["x"] = -19.5,
						["point"] = "BOTTOM",
						["scale"] = 1,
					},
				},
				["RealUI"] = {
					["fadeoutalpha"] = 0,
					["position"] = {
						["y"] = -164.5,
						["x"] = -19.5,
						["point"] = "CENTER",
						["scale"] = 1,
					},
					["version"] = 3,
					["padding"] = -7,
					["visibility"] = {
						["custom"] = true,
						["customdata"] = "[mod:ctrl][target=focus,exists][harm,nodead][combat][group:party][group:raid][vehicleui]show;hide",
					},
					["skin"] = {
						["ID"] = "PixelSkin",
						["Colors"] = {
							["Normal"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Pushed"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.4900000095367432, -- [4]
							},
							["Highlight"] = {
								0.3529411764705882, -- [1]
								0.3529411764705882, -- [2]
								0.3529411764705882, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0, -- [1]
								0.5607843137254902, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
						},
						["Backdrop"] = false,
					},
				},
			},
		},
		["Vehicle"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["version"] = 3,
					["position"] = {
						["y"] = -167.5,
						["x"] = -165.5,
						["point"] = "CENTER",
						["scale"] = 0.6,
					},
					["padding"] = 1,
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Pushed"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.4900000095367432, -- [4]
							},
							["Highlight"] = {
								0.3529411764705882, -- [1]
								0.3529411764705882, -- [2]
								0.3529411764705882, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0, -- [1]
								0.5607843137254902, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
						},
						["ID"] = "PixelSkin",
						["Backdrop"] = false,
					},
				},
				["RealUI-HR-Healing"] = {
					["position"] = {
						["y"] = 111,
						["x"] = -165.5,
						["point"] = "BOTTOM",
						["scale"] = 0.6,
					},
					["version"] = 3,
					["skin"] = {
						["ID"] = "PixelSkin",
						["Colors"] = {
							["Normal"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Pushed"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.4900000095367432, -- [4]
							},
							["Highlight"] = {
								0.3529411764705882, -- [1]
								0.3529411764705882, -- [2]
								0.3529411764705882, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0, -- [1]
								0.5607843137254902, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
						},
						["Backdrop"] = false,
					},
				},
				["RealUI-Healing"] = {
					["skin"] = {
						["ID"] = "PixelSkin",
						["Colors"] = {
							["Normal"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Pushed"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.4900000095367432, -- [4]
							},
							["Highlight"] = {
								0.3529411764705882, -- [1]
								0.3529411764705882, -- [2]
								0.3529411764705882, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0, -- [1]
								0.5607843137254902, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
						},
						["Backdrop"] = false,
					},
					["version"] = 3,
					["position"] = {
						["y"] = 84,
						["x"] = -165.5,
						["point"] = "BOTTOM",
						["scale"] = 0.6,
					},
				},
				["RealUI"] = {
					["position"] = {
						["y"] = -167.5,
						["x"] = -165.5,
						["point"] = "CENTER",
						["scale"] = 0.6,
					},
					["padding"] = 1,
					["version"] = 3,
					["skin"] = {
						["ID"] = "PixelSkin",
						["Colors"] = {
							["Normal"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Pushed"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.4900000095367432, -- [4]
							},
							["Highlight"] = {
								0.3529411764705882, -- [1]
								0.3529411764705882, -- [2]
								0.3529411764705882, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0, -- [1]
								0.5607843137254902, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
						},
						["Backdrop"] = false,
					},
				},
			},
		},
		["PetBar"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["version"] = 3,
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Pushed"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.4900000095367432, -- [4]
							},
							["Highlight"] = {
								0.3529411764705882, -- [1]
								0.3529411764705882, -- [2]
								0.3529411764705882, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0, -- [1]
								0.5607843137254902, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
						},
						["ID"] = "PixelSkin",
						["Backdrop"] = false,
					},
					["fadeoutalpha"] = 0,
					["padding"] = -5,
					["visibility"] = {
						["custom"] = true,
						["customdata"] = "[nopet][target=vehicle,exists][vehicleui]hide;[combat][harm,nodead][target=focus,exists][group:party][group:raid]show;fade",
						["stance"] = {
							[0] = false,
						},
					},
					["position"] = {
						["y"] = -268.5,
						["x"] = -132.5,
						["point"] = "CENTER",
					},
				},
				["RealUI-HR-Healing"] = {
					["enabled"] = false,
					["fadeoutalpha"] = 0,
					["position"] = {
						["y"] = -260.5,
						["x"] = -132.5,
						["point"] = "CENTER",
					},
					["skin"] = {
						["ID"] = "PixelSkin",
						["Colors"] = {
							["Normal"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Pushed"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.4900000095367432, -- [4]
							},
							["Highlight"] = {
								0.3529411764705882, -- [1]
								0.3529411764705882, -- [2]
								0.3529411764705882, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0, -- [1]
								0.5607843137254902, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
						},
						["Backdrop"] = false,
					},
					["padding"] = -5,
					["visibility"] = {
						["customdata"] = "[nopet][target=vehicle,exists][vehicleui]hide;[combat][harm,nodead][target=focus,exists][group:party][group:raid]show;fade",
						["custom"] = true,
						["stance"] = {
							[0] = false,
						},
					},
					["version"] = 3,
				},
				["RealUI-Healing"] = {
					["enabled"] = false,
					["version"] = 3,
					["skin"] = {
						["ID"] = "PixelSkin",
						["Colors"] = {
							["Normal"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Pushed"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.4900000095367432, -- [4]
							},
							["Highlight"] = {
								0.3529411764705882, -- [1]
								0.3529411764705882, -- [2]
								0.3529411764705882, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0, -- [1]
								0.5607843137254902, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
						},
						["Backdrop"] = false,
					},
					["fadeoutalpha"] = 0,
					["padding"] = -5,
					["visibility"] = {
						["customdata"] = "[nopet][target=vehicle,exists][vehicleui]hide;[combat][harm,nodead][target=focus,exists][group:party][group:raid]show;fade",
						["custom"] = true,
						["stance"] = {
							[0] = false,
						},
					},
					["position"] = {
						["y"] = -260.5,
						["x"] = -132.5,
						["point"] = "CENTER",
					},
				},
				["RealUI"] = {
					["fadeoutalpha"] = 0,
					["position"] = {
						["y"] = -241.5,
						["x"] = -132.5,
						["point"] = "CENTER",
					},
					["version"] = 3,
					["padding"] = -5,
					["visibility"] = {
						["customdata"] = "[nopet][target=vehicle,exists][vehicleui]hide;[combat][harm,nodead][target=focus,exists][group:party][group:raid]show;fade",
						["custom"] = true,
						["stance"] = {
							[0] = false,
						},
					},
					["skin"] = {
						["ID"] = "PixelSkin",
						["Colors"] = {
							["Normal"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Pushed"] = {
								0, -- [1]
								0, -- [2]
								0, -- [3]
								0.4900000095367432, -- [4]
							},
							["Highlight"] = {
								0.3529411764705882, -- [1]
								0.3529411764705882, -- [2]
								0.3529411764705882, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0, -- [1]
								0.5607843137254902, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0, -- [4]
							},
						},
						["Backdrop"] = false,
					},
				},
			},
		},
		["RepBar"] = {
			["profiles"] = {
				["RealUI-HR-Healing"] = {
					["version"] = 3,
					["position"] = {
						["y"] = 10.00008673617606,
						["x"] = 374.4348705856189,
						["point"] = "LEFT",
					},
				},
				["RealUI"] = {
					["version"] = 3,
					["position"] = {
						["y"] = 10.00008673617606,
						["x"] = 374.4348705856189,
						["point"] = "LEFT",
					},
				},
				["RealUI-Healing"] = {
					["version"] = 3,
					["position"] = {
						["y"] = 10.00008673617606,
						["x"] = 374.4348705856189,
						["point"] = "LEFT",
					},
				},
				["RealUI-HR"] = {
					["position"] = {
						["y"] = 10.00008673617606,
						["x"] = 374.4348705856189,
						["point"] = "LEFT",
					},
					["version"] = 3,
				},
			},
		},
	},
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI-HR",
	},
	["profiles"] = {
		["RealUI-HR"] = {
			["minimapIcon"] = {
				["hide"] = true,
			},
		},
		["RealUI-HR-Healing"] = {
			["minimapIcon"] = {
				["hide"] = true,
			},
		},
		["RealUI-Healing"] = {
			["minimapIcon"] = {
				["hide"] = true,
			},
		},
		["RealUI"] = {
			["minimapIcon"] = {
				["hide"] = true,
			},
		},
	},
}






-----------------
---- BugSack ----
-----------------
BugSackDB = {
	["fontSize"] = "GameFontHighlight",
	["auto"] = false,
	["soundMedia"] = "BugSack: Fatality",
	["mute"] = true,
	["chatframe"] = false,
}
BugSackLDBIconDB = {
	["hide"] = false,
}






-----------------
---- Chatter ----
-----------------

ChatterDB = {
	["namespaces"] = {
		["Highlight"] = {
		},
		["AltLinks"] = {
			["profiles"] = {
				["RealUI"] = {
					["guildNotes"] = false,
				},
			},
		},
		["Scrollback"] = {
			["profiles"] = {
				["RealUI"] = {
					["FRAME_1"] = 500,
				},
			},
		},
		["Invite Links"] = {
			["profiles"] = {
				["Default"] = {
					["words"] = {
						["inv"] = "inv",
						["invite"] = "invite",
					},
				},
				["RealUI"] = {
					["words"] = {
						["inv"] = "inv",
						["invite"] = "invite",
					},
				},
			},
		},
		["ChannelColors"] = {
			["profiles"] = {
				["Default"] = {
					["colors"] = {
						["CHANNEL6"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["Raid Leader"] = {
							["b"] = 0.03529411973431706,
							["g"] = 0.2823529578745365,
							["r"] = 1.000000059138984,
						},
						["CHANNEL"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["PARTY"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.6666667060926557,
							["r"] = 0.6666667060926557,
						},
						["CHANNEL_LIST"] = {
							["b"] = 0.501960813999176,
							["g"] = 0.501960813999176,
							["r"] = 0.752941220998764,
						},
						["Raid"] = {
							["b"] = 0,
							["g"] = 0.4980392451398075,
							["r"] = 1.000000059138984,
						},
						["SYSTEM"] = {
							["b"] = 0,
							["g"] = 1.000000059138984,
							["r"] = 1.000000059138984,
						},
						["RAID_BOSS_EMOTE"] = {
							["b"] = 0,
							["g"] = 0.8666667179204524,
							["r"] = 1.000000059138984,
						},
						["CHANNEL7"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["SKILL"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.3333333530463278,
							["r"] = 0.3333333530463278,
						},
						["CHANNEL1"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["CHANNEL3"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["BATTLENET"] = {
							["b"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["r"] = 1.000000059138984,
						},
						["BN_CONVERSATION_LIST"] = {
							["b"] = 0.9411765262484551,
							["g"] = 0.6941176881082356,
							["r"] = 0,
						},
						["LOOT"] = {
							["b"] = 0,
							["g"] = 0.6666667060926557,
							["r"] = 0,
						},
						["Officer"] = {
							["b"] = 0.250980406999588,
							["g"] = 0.752941220998764,
							["r"] = 0.250980406999588,
						},
						["IGNORED"] = {
							["b"] = 0,
							["g"] = 0,
							["r"] = 1.000000059138984,
						},
						["BN_WHISPER_PLAYER_OFFLINE"] = {
							["r"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["b"] = 0,
						},
						["OFFICER"] = {
							["b"] = 0.250980406999588,
							["g"] = 0.752941220998764,
							["r"] = 0.250980406999588,
						},
						["YELL"] = {
							["b"] = 0.250980406999588,
							["g"] = 0.250980406999588,
							["r"] = 1.000000059138984,
						},
						["BATTLEGROUND"] = {
							["b"] = 0,
							["g"] = 0.4980392451398075,
							["r"] = 1.000000059138984,
						},
						["COMBAT_MISC_INFO"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["r"] = 0.501960813999176,
						},
						["SAY"] = {
							["b"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["r"] = 1.000000059138984,
						},
						["Raid Warning"] = {
							["b"] = 0,
							["g"] = 0.2823529578745365,
							["r"] = 1.000000059138984,
						},
						["DND"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["r"] = 1.000000059138984,
						},
						["GUILD_ACHIEVEMENT"] = {
							["b"] = 0.250980406999588,
							["g"] = 1.000000059138984,
							["r"] = 0.250980406999588,
						},
						["MONSTER_PARTY"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.6666667060926557,
							["r"] = 0.6666667060926557,
						},
						["BN_INLINE_TOAST_ALERT"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.7725490652956069,
							["r"] = 0.5098039517179132,
						},
						["CHANNEL4"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["BN_CONVERSATION"] = {
							["b"] = 0.9411765262484551,
							["g"] = 0.6941176881082356,
							["r"] = 0,
						},
						["WHISPER_FOREIGN"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["r"] = 1.000000059138984,
						},
						["RAID_WARNING"] = {
							["b"] = 0,
							["g"] = 0.2823529578745365,
							["r"] = 1.000000059138984,
						},
						["Say"] = {
							["b"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["r"] = 1.000000059138984,
						},
						["MONSTER_WHISPER"] = {
							["b"] = 0.9215686819516122,
							["g"] = 0.7098039635457099,
							["r"] = 1.000000059138984,
						},
						["CHANNEL_JOIN"] = {
							["b"] = 0.501960813999176,
							["g"] = 0.501960813999176,
							["r"] = 0.752941220998764,
						},
						["WHISPER_INFORM"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["r"] = 1.000000059138984,
						},
						["Guild"] = {
							["b"] = 0.250980406999588,
							["g"] = 1.000000059138984,
							["r"] = 0.250980406999588,
						},
						["COMBAT_HONOR_GAIN"] = {
							["b"] = 0.03921568859368563,
							["g"] = 0.7921569095924497,
							["r"] = 0.878431424498558,
						},
						["CHANNEL5"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["TRADESKILLS"] = {
							["b"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["r"] = 1.000000059138984,
						},
						["Party"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.6666667060926557,
							["r"] = 0.6666667060926557,
						},
						["CHANNEL8"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["BN_CONVERSATION_NOTICE"] = {
							["b"] = 0.9411765262484551,
							["g"] = 0.6941176881082356,
							["r"] = 0,
						},
						["BG_SYSTEM_NEUTRAL"] = {
							["b"] = 0.03921568859368563,
							["g"] = 0.4705882631242275,
							["r"] = 1.000000059138984,
						},
						["MONEY"] = {
							["b"] = 0,
							["g"] = 1.000000059138984,
							["r"] = 1.000000059138984,
						},
						["Battleground Leader"] = {
							["b"] = 0.717647101264447,
							["g"] = 0.8588235802017152,
							["r"] = 1.000000059138984,
						},
						["WHISPER"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["r"] = 1.000000059138984,
						},
						["CHANNEL9"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["RealID Whisper"] = {
							["r"] = 0,
							["g"] = 1.000000059138984,
							["b"] = 0.9647059394046664,
						},
						["BG_SYSTEM_HORDE"] = {
							["b"] = 0,
							["g"] = 0,
							["r"] = 1.000000059138984,
						},
						["GUILD"] = {
							["b"] = 0.250980406999588,
							["g"] = 1.000000059138984,
							["r"] = 0.250980406999588,
						},
						["OPENING"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["r"] = 0.501960813999176,
						},
						["BN_WHISPER"] = {
							["b"] = 0.9647059394046664,
							["g"] = 1.000000059138984,
							["r"] = 0,
						},
						["BN_INLINE_TOAST_BROADCAST_INFORM"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.7725490652956069,
							["r"] = 0.5098039517179132,
						},
						["Yell"] = {
							["b"] = 0.250980406999588,
							["g"] = 0.250980406999588,
							["r"] = 1.000000059138984,
						},
						["COMBAT_FACTION_CHANGE"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["r"] = 0.501960813999176,
						},
						["MONSTER_EMOTE"] = {
							["b"] = 0.250980406999588,
							["g"] = 0.501960813999176,
							["r"] = 1.000000059138984,
						},
						["CHANNEL_LEAVE"] = {
							["b"] = 0.501960813999176,
							["g"] = 0.501960813999176,
							["r"] = 0.752941220998764,
						},
						["CHANNEL10"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["LocalDefense"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["BN_WHISPER_INFORM"] = {
							["b"] = 0.9647059394046664,
							["g"] = 1.000000059138984,
							["r"] = 0,
						},
						["PET_INFO"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["r"] = 0.501960813999176,
						},
						["Battleground"] = {
							["b"] = 0,
							["g"] = 0.4980392451398075,
							["r"] = 1.000000059138984,
						},
						["RealID Conversation"] = {
							["r"] = 0,
							["g"] = 0.6941176881082356,
							["b"] = 0.9411765262484551,
						},
						["ACHIEVEMENT"] = {
							["b"] = 0,
							["g"] = 1.000000059138984,
							["r"] = 1.000000059138984,
						},
						["General"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["ARENA_POINTS"] = {
							["b"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["r"] = 1.000000059138984,
						},
						["EMOTE"] = {
							["b"] = 0.250980406999588,
							["g"] = 0.501960813999176,
							["r"] = 1.000000059138984,
						},
						["COMBAT_XP_GAIN"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.4352941433899105,
							["r"] = 0.4352941433899105,
						},
						["CHANNEL2"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["COMBAT_GUILD_XP_GAIN"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.4352941433899105,
							["r"] = 0.4352941433899105,
						},
						["LookingForGroup"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["BG_SYSTEM_ALLIANCE"] = {
							["b"] = 0.9372549573890865,
							["g"] = 0.6823529815301299,
							["r"] = 0,
						},
						["BATTLEGROUND_LEADER"] = {
							["b"] = 0.717647101264447,
							["g"] = 0.8588235802017152,
							["r"] = 1.000000059138984,
						},
						["PARTY_LEADER"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.7843137718737125,
							["r"] = 0.4627451254054904,
						},
						["MONSTER_SAY"] = {
							["b"] = 0.6235294486396015,
							["g"] = 1.000000059138984,
							["r"] = 1.000000059138984,
						},
						["CHANNEL_NOTICE"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 0.752941220998764,
						},
						["RAID_BOSS_WHISPER"] = {
							["b"] = 0,
							["g"] = 0.8666667179204524,
							["r"] = 1.000000059138984,
						},
						["RAID_LEADER"] = {
							["b"] = 0.03529411973431706,
							["g"] = 0.2823529578745365,
							["r"] = 1.000000059138984,
						},
						["FILTERED"] = {
							["b"] = 0,
							["g"] = 0,
							["r"] = 1.000000059138984,
						},
						["TARGETICONS"] = {
							["b"] = 0,
							["g"] = 1.000000059138984,
							["r"] = 1.000000059138984,
						},
						["Party Leader"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.7843137718737125,
							["r"] = 0.4627451254054904,
						},
						["AFK"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["r"] = 1.000000059138984,
						},
						["Whisper"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["r"] = 1.000000059138984,
						},
						["RESTRICTED"] = {
							["b"] = 0,
							["g"] = 0,
							["r"] = 1.000000059138984,
						},
						["kodboomshakalaka"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.9764706459827721,
							["r"] = 0,
						},
						["BN_INLINE_TOAST_CONVERSATION"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.7725490652956069,
							["r"] = 0.5098039517179132,
						},
						["GuildRecruitment"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["BN_INLINE_TOAST_BROADCAST"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.7725490652956069,
							["r"] = 0.5098039517179132,
						},
						["RAID"] = {
							["b"] = 0,
							["g"] = 0.4980392451398075,
							["r"] = 1.000000059138984,
						},
						["Trade"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["TEXT_EMOTE"] = {
							["b"] = 0.250980406999588,
							["g"] = 0.501960813999176,
							["r"] = 1.000000059138984,
						},
						["MONSTER_YELL"] = {
							["b"] = 0.250980406999588,
							["g"] = 0.250980406999588,
							["r"] = 1.000000059138984,
						},
						["CURRENCY"] = {
							["r"] = 0,
							["g"] = 0.6666667060926557,
							["b"] = 0,
						},
						["CHANNEL_NOTICE_USER"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 0.752941220998764,
						},
					},
				},
				["RealUI"] = {
					["colors"] = {
						["CHANNEL6"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["Raid Leader"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.2823529578745365,
							["b"] = 0.03529411973431706,
						},
						["CHANNEL"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["PARTY"] = {
							["r"] = 0.6666667060926557,
							["g"] = 0.6666667060926557,
							["b"] = 1.000000059138984,
						},
						["tfw"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["CHANNEL_LIST"] = {
							["r"] = 0.752941220998764,
							["g"] = 0.501960813999176,
							["b"] = 0.501960813999176,
						},
						["Raid"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.4980392451398075,
							["b"] = 0,
						},
						["SYSTEM"] = {
							["r"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["b"] = 0,
						},
						["RAID_BOSS_EMOTE"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.8666667179204524,
							["b"] = 0,
						},
						["CHANNEL7"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["SKILL"] = {
							["r"] = 0.3333333530463278,
							["g"] = 0.3333333530463278,
							["b"] = 1.000000059138984,
						},
						["CHANNEL1"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["CHANNEL3"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["BATTLENET"] = {
							["r"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["b"] = 1.000000059138984,
						},
						["BN_CONVERSATION_LIST"] = {
							["r"] = 0,
							["g"] = 0.6941176881082356,
							["b"] = 0.9411765262484551,
						},
						["LOOT"] = {
							["r"] = 0,
							["g"] = 0.6666667060926557,
							["b"] = 0,
						},
						["Officer"] = {
							["r"] = 0.250980406999588,
							["g"] = 0.752941220998764,
							["b"] = 0.250980406999588,
						},
						["IGNORED"] = {
							["r"] = 1.000000059138984,
							["g"] = 0,
							["b"] = 0,
						},
						["BN_WHISPER_PLAYER_OFFLINE"] = {
							["b"] = 0,
							["g"] = 1.000000059138984,
							["r"] = 1.000000059138984,
						},
						["OFFICER"] = {
							["r"] = 0.250980406999588,
							["g"] = 0.752941220998764,
							["b"] = 0.250980406999588,
						},
						["YELL"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.250980406999588,
							["b"] = 0.250980406999588,
						},
						["BATTLEGROUND"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.4980392451398075,
							["b"] = 0,
						},
						["COMBAT_MISC_INFO"] = {
							["r"] = 0.501960813999176,
							["g"] = 0.501960813999176,
							["b"] = 1.000000059138984,
						},
						["SAY"] = {
							["r"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["b"] = 1.000000059138984,
						},
						["Raid Warning"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.2823529578745365,
							["b"] = 0,
						},
						["DND"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["b"] = 1.000000059138984,
						},
						["GUILD_ACHIEVEMENT"] = {
							["r"] = 0.250980406999588,
							["g"] = 1.000000059138984,
							["b"] = 0.250980406999588,
						},
						["MONSTER_PARTY"] = {
							["r"] = 0.6666667060926557,
							["g"] = 0.6666667060926557,
							["b"] = 1.000000059138984,
						},
						["BN_INLINE_TOAST_ALERT"] = {
							["r"] = 0.5098039517179132,
							["g"] = 0.7725490652956069,
							["b"] = 1.000000059138984,
						},
						["CHANNEL4"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["BN_CONVERSATION"] = {
							["r"] = 0,
							["g"] = 0.6941176881082356,
							["b"] = 0.9411765262484551,
						},
						["WHISPER_FOREIGN"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["b"] = 1.000000059138984,
						},
						["RAID_WARNING"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.2823529578745365,
							["b"] = 0,
						},
						["Say"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["MONSTER_WHISPER"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.7098039635457099,
							["b"] = 0.9215686819516122,
						},
						["CHANNEL_JOIN"] = {
							["r"] = 0.752941220998764,
							["g"] = 0.501960813999176,
							["b"] = 0.501960813999176,
						},
						["WHISPER_INFORM"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["b"] = 1.000000059138984,
						},
						["Guild"] = {
							["r"] = 0.250980406999588,
							["g"] = 1.000000059138984,
							["b"] = 0.250980406999588,
						},
						["CDRogue"] = {
							["b"] = 0.3647059039212763,
							["g"] = 1.000000059138984,
							["r"] = 0.9882353525608778,
						},
						["CHANNEL_NOTICE_USER"] = {
							["r"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["COMBAT_HONOR_GAIN"] = {
							["r"] = 0.878431424498558,
							["g"] = 0.7921569095924497,
							["b"] = 0.03921568859368563,
						},
						["CHANNEL5"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["TRADESKILLS"] = {
							["r"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["b"] = 1.000000059138984,
						},
						["RealID Whisper"] = {
							["b"] = 0.9647059394046664,
							["g"] = 1.000000059138984,
							["r"] = 0,
						},
						["Party"] = {
							["r"] = 0.6666667060926557,
							["g"] = 0.6666667060926557,
							["b"] = 1.000000059138984,
						},
						["Testing"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["TEXT_EMOTE"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["b"] = 0.250980406999588,
						},
						["BG_SYSTEM_NEUTRAL"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.4705882631242275,
							["b"] = 0.03921568859368563,
						},
						["MONEY"] = {
							["r"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["b"] = 0,
						},
						["Battleground Leader"] = {
							["r"] = 1,
							["g"] = 0.8509803921568627,
							["b"] = 0.6980392156862745,
						},
						["WHISPER"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["b"] = 1.000000059138984,
						},
						["CHANNEL9"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["Trade"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.8509804424829781,
							["b"] = 0.8705882867798209,
						},
						["BN_INLINE_TOAST_BROADCAST_INFORM"] = {
							["r"] = 0.5098039517179132,
							["g"] = 0.7725490652956069,
							["b"] = 1.000000059138984,
						},
						["GUILD"] = {
							["r"] = 0.250980406999588,
							["g"] = 1.000000059138984,
							["b"] = 0.250980406999588,
						},
						["OPENING"] = {
							["r"] = 0.501960813999176,
							["g"] = 0.501960813999176,
							["b"] = 1.000000059138984,
						},
						["BN_WHISPER"] = {
							["r"] = 0,
							["g"] = 1.000000059138984,
							["b"] = 0.9647059394046664,
						},
						["GuildRecruitment"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["Yell"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.250980406999588,
							["b"] = 0.250980406999588,
						},
						["COMBAT_FACTION_CHANGE"] = {
							["r"] = 0.501960813999176,
							["g"] = 0.501960813999176,
							["b"] = 1.000000059138984,
						},
						["MONSTER_EMOTE"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["b"] = 0.250980406999588,
						},
						["CHANNEL_LEAVE"] = {
							["r"] = 0.752941220998764,
							["g"] = 0.501960813999176,
							["b"] = 0.501960813999176,
						},
						["BATTLEGROUND_LEADER"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.8588235802017152,
							["b"] = 0.717647101264447,
						},
						["CHANNEL10"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["ACHIEVEMENT"] = {
							["r"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["b"] = 0,
						},
						["PET_INFO"] = {
							["r"] = 0.501960813999176,
							["g"] = 0.501960813999176,
							["b"] = 1.000000059138984,
						},
						["Battleground"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.4980392451398075,
							["b"] = 0,
						},
						["RealID Conversation"] = {
							["b"] = 0.9411765262484551,
							["g"] = 0.6941176881082356,
							["r"] = 0,
						},
						["ARENA_POINTS"] = {
							["r"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["b"] = 1.000000059138984,
						},
						["BN_WHISPER_INFORM"] = {
							["r"] = 0,
							["g"] = 1.000000059138984,
							["b"] = 0.9647059394046664,
						},
						["kodboomshakalaka"] = {
							["r"] = 0,
							["g"] = 0.9764706459827721,
							["b"] = 1.000000059138984,
						},
						["EMOTE"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["b"] = 0.250980406999588,
						},
						["COMBAT_XP_GAIN"] = {
							["r"] = 0.4352941433899105,
							["g"] = 0.4352941433899105,
							["b"] = 1.000000059138984,
						},
						["COMBAT_GUILD_XP_GAIN"] = {
							["b"] = 1.000000059138984,
							["g"] = 0.4352941433899105,
							["r"] = 0.4352941433899105,
						},
						["CHANNEL2"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["LookingForGroup"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["BG_SYSTEM_ALLIANCE"] = {
							["r"] = 0,
							["g"] = 0.6823529815301299,
							["b"] = 0.9372549573890865,
						},
						["RESTRICTED"] = {
							["r"] = 1.000000059138984,
							["g"] = 0,
							["b"] = 0,
						},
						["PARTY_LEADER"] = {
							["r"] = 0.4627451254054904,
							["g"] = 0.7843137718737125,
							["b"] = 1.000000059138984,
						},
						["AFK"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["b"] = 1.000000059138984,
						},
						["CHANNEL_NOTICE"] = {
							["r"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
						["RAID_BOSS_WHISPER"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.8666667179204524,
							["b"] = 0,
						},
						["RAID_LEADER"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.2823529578745365,
							["b"] = 0.03529411973431706,
						},
						["Whisper"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.501960813999176,
							["b"] = 1.000000059138984,
						},
						["TARGETICONS"] = {
							["r"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["b"] = 0,
						},
						["Party Leader"] = {
							["r"] = 0.4627451254054904,
							["g"] = 0.7843137718737125,
							["b"] = 1.000000059138984,
						},
						["FILTERED"] = {
							["r"] = 1.000000059138984,
							["g"] = 0,
							["b"] = 0,
						},
						["MONSTER_SAY"] = {
							["r"] = 1.000000059138984,
							["g"] = 1.000000059138984,
							["b"] = 0.6235294486396015,
						},
						["General"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.8745098556391895,
							["b"] = 0.8901961310766637,
						},
						["TCForwarder2IIll"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["BN_INLINE_TOAST_CONVERSATION"] = {
							["r"] = 0.5098039517179132,
							["g"] = 0.7725490652956069,
							["b"] = 1.000000059138984,
						},
						["LocalDefense"] = {
							["b"] = 0.752941220998764,
							["g"] = 0.752941220998764,
							["r"] = 1.000000059138984,
						},
						["BN_INLINE_TOAST_BROADCAST"] = {
							["r"] = 0.5098039517179132,
							["g"] = 0.7725490652956069,
							["b"] = 1.000000059138984,
						},
						["RAID"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.4980392451398075,
							["b"] = 0,
						},
						["BG_SYSTEM_HORDE"] = {
							["r"] = 1.000000059138984,
							["g"] = 0,
							["b"] = 0,
						},
						["BN_CONVERSATION_NOTICE"] = {
							["r"] = 0,
							["g"] = 0.6941176881082356,
							["b"] = 0.9411765262484551,
						},
						["MONSTER_YELL"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.250980406999588,
							["b"] = 0.250980406999588,
						},
						["CURRENCY"] = {
							["b"] = 0,
							["g"] = 0.6666667060926557,
							["r"] = 0,
						},
						["CHANNEL8"] = {
							["r"] = 1.000000059138984,
							["g"] = 0.752941220998764,
							["b"] = 0.752941220998764,
						},
					},
				},
			},
		},
		["StickyChannels"] = {
			["profiles"] = {
				["RealUI"] = {
					["YELL"] = false,
					["RAID_WARNING"] = false,
					["EMOTE"] = false,
					["WHISPER"] = false,
				},
			},
		},
		["RealIdPolish"] = {
			["profiles"] = {
				["RealUI"] = {
					["toastx"] = 30,
					["toasty"] = 15,
				},
			},
		},
		["ChatFrameBorders"] = {
			["profiles"] = {
				["Default"] = {
					["frames"] = {
						["FRAME_2"] = {
							["enable"] = false,
							["background"] = "Solid",
							["border"] = "None",
						},
						["FRAME_1"] = {
							["enable"] = false,
							["background"] = "Solid",
							["border"] = "None",
							["backgroundColor"] = {
								["a"] = 0,
							},
						},
					},
				},
				["RealUI"] = {
					["frames"] = {
						["FRAME_1"] = {
							["background"] = "Solid",
							["backgroundColor"] = {
								["a"] = 0.2900000214576721,
							},
							["border"] = "None",
						},
						["FRAME_9"] = {
							["enable"] = false,
							["background"] = "Solid",
							["border"] = "None",
							["backgroundColor"] = {
								["a"] = 0,
							},
						},
						["FRAME_6"] = {
							["enable"] = false,
							["background"] = "Solid",
							["border"] = "None",
							["backgroundColor"] = {
								["a"] = 0,
							},
						},
						["FRAME_5"] = {
							["enable"] = false,
							["background"] = "Solid",
							["border"] = "None",
							["backgroundColor"] = {
								["a"] = 0,
							},
						},
						["FRAME_8"] = {
							["enable"] = false,
							["background"] = "Solid",
							["border"] = "None",
							["backgroundColor"] = {
								["a"] = 0,
							},
						},
						["FRAME_7"] = {
							["enable"] = false,
							["background"] = "Solid",
							["border"] = "None",
							["backgroundColor"] = {
								["a"] = 0,
							},
						},
						["FRAME_2"] = {
							["enable"] = false,
							["background"] = "Solid",
							["backgroundColor"] = {
								["a"] = 0,
							},
							["border"] = "None",
						},
						["FRAME_4"] = {
							["enable"] = false,
							["background"] = "Solid",
							["border"] = "None",
							["backgroundColor"] = {
								["a"] = 0,
							},
						},
						["FRAME_3"] = {
							["enable"] = false,
							["background"] = "Solid",
							["border"] = "None",
							["backgroundColor"] = {
								["a"] = 0,
							},
						},
						["FRAME_10"] = {
							["enable"] = false,
							["background"] = "Solid",
							["border"] = "None",
							["backgroundColor"] = {
								["a"] = 0,
							},
						},
					},
				},
			},
		},
		["Buttons"] = {
			["profiles"] = {
				["RealUI"] = {
					["scrollReminder"] = true,
				},
			},
		},
		["Server Positioning"] = {
		},
		["JustifyText"] = {
		},
		["Timestamps"] = {
		},
		["EditBox"] = {
			["profiles"] = {
				["RealUI"] = {
					["editW"] = 422.0097775971747,
					["attach"] = "LOCK",
					["border"] = "None",
					["editY"] = 228.4514578142029,
					["font"] = "Standard",
					["borderColor"] = {
						["a"] = 0,
					},
					["height"] = 20,
					["background"] = "Solid",
					["backgroundColor"] = {
						["a"] = 0,
					},
					["editX"] = -7.090228140514713,
				},
				["Default"] = {
					["edgeSize"] = 16,
					["borderColor"] = {
						["b"] = 0.5,
						["g"] = 0.5,
						["r"] = 0.5,
					},
					["background"] = "Blizzard ChatFrame Background",
					["inset"] = 4,
					["backgroundColor"] = {
						["a"] = 0.9,
					},
				},
			},
		},
		["PlayerNames"] = {
			["realm"] = {
			},
			["profiles"] = {
				["RealUI"] = {
					["saveFriends"] = true,
					["saveGuild"] = true,
					["emphasizeSelfInText"] = false,
				},
			},
		},
		["ChatTabs"] = {
		},
		["UrlCopy"] = {
		},
		["CopyChat"] = {
		},
		["ChannelNames"] = {
		},
		["Editbox History"] = {
			["realm"] = {
			},
		},
		["ChatFont"] = {
			["profiles"] = {
				["RealUI"] = {
					["outline"] = "OUTLINE",
					["font"] = "Standard",
					["frames"] = {
						["FRAME_1"] = {
							["fontsize"] = 12,
							["font"] = "Standard",
						},
						["FRAME_2"] = {
							["fontsize"] = 12,
						},
					},
					["fontsize"] = 12,
				},
			},
		},
		["Mousewheel Scroll"] = {
			["profiles"] = {
				["RealUI"] = {
					["scrollLines"] = 2,
				},
			},
		},
	},
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI",
	},
	["profiles"] = {
		["Default"] = {
			["modules"] = {
				["Borders/Background"] = true,
				["ChatTabs"] = false,
				["Auto Popup"] = false,
				["Timestamps"] = false,
			},
			["welcomeMessaged"] = true,
		},
		["RealUI"] = {
			["modules"] = {
				["Link Hover"] = false,
				["Justify Text"] = false,
				["Auto Popup"] = false,
				["Timestamps"] = false,
				["Borders/Background"] = false,
				["ChatTabs"] = false,
				["Highlights"] = false,
			},
			["welcomeMessaged"] = true,
		},
	},
}






-------------------
---- Easy Mail ----
-------------------
EasyMail_SavedVars = {
	["Total"] = "Y",
	["Guild"] = "N",
	["DelPrompt"] = "Y",
	["Money"] = "Y",
	["TextTooltip"] = "N",
	["AutoAdd"] = "N",
	["DelPending"] = "N",
	["ClickDel"] = "N",
	["Friends"] = "N",
	["ClickGet"] = "N",
	["BlizzList"] = "N",
}






--------------
---- Grid ----
--------------

GridDB = {
	["namespaces"] = {
		["GridStatusRaidIcons"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["alert_raidicons_playertarget"] = {
						["enable"] = false,
					},
				},
				["RealUI-HR-Healing"] = {
					["alert_raidicons_playertarget"] = {
						["enable"] = false,
					},
				},
				["RealUI-Healing"] = {
					["alert_raidicons_playertarget"] = {
						["enable"] = false,
					},
				},
				["RealUI"] = {
					["alert_raidicons_playertarget"] = {
						["enable"] = false,
					},
				},
			},
		},
		["GridStatusVehicle"] = {
		},
		["GridRoster"] = {
		},
		["GridStatusAuras"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["debuff_FrostBolt"] = {
						["duration"] = false,
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 0.4274509803921568,
							["r"] = 0.3882352941176471,
						},
						["priority"] = 90,
						["missing"] = false,
						["enable"] = true,
						["text"] = "FrostBolt",
						["range"] = false,
						["desc"] = "Debuff: FrostBolt",
					},
					["buff_Renew"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_Renew",
					},
					["debuff_Fear"] = {
						["text"] = "Fear",
						["color"] = {
							["a"] = 1,
							["b"] = 0.5,
							["g"] = 0.5,
							["r"] = 0.5,
						},
						["priority"] = 90,
						["missing"] = false,
						["enable"] = true,
						["duration"] = false,
						["range"] = false,
						["desc"] = "Debuff: Fear",
					},
					["buff_Riptide"] = {
						["duration"] = false,
						["missing"] = false,
						["color"] = {
							["b"] = 0.5019607843137255,
							["g"] = 0.1098039215686275,
							["r"] = 0.3411764705882353,
						},
					},
					["buff_BeaconofLight"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 0.615686274509804,
							["b"] = 0.9882352941176471,
						},
						["duration"] = false,
						["mine"] = true,
						["desc"] = "Buff: Beacon of Light",
						["text"] = "Beacon of Light",
						["missing"] = false,
						["priority"] = 90,
						["range"] = true,
						["enable"] = true,
					},
					["buff_PowerWord:Shield"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
					},
					["debuff_IronRoots"] = {
						["text"] = "Iron Roots",
						["missing"] = false,
						["priority"] = 90,
						["color"] = {
							["a"] = 1,
							["b"] = 0.5,
							["g"] = 0.5,
							["r"] = 0.5,
						},
						["enable"] = true,
						["duration"] = false,
						["range"] = false,
						["desc"] = "Debuff: Iron Roots",
					},
					["debuff_NapalmShell"] = {
						["text"] = "Napalm Shell",
						["color"] = {
							["a"] = 1,
							["b"] = 0.5,
							["g"] = 0.5,
							["r"] = 0.5,
						},
						["priority"] = 90,
						["enable"] = true,
						["missing"] = false,
						["duration"] = false,
						["range"] = false,
						["desc"] = "Debuff: Napalm Shell",
					},
					["buff_Rejuvenation"] = {
						["icon"] = "Interface\\Icons\\Spell_Nature_Rejuvenation",
					},
					["debuff_FrostBlast"] = {
						["duration"] = false,
						["missing"] = false,
						["priority"] = 90,
						["enable"] = true,
						["color"] = {
							["a"] = 1,
							["r"] = 0.2549019607843137,
							["g"] = 0.396078431372549,
							["b"] = 1,
						},
						["text"] = "Frost Blast",
						["range"] = true,
						["desc"] = "Debuff: Frost Blast",
					},
					["buff_EarthShield"] = {
						["color"] = {
							["b"] = 0.2901960784313725,
							["g"] = 0.9490196078431372,
							["r"] = 1,
						},
						["duration"] = false,
						["icon"] = "Interface\\Icons\\Spell_Nature_SkinofEarth",
						["missing"] = false,
					},
					["buff_Regrowth"] = {
						["icon"] = "Interface\\Icons\\Spell_Nature_ResistNature",
					},
					["buff_HandofSacrifice"] = {
						["duration"] = true,
						["color"] = {
							["a"] = 1,
							["b"] = 0.5019607843137255,
							["g"] = 0.5019607843137255,
							["r"] = 0.5019607843137255,
						},
						["priority"] = 90,
						["enable"] = true,
						["missing"] = false,
						["text"] = "Hand of Sacrifice",
						["range"] = false,
						["desc"] = "Buff: Hand of Sacrifice",
					},
					["abolish"] = false,
					["buff_Lifebloom"] = {
						["icon"] = "Interface\\Icons\\INV_Misc_Herb_Felblossom",
					},
				},
				["RealUI-Healing"] = {
					["debuff_FrostBolt"] = {
						["duration"] = false,
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 0.4274509803921568,
							["r"] = 0.3882352941176471,
						},
						["priority"] = 90,
						["missing"] = false,
						["enable"] = true,
						["text"] = "FrostBolt",
						["range"] = false,
						["desc"] = "Debuff: FrostBolt",
					},
					["debuff_NapalmShell"] = {
						["text"] = "Napalm Shell",
						["color"] = {
							["a"] = 1,
							["b"] = 0.5,
							["g"] = 0.5,
							["r"] = 0.5,
						},
						["priority"] = 90,
						["enable"] = true,
						["missing"] = false,
						["duration"] = false,
						["range"] = false,
						["desc"] = "Debuff: Napalm Shell",
					},
					["debuff_IronRoots"] = {
						["text"] = "Iron Roots",
						["missing"] = false,
						["priority"] = 90,
						["color"] = {
							["a"] = 1,
							["b"] = 0.5,
							["g"] = 0.5,
							["r"] = 0.5,
						},
						["enable"] = true,
						["duration"] = false,
						["range"] = false,
						["desc"] = "Debuff: Iron Roots",
					},
					["buff_Rejuvenation"] = {
						["icon"] = "Interface\\Icons\\Spell_Nature_Rejuvenation",
					},
					["debuff_FrostBlast"] = {
						["duration"] = false,
						["missing"] = false,
						["priority"] = 90,
						["enable"] = true,
						["color"] = {
							["a"] = 1,
							["r"] = 0.2549019607843137,
							["g"] = 0.396078431372549,
							["b"] = 1,
						},
						["text"] = "Frost Blast",
						["range"] = true,
						["desc"] = "Debuff: Frost Blast",
					},
					["buff_EarthShield"] = {
						["missing"] = false,
						["duration"] = false,
						["color"] = {
							["b"] = 0.2901960784313725,
							["g"] = 0.9490196078431372,
							["r"] = 1,
						},
					},
					["buff_Renew"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_Renew",
					},
					["buff_BeaconofLight"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 1,
							["g"] = 0.615686274509804,
							["b"] = 0.9882352941176471,
						},
						["duration"] = false,
						["mine"] = true,
						["desc"] = "Buff: Beacon of Light",
						["text"] = "Beacon of Light",
						["missing"] = false,
						["priority"] = 90,
						["range"] = true,
						["enable"] = true,
					},
					["debuff_Fear"] = {
						["text"] = "Fear",
						["color"] = {
							["a"] = 1,
							["b"] = 0.5,
							["g"] = 0.5,
							["r"] = 0.5,
						},
						["priority"] = 90,
						["missing"] = false,
						["enable"] = true,
						["duration"] = false,
						["range"] = false,
						["desc"] = "Debuff: Fear",
					},
					["buff_Regrowth"] = {
						["icon"] = "Interface\\Icons\\Spell_Nature_ResistNature",
					},
					["buff_Riptide"] = {
						["color"] = {
							["b"] = 0.5019607843137255,
							["g"] = 0.1098039215686275,
							["r"] = 0.3411764705882353,
						},
						["duration"] = false,
						["icon"] = "Interface\\Icons\\spell_nature_riptide",
						["missing"] = false,
					},
					["buff_PowerWord:Shield"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
					},
					["abolish"] = false,
					["buff_Lifebloom"] = {
						["icon"] = "Interface\\Icons\\INV_Misc_Herb_Felblossom",
					},
					["buff_HandofSacrifice"] = {
						["duration"] = true,
						["color"] = {
							["a"] = 1,
							["b"] = 0.5019607843137255,
							["g"] = 0.5019607843137255,
							["r"] = 0.5019607843137255,
						},
						["priority"] = 90,
						["enable"] = true,
						["missing"] = false,
						["text"] = "Hand of Sacrifice",
						["range"] = false,
						["desc"] = "Buff: Hand of Sacrifice",
					},
				},
				["RealUI"] = {
					["debuff_FrostBolt"] = {
						["duration"] = false,
						["color"] = {
							["a"] = 1,
							["r"] = 0.3882352941176471,
							["g"] = 0.4274509803921568,
							["b"] = 1,
						},
						["text"] = "FrostBolt",
						["enable"] = true,
						["missing"] = false,
						["priority"] = 90,
						["range"] = false,
						["desc"] = "Debuff: FrostBolt",
					},
					["debuff_NapalmShell"] = {
						["text"] = "Napalm Shell",
						["color"] = {
							["a"] = 1,
							["r"] = 0.5,
							["g"] = 0.5,
							["b"] = 0.5,
						},
						["duration"] = false,
						["missing"] = false,
						["enable"] = true,
						["priority"] = 90,
						["range"] = false,
						["desc"] = "Debuff: Napalm Shell",
					},
					["debuff_IronRoots"] = {
						["text"] = "Iron Roots",
						["missing"] = false,
						["duration"] = false,
						["enable"] = true,
						["color"] = {
							["a"] = 1,
							["r"] = 0.5,
							["g"] = 0.5,
							["b"] = 0.5,
						},
						["priority"] = 90,
						["range"] = false,
						["desc"] = "Debuff: Iron Roots",
					},
					["buff_Rejuvenation"] = {
						["icon"] = "Interface\\Icons\\Spell_Nature_Rejuvenation",
					},
					["debuff_FrostBlast"] = {
						["duration"] = false,
						["missing"] = false,
						["text"] = "Frost Blast",
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 0.396078431372549,
							["r"] = 0.2549019607843137,
						},
						["enable"] = true,
						["priority"] = 90,
						["range"] = true,
						["desc"] = "Debuff: Frost Blast",
					},
					["buff_EarthShield"] = {
						["color"] = {
							["b"] = 0.2901960784313725,
							["g"] = 0.9490196078431372,
							["r"] = 1,
						},
						["duration"] = false,
						["icon"] = "Interface\\Icons\\Spell_Nature_SkinofEarth",
						["missing"] = false,
					},
					["buff_Renew"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_Renew",
					},
					["buff_BeaconofLight"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 0.9882352941176471,
							["g"] = 0.615686274509804,
							["r"] = 1,
						},
						["duration"] = false,
						["mine"] = true,
						["desc"] = "Buff: Beacon of Light",
						["enable"] = true,
						["range"] = true,
						["priority"] = 90,
						["missing"] = false,
						["text"] = "Beacon of Light",
					},
					["debuff_Fear"] = {
						["text"] = "Fear",
						["color"] = {
							["a"] = 1,
							["r"] = 0.5,
							["g"] = 0.5,
							["b"] = 0.5,
						},
						["duration"] = false,
						["enable"] = true,
						["missing"] = false,
						["priority"] = 90,
						["range"] = false,
						["desc"] = "Debuff: Fear",
					},
					["buff_Regrowth"] = {
						["icon"] = "Interface\\Icons\\Spell_Nature_ResistNature",
					},
					["buff_Riptide"] = {
						["missing"] = false,
						["duration"] = false,
						["color"] = {
							["r"] = 0.3411764705882353,
							["g"] = 0.1098039215686275,
							["b"] = 0.5019607843137255,
						},
					},
					["abolish"] = false,
					["buff_PowerWord:Shield"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
					},
					["buff_Lifebloom"] = {
						["icon"] = "Interface\\Icons\\INV_Misc_Herb_Felblossom",
					},
					["buff_HandofSacrifice"] = {
						["duration"] = true,
						["color"] = {
							["a"] = 1,
							["r"] = 0.5019607843137255,
							["g"] = 0.5019607843137255,
							["b"] = 0.5019607843137255,
						},
						["text"] = "Hand of Sacrifice",
						["missing"] = false,
						["enable"] = true,
						["priority"] = 90,
						["range"] = false,
						["desc"] = "Buff: Hand of Sacrifice",
					},
				},
				["Default"] = {
					["abolish"] = true,
				},
				["RealUI-HR-Healing"] = {
					["debuff_FrostBolt"] = {
						["duration"] = false,
						["color"] = {
							["a"] = 1,
							["r"] = 0.3882352941176471,
							["g"] = 0.4274509803921568,
							["b"] = 1,
						},
						["text"] = "FrostBolt",
						["enable"] = true,
						["missing"] = false,
						["priority"] = 90,
						["range"] = false,
						["desc"] = "Debuff: FrostBolt",
					},
					["debuff_NapalmShell"] = {
						["text"] = "Napalm Shell",
						["color"] = {
							["a"] = 1,
							["r"] = 0.5,
							["g"] = 0.5,
							["b"] = 0.5,
						},
						["duration"] = false,
						["missing"] = false,
						["enable"] = true,
						["priority"] = 90,
						["range"] = false,
						["desc"] = "Debuff: Napalm Shell",
					},
					["buff_HandofSacrifice"] = {
						["duration"] = true,
						["color"] = {
							["a"] = 1,
							["r"] = 0.5019607843137255,
							["g"] = 0.5019607843137255,
							["b"] = 0.5019607843137255,
						},
						["text"] = "Hand of Sacrifice",
						["missing"] = false,
						["enable"] = true,
						["priority"] = 90,
						["range"] = false,
						["desc"] = "Buff: Hand of Sacrifice",
					},
					["buff_Rejuvenation"] = {
						["icon"] = "Interface\\Icons\\Spell_Nature_Rejuvenation",
					},
					["debuff_FrostBlast"] = {
						["duration"] = false,
						["missing"] = false,
						["text"] = "Frost Blast",
						["color"] = {
							["a"] = 1,
							["b"] = 1,
							["g"] = 0.396078431372549,
							["r"] = 0.2549019607843137,
						},
						["enable"] = true,
						["priority"] = 90,
						["range"] = true,
						["desc"] = "Debuff: Frost Blast",
					},
					["buff_EarthShield"] = {
						["color"] = {
							["b"] = 0.2901960784313725,
							["g"] = 0.9490196078431372,
							["r"] = 1,
						},
						["duration"] = false,
						["icon"] = "Interface\\Icons\\Spell_Nature_SkinofEarth",
						["missing"] = false,
					},
					["buff_Renew"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_Renew",
					},
					["buff_BeaconofLight"] = {
						["color"] = {
							["a"] = 1,
							["b"] = 0.9882352941176471,
							["g"] = 0.615686274509804,
							["r"] = 1,
						},
						["duration"] = false,
						["mine"] = true,
						["desc"] = "Buff: Beacon of Light",
						["enable"] = true,
						["range"] = true,
						["priority"] = 90,
						["missing"] = false,
						["text"] = "Beacon of Light",
					},
					["debuff_Fear"] = {
						["text"] = "Fear",
						["color"] = {
							["a"] = 1,
							["r"] = 0.5,
							["g"] = 0.5,
							["b"] = 0.5,
						},
						["duration"] = false,
						["enable"] = true,
						["missing"] = false,
						["priority"] = 90,
						["range"] = false,
						["desc"] = "Debuff: Fear",
					},
					["buff_Regrowth"] = {
						["icon"] = "Interface\\Icons\\Spell_Nature_ResistNature",
					},
					["buff_Riptide"] = {
						["color"] = {
							["b"] = 0.5019607843137255,
							["g"] = 0.1098039215686275,
							["r"] = 0.3411764705882353,
						},
						["duration"] = false,
						["icon"] = "Interface\\Icons\\spell_nature_riptide",
						["missing"] = false,
					},
					["abolish"] = false,
					["buff_PowerWord:Shield"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
					},
					["buff_Lifebloom"] = {
						["icon"] = "Interface\\Icons\\INV_Misc_Herb_Felblossom",
					},
					["debuff_IronRoots"] = {
						["text"] = "Iron Roots",
						["missing"] = false,
						["duration"] = false,
						["enable"] = true,
						["color"] = {
							["a"] = 1,
							["r"] = 0.5,
							["g"] = 0.5,
							["b"] = 0.5,
						},
						["priority"] = 90,
						["range"] = false,
						["desc"] = "Debuff: Iron Roots",
					},
				},
			},
		},
		["GridIndicatorCornerPlus"] = {
			["profiles"] = {
				["RealUI-HR-Healing"] = {
					["CornerPlusSize"] = 7,
					["CornerPlusOriginalSize"] = false,
					["CornerPlusSpace"] = 0,
				},
				["RealUI-HR"] = {
					["CornerPlusSize"] = 7,
					["CornerPlusOriginalSize"] = false,
					["CornerPlusSpace"] = 0,
				},
				["RealUI-Healing"] = {
					["CornerPlusSize"] = 7,
					["CornerPlusOriginalSize"] = false,
					["CornerPlusSpace"] = 0,
				},
				["RealUI"] = {
					["CornerPlusSize"] = 7,
					["CornerPlusOriginalSize"] = false,
					["CornerPlusSpace"] = 0,
				},
			},
		},
		["GridStatusThreat"] = {
		},
		["LibDualSpec-1.0"] = {
		},
		["GridMBStatus"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["hiderage"] = true,
					["color"] = {
						["g"] = 0.5019607843137255,
					},
				},
				["RealUI-HR-Healing"] = {
					["hiderage"] = true,
					["color"] = {
						["g"] = 0.5019607843137255,
					},
				},
				["RealUI-Healing"] = {
					["hiderage"] = true,
					["color"] = {
						["g"] = 0.5019607843137255,
					},
				},
				["RealUI"] = {
					["hiderage"] = true,
					["color"] = {
						["g"] = 0.5019607843137255,
					},
				},
			},
		},
		["GridStatusRaidDebuff"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["isFirst"] = false,
				},
				["RealUI-Healing"] = {
					["isFirst"] = false,
				},
				["RealUI"] = {
					["isFirst"] = false,
				},
				["Default"] = {
					["isFirst"] = false,
				},
				["RealUI-HR-Healing"] = {
					["isFirst"] = false,
				},
			},
		},
		["GridStatusTarget"] = {
		},
		["GridMBFrame"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["side"] = "Bottom",
					["size"] = 0.05,
				},
				["RealUI-HR-Healing"] = {
					["side"] = "Bottom",
					["size"] = 0.09,
				},
				["RealUI-Healing"] = {
					["side"] = "Bottom",
					["size"] = 0.09,
				},
				["RealUI"] = {
					["side"] = "Bottom",
					["size"] = 0.05,
				},
			},
		},
		["GridLayout"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["hideTab"] = true,
					["anchorRel"] = "BOTTOM",
					["BorderB"] = 0.5019607843137255,
					["layouts"] = {
						["solo"] = "None",
						["arena"] = "By Group 5 w/Pets",
						["raid"] = "By Group 25",
					},
					["BackgroundR"] = 0,
					["FrameLock"] = true,
					["BorderA"] = 0,
					["BorderR"] = 0.5019607843137255,
					["Spacing"] = 4,
					["anchor"] = "BOTTOM",
					["clamp"] = false,
					["PosY"] = 119.1838968824322,
					["layout"] = "None",
					["PosX"] = 0.0001334632561338367,
					["BackgroundA"] = 0,
					["BackgroundG"] = 0,
					["BorderG"] = 0.5019607843137255,
					["horizontal"] = true,
					["Padding"] = 0,
					["BackgroundB"] = 0,
					["borderTexture"] = "Seerah Solid",
				},
				["RealUI-Healing"] = {
					["hideTab"] = true,
					["anchorRel"] = "TOP",
					["BorderB"] = 0.5019607843137255,
					["layouts"] = {
						["party"] = "By Group 5 w/Pets",
						["solo"] = "None",
						["arena"] = "By Group 5 w/Pets",
						["bg"] = "By Group 15",
						["raid"] = "By Group 25",
					},
					["BackgroundR"] = 0,
					["FrameLock"] = true,
					["BorderA"] = 0,
					["BorderR"] = 0.5019607843137255,
					["Spacing"] = 4,
					["anchor"] = "TOP",
					["clamp"] = false,
					["PosY"] = -529.4935197128552,
					["layout"] = "None",
					["BackgroundA"] = 0,
					["PosX"] = -2.447169106289948e-005,
					["BorderG"] = 0.5019607843137255,
					["BackgroundG"] = 0,
					["Padding"] = 0,
					["BackgroundB"] = 0,
					["borderTexture"] = "Seerah Solid",
				},
				["RealUI"] = {
					["hideTab"] = true,
					["anchorRel"] = "BOTTOM",
					["BorderB"] = 0.5019607843137255,
					["layouts"] = {
						["raid"] = "By Group 25",
						["arena"] = "By Group 5 w/Pets",
						["solo"] = "None",
						["bg"] = "By Group 15",
					},
					["BackgroundB"] = 0,
					["FrameLock"] = true,
					["BorderA"] = 0,
					["BorderR"] = 0.5019607843137255,
					["PosX"] = -0.499941224309282,
					["anchor"] = "BOTTOM",
					["BackgroundG"] = 0,
					["PosY"] = 82.50004400614378,
					["layout"] = "None",
					["borderTexture"] = "Seerah Solid",
					["BackgroundA"] = 0,
					["clamp"] = false,
					["BorderG"] = 0.5019607843137255,
					["Padding"] = 0,
					["horizontal"] = true,
					["Spacing"] = 4,
					["BackgroundR"] = 0,
				},
				["Default"] = {
					["anchorRel"] = "TOPLEFT",
					["PosY"] = -399.9996031599165,
					["PosX"] = 499.9998264004128,
					["layouts"] = {
						["raid"] = "By Group 10",
						["heroic_raid"] = "By Group 25",
					},
					["layout"] = "By Group 5",
					["horizontal"] = true,
				},
				["RealUI-HR-Healing"] = {
					["hideTab"] = true,
					["anchorRel"] = "TOP",
					["BorderB"] = 0.5019607843137255,
					["layouts"] = {
						["arena"] = "By Group 5 w/Pets",
						["raid"] = "By Group 25",
						["solo"] = "None",
						["party"] = "By Group 5 w/Pets",
					},
					["BackgroundR"] = 0,
					["FrameLock"] = true,
					["BorderA"] = 0,
					["BorderR"] = 0.5019607843137255,
					["Spacing"] = 4,
					["anchor"] = "TOP",
					["clamp"] = false,
					["PosY"] = -529.4935197128552,
					["layout"] = "None",
					["BackgroundA"] = 0,
					["PosX"] = -2.447169106289948e-005,
					["BorderG"] = 0.5019607843137255,
					["BackgroundG"] = 0,
					["Padding"] = 0,
					["BackgroundB"] = 0,
					["borderTexture"] = "Seerah Solid",
				},
			},
		},
		["GridStatusFastHealth"] = {
		},
		["GridStatusMana"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["alert_lowMana"] = {
						["threshold"] = 5,
					},
				},
				["RealUI-HR-Healing"] = {
					["alert_lowMana"] = {
						["threshold"] = 5,
					},
				},
				["RealUI-Healing"] = {
					["alert_lowMana"] = {
						["threshold"] = 5,
					},
				},
				["RealUI"] = {
					["alert_lowMana"] = {
						["threshold"] = 5,
					},
				},
			},
		},
		["GridStatusRange"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["alert_range_43"] = {
						["enable"] = true,
						["text"] = "43 yards",
						["color"] = {
							["a"] = 0.2181818181818181,
							["b"] = 0.29,
							["g"] = 0.86,
							["r"] = 0.43,
						},
						["priority"] = 84,
						["range"] = false,
						["desc"] = "More than 43 yards away",
					},
					["alert_range_28"] = {
						["color"] = {
							["a"] = 0.800000011920929,
							["r"] = 0.2509803921568627,
							["g"] = 0.2509803921568627,
							["b"] = 0.2509803921568627,
						},
						["priority"] = 83,
						["enable"] = true,
						["text"] = "28 yards",
						["range"] = false,
						["desc"] = "More than 28 yards away",
					},
					["alert_range_30"] = {
						["color"] = {
							["a"] = 0.800000011920929,
							["r"] = 0.1568627450980392,
							["g"] = 0.1568627450980392,
							["b"] = 0.1568627450980392,
						},
						["priority"] = 83,
						["enable"] = true,
						["text"] = "30 yards",
						["range"] = false,
						["desc"] = "More than 30 yards away",
					},
					["alert_range_45"] = {
						["enable"] = true,
						["text"] = "45 yards",
						["color"] = {
							["a"] = 0.1818181818181818,
							["b"] = 0.35,
							["g"] = 0.9,
							["r"] = 0.45,
						},
						["priority"] = 84,
						["range"] = false,
						["desc"] = "More than 45 yards away",
					},
					["alert_range_10"] = {
						["color"] = {
							["a"] = 0.9000000059604645,
							["r"] = 0.2509803921568627,
							["g"] = 0.2509803921568627,
							["b"] = 0.2509803921568627,
						},
						["priority"] = 81,
						["enable"] = false,
						["text"] = "10 yards",
						["range"] = false,
						["desc"] = "More than 10 yards away",
					},
					["alert_range_38"] = {
						["color"] = {
							["a"] = 0.4000000357627869,
							["r"] = 0.2509803921568627,
							["g"] = 0.2509803921568627,
							["b"] = 0.2509803921568627,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "38 yards",
						["range"] = false,
						["desc"] = "More than 38 yards away",
					},
					["alert_range_25"] = {
						["color"] = {
							["a"] = 0.5454545454545454,
							["b"] = 0.75,
							["g"] = 0.5,
							["r"] = 0.25,
						},
						["priority"] = 82,
						["enable"] = false,
						["text"] = "25 yards",
						["range"] = false,
						["desc"] = "More than 25 yards away",
					},
					["alert_range_100"] = {
						["color"] = {
							["a"] = 0.1090909090909091,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0,
						},
						["priority"] = 90,
						["enable"] = false,
						["text"] = "100 yards",
						["range"] = false,
						["desc"] = "More than 100 yards away",
					},
					["alert_range_40"] = {
						["color"] = {
							["a"] = 0.5,
							["r"] = 0.1568627450980392,
							["g"] = 0.1568627450980392,
							["b"] = 0.1568627450980392,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "40 yards",
						["range"] = false,
						["desc"] = "More than 40 yards away",
					},
					["alert_range_46"] = {
						["color"] = {
							["a"] = 0.1636363636363637,
							["b"] = 0.38,
							["g"] = 0.92,
							["r"] = 0.46,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "46 yards",
						["range"] = false,
						["desc"] = "More than 46 yards away",
					},
					["alert_range_36"] = {
						["color"] = {
							["a"] = 0.3454545454545455,
							["b"] = 0.08,
							["g"] = 0.72,
							["r"] = 0.36,
						},
						["priority"] = 83,
						["enable"] = true,
						["text"] = "36 yards",
						["range"] = false,
						["desc"] = "More than 36 yards away",
					},
					["alert_range_60"] = {
						["color"] = {
							["a"] = 0.8363636363636364,
							["r"] = 0.6,
							["g"] = 0.2,
							["b"] = 0.8,
						},
						["priority"] = 86,
						["enable"] = true,
						["text"] = "60 yards",
						["range"] = false,
						["desc"] = "More than 60 yards away",
					},
					["alert_range_33"] = {
						["enable"] = true,
						["text"] = "33 yards",
						["color"] = {
							["a"] = 0.4,
							["b"] = 0.99,
							["g"] = 0.66,
							["r"] = 0.33,
						},
						["priority"] = 83,
						["range"] = false,
						["desc"] = "More than 33 yards away",
					},
					["alert_range_20"] = {
						["enable"] = false,
						["text"] = "20 yards",
						["color"] = {
							["a"] = 0.6363636363636364,
							["b"] = 0.6,
							["g"] = 0.4,
							["r"] = 0.2,
						},
						["priority"] = 82,
						["range"] = false,
						["desc"] = "More than 20 yards away",
					},
					["frequency"] = 0.7000000000000001,
				},
				["RealUI-Healing"] = {
					["alert_range_45"] = {
						["enable"] = true,
						["text"] = "45 yards",
						["color"] = {
							["a"] = 0.1818181818181818,
							["b"] = 0.35,
							["g"] = 0.9,
							["r"] = 0.45,
						},
						["priority"] = 84,
						["range"] = false,
						["desc"] = "More than 45 yards away",
					},
					["alert_range_43"] = {
						["enable"] = true,
						["text"] = "43 yards",
						["color"] = {
							["a"] = 0.2181818181818181,
							["b"] = 0.29,
							["g"] = 0.86,
							["r"] = 0.43,
						},
						["priority"] = 84,
						["range"] = false,
						["desc"] = "More than 43 yards away",
					},
					["frequency"] = 0.7000000000000001,
					["alert_range_100"] = {
						["color"] = {
							["a"] = 0.1090909090909091,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0,
						},
						["priority"] = 90,
						["enable"] = false,
						["text"] = "100 yards",
						["range"] = false,
						["desc"] = "More than 100 yards away",
					},
					["alert_range_38"] = {
						["color"] = {
							["a"] = 0.4000000357627869,
							["r"] = 0.2509803921568627,
							["g"] = 0.2509803921568627,
							["b"] = 0.2509803921568627,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "38 yards",
						["range"] = false,
						["desc"] = "More than 38 yards away",
					},
					["alert_range_25"] = {
						["color"] = {
							["a"] = 0.5454545454545454,
							["b"] = 0.75,
							["g"] = 0.5,
							["r"] = 0.25,
						},
						["priority"] = 82,
						["enable"] = false,
						["text"] = "25 yards",
						["range"] = false,
						["desc"] = "More than 25 yards away",
					},
					["alert_range_60"] = {
						["color"] = {
							["a"] = 0.8363636363636364,
							["r"] = 0.6,
							["g"] = 0.2,
							["b"] = 0.8,
						},
						["priority"] = 86,
						["enable"] = true,
						["text"] = "60 yards",
						["range"] = false,
						["desc"] = "More than 60 yards away",
					},
					["alert_range_33"] = {
						["enable"] = true,
						["text"] = "33 yards",
						["color"] = {
							["a"] = 0.4,
							["b"] = 0.99,
							["g"] = 0.66,
							["r"] = 0.33,
						},
						["priority"] = 83,
						["range"] = false,
						["desc"] = "More than 33 yards away",
					},
					["alert_range_40"] = {
						["color"] = {
							["a"] = 0.4000000357627869,
							["r"] = 0.1568627450980392,
							["g"] = 0.1568627450980392,
							["b"] = 0.1568627450980392,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "40 yards",
						["range"] = false,
						["desc"] = "More than 40 yards away",
					},
					["alert_range_46"] = {
						["color"] = {
							["a"] = 0.1636363636363637,
							["b"] = 0.38,
							["g"] = 0.92,
							["r"] = 0.46,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "46 yards",
						["range"] = false,
						["desc"] = "More than 46 yards away",
					},
					["alert_range_10"] = {
						["color"] = {
							["a"] = 0.9000000059604645,
							["r"] = 0.2509803921568627,
							["g"] = 0.2509803921568627,
							["b"] = 0.2509803921568627,
						},
						["priority"] = 81,
						["enable"] = false,
						["text"] = "10 yards",
						["range"] = false,
						["desc"] = "More than 10 yards away",
					},
					["alert_range_28"] = {
						["color"] = {
							["a"] = 0.800000011920929,
							["r"] = 0.2509803921568627,
							["g"] = 0.2509803921568627,
							["b"] = 0.2509803921568627,
						},
						["priority"] = 83,
						["enable"] = true,
						["text"] = "28 yards",
						["range"] = false,
						["desc"] = "More than 28 yards away",
					},
					["alert_range_30"] = {
						["color"] = {
							["a"] = 0.8500000089406967,
							["r"] = 0.1568627450980392,
							["g"] = 0.1568627450980392,
							["b"] = 0.1568627450980392,
						},
						["priority"] = 83,
						["enable"] = true,
						["text"] = "30 yards",
						["range"] = false,
						["desc"] = "More than 30 yards away",
					},
					["alert_range_36"] = {
						["color"] = {
							["a"] = 0.3454545454545455,
							["b"] = 0.08,
							["g"] = 0.72,
							["r"] = 0.36,
						},
						["priority"] = 83,
						["enable"] = true,
						["text"] = "36 yards",
						["range"] = false,
						["desc"] = "More than 36 yards away",
					},
					["alert_range_20"] = {
						["enable"] = false,
						["text"] = "20 yards",
						["color"] = {
							["a"] = 0.6363636363636364,
							["b"] = 0.6,
							["g"] = 0.4,
							["r"] = 0.2,
						},
						["priority"] = 82,
						["range"] = false,
						["desc"] = "More than 20 yards away",
					},
				},
				["RealUI"] = {
					["alert_range_45"] = {
						["enable"] = true,
						["text"] = "45 yards",
						["color"] = {
							["a"] = 0.1818181818181818,
							["r"] = 0.45,
							["g"] = 0.9,
							["b"] = 0.35,
						},
						["priority"] = 84,
						["range"] = false,
						["desc"] = "More than 45 yards away",
					},
					["alert_range_43"] = {
						["enable"] = true,
						["text"] = "43 yards",
						["color"] = {
							["a"] = 0.2181818181818181,
							["r"] = 0.43,
							["g"] = 0.86,
							["b"] = 0.29,
						},
						["priority"] = 84,
						["range"] = false,
						["desc"] = "More than 43 yards away",
					},
					["frequency"] = 0.7000000000000001,
					["alert_range_20"] = {
						["enable"] = false,
						["text"] = "20 yards",
						["color"] = {
							["a"] = 0.6363636363636364,
							["r"] = 0.2,
							["g"] = 0.4,
							["b"] = 0.6,
						},
						["priority"] = 82,
						["range"] = false,
						["desc"] = "More than 20 yards away",
					},
					["alert_range_38"] = {
						["color"] = {
							["a"] = 0.4000000357627869,
							["b"] = 0.2509803921568627,
							["g"] = 0.2509803921568627,
							["r"] = 0.2509803921568627,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "38 yards",
						["range"] = false,
						["desc"] = "More than 38 yards away",
					},
					["alert_range_25"] = {
						["color"] = {
							["a"] = 0.5454545454545454,
							["r"] = 0.25,
							["g"] = 0.5,
							["b"] = 0.75,
						},
						["priority"] = 82,
						["enable"] = false,
						["text"] = "25 yards",
						["range"] = false,
						["desc"] = "More than 25 yards away",
					},
					["alert_range_60"] = {
						["color"] = {
							["a"] = 0.8363636363636364,
							["b"] = 0.8,
							["g"] = 0.2,
							["r"] = 0.6,
						},
						["priority"] = 86,
						["enable"] = true,
						["text"] = "60 yards",
						["range"] = false,
						["desc"] = "More than 60 yards away",
					},
					["alert_range_10"] = {
						["color"] = {
							["a"] = 0.9000000059604645,
							["b"] = 0.2509803921568627,
							["g"] = 0.2509803921568627,
							["r"] = 0.2509803921568627,
						},
						["priority"] = 81,
						["enable"] = false,
						["text"] = "10 yards",
						["range"] = false,
						["desc"] = "More than 10 yards away",
					},
					["alert_range_40"] = {
						["color"] = {
							["a"] = 0.5,
							["b"] = 0.1568627450980392,
							["g"] = 0.1568627450980392,
							["r"] = 0.1568627450980392,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "40 yards",
						["range"] = false,
						["desc"] = "More than 40 yards away",
					},
					["alert_range_46"] = {
						["color"] = {
							["a"] = 0.1636363636363637,
							["r"] = 0.46,
							["g"] = 0.92,
							["b"] = 0.38,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "46 yards",
						["range"] = false,
						["desc"] = "More than 46 yards away",
					},
					["alert_range_33"] = {
						["enable"] = true,
						["text"] = "33 yards",
						["color"] = {
							["a"] = 0.4,
							["r"] = 0.33,
							["g"] = 0.66,
							["b"] = 0.99,
						},
						["priority"] = 83,
						["range"] = false,
						["desc"] = "More than 33 yards away",
					},
					["alert_range_28"] = {
						["color"] = {
							["a"] = 0.800000011920929,
							["b"] = 0.2509803921568627,
							["g"] = 0.2509803921568627,
							["r"] = 0.2509803921568627,
						},
						["priority"] = 83,
						["enable"] = true,
						["text"] = "28 yards",
						["range"] = false,
						["desc"] = "More than 28 yards away",
					},
					["alert_range_30"] = {
						["color"] = {
							["a"] = 0.800000011920929,
							["b"] = 0.1568627450980392,
							["g"] = 0.1568627450980392,
							["r"] = 0.1568627450980392,
						},
						["priority"] = 83,
						["enable"] = true,
						["text"] = "30 yards",
						["range"] = false,
						["desc"] = "More than 30 yards away",
					},
					["alert_range_36"] = {
						["color"] = {
							["a"] = 0.3454545454545455,
							["r"] = 0.36,
							["g"] = 0.72,
							["b"] = 0.08,
						},
						["priority"] = 83,
						["enable"] = true,
						["text"] = "36 yards",
						["range"] = false,
						["desc"] = "More than 36 yards away",
					},
					["alert_range_100"] = {
						["color"] = {
							["a"] = 0.1090909090909091,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
						["priority"] = 90,
						["enable"] = false,
						["text"] = "100 yards",
						["range"] = false,
						["desc"] = "More than 100 yards away",
					},
				},
				["Default"] = {
					["alert_range_10"] = {
						["enable"] = false,
						["text"] = "10 yards",
						["color"] = {
							["a"] = 0.8181818181818181,
							["b"] = 0.3,
							["g"] = 0.2,
							["r"] = 0.1,
						},
						["priority"] = 81,
						["range"] = false,
						["desc"] = "More than 10 yards away",
					},
					["alert_range_38"] = {
						["enable"] = false,
						["text"] = "38 yards",
						["color"] = {
							["a"] = 0.3090909090909091,
							["b"] = 0.14,
							["g"] = 0.76,
							["r"] = 0.38,
						},
						["priority"] = 84,
						["range"] = false,
						["desc"] = "More than 38 yards away",
					},
					["alert_range_25"] = {
						["enable"] = false,
						["text"] = "25 yards",
						["color"] = {
							["a"] = 0.5454545454545454,
							["b"] = 0.75,
							["g"] = 0.5,
							["r"] = 0.25,
						},
						["priority"] = 82,
						["range"] = false,
						["desc"] = "More than 25 yards away",
					},
					["alert_range_40"] = {
						["enable"] = true,
						["text"] = "40 yards",
						["color"] = {
							["a"] = 0.2727272727272727,
							["b"] = 0.2,
							["g"] = 0.8,
							["r"] = 0.4,
						},
						["priority"] = 84,
						["range"] = false,
						["desc"] = "More than 40 yards away",
					},
					["alert_range_20"] = {
						["color"] = {
							["a"] = 0.6363636363636364,
							["r"] = 0.2,
							["g"] = 0.4,
							["b"] = 0.6,
						},
						["priority"] = 82,
						["enable"] = true,
						["text"] = "20 yards",
						["range"] = false,
						["desc"] = "More than 20 yards away",
					},
					["alert_range_28"] = {
						["enable"] = false,
						["text"] = "28 yards",
						["color"] = {
							["a"] = 0.490909090909091,
							["b"] = 0.84,
							["g"] = 0.5600000000000001,
							["r"] = 0.28,
						},
						["priority"] = 83,
						["range"] = false,
						["desc"] = "More than 28 yards away",
					},
					["alert_range_60"] = {
						["enable"] = true,
						["text"] = "60 yards",
						["color"] = {
							["a"] = 0.8363636363636364,
							["r"] = 0.6,
							["g"] = 0.2,
							["b"] = 0.8,
						},
						["priority"] = 86,
						["range"] = false,
						["desc"] = "More than 60 yards away",
					},
					["alert_range_30"] = {
						["enable"] = false,
						["text"] = "30 yards",
						["color"] = {
							["a"] = 0.4545454545454546,
							["b"] = 0.9,
							["g"] = 0.6,
							["r"] = 0.3,
						},
						["priority"] = 83,
						["range"] = false,
						["desc"] = "More than 30 yards away",
					},
					["alert_range_100"] = {
						["enable"] = false,
						["text"] = "100 yards",
						["color"] = {
							["a"] = 0.1090909090909091,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
						["priority"] = 90,
						["range"] = false,
						["desc"] = "More than 100 yards away",
					},
				},
				["RealUI-HR-Healing"] = {
					["alert_range_45"] = {
						["enable"] = true,
						["text"] = "45 yards",
						["color"] = {
							["a"] = 0.1818181818181818,
							["r"] = 0.45,
							["g"] = 0.9,
							["b"] = 0.35,
						},
						["priority"] = 84,
						["range"] = false,
						["desc"] = "More than 45 yards away",
					},
					["alert_range_43"] = {
						["enable"] = true,
						["text"] = "43 yards",
						["color"] = {
							["a"] = 0.2181818181818181,
							["r"] = 0.43,
							["g"] = 0.86,
							["b"] = 0.29,
						},
						["priority"] = 84,
						["range"] = false,
						["desc"] = "More than 43 yards away",
					},
					["alert_range_20"] = {
						["enable"] = false,
						["text"] = "20 yards",
						["color"] = {
							["a"] = 0.6363636363636364,
							["r"] = 0.2,
							["g"] = 0.4,
							["b"] = 0.6,
						},
						["priority"] = 82,
						["range"] = false,
						["desc"] = "More than 20 yards away",
					},
					["alert_range_33"] = {
						["enable"] = true,
						["text"] = "33 yards",
						["color"] = {
							["a"] = 0.4,
							["r"] = 0.33,
							["g"] = 0.66,
							["b"] = 0.99,
						},
						["priority"] = 83,
						["range"] = false,
						["desc"] = "More than 33 yards away",
					},
					["alert_range_38"] = {
						["color"] = {
							["a"] = 0.4000000357627869,
							["b"] = 0.2509803921568627,
							["g"] = 0.2509803921568627,
							["r"] = 0.2509803921568627,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "38 yards",
						["range"] = false,
						["desc"] = "More than 38 yards away",
					},
					["alert_range_25"] = {
						["color"] = {
							["a"] = 0.5454545454545454,
							["r"] = 0.25,
							["g"] = 0.5,
							["b"] = 0.75,
						},
						["priority"] = 82,
						["enable"] = false,
						["text"] = "25 yards",
						["range"] = false,
						["desc"] = "More than 25 yards away",
					},
					["alert_range_60"] = {
						["color"] = {
							["a"] = 0.8363636363636364,
							["b"] = 0.8,
							["g"] = 0.2,
							["r"] = 0.6,
						},
						["priority"] = 86,
						["enable"] = true,
						["text"] = "60 yards",
						["range"] = false,
						["desc"] = "More than 60 yards away",
					},
					["alert_range_36"] = {
						["color"] = {
							["a"] = 0.3454545454545455,
							["r"] = 0.36,
							["g"] = 0.72,
							["b"] = 0.08,
						},
						["priority"] = 83,
						["enable"] = true,
						["text"] = "36 yards",
						["range"] = false,
						["desc"] = "More than 36 yards away",
					},
					["alert_range_40"] = {
						["color"] = {
							["a"] = 0.4000000357627869,
							["b"] = 0.1568627450980392,
							["g"] = 0.1568627450980392,
							["r"] = 0.1568627450980392,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "40 yards",
						["range"] = false,
						["desc"] = "More than 40 yards away",
					},
					["alert_range_46"] = {
						["color"] = {
							["a"] = 0.1636363636363637,
							["r"] = 0.46,
							["g"] = 0.92,
							["b"] = 0.38,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "46 yards",
						["range"] = false,
						["desc"] = "More than 46 yards away",
					},
					["alert_range_100"] = {
						["color"] = {
							["a"] = 0.1090909090909091,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
						["priority"] = 90,
						["enable"] = false,
						["text"] = "100 yards",
						["range"] = false,
						["desc"] = "More than 100 yards away",
					},
					["alert_range_28"] = {
						["color"] = {
							["a"] = 0.800000011920929,
							["b"] = 0.2509803921568627,
							["g"] = 0.2509803921568627,
							["r"] = 0.2509803921568627,
						},
						["priority"] = 83,
						["enable"] = true,
						["text"] = "28 yards",
						["range"] = false,
						["desc"] = "More than 28 yards away",
					},
					["alert_range_30"] = {
						["color"] = {
							["a"] = 0.8500000089406967,
							["b"] = 0.1568627450980392,
							["g"] = 0.1568627450980392,
							["r"] = 0.1568627450980392,
						},
						["priority"] = 83,
						["enable"] = true,
						["text"] = "30 yards",
						["range"] = false,
						["desc"] = "More than 30 yards away",
					},
					["alert_range_10"] = {
						["color"] = {
							["a"] = 0.9000000059604645,
							["b"] = 0.2509803921568627,
							["g"] = 0.2509803921568627,
							["r"] = 0.2509803921568627,
						},
						["priority"] = 81,
						["enable"] = false,
						["text"] = "10 yards",
						["range"] = false,
						["desc"] = "More than 10 yards away",
					},
					["frequency"] = 0.7000000000000001,
				},
			},
		},
		["GridStatusCloseUp"] = {
			["profiles"] = {
				["RealUI"] = {
					["alert_closeup"] = {
						["HPLossToogle"] = true,
					},
				},
				["RealUI-Healing"] = {
					["alert_closeup"] = {
						["HPLossToogle"] = true,
					},
				},
			},
		},
		["GridIndicatorCornerIcons"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["iconSizeBottomRightCorner"] = 14,
					["xoffset"] = 1,
					["yoffset"] = -1,
				},
				["RealUI-HR-Healing"] = {
					["iconSizeBottomRightCorner"] = 14,
					["xoffset"] = 1,
					["yoffset"] = -1,
				},
				["RealUI-Healing"] = {
					["iconSizeBottomRightCorner"] = 14,
					["xoffset"] = 1,
					["yoffset"] = -1,
				},
				["RealUI"] = {
					["iconSizeBottomRightCorner"] = 14,
					["xoffset"] = 1,
					["yoffset"] = -1,
				},
			},
		},
		["GridStatusVoiceComm"] = {
		},
		["GridStatus"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["colors"] = {
						["HUNTER"] = {
							["b"] = 0.45,
							["g"] = 0.83,
							["r"] = 0.67,
						},
						["SHAMAN"] = {
							["b"] = 0.8588235294117647,
							["g"] = 0.3450980392156863,
							["r"] = 0.1882352941176471,
						},
						["MAGE"] = {
							["b"] = 0.9411764705882353,
							["g"] = 0.8,
							["r"] = 0.4117647058823529,
						},
						["DRUID"] = {
							["b"] = 0.04,
							["g"] = 0.49,
							["r"] = 1,
						},
						["DEATHKNIGHT"] = {
							["b"] = 0.23,
							["g"] = 0.12,
							["r"] = 0.77,
						},
						["PRIEST"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["WARLOCK"] = {
							["b"] = 0.79,
							["g"] = 0.51,
							["r"] = 0.58,
						},
						["UNKNOWN_UNIT"] = {
							["b"] = 0.6352941176470588,
							["g"] = 0.6352941176470588,
							["r"] = 0.6352941176470588,
						},
						["WARRIOR"] = {
							["b"] = 0.43,
							["g"] = 0.61,
							["r"] = 0.78,
						},
						["PALADIN"] = {
							["b"] = 0.73,
							["g"] = 0.55,
							["r"] = 0.96,
						},
						["ROGUE"] = {
							["b"] = 0.41,
							["g"] = 0.96,
							["r"] = 1,
						},
					},
				},
				["RealUI-Healing"] = {
					["colors"] = {
						["HUNTER"] = {
							["b"] = 0.45,
							["g"] = 0.83,
							["r"] = 0.67,
						},
						["UNKNOWN_PET"] = {
							["r"] = 0.2235294117647059,
							["b"] = 0.2823529411764706,
						},
						["PALADIN"] = {
							["b"] = 0.73,
							["g"] = 0.55,
							["r"] = 0.96,
						},
						["MAGE"] = {
							["b"] = 0.9411764705882353,
							["g"] = 0.8,
							["r"] = 0.4117647058823529,
						},
						["PRIEST"] = {
							["b"] = 0.8431372549019608,
							["g"] = 0.8431372549019608,
							["r"] = 0.8431372549019608,
						},
						["ROGUE"] = {
							["b"] = 0.41,
							["g"] = 0.96,
							["r"] = 1,
						},
						["WARLOCK"] = {
							["b"] = 0.79,
							["g"] = 0.51,
							["r"] = 0.58,
						},
						["SHAMAN"] = {
							["b"] = 0.8588235294117647,
							["g"] = 0.3450980392156863,
							["r"] = 0.1882352941176471,
						},
						["WARRIOR"] = {
							["b"] = 0.43,
							["g"] = 0.61,
							["r"] = 0.78,
						},
						["DRUID"] = {
							["b"] = 0.04,
							["g"] = 0.49,
							["r"] = 1,
						},
						["UNKNOWN_UNIT"] = {
							["b"] = 0.6352941176470588,
							["g"] = 0.6352941176470588,
							["r"] = 0.6352941176470588,
						},
						["DEATHKNIGHT"] = {
							["b"] = 0.23,
							["g"] = 0.12,
							["r"] = 0.77,
						},
					},
				},
				["RealUI"] = {
					["colors"] = {
						["UNKNOWN_UNIT"] = {
							["r"] = 0.6352941176470588,
							["g"] = 0.6352941176470588,
							["b"] = 0.6352941176470588,
						},
						["WARRIOR"] = {
							["r"] = 0.78,
							["g"] = 0.61,
							["b"] = 0.43,
						},
						["PALADIN"] = {
							["r"] = 0.96,
							["g"] = 0.55,
							["b"] = 0.73,
						},
						["MAGE"] = {
							["r"] = 0.4117647058823529,
							["g"] = 0.8,
							["b"] = 0.9411764705882353,
						},
						["PRIEST"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["WARLOCK"] = {
							["r"] = 0.58,
							["g"] = 0.51,
							["b"] = 0.79,
						},
						["SHAMAN"] = {
							["r"] = 0.1882352941176471,
							["g"] = 0.3450980392156863,
							["b"] = 0.8588235294117647,
						},
						["ROGUE"] = {
							["r"] = 1,
							["g"] = 0.96,
							["b"] = 0.41,
						},
						["DRUID"] = {
							["r"] = 1,
							["g"] = 0.49,
							["b"] = 0.04,
						},
						["HUNTER"] = {
							["r"] = 0.67,
							["g"] = 0.83,
							["b"] = 0.45,
						},
						["DEATHKNIGHT"] = {
							["r"] = 0.77,
							["g"] = 0.12,
							["b"] = 0.23,
						},
					},
				},
				["Default"] = {
					["colors"] = {
						["HUNTER"] = {
							["r"] = 0.67,
							["g"] = 0.83,
							["b"] = 0.45,
						},
						["WARRIOR"] = {
							["r"] = 0.78,
							["g"] = 0.61,
							["b"] = 0.43,
						},
						["PALADIN"] = {
							["r"] = 0.96,
							["g"] = 0.55,
							["b"] = 0.73,
						},
						["MAGE"] = {
							["r"] = 0.41,
							["g"] = 0.8,
							["b"] = 0.94,
						},
						["PRIEST"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["WARLOCK"] = {
							["r"] = 0.58,
							["g"] = 0.51,
							["b"] = 0.79,
						},
						["ROGUE"] = {
							["r"] = 1,
							["g"] = 0.96,
							["b"] = 0.41,
						},
						["DRUID"] = {
							["r"] = 1,
							["g"] = 0.49,
							["b"] = 0.04,
						},
						["SHAMAN"] = {
							["r"] = 0,
							["g"] = 0.44,
							["b"] = 0.87,
						},
						["DEATHKNIGHT"] = {
							["r"] = 0.77,
							["g"] = 0.12,
							["b"] = 0.23,
						},
					},
				},
				["RealUI-HR-Healing"] = {
					["colors"] = {
						["HUNTER"] = {
							["r"] = 0.67,
							["g"] = 0.83,
							["b"] = 0.45,
						},
						["WARRIOR"] = {
							["r"] = 0.78,
							["g"] = 0.61,
							["b"] = 0.43,
						},
						["ROGUE"] = {
							["r"] = 1,
							["g"] = 0.96,
							["b"] = 0.41,
						},
						["MAGE"] = {
							["r"] = 0.4117647058823529,
							["g"] = 0.8,
							["b"] = 0.9411764705882353,
						},
						["PRIEST"] = {
							["r"] = 0.8431372549019608,
							["g"] = 0.8431372549019608,
							["b"] = 0.8431372549019608,
						},
						["PALADIN"] = {
							["r"] = 0.96,
							["g"] = 0.55,
							["b"] = 0.73,
						},
						["WARLOCK"] = {
							["r"] = 0.58,
							["g"] = 0.51,
							["b"] = 0.79,
						},
						["SHAMAN"] = {
							["r"] = 0.1882352941176471,
							["g"] = 0.3450980392156863,
							["b"] = 0.8588235294117647,
						},
						["UNKNOWN_PET"] = {
							["b"] = 0.2823529411764706,
							["r"] = 0.2235294117647059,
						},
						["DRUID"] = {
							["r"] = 1,
							["g"] = 0.49,
							["b"] = 0.04,
						},
						["UNKNOWN_UNIT"] = {
							["b"] = 0.6352941176470588,
							["g"] = 0.6352941176470588,
							["r"] = 0.6352941176470588,
						},
						["DEATHKNIGHT"] = {
							["r"] = 0.77,
							["g"] = 0.12,
							["b"] = 0.23,
						},
					},
				},
			},
		},
		["GridStatusAggro"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["alert_aggro"] = {
						["threatcolors"] = {
							{
								["b"] = 0.4666656414046884,
							}, -- [1]
						},
					},
				},
				["RealUI-Healing"] = {
					["alert_aggro"] = {
						["threatcolors"] = {
							{
								["b"] = 0.4666656414046884,
							}, -- [1]
						},
					},
				},
				["RealUI"] = {
					["alert_aggro"] = {
						["threatcolors"] = {
							{
								["b"] = 0.4666656414046884,
							}, -- [1]
						},
					},
				},
				["Default"] = {
					["alert_aggro"] = {
						["threatcolors"] = {
							{
								["b"] = 0.4666656414046884,
							}, -- [1]
						},
					},
				},
				["RealUI-HR-Healing"] = {
					["alert_aggro"] = {
						["threatcolors"] = {
							{
								["b"] = 0.4666656414046884,
							}, -- [1]
						},
					},
				},
			},
		},
		["GridStatusHeals"] = {
			["profiles"] = {
				["Default"] = {
					["alert_heals"] = {
						["heal_filter"] = {
							["direct"] = true,
							["hot"] = true,
							["channeled"] = true,
						},
					},
				},
			},
		},
		["GridStatusReadyCheck"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["ready_check"] = {
						["priority"] = 99,
					},
				},
				["RealUI-HR-Healing"] = {
					["ready_check"] = {
						["priority"] = 99,
					},
				},
				["RealUI-Healing"] = {
					["ready_check"] = {
						["priority"] = 99,
					},
				},
				["RealUI"] = {
					["ready_check"] = {
						["priority"] = 99,
					},
				},
			},
		},
		["DungeonRole"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["dungeonRole"] = {
						["filter"] = {
							["DAMAGER"] = false,
							["DPS"] = false,
						},
					},
				},
				["RealUI-Healing"] = {
					["dungeonRole"] = {
						["filter"] = {
							["DAMAGER"] = false,
							["DPS"] = false,
						},
					},
				},
				["RealUI"] = {
					["dungeonRole"] = {
						["filter"] = {
							["DAMAGER"] = false,
							["DPS"] = false,
						},
					},
				},
				["Default"] = {
					["dungeonRole"] = {
						["colors"] = {
							["tank"] = {
								["a"] = 1,
								["r"] = 0,
								["g"] = 0,
								["b"] = 0.75,
							},
							["healer"] = {
								["a"] = 1,
								["r"] = 0,
								["g"] = 0.75,
								["b"] = 0,
							},
							["DPS"] = {
								["a"] = 1,
								["r"] = 0.75,
								["g"] = 0,
								["b"] = 0,
							},
						},
						["filter"] = {
							["tank"] = true,
							["healer"] = true,
							["DPS"] = true,
						},
					},
				},
				["RealUI-HR-Healing"] = {
					["dungeonRole"] = {
						["filter"] = {
							["DAMAGER"] = false,
							["DPS"] = false,
						},
					},
				},
			},
		},
		["GridIndicatorSideIcons"] = {
			["profiles"] = {
			},
		},
		["GridStatusHealth"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["alert_offline"] = {
						["color"] = {
							["a"] = 0,
							["b"] = 0.8627450980392157,
							["g"] = 0.8627450980392157,
							["r"] = 0.8627450980392157,
						},
					},
					["unit_healthDeficit"] = {
						["threshold"] = 90,
						["useClassColors"] = false,
						["priority"] = 73,
					},
					["alert_death"] = {
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
					},
					["alert_lowHealth"] = {
						["threshold"] = 30,
						["color"] = {
							["b"] = 0,
							["g"] = 0,
							["r"] = 0.7843137254901961,
						},
						["priority"] = 86,
					},
					["unit_health"] = {
						["color"] = {
							["b"] = 0.1058823529411765,
							["g"] = 0.1058823529411765,
							["r"] = 0.1058823529411765,
						},
						["priority"] = 61,
						["useClassColors"] = false,
					},
				},
				["RealUI-HR-Healing"] = {
					["alert_offline"] = {
						["color"] = {
							["a"] = 0,
							["b"] = 0.8627450980392157,
							["g"] = 0.8627450980392157,
							["r"] = 0.8627450980392157,
						},
					},
					["unit_healthDeficit"] = {
						["threshold"] = 85,
						["useClassColors"] = false,
						["priority"] = 73,
						["color"] = {
							["b"] = 0,
							["g"] = 0.8627450980392157,
							["r"] = 0,
						},
					},
					["alert_death"] = {
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
					},
					["alert_lowHealth"] = {
						["threshold"] = 50,
						["priority"] = 86,
						["color"] = {
							["b"] = 0,
							["g"] = 0,
							["r"] = 0.7843137254901961,
						},
					},
					["unit_health"] = {
						["priority"] = 61,
					},
				},
				["RealUI-Healing"] = {
					["alert_offline"] = {
						["color"] = {
							["a"] = 0,
							["b"] = 0.8627450980392157,
							["g"] = 0.8627450980392157,
							["r"] = 0.8627450980392157,
						},
					},
					["unit_healthDeficit"] = {
						["threshold"] = 85,
						["useClassColors"] = false,
						["priority"] = 73,
						["color"] = {
							["b"] = 0,
							["g"] = 0.8627450980392157,
							["r"] = 0,
						},
					},
					["alert_death"] = {
						["color"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
					},
					["alert_lowHealth"] = {
						["threshold"] = 50,
						["priority"] = 86,
						["color"] = {
							["b"] = 0,
							["g"] = 0,
							["r"] = 0.7843137254901961,
						},
					},
					["unit_health"] = {
						["priority"] = 61,
					},
				},
				["RealUI"] = {
					["alert_offline"] = {
						["color"] = {
							["a"] = 0,
							["r"] = 0.8627450980392157,
							["g"] = 0.8627450980392157,
							["b"] = 0.8627450980392157,
						},
					},
					["unit_healthDeficit"] = {
						["threshold"] = 90,
						["useClassColors"] = false,
						["priority"] = 73,
					},
					["alert_lowHealth"] = {
						["threshold"] = 30,
						["priority"] = 86,
						["color"] = {
							["b"] = 0,
							["g"] = 0,
							["r"] = 0.7843137254901961,
						},
					},
					["alert_death"] = {
						["color"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
					},
					["unit_health"] = {
						["color"] = {
							["r"] = 0.1058823529411765,
							["g"] = 0.1058823529411765,
							["b"] = 0.1058823529411765,
						},
						["useClassColors"] = false,
						["priority"] = 61,
					},
				},
			},
		},
		["GridRange"] = {
		},
		["GridFrame"] = {
			["profiles"] = {
				["RealUI-HR"] = {
					["fontSize"] = 8,
					["statusmap"] = {
						["corner2"] = {
							["alert_mt"] = true,
							["buff_Riptide"] = false,
							["alert_closeup"] = false,
							["alert_threat_graphic"] = false,
							["alert_lowMana"] = false,
							["dungeonRole"] = false,
						},
						["iconleft"] = {
							["buff_BeaconofLight"] = true,
						},
						["iconBLcornerleft"] = {
							["dungeonRole"] = false,
						},
						["iconbottom"] = {
							["buff_BeaconofLight"] = false,
							["debuff_NapalmShell"] = false,
						},
						["iconBLcornerright"] = {
						},
						["cornerPlusBRbottomleft"] = {
						},
						["icon"] = {
							["debuff_curse"] = false,
							["alert_offline"] = false,
							["debuff_NapalmShell"] = false,
							["debuff_disease"] = false,
							["debuff_magic"] = false,
							["debuff_FrostBlast"] = false,
							["debuff_FrostBolt"] = false,
							["dungeonRole"] = false,
							["ready_check"] = false,
							["debuff_Fear"] = false,
							["debuff_poison"] = false,
							["debuff_MortalStrike"] = false,
							["buff_BeaconofLight"] = false,
							["buff_HandofSacrifice"] = false,
							["alert_RaidDebuff"] = false,
							["debuff_IronRoots"] = false,
						},
						["iconTRcornerleft"] = {
						},
						["cornerPlusTLbottomright"] = {
						},
						["text"] = {
							["debuff_curse"] = false,
							["debuff_Ghost"] = false,
							["debuff_disease"] = false,
							["alert_heals"] = false,
							["alert_feignDeath"] = false,
							["unit_healthDeficit"] = false,
							["alert_offline"] = false,
							["debuff_poison"] = false,
							["alert_death"] = false,
							["debuff_magic"] = false,
						},
						["corner4"] = {
							["alert_aggro"] = false,
							["alert_heals"] = false,
						},
						["iconright"] = {
							["buff_BeaconofLight"] = false,
							["buff_HandofSacrifice"] = true,
						},
						["iconTLcornerright"] = {
							["ready_check"] = true,
						},
						["cornerPlusBLbottomright"] = {
							["dungeonRole"] = false,
						},
						["icontop"] = {
							["buff_BeaconofLight"] = false,
							["buff_HandofSacrifice"] = false,
						},
						["cornerPlusBLtopright"] = {
						},
						["text3"] = {
							["unit_name"] = false,
							["player_target"] = false,
							["unit_healthDeficit"] = false,
						},
						["border"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["debuff_disease"] = false,
							["alert_heals"] = true,
							["alert_lowMana"] = false,
							["player_target"] = false,
							["debuff_magic"] = false,
							["alert_lowHealth"] = false,
							["alert_aggro"] = true,
						},
						["iconBRcornerleft"] = {
							["buff_PowerWord:Shield"] = false,
							["alert_threat_graphic"] = false,
						},
						["iconTRcornerright"] = {
						},
						["corner1"] = {
							["ready_check"] = false,
							["alert_raidicons_playertarget"] = false,
							["alert_mt"] = false,
							["alert_closeup"] = false,
							["alert_raidicons_player"] = false,
							["alert_heals"] = false,
							["debuff_NapalmShell"] = false,
							["dungeonRole"] = true,
						},
						["corner3"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["debuff_disease"] = false,
							["buff_BeaconofLight"] = false,
							["alert_raidicons_player"] = false,
							["buff_EarthShield"] = false,
						},
						["text2"] = {
							["ready_check"] = false,
							["alert_offline"] = false,
							["unit_healthDeficit"] = true,
							["alert_heals"] = false,
							["unit_health"] = false,
						},
						["barcolor"] = {
							["alert_offline"] = false,
							["alert_death"] = false,
							["unit_healthDeficit"] = true,
							["alert_heals"] = false,
							["alert_lowMana"] = false,
						},
						["iconBRcornerright"] = {
							["debuff_IronRoots"] = true,
							["debuff_NapalmShell"] = true,
							["alert_closeup"] = false,
							["alert_RaidDebuff"] = true,
						},
						["manabar"] = {
							["unit_mana"] = true,
						},
						["cornerPlusTLbottomleft"] = {
						},
						["cornerPlusBRtopleft"] = {
						},
						["cornerPlusTLtopright"] = {
						},
						["healingBar"] = {
							["fast_health"] = true,
							["unit_name"] = false,
							["unit_healthDeficit"] = false,
							["debuff_FrostBlast"] = false,
						},
						["cornerPlusTRbottomleft"] = {
							["debuff_curse"] = true,
						},
						["cornerPlusTRbottomright"] = {
							["debuff_poison"] = true,
						},
						["frameAlpha"] = {
							["alert_offline"] = false,
							["alert_range_10"] = false,
							["alert_range_38"] = true,
							["alert_death"] = false,
							["alert_range_100"] = false,
						},
						["cornerPlusBRtopright"] = {
						},
						["cornerPlusBLtopleft"] = {
							["alert_threat_graphic"] = false,
						},
						["iconTLcornerleft"] = {
							["ready_check"] = false,
							["alert_raidicons_player"] = true,
						},
						["cornerPlusTRtopleft"] = {
							["debuff_disease"] = true,
						},
					},
					["fontOutline"] = "OUTLINE",
					["iconSize"] = 15,
					["texture"] = "Plain",
					["frameHeight"] = 28,
					["enableText2"] = true,
					["font"] = "pixel_lr_small",
					["healingBar_intensity"] = 0.6,
					["fontShadow"] = false,
					["orientation"] = "HORIZONTAL",
					["cornerSize"] = 8,
					["frameWidth"] = 66,
					["invertBarColor"] = true,
				},
				["RealUI-Healing"] = {
					["fontSize"] = 8,
					["healingBar_intensity"] = 0.6,
					["fontShadow"] = false,
					["frameHeight"] = 26,
					["cornerSize"] = 7,
					["orientation"] = "HORIZONTAL",
					["font"] = "pixel_lr_small",
					["invertBarColor"] = true,
					["statusmap"] = {
						["corner2"] = {
							["alert_mt"] = true,
							["buff_Riptide"] = false,
							["alert_closeup"] = false,
							["alert_lowMana"] = false,
							["dungeonRole"] = false,
						},
						["iconleft"] = {
							["buff_BeaconofLight"] = true,
						},
						["iconBLcornerleft"] = {
							["dungeonRole"] = false,
						},
						["iconbottom"] = {
							["buff_BeaconofLight"] = false,
							["debuff_NapalmShell"] = false,
						},
						["iconBLcornerright"] = {
						},
						["cornerPlusBRbottomleft"] = {
						},
						["icon"] = {
							["debuff_curse"] = false,
							["alert_offline"] = false,
							["debuff_NapalmShell"] = false,
							["debuff_disease"] = false,
							["debuff_magic"] = false,
							["debuff_FrostBlast"] = false,
							["debuff_FrostBolt"] = false,
							["dungeonRole"] = false,
							["ready_check"] = false,
							["debuff_Fear"] = false,
							["debuff_poison"] = false,
							["debuff_MortalStrike"] = false,
							["buff_BeaconofLight"] = false,
							["buff_HandofSacrifice"] = false,
							["alert_RaidDebuff"] = false,
							["debuff_IronRoots"] = false,
						},
						["iconTRcornerleft"] = {
						},
						["cornerPlusTLbottomright"] = {
						},
						["text"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["debuff_disease"] = false,
							["fast_health"] = true,
							["alert_heals"] = false,
							["alert_offline"] = false,
							["debuff_magic"] = false,
						},
						["corner4"] = {
							["alert_aggro"] = false,
							["alert_heals"] = false,
						},
						["iconright"] = {
							["buff_BeaconofLight"] = false,
							["buff_HandofSacrifice"] = true,
						},
						["iconTLcornerright"] = {
							["ready_check"] = true,
						},
						["cornerPlusBLbottomright"] = {
							["dungeonRole"] = true,
						},
						["icontop"] = {
							["buff_BeaconofLight"] = false,
							["buff_HandofSacrifice"] = false,
						},
						["cornerPlusBLtopright"] = {
						},
						["text3"] = {
							["unit_name"] = false,
							["player_target"] = false,
							["unit_healthDeficit"] = false,
						},
						["border"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["debuff_magic"] = false,
							["debuff_disease"] = false,
							["player_target"] = false,
							["alert_heals"] = true,
							["alert_lowMana"] = false,
							["alert_aggro"] = true,
						},
						["iconBRcornerleft"] = {
							["buff_PowerWord:Shield"] = false,
							["alert_threat_graphic"] = false,
						},
						["iconTRcornerright"] = {
						},
						["corner1"] = {
							["ready_check"] = false,
							["alert_raidicons_playertarget"] = false,
							["alert_mt"] = false,
							["alert_closeup"] = true,
							["alert_raidicons_player"] = false,
							["alert_heals"] = false,
							["debuff_NapalmShell"] = false,
							["dungeonRole"] = false,
						},
						["corner3"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["debuff_disease"] = false,
							["alert_raidicons_player"] = false,
							["buff_BeaconofLight"] = false,
							["buff_EarthShield"] = false,
						},
						["text2"] = {
							["ready_check"] = false,
							["alert_feignDeath"] = false,
							["unit_healthDeficit"] = true,
							["alert_heals"] = true,
							["dungeonRole"] = false,
							["unit_health"] = false,
						},
						["barcolor"] = {
							["alert_offline"] = false,
							["unit_healthDeficit"] = false,
							["alert_heals"] = false,
							["alert_death"] = false,
							["alert_lowMana"] = false,
						},
						["iconBRcornerright"] = {
							["debuff_IronRoots"] = true,
							["debuff_NapalmShell"] = true,
							["alert_closeup"] = false,
							["alert_RaidDebuff"] = true,
						},
						["manabar"] = {
							["unit_mana"] = true,
						},
						["cornerPlusTLbottomleft"] = {
						},
						["cornerPlusBRtopleft"] = {
						},
						["cornerPlusTLtopright"] = {
						},
						["healingBar"] = {
							["fast_health"] = true,
							["unit_name"] = false,
							["unit_healthDeficit"] = false,
							["debuff_FrostBlast"] = false,
							["unit_health"] = false,
						},
						["cornerPlusTRbottomleft"] = {
							["debuff_curse"] = true,
						},
						["cornerPlusTRbottomright"] = {
							["debuff_poison"] = true,
						},
						["frameAlpha"] = {
							["alert_offline"] = false,
							["alert_range_10"] = false,
							["alert_range_38"] = true,
							["alert_death"] = false,
							["alert_range_100"] = false,
						},
						["cornerPlusBRtopright"] = {
						},
						["cornerPlusBLtopleft"] = {
							["alert_threat_graphic"] = false,
						},
						["iconTLcornerleft"] = {
							["ready_check"] = false,
							["alert_raidicons_player"] = true,
						},
						["cornerPlusTRtopleft"] = {
							["debuff_disease"] = true,
						},
					},
					["fontOutline"] = "OUTLINE",
					["iconSize"] = 15,
					["enableBarColor"] = true,
					["frameWidth"] = 66,
					["texture"] = "Plain_Dark",
				},
				["RealUI"] = {
					["fontSize"] = 8,
					["statusmap"] = {
						["cornerPlusTLtopright"] = {
						},
						["iconleft"] = {
							["buff_BeaconofLight"] = true,
						},
						["iconBLcornerleft"] = {
							["dungeonRole"] = false,
						},
						["iconbottom"] = {
							["buff_BeaconofLight"] = false,
							["debuff_NapalmShell"] = false,
						},
						["iconBLcornerright"] = {
						},
						["cornerPlusBRbottomleft"] = {
						},
						["icon"] = {
							["debuff_FrostBolt"] = false,
							["alert_offline"] = false,
							["debuff_NapalmShell"] = false,
							["debuff_MortalStrike"] = false,
							["debuff_IronRoots"] = false,
							["debuff_FrostBlast"] = false,
							["dungeonRole"] = false,
							["alert_RaidDebuff"] = false,
							["ready_check"] = false,
							["debuff_Fear"] = false,
							["buff_HandofSacrifice"] = false,
							["debuff_curse"] = false,
							["buff_BeaconofLight"] = false,
							["debuff_poison"] = false,
							["debuff_disease"] = false,
							["debuff_magic"] = false,
						},
						["iconTRcornerleft"] = {
						},
						["cornerPlusTLbottomright"] = {
						},
						["text"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["debuff_disease"] = false,
							["alert_heals"] = false,
							["alert_offline"] = false,
							["debuff_magic"] = false,
						},
						["corner4"] = {
							["alert_aggro"] = false,
							["alert_heals"] = false,
						},
						["iconright"] = {
							["buff_BeaconofLight"] = false,
							["buff_HandofSacrifice"] = true,
						},
						["iconTLcornerright"] = {
							["ready_check"] = true,
						},
						["healingBar"] = {
							["fast_health"] = true,
							["unit_name"] = false,
							["debuff_FrostBlast"] = false,
							["unit_healthDeficit"] = false,
						},
						["icontop"] = {
							["buff_BeaconofLight"] = false,
							["buff_HandofSacrifice"] = false,
						},
						["cornerPlusBLtopright"] = {
						},
						["barcolor"] = {
							["alert_offline"] = false,
							["unit_healthDeficit"] = true,
							["alert_heals"] = false,
							["alert_lowMana"] = false,
							["alert_death"] = false,
						},
						["border"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["debuff_disease"] = false,
							["alert_heals"] = true,
							["alert_lowMana"] = false,
							["player_target"] = false,
							["alert_aggro"] = true,
							["alert_lowHealth"] = false,
							["debuff_magic"] = false,
						},
						["iconBRcornerleft"] = {
							["buff_PowerWord:Shield"] = false,
							["alert_threat_graphic"] = false,
						},
						["iconTRcornerright"] = {
						},
						["text3"] = {
							["unit_name"] = false,
							["player_target"] = false,
							["unit_healthDeficit"] = false,
						},
						["iconTLcornerleft"] = {
							["ready_check"] = false,
							["alert_raidicons_player"] = true,
						},
						["text2"] = {
							["ready_check"] = false,
							["alert_offline"] = false,
							["unit_healthDeficit"] = true,
							["alert_heals"] = false,
							["unit_health"] = false,
						},
						["corner1"] = {
							["ready_check"] = false,
							["alert_raidicons_playertarget"] = false,
							["alert_mt"] = false,
							["alert_closeup"] = false,
							["alert_raidicons_player"] = false,
							["alert_heals"] = false,
							["debuff_NapalmShell"] = false,
							["dungeonRole"] = true,
						},
						["iconBRcornerright"] = {
							["alert_RaidDebuff"] = true,
							["alert_closeup"] = false,
							["debuff_NapalmShell"] = true,
							["debuff_IronRoots"] = true,
						},
						["manabar"] = {
							["unit_mana"] = true,
						},
						["cornerPlusTLbottomleft"] = {
						},
						["cornerPlusBRtopright"] = {
						},
						["corner2"] = {
							["alert_mt"] = true,
							["buff_Riptide"] = false,
							["alert_closeup"] = false,
							["alert_threat_graphic"] = false,
							["alert_lowMana"] = false,
							["dungeonRole"] = false,
						},
						["cornerPlusBLtopleft"] = {
							["alert_threat_graphic"] = false,
						},
						["cornerPlusTRbottomleft"] = {
							["debuff_curse"] = true,
						},
						["cornerPlusTRbottomright"] = {
							["debuff_poison"] = true,
						},
						["frameAlpha"] = {
							["alert_offline"] = false,
							["alert_range_10"] = false,
							["alert_range_38"] = true,
							["alert_death"] = false,
							["alert_range_100"] = false,
						},
						["cornerPlusBRtopleft"] = {
						},
						["cornerPlusBLbottomright"] = {
							["dungeonRole"] = false,
						},
						["corner3"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["debuff_disease"] = false,
							["alert_raidicons_player"] = false,
							["buff_BeaconofLight"] = false,
							["buff_EarthShield"] = false,
						},
						["cornerPlusTRtopleft"] = {
							["debuff_disease"] = true,
						},
					},
					["fontShadow"] = false,
					["frameHeight"] = 21,
					["healingBar_intensity"] = 0.6,
					["invertBarColor"] = true,
					["orientation"] = "HORIZONTAL",
					["fontOutline"] = "OUTLINE",
					["iconSize"] = 15,
					["font"] = "pixel_lr_small",
					["frameWidth"] = 66,
					["texture"] = "Plain",
				},
				["Default"] = {
					["statusmap"] = {
						["iconTLcornerright"] = {
						},
						["cornerPlusBLbottomright"] = {
						},
						["cornerPlusBLtopright"] = {
						},
						["iconBLcornerleft"] = {
						},
						["iconBLcornerright"] = {
						},
						["iconTRcornerright"] = {
						},
						["cornerPlusBRbottomleft"] = {
						},
						["icon"] = {
							["alert_RaidDebuff"] = true,
						},
						["iconTRcornerleft"] = {
						},
						["cornerPlusTLbottomright"] = {
						},
						["manabar"] = {
							["unit_mana"] = true,
						},
						["cornerPlusTLbottomleft"] = {
						},
						["iconBRcornerleft"] = {
						},
						["cornerPlusTLtopright"] = {
						},
						["cornerPlusTRbottomright"] = {
						},
						["cornerPlusTRbottomleft"] = {
						},
						["cornerPlusBRtopright"] = {
						},
						["cornerPlusBLtopleft"] = {
						},
						["cornerPlusBRtopleft"] = {
						},
						["iconBRcornerright"] = {
						},
						["iconTLcornerleft"] = {
						},
						["cornerPlusTRtopleft"] = {
						},
					},
					["frameWidth"] = 66,
				},
				["RealUI-HR-Healing"] = {
					["fontSize"] = 8,
					["statusmap"] = {
						["cornerPlusBLtopleft"] = {
							["alert_threat_graphic"] = false,
						},
						["iconleft"] = {
							["buff_BeaconofLight"] = true,
						},
						["iconBLcornerleft"] = {
							["dungeonRole"] = false,
						},
						["iconbottom"] = {
							["buff_BeaconofLight"] = false,
							["debuff_NapalmShell"] = false,
						},
						["iconBLcornerright"] = {
						},
						["cornerPlusBRbottomleft"] = {
						},
						["icon"] = {
							["debuff_curse"] = false,
							["alert_offline"] = false,
							["debuff_NapalmShell"] = false,
							["debuff_disease"] = false,
							["debuff_magic"] = false,
							["debuff_FrostBlast"] = false,
							["debuff_IronRoots"] = false,
							["alert_RaidDebuff"] = false,
							["ready_check"] = false,
							["debuff_Fear"] = false,
							["debuff_poison"] = false,
							["debuff_FrostBolt"] = false,
							["buff_BeaconofLight"] = false,
							["debuff_MortalStrike"] = false,
							["dungeonRole"] = false,
							["buff_HandofSacrifice"] = false,
						},
						["iconTRcornerleft"] = {
						},
						["cornerPlusTLbottomright"] = {
						},
						["text"] = {
							["debuff_curse"] = false,
							["debuff_Ghost"] = false,
							["debuff_disease"] = false,
							["alert_heals"] = false,
							["fast_health"] = true,
							["unit_healthDeficit"] = false,
							["alert_offline"] = false,
							["debuff_poison"] = false,
							["alert_death"] = false,
							["debuff_magic"] = false,
						},
						["corner4"] = {
							["alert_aggro"] = false,
							["alert_heals"] = false,
						},
						["iconright"] = {
							["buff_BeaconofLight"] = false,
							["buff_HandofSacrifice"] = true,
						},
						["iconTLcornerright"] = {
							["ready_check"] = true,
						},
						["cornerPlusBLbottomright"] = {
							["dungeonRole"] = true,
						},
						["icontop"] = {
							["buff_BeaconofLight"] = false,
							["buff_HandofSacrifice"] = false,
						},
						["cornerPlusBLtopright"] = {
						},
						["text3"] = {
							["unit_name"] = false,
							["player_target"] = false,
							["unit_healthDeficit"] = false,
						},
						["border"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["alert_aggro"] = true,
							["debuff_disease"] = false,
							["player_target"] = false,
							["alert_heals"] = true,
							["alert_lowMana"] = false,
							["debuff_magic"] = false,
						},
						["iconBRcornerleft"] = {
							["buff_PowerWord:Shield"] = false,
							["alert_threat_graphic"] = false,
						},
						["iconTRcornerright"] = {
						},
						["corner2"] = {
							["alert_mt"] = true,
							["buff_Riptide"] = false,
							["alert_closeup"] = false,
							["alert_lowMana"] = false,
							["dungeonRole"] = false,
						},
						["corner3"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["debuff_disease"] = false,
							["buff_BeaconofLight"] = false,
							["alert_raidicons_player"] = false,
							["buff_EarthShield"] = false,
						},
						["text2"] = {
							["ready_check"] = false,
							["alert_feignDeath"] = false,
							["unit_healthDeficit"] = true,
							["alert_heals"] = true,
							["dungeonRole"] = false,
							["unit_health"] = false,
						},
						["corner1"] = {
							["ready_check"] = false,
							["alert_raidicons_playertarget"] = false,
							["alert_mt"] = false,
							["alert_closeup"] = true,
							["alert_raidicons_player"] = false,
							["alert_heals"] = false,
							["debuff_NapalmShell"] = false,
							["dungeonRole"] = false,
						},
						["iconBRcornerright"] = {
							["alert_RaidDebuff"] = true,
							["alert_closeup"] = false,
							["debuff_NapalmShell"] = true,
							["debuff_IronRoots"] = true,
						},
						["manabar"] = {
							["unit_mana"] = true,
						},
						["cornerPlusTLbottomleft"] = {
						},
						["cornerPlusBRtopright"] = {
						},
						["cornerPlusTLtopright"] = {
						},
						["healingBar"] = {
							["fast_health"] = true,
							["unit_name"] = false,
							["unit_healthDeficit"] = false,
							["debuff_FrostBlast"] = false,
							["unit_health"] = false,
						},
						["cornerPlusTRbottomleft"] = {
							["debuff_curse"] = true,
						},
						["barcolor"] = {
							["alert_offline"] = false,
							["unit_healthDeficit"] = false,
							["alert_heals"] = false,
							["alert_death"] = false,
							["alert_lowMana"] = false,
						},
						["frameAlpha"] = {
							["alert_offline"] = false,
							["alert_range_10"] = false,
							["alert_range_38"] = true,
							["alert_death"] = false,
							["alert_range_100"] = false,
						},
						["cornerPlusBRtopleft"] = {
						},
						["cornerPlusTRbottomright"] = {
							["debuff_poison"] = true,
						},
						["iconTLcornerleft"] = {
							["ready_check"] = false,
							["alert_raidicons_player"] = true,
						},
						["cornerPlusTRtopleft"] = {
							["debuff_disease"] = true,
						},
					},
					["texture"] = "Plain_Dark",
					["frameHeight"] = 29,
					["enableText2"] = true,
					["healingBar_intensity"] = 0.6,
					["orientation"] = "HORIZONTAL",
					["font"] = "pixel_lr_small",
					["invertBarColor"] = true,
					["cornerSize"] = 8,
					["fontOutline"] = "OUTLINE",
					["iconSize"] = 15,
					["enableBarColor"] = true,
					["frameWidth"] = 66,
					["fontShadow"] = false,
				},
			},
		},
		["GridStatusName"] = {
			["profiles"] = {
				["RealUI-HR-Healing"] = {
					["unit_name"] = {
						["class"] = false,
					},
				},
				["RealUI-Healing"] = {
					["unit_name"] = {
						["class"] = false,
					},
				},
			},
		},
	},
	["profiles"] = {
		["RealUI-HR"] = {
			["showText"] = false,
			["detachedTooltip"] = {
				["fontSizePercent"] = 1,
			},
			["hidden"] = true,
			["minimap"] = {
				["hide"] = true,
			},
		},
		["RealUI-Healing"] = {
			["hidden"] = true,
			["detachedTooltip"] = {
				["fontSizePercent"] = 1,
			},
			["showText"] = false,
			["minimap"] = {
				["hide"] = true,
			},
		},
		["RealUI"] = {
			["hidden"] = true,
			["detachedTooltip"] = {
				["fontSizePercent"] = 1,
			},
			["showText"] = false,
			["minimap"] = {
				["hide"] = true,
			},
		},
		["Default"] = {
			["minimap"] = {
			},
		},
		["RealUI-HR-Healing"] = {
			["hidden"] = true,
			["detachedTooltip"] = {
				["fontSizePercent"] = 1,
			},
			["showText"] = false,
			["minimap"] = {
				["hide"] = true,
			},
		},
	},
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI-HR",
	},
	["currentProfile"] = {
		["Real - Zul'jin"] = "RealUI",
	},
}






-----------------
---- Mapster ----
-----------------
MapsterDB = {
	["namespaces"] = {
		["InstanceMaps"] = {
			["profileKeys"] = {
			},
			["profiles"] = {
				["Default"] = {
				},
			},
		},
		["BattleMap"] = {
		},
		["GroupIcons"] = {
		},
		["Coords"] = {
		},
		["FogClear"] = {
		},
	},
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI",
	},
	["profiles"] = {
		["RealUI"] = {
			["point"] = "CENTER",
			["scale"] = 1,
			["y"] = 20,
			["x"] = 0,
		},
		["Default"] = {
			["scale"] = 1,
			["point"] = "TOP",
			["y"] = -50,
		},
	},
}






----------------
---- Masque ----
----------------

MasqueDB = {
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI",
	},
	["profiles"] = {
		["Default"] = {
			["Groups"] = {
				["Bartender4_StanceBar"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Bartender4_Vehicle"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Bartender4_1"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Bartender4_3"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Raven_NestIcons"] = {
					["Fonts"] = true,
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Bartender4_2"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Bartender4_BagBar"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Inherit"] = false,
				},
				["Bartender4_4"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Raven"] = {
					["Fonts"] = true,
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Bartender4_10"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Inherit"] = false,
				},
				["Bartender4_9"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Inherit"] = false,
				},
				["Bartender4_5"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Bartender4"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Bartender4_MicroMenu"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Inherit"] = false,
				},
				["Masque"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Bartender4_PetBar"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Bartender4_8"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Inherit"] = false,
				},
				["Bartender4_7"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Inherit"] = false,
				},
				["Bartender4_6"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Inherit"] = false,
				},
			},
		},
		["RealUI"] = {
			["Groups"] = {
				["Raven_FocusBuffs"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Raven_PlayerBuffsExtra"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Bartender4_StanceBar"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Raven_TargetBuffsExtraPvP"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Raven_TargetBuffsExtra2"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Bartender4_1"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Backdrop"] = true,
				},
				["Bartender4_3"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Backdrop"] = true,
				},
				["Raven_TargetBuffsExtra"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["SBF"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Raven_FocusBuffsExtra"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Raven_Buffs"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Bartender4_5"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Backdrop"] = true,
				},
				["Bartender4_MicroMenu"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Inherit"] = false,
				},
				["SBF_TargetDebuffs"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["SBF_PlayerDebuffs"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["SBF_Buffs"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Bartender4_6"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Backdrop"] = true,
				},
				["SBF_ToTDebuffs"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Raven_TargetBuffs"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Bartender4_Vehicle"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Backdrop"] = true,
				},
				["SBF_PlayerBuffs"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["SBF_PetBuffs"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Raven_PlayerDebuffs"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Raven_ToTDebuffs"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["SBF_TargetBuffsMy"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Bartender4_BagBar"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Inherit"] = false,
				},
				["SBF_Debuffs"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Inherit"] = false,
				},
				["Raven"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Inherit"] = false,
				},
				["Raven_TargetDebuffs"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Raven_TargetDebuffsExtra"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Bartender4_PetBar"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Backdrop"] = true,
				},
				["Bartender4"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Backdrop"] = true,
				},
				["Raven_FocusDebuffs"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["SBF_FocusDebuffs"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Bartender4_4"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Backdrop"] = true,
				},
				["Raven_PlayerBuffs"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Raven_NestIcons"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Inherit"] = false,
				},
				["Bartender4_2"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Backdrop"] = true,
				},
				["SBF_FocusBuffs"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
				},
				["Raven_ToTDebuffsExtra"] = {
					["Inherit"] = false,
					["SkinID"] = "RealUI",
				},
				["Masque"] = {
					["Fonts"] = true,
					["SkinID"] = "RealUI",
					["Backdrop"] = true,
				},
			},
		},
	},
}






--------------
---- MSBT ----
--------------

MSBTProfiles_SavedVars = {
	["profiles"] = {
		["RealUI"] = {
			["critFontName"] = "pixel_lr_large",
			["stickyCritsDisabled"] = true,
			["animationSpeed"] = 70,
			["triggers"] = {
				["MSBT_TRIGGER_LOW_HEALTH"] = {
					["mainEvents"] = "UNIT_HEALTH{unitID;;eq;;player;;threshold;;lt;;25}",
					["iconSkill"] = "3273",
					["disabled"] = true,
					["soundFile"] = "Omen: Aoogah!",
				},
				["Custom2"] = {
					["message"] = "New Trigger",
					["alwaysSticky"] = true,
				},
				["MSBT_TRIGGER_LOCK_AND_LOAD"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_TIDAL_WAVES"] = {
					["disabled"] = true,
				},
				["Custom1"] = {
					["message"] = "New Trigger",
					["alwaysSticky"] = true,
				},
				["MSBT_TRIGGER_MAELSTROM_WEAPON"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_NIGHTFALL"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SWORD_AND_BOARD"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LAVA_SURGE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SUDDEN_DEATH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHADOW_ORB"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_BLOODSURGE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHOOTING_STARS"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LOW_PET_HEALTH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_MOLTEN_CORE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_ECLIPSE_SOLAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_BRAIN_FREEZE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_RIME"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHADOW_INFUSION"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_CLEARCASTING"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_THE_ART_OF_WAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_ECLIPSE_LUNAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_IMPACT"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_HOT_STREAK"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_KILLING_MACHINE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_VICTORY_RUSH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LOW_MANA"] = {
					["mainEvents"] = "UNIT_MANA{unitID;;eq;;player;;threshold;;lt;;25}",
					["disabled"] = true,
				},
				["MSBT_TRIGGER_TASTE_FOR_BLOOD"] = {
					["disabled"] = true,
				},
			},
			["textShadowingDisabled"] = true,
			["creationVersion"] = "5.4.78",
			["critFontSize"] = 8,
			["normalOutlineIndex"] = 5,
			["events"] = {
				["NOTIFICATION_PC_KILLING_BLOW"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONEY"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_ITEM_BUFF_FADE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_LOSS"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_SKILL_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_LOOT"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_SOUL_SHARD_CREATED"] = {
					["alwaysSticky"] = false,
				},
				["INCOMING_HEAL_CRIT"] = {
					["fontSize"] = false,
				},
				["NOTIFICATION_POWER_LOSS"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HOLY_POWER_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONSTER_EMOTE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_ITEM_BUFF"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_POWER_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF_STACK"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_CP_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_EXTRA_ATTACK"] = {
					["alwaysSticky"] = false,
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF_FADE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HOLY_POWER_CHANGE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_CP_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_COOLDOWN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HONOR_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_PET_COOLDOWN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_GAIN"] = {
					["disabled"] = true,
				},
			},
			["hideFullOverheals"] = true,
			["scrollAreas"] = {
				["Outgoing"] = {
					["direction"] = "Up",
					["behavior"] = "MSBT_NORMAL",
					["stickyDirection"] = "Up",
					["scrollHeight"] = 150,
					["offsetX"] = 166,
					["stickyBehavior"] = "MSBT_NORMAL",
					["scrollWidth"] = 130,
					["offsetY"] = 10,
					["animationStyle"] = "Straight",
					["stickyAnimationStyle"] = "Static",
				},
				["Notification"] = {
					["direction"] = "Up",
					["critFontSize"] = 16,
					["scrollHeight"] = 100,
					["offsetX"] = -150,
					["stickyAnimationStyle"] = "Static",
					["stickyDirection"] = "Up",
					["offsetY"] = 60,
					["scrollWidth"] = 300,
					["normalFontSize"] = 16,
				},
				["Static"] = {
					["disabled"] = true,
					["offsetY"] = -65,
				},
				["Incoming"] = {
					["direction"] = "Up",
					["behavior"] = "MSBT_NORMAL",
					["stickyDirection"] = "Up",
					["scrollWidth"] = 130,
					["offsetX"] = -296,
					["scrollHeight"] = 150,
					["stickyBehavior"] = "MSBT_NORMAL",
					["offsetY"] = 10,
					["animationStyle"] = "Straight",
					["stickyAnimationStyle"] = "Static",
				},
			},
			["normalFontName"] = "pixel_lr_small",
			["critOutlineIndex"] = 5,
			["normalFontSize"] = 8,
		},
		["Default"] = {
			["critFontName"] = "pixel_lr_large",
			["stickyCritsDisabled"] = true,
			["animationSpeed"] = 70,
			["triggers"] = {
				["MSBT_TRIGGER_LOW_HEALTH"] = {
					["mainEvents"] = "UNIT_HEALTH{unitID;;eq;;player;;threshold;;lt;;25}",
					["iconSkill"] = "3273",
					["disabled"] = true,
					["soundFile"] = "Omen: Aoogah!",
				},
				["Custom2"] = {
					["message"] = "New Trigger",
					["alwaysSticky"] = true,
				},
				["MSBT_TRIGGER_LOCK_AND_LOAD"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_TIDAL_WAVES"] = {
					["disabled"] = true,
				},
				["Custom1"] = {
					["message"] = "New Trigger",
					["alwaysSticky"] = true,
				},
				["MSBT_TRIGGER_MAELSTROM_WEAPON"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_NIGHTFALL"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SWORD_AND_BOARD"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LAVA_SURGE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SUDDEN_DEATH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHADOW_ORB"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_BLOODSURGE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHOOTING_STARS"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LOW_PET_HEALTH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_MOLTEN_CORE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_ECLIPSE_SOLAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_BRAIN_FREEZE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_RIME"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHADOW_INFUSION"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_CLEARCASTING"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_THE_ART_OF_WAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_ECLIPSE_LUNAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_IMPACT"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_HOT_STREAK"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_KILLING_MACHINE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_VICTORY_RUSH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LOW_MANA"] = {
					["mainEvents"] = "UNIT_MANA{unitID;;eq;;player;;threshold;;lt;;25}",
					["disabled"] = true,
				},
				["MSBT_TRIGGER_TASTE_FOR_BLOOD"] = {
					["disabled"] = true,
				},
			},
			["textShadowingDisabled"] = true,
			["creationVersion"] = "5.4.78",
			["critFontSize"] = 8,
			["normalOutlineIndex"] = 5,
			["events"] = {
				["NOTIFICATION_PC_KILLING_BLOW"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONEY"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_ITEM_BUFF_FADE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_LOSS"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_SKILL_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_LOOT"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_SOUL_SHARD_CREATED"] = {
					["alwaysSticky"] = false,
				},
				["INCOMING_HEAL_CRIT"] = {
					["fontSize"] = false,
				},
				["NOTIFICATION_POWER_LOSS"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HOLY_POWER_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONSTER_EMOTE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_ITEM_BUFF"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_POWER_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF_STACK"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_CP_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_EXTRA_ATTACK"] = {
					["alwaysSticky"] = false,
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF_FADE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HOLY_POWER_CHANGE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_CP_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_COOLDOWN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HONOR_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_PET_COOLDOWN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_GAIN"] = {
					["disabled"] = true,
				},
			},
			["hideFullOverheals"] = true,
			["scrollAreas"] = {
				["Outgoing"] = {
					["direction"] = "Up",
					["stickyBehavior"] = "MSBT_NORMAL",
					["stickyDirection"] = "Up",
					["scrollHeight"] = 150,
					["offsetX"] = 166,
					["scrollWidth"] = 130,
					["behavior"] = "MSBT_NORMAL",
					["offsetY"] = 10,
					["animationStyle"] = "Straight",
					["stickyAnimationStyle"] = "Static",
				},
				["Notification"] = {
					["direction"] = "Up",
					["stickyDirection"] = "Up",
					["scrollWidth"] = 300,
					["offsetX"] = -150,
					["stickyAnimationStyle"] = "Static",
					["scrollHeight"] = 100,
					["offsetY"] = 60,
					["critFontSize"] = 16,
					["normalFontSize"] = 16,
				},
				["Static"] = {
					["disabled"] = true,
					["offsetY"] = -65,
				},
				["Incoming"] = {
					["direction"] = "Up",
					["behavior"] = "MSBT_NORMAL",
					["stickyDirection"] = "Up",
					["scrollHeight"] = 150,
					["offsetX"] = -296,
					["stickyBehavior"] = "MSBT_NORMAL",
					["scrollWidth"] = 130,
					["offsetY"] = 10,
					["animationStyle"] = "Straight",
					["stickyAnimationStyle"] = "Static",
				},
			},
			["normalFontName"] = "pixel_lr_small",
			["critOutlineIndex"] = 5,
			["normalFontSize"] = 8,
		},
		["RealUI-HR"] = {
			["critFontName"] = "pixel_hr_large",
			["stickyCritsDisabled"] = true,
			["animationSpeed"] = 70,
			["normalFontSize"] = 8,
			["textShadowingDisabled"] = true,
			["creationVersion"] = "5.4.78",
			["critFontSize"] = 8,
			["critOutlineIndex"] = 5,
			["events"] = {
				["NOTIFICATION_PC_KILLING_BLOW"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HONOR_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_ITEM_BUFF_FADE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_LOSS"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_PET_COOLDOWN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_LOOT"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_SOUL_SHARD_CREATED"] = {
					["alwaysSticky"] = false,
				},
				["INCOMING_HEAL_CRIT"] = {
					["fontSize"] = false,
				},
				["NOTIFICATION_POWER_LOSS"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HOLY_POWER_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONSTER_EMOTE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_POWER_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_SKILL_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONEY"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF_STACK"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_EXTRA_ATTACK"] = {
					["alwaysSticky"] = false,
					["disabled"] = true,
				},
				["NOTIFICATION_COOLDOWN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HOLY_POWER_CHANGE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_CP_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF_FADE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_CP_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_ITEM_BUFF"] = {
					["disabled"] = true,
				},
			},
			["hideFullOverheals"] = true,
			["scrollAreas"] = {
				["Incoming"] = {
					["direction"] = "Up",
					["stickyBehavior"] = "MSBT_NORMAL",
					["stickyDirection"] = "Up",
					["scrollWidth"] = 130,
					["offsetX"] = -316,
					["scrollHeight"] = 150,
					["behavior"] = "MSBT_NORMAL",
					["offsetY"] = 10,
					["animationStyle"] = "Straight",
					["stickyAnimationStyle"] = "Static",
				},
				["Outgoing"] = {
					["direction"] = "Up",
					["stickyBehavior"] = "MSBT_NORMAL",
					["stickyDirection"] = "Up",
					["scrollWidth"] = 130,
					["offsetX"] = 186,
					["scrollHeight"] = 150,
					["behavior"] = "MSBT_NORMAL",
					["offsetY"] = 10,
					["animationStyle"] = "Straight",
					["stickyAnimationStyle"] = "Static",
				},
				["Static"] = {
					["disabled"] = true,
					["offsetY"] = -65,
				},
				["Notification"] = {
					["direction"] = "Up",
					["critFontSize"] = 16,
					["scrollWidth"] = 300,
					["offsetX"] = -150,
					["normalFontSize"] = 16,
					["scrollHeight"] = 100,
					["offsetY"] = 60,
					["stickyDirection"] = "Up",
					["stickyAnimationStyle"] = "Static",
				},
			},
			["normalFontName"] = "pixel_hr_small",
			["normalOutlineIndex"] = 5,
			["triggers"] = {
				["MSBT_TRIGGER_LOW_HEALTH"] = {
					["soundFile"] = "Omen: Aoogah!",
					["iconSkill"] = "3273",
					["mainEvents"] = "UNIT_HEALTH{unitID;;eq;;player;;threshold;;lt;;25}",
					["disabled"] = true,
				},
				["Custom2"] = {
					["message"] = "New Trigger",
					["alwaysSticky"] = true,
				},
				["MSBT_TRIGGER_LOCK_AND_LOAD"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_TIDAL_WAVES"] = {
					["disabled"] = true,
				},
				["Custom1"] = {
					["message"] = "New Trigger",
					["alwaysSticky"] = true,
				},
				["MSBT_TRIGGER_MAELSTROM_WEAPON"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_NIGHTFALL"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SWORD_AND_BOARD"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LAVA_SURGE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SUDDEN_DEATH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHADOW_ORB"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_BLOODSURGE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHOOTING_STARS"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LOW_PET_HEALTH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_MOLTEN_CORE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_ECLIPSE_SOLAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LOW_MANA"] = {
					["mainEvents"] = "UNIT_MANA{unitID;;eq;;player;;threshold;;lt;;25}",
					["disabled"] = true,
				},
				["MSBT_TRIGGER_RIME"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHADOW_INFUSION"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_CLEARCASTING"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_VICTORY_RUSH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_KILLING_MACHINE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_HOT_STREAK"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_IMPACT"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_ECLIPSE_LUNAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_THE_ART_OF_WAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_BRAIN_FREEZE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_TASTE_FOR_BLOOD"] = {
					["disabled"] = true,
				},
			},
		},
	},
}
MSBT_SavedMedia = {
	["fonts"] = {
	},
	["sounds"] = {
	},
}






-------------------
---- nibIceHUD ----
-------------------

IceCoreRealUIDB = {
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI-HR",
	},
	["currentProfile"] = {
		["Real - Zul'jin"] = "RealUI",
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["global"] = {
		["lastRunVersion"] = 829,
	},
	["profiles"] = {
		["RealUI"] = {
			["alphaTarget"] = 0.7000000000000001,
			["scale"] = 1,
			["minimap"] = {
				["hide"] = true,
			},
			["modules"] = {
				["zCT-Sha-FrostShock"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.2352941176470588,
						["b"] = 0.9411764705882353,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Fr",
					["lowerText"] = "",
					["forceJustifyText"] = "RIGHT",
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barFontSize"] = 8,
					["textVerticalOffset"] = 21,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["enabled"] = true,
					["buffTimerDisplay"] = "seconds",
					["barVerticalOffset"] = 39,
					["scale"] = 0.715,
					["side"] = "RIGHT",
					["buffToTrack"] = "8056",
					["exactMatch"] = true,
					["textHorizontalOffset"] = 0,
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["buffOrDebuff"] = "debuff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = -12,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["class"] = "SHAMAN",
				},
				["zCT-Rog-FindWeakness"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
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
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 20,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["scale"] = 0.715,
					["barVerticalOffset"] = 39,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "91023",
					["auraIconXOffset"] = 40,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -28,
					["textHorizontalOffset"] = 5,
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["enabled"] = true,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["class"] = "ROGUE",
				},
				["TargetCast"] = {
					["barVerticalOffset"] = 15,
					["forceJustifyText"] = "LEFT",
					["textHorizontalOffset"] = 8,
					["lockLowerTextAlpha"] = true,
					["barHorizontalOffset"] = 4,
					["auraIconXOffset"] = -128.5,
					["barFontSize"] = 8,
					["auraIconYOffset"] = -29,
					["textVerticalOffset"] = 0,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["scale"] = 0.85,
					["displayAuraIcon"] = true,
				},
				["RogueExtras1"] = {
					["barVerticalOffset"] = 15,
					["scale"] = 0.85,
					["textHorizontalOffset"] = -6,
					["displayAuraIcon"] = true,
					["auraIconXOffset"] = 24,
					["barHorizontalOffset"] = -4,
					["auraIconYOffset"] = -29,
					["forceJustifyText"] = "RIGHT",
					["offset"] = 2,
					["myTagVersion"] = 3,
					["auraIconSize"] = 28,
					["lockLowerTextAlpha"] = true,
				},
				["zCT-Dru-Lacerate"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
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
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "La",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = true,
						["spec2"] = true,
					},
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["barHorizontalOffset"] = -4,
					["myTagVersion"] = 3,
					["buffOrDebuff"] = "debuff",
					["offset"] = 2,
					["barVerticalOffset"] = 33,
					["textVerticalOffset"] = 12,
					["side"] = "RIGHT",
					["buffToTrack"] = "33745",
					["scale"] = 0.745,
					["textHorizontalOffset"] = -1,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["lowerText"] = "",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["class"] = "DRUID",
				},
				["zCT-Mon-SerpentsZeal"] = {
					["class"] = "MONK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.4588235294117647,
						["g"] = 1,
						["r"] = 0.3490196078431372,
					},
					["barHorizontalOffset"] = -3,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "SZ",
					["lowerText"] = "",
					["forceJustifyText"] = "LEFT",
					["textVerticalOffset"] = 4,
					["myTagVersion"] = 3,
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
					["barVerticalOffset"] = 27.5,
					["bAllowExpand"] = true,
					["side"] = "LEFT",
					["lowThreshold"] = 0,
					["buffOrDebuff"] = "buff",
					["textHorizontalOffset"] = 1,
					["scale"] = 0.775,
					["widthModifier"] = -16,
					["lockUpperTextAlpha"] = true,
					["enabled"] = true,
					["lowerTextVisible"] = false,
					["buffToTrack"] = "127722",
					["textVisible"] = {
						["lower"] = true,
						["upper"] = true,
					},
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["buffTimerDisplay"] = "minutes",
				},
				["zCT-Wlock-UAffliction"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.6862745098039216,
						["g"] = 0.09803921568627451,
						["b"] = 1,
					},
					["barHorizontalOffset"] = -4,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "UA",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "debuff",
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 12,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["auraIconXOffset"] = 40,
					["lowerText"] = "",
					["barVerticalOffset"] = 33,
					["scale"] = 0.745,
					["side"] = "RIGHT",
					["buffToTrack"] = "30108",
					["exactMatch"] = true,
					["textHorizontalOffset"] = -11,
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["forceJustifyText"] = "RIGHT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["class"] = "WARLOCK",
				},
				["PlayerMana"] = {
					["enabled"] = true,
					["myTagVersion"] = 3,
				},
				["zCT-Rog-Recuperate"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.5529411764705883,
						["g"] = 1,
						["r"] = 0,
					},
					["barHorizontalOffset"] = 13,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "R",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "buff",
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 20,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["scale"] = 0.715,
					["barVerticalOffset"] = 39,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "73651",
					["auraIconXOffset"] = 40,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -28,
					["textHorizontalOffset"] = 5,
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["enabled"] = true,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["class"] = "ROGUE",
				},
				["zCT-DK-FrostFever"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["spec"] = {
						["spec3"] = true,
						["spec4"] = false,
						["spec1"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.6588235294117647,
						["r"] = 0.2,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "FF",
					["lowerText"] = "",
					["scale"] = 0.775,
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["offset"] = 2,
					["class"] = "DEATHKNIGHT",
					["barVerticalOffset"] = 27.5,
					["buffOrDebuff"] = "debuff",
					["side"] = "RIGHT",
					["buffToTrack"] = "59921",
					["buffTimerDisplay"] = "seconds",
					["textHorizontalOffset"] = -1,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textVerticalOffset"] = 5,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["forceJustifyText"] = "RIGHT",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["barHorizontalOffset"] = 3,
				},
				["zCT-Hun-BlackArrow"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.5686274509803921,
						["g"] = 0.1490196078431373,
						["r"] = 0.403921568627451,
					},
					["barHorizontalOffset"] = -4,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "BA",
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
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["scale"] = 0.745,
					["class"] = "HUNTER",
					["barVerticalOffset"] = 33,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "3674",
					["textVerticalOffset"] = 14,
					["textHorizontalOffset"] = 1,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["forceJustifyText"] = "RIGHT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
				},
				["zCT-DK-FrostFever(Blood)"] = {
					["shouldAnimate"] = false,
					["class"] = "DEATHKNIGHT",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["spec"] = {
						["spec3"] = false,
						["spec4"] = false,
						["spec1"] = true,
						["spec2"] = false,
					},
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.2,
						["g"] = 0.6588235294117647,
						["b"] = 1,
					},
					["barHorizontalOffset"] = -11,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "FF",
					["lowerText"] = "",
					["forceJustifyText"] = "RIGHT",
					["scaleManaColor"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["auraIconXOffset"] = 40,
					["myTagVersion"] = 3,
					["buffOrDebuff"] = "debuff",
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 39,
					["buffTimerDisplay"] = "seconds",
					["side"] = "RIGHT",
					["buffToTrack"] = "59921",
					["scale"] = 0.715,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -28,
					["textHorizontalOffset"] = 5,
					["textVerticalOffset"] = 20,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["offset"] = 2,
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
				},
				["zCT-Mag-Pyroblast"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.2705882352941176,
						["r"] = 1,
					},
					["barHorizontalOffset"] = -11,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "PB",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["textVerticalOffset"] = 20,
					["myTagVersion"] = 3,
					["buffOrDebuff"] = "debuff",
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["barVerticalOffset"] = 39,
					["scale"] = 0.715,
					["side"] = "RIGHT",
					["buffToTrack"] = "11366",
					["textHorizontalOffset"] = -5,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["lowerText"] = "",
					["offset"] = 2,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "MAGE",
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["RogueExtras2"] = {
					["barVerticalOffset"] = 32,
					["scale"] = 0.75,
					["textHorizontalOffset"] = -16,
					["barHorizontalOffset"] = -12,
					["widthModifier"] = -16,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 4,
					["forceJustifyText"] = "RIGHT",
					["myTagVersion"] = 3,
					["offset"] = 3,
					["textVisible"] = {
						["lower"] = false,
					},
				},
				["zCT-Mon-DizzyingHaze"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.1607843137254902,
						["g"] = 0.6196078431372549,
						["r"] = 0.8666666666666667,
					},
					["barHorizontalOffset"] = -4,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "DH",
					["lowerText"] = "",
					["forceJustifyText"] = "RIGHT",
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["auraIconXOffset"] = 40,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["class"] = "MONK",
					["barVerticalOffset"] = 33,
					["buffOrDebuff"] = "debuff",
					["side"] = "RIGHT",
					["buffToTrack"] = "115180",
					["scale"] = 0.745,
					["textHorizontalOffset"] = 1,
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["textVerticalOffset"] = 14,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
				},
				["zCT-DK-BloodPlague"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.7843137254901961,
						["g"] = 0.196078431372549,
						["b"] = 0.196078431372549,
					},
					["barHorizontalOffset"] = -4,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "BP",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["scale"] = 0.745,
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["forceJustifyText"] = "RIGHT",
					["barVerticalOffset"] = 33,
					["buffTimerDisplay"] = "seconds",
					["side"] = "RIGHT",
					["buffToTrack"] = "59879",
					["textVerticalOffset"] = 12,
					["textHorizontalOffset"] = -1,
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["enabled"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "DEATHKNIGHT",
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec4"] = false,
						["spec1"] = true,
						["spec2"] = true,
					},
				},
				["zCT-Rog-Hemorrhage"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.3490196078431372,
						["r"] = 1,
					},
					["barHorizontalOffset"] = -4,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "H",
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
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 12,
					["exactMatch"] = true,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["scale"] = 0.74,
					["barVerticalOffset"] = 33.5,
					["auraIconXOffset"] = 40,
					["side"] = "RIGHT",
					["buffToTrack"] = "16511",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = 0,
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["forceJustifyText"] = "RIGHT",
					["lowerText"] = "",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "ROGUE",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Dru-Harmony"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.2627450980392157,
						["g"] = 0.8745098039215686,
						["r"] = 0.6901960784313725,
					},
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "H",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "buff",
					["barHorizontalOffset"] = -3,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 4,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["auraIconXOffset"] = 40,
					["lowerText"] = "",
					["barVerticalOffset"] = 27.5,
					["scale"] = 0.775,
					["side"] = "LEFT",
					["buffToTrack"] = "100977",
					["exactMatch"] = true,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textHorizontalOffset"] = 16,
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "DRUID",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = true,
						["spec2"] = false,
					},
				},
				["CastBar"] = {
					["offset"] = 2,
					["barHorizontalOffset"] = -4,
					["scale"] = 0.85,
					["textHorizontalOffset"] = -6,
					["displayAuraIcon"] = true,
					["auraIconXOffset"] = 24,
					["barFontSize"] = 8,
					["lagAlpha"] = 0.6000000000000001,
					["auraIconYOffset"] = -29,
					["textVerticalOffset"] = 0,
					["forceJustifyText"] = "RIGHT",
					["myTagVersion"] = 3,
					["markers"] = {
						{
							["height"] = 1,
						}, -- [1]
						{
							["height"] = 1,
						}, -- [2]
						{
							["height"] = 1,
						}, -- [3]
					},
					["barVerticalOffset"] = 15,
				},
				["zCT-Pri-DevPlague"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.2,
						["r"] = 0.2941176470588235,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "DP",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["barHorizontalOffset"] = -11,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["textVerticalOffset"] = 21,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "RIGHT",
					["auraIconXOffset"] = 40,
					["barVerticalOffset"] = 39,
					["scale"] = 0.715,
					["side"] = "RIGHT",
					["buffToTrack"] = "2944",
					["textHorizontalOffset"] = -7,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["buffTimerDisplay"] = "seconds",
					["offset"] = 2,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "PRIEST",
					["barFontSize"] = 8,
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
				},
				["zCT-Mag-Pyroblast!"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.2705882352941176,
						["b"] = 0,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "PB",
					["lowerText"] = "",
					["forceJustifyText"] = "RIGHT",
					["enabled"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 20,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["barHorizontalOffset"] = -11,
					["buffTimerDisplay"] = "seconds",
					["barVerticalOffset"] = 39,
					["exactMatch"] = true,
					["side"] = "RIGHT",
					["buffToTrack"] = "92315",
					["textHorizontalOffset"] = -5,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -28,
					["buffOrDebuff"] = "debuff",
					["scale"] = 0.715,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "MAGE",
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-War-Hamstring"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.392156862745098,
						["r"] = 1,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "H",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["textVerticalOffset"] = 12,
					["myTagVersion"] = 3,
					["buffOrDebuff"] = "debuff",
					["barHorizontalOffset"] = -5,
					["barVerticalOffset"] = 33,
					["scale"] = 0.745,
					["side"] = "RIGHT",
					["buffToTrack"] = "1715",
					["textHorizontalOffset"] = 0,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["lowerText"] = "",
					["enabled"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "WARRIOR",
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["Runes"] = {
					["barVerticalOffset"] = -2,
					["enabled"] = true,
					["alwaysFullAlpha"] = true,
					["reverse"] = true,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["markers"] = {
						{
							["color"] = {
								["a"] = 1,
								["b"] = 0,
								["g"] = 0,
								["r"] = 0,
							},
							["height"] = 1,
							["position"] = 0.83,
						}, -- [1]
						{
							["color"] = {
								["a"] = 1,
								["b"] = 0,
								["g"] = 0,
								["r"] = 0,
							},
							["height"] = 1,
							["position"] = 0.67,
						}, -- [2]
						{
							["color"] = {
								["a"] = 1,
								["b"] = 0,
								["g"] = 0,
								["r"] = 0,
							},
							["height"] = 1,
							["position"] = 0.5,
						}, -- [3]
						{
							["color"] = {
								["a"] = 1,
								["b"] = 0,
								["g"] = 0,
								["r"] = 0,
							},
							["height"] = 1,
							["position"] = 0.33,
						}, -- [4]
						{
							["color"] = {
								["a"] = 1,
								["b"] = 0,
								["g"] = 0,
								["r"] = 0,
							},
							["height"] = 1,
							["position"] = 0.17,
						}, -- [5]
					},
					["barHorizontalOffset"] = 12,
				},
				["zCT-Rog-Recuperate-Sub"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
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
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["lowerText"] = "",
					["buffOrDebuff"] = "buff",
					["barVerticalOffset"] = 33,
					["scale"] = 0.745,
					["side"] = "LEFT",
					["buffToTrack"] = "73651",
					["textVerticalOffset"] = 12,
					["textHorizontalOffset"] = 12,
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["auraIconXOffset"] = 40,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["enabled"] = true,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["class"] = "ROGUE",
				},
				["zCT-Mon-RisingSunKick"] = {
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
				},
				["zCT-Pri-Evangelism"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.8627450980392157,
						["g"] = 0.8627450980392157,
						["b"] = 0.8627450980392157,
					},
					["barHorizontalOffset"] = 5,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Ev",
					["lowerText"] = "",
					["scale"] = 0.745,
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 12,
					["buffTimerDisplay"] = "seconds",
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["buffOrDebuff"] = "buff",
					["barVerticalOffset"] = 33,
					["forceJustifyText"] = "LEFT",
					["side"] = "LEFT",
					["buffToTrack"] = "81661",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["textHorizontalOffset"] = 9,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["exactMatch"] = true,
					["enabled"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "PRIEST",
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
				},
				["zCT-Pri-EmpoweredShadow"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.5333333333333333,
						["g"] = 0.4156862745098039,
						["b"] = 0.9215686274509803,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "ES",
					["lowerText"] = "",
					["forceJustifyText"] = "LEFT",
					["barHorizontalOffset"] = 5,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 12,
					["buffTimerDisplay"] = "seconds",
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["offset"] = 2,
					["barVerticalOffset"] = 33,
					["buffOrDebuff"] = "buff",
					["side"] = "LEFT",
					["buffToTrack"] = "95799",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["textHorizontalOffset"] = 9,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["exactMatch"] = true,
					["scale"] = 0.745,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "PRIEST",
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
				},
				["MirrorBarHandler"] = {
					["barVerticalOffset"] = -5,
					["textVerticalOffset"] = -20,
					["textHorizontalOffset"] = -24,
					["enabled"] = true,
					["barFontSize"] = 8,
				},
				["zCT-Wlock-Corruption"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.8823529411764706,
						["g"] = 0,
						["b"] = 0.9764705882352941,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "C",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.775,
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["lowerText"] = "",
					["myTagVersion"] = 3,
					["barHorizontalOffset"] = 3,
					["offset"] = 2,
					["barVerticalOffset"] = 27.5,
					["forceJustifyText"] = "RIGHT",
					["side"] = "RIGHT",
					["buffToTrack"] = "172",
					["textVerticalOffset"] = 4,
					["textHorizontalOffset"] = -24,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["buffOrDebuff"] = "debuff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "WARLOCK",
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Mag-ArcaneBlast"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "AB",
					["lowerText"] = "",
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
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["buffTimerDisplay"] = "seconds",
					["barHorizontalOffset"] = -3,
					["barVerticalOffset"] = 27.5,
					["textVerticalOffset"] = 4,
					["side"] = "LEFT",
					["buffToTrack"] = "36032",
					["scale"] = 0.775,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textHorizontalOffset"] = 1,
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "MAGE",
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
				},
				["zCT-Pri-SWP"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.9215686274509803,
						["g"] = 0.4156862745098039,
						["r"] = 0.5333333333333333,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "SWP",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["barHorizontalOffset"] = -4,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["textVerticalOffset"] = 12,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "RIGHT",
					["auraIconXOffset"] = 40,
					["barVerticalOffset"] = 33,
					["scale"] = 0.745,
					["side"] = "RIGHT",
					["buffToTrack"] = "589",
					["textHorizontalOffset"] = -6,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["buffTimerDisplay"] = "seconds",
					["offset"] = 2,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "PRIEST",
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Dru-Sunfire"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.05882352941176471,
						["g"] = 0.6431372549019607,
						["r"] = 0.8666666666666667,
					},
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Sf",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
					["barHorizontalOffset"] = -4,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["auraIconXOffset"] = 40,
					["buffOrDebuff"] = "debuff",
					["barVerticalOffset"] = 33,
					["scale"] = 0.745,
					["side"] = "RIGHT",
					["buffToTrack"] = "93402",
					["lowerText"] = "",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = -1,
					["textVerticalOffset"] = 12,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "DRUID",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
				},
				["Rapture"] = {
					["barVerticalOffset"] = 28,
					["side"] = "LEFT",
					["scale"] = 0.775,
					["textVisible"] = {
						["lower"] = false,
					},
					["widthModifier"] = -16,
					["barHorizontalOffset"] = -3,
					["textVerticalOffset"] = 4,
					["myTagVersion"] = 3,
					["barFontSize"] = 8,
					["offset"] = 2,
					["forceJustifyText"] = "LEFT",
				},
				["zCT-Pal-HolyAvenger"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.4509803921568628,
						["b"] = 0.2,
					},
					["barHorizontalOffset"] = 21,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "HA",
					["lowerText"] = "",
					["scale"] = 0.6849999999999999,
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["textVerticalOffset"] = 28,
					["barVerticalOffset"] = 45,
					["buffTimerDisplay"] = "seconds",
					["side"] = "LEFT",
					["buffToTrack"] = "105809",
					["textHorizontalOffset"] = 3,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -34,
					["offset"] = 2,
					["buffOrDebuff"] = "buff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "PALADIN",
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
				},
				["MirrorBarAdv"] = {
					["barVerticalOffset"] = 15,
					["scale"] = 0.85,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = true,
					["barHorizontalOffset"] = -4,
					["textVerticalOffset"] = 0,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["barFontSize"] = 8,
					["textHorizontalOffset"] = -6,
				},
				["TargetTargetCast"] = {
					["offset"] = 3,
					["forceJustifyText"] = "LEFT",
					["textVisible"] = {
						["lower"] = false,
					},
					["barFontSize"] = 8,
					["barHorizontalOffset"] = 12,
					["textHorizontalOffset"] = 18,
					["myTagVersion"] = 3,
					["widthModifier"] = -16,
					["textVerticalOffset"] = 4,
					["scale"] = 0.75,
					["barTextureOverride"] = "CleanCurves",
					["shouldUseOverride"] = true,
					["barVerticalOffset"] = 32,
				},
				["zCT-Rog-Rupture"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.7843137254901961,
						["g"] = 0,
						["b"] = 0,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "R",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["class"] = "ROGUE",
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["barHorizontalOffset"] = 3,
					["enabled"] = true,
					["barVerticalOffset"] = 27.5,
					["scale"] = 0.775,
					["side"] = "RIGHT",
					["buffToTrack"] = "1943",
					["textHorizontalOffset"] = -7,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["textVerticalOffset"] = 4,
					["forceJustifyText"] = "RIGHT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["buffTimerDisplay"] = "seconds",
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["RogueLegendary"] = {
					["offset"] = 2,
					["side"] = "LEFT",
					["forceJustifyText"] = "LEFT",
					["textHorizontalOffset"] = -1,
					["barHorizontalOffset"] = 21,
					["textVerticalOffset"] = 28,
					["scale"] = 0.6849999999999999,
					["myTagVersion"] = 3,
					["barVerticalOffset"] = 45,
					["widthModifier"] = -34,
				},
				["zCT-Dru-TigersFury"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.1529411764705883,
						["b"] = 0,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "T",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.745,
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
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["barHorizontalOffset"] = 5,
					["myTagVersion"] = 3,
					["offset"] = 2,
					["forceJustifyText"] = "LEFT",
					["barVerticalOffset"] = 33,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "5217",
					["textHorizontalOffset"] = 8,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["buffOrDebuff"] = "buff",
					["textVerticalOffset"] = 12,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "DRUID",
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Dru-Berserk"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.1529411764705883,
						["r"] = 1,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "B",
					["lowerText"] = "",
					["buffOrDebuff"] = "buff",
					["offset"] = 2,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 12,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["barHorizontalOffset"] = 5,
					["auraIconXOffset"] = 40,
					["barVerticalOffset"] = 33,
					["buffTimerDisplay"] = "seconds",
					["side"] = "LEFT",
					["buffToTrack"] = "50334",
					["scale"] = 0.745,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["textHorizontalOffset"] = 8,
					["exactMatch"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "DRUID",
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-War-TasteBlood"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "TB",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.6849999999999999,
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["offset"] = 2,
					["forceJustifyText"] = "LEFT",
					["barVerticalOffset"] = 45,
					["buffOrDebuff"] = "buff",
					["side"] = "LEFT",
					["buffToTrack"] = "56636",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["textHorizontalOffset"] = 1,
					["shouldUseOverride"] = false,
					["widthModifier"] = -34,
					["lowerText"] = "",
					["textVerticalOffset"] = 28,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = 21,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["class"] = "WARRIOR",
				},
				["WildMushrooms"] = {
					["barVerticalOffset"] = 33,
					["barHorizontalOffset"] = 5,
					["textVerticalOffset"] = 12,
					["scale"] = 0.745,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "LEFT",
					["widthModifier"] = -22,
				},
				["Stagger"] = {
					["barVerticalOffset"] = 39,
					["widthModifier"] = -28,
					["textHorizontalOffset"] = 3,
					["textVerticalOffset"] = 25,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["scale"] = 0.715,
					["barHorizontalOffset"] = 13,
				},
				["SavageRoar"] = {
					["offset"] = 2,
					["side"] = "LEFT",
					["forceJustifyText"] = "LEFT",
					["textHorizontalOffset"] = 10,
					["widthModifier"] = -16,
					["barHorizontalOffset"] = -3,
					["textVerticalOffset"] = 4,
					["myTagVersion"] = 3,
					["barFontSize"] = 8,
					["barVerticalOffset"] = 28,
					["scale"] = 0.775,
				},
				["TargetInvuln"] = {
					["barVerticalOffset"] = 32,
					["forceJustifyText"] = "LEFT",
					["textHorizontalOffset"] = 60,
					["lockLowerTextAlpha"] = true,
					["widthModifier"] = -16,
					["barHorizontalOffset"] = 12,
					["displayAuraIcon"] = true,
					["auraIconYOffset"] = -7,
					["textVerticalOffset"] = 22,
					["scale"] = 0.75,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["auraIconXOffset"] = -49,
				},
				["FocusCast"] = {
					["offset"] = 3,
					["side"] = "LEFT",
					["scale"] = 0.75,
					["textHorizontalOffset"] = -16,
					["barHorizontalOffset"] = -12,
					["enabled"] = true,
					["barFontSize"] = 8,
					["forceJustifyText"] = "RIGHT",
					["textVerticalOffset"] = 4,
					["widthModifier"] = -16,
					["myTagVersion"] = 3,
					["textVisible"] = {
						["lower"] = false,
					},
					["barVerticalOffset"] = 32,
				},
				["zCT-War-Victorious"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.392156862745098,
						["b"] = 0,
					},
					["barHorizontalOffset"] = 5,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "V",
					["lowerText"] = "",
					["scale"] = 0.745,
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 12,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["exactMatch"] = true,
					["barVerticalOffset"] = 33,
					["buffTimerDisplay"] = "seconds",
					["side"] = "LEFT",
					["buffToTrack"] = "32216",
					["textHorizontalOffset"] = 15,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["offset"] = 2,
					["buffOrDebuff"] = "buff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "WARRIOR",
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Pri-DarkEvangelism"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.6470588235294118,
						["g"] = 0.6470588235294118,
						["b"] = 0.9215686274509803,
					},
					["barHorizontalOffset"] = -3,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "DE",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.775,
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 4,
					["lowerText"] = "",
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["enabled"] = true,
					["barVerticalOffset"] = 28,
					["exactMatch"] = true,
					["side"] = "LEFT",
					["buffToTrack"] = "87118",
					["forceJustifyText"] = "LEFT",
					["textHorizontalOffset"] = 17,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["buffOrDebuff"] = "buff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "PRIEST",
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
				},
				["zCT-War-Enrage2"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.1372549019607843,
						["b"] = 0,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "E",
					["lowerText"] = "",
					["forceJustifyText"] = "LEFT",
					["scaleManaColor"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 4,
					["barHorizontalOffset"] = -3,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["scale"] = 0.775,
					["barVerticalOffset"] = 27,
					["buffOrDebuff"] = "buff",
					["side"] = "LEFT",
					["buffToTrack"] = "12880",
					["exactMatch"] = true,
					["textHorizontalOffset"] = 24,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["class"] = "WARRIOR",
				},
				["zCT-Dru-Rip"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.7843137254901961,
						["g"] = 0,
						["b"] = 0,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Ri",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
					["barHorizontalOffset"] = 3,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["scale"] = 0.775,
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["offset"] = 2,
					["barVerticalOffset"] = 27.5,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "1079",
					["textHorizontalOffset"] = -1,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["buffOrDebuff"] = "debuff",
					["textVerticalOffset"] = 5,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "DRUID",
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
						["spec2"] = true,
					},
				},
				["BanditsGuile"] = {
					["barVerticalOffset"] = 33,
					["scale"] = 0.745,
					["textVisible"] = {
						["lower"] = false,
					},
					["widthModifier"] = -22,
					["barHorizontalOffset"] = 5,
					["textVerticalOffset"] = 12,
					["textHorizontalOffset"] = 12,
					["myTagVersion"] = 3,
					["offset"] = 2,
					["forceJustifyText"] = "LEFT",
				},
				["zCT-Pal-Inquisition"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.2235294117647059,
						["g"] = 0.8549019607843137,
						["r"] = 1,
					},
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "In",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.745,
					["barHorizontalOffset"] = 5,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["auraIconXOffset"] = 40,
					["lowerText"] = "",
					["barVerticalOffset"] = 33,
					["buffOrDebuff"] = "buff",
					["side"] = "LEFT",
					["buffToTrack"] = "84963",
					["textHorizontalOffset"] = 16,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["textVerticalOffset"] = 12,
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "PALADIN",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Mon-TigerPower"] = {
					["class"] = "MONK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["offset"] = 2,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.4588235294117647,
						["g"] = 1,
						["r"] = 0.3490196078431372,
					},
					["barHorizontalOffset"] = -3,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "TP",
					["lowerText"] = "",
					["forceJustifyText"] = "LEFT",
					["textVerticalOffset"] = 4,
					["myTagVersion"] = 3,
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
					["barVerticalOffset"] = 27.5,
					["bAllowExpand"] = true,
					["side"] = "LEFT",
					["lowThreshold"] = 0,
					["buffOrDebuff"] = "buff",
					["textHorizontalOffset"] = 1,
					["scale"] = 0.775,
					["widthModifier"] = -16,
					["lockUpperTextAlpha"] = true,
					["enabled"] = true,
					["lowerTextVisible"] = false,
					["buffToTrack"] = "125359",
					["textVisible"] = {
						["lower"] = true,
						["upper"] = true,
					},
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["buffTimerDisplay"] = "minutes",
				},
				["zCT-Pri-VampTouch"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.9215686274509803,
						["g"] = 0.6470588235294118,
						["r"] = 0.6470588235294118,
					},
					["barHorizontalOffset"] = 3,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "VT",
					["lowerText"] = "",
					["scale"] = 0.775,
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
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["buffOrDebuff"] = "debuff",
					["myTagVersion"] = 3,
					["auraIconXOffset"] = 40,
					["enabled"] = true,
					["barVerticalOffset"] = 27.5,
					["textVerticalOffset"] = 4,
					["side"] = "RIGHT",
					["buffToTrack"] = "34914",
					["forceJustifyText"] = "RIGHT",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = -18,
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "PRIEST",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["WeakenedBlows"] = {
					["upperText"] = "WB",
					["scale"] = 0.775,
					["textHorizontalOffset"] = -1,
					["barHorizontalOffset"] = 3,
					["textVerticalOffset"] = 5,
					["barVerticalOffset"] = 27.5,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "RIGHT",
					["widthModifier"] = -16,
				},
				["zCT-Pal-ArdentDefender"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.2,
						["g"] = 0.4509803921568628,
						["r"] = 1,
					},
					["barHorizontalOffset"] = 21,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "AD",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.6849999999999999,
					["offset"] = 2,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["lowerText"] = "",
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["auraIconXOffset"] = 40,
					["barVerticalOffset"] = 45,
					["textVerticalOffset"] = 28,
					["side"] = "LEFT",
					["buffToTrack"] = "31850",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = 3,
					["shouldUseOverride"] = false,
					["widthModifier"] = -34,
					["buffOrDebuff"] = "buff",
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "PALADIN",
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Sha-EarthShock"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.5882352941176471,
						["b"] = 0,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Ea",
					["lowerText"] = "",
					["forceJustifyText"] = "RIGHT",
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
					["barFontSize"] = 8,
					["textVerticalOffset"] = 12,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["barHorizontalOffset"] = -4,
					["buffTimerDisplay"] = "seconds",
					["barVerticalOffset"] = 33,
					["exactMatch"] = true,
					["side"] = "RIGHT",
					["buffToTrack"] = "8042",
					["textHorizontalOffset"] = -6,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["buffOrDebuff"] = "debuff",
					["scale"] = 0.745,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "SHAMAN",
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-War-Enrage"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.1372549019607843,
						["r"] = 1,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "E",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "buff",
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 4,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["forceJustifyText"] = "LEFT",
					["enabled"] = true,
					["barVerticalOffset"] = 27,
					["scale"] = 0.775,
					["side"] = "LEFT",
					["buffToTrack"] = "12880",
					["lowerText"] = "",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textHorizontalOffset"] = 24,
					["exactMatch"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = -3,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["class"] = "WARRIOR",
				},
				["Vengeance"] = {
					["enabled"] = true,
					["forceJustifyText"] = "LEFT",
					["textVisible"] = {
						["lower"] = false,
					},
					["widthModifier"] = -16,
					["barHorizontalOffset"] = -3,
					["offset"] = 2,
					["textVerticalOffset"] = 4,
					["myTagVersion"] = 3,
					["barFontSize"] = 8,
					["scale"] = 0.775,
					["barVerticalOffset"] = 27.5,
				},
				["zCT-Dru-Moonfire"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.1882352941176471,
						["g"] = 0.4196078431372549,
						["b"] = 0.8666666666666667,
					},
					["barHorizontalOffset"] = 3,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Mf",
					["lowerText"] = "",
					["scale"] = 0.775,
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 5,
					["buffOrDebuff"] = "debuff",
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["offset"] = 2,
					["barVerticalOffset"] = 27.5,
					["buffTimerDisplay"] = "seconds",
					["side"] = "RIGHT",
					["buffToTrack"] = "8921",
					["textHorizontalOffset"] = -1,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["forceJustifyText"] = "RIGHT",
					["exactMatch"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "DRUID",
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = true,
						["spec2"] = true,
					},
				},
				["zCT-Pal-AvengingWrath"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.9137254901960784,
						["b"] = 0.5215686274509804,
					},
					["barHorizontalOffset"] = -3,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "AW",
					["lowerText"] = "",
					["scale"] = 0.775,
					["scaleManaColor"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["auraIconXOffset"] = 40,
					["myTagVersion"] = 3,
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "buff",
					["barVerticalOffset"] = 27.5,
					["enabled"] = true,
					["side"] = "LEFT",
					["buffToTrack"] = "31884",
					["forceJustifyText"] = "LEFT",
					["textHorizontalOffset"] = 24,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["textVerticalOffset"] = 5,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["class"] = "PALADIN",
				},
				["zCT-Mag-FingersFrost"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.788235294117647,
						["r"] = 0,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "FF",
					["lowerText"] = "",
					["forceJustifyText"] = "LEFT",
					["barHorizontalOffset"] = -3,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 4,
					["scale"] = 0.775,
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["offset"] = 2,
					["barVerticalOffset"] = 27.5,
					["exactMatch"] = true,
					["side"] = "LEFT",
					["buffToTrack"] = "44544",
					["buffTimerDisplay"] = "seconds",
					["textHorizontalOffset"] = 1,
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["buffOrDebuff"] = "buff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "MAGE",
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Mag-Frostfire(G)"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barHorizontalOffset"] = 3,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "FFB",
					["lowerText"] = "",
					["scale"] = 0.775,
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
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["buffOrDebuff"] = "debuff",
					["myTagVersion"] = 3,
					["auraIconXOffset"] = 40,
					["enabled"] = true,
					["barVerticalOffset"] = 27.5,
					["textVerticalOffset"] = 4,
					["side"] = "RIGHT",
					["buffToTrack"] = "61205",
					["forceJustifyText"] = "RIGHT",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = -12,
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "MAGE",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["MirrorBar"] = {
					["enabled"] = true,
					["myTagVersion"] = 3,
				},
				["zCT-Mon-VitalMists"] = {
					["class"] = "MONK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.7098039215686275,
						["g"] = 1,
						["r"] = 0.1490196078431373,
					},
					["barHorizontalOffset"] = 5,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "VM",
					["lowerText"] = "",
					["forceJustifyText"] = "LEFT",
					["textVerticalOffset"] = 14,
					["myTagVersion"] = 3,
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
					["barVerticalOffset"] = 33,
					["bAllowExpand"] = true,
					["side"] = "LEFT",
					["lowThreshold"] = 0,
					["buffOrDebuff"] = "buff",
					["textHorizontalOffset"] = 9,
					["scale"] = 0.745,
					["widthModifier"] = -22,
					["lockUpperTextAlpha"] = true,
					["enabled"] = true,
					["lowerTextVisible"] = false,
					["buffToTrack"] = "118674",
					["textVisible"] = {
						["lower"] = true,
						["upper"] = true,
					},
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["buffTimerDisplay"] = "minutes",
				},
				["zCT-Pri-MindSpike"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.2,
						["r"] = 0.2941176470588235,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "MS",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.715,
					["barHorizontalOffset"] = 13,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["offset"] = 2,
					["barVerticalOffset"] = 39,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "33371",
					["textHorizontalOffset"] = 0,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["textVerticalOffset"] = 21,
					["buffOrDebuff"] = "buff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "PRIEST",
					["barFontSize"] = 8,
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
				},
				["SliceAndDice"] = {
					["barVerticalOffset"] = 27.5,
					["side"] = "LEFT",
					["scale"] = 0.775,
					["textHorizontalOffset"] = 8,
					["barHorizontalOffset"] = -3,
					["widthModifier"] = -16,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 5,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["textVisible"] = {
						["lower"] = false,
					},
					["offset"] = 2,
				},
				["zCT-Rog-Envenom"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.7843137254901961,
						["b"] = 0,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "E",
					["lowerText"] = "",
					["buffOrDebuff"] = "buff",
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
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["buffTimerDisplay"] = "seconds",
					["barHorizontalOffset"] = 5,
					["barVerticalOffset"] = 33,
					["textVerticalOffset"] = 12,
					["side"] = "LEFT",
					["buffToTrack"] = "32645",
					["textHorizontalOffset"] = 12,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["scale"] = 0.745,
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "ROGUE",
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["BurningEmbersBar"] = {
					["barVerticalOffset"] = 27.5,
					["barHorizontalOffset"] = -3,
					["scale"] = 0.775,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "LEFT",
					["widthModifier"] = -16,
				},
				["zCT-Pal-DivineProtection"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.22,
						["g"] = 0.65,
						["r"] = 1,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "DP",
					["lowerText"] = "",
					["buffOrDebuff"] = "buff",
					["scaleManaColor"] = true,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["buffTimerDisplay"] = "seconds",
					["barHorizontalOffset"] = 13,
					["barVerticalOffset"] = 39,
					["scale"] = 0.715,
					["side"] = "LEFT",
					["buffToTrack"] = "498",
					["textVerticalOffset"] = 20,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -28,
					["textHorizontalOffset"] = 9,
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["class"] = "PALADIN",
				},
				["zCT-War-MeatCleaver"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "MC",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "LEFT",
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 28,
					["barHorizontalOffset"] = 21,
					["myTagVersion"] = 3,
					["buffOrDebuff"] = "buff",
					["auraIconXOffset"] = 40,
					["barVerticalOffset"] = 45,
					["exactMatch"] = true,
					["side"] = "LEFT",
					["buffToTrack"] = "85739",
					["lowerText"] = "",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -34,
					["textHorizontalOffset"] = 1,
					["scale"] = 0.6849999999999999,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["enabled"] = true,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["class"] = "WARRIOR",
				},
				["zCT-Rog-Revealing"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.3490196078431372,
						["b"] = 0,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "RS",
					["lowerText"] = "",
					["scale"] = 0.74,
					["scaleManaColor"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["class"] = "ROGUE",
					["myTagVersion"] = 3,
					["enabled"] = true,
					["auraIconXOffset"] = 40,
					["barVerticalOffset"] = 33.5,
					["buffOrDebuff"] = "debuff",
					["side"] = "RIGHT",
					["buffToTrack"] = "84617",
					["forceJustifyText"] = "RIGHT",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["textHorizontalOffset"] = 0,
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["textVerticalOffset"] = 12,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["barHorizontalOffset"] = -4,
				},
				["zCT-Sha-FlameShock"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0.8627450980392157,
					},
					["barHorizontalOffset"] = 3,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Fl",
					["lowerText"] = "",
					["scale"] = 0.775,
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
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["buffOrDebuff"] = "debuff",
					["myTagVersion"] = 3,
					["auraIconXOffset"] = 40,
					["buffTimerDisplay"] = "seconds",
					["barVerticalOffset"] = 27.5,
					["textVerticalOffset"] = 4,
					["side"] = "RIGHT",
					["buffToTrack"] = "8050",
					["forceJustifyText"] = "RIGHT",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = -16,
					["enabled"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "SHAMAN",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Dru-Rake"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.3882352941176471,
						["r"] = 1,
					},
					["barHorizontalOffset"] = -4,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Ra",
					["lowerText"] = "",
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
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 12,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["auraIconXOffset"] = 40,
					["exactMatch"] = true,
					["barVerticalOffset"] = 33,
					["buffTimerDisplay"] = "seconds",
					["side"] = "RIGHT",
					["buffToTrack"] = "1822",
					["forceJustifyText"] = "RIGHT",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = -1,
					["scale"] = 0.745,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "DRUID",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = true,
						["spec2"] = true,
					},
				},
				["EclipseBar"] = {
					["offset"] = 2,
					["forceJustifyText"] = "LEFT",
					["textHorizontalOffset"] = -20,
					["barHorizontalOffset"] = -3,
					["widthModifier"] = -16,
					["scale"] = 0.775,
					["textVerticalOffset"] = 94,
					["barFontSize"] = 8,
					["myTagVersion"] = 3,
					["alwaysFullAlpha"] = true,
					["barVerticalOffset"] = 27.5,
				},
				["zCT-Wlock-Immolate"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.09803921568627451,
						["r"] = 0.6862745098039216,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Im",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["barHorizontalOffset"] = -4,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 12,
					["forceJustifyText"] = "RIGHT",
					["myTagVersion"] = 3,
					["offset"] = 2,
					["auraIconXOffset"] = 40,
					["barVerticalOffset"] = 33,
					["scale"] = 0.745,
					["side"] = "RIGHT",
					["buffToTrack"] = "348",
					["exactMatch"] = true,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = -11,
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "WARLOCK",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
				},
				["DemonicFuryBar"] = {
					["barVerticalOffset"] = 27.5,
					["widthModifier"] = -16,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["scale"] = 0.775,
					["barHorizontalOffset"] = -3,
				},
				["zCT-Wlock-BoA"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.3098039215686275,
						["r"] = 0.4745098039215686,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "BA",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["barHorizontalOffset"] = -11,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 20,
					["forceJustifyText"] = "RIGHT",
					["myTagVersion"] = 3,
					["offset"] = 2,
					["auraIconXOffset"] = 40,
					["barVerticalOffset"] = 39,
					["scale"] = 0.715,
					["side"] = "RIGHT",
					["buffToTrack"] = "980",
					["exactMatch"] = true,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = -5,
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "WARLOCK",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Wlock-BoD"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.4666666666666667,
						["g"] = 0.2980392156862745,
						["b"] = 1,
					},
					["barHorizontalOffset"] = -11,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "BD",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "debuff",
					["enabled"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 20,
					["auraIconXOffset"] = 40,
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["lowerText"] = "",
					["barVerticalOffset"] = 39,
					["exactMatch"] = true,
					["side"] = "RIGHT",
					["buffToTrack"] = "603",
					["textHorizontalOffset"] = -5,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -28,
					["forceJustifyText"] = "RIGHT",
					["scale"] = 0.715,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "WARLOCK",
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Mon-Shuffle"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["talentGroups"] = 1,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.8627450980392157,
						["g"] = 0.4313725490196079,
						["b"] = 0,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Sh",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.745,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["auraIconXOffset"] = 40,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["class"] = "MONK",
					["barVerticalOffset"] = 33,
					["buffOrDebuff"] = "buff",
					["side"] = "LEFT",
					["buffToTrack"] = "115307",
					["forceJustifyText"] = "LEFT",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = 9,
					["lowerText"] = "",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["textVerticalOffset"] = 14,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["barHorizontalOffset"] = 5,
				},
				["zCT-Wlock-ShadowAndFlame"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.2980392156862745,
						["g"] = 0.4274509803921568,
						["b"] = 1,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "SF",
					["lowerText"] = "",
					["forceJustifyText"] = "RIGHT",
					["barHorizontalOffset"] = -18,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["buffTimerDisplay"] = "seconds",
					["myTagVersion"] = 3,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["offset"] = 2,
					["barVerticalOffset"] = 45,
					["buffOrDebuff"] = "debuff",
					["side"] = "RIGHT",
					["buffToTrack"] = "17800",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["textHorizontalOffset"] = 1,
					["shouldUseOverride"] = false,
					["widthModifier"] = -34,
					["textVerticalOffset"] = 28,
					["scale"] = 0.6849999999999999,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "WARLOCK",
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Hun-SerpentSting"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.2274509803921569,
						["g"] = 0.9019607843137255,
						["r"] = 0.3058823529411765,
					},
					["barHorizontalOffset"] = 3,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "SS",
					["lowerText"] = "",
					["scale"] = 0.775,
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
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["buffOrDebuff"] = "debuff",
					["myTagVersion"] = 3,
					["auraIconXOffset"] = 40,
					["buffTimerDisplay"] = "seconds",
					["barVerticalOffset"] = 27.5,
					["textVerticalOffset"] = 4,
					["side"] = "RIGHT",
					["buffToTrack"] = "1978",
					["forceJustifyText"] = "RIGHT",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = 2,
					["enabled"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "HUNTER",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-War-DeadlyCalm"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.6666666666666666,
						["b"] = 0,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "DC",
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
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["barHorizontalOffset"] = 13,
					["textVerticalOffset"] = 20,
					["barVerticalOffset"] = 39,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "85730",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["textHorizontalOffset"] = 8,
					["shouldUseOverride"] = false,
					["widthModifier"] = -28,
					["buffOrDebuff"] = "buff",
					["scale"] = 0.715,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "WARRIOR",
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Mag-Ignite"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 1,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "IG",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["barHorizontalOffset"] = -4,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["textVerticalOffset"] = 12,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "RIGHT",
					["auraIconXOffset"] = 40,
					["barVerticalOffset"] = 33,
					["scale"] = 0.745,
					["side"] = "RIGHT",
					["buffToTrack"] = "12654",
					["textHorizontalOffset"] = -14,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["buffTimerDisplay"] = "seconds",
					["offset"] = 2,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "MAGE",
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Mag-LivingBomb"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.5372549019607843,
						["r"] = 1,
					},
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "LB",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
					["auraIconXOffset"] = 40,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 28,
					["exactMatch"] = true,
					["myTagVersion"] = 3,
					["barHorizontalOffset"] = -18,
					["scale"] = 0.6849999999999999,
					["barVerticalOffset"] = 45,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "44457",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = 0,
					["widthModifier"] = -34,
					["shouldUseOverride"] = false,
					["enabled"] = true,
					["buffOrDebuff"] = "debuff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["class"] = "MAGE",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["HungerForBlood"] = {
					["offset"] = 1,
					["side"] = "LEFT",
					["scale"] = 0.8,
					["textHorizontalOffset"] = 4,
					["widthModifier"] = -22,
					["forceJustifyText"] = "LEFT",
					["textVerticalOffset"] = -18,
					["myTagVersion"] = 3,
					["barFontSize"] = 8,
					["barVerticalOffset"] = 27,
					["enabled"] = true,
				},
				["TargetCC"] = {
					["enabled"] = true,
					["scale"] = 0.85,
					["textHorizontalOffset"] = 8,
					["displayAuraIcon"] = true,
					["auraIconXOffset"] = -128.5,
					["barHorizontalOffset"] = 4,
					["auraIconYOffset"] = -29,
					["textVerticalOffset"] = 0,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["barVerticalOffset"] = 15,
					["lockLowerTextAlpha"] = true,
				},
			},
			["fontFamily"] = "pixel_lr_small",
			["alphaicbg"] = 0.5,
			["fontFamilyLarge"] = "pixel_lr_small",
			["gap"] = 100,
			["alphaic"] = 0.8,
			["detachedTooltip"] = {
			},
			["hidden"] = true,
			["updatePeriod"] = 0.0334,
			["alphaNotFullbg"] = 0.4,
			["alphaoocbg"] = 0.25,
			["colors"] = {
				["EclipseSolar"] = {
					["r"] = 0.6627450980392157,
					["g"] = 0.6627450980392157,
					["b"] = 0.6627450980392157,
				},
				["ScaledManaColor"] = {
					["r"] = 1,
				},
				["CastNotInterruptible"] = {
					["r"] = 0.7843137254901961,
					["g"] = 0.4313725490196079,
					["b"] = 0.4313725490196079,
				},
				["SliceAndDice"] = {
					["r"] = 1,
					["b"] = 1,
				},
				["EclipseLunarActive"] = {
					["g"] = 0.3176470588235294,
					["r"] = 0.3176470588235294,
				},
				["EclipseSolarActive"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 0.2,
				},
				["CastSuccess"] = {
					["r"] = 0.3882352941176471,
					["g"] = 0.7137254901960785,
					["b"] = 0.1764705882352941,
				},
				["CastNotInRange"] = {
					["r"] = 0.3529411764705882,
					["g"] = 0.3529411764705882,
					["b"] = 0.3529411764705882,
				},
				["CastCasting"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["ScaledHealthColor"] = {
					["g"] = 0,
					["r"] = 1,
				},
				["EclipseLunar"] = {
					["r"] = 0.392156862745098,
					["g"] = 0.392156862745098,
					["b"] = 0.392156862745098,
				},
				["BREATH"] = {
					["g"] = 0.7411764705882353,
					["r"] = 0.3019607843137255,
				},
				["CastChanneling"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
			},
			["alphaTargetbg"] = 0.4,
			["verticalPos"] = -134,
			["bShouldUseDogTags"] = false,
			["alphaNotFull"] = 0.7000000000000001,
			["updatedOocNotFull"] = true,
		},
		["Default"] = {
			["modules"] = {
				["Runes"] = {
					["myTagVersion"] = 3,
				},
				["CastBar"] = {
					["myTagVersion"] = 3,
				},
				["TargetCast"] = {
					["myTagVersion"] = 3,
				},
				["Rapture"] = {
					["myTagVersion"] = 3,
				},
				["SliceAndDice"] = {
					["myTagVersion"] = 3,
				},
				["SavageRoar"] = {
					["myTagVersion"] = 3,
				},
				["EclipseBar"] = {
					["myTagVersion"] = 3,
				},
				["WeakenedBlows"] = {
					["myTagVersion"] = 3,
				},
			},
		},
		["RealUI-HR"] = {
			["modules"] = {
				["zCT-Sha-FrostShock"] = {
					["shouldAnimate"] = false,
					["class"] = "SHAMAN",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.2352941176470588,
						["b"] = 0.9411764705882353,
					},
					["barHorizontalOffset"] = -12,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Fr",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.715,
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
					["barFontSize"] = 8,
					["textVerticalOffset"] = 24,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["buffOrDebuff"] = "debuff",
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 39,
					["exactMatch"] = true,
					["side"] = "RIGHT",
					["buffToTrack"] = "8056",
					["textHorizontalOffset"] = -1,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["lowerText"] = "",
					["forceJustifyText"] = "RIGHT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Rog-FindWeakness"] = {
					["shouldAnimate"] = false,
					["class"] = "ROGUE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
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
					["lowerText"] = "",
					["scale"] = 0.715,
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 24,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 39,
					["buffOrDebuff"] = "debuff",
					["side"] = "LEFT",
					["buffToTrack"] = "91023",
					["auraIconXOffset"] = 40,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = 6,
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["forceJustifyText"] = "LEFT",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["offset"] = 2,
				},
				["TargetCast"] = {
					["lockLowerTextAlpha"] = true,
					["auraIconYOffset"] = -30,
					["offset"] = 2,
					["AuraIconSize"] = 27,
					["auraIconXOffset"] = -128.5,
					["forceJustifyText"] = "LEFT",
					["displayAuraIcon"] = true,
					["myTagVersion"] = 3,
					["barVerticalOffset"] = 15,
					["textHorizontalOffset"] = 8,
					["auraIconSize"] = 28,
					["scale"] = 0.85,
					["barFontSize"] = 8,
					["barHorizontalOffset"] = 4,
				},
				["RogueExtras1"] = {
					["scale"] = 0.85,
					["displayAuraIcon"] = true,
					["auraIconYOffset"] = -30,
					["myTagVersion"] = 3,
					["barVerticalOffset"] = 15,
					["lockLowerTextAlpha"] = true,
					["textHorizontalOffset"] = -6,
					["auraIconSize"] = 28,
					["auraIconXOffset"] = 25,
					["offset"] = 2,
					["forceJustifyText"] = "RIGHT",
					["barHorizontalOffset"] = -4,
				},
				["zCT-Dru-Lacerate"] = {
					["shouldAnimate"] = false,
					["class"] = "DRUID",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.3882352941176471,
						["b"] = 0,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "La",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
					["barHorizontalOffset"] = -4,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 14,
					["buffOrDebuff"] = "debuff",
					["myTagVersion"] = 3,
					["enabled"] = true,
					["exactMatch"] = true,
					["barVerticalOffset"] = 33,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "33745",
					["textHorizontalOffset"] = -1,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["lockUpperTextAlpha"] = true,
					["scale"] = 0.745,
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
						["spec1"] = true,
						["spec4"] = true,
						["spec2"] = true,
					},
				},
				["zCT-Mon-SerpentsZeal"] = {
					["class"] = "MONK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.4392156862745098,
						["g"] = 1,
						["r"] = 0.3254901960784314,
					},
					["barHorizontalOffset"] = -3,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "SZ",
					["lowerText"] = "",
					["forceJustifyText"] = "LEFT",
					["textVerticalOffset"] = 5,
					["myTagVersion"] = 3,
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
					["barVerticalOffset"] = 27.5,
					["bAllowExpand"] = true,
					["side"] = "LEFT",
					["lowThreshold"] = 0,
					["buffOrDebuff"] = "buff",
					["textVisible"] = {
						["lower"] = true,
						["upper"] = true,
					},
					["scale"] = 0.775,
					["widthModifier"] = -16,
					["lockUpperTextAlpha"] = true,
					["enabled"] = true,
					["lowerTextVisible"] = false,
					["buffToTrack"] = "127722",
					["textHorizontalOffset"] = -1,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["buffTimerDisplay"] = "minutes",
				},
				["zCT-Wlock-UAffliction"] = {
					["shouldAnimate"] = false,
					["class"] = "WARLOCK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.6862745098039216,
						["g"] = 0.09803921568627451,
						["b"] = 1,
					},
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "UA",
					["lowerText"] = "",
					["scale"] = 0.745,
					["enabled"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 14,
					["auraIconXOffset"] = 40,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "RIGHT",
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 33,
					["exactMatch"] = true,
					["side"] = "RIGHT",
					["buffToTrack"] = "30108",
					["textHorizontalOffset"] = -11,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "debuff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = -4,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["PlayerMana"] = {
					["enabled"] = true,
					["myTagVersion"] = 3,
				},
				["zCT-Rog-Recuperate"] = {
					["shouldAnimate"] = false,
					["class"] = "ROGUE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.5529411764705883,
						["g"] = 1,
						["r"] = 0,
					},
					["barHorizontalOffset"] = 13,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "R",
					["lowerText"] = "",
					["scale"] = 0.715,
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 24,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 39,
					["buffOrDebuff"] = "buff",
					["side"] = "LEFT",
					["buffToTrack"] = "73651",
					["auraIconXOffset"] = 40,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = 6,
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["forceJustifyText"] = "LEFT",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["offset"] = 2,
				},
				["zCT-DK-FrostFever"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.6588235294117647,
						["r"] = 0.2,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "FF",
					["lowerText"] = "",
					["scale"] = 0.775,
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["offset"] = 2,
					["class"] = "DEATHKNIGHT",
					["barVerticalOffset"] = 27.5,
					["buffOrDebuff"] = "debuff",
					["side"] = "RIGHT",
					["buffToTrack"] = "59921",
					["buffTimerDisplay"] = "seconds",
					["textHorizontalOffset"] = -1,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textVerticalOffset"] = 5,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["forceJustifyText"] = "RIGHT",
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["barHorizontalOffset"] = 3,
				},
				["zCT-Hun-BlackArrow"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.5686274509803921,
						["g"] = 0.1490196078431373,
						["r"] = 0.403921568627451,
					},
					["barHorizontalOffset"] = -4,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "BA",
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
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["scale"] = 0.745,
					["class"] = "HUNTER",
					["barVerticalOffset"] = 33,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "3674",
					["textVerticalOffset"] = 14,
					["textHorizontalOffset"] = 1,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["forceJustifyText"] = "RIGHT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
				},
				["zCT-DK-FrostFever(Blood)"] = {
					["shouldAnimate"] = false,
					["class"] = "DEATHKNIGHT",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.2,
						["g"] = 0.6588235294117647,
						["b"] = 1,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "FF",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "debuff",
					["scaleManaColor"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["barHorizontalOffset"] = -11,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "RIGHT",
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 39,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "59921",
					["textHorizontalOffset"] = 4,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["textVerticalOffset"] = 24,
					["scale"] = 0.715,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["enabled"] = true,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["auraIconXOffset"] = 40,
				},
				["zCT-Mag-Pyroblast"] = {
					["shouldAnimate"] = false,
					["class"] = "MAGE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.2705882352941176,
						["r"] = 1,
					},
					["barHorizontalOffset"] = -11,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "PB",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["textVerticalOffset"] = 24,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 39,
					["buffTimerDisplay"] = "seconds",
					["side"] = "RIGHT",
					["buffToTrack"] = "11366",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = -6,
					["shouldUseOverride"] = false,
					["widthModifier"] = -28,
					["scale"] = 0.715,
					["forceJustifyText"] = "RIGHT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["RogueExtras2"] = {
					["scale"] = 0.75,
					["textVerticalOffset"] = 3,
					["myTagVersion"] = 3,
					["offset"] = 3,
					["textHorizontalOffset"] = -16,
					["AuraIconSize"] = 27,
					["barHorizontalOffset"] = -12,
					["textVisible"] = {
						["lower"] = false,
					},
					["barVerticalOffset"] = 32,
					["forceJustifyText"] = "RIGHT",
					["barFontSize"] = 8,
					["widthModifier"] = -16,
				},
				["zCT-Mon-DizzyingHaze"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.1607843137254902,
						["g"] = 0.6196078431372549,
						["r"] = 0.8666666666666667,
					},
					["barHorizontalOffset"] = -4,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "DH",
					["lowerText"] = "",
					["forceJustifyText"] = "RIGHT",
					["auraIconXOffset"] = 40,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["textVerticalOffset"] = 14,
					["class"] = "MONK",
					["barVerticalOffset"] = 33,
					["scale"] = 0.745,
					["side"] = "RIGHT",
					["buffToTrack"] = "115180",
					["buffTimerDisplay"] = "seconds",
					["textHorizontalOffset"] = 1,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["buffOrDebuff"] = "debuff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-DK-BloodPlague"] = {
					["shouldAnimate"] = false,
					["class"] = "DEATHKNIGHT",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.7843137254901961,
						["g"] = 0.196078431372549,
						["b"] = 0.196078431372549,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "BP",
					["lowerText"] = "",
					["forceJustifyText"] = "RIGHT",
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["scale"] = 0.745,
					["myTagVersion"] = 3,
					["offset"] = 2,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 33,
					["textVerticalOffset"] = 14,
					["side"] = "RIGHT",
					["buffToTrack"] = "59879",
					["textHorizontalOffset"] = -1,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["buffOrDebuff"] = "debuff",
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = -4,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Rog-Hemorrhage"] = {
					["shouldAnimate"] = false,
					["class"] = "ROGUE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.3490196078431372,
						["r"] = 1,
					},
					["barHorizontalOffset"] = -4,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "H",
					["lowerText"] = "",
					["scale"] = 0.74,
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
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 14,
					["exactMatch"] = true,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "RIGHT",
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 33.5,
					["auraIconXOffset"] = 40,
					["side"] = "RIGHT",
					["buffToTrack"] = "16511",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = 0,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "debuff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["offset"] = 2,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Dru-Harmony"] = {
					["shouldAnimate"] = false,
					["class"] = "DRUID",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.2627450980392157,
						["g"] = 0.8745098039215686,
						["r"] = 0.6901960784313725,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "H",
					["lowerText"] = "",
					["forceJustifyText"] = "LEFT",
					["barHorizontalOffset"] = -3,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 5,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 27.5,
					["scale"] = 0.775,
					["side"] = "LEFT",
					["buffToTrack"] = "100977",
					["buffTimerDisplay"] = "seconds",
					["textHorizontalOffset"] = 19,
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["buffOrDebuff"] = "buff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = true,
						["spec2"] = false,
					},
				},
				["CastBar"] = {
					["auraIconYOffset"] = -30,
					["markers"] = {
						{
							["height"] = 1,
						}, -- [1]
						{
							["height"] = 1,
						}, -- [2]
						{
							["height"] = 1,
						}, -- [3]
						{
							["height"] = 1,
						}, -- [4]
					},
					["offset"] = 2,
					["AuraIconSize"] = 27,
					["barHorizontalOffset"] = -4,
					["forceJustifyText"] = "RIGHT",
					["displayAuraIcon"] = true,
					["myTagVersion"] = 3,
					["barVerticalOffset"] = 15,
					["scale"] = 0.85,
					["textHorizontalOffset"] = -6,
					["auraIconSize"] = 28,
					["lagAlpha"] = 0.6000000000000001,
					["barFontSize"] = 8,
					["auraIconXOffset"] = 25,
				},
				["zCT-Pri-DevPlague"] = {
					["shouldAnimate"] = false,
					["class"] = "PRIEST",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.2,
						["r"] = 0.2941176470588235,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "DP",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
					["barHorizontalOffset"] = -11,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["textVerticalOffset"] = 24,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 39,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "2944",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = -6,
					["shouldUseOverride"] = false,
					["widthModifier"] = -28,
					["scale"] = 0.715,
					["buffOrDebuff"] = "debuff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Mag-Pyroblast!"] = {
					["shouldAnimate"] = false,
					["class"] = "MAGE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.2705882352941176,
						["b"] = 0,
					},
					["barHorizontalOffset"] = -11,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "PB",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.715,
					["enabled"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 24,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["buffOrDebuff"] = "debuff",
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 39,
					["exactMatch"] = true,
					["side"] = "RIGHT",
					["buffToTrack"] = "92315",
					["textHorizontalOffset"] = -6,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["lowerText"] = "",
					["forceJustifyText"] = "RIGHT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-War-Hamstring"] = {
					["shouldAnimate"] = false,
					["class"] = "WARRIOR",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.392156862745098,
						["r"] = 1,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "H",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["textVerticalOffset"] = 14,
					["myTagVersion"] = 3,
					["offset"] = 2,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 33,
					["buffTimerDisplay"] = "seconds",
					["side"] = "RIGHT",
					["buffToTrack"] = "1715",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = 0,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["scale"] = 0.745,
					["forceJustifyText"] = "RIGHT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = -5,
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["Runes"] = {
					["barVerticalOffset"] = -2,
					["enabled"] = true,
					["alwaysFullAlpha"] = true,
					["reverse"] = true,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["markers"] = {
						{
							["height"] = 1,
							["color"] = {
								["a"] = 1,
								["b"] = 0,
								["g"] = 0,
								["r"] = 0,
							},
							["position"] = 0.83,
						}, -- [1]
						{
							["height"] = 1,
							["color"] = {
								["a"] = 1,
								["b"] = 0,
								["g"] = 0,
								["r"] = 0,
							},
							["position"] = 0.67,
						}, -- [2]
						{
							["height"] = 1,
							["color"] = {
								["a"] = 1,
								["b"] = 0,
								["g"] = 0,
								["r"] = 0,
							},
							["position"] = 0.5,
						}, -- [3]
						{
							["height"] = 1,
							["color"] = {
								["a"] = 1,
								["b"] = 0,
								["g"] = 0,
								["r"] = 0,
							},
							["position"] = 0.33,
						}, -- [4]
						{
							["height"] = 1,
							["color"] = {
								["a"] = 1,
								["b"] = 0,
								["g"] = 0,
								["r"] = 0,
							},
							["position"] = 0.17,
						}, -- [5]
					},
					["barHorizontalOffset"] = 12,
				},
				["zCT-Rog-Recuperate-Sub"] = {
					["shouldAnimate"] = false,
					["class"] = "ROGUE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
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
					["buffOrDebuff"] = "buff",
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["lowerText"] = "",
					["auraIconXOffset"] = 40,
					["barVerticalOffset"] = 33,
					["lockUpperTextAlpha"] = true,
					["side"] = "LEFT",
					["buffToTrack"] = "73651",
					["textVerticalOffset"] = 14,
					["textHorizontalOffset"] = 13,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["offset"] = 2,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["scale"] = 0.745,
				},
				["zCT-Mon-RisingSunKick"] = {
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
				},
				["zCT-Pri-Evangelism"] = {
					["shouldAnimate"] = false,
					["class"] = "PRIEST",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.8627450980392157,
						["g"] = 0.8627450980392157,
						["b"] = 0.8627450980392157,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Ev",
					["lowerText"] = "",
					["buffOrDebuff"] = "buff",
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 14,
					["buffTimerDisplay"] = "seconds",
					["myTagVersion"] = 3,
					["offset"] = 2,
					["exactMatch"] = true,
					["barVerticalOffset"] = 33,
					["scale"] = 0.745,
					["side"] = "LEFT",
					["buffToTrack"] = "81661",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["textHorizontalOffset"] = 10,
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["lockUpperTextAlpha"] = true,
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = 5,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
				},
				["zCT-Pri-EmpoweredShadow"] = {
					["shouldAnimate"] = false,
					["class"] = "PRIEST",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.5333333333333333,
						["g"] = 0.4156862745098039,
						["b"] = 0.9215686274509803,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "ES",
					["lowerText"] = "",
					["scale"] = 0.745,
					["barHorizontalOffset"] = 5,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 14,
					["buffTimerDisplay"] = "seconds",
					["myTagVersion"] = 3,
					["enabled"] = true,
					["exactMatch"] = true,
					["barVerticalOffset"] = 33,
					["buffOrDebuff"] = "buff",
					["side"] = "LEFT",
					["buffToTrack"] = "95799",
					["textHorizontalOffset"] = 9,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["forceJustifyText"] = "LEFT",
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
				},
				["MirrorBarHandler"] = {
					["barVerticalOffset"] = -5,
					["textVerticalOffset"] = -20,
					["textHorizontalOffset"] = -24,
					["barFontSize"] = 8,
					["enabled"] = true,
				},
				["zCT-Wlock-Corruption"] = {
					["shouldAnimate"] = false,
					["class"] = "WARLOCK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.8823529411764706,
						["g"] = 0,
						["b"] = 0.9764705882352941,
					},
					["barHorizontalOffset"] = 3,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "C",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "debuff",
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["lowerText"] = "",
					["myTagVersion"] = 3,
					["enabled"] = true,
					["textVerticalOffset"] = 5,
					["barVerticalOffset"] = 27.5,
					["scale"] = 0.775,
					["side"] = "RIGHT",
					["buffToTrack"] = "172",
					["textHorizontalOffset"] = -27,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["lockUpperTextAlpha"] = true,
					["forceJustifyText"] = "RIGHT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Mag-ArcaneBlast"] = {
					["shouldAnimate"] = false,
					["class"] = "MAGE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "AB",
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
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["scale"] = 0.775,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 27.5,
					["textVerticalOffset"] = 5,
					["side"] = "LEFT",
					["buffToTrack"] = "36032",
					["lowerText"] = "",
					["textHorizontalOffset"] = -1,
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["buffOrDebuff"] = "debuff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = -3,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
				},
				["zCT-Pri-SWP"] = {
					["shouldAnimate"] = false,
					["class"] = "PRIEST",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.9215686274509803,
						["g"] = 0.4156862745098039,
						["r"] = 0.5333333333333333,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "SWP",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
					["barHorizontalOffset"] = -4,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["textVerticalOffset"] = 14,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 33,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "589",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = -6,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["scale"] = 0.745,
					["buffOrDebuff"] = "debuff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Dru-Sunfire"] = {
					["shouldAnimate"] = false,
					["class"] = "DRUID",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.05882352941176471,
						["g"] = 0.6431372549019607,
						["r"] = 0.8666666666666667,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Sf",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "debuff",
					["barHorizontalOffset"] = -4,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 14,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 33,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "93402",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = -1,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["forceJustifyText"] = "RIGHT",
					["scale"] = 0.745,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
				},
				["Rapture"] = {
					["barVerticalOffset"] = 28,
					["side"] = "LEFT",
					["scale"] = 0.775,
					["textVisible"] = {
						["lower"] = false,
					},
					["widthModifier"] = -16,
					["barHorizontalOffset"] = -3,
					["textVerticalOffset"] = 5,
					["myTagVersion"] = 3,
					["barFontSize"] = 8,
					["offset"] = 2,
					["forceJustifyText"] = "LEFT",
				},
				["zCT-Pal-HolyAvenger"] = {
					["shouldAnimate"] = false,
					["class"] = "PALADIN",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.4509803921568628,
						["b"] = 0.2,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "HA",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "buff",
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 34,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["offset"] = 2,
					["barVerticalOffset"] = 45,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "105809",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["textHorizontalOffset"] = 3,
					["widthModifier"] = -34,
					["shouldUseOverride"] = false,
					["scale"] = 0.6849999999999999,
					["lockUpperTextAlpha"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = 21,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["MirrorBarAdv"] = {
					["scale"] = 0.85,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = true,
					["myTagVersion"] = 3,
					["barVerticalOffset"] = 15,
					["textHorizontalOffset"] = -6,
					["barHorizontalOffset"] = -4,
					["barFontSize"] = 8,
					["enabled"] = true,
				},
				["TargetTargetCast"] = {
					["AuraIconSize"] = 27,
					["barHorizontalOffset"] = 12,
					["forceJustifyText"] = "LEFT",
					["textVerticalOffset"] = 4,
					["myTagVersion"] = 3,
					["barVerticalOffset"] = 32,
					["widthModifier"] = -16,
					["scale"] = 0.75,
					["textHorizontalOffset"] = 18,
					["shouldUseOverride"] = true,
					["barTextureOverride"] = "CleanCurves",
					["offset"] = 3,
					["textVisible"] = {
						["lower"] = false,
					},
					["barFontSize"] = 8,
				},
				["zCT-Rog-Rupture"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.7843137254901961,
						["g"] = 0,
						["b"] = 0,
					},
					["barHorizontalOffset"] = 3,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "R",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
					["class"] = "ROGUE",
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["offset"] = 2,
					["textVerticalOffset"] = 5,
					["barVerticalOffset"] = 27.5,
					["scale"] = 0.775,
					["side"] = "RIGHT",
					["buffToTrack"] = "1943",
					["textHorizontalOffset"] = -7,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["RogueLegendary"] = {
					["barVerticalOffset"] = 45,
					["side"] = "LEFT",
					["scale"] = 0.6849999999999999,
					["widthModifier"] = -34,
					["textVerticalOffset"] = 34,
					["barHorizontalOffset"] = 21,
					["myTagVersion"] = 3,
					["offset"] = 2,
					["forceJustifyText"] = "LEFT",
				},
				["zCT-Dru-TigersFury"] = {
					["shouldAnimate"] = false,
					["class"] = "DRUID",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.1529411764705883,
						["b"] = 0,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "T",
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
					["barFontSize"] = 8,
					["textVerticalOffset"] = 14,
					["barHorizontalOffset"] = 5,
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["buffOrDebuff"] = "buff",
					["barVerticalOffset"] = 33,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "5217",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["textHorizontalOffset"] = 8,
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["scale"] = 0.745,
					["lockUpperTextAlpha"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["enabled"] = true,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Dru-Berserk"] = {
					["shouldAnimate"] = false,
					["class"] = "DRUID",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.1529411764705883,
						["r"] = 1,
					},
					["barHorizontalOffset"] = 5,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "B",
					["lowerText"] = "",
					["scale"] = 0.745,
					["offset"] = 2,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["auraIconXOffset"] = 40,
					["textVerticalOffset"] = 14,
					["barVerticalOffset"] = 33,
					["buffOrDebuff"] = "buff",
					["side"] = "LEFT",
					["buffToTrack"] = "50334",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = 8,
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["lockUpperTextAlpha"] = true,
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["ShroomBar"] = {
					["myTagVersion"] = 3,
				},
				["zCT-War-TasteBlood"] = {
					["shouldAnimate"] = false,
					["class"] = "WARRIOR",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 0,
					},
					["barHorizontalOffset"] = 21,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "TB",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "LEFT",
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["offset"] = 2,
					["textVerticalOffset"] = 34,
					["barVerticalOffset"] = 45,
					["lockUpperTextAlpha"] = true,
					["side"] = "LEFT",
					["buffToTrack"] = "56636",
					["textHorizontalOffset"] = 0,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -34,
					["shouldUseOverride"] = false,
					["lowerText"] = "",
					["scale"] = 0.6849999999999999,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["buffOrDebuff"] = "buff",
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["auraIconXOffset"] = 40,
				},
				["WildMushrooms"] = {
					["barVerticalOffset"] = 33,
					["scale"] = 0.745,
					["lockUpperTextAlpha"] = true,
					["barHorizontalOffset"] = 5,
					["textVerticalOffset"] = 15,
					["textHorizontalOffset"] = -2,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "LEFT",
					["widthModifier"] = -22,
				},
				["Stagger"] = {
					["barVerticalOffset"] = 39,
					["widthModifier"] = -28,
					["forceJustifyText"] = "LEFT",
					["textVerticalOffset"] = 24,
					["scale"] = 0.715,
					["textHorizontalOffset"] = 3,
					["myTagVersion"] = 3,
					["barHorizontalOffset"] = 13,
				},
				["SavageRoar"] = {
					["barVerticalOffset"] = 28,
					["side"] = "LEFT",
					["forceJustifyText"] = "LEFT",
					["textHorizontalOffset"] = 10,
					["barHorizontalOffset"] = -3,
					["scale"] = 0.775,
					["textVerticalOffset"] = 4,
					["offset"] = 2,
					["barFontSize"] = 8,
					["myTagVersion"] = 3,
					["widthModifier"] = -16,
				},
				["HungerForBlood"] = {
					["offset"] = 1,
					["side"] = "LEFT",
					["forceJustifyText"] = "LEFT",
					["textHorizontalOffset"] = 4,
					["widthModifier"] = -22,
					["enabled"] = true,
					["textVerticalOffset"] = -18,
					["barVerticalOffset"] = 27,
					["barFontSize"] = 8,
					["myTagVersion"] = 3,
					["scale"] = 0.8,
				},
				["zCT-War-Victorious"] = {
					["shouldAnimate"] = false,
					["class"] = "WARRIOR",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.392156862745098,
						["b"] = 0,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "V",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "buff",
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["textVerticalOffset"] = 14,
					["offset"] = 2,
					["barVerticalOffset"] = 33,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "32216",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["textHorizontalOffset"] = 14,
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["scale"] = 0.745,
					["lockUpperTextAlpha"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = 5,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["FocusCast"] = {
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
					["forceJustifyText"] = "RIGHT",
					["enabled"] = true,
					["barFontSize"] = 8,
					["textVisible"] = {
						["lower"] = false,
					},
				},
				["zCT-War-Enrage2"] = {
					["shouldAnimate"] = false,
					["class"] = "WARRIOR",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.1372549019607843,
						["b"] = 0,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "E",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.775,
					["scaleManaColor"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 5,
					["barHorizontalOffset"] = -3,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 27,
					["exactMatch"] = true,
					["side"] = "LEFT",
					["buffToTrack"] = "12880",
					["textHorizontalOffset"] = 24,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["lowerText"] = "",
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["buffOrDebuff"] = "buff",
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
				},
				["zCT-Pri-DarkEvangelism"] = {
					["shouldAnimate"] = false,
					["class"] = "PRIEST",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.6470588235294118,
						["g"] = 0.6470588235294118,
						["b"] = 0.9215686274509803,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "DE",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "buff",
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 5,
					["lowerText"] = "",
					["myTagVersion"] = 3,
					["offset"] = 2,
					["forceJustifyText"] = "LEFT",
					["barVerticalOffset"] = 28,
					["scale"] = 0.775,
					["side"] = "LEFT",
					["buffToTrack"] = "87118",
					["textHorizontalOffset"] = 17,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["lockUpperTextAlpha"] = true,
					["exactMatch"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = -3,
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
				},
				["Wild Mushrooms"] = {
					["offset"] = -3,
					["myTagVersion"] = 3,
				},
				["zCT-Dru-Rip"] = {
					["shouldAnimate"] = false,
					["class"] = "DRUID",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.7843137254901961,
						["g"] = 0,
						["b"] = 0,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Ri",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "debuff",
					["barHorizontalOffset"] = 3,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 5,
					["scale"] = 0.775,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["exactMatch"] = true,
					["barVerticalOffset"] = 27.5,
					["forceJustifyText"] = "RIGHT",
					["side"] = "RIGHT",
					["buffToTrack"] = "1079",
					["textHorizontalOffset"] = -1,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["lockUpperTextAlpha"] = true,
					["lowerText"] = "",
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
						["spec2"] = true,
					},
				},
				["BanditsGuile"] = {
					["scale"] = 0.745,
					["textVerticalOffset"] = 14,
					["myTagVersion"] = 3,
					["barVerticalOffset"] = 33,
					["textVisible"] = {
						["lower"] = false,
					},
					["offset"] = 2,
					["textHorizontalOffset"] = 13,
					["widthModifier"] = -22,
					["forceJustifyText"] = "LEFT",
					["barHorizontalOffset"] = 5,
				},
				["zCT-Pal-Inquisition"] = {
					["shouldAnimate"] = false,
					["class"] = "PALADIN",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.2235294117647059,
						["g"] = 0.8549019607843137,
						["r"] = 1,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "In",
					["lowerText"] = "",
					["forceJustifyText"] = "LEFT",
					["barHorizontalOffset"] = 5,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["textVerticalOffset"] = 14,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 33,
					["buffOrDebuff"] = "buff",
					["side"] = "LEFT",
					["buffToTrack"] = "84963",
					["textHorizontalOffset"] = 16,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.745,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Mon-TigerPower"] = {
					["class"] = "MONK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["offset"] = 2,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.4392156862745098,
						["g"] = 1,
						["r"] = 0.3254901960784314,
					},
					["barHorizontalOffset"] = -3,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "TP",
					["lowerText"] = "",
					["forceJustifyText"] = "LEFT",
					["textVerticalOffset"] = 5,
					["myTagVersion"] = 3,
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
					["barVerticalOffset"] = 27.5,
					["bAllowExpand"] = true,
					["side"] = "LEFT",
					["lowThreshold"] = 0,
					["buffOrDebuff"] = "buff",
					["textVisible"] = {
						["lower"] = true,
						["upper"] = true,
					},
					["scale"] = 0.775,
					["widthModifier"] = -16,
					["lockUpperTextAlpha"] = true,
					["enabled"] = true,
					["lowerTextVisible"] = false,
					["buffToTrack"] = "125359",
					["textHorizontalOffset"] = -1,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["buffTimerDisplay"] = "minutes",
				},
				["zCT-Pri-VampTouch"] = {
					["shouldAnimate"] = false,
					["class"] = "PRIEST",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.9215686274509803,
						["g"] = 0.6470588235294118,
						["r"] = 0.6470588235294118,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "VT",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
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
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["buffOrDebuff"] = "debuff",
					["myTagVersion"] = 3,
					["offset"] = 2,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 27.5,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "34914",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = -18,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["scale"] = 0.775,
					["textVerticalOffset"] = 5,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = 3,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["WeakenedBlows"] = {
					["barVerticalOffset"] = 27.5,
					["barHorizontalOffset"] = 3,
					["forceJustifyText"] = "RIGHT",
					["textVerticalOffset"] = 5,
					["scale"] = 0.775,
					["textHorizontalOffset"] = -1,
					["myTagVersion"] = 3,
					["widthModifier"] = -16,
				},
				["zCT-Pal-ArdentDefender"] = {
					["shouldAnimate"] = false,
					["class"] = "PALADIN",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.2,
						["g"] = 0.4509803921568628,
						["r"] = 1,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "AD",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "LEFT",
					["offset"] = 2,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["lowerText"] = "",
					["myTagVersion"] = 3,
					["auraIconXOffset"] = 40,
					["buffOrDebuff"] = "buff",
					["barVerticalOffset"] = 45,
					["scale"] = 0.6849999999999999,
					["side"] = "LEFT",
					["buffToTrack"] = "31850",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = 3,
					["widthModifier"] = -34,
					["shouldUseOverride"] = false,
					["lockUpperTextAlpha"] = true,
					["textVerticalOffset"] = 34,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = 21,
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Sha-EarthShock"] = {
					["shouldAnimate"] = false,
					["class"] = "SHAMAN",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.5882352941176471,
						["b"] = 0,
					},
					["barHorizontalOffset"] = -4,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Ea",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.745,
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
					["barFontSize"] = 8,
					["textVerticalOffset"] = 14,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["buffOrDebuff"] = "debuff",
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 33,
					["exactMatch"] = true,
					["side"] = "RIGHT",
					["buffToTrack"] = "8042",
					["textHorizontalOffset"] = -6,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["lowerText"] = "",
					["forceJustifyText"] = "RIGHT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-War-Enrage"] = {
					["shouldAnimate"] = false,
					["class"] = "WARRIOR",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.1372549019607843,
						["r"] = 1,
					},
					["barHorizontalOffset"] = -3,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "E",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.775,
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 5,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["myTagVersion"] = 3,
					["forceJustifyText"] = "LEFT",
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 27,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "12880",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = 24,
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["exactMatch"] = true,
					["buffOrDebuff"] = "buff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["offset"] = 2,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["auraIconXOffset"] = 40,
				},
				["zCT-Dru-Moonfire"] = {
					["shouldAnimate"] = false,
					["class"] = "DRUID",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.1882352941176471,
						["g"] = 0.4196078431372549,
						["b"] = 0.8666666666666667,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Mf",
					["lowerText"] = "",
					["forceJustifyText"] = "RIGHT",
					["auraIconXOffset"] = 40,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["buffOrDebuff"] = "debuff",
					["myTagVersion"] = 3,
					["enabled"] = true,
					["textVerticalOffset"] = 5,
					["barVerticalOffset"] = 27.5,
					["scale"] = 0.775,
					["side"] = "RIGHT",
					["buffToTrack"] = "8921",
					["textHorizontalOffset"] = -1,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["lockUpperTextAlpha"] = true,
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = 3,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = true,
						["spec2"] = true,
					},
				},
				["Vengeance"] = {
					["barVerticalOffset"] = 27.5,
					["scale"] = 0.775,
					["textVisible"] = {
						["lower"] = false,
					},
					["widthModifier"] = -16,
					["barHorizontalOffset"] = -3,
					["textVerticalOffset"] = 5,
					["myTagVersion"] = 3,
					["barFontSize"] = 8,
					["offset"] = 2,
					["forceJustifyText"] = "LEFT",
				},
				["zCT-Pal-AvengingWrath"] = {
					["shouldAnimate"] = false,
					["class"] = "PALADIN",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.9137254901960784,
						["b"] = 0.5215686274509804,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "AW",
					["lowerText"] = "",
					["buffOrDebuff"] = "buff",
					["scaleManaColor"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["auraIconXOffset"] = 40,
					["myTagVersion"] = 3,
					["buffTimerDisplay"] = "seconds",
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 28,
					["forceJustifyText"] = "LEFT",
					["side"] = "LEFT",
					["buffToTrack"] = "31884",
					["textHorizontalOffset"] = 0,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -16,
					["shouldUseOverride"] = false,
					["textVerticalOffset"] = 4,
					["scale"] = 0.775,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["offset"] = 2,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["barHorizontalOffset"] = -3,
				},
				["zCT-Mag-FingersFrost"] = {
					["shouldAnimate"] = false,
					["class"] = "MAGE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.788235294117647,
						["r"] = 0,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "FF",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "buff",
					["barHorizontalOffset"] = -3,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 5,
					["scale"] = 0.775,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 27.5,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "44544",
					["textHorizontalOffset"] = -1,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["forceJustifyText"] = "LEFT",
					["exactMatch"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["barFontSize"] = 8,
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
				},
				["zCT-Mag-Frostfire(G)"] = {
					["shouldAnimate"] = false,
					["class"] = "MAGE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "FFB",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
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
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["buffOrDebuff"] = "debuff",
					["myTagVersion"] = 3,
					["offset"] = 2,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 27.5,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "61205",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = -12,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["scale"] = 0.775,
					["textVerticalOffset"] = 5,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = 3,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["MirrorBar"] = {
					["enabled"] = true,
					["myTagVersion"] = 3,
				},
				["zCT-Mon-VitalMists"] = {
					["class"] = "MONK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.7098039215686275,
						["g"] = 1,
						["r"] = 0.1490196078431373,
					},
					["barHorizontalOffset"] = 5,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "VM",
					["lowerText"] = "",
					["forceJustifyText"] = "LEFT",
					["textVerticalOffset"] = 14,
					["myTagVersion"] = 3,
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
					["barVerticalOffset"] = 33,
					["bAllowExpand"] = true,
					["side"] = "LEFT",
					["lowThreshold"] = 0,
					["buffOrDebuff"] = "buff",
					["textVisible"] = {
						["lower"] = true,
						["upper"] = true,
					},
					["scale"] = 0.745,
					["widthModifier"] = -22,
					["lockUpperTextAlpha"] = true,
					["enabled"] = true,
					["lowerTextVisible"] = false,
					["buffToTrack"] = "118674 ",
					["textHorizontalOffset"] = 9,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["buffTimerDisplay"] = "minutes",
				},
				["zCT-Pri-MindSpike"] = {
					["shouldAnimate"] = false,
					["class"] = "PRIEST",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.2,
						["r"] = 0.2941176470588235,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "MS",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "buff",
					["barHorizontalOffset"] = 13,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["enabled"] = true,
					["textVerticalOffset"] = 24,
					["barVerticalOffset"] = 39,
					["scale"] = 0.715,
					["side"] = "LEFT",
					["buffToTrack"] = "33371",
					["textHorizontalOffset"] = -1,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["shouldUseOverride"] = false,
					["widthModifier"] = -28,
					["lockUpperTextAlpha"] = true,
					["lowerText"] = "",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["barFontSize"] = 8,
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
				},
				["SliceAndDice"] = {
					["scale"] = 0.775,
					["textVisible"] = {
						["lower"] = false,
					},
					["textVerticalOffset"] = 5,
					["myTagVersion"] = 3,
					["barVerticalOffset"] = 27.5,
					["offset"] = 2,
					["side"] = "LEFT",
					["textHorizontalOffset"] = 6,
					["barHorizontalOffset"] = -3,
					["forceJustifyText"] = "LEFT",
					["barFontSize"] = 8,
					["widthModifier"] = -16,
				},
				["zCT-Rog-Envenom"] = {
					["shouldAnimate"] = false,
					["class"] = "ROGUE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0,
						["g"] = 0.7843137254901961,
						["b"] = 0,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "E",
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
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["scale"] = 0.745,
					["textVerticalOffset"] = 14,
					["barVerticalOffset"] = 33,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "32645",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["textHorizontalOffset"] = 14,
					["widthModifier"] = -22,
					["shouldUseOverride"] = false,
					["buffOrDebuff"] = "buff",
					["lockUpperTextAlpha"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = 5,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["BurningEmbersBar"] = {
					["barVerticalOffset"] = 27,
					["barHorizontalOffset"] = -3,
					["scale"] = 0.775,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "LEFT",
					["widthModifier"] = -16,
				},
				["zCT-Pal-DivineProtection"] = {
					["shouldAnimate"] = false,
					["class"] = "PALADIN",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.22,
						["g"] = 0.65,
						["r"] = 1,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "DP",
					["lowerText"] = "",
					["scale"] = 0.715,
					["scaleManaColor"] = true,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "LEFT",
					["barVerticalOffset"] = 39,
					["lockUpperTextAlpha"] = true,
					["side"] = "LEFT",
					["buffToTrack"] = "498",
					["textVerticalOffset"] = 24,
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = 9,
					["buffOrDebuff"] = "buff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = 13,
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["auraIconXOffset"] = 40,
				},
				["zCT-War-MeatCleaver"] = {
					["shouldAnimate"] = false,
					["class"] = "WARRIOR",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 1,
						["r"] = 1,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "MC",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.6849999999999999,
					["scaleManaColor"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["barHorizontalOffset"] = 21,
					["myTagVersion"] = 3,
					["buffOrDebuff"] = "buff",
					["textVerticalOffset"] = 34,
					["barVerticalOffset"] = 45,
					["lockUpperTextAlpha"] = true,
					["side"] = "LEFT",
					["buffToTrack"] = "85739",
					["lowerText"] = "",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["widthModifier"] = -34,
					["shouldUseOverride"] = false,
					["textHorizontalOffset"] = 0,
					["forceJustifyText"] = "LEFT",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["offset"] = 2,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["auraIconXOffset"] = 40,
				},
				["zCT-Rog-Revealing"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.3490196078431372,
						["b"] = 0,
					},
					["barHorizontalOffset"] = -4,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "RS",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["scaleManaColor"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 14,
					["class"] = "ROGUE",
					["myTagVersion"] = 3,
					["enabled"] = true,
					["exactMatch"] = true,
					["barVerticalOffset"] = 33.5,
					["scale"] = 0.74,
					["side"] = "RIGHT",
					["buffToTrack"] = "84617",
					["forceJustifyText"] = "RIGHT",
					["textHorizontalOffset"] = 0,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
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
				},
				["zCT-Sha-FlameShock"] = {
					["shouldAnimate"] = false,
					["class"] = "SHAMAN",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0,
						["r"] = 0.8627450980392157,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Fl",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
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
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["buffOrDebuff"] = "debuff",
					["myTagVersion"] = 3,
					["offset"] = 2,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 27.5,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "8050",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = -17,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["scale"] = 0.775,
					["textVerticalOffset"] = 5,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = 3,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Dru-Rake"] = {
					["shouldAnimate"] = false,
					["class"] = "DRUID",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.3882352941176471,
						["r"] = 1,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Ra",
					["lowerText"] = "",
					["scale"] = 0.745,
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
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["textVerticalOffset"] = 14,
					["forceJustifyText"] = "RIGHT",
					["barVerticalOffset"] = 33,
					["buffOrDebuff"] = "debuff",
					["side"] = "RIGHT",
					["buffToTrack"] = "1822",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = -1,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["lockUpperTextAlpha"] = true,
					["buffTimerDisplay"] = "seconds",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = -4,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = true,
						["spec2"] = true,
					},
				},
				["EclipseBar"] = {
					["offset"] = 2,
					["scale"] = 0.775,
					["textHorizontalOffset"] = -20,
					["barHorizontalOffset"] = -3,
					["barVerticalOffset"] = 27.5,
					["forceJustifyText"] = "LEFT",
					["textVerticalOffset"] = 94,
					["myTagVersion"] = 3,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = true,
					["widthModifier"] = -16,
				},
				["zCT-Wlock-Immolate"] = {
					["shouldAnimate"] = false,
					["class"] = "WARLOCK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.09803921568627451,
						["r"] = 0.6862745098039216,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Im",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "debuff",
					["barHorizontalOffset"] = -4,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 14,
					["forceJustifyText"] = "RIGHT",
					["myTagVersion"] = 3,
					["enabled"] = true,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 33,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "348",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = -16,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["exactMatch"] = true,
					["scale"] = 0.745,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
				},
				["DemonicFuryBar"] = {
					["barVerticalOffset"] = 27,
					["widthModifier"] = -16,
					["forceJustifyText"] = "LEFT",
					["myTagVersion"] = 3,
					["scale"] = 0.775,
					["barHorizontalOffset"] = -3,
				},
				["zCT-Wlock-BoA"] = {
					["shouldAnimate"] = false,
					["class"] = "WARLOCK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 0.3098039215686275,
						["r"] = 0.4745098039215686,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "BA",
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "debuff",
					["barHorizontalOffset"] = -11,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 24,
					["forceJustifyText"] = "RIGHT",
					["myTagVersion"] = 3,
					["enabled"] = true,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 39,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "980",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = -5,
					["shouldUseOverride"] = false,
					["widthModifier"] = -28,
					["exactMatch"] = true,
					["scale"] = 0.715,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Wlock-BoD"] = {
					["shouldAnimate"] = false,
					["class"] = "WARLOCK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.4666666666666667,
						["g"] = 0.2980392156862745,
						["b"] = 1,
					},
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "BD",
					["lowerText"] = "",
					["scale"] = 0.715,
					["enabled"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 24,
					["auraIconXOffset"] = 40,
					["myTagVersion"] = 3,
					["forceJustifyText"] = "RIGHT",
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 39,
					["exactMatch"] = true,
					["side"] = "RIGHT",
					["buffToTrack"] = "603",
					["textHorizontalOffset"] = -6,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["buffTimerDisplay"] = "seconds",
					["buffOrDebuff"] = "debuff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = -11,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Mon-Shuffle"] = {
					["shouldAnimate"] = false,
					["lockUpperTextAlpha"] = true,
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["spec"] = {
						["spec3"] = false,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = false,
					},
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.8627450980392157,
						["g"] = 0.4313725490196079,
						["b"] = 0,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "Sh",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.745,
					["scaleManaColor"] = true,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["auraIconXOffset"] = 40,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["class"] = "MONK",
					["barVerticalOffset"] = 33,
					["buffOrDebuff"] = "buff",
					["side"] = "LEFT",
					["buffToTrack"] = "115307",
					["forceJustifyText"] = "LEFT",
					["textHorizontalOffset"] = 9,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["lowerText"] = "",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["textVerticalOffset"] = 14,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["barHorizontalOffset"] = 5,
				},
				["zCT-Wlock-ShadowAndFlame"] = {
					["shouldAnimate"] = false,
					["class"] = "WARLOCK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 0.2980392156862745,
						["g"] = 0.4274509803921568,
						["b"] = 1,
					},
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "SF",
					["lowerText"] = "",
					["scale"] = 0.6849999999999999,
					["barHorizontalOffset"] = -18,
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["exactMatch"] = true,
					["buffTimerDisplay"] = "seconds",
					["myTagVersion"] = 3,
					["enabled"] = true,
					["textVerticalOffset"] = 34,
					["barVerticalOffset"] = 45,
					["buffOrDebuff"] = "debuff",
					["side"] = "RIGHT",
					["buffToTrack"] = "17800",
					["textHorizontalOffset"] = -1,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["widthModifier"] = -34,
					["shouldUseOverride"] = false,
					["forceJustifyText"] = "RIGHT",
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
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Hun-SerpentSting"] = {
					["shouldAnimate"] = false,
					["class"] = "HUNTER",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0.2274509803921569,
						["g"] = 0.9019607843137255,
						["r"] = 0.3058823529411765,
					},
					["auraIconXOffset"] = 40,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "SS",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
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
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["buffOrDebuff"] = "debuff",
					["myTagVersion"] = 3,
					["offset"] = 2,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 27.5,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "1978",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = 2,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["scale"] = 0.775,
					["textVerticalOffset"] = 5,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["barHorizontalOffset"] = 3,
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-War-DeadlyCalm"] = {
					["shouldAnimate"] = false,
					["class"] = "WARRIOR",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.6666666666666666,
						["b"] = 0,
					},
					["barHorizontalOffset"] = 13,
					["maxDuration"] = 0,
					["myUnit"] = "player",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "DC",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.715,
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
					["barFontSize"] = 8,
					["textVerticalOffset"] = 24,
					["enabled"] = true,
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["buffOrDebuff"] = "buff",
					["barVerticalOffset"] = 39,
					["lowerText"] = "",
					["side"] = "LEFT",
					["buffToTrack"] = "85730",
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["textHorizontalOffset"] = 6,
					["widthModifier"] = -28,
					["shouldUseOverride"] = false,
					["forceJustifyText"] = "LEFT",
					["lockUpperTextAlpha"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["trackOnlyMine"] = true,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Mag-Ignite"] = {
					["shouldAnimate"] = false,
					["class"] = "MAGE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
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
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "IG",
					["buffTimerDisplay"] = "seconds",
					["forceJustifyText"] = "RIGHT",
					["barHorizontalOffset"] = -4,
					["alwaysFullAlpha"] = false,
					["trackOnlyMine"] = true,
					["exactMatch"] = true,
					["textVerticalOffset"] = 14,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["lockUpperTextAlpha"] = true,
					["barVerticalOffset"] = 33,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "12654",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = -15,
					["shouldUseOverride"] = false,
					["widthModifier"] = -22,
					["scale"] = 0.745,
					["buffOrDebuff"] = "debuff",
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["barFontSize"] = 8,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = false,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["zCT-Mag-LivingBomb"] = {
					["shouldAnimate"] = false,
					["class"] = "MAGE",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["markers"] = {
					},
					["desiredLerpTime"] = 0,
					["offset"] = 2,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["b"] = 0,
						["g"] = 0.5372549019607843,
						["r"] = 1,
					},
					["barHorizontalOffset"] = -18,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "LB",
					["buffTimerDisplay"] = "seconds",
					["scale"] = 0.6849999999999999,
					["auraIconXOffset"] = 40,
					["upperTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["trackOnlyMine"] = true,
					["textVerticalOffset"] = 34,
					["exactMatch"] = true,
					["myTagVersion"] = 3,
					["buffOrDebuff"] = "debuff",
					["enabled"] = true,
					["barVerticalOffset"] = 45,
					["lowerText"] = "",
					["side"] = "RIGHT",
					["buffToTrack"] = "44457",
					["textVisible"] = {
						["lower"] = false,
						["upper"] = true,
					},
					["textHorizontalOffset"] = 0,
					["shouldUseOverride"] = false,
					["widthModifier"] = -34,
					["forceJustifyText"] = "RIGHT",
					["lockUpperTextAlpha"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["lowerTextColor"] = {
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["barFontSize"] = 8,
					["alwaysFullAlpha"] = false,
					["spec"] = {
						["spec3"] = true,
						["spec1"] = true,
						["spec4"] = false,
						["spec2"] = true,
					},
				},
				["TargetInvuln"] = {
					["forceJustifyText"] = "LEFT",
					["displayAuraIcon"] = true,
					["auraIconYOffset"] = -7,
					["textVerticalOffset"] = 22,
					["myTagVersion"] = 3,
					["enabled"] = true,
					["auraIconXOffset"] = -50,
					["textHorizontalOffset"] = 59,
					["auraIconSize"] = 28,
					["widthModifier"] = -16,
					["barVerticalOffset"] = 32,
					["lockLowerTextAlpha"] = true,
					["scale"] = 0.75,
					["barHorizontalOffset"] = 12,
				},
				["TargetCC"] = {
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
				},
			},
			["fontFamily"] = "pixel_hr_small",
			["alphaicbg"] = 0.5,
			["fontFamilyLarge"] = "pixel_lr_small",
			["detachedTooltip"] = {
			},
			["hidden"] = true,
			["updatePeriod"] = 0.02222222222222222,
			["alphaNotFullbg"] = 0.4,
			["bShouldUseDogTags"] = false,
			["verticalPos"] = -134,
			["alphaTarget"] = 0.7000000000000001,
			["minimap"] = {
				["hide"] = true,
			},
			["alphaNotFull"] = 0.7000000000000001,
			["updatedOocNotFull"] = true,
			["scale"] = 1,
			["alphaoocbg"] = 0.25,
			["colors"] = {
				["ScaledManaColor"] = {
					["r"] = 1,
				},
				["CastNotInRange"] = {
					["r"] = 0.3529411764705882,
					["g"] = 0.3529411764705882,
					["b"] = 0.3529411764705882,
				},
				["CastCasting"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["EclipseLunar"] = {
					["b"] = 0.392156862745098,
					["g"] = 0.392156862745098,
					["r"] = 0.392156862745098,
				},
				["SliceAndDice"] = {
					["r"] = 1,
					["b"] = 1,
				},
				["CastSuccess"] = {
					["r"] = 0.3882352941176471,
					["g"] = 0.7137254901960785,
					["b"] = 0.1764705882352941,
				},
				["EclipseSolarActive"] = {
					["b"] = 0.2,
					["g"] = 1,
					["r"] = 1,
				},
				["BREATH"] = {
					["g"] = 0.7411764705882353,
					["r"] = 0.3019607843137255,
				},
				["EclipseLunarActive"] = {
					["g"] = 0.3176470588235294,
					["r"] = 0.3176470588235294,
				},
				["EclipseSolar"] = {
					["b"] = 0.6627450980392157,
					["g"] = 0.6627450980392157,
					["r"] = 0.6627450980392157,
				},
				["CastNotInterruptible"] = {
					["r"] = 0.7843137254901961,
					["g"] = 0.4313725490196079,
					["b"] = 0.4313725490196079,
				},
				["ScaledHealthColor"] = {
					["g"] = 0,
					["r"] = 1,
				},
				["CastChanneling"] = {
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
			},
			["gap"] = 140,
			["alphaic"] = 0.8,
			["alphaTargetbg"] = 0.4,
		},
	},
}









--------------------
---- nibMinimap ----
--------------------
nibMinimapDB = {
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI-HR",
	},
	["profiles"] = {
		["RealUI"] = {
			["information"] = {
				["font"] = {
					["name"] = "pixel_lr_small",
				},
			},
		},
		["Default"] = {
		},
		["RealUI-HR"] = {
			["information"] = {
				["font"] = {
					["name"] = "pixel_hr_small",
					["gap"] = 6,
				},
			},
		},
	},
}






--------------------------------
---- nibPointDisplay_RealUI ----
--------------------------------

nibPointDisplayRUIDB = {
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI-HR",
	},
	["profiles"] = {
		["RealUI"] = {
			["GENERAL"] = {
				["types"] = {
					["cp"] = {
						["general"] = {
							["direction"] = {
								["reverse"] = true,
							},
							["hidein"] = {
								["vehicle"] = false,
							},
						},
						["position"] = {
							["y"] = -37,
							["x"] = 56,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.800000011920929,
									},
								},
							},
						},
					},
				},
			},
			["WARRIOR"] = {
				["types"] = {
					["mc"] = {
						["position"] = {
							["y"] = -31,
							["x"] = -60,
						},
						["bars"] = {
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
					},
					["ts"] = {
						["position"] = {
							["y"] = -47,
							["x"] = -60,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.2784313725490196,
										["g"] = 0.6627450980392157,
										["b"] = 0.8,
									},
									["maxcolor"] = {
										["g"] = 0.8352941176470589,
										["r"] = 0.3725490196078432,
									},
								},
							},
						},
					},
					["sa"] = {
						["general"] = {
							["direction"] = {
								["reverse"] = true,
							},
						},
						["position"] = {
							["y"] = -38,
							["x"] = 76,
						},
					},
					["tb"] = {
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
										["b"] = 0.1215686274509804,
										["g"] = 0.5333333333333333,
										["r"] = 0.807843137254902,
									},
									["maxcolor"] = {
										["g"] = 0.6627450980392157,
										["b"] = 0.1490196078431373,
									},
								},
							},
						},
					},
				},
			},
			["PALADIN"] = {
				["types"] = {
					["hp"] = {
						["position"] = {
							["y"] = -114,
						},
						["bars"] = {
							["custom"] = true,
							["position"] = {
								["gap"] = -64,
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.9,
										["b"] = 0.5,
									},
									["maxcolor"] = {
										["b"] = 0.2,
									},
								},
							},
							["size"] = {
								["height"] = 64,
								["width"] = 64,
							},
						},
					},
				},
			},
			["MAGE"] = {
				["types"] = {
					["ab"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -79,
						},
					},
					["ff"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -93,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["b"] = 0.7803921568627451,
										["g"] = 0.615686274509804,
										["r"] = 0,
									},
									["maxcolor"] = {
										["g"] = 0.788235294117647,
										["r"] = 0,
									},
								},
							},
						},
					},
				},
			},
			["PRIEST"] = {
				["types"] = {
					["ms"] = {
						["position"] = {
							["y"] = -69,
							["x"] = -71,
						},
						["bars"] = {
							["surround"] = {
								["texture"] = "Round_Small_Surround",
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.8100000023841858,
										["b"] = 0.7058823529411764,
										["g"] = 0.1411764705882353,
										["r"] = 0.2078431372549019,
									},
									["maxcolor"] = {
										["g"] = 0.2,
										["r"] = 0.2941176470588235,
									},
									["texture"] = "Round_Small_BG",
								},
								["empty"] = {
									["texture"] = "Round_Small_BG",
								},
							},
						},
					},
					["deva"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -54,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.5098039215686274,
										["g"] = 0.5137254901960784,
										["b"] = 0.7254901960784314,
									},
									["maxcolor"] = {
										["r"] = 0.6470588235294118,
										["g"] = 0.6470588235294118,
										["b"] = 0.9215686274509803,
									},
								},
							},
						},
					},
					["eva"] = {
						["position"] = {
							["y"] = -38,
							["x"] = -62,
						},
					},
					["so"] = {
						["position"] = {
							["y"] = -53,
							["x"] = -67,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.4156862745098039,
										["g"] = 0.3254901960784314,
										["b"] = 0.7215686274509804,
									},
									["maxcolor"] = {
										["r"] = 0.5333333333333333,
										["g"] = 0.4156862745098039,
										["b"] = 0.9215686274509803,
									},
								},
							},
						},
					},
					["ser"] = {
						["position"] = {
							["y"] = -38,
							["x"] = -100,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["b"] = 0.7568627450980392,
										["g"] = 0.611764705882353,
										["r"] = 0,
									},
									["maxcolor"] = {
										["g"] = 0.807843137254902,
										["r"] = 0,
									},
								},
								["empty"] = {
									["color"] = {
										["r"] = 0.1411764705882353,
										["g"] = 0.1411764705882353,
										["b"] = 0.1411764705882353,
									},
								},
							},
						},
					},
				},
			},
			["SHAMAN"] = {
				["types"] = {
					["tw"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -101,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.1254901960784314,
										["g"] = 0.6470588235294118,
										["b"] = 0.796078431372549,
									},
									["maxcolor"] = {
										["g"] = 0.7843137254901961,
										["r"] = 0.05098039215686274,
									},
								},
							},
						},
					},
					["ls"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -73,
						},
					},
					["ws"] = {
						["position"] = {
							["y"] = -53,
							["x"] = -93,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.1607843137254902,
										["g"] = 0.4313725490196079,
										["b"] = 0.8117647058823529,
									},
									["maxcolor"] = {
										["g"] = 0.5333333333333333,
										["r"] = 0.2,
									},
								},
							},
						},
					},
					["mw"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -80,
						},
					},
				},
			},
			["WARLOCK"] = {
				["types"] = {
					["be"] = {
						["configmode"] = {
							["count"] = 4,
						},
						["general"] = {
							["smarthide"] = true,
						},
						["position"] = {
							["y"] = -38,
							["x"] = -70,
						},
						["bars"] = {
							["surround"] = {
								["color"] = {
									["b"] = 1,
									["g"] = 1,
									["r"] = 1,
								},
								["texture"] = "Soul_Shard_Surround",
							},
							["position"] = {
								["gap"] = -14,
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 1,
										["b"] = 0.04705882352941176,
										["g"] = 0.1686274509803922,
										["r"] = 0.9137254901960784,
									},
									["maxcolor"] = {
										["b"] = 0.04705882352941176,
										["g"] = 0.1686274509803922,
										["r"] = 0.9137254901960784,
									},
									["texture"] = "Soul_Shard_BG",
								},
								["empty"] = {
									["texture"] = "Soul_Shard_BG",
								},
							},
							["size"] = {
								["width"] = 32,
							},
						},
					},
					["mco"] = {
						["position"] = {
							["y"] = -55,
							["x"] = -80,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.800000011920929,
										["b"] = 0.1215686274509804,
										["g"] = 0.5372549019607843,
										["r"] = 0.8431372549019608,
									},
									["maxcolor"] = {
										["a"] = 0.800000011920929,
										["g"] = 0.6392156862745098,
										["b"] = 0.1490196078431373,
									},
								},
							},
						},
					},
					["ss"] = {
						["general"] = {
							["smarthide"] = true,
						},
						["position"] = {
							["y"] = -38,
							["x"] = -70,
						},
						["bars"] = {
							["surround"] = {
								["color"] = {
									["b"] = 1,
									["g"] = 1,
									["r"] = 1,
								},
								["texture"] = "Soul_Shard_Surround",
							},
							["position"] = {
								["gap"] = -14,
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 1,
										["b"] = 0.8274509803921568,
										["g"] = 0.3803921568627451,
										["r"] = 0.5294117647058824,
									},
									["maxcolor"] = {
										["g"] = 0.4509803921568628,
										["r"] = 0.6352941176470588,
									},
									["texture"] = "Soul_Shard_BG",
								},
								["empty"] = {
									["texture"] = "Soul_Shard_BG",
								},
							},
							["size"] = {
								["width"] = 32,
							},
						},
						["combatfader"] = {
							["enabled"] = true,
							["opacity"] = {
								["outofcombat"] = 0,
							},
						},
					},
				},
			},
			["ROGUE"] = {
				["types"] = {
					["bg"] = {
						["enabled"] = false,
					},
					["dp"] = {
						["general"] = {
							["direction"] = {
								["reverse"] = true,
							},
						},
						["position"] = {
							["y"] = -37,
							["x"] = 56,
							["framelevel"] = {
								["level"] = 4,
							},
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 1,
										["b"] = 0,
										["g"] = 0,
										["r"] = 0.8627450980392157,
									},
									["maxcolor"] = {
										["b"] = 0,
										["g"] = 0,
										["r"] = 0.9882352941176471,
									},
								},
							},
						},
					},
				},
			},
			["HUNTER"] = {
				["types"] = {
					["fe"] = {
						["position"] = {
							["y"] = -53,
							["x"] = -81,
						},
						["bars"] = {
							["surround"] = {
								["texture"] = "Round_Small_Surround",
							},
							["position"] = {
								["gap"] = -3,
							},
							["bg"] = {
								["full"] = {
									["texture"] = "Round_Small_BG",
								},
								["empty"] = {
									["texture"] = "Round_Small_BG",
								},
							},
						},
					},
					["rsa"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -80,
						},
					},
				},
			},
			["DRUID"] = {
				["types"] = {
					["lac"] = {
						["general"] = {
							["direction"] = {
								["reverse"] = true,
							},
						},
						["position"] = {
							["y"] = -52,
							["x"] = 70,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.7843137254901961,
										["g"] = 0.3058823529411765,
										["b"] = 0,
									},
									["maxcolor"] = {
										["g"] = 0.3882352941176471,
										["b"] = 0,
									},
								},
							},
						},
					},
					["wm"] = {
						["position"] = {
							["y"] = -69,
							["x"] = -76,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["b"] = 0.1882352941176471,
										["g"] = 0.6,
										["r"] = 0.7568627450980392,
									},
									["maxcolor"] = {
										["g"] = 0.792156862745098,
										["b"] = 0.2509803921568627,
									},
								},
							},
						},
					},
					["al"] = {
						["position"] = {
							["y"] = -84,
							["x"] = -71,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["b"] = 0.7490196078431373,
										["g"] = 0.4588235294117647,
										["r"] = 0.6823529411764706,
									},
									["maxcolor"] = {
										["g"] = 0.6,
										["r"] = 0.9098039215686274,
									},
								},
							},
						},
					},
					["lus"] = {
						["position"] = {
							["y"] = -54,
							["x"] = -78,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["b"] = 0.8352941176470589,
										["g"] = 0.4156862745098039,
										["r"] = 0.3764705882352941,
									},
									["maxcolor"] = {
										["g"] = 0.4980392156862745,
										["r"] = 0.4509803921568628,
									},
								},
							},
						},
					},
				},
			},
			["MONK"] = {
				["types"] = {
					["tp"] = {
						["position"] = {
							["y"] = -52,
							["x"] = -66,
						},
						["bars"] = {
							["surround"] = {
								["texture"] = "Round_Small_Surround",
							},
							["position"] = {
								["gap"] = -3,
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.8200000077486038,
										["r"] = 0.3490196078431372,
										["b"] = 0.4588235294117647,
									},
									["maxcolor"] = {
										["r"] = 0.3490196078431372,
										["b"] = 0.4588235294117647,
									},
									["texture"] = "Round_Small_BG",
								},
								["empty"] = {
									["texture"] = "Round_Small_BG",
								},
							},
						},
					},
					["sz"] = {
						["position"] = {
							["y"] = -25,
							["x"] = -85,
						},
						["bars"] = {
							["surround"] = {
								["texture"] = "Round_Small_Surround",
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.8200000077486038,
										["r"] = 0.3490196078431372,
										["b"] = 0.4588235294117647,
									},
									["maxcolor"] = {
										["r"] = 0.3490196078431372,
										["b"] = 0.4588235294117647,
									},
									["texture"] = "Round_Small_BG",
								},
								["empty"] = {
									["texture"] = "Round_Small_BG",
								},
							},
						},
					},
					["vm"] = {
						["position"] = {
							["y"] = -52,
							["x"] = -66,
						},
						["bars"] = {
							["surround"] = {
								["texture"] = "Round_Small_Surround",
							},
							["position"] = {
								["gap"] = -3,
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.8100000023841858,
										["r"] = 0.1490196078431373,
										["b"] = 0.7098039215686275,
									},
									["maxcolor"] = {
										["r"] = 0.1490196078431373,
										["b"] = 0.7098039215686275,
									},
									["texture"] = "Round_Small_BG",
								},
								["empty"] = {
									["texture"] = "Round_Small_BG",
								},
							},
						},
						["configmode"] = {
							["count"] = 5,
						},
					},
					["chi"] = {
						["position"] = {
							["y"] = -39,
							["x"] = -63,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.8100000023841858,
										["r"] = 0.9882352941176471,
										["b"] = 0.6980392156862745,
									},
									["maxcolor"] = {
										["r"] = 0.9882352941176471,
										["b"] = 0.6980392156862745,
									},
								},
							},
						},
						["configmode"] = {
							["count"] = 5,
						},
					},
				},
			},
			["DEATHKNIGHT"] = {
				["types"] = {
					["si"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -82,
						},
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.4627450980392157,
										["g"] = 0.4862745098039216,
										["b"] = 0.8,
									},
									["maxcolor"] = {
										["g"] = 0.6274509803921569,
										["r"] = 0.6,
									},
								},
							},
						},
					},
					["bs"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -70,
						},
					},
				},
			},
		},
		["Default"] = {
		},
		["RealUI-HR"] = {
			["GENERAL"] = {
				["types"] = {
					["cp"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.800000011920929,
									},
								},
							},
						},
						["general"] = {
							["direction"] = {
								["reverse"] = true,
							},
							["hidein"] = {
								["vehicle"] = false,
							},
						},
						["position"] = {
							["y"] = -37,
							["x"] = 76,
						},
					},
				},
			},
			["WARRIOR"] = {
				["types"] = {
					["mc"] = {
						["bars"] = {
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
						["position"] = {
							["y"] = -31,
							["x"] = -80,
						},
					},
					["ts"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.2784313725490196,
										["g"] = 0.6627450980392157,
										["b"] = 0.8,
									},
									["maxcolor"] = {
										["g"] = 0.8352941176470589,
										["r"] = 0.3725490196078432,
									},
								},
							},
						},
						["position"] = {
							["y"] = -47,
							["x"] = -80,
						},
					},
					["sa"] = {
						["general"] = {
							["direction"] = {
								["reverse"] = true,
							},
						},
						["position"] = {
							["y"] = -38,
							["x"] = 96,
						},
					},
					["tb"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["b"] = 0.1215686274509804,
										["g"] = 0.5333333333333333,
										["r"] = 0.807843137254902,
									},
									["maxcolor"] = {
										["g"] = 0.6627450980392157,
										["b"] = 0.1490196078431373,
									},
								},
							},
							["position"] = {
								["gap"] = -3,
							},
						},
						["position"] = {
							["y"] = -31,
							["x"] = -68,
						},
					},
				},
			},
			["PALADIN"] = {
				["types"] = {
					["hp"] = {
						["bars"] = {
							["size"] = {
								["height"] = 64,
								["width"] = 64,
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.9,
										["b"] = 0.5,
									},
									["maxcolor"] = {
										["b"] = 0.2,
									},
								},
							},
							["custom"] = true,
							["position"] = {
								["gap"] = -64,
							},
						},
						["position"] = {
							["y"] = -114,
						},
					},
				},
			},
			["MAGE"] = {
				["types"] = {
					["ff"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0,
										["g"] = 0.615686274509804,
										["b"] = 0.7803921568627451,
									},
									["maxcolor"] = {
										["g"] = 0.788235294117647,
										["r"] = 0,
									},
								},
							},
						},
						["position"] = {
							["y"] = -37,
							["x"] = -113,
						},
					},
					["ab"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -99,
						},
					},
				},
			},
			["PRIEST"] = {
				["types"] = {
					["ms"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.8100000023841858,
										["r"] = 0.2078431372549019,
										["g"] = 0.1411764705882353,
										["b"] = 0.7058823529411764,
									},
									["maxcolor"] = {
										["r"] = 0.2078431372549019,
										["g"] = 0.1411764705882353,
										["b"] = 0.7058823529411764,
									},
								},
							},
						},
						["position"] = {
							["y"] = -69,
							["x"] = -91,
						},
					},
					["deva"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.5098039215686274,
										["g"] = 0.5137254901960784,
										["b"] = 0.7254901960784314,
									},
									["maxcolor"] = {
										["r"] = 0.6470588235294118,
										["g"] = 0.6470588235294118,
										["b"] = 0.9215686274509803,
									},
								},
							},
						},
						["position"] = {
							["y"] = -37,
							["x"] = -74,
						},
					},
					["eva"] = {
						["position"] = {
							["y"] = -38,
							["x"] = -82,
						},
					},
					["so"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.4156862745098039,
										["g"] = 0.3254901960784314,
										["b"] = 0.7215686274509804,
									},
									["maxcolor"] = {
										["r"] = 0.5333333333333333,
										["g"] = 0.4156862745098039,
										["b"] = 0.9215686274509803,
									},
								},
							},
						},
						["position"] = {
							["y"] = -53,
							["x"] = -87,
						},
					},
					["ser"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0,
										["g"] = 0.611764705882353,
										["b"] = 0.7568627450980392,
									},
									["maxcolor"] = {
										["g"] = 0.807843137254902,
										["r"] = 0,
									},
								},
								["empty"] = {
									["color"] = {
										["r"] = 0.1411764705882353,
										["g"] = 0.1411764705882353,
										["b"] = 0.1411764705882353,
									},
								},
							},
						},
						["position"] = {
							["y"] = -38,
							["x"] = -120,
						},
					},
				},
			},
			["SHAMAN"] = {
				["types"] = {
					["tw"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.1254901960784314,
										["g"] = 0.6470588235294118,
										["b"] = 0.796078431372549,
									},
									["maxcolor"] = {
										["g"] = 0.7843137254901961,
										["r"] = 0.05098039215686274,
									},
								},
							},
						},
						["position"] = {
							["y"] = -37,
							["x"] = -121,
						},
					},
					["ls"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -93,
						},
					},
					["ws"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.1607843137254902,
										["g"] = 0.4313725490196079,
										["b"] = 0.8117647058823529,
									},
									["maxcolor"] = {
										["g"] = 0.5333333333333333,
										["r"] = 0.2,
									},
								},
							},
						},
						["position"] = {
							["y"] = -53,
							["x"] = -113,
						},
					},
					["mw"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -100,
						},
					},
				},
			},
			["WARLOCK"] = {
				["types"] = {
					["be"] = {
						["configmode"] = {
							["count"] = 4,
						},
						["bars"] = {
							["surround"] = {
								["color"] = {
									["b"] = 1,
									["g"] = 1,
									["r"] = 1,
								},
								["texture"] = "Soul_Shard_Surround",
							},
							["size"] = {
								["width"] = 32,
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 1,
										["b"] = 0.04705882352941176,
										["g"] = 0.1686274509803922,
										["r"] = 0.9137254901960784,
									},
									["maxcolor"] = {
										["b"] = 0.04705882352941176,
										["g"] = 0.1686274509803922,
										["r"] = 0.9137254901960784,
									},
									["texture"] = "Soul_Shard_BG",
								},
								["empty"] = {
									["texture"] = "Soul_Shard_BG",
								},
							},
							["position"] = {
								["gap"] = -14,
							},
						},
						["general"] = {
							["smarthide"] = true,
						},
						["position"] = {
							["y"] = -38,
							["x"] = -90,
						},
					},
					["mco"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.800000011920929,
										["r"] = 0.8431372549019608,
										["g"] = 0.5372549019607843,
										["b"] = 0.1215686274509804,
									},
									["maxcolor"] = {
										["a"] = 0.800000011920929,
										["g"] = 0.6392156862745098,
										["b"] = 0.1490196078431373,
									},
								},
							},
						},
						["position"] = {
							["y"] = -55,
							["x"] = -100,
						},
					},
					["ss"] = {
						["combatfader"] = {
							["enabled"] = true,
							["opacity"] = {
								["outofcombat"] = 0,
							},
						},
						["bars"] = {
							["surround"] = {
								["color"] = {
									["r"] = 1,
									["g"] = 1,
									["b"] = 1,
								},
								["texture"] = "Soul_Shard_Surround",
							},
							["size"] = {
								["width"] = 32,
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 1,
										["r"] = 0.5294117647058824,
										["g"] = 0.3803921568627451,
										["b"] = 0.8274509803921568,
									},
									["maxcolor"] = {
										["g"] = 0.4509803921568628,
										["r"] = 0.6352941176470588,
									},
									["texture"] = "Soul_Shard_BG",
								},
								["empty"] = {
									["texture"] = "Soul_Shard_BG",
								},
							},
							["position"] = {
								["gap"] = -14,
							},
						},
						["general"] = {
							["smarthide"] = true,
						},
						["position"] = {
							["y"] = -38,
							["x"] = -90,
						},
					},
				},
			},
			["ROGUE"] = {
				["types"] = {
					["bg"] = {
						["enabled"] = false,
					},
					["dp"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 1,
										["b"] = 0,
										["g"] = 0,
										["r"] = 0.8627450980392157,
									},
									["maxcolor"] = {
										["b"] = 0,
										["g"] = 0,
										["r"] = 0.9882352941176471,
									},
								},
							},
						},
						["general"] = {
							["direction"] = {
								["reverse"] = true,
							},
						},
						["position"] = {
							["y"] = -37,
							["x"] = 76,
							["framelevel"] = {
								["level"] = 4,
							},
						},
					},
				},
			},
			["HUNTER"] = {
				["types"] = {
					["fe"] = {
						["bars"] = {
							["surround"] = {
								["texture"] = "Round_Small_Surround",
							},
							["bg"] = {
								["full"] = {
									["texture"] = "Round_Small_BG",
								},
								["empty"] = {
									["texture"] = "Round_Small_BG",
								},
							},
							["position"] = {
								["gap"] = -3,
							},
						},
						["position"] = {
							["y"] = -53,
							["x"] = -101,
						},
					},
					["rsa"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -100,
						},
					},
				},
			},
			["DRUID"] = {
				["types"] = {
					["wm"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.7568627450980392,
										["g"] = 0.6,
										["b"] = 0.1882352941176471,
									},
									["maxcolor"] = {
										["g"] = 0.792156862745098,
										["b"] = 0.2509803921568627,
									},
								},
							},
						},
						["position"] = {
							["y"] = -69,
							["x"] = -96,
						},
					},
					["lac"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.7843137254901961,
										["g"] = 0.3058823529411765,
										["b"] = 0,
									},
									["maxcolor"] = {
										["g"] = 0.3882352941176471,
										["b"] = 0,
									},
								},
							},
						},
						["general"] = {
							["direction"] = {
								["reverse"] = true,
							},
						},
						["position"] = {
							["y"] = -52,
							["x"] = 90,
						},
					},
					["al"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.6823529411764706,
										["g"] = 0.4588235294117647,
										["b"] = 0.7490196078431373,
									},
									["maxcolor"] = {
										["g"] = 0.6,
										["r"] = 0.9098039215686274,
									},
								},
							},
						},
						["position"] = {
							["y"] = -84,
							["x"] = -91,
						},
					},
					["lus"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.3764705882352941,
										["g"] = 0.4156862745098039,
										["b"] = 0.8352941176470589,
									},
									["maxcolor"] = {
										["g"] = 0.4980392156862745,
										["r"] = 0.4509803921568628,
									},
								},
							},
						},
						["position"] = {
							["y"] = -54,
							["x"] = -98,
						},
					},
				},
			},
			["MONK"] = {
				["types"] = {
					["tp"] = {
						["bars"] = {
							["surround"] = {
								["texture"] = "Round_Small_Surround",
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.8200000077486038,
										["r"] = 0.3490196078431372,
										["b"] = 0.4588235294117647,
									},
									["maxcolor"] = {
										["r"] = 0.3490196078431372,
										["b"] = 0.4588235294117647,
									},
									["texture"] = "Round_Small_BG",
								},
								["empty"] = {
									["texture"] = "Round_Small_BG",
								},
							},
							["position"] = {
								["gap"] = -3,
							},
						},
						["position"] = {
							["y"] = -52,
							["x"] = -66,
						},
					},
					["sz"] = {
						["bars"] = {
							["surround"] = {
								["texture"] = "Round_Small_Surround",
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.8200000077486038,
										["r"] = 0.3490196078431372,
										["b"] = 0.4588235294117647,
									},
									["maxcolor"] = {
										["r"] = 0.3490196078431372,
										["b"] = 0.4588235294117647,
									},
									["texture"] = "Round_Small_BG",
								},
								["empty"] = {
									["texture"] = "Round_Small_BG",
								},
							},
						},
						["position"] = {
							["y"] = -25,
							["x"] = -85,
						},
					},
					["vm"] = {
						["configmode"] = {
							["count"] = 5,
						},
						["bars"] = {
							["surround"] = {
								["texture"] = "Round_Small_Surround",
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 0.8100000023841858,
										["r"] = 0.1490196078431373,
										["b"] = 0.7098039215686275,
									},
									["maxcolor"] = {
										["r"] = 0.1490196078431373,
										["b"] = 0.7098039215686275,
									},
									["texture"] = "Round_Small_BG",
								},
								["empty"] = {
									["texture"] = "Round_Small_BG",
								},
							},
							["position"] = {
								["gap"] = -3,
							},
						},
						["position"] = {
							["y"] = -52,
							["x"] = -66,
						},
					},
					["chi"] = {
						["configmode"] = {
							["count"] = 5,
						},
						["bars"] = {
							["surround"] = {
								["texture"] = "Round_Larger_Surround",
							},
							["bg"] = {
								["full"] = {
									["color"] = {
										["a"] = 1,
									},
									["texture"] = "Round_Larger_BG",
								},
								["empty"] = {
									["texture"] = "Round_Larger_BG",
								},
							},
							["position"] = {
								["gap"] = 1,
							},
						},
						["position"] = {
							["y"] = -37,
							["x"] = -68,
						},
					},
				},
			},
			["DEATHKNIGHT"] = {
				["types"] = {
					["si"] = {
						["bars"] = {
							["bg"] = {
								["full"] = {
									["color"] = {
										["r"] = 0.4627450980392157,
										["g"] = 0.4862745098039216,
										["b"] = 0.8,
									},
									["maxcolor"] = {
										["g"] = 0.6274509803921569,
										["r"] = 0.6,
									},
								},
							},
						},
						["position"] = {
							["y"] = -37,
							["x"] = -102,
						},
					},
					["bs"] = {
						["position"] = {
							["y"] = -37,
							["x"] = -90,
						},
					},
				},
			},
		},
	},
}







-----------------------------
---- nibSpellAlertConfig ----
-----------------------------

nibSpellAlertConfigDB = {
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI-HR",
	},
	["profiles"] = {
		["RealUI"] = {
			["appearance"] = {
				["opacity"] = 0.75,
			},
			["position"] = {
				["y"] = -56,
			},
			["size"] = {
				["height"] = 110,
				["scale"] = 0.65,
				["width"] = 90,
			},
			["custom"] = {
				{
				}, -- [1]
				{
				}, -- [2]
				nil, -- [3]
				{
				}, -- [4]
				{
				}, -- [5]
				nil, -- [6]
				nil, -- [7]
				{
				}, -- [8]
				{
				}, -- [9]
				{
				}, -- [10]
				nil, -- [11]
				nil, -- [12]
				nil, -- [13]
				nil, -- [14]
				nil, -- [15]
				{
				}, -- [16]
				{
				}, -- [17]
				{
				}, -- [18]
			},
			["framelevel"] = {
				["strata"] = "BACKGROUND",
			},
		},
		["Default"] = {
			["custom"] = {
				{
				}, -- [1]
				{
				}, -- [2]
				nil, -- [3]
				{
				}, -- [4]
				{
				}, -- [5]
				nil, -- [6]
				nil, -- [7]
				{
				}, -- [8]
				{
				}, -- [9]
				{
				}, -- [10]
				nil, -- [11]
				nil, -- [12]
				nil, -- [13]
				nil, -- [14]
				nil, -- [15]
				{
				}, -- [16]
				{
				}, -- [17]
				{
				}, -- [18]
			},
		},
		["RealUI-HR"] = {
			["appearance"] = {
				["opacity"] = 0.75,
			},
			["position"] = {
				["y"] = -55,
			},
			["size"] = {
				["height"] = 100,
				["scale"] = 0.7,
				["width"] = 130,
			},
			["custom"] = {
				{
				}, -- [1]
				{
				}, -- [2]
				nil, -- [3]
				{
				}, -- [4]
				{
				}, -- [5]
				nil, -- [6]
				nil, -- [7]
				{
				}, -- [8]
				{
				}, -- [9]
				{
				}, -- [10]
				nil, -- [11]
				nil, -- [12]
				nil, -- [13]
				nil, -- [14]
				nil, -- [15]
				{
				}, -- [16]
				{
				}, -- [17]
				{
				}, -- [18]
			},
			["framelevel"] = {
				["strata"] = "BACKGROUND",
			},
		},
	},
}






--------------
---- Omen ----
--------------

Omen3DB = {
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI-HR",
	},
	["profiles"] = {
		["RealUI"] = {
			["PositionW"] = 131.2870519688163,
			["NumBars"] = 2,
			["PositionH"] = 18.00000857521351,
			["VGrip2"] = 83.47614147156494,
			["PositionY"] = 348.0000458281903,
			["ClickThrough"] = true,
			["minimapPosition"] = 313.590160181572,
			["Background"] = {
				["BorderColor"] = {
					["a"] = 0,
				},
				["Color"] = {
					["a"] = 0,
				},
				["BarInset"] = 1,
				["BorderTexture"] = "None",
				["Texture"] = "None",
			},
			["MinimapIcon"] = {
				["minimapPos"] = 318.8218167576527,
				["hide"] = true,
			},
			["ShowWith"] = {
				["HideWhileResting"] = false,
			},
			["detachedTooltip"] = {
			},
			["hidden"] = true,
			["VGrip1"] = 87.64355025837733,
			["Locked"] = true,
			["GrowUp"] = true,
			["PositionX"] = 774.3564318424106,
			["Autocollapse"] = true,
			["Warnings"] = {
				["Threshold"] = 95,
				["Sound"] = false,
				["Flash"] = false,
			},
			["FrameStrata"] = "2-LOW",
			["TitleBar"] = {
				["ShowTitleBar"] = false,
				["FontSize"] = 12,
				["FontColor"] = {
					["b"] = 0.7843137254901961,
					["g"] = 0.7843137254901961,
					["r"] = 0.7843137254901961,
				},
				["Font"] = "ABF",
			},
			["Bar"] = {
				["FontSize"] = 8,
				["FontColor"] = {
					["a"] = 0,
					["r"] = 0.1843137254901961,
					["g"] = 0.1843137254901961,
					["b"] = 0.1843137254901961,
				},
				["ShowHeadings"] = false,
				["ShowValue"] = false,
				["UseClassColors"] = false,
				["FontOutline"] = "MONOCHROMEOUTLINE",
				["MyBarColor"] = {
					["g"] = 1,
					["r"] = 0,
				},
				["ShowAggroBar"] = false,
				["Texture"] = "Flat",
				["HeadingBGColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["ShowTPS"] = false,
				["InvertColors"] = true,
				["BarColor"] = {
					["g"] = 1,
					["b"] = 1,
				},
				["Font"] = "pixel_lr_small",
				["Height"] = 5,
				["Spacing"] = 7,
				["UseMyBarColor"] = true,
			},
		},
		["RealUI-HR"] = {
			["PositionW"] = 162.2868798354884,
			["NumBars"] = 2,
			["PositionH"] = 18.99997386410335,
			["VGrip2"] = 103.1867838498328,
			["PositionY"] = 226.5000419842595,
			["ClickThrough"] = true,
			["Locked"] = true,
			["Background"] = {
				["BorderColor"] = {
					["a"] = 0,
				},
				["Color"] = {
					["a"] = 0,
				},
				["BarInset"] = 1,
				["BorderTexture"] = "None",
				["Texture"] = "None",
			},
			["Autocollapse"] = true,
			["MinimapIcon"] = {
				["minimapPos"] = 318.8218167576527,
				["hide"] = true,
			},
			["ShowWith"] = {
				["HideWhileResting"] = false,
			},
			["detachedTooltip"] = {
			},
			["hidden"] = true,
			["VGrip1"] = 108.3382139724767,
			["minimapPosition"] = 313.590160181572,
			["GrowUp"] = true,
			["PositionX"] = 560.8565367267737,
			["Warnings"] = {
				["Threshold"] = 95,
				["Sound"] = false,
				["Flash"] = false,
			},
			["FrameStrata"] = "2-LOW",
			["TitleBar"] = {
				["ShowTitleBar"] = false,
				["FontSize"] = 12,
				["FontColor"] = {
					["b"] = 0.7843137254901961,
					["g"] = 0.7843137254901961,
					["r"] = 0.7843137254901961,
				},
				["Font"] = "ABF",
			},
			["Bar"] = {
				["FontSize"] = 8,
				["FontColor"] = {
					["a"] = 0,
					["b"] = 0.1843137254901961,
					["g"] = 0.1843137254901961,
					["r"] = 0.1843137254901961,
				},
				["ShowHeadings"] = false,
				["ShowValue"] = false,
				["UseClassColors"] = false,
				["FontOutline"] = "MONOCHROMEOUTLINE",
				["MyBarColor"] = {
					["g"] = 1,
					["r"] = 0,
				},
				["ShowAggroBar"] = false,
				["Texture"] = "Flat",
				["HeadingBGColor"] = {
					["a"] = 1,
					["b"] = 1,
					["g"] = 1,
					["r"] = 1,
				},
				["ShowTPS"] = false,
				["InvertColors"] = true,
				["BarColor"] = {
					["g"] = 1,
					["b"] = 1,
				},
				["Font"] = "pixel_hr_small",
				["Height"] = 5,
				["Spacing"] = 7,
				["UseMyBarColor"] = true,
			},
		},
	},
}






----------------
---- OmniCC ----
----------------

OmniCC4Config = {
	["version"] = "5.1.2",
	["engine"] = "AniUpdater",
	["groups"] = {
		{
			["id"] = "Totems",
			["rules"] = {
				"MultiCast", -- [1]
			},
			["enabled"] = true,
		}, -- [1]
	},
	["groupSettings"] = {
		["base"] = {
			["enabled"] = true,
			["scaleText"] = true,
			["showCooldownModels"] = true,
			["effect"] = "none",
			["minSize"] = 0.55,
			["minDuration"] = 3,
			["tenthsDuration"] = 0,
			["mmSSDuration"] = 0,
			["minEffectDuration"] = 30,
			["fontFace"] = "Interface\\Addons\\SharedMedia_MyMedia\\font\\standard.ttf",
			["styles"] = {
				["soon"] = {
					["a"] = 1,
					["r"] = 1,
					["scale"] = 1.5,
					["g"] = 0.1,
					["b"] = 0.1,
				},
				["seconds"] = {
					["a"] = 1,
					["r"] = 1,
					["scale"] = 1,
					["g"] = 1,
					["b"] = 0.1,
				},
				["minutes"] = {
					["a"] = 1,
					["r"] = 1,
					["scale"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["hours"] = {
					["a"] = 1,
					["r"] = 0.7,
					["scale"] = 1,
					["g"] = 0.7,
					["b"] = 0.7,
				},
			},
			["fontSize"] = 16,
			["fontOutline"] = "OUTLINE",
			["anchor"] = "CENTER",
			["xOff"] = 2,
			["yOff"] = 0,
		},
		["Totems"] = {
			["enabled"] = true,
			["scaleText"] = true,
			["showCooldownModels"] = true,
			["effect"] = "none",
			["minSize"] = 0.55,
			["minDuration"] = 3,
			["tenthsDuration"] = 0,
			["mmSSDuration"] = 0,
			["minEffectDuration"] = 30,
			["fontFace"] = "Interface\\Addons\\SharedMedia_MyMedia\\font\\standard.ttf",
			["styles"] = {
				["soon"] = {
					["a"] = 1,
					["r"] = 1,
					["scale"] = 1.5,
					["g"] = 0.1,
					["b"] = 0.1,
				},
				["seconds"] = {
					["a"] = 1,
					["r"] = 1,
					["scale"] = 1,
					["g"] = 1,
					["b"] = 0.1,
				},
				["minutes"] = {
					["a"] = 1,
					["r"] = 1,
					["scale"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["hours"] = {
					["a"] = 1,
					["r"] = 0.7,
					["scale"] = 1,
					["g"] = 0.7,
					["b"] = 0.7,
				},
			},
			["fontSize"] = 16,
			["fontOutline"] = "OUTLINE",
			["anchor"] = "TOP",
			["xOff"] = 1,
			["yOff"] = 1,
		},
	},
}






---------------
---- Raven ----
---------------

RavenDB = {
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI-HR",
	},
	["global"] = {
		["SpellLists"] = {
			["PlayerInclusions"] = {
				["#87378"] = true,
				["#75610"] = true,
				["#98507"] = true,
				["#46393"] = true,
				["#75697"] = true,
			},
			["ClassBuffs"] = {
				["#121153"] = true,
				["#121471"] = true,
				["#13877"] = true,
				["#108208"] = true,
			},
			["PlayerDebuffExclusions"] = {
				["#36032"] = true,
			},
			["PlayerExclusions"] = {
				["#12329"] = true,
				["#85114"] = true,
				["#5171"] = true,
				["#20584"] = true,
				["#8326"] = true,
				["#109959"] = true,
				["#86627"] = true,
				["#44544"] = true,
				["#14202"] = true,
				["#109955"] = true,
				["#84746"] = true,
				["#121153"] = true,
				["#121471"] = true,
				["#81661"] = true,
				["#73651"] = true,
				["#80313"] = true,
				["#31884"] = true,
				["#51713"] = true,
				["#50334"] = true,
				["#87160"] = true,
				["#32216"] = true,
				["#85739"] = true,
				["#9036"] = true,
				["#87118"] = true,
				["#87117"] = true,
				["#13750"] = true,
				["#57933"] = true,
				["#44543"] = true,
				["#77487"] = true,
				["#742"] = true,
				["#50685"] = true,
				["#498"] = true,
				["#60503"] = true,
				["#108208"] = true,
				["#57940"] = true,
				["#84745"] = true,
				["#95799"] = true,
				["#81659"] = true,
				["#84535"] = true,
				["#80979"] = true,
				["#18119"] = true,
				["#85696"] = true,
				["#56636"] = true,
				["#109949"] = true,
				["#84963"] = true,
				["#32645"] = true,
				["#31850"] = true,
				["#5229"] = true,
				["#30451"] = true,
				["#52610"] = true,
				["#57519"] = true,
				["#87096"] = true,
				["#109941"] = true,
				["#5217"] = true,
				["#43"] = true,
				["#14910"] = true,
				["#84747"] = true,
				["#36032"] = true,
				["#85113"] = true,
			},
			["TargetExclusions"] = {
				["#16511"] = true,
				["#1079"] = true,
				["#85383"] = true,
				["#97341"] = true,
				["#20584"] = true,
				["#44457"] = true,
				["#59879"] = true,
				["#61205"] = true,
				["#91021"] = true,
				["#84617"] = true,
				["#31884"] = true,
				["#92315"] = true,
				["#36032"] = true,
				["#5570"] = true,
				["#8921"] = true,
				["#33745"] = true,
				["#93401"] = true,
				["#15286"] = true,
				["#9036"] = true,
				["#91023"] = true,
				["#89775"] = true,
				["#3261"] = true,
				["#55078"] = true,
				["#59921"] = true,
				["#1978"] = false,
				["#772"] = true,
				["#11366"] = true,
				["#33377"] = true,
				["#8050"] = true,
				["#1822"] = true,
				["#2944"] = true,
				["#30108"] = true,
				["#57940"] = true,
				["#8056"] = true,
				["#1715"] = true,
				["#17793"] = true,
				["#79140"] = true,
				["#5422"] = true,
				["#12846"] = true,
				["#58045"] = true,
				["#17800"] = true,
				["#34914"] = true,
				["#93402"] = true,
				["#8042"] = true,
				["#348"] = true,
				["#603"] = true,
				["#1943"] = true,
				["#55095"] = true,
				["#94009"] = true,
				["#589"] = true,
				["#563"] = true,
				["#20475"] = true,
				["#172"] = true,
				["#980"] = true,
				["#97340"] = true,
				["#8326"] = true,
			},
		},
		["FilterBuff"] = {
			["PlayerBuffs"] = {
			},
			["TargetBuffs"] = {
			},
			["PlayerBuffsExtra"] = {
			},
			["BF"] = {
				["Blade Flurry"] = "Blade Flurry",
			},
		},
		["DefaultCooldownColor"] = {
			["b"] = 0.2549019607843137,
			["g"] = 0.7803921568627451,
			["r"] = 0.8431372549019608,
		},
		["Minimap"] = {
			["hide"] = true,
		},
		["DefaultBuffColor"] = {
			["b"] = 0.2,
			["g"] = 0.796078431372549,
			["r"] = 0.5215686274509804,
		},
		["FilterDebuff"] = {
			["TargetDebuffs"] = {
			},
		},
		["Settings"] = {
			["WeaponEnchants"] = {
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
			},
			["Buffs"] = {
				["backdropFill"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["hideSpark"] = false,
				["growDirection"] = false,
				["iconInset"] = -15,
				["showNoDuration"] = true,
				["timeOffset"] = 14,
				["spacingX"] = -9,
				["barHeight"] = 5,
				["anchorX"] = -2,
				["reverseSort"] = true,
				["i_iconSize"] = 30,
				["i_spacingX"] = 3,
				["detectBuffs"] = true,
				["pointW"] = 37.00001862648837,
				["hideLabel"] = true,
				["spacingY"] = -9,
				["checkDuration"] = true,
				["iconSize"] = 37,
				["checkTimeLeft"] = true,
				["filterDuration"] = 60,
				["barWidth"] = 20,
				["timeAlign"] = "LEFT",
				["i_spacingY"] = 15,
				["iconAlign"] = "RIGHT",
				["pointX"] = 0.9767857393792347,
				["borderColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["configuration"] = 9,
				["labelFont"] = "pixel_lr_small",
				["filterTimeLeft"] = 60,
				["maxBars"] = 40,
				["timeInset"] = 16,
				["sor"] = "T",
				["pointXR"] = 0.00119044043730982,
				["pointH"] = 37.00001862648837,
				["wrap"] = 20,
				["timeFormat"] = 23,
				["timeFont"] = "pixel_lr_small",
				["anchorY"] = -2,
				["backdropColor"] = {
					["a"] = 1,
					["r"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["iconFont"] = "pixel_lr_small",
				["detectBuffsCastBy"] = "anyone",
				["pointY"] = 0.9628571830067758,
				["hideBar"] = true,
				["pointYT"] = 0.001904704699695495,
				["iconOffset"] = 8,
			},
		},
		["HighlightsEnabled"] = false,
		["SpellIDs"] = {
			["Corruption"] = 172,
			["Avenging Wrath"] = 31884,
			["Shadow Word: Pain"] = 589,
			["Enrage"] = 5229,
			["Immolate"] = 348,
			["Living Bomb"] = 20475,
			["Dark Evangelism"] = 87117,
			["Devouring Plague"] = 2944,
			["Fingers of Frost"] = 44543,
			["Thunderstruck"] = 80979,
			["Vampiric Touch"] = 34914,
			["Zealotry"] = 84535,
			["Shadow and Flame"] = 17793,
			["Improved Soul Fire"] = 18119,
			["Bane of Agony"] = 980,
			["Divine Protection"] = 498,
			["Forbearance"] = 25771,
			["Blood Plague"] = 55078,
			["Tiger's Fury"] = 5217,
			["Bane of Doom"] = 603,
			["Unstable Affliction"] = 30108,
			["Essence of Wintergrasp"] = 57940,
			["Inquisition"] = 84963,
			["Evolution"] = 75610,
			["Frost Fever"] = 55095,
			["Berserk"] = 43,
			["Savage Combat"] = 51682,
			["Shadow Orb"] = 77487,
			["Ardent Defender"] = 31850,
			["Earth Shock"] = 8042,
			["Frost Shock"] = 8056,
			["Empowered Shadow"] = 95799,
			["Rip"] = 1079,
			["Insect Swarm"] = 5570,
			["Deep Insight"] = 84747,
			["Rend"] = 772,
			["Incite"] = 50685,
			["Trick"] = 24714,
			["Rake"] = 1822,
			["Shallow Insight"] = 84745,
			["Ghost"] = 8326,
			["Recently Bandaged"] = 11196,
			["Meat Cleaver"] = 12329,
			["Brutal Assault"] = 46393,
			["Moderate Insight"] = 84746,
			["Taste for Blood"] = 56636,
			["Anthem"] = 91141,
			["Savage Roar"] = 52610,
			["Hamstring"] = 1715,
			["Victorious"] = 32216,
			["Pulverize"] = 742,
			["Lacerate"] = 5422,
			["Moonfire"] = 563,
			["Hemorrhage"] = 16511,
			["Serpent Sting"] = 1978,
			["Pyroblast!"] = 92315,
			["Mind Melt"] = 14910,
			["Ignite"] = 3261,
			["Flame Shock"] = 8050,
			["Sunfire"] = 93401,
			["Pyroblast"] = 11366,
			["Evangelism"] = 81659,
		},
		["Defaults"] = {
			["timeMono"] = true,
			["iconFSize"] = 8,
			["bgAlpha"] = 0,
			["iconSize"] = 20,
			["texture"] = "Plain_Dark",
			["borderOffset"] = 0,
			["timeFont"] = "pixel_hr_small",
			["borderWidth"] = 1,
			["labelShadow"] = false,
			["iconFont"] = "pixel_hr_small",
			["labelFont"] = "pixel_hr_small",
			["hideClock"] = true,
			["iconMono"] = true,
			["timeOutline"] = true,
			["i_iconSize"] = 37,
			["iconShadow"] = false,
			["i_spacingX"] = -9,
			["bgtexture"] = "Plain_Dark",
			["labelMono"] = true,
			["labelFSize"] = 8,
			["i_spacingY"] = -9,
			["timeShadow"] = false,
			["labelOutline"] = true,
			["i_hideClock"] = true,
			["timeFSize"] = 8,
			["hideSpark"] = true,
			["barWidth"] = 149,
		},
		["ButtonFacade"] = true,
		["DefaultDebuffColor"] = {
			["b"] = 0,
			["g"] = 0,
			["r"] = 0.6470588235294118,
		},
		["DefaultMagicColor"] = {
			["a"] = 1,
			["r"] = 0.1450980392156863,
			["g"] = 0.4392156862745098,
			["b"] = 0.7176470588235294,
		},
		["BuffDurations"] = {
			["Instant Poison"] = 3600,
			["Crippling Poison"] = 197,
			["Mind Numbing Poison"] = 199,
			["Deadly Poison"] = 3600,
			["Wound Poison"] = 3600,
		},
		["Version"] = "6",
		["DefaultPoisonColor"] = {
			["a"] = 1,
			["g"] = 0.6313725490196078,
		},
		["DefaultDiseaseColor"] = {
			["a"] = 1,
		},
		["DefaultCurseColor"] = {
			["a"] = 1,
			["r"] = 0.4196078431372549,
			["b"] = 0.6941176470588235,
		},
	},
	["profiles"] = {
		["RealUI"] = {
			["Durations"] = {
				["Cloak of Shadows"] = 5,
				["Deadly Poison"] = 12,
				["Blade Twisting"] = 8,
				["Earthbind"] = 5,
				["Slice and Dice"] = 27,
				["Rupture"] = 12,
				["Combat Readiness"] = 20,
				["Forbearance"] = 60,
				["Recuperate"] = 24,
				["Arcane Missiles!"] = 20,
				["Sprint"] = 8,
				["Hand of Protection"] = 10,
				["Resurrection Sickness"] = 600,
				["Hurricane"] = 12,
				["Frostbolt"] = 9,
				["Revealing Strike"] = 15,
				["Plague of Ages"] = 9,
				["Shallow Insight"] = 15,
				["Recently Bandaged"] = 60,
				["Harmony"] = 20,
				["Blind"] = 60,
				["Tricks of the Trade"] = 6,
				["Vanish"] = 3,
				["Evasion"] = 15,
				["Killing Spree"] = 2,
				["Kidney Shot"] = 2,
				["Deserter"] = 900,
				["Enlightenment"] = 10,
				["Arrow of Time"] = 20,
				["First Aid"] = 8,
				["Grace"] = 15,
				["Adrenaline Rush"] = 20,
				["Deep Insight"] = 15,
				["Honorless Target"] = 30,
				["Moderate Insight"] = 15,
				["Garrote"] = 18,
				["Rejuvenation"] = 11.656,
				["Cheap Shot"] = 4,
				["Eye of Vengeance"] = 10,
			},
			["Conditions"] = {
				["HUNTER"] = {
					["Check Aspect!"] = {
						["tests"] = {
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["minHealth"] = 100,
								["minComboPoints"] = 5,
								["level"] = 80,
								["minPower"] = 100,
								["levelRanged"] = 1,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
					["Aspect Missing"] = {
						["tests"] = {
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["minHealth"] = 100,
								["minComboPoints"] = 5,
								["level"] = 80,
								["minPower"] = 100,
								["levelRanged"] = 1,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
					["No Pet!"] = {
						["tests"] = {
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["minHealth"] = 100,
								["minComboPoints"] = 5,
								["level"] = 80,
								["minPower"] = 100,
								["levelRanged"] = 1,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
					["Trueshot Aura Missing"] = {
						["tests"] = {
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["minHealth"] = 100,
								["minComboPoints"] = 5,
								["level"] = 80,
								["minPower"] = 100,
								["levelRanged"] = 1,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
				},
				["SHAMAN"] = {
					["Cleanse Spirit (Magic)"] = {
						["tests"] = {
							["Debuff Type"] = {
								["toggle"] = false,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
							},
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["minHealth"] = 100,
								["minComboPoints"] = 5,
								["levelRanged"] = 1,
								["minPower"] = 100,
								["level"] = 80,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
					["Cleanse Spirit (Curse)"] = {
						["tests"] = {
							["Debuff Type"] = {
								["toggle"] = false,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
					["Shield Missing"] = {
						["tests"] = {
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["minHealth"] = 100,
								["minComboPoints"] = 5,
								["levelRanged"] = 1,
								["minPower"] = 100,
								["level"] = 80,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
					["Weapon Buff Missing"] = {
						["tests"] = {
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["minHealth"] = 100,
								["minComboPoints"] = 5,
								["levelRanged"] = 1,
								["minPower"] = 100,
								["level"] = 80,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
				},
				["ROGUE"] = {
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
				},
			},
			["BarGroups"] = {
				["PlayerDebuffs"] = {
					["timeAlign"] = "LEFT",
					["pointY"] = 0.4780952661673391,
					["maxBars"] = 10,
					["detectDebuffsCastBy"] = "anyone",
					["timeInset"] = 4,
					["sor"] = "T",
					["i_spacingX"] = 3,
					["showNoDuration"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["pointXR"] = 0.7461309387121242,
					["i_spacingY"] = 15,
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["labelInset"] = -1,
					["detectDebuffs"] = true,
					["i_iconSize"] = 30,
					["filterBuffTable"] = "PlayerExclusions",
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["filterDebuffSpells"] = true,
					["auto"] = true,
					["wrap"] = 10,
					["filterDebuffTable"] = "PlayerDebuffExclusions",
					["parentFrame"] = "oUF_RealUIPlayer_Overlay",
					["timeFormat"] = 23,
					["pointH"] = 14.99997265772085,
					["configuration"] = 8,
					["pointX"] = 0.1532738319651693,
					["name"] = "PlayerDebuffs",
					["pointYT"] = 0.5076190458645412,
					["filterCooldownTable"] = "PlayerExclusions",
					["bars"] = {
					},
					["pointW"] = 168.9999885429524,
					["iconInset"] = 2,
				},
				["FocusDebuffs"] = {
					["timeAlign"] = "LEFT",
					["maxBars"] = 8,
					["detectDebuffsCastBy"] = "anyone",
					["spacingX"] = -9,
					["barHeight"] = 5,
					["configuration"] = 9,
					["noPlayerDebuffs"] = true,
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
					["pointX"] = 0.2666666909441377,
					["timeFormat"] = 23,
					["name"] = "FocusDebuffs",
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spacingY"] = -9,
					["hideSpark"] = false,
					["sor"] = "T",
					["i_spacingX"] = -8,
					["detectDebuffs"] = true,
					["iconOffset"] = 8,
					["i_spacingY"] = -8,
					["growDirection"] = false,
					["iconSize"] = 37,
					["timeInset"] = 16,
					["filterBuffTable"] = "PlayerExclusions",
					["barWidth"] = 20,
					["bars"] = {
					},
					["wrap"] = 8,
					["auto"] = true,
					["pointXR"] = 0.7113095062772115,
					["filterDebuffTable"] = "PlayerExclusions",
					["parentFrame"] = "oUF_RealUIFocus_Overlay",
					["pointY"] = 0.3647619648231441,
					["timeOffset"] = 14,
					["pointH"] = 36.99996014634375,
					["noTargetDebuffs"] = true,
					["hideBar"] = true,
					["pointYT"] = 0.5999999785787019,
					["pointW"] = 36.99998938641606,
					["detectDebuffsMonitor"] = "focus",
					["showNoDuration"] = true,
					["iconInset"] = -15,
				},
				["PlayerBuffsExtra"] = {
					["filterBuffSpells"] = true,
					["filterBuff"] = false,
					["i_spacingX"] = 3,
					["showNoDuration"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["i_spacingY"] = 15,
					["pointH"] = 14.99997265772085,
					["i_iconSize"] = 30,
					["pointW"] = 169.000114500187,
					["filterBuffTable"] = "PlayerInclusions",
					["detectBuffs"] = true,
					["auto"] = true,
					["detectBuffsCastBy"] = "anyone",
					["merged"] = true,
					["pointX"] = 0.4625000042842596,
					["pointY"] = 0.8161904569317093,
					["showBuff"] = true,
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["pointXR"] = 0.4369046914184909,
					["name"] = "PlayerBuffsExtra",
					["mergeInto"] = "PlayerBuffs",
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["bars"] = {
					},
					["pointYT"] = 0.1695238551001711,
					["filterBuffList"] = {
					},
				},
				["FocusBuffs"] = {
					["timeAlign"] = "LEFT",
					["maxBars"] = 8,
					["detectDebuffsCastBy"] = "anyone",
					["spacingX"] = -9,
					["barHeight"] = 5,
					["configuration"] = 9,
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
					["i_iconSize"] = 30,
					["detectBuffsMonitor"] = "focus",
					["filterCooldownTable"] = "PlayerExclusions",
					["pointX"] = 0.2666666909441377,
					["timeFormat"] = 23,
					["filterDebuffTypes"] = true,
					["name"] = "FocusBuffs",
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spacingY"] = -9,
					["hideSpark"] = false,
					["sor"] = "T",
					["i_spacingX"] = 3,
					["iconOffset"] = 8,
					["barWidth"] = 20,
					["growDirection"] = false,
					["pointH"] = 36.99996014634375,
					["iconSize"] = 37,
					["noTargetBuffs"] = false,
					["filterBuffTable"] = "PlayerExclusions",
					["bars"] = {
					},
					["wrap"] = 8,
					["detectBuffs"] = true,
					["auto"] = true,
					["pointXR"] = 0.7113095062772115,
					["filterDebuffTable"] = "PlayerExclusions",
					["parentFrame"] = "oUF_RealUIFocus_Overlay",
					["pointY"] = 0.3914286017856108,
					["noPlayerBuffs"] = true,
					["timeInset"] = 16,
					["pointW"] = 36.99998938641606,
					["hideBar"] = true,
					["pointYT"] = 0.5733333416162352,
					["i_spacingY"] = 15,
					["detectDebuffsMonitor"] = "focus",
					["timeOffset"] = 14,
					["iconInset"] = -15,
				},
				["ClassBuffs"] = {
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
				},
				["PlayerBuffs"] = {
					["timeAlign"] = "LEFT",
					["maxBars"] = 12,
					["spacingX"] = -9,
					["barHeight"] = 5,
					["configuration"] = 9,
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
					["checkTimeLeft"] = true,
					["i_iconSize"] = 25,
					["i_hideClock"] = false,
					["detectBuffsCastBy"] = "anyone",
					["pointX"] = 0.2333333518984583,
					["anchorX"] = -63,
					["minimumTimeLeft"] = false,
					["name"] = "PlayerBuffs",
					["iconOffset"] = 8,
					["hideBar"] = true,
					["i_spacingY"] = 15,
					["minimumDuration"] = false,
					["spacingY"] = -9,
					["iconAlign"] = "RIGHT",
					["filterBuffTable"] = "PlayerExclusions",
					["hideSpark"] = false,
					["sor"] = "T",
					["i_spacingX"] = 2,
					["filterBuffList"] = {
					},
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["timeFormat"] = 23,
					["wrap"] = 6,
					["growDirection"] = false,
					["iconSize"] = 37,
					["pointXR"] = 0.7446428453228909,
					["pointH"] = 36.99993090627144,
					["timeInset"] = 16,
					["anchorPoint"] = "LEFT",
					["detectBuffs"] = true,
					["auto"] = true,
					["filterBuffSpells"] = true,
					["filterDebuffTable"] = "PlayerExclusions",
					["parentFrame"] = "oUF_RealUIPlayer_Overlay",
					["pointY"] = 0.4466667260750665,
					["barWidth"] = 20,
					["filterDuration"] = 66,
					["checkDuration"] = true,
					["filterTimeLeft"] = 66,
					["pointYT"] = 0.518095245174467,
					["pointW"] = 36.99998938641606,
					["bars"] = {
					},
					["timeOffset"] = 14,
					["iconInset"] = -15,
				},
				["TargetBuffsExtra2"] = {
					["filterBuffSpells"] = true,
					["showOnlyNoDuration"] = true,
					["i_spacingX"] = -8,
					["showNoDuration"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["i_spacingY"] = -8,
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectBuffsMonitor"] = "target",
					["filterBuffTable"] = "TargetExclusions",
					["merged"] = true,
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectBuffs"] = true,
					["auto"] = true,
					["detectBuffsCastBy"] = "target",
					["filterDebuffTable"] = "PlayerExclusions",
					["pointX"] = 0.4607142820420632,
					["pointY"] = 0.8961904706413399,
					["noPlayerBuffs"] = true,
					["pointXR"] = 0.4386904136606873,
					["pointH"] = 14.99991305295806,
					["name"] = "TargetBuffsExtra2",
					["mergeInto"] = "TargetBuffs",
					["pointW"] = 169.000114500187,
					["bars"] = {
					},
					["filterCooldownTable"] = "PlayerExclusions",
					["pointYT"] = 0.08952389815698005,
				},
				["ToTDebuffsExtra"] = {
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectDebuffsCastBy"] = "anyone",
					["detectNPCDebuffs"] = true,
					["noTargetDebuffs"] = true,
					["i_spacingX"] = -8,
					["noPlayerDebuffs"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectDispellable"] = true,
					["i_spacingY"] = -8,
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectInflictable"] = true,
					["pointH"] = 14.99991305295806,
					["detectDebuffs"] = true,
					["filterBuffTable"] = "PlayerExclusions",
					["bars"] = {
					},
					["pointXR"] = 0.4386903708180914,
					["auto"] = true,
					["filterDebuffTable"] = "PlayerExclusions",
					["merged"] = true,
					["pointX"] = 0.4607142820420632,
					["pointY"] = 0.8542856819701563,
					["detectVehicleDebuffs"] = true,
					["pointW"] = 169.0001864757496,
					["detectBoss"] = true,
					["name"] = "ToTDebuffsExtra",
					["mergeInto"] = "ToTDebuffs",
					["filterDebuffTypes"] = true,
					["detectDebuffsMonitor"] = "targettarget",
					["pointYT"] = 0.1314286868281638,
					["showNoDuration"] = true,
				},
				["FocusBuffsExtra"] = {
					["minimumDuration"] = false,
					["filterCooldownTable"] = "PlayerExclusions",
					["filterBuffTable"] = "PlayerExclusions",
					["detectNPCBuffs"] = true,
					["i_spacingX"] = 3,
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectBuffsMonitor"] = "focus",
					["i_spacingY"] = 15,
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["pointXR"] = 0.4404762430093736,
					["pointH"] = 14.99997265772085,
					["i_iconSize"] = 30,
					["filterBuffTypes"] = true,
					["detectVehicleBuffs"] = true,
					["detectBuffs"] = true,
					["auto"] = true,
					["detectBuffsCastBy"] = "anyone",
					["filterDebuffTable"] = "PlayerExclusions",
					["pointX"] = 0.4589285597998669,
					["pointY"] = 0.7219046652845075,
					["noPlayerBuffs"] = true,
					["detectStealable"] = true,
					["merged"] = true,
					["name"] = "FocusBuffsExtra",
					["mergeInto"] = "FocusBuffs",
					["filterDuration"] = 30,
					["bars"] = {
					},
					["pointW"] = 168.9999345612805,
					["pointYT"] = 0.263809646747373,
				},
				["ToTDebuffs"] = {
					["timeAlign"] = "LEFT",
					["maxBars"] = 8,
					["spacingX"] = -9,
					["noTargetDebuffs"] = true,
					["configuration"] = 9,
					["noPlayerDebuffs"] = true,
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
					["detectOtherDebuffs"] = false,
					["pointX"] = 0.7113094942277314,
					["timeFormat"] = 23,
					["filterDebuffTypes"] = false,
					["name"] = "ToTDebuffs",
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spacingY"] = -9,
					["hideSpark"] = false,
					["sor"] = "T",
					["i_spacingX"] = -8,
					["detectDebuffs"] = true,
					["iconOffset"] = 8,
					["barWidth"] = 20,
					["pointH"] = 36.99996014634375,
					["iconSize"] = 37,
					["i_spacingY"] = -8,
					["noFocusDebuffs"] = false,
					["filterBuffTable"] = "PlayerExclusions",
					["barHeight"] = 5,
					["bars"] = {
					},
					["auto"] = true,
					["wrap"] = 8,
					["filterDebuffTable"] = "PlayerExclusions",
					["parentFrame"] = "oUF_RealUITargetTarget_Overlay",
					["pointY"] = 0.3914286017856108,
					["pointXR"] = 0.2666666855888132,
					["timeInset"] = 16,
					["timeOffset"] = 14,
					["hideBar"] = true,
					["pointYT"] = 0.5733333416162352,
					["pointW"] = 37.00001862648837,
					["detectDebuffsMonitor"] = "targettarget",
					["showNoDuration"] = true,
					["iconInset"] = -15,
				},
				["TargetBuffsExtra"] = {
					["filterBuffSpells"] = true,
					["pointY"] = 0.7476189970239821,
					["filterBuffTable"] = "TargetExclusions",
					["detectNPCBuffs"] = true,
					["i_spacingX"] = 3,
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectBuffsCastBy"] = "anyone",
					["i_spacingY"] = 15,
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectVehicleBuffs"] = true,
					["pointXR"] = 0.4357142242045586,
					["i_iconSize"] = 30,
					["filterBuffTypes"] = true,
					["pointH"] = 14.99997265772085,
					["detectBuffs"] = true,
					["auto"] = true,
					["detectBuffsMonitor"] = "target",
					["filterDebuffTable"] = "PlayerExclusions",
					["pointX"] = 0.4636904714981919,
					["timeFormat"] = 23,
					["bars"] = {
					},
					["detectStealable"] = true,
					["merged"] = true,
					["name"] = "TargetBuffsExtra",
					["mergeInto"] = "TargetBuffs",
					["filterCooldownTable"] = "PlayerExclusions",
					["detectCastable"] = true,
					["pointW"] = 169.000114500187,
					["pointYT"] = 0.2380953150078984,
				},
				["WeaponEnchants"] = {
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
				},
				["TargetBuffsExtraPvP"] = {
					["showSolo"] = false,
					["showCombat"] = false,
					["filterBuffTable"] = "PlayerDebuffExclusions",
					["showNoDuration"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["pointXR"] = 0.4380952657389131,
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["pointY"] = 0.9257142289172442,
					["merged"] = true,
					["showFriendly"] = false,
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectBuffsMonitor"] = "target",
					["detectBuffs"] = true,
					["auto"] = true,
					["detectBuffsCastBy"] = "anyone",
					["filterDebuffTable"] = "PlayerDebuffExclusions",
					["pointX"] = 0.4613095370703273,
					["showInstance"] = false,
					["timeFormat"] = 23,
					["mergeInto"] = "TargetBuffs",
					["pointH"] = 14.99991305295806,
					["name"] = "TargetBuffsExtraPvP",
					["pointYT"] = 0.06000013988107579,
					["showFishing"] = false,
					["bars"] = {
					},
					["filterCooldownTable"] = "PlayerDebuffExclusions",
					["pointW"] = 168.9999345612805,
				},
				["TargetDebuffsExtra"] = {
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectDebuffsCastBy"] = "other",
					["detectNPCDebuffs"] = true,
					["detectDispellable"] = true,
					["i_spacingX"] = 3,
					["showNoDuration"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectDebuffs"] = true,
					["i_spacingY"] = 15,
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectInflictable"] = true,
					["filterDebuffTable"] = "TargetExclusions",
					["i_iconSize"] = 30,
					["bars"] = {
					},
					["detectBoss"] = true,
					["mergeInto"] = "TargetDebuffs",
					["auto"] = true,
					["pointXR"] = 0.4369047985249808,
					["merged"] = true,
					["pointX"] = 0.4625000042842596,
					["pointY"] = 0.779999979435554,
					["filterDebuffBars"] = true,
					["pointH"] = 14.99997265772085,
					["filterDebuffBarGroup"] = "TargetDebuffs",
					["name"] = "TargetDebuffsExtra",
					["pointYT"] = 0.2057143325963264,
					["detectVehicleDebuffs"] = true,
					["detectDebuffsMonitor"] = "target",
					["filterDebuffTypes"] = true,
					["pointW"] = 168.9999345612805,
				},
				["Buffs"] = {
					["timeAlign"] = "LEFT",
					["maxBars"] = 40,
					["spacingX"] = -9,
					["barHeight"] = 5,
					["configuration"] = 9,
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
					["checkTimeLeft"] = true,
					["i_iconSize"] = 30,
					["detectBuffsCastBy"] = "anyone",
					["pointX"] = 0.9767857393792347,
					["anchorX"] = -2,
					["name"] = "Buffs",
					["anchorY"] = -2,
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spacingY"] = -9,
					["iconOffset"] = 8,
					["hideBar"] = true,
					["hideSpark"] = false,
					["sor"] = "T",
					["i_spacingX"] = 3,
					["checkDuration"] = true,
					["iconAlign"] = "RIGHT",
					["filterBuffTable"] = "PlayerExclusions",
					["pointW"] = 37.00001862648837,
					["pointH"] = 37.00001862648837,
					["iconSize"] = 37,
					["barWidth"] = 20,
					["timeFormat"] = 23,
					["wrap"] = 20,
					["pointXR"] = 0.00119044043730982,
					["detectBuffs"] = true,
					["auto"] = true,
					["growDirection"] = false,
					["reverseSort"] = true,
					["timeInset"] = 16,
					["pointY"] = 0.9628570459104687,
					["i_spacingY"] = 15,
					["filterDuration"] = 60,
					["filterDebuffTable"] = "PlayerDebuffExclusions",
					["filterTimeLeft"] = 60,
					["pointYT"] = 0.001904841796002557,
					["anchorPoint"] = "TOPRIGHT",
					["bars"] = {
					},
					["timeOffset"] = 14,
					["iconInset"] = -15,
				},
				["TargetBuffs"] = {
					["filterBuffSpells"] = true,
					["maxBars"] = 12,
					["spacingX"] = -9,
					["barHeight"] = 5,
					["configuration"] = 9,
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
					["i_iconSize"] = 30,
					["detectBuffsMonitor"] = "target",
					["filterCooldownTable"] = "PlayerExclusions",
					["pointX"] = 0.7446428761160068,
					["timeFormat"] = 23,
					["name"] = "TargetBuffs",
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spacingY"] = -9,
					["hideSpark"] = false,
					["sor"] = "T",
					["i_spacingX"] = 3,
					["iconOffset"] = 8,
					["barWidth"] = 20,
					["filterBuffList"] = {
					},
					["iconSize"] = 37,
					["i_spacingY"] = 15,
					["wrap"] = 6,
					["filterBuffTypes"] = false,
					["filterBuffTable"] = "TargetExclusions",
					["detectBuffs"] = true,
					["auto"] = true,
					["pointW"] = 37.00001862648837,
					["filterDebuffTable"] = "PlayerExclusions",
					["parentFrame"] = "oUF_RealUITarget_Overlay",
					["pointY"] = 0.4466667260750665,
					["pointXR"] = 0.2333333037005379,
					["pointH"] = 36.99993090627144,
					["timeInset"] = 16,
					["hideBar"] = true,
					["pointYT"] = 0.518095245174467,
					["timeAlign"] = "LEFT",
					["bars"] = {
					},
					["timeOffset"] = 14,
					["iconInset"] = -15,
				},
				["TargetDebuffs"] = {
					["timeAlign"] = "RIGHT",
					["maxBars"] = 10,
					["showNoDuration"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["barColors"] = "Standard",
					["i_spacingY"] = 15,
					["borderColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["detectOtherDebuffs"] = false,
					["i_iconSize"] = 30,
					["pointX"] = 0.7461308851588792,
					["timeFormat"] = 23,
					["filterDebuffTypes"] = false,
					["name"] = "TargetDebuffs",
					["backdropColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["sor"] = "T",
					["i_spacingX"] = 3,
					["detectDebuffs"] = true,
					["pointH"] = 14.99997265772085,
					["filterBuffTable"] = "PlayerExclusions",
					["filterDebuffSpells"] = true,
					["auto"] = true,
					["iconColors"] = "Normal",
					["filterDebuffTable"] = "TargetExclusions",
					["parentFrame"] = "oUF_RealUITarget_Overlay",
					["pointY"] = 0.4780952661673391,
					["filterDebuffList"] = {
					},
					["wrap"] = 10,
					["pointXR"] = 0.1532738426758183,
					["labelInset"] = 3,
					["pointYT"] = 0.5076190458645412,
					["detectDebuffsMonitor"] = "target",
					["bars"] = {
					},
					["pointW"] = 169.0000605185151,
					["iconInset"] = 2,
				},
			},
			["muteSFX"] = true,
		},
		["RealUI-HR"] = {
			["BarGroups"] = {
				["PlayerDebuffs"] = {
					["detectDebuffsCastBy"] = "anyone",
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["labelOffset"] = -1,
					["parentFrame"] = "oUF_RealUIPlayer_Overlay",
					["iconInset"] = 1,
					["showNoDuration"] = true,
					["name"] = "PlayerDebuffs",
					["timeOffset"] = -1,
					["auto"] = true,
					["pointYT"] = 0.5076190458645412,
					["i_spacingX"] = 3,
					["pointW"] = 168.9999885429524,
					["labelInset"] = -1,
					["filterDebuffTable"] = "PlayerDebuffExclusions",
					["filterCooldownTable"] = "PlayerExclusions",
					["timeAlign"] = "LEFT",
					["i_spacingY"] = 15,
					["pointX"] = 0.1354167273603443,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
					},
					["configuration"] = 8,
					["sor"] = "T",
					["maxBars"] = 10,
					["timeInset"] = 4,
					["pointH"] = 14.99997265772085,
					["pointXR"] = 0.7639880433169491,
					["wrap"] = 10,
					["timeFormat"] = 23,
					["i_iconSize"] = 30,
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["filterBuffTable"] = "PlayerExclusions",
					["detectDebuffs"] = true,
					["filterDebuffSpells"] = true,
					["pointY"] = 0.4780952661673391,
					["iconOffset"] = -1,
				},
				["FocusDebuffs"] = {
					["detectDebuffsCastBy"] = "anyone",
					["noPlayerDebuffs"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["hideSpark"] = false,
					["pointH"] = 36.99996014634375,
					["parentFrame"] = "oUF_RealUIFocus_Overlay",
					["iconInset"] = -15,
					["showNoDuration"] = true,
					["name"] = "FocusDebuffs",
					["timeOffset"] = 14,
					["spacingX"] = -9,
					["barHeight"] = 5,
					["auto"] = true,
					["pointYT"] = 0.5999999785787019,
					["i_spacingX"] = -8,
					["pointW"] = 36.99998938641606,
					["hideLabel"] = true,
					["spacingY"] = -9,
					["iconSize"] = 37,
					["filterDebuffTable"] = "PlayerExclusions",
					["barWidth"] = 20,
					["timeAlign"] = "LEFT",
					["i_spacingY"] = -8,
					["pointX"] = 0.254761933119623,
					["noTargetDebuffs"] = true,
					["configuration"] = 9,
					["growDirection"] = false,
					["sor"] = "T",
					["detectDebuffsMonitor"] = "focus",
					["maxBars"] = 8,
					["timeInset"] = 16,
					["pointXR"] = 0.7232142641017262,
					["wrap"] = 8,
					["timeFormat"] = 23,
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
					},
					["filterBuffTable"] = "PlayerExclusions",
					["detectDebuffs"] = true,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["iconAlign"] = "RIGHT",
					["pointY"] = 0.3647619648231441,
					["hideBar"] = true,
					["iconOffset"] = 7,
				},
				["PlayerBuffsExtra"] = {
					["filterBuffSpells"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["pointH"] = 14.99997265772085,
					["showNoDuration"] = true,
					["name"] = "PlayerBuffsExtra",
					["filterBuffList"] = {
					},
					["auto"] = true,
					["pointYT"] = 0.1695238551001711,
					["filterBuff"] = false,
					["i_spacingX"] = 3,
					["detectBuffs"] = true,
					["pointW"] = 169.0001864757496,
					["merged"] = true,
					["i_spacingY"] = 15,
					["pointX"] = 0.4625000042842596,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["pointXR"] = 0.436904648575895,
					["mergeInto"] = "PlayerBuffs",
					["detectBuffsCastBy"] = "anyone",
					["showBuff"] = true,
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
					},
					["filterBuffTable"] = "PlayerInclusions",
					["pointY"] = 0.8161904569317093,
					["i_iconSize"] = 30,
				},
				["WeaponEnchants"] = {
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
				},
				["ClassBuffs"] = {
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["hideSpark"] = false,
					["parentFrame"] = "oUF_RealUIPlayer_Overlay",
					["iconInset"] = -15,
					["showNoDuration"] = true,
					["name"] = "ClassBuffs",
					["timeOffset"] = 14,
					["spacingX"] = -9,
					["barHeight"] = 5,
					["auto"] = true,
					["pointYT"] = 0.5190476253720022,
					["filterBuff"] = false,
					["detectBuffs"] = true,
					["pointW"] = 37.00001862648837,
					["anchorPoint"] = "BOTTOMLEFT",
					["hideLabel"] = true,
					["spacingY"] = -9,
					["iconSize"] = 37,
					["filterDebuffTable"] = "ClassBuffs",
					["filterCooldownTable"] = "ClassBuffs",
					["timeAlign"] = "LEFT",
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
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
					["pointX"] = 0.4345238319651693,
					["iconAlign"] = "RIGHT",
					["filterBuffSpells"] = true,
					["configuration"] = 10,
					["anchorFrame"] = "RealUI_Positioners_CenterAuras",
					["timeInset"] = 16,
					["pointH"] = 36.99996014634375,
					["pointXR"] = 0.5434523478513753,
					["timeFormat"] = 23,
					["showResting"] = false,
					["showBuff"] = true,
					["anchorY"] = -18,
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
					},
					["filterBuffTable"] = "ClassBuffs",
					["pointY"] = 0.4457143180298439,
					["barWidth"] = 20,
					["hideBar"] = true,
					["iconOffset"] = 8,
				},
				["PlayerBuffs"] = {
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["hideSpark"] = false,
					["pointH"] = 36.99993090627144,
					["parentFrame"] = "oUF_RealUIPlayer_Overlay",
					["iconInset"] = -15,
					["name"] = "PlayerBuffs",
					["timeOffset"] = 14,
					["spacingX"] = -9,
					["anchorX"] = -63,
					["minimumDuration"] = false,
					["filterBuffList"] = {
					},
					["auto"] = true,
					["pointYT"] = 0.518095245174467,
					["i_iconSize"] = 25,
					["i_spacingX"] = 2,
					["detectBuffs"] = true,
					["pointW"] = 36.99998938641606,
					["anchorPoint"] = "LEFT",
					["hideLabel"] = true,
					["spacingY"] = -9,
					["checkDuration"] = true,
					["iconSize"] = 37,
					["filterDebuffTable"] = "PlayerExclusions",
					["checkTimeLeft"] = true,
					["i_hideClock"] = false,
					["filterDuration"] = 66,
					["timeAlign"] = "LEFT",
					["i_spacingY"] = 15,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["pointX"] = 0.2154762365829842,
					["barHeight"] = 5,
					["filterBuffSpells"] = true,
					["configuration"] = 9,
					["minimumTimeLeft"] = false,
					["barWidth"] = 20,
					["sor"] = "T",
					["filterTimeLeft"] = 66,
					["growDirection"] = false,
					["maxBars"] = 12,
					["timeInset"] = 16,
					["pointXR"] = 0.7624999606383649,
					["wrap"] = 6,
					["timeFormat"] = 23,
					["detectBuffsCastBy"] = "anyone",
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
					},
					["filterBuffTable"] = "PlayerExclusions",
					["iconAlign"] = "RIGHT",
					["pointY"] = 0.4466667260750665,
					["hideBar"] = true,
					["iconOffset"] = 7,
				},
				["TargetBuffsExtra2"] = {
					["filterBuffSpells"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["showOnlyNoDuration"] = true,
					["mergeInto"] = "TargetBuffs",
					["showNoDuration"] = true,
					["detectBuffsCastBy"] = "target",
					["name"] = "TargetBuffsExtra2",
					["auto"] = true,
					["pointYT"] = 0.08952389815698005,
					["i_spacingX"] = -8,
					["detectBuffs"] = true,
					["pointW"] = 169.000114500187,
					["filterCooldownTable"] = "PlayerExclusions",
					["merged"] = true,
					["noPlayerBuffs"] = true,
					["i_spacingY"] = -8,
					["pointX"] = 0.4601190270137991,
					["bars"] = {
					},
					["filterDebuffTable"] = "PlayerExclusions",
					["pointH"] = 14.99991305295806,
					["pointXR"] = 0.4392856686889515,
					["detectBuffsMonitor"] = "target",
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["filterBuffTable"] = "TargetExclusions",
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["pointY"] = 0.8961904706413399,
				},
				["ToTDebuffsExtra"] = {
					["detectDebuffsCastBy"] = "anyone",
					["detectNPCDebuffs"] = true,
					["noPlayerDebuffs"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["mergeInto"] = "ToTDebuffs",
					["showNoDuration"] = true,
					["name"] = "ToTDebuffsExtra",
					["auto"] = true,
					["pointYT"] = 0.1304762787829412,
					["i_spacingX"] = -8,
					["pointW"] = 169.000114500187,
					["filterDebuffTable"] = "PlayerExclusions",
					["merged"] = true,
					["i_spacingY"] = -8,
					["detectDispellable"] = true,
					["pointX"] = 0.4601190270137991,
					["noTargetDebuffs"] = true,
					["detectBoss"] = true,
					["filterDebuffTypes"] = true,
					["detectDebuffsMonitor"] = "targettarget",
					["detectVehicleDebuffs"] = true,
					["pointH"] = 14.99991305295806,
					["pointXR"] = 0.4392856686889515,
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
					},
					["filterBuffTable"] = "PlayerExclusions",
					["detectDebuffs"] = true,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["detectInflictable"] = true,
					["pointY"] = 0.8552380900153789,
				},
				["FocusBuffsExtra"] = {
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["mergeInto"] = "FocusBuffs",
					["detectBuffsMonitor"] = "focus",
					["name"] = "FocusBuffsExtra",
					["minimumDuration"] = false,
					["filterBuffTypes"] = true,
					["auto"] = true,
					["pointYT"] = 0.263809646747373,
					["i_spacingX"] = 3,
					["detectBuffs"] = true,
					["pointW"] = 168.9999345612805,
					["filterCooldownTable"] = "PlayerExclusions",
					["filterDuration"] = 30,
					["merged"] = true,
					["noPlayerBuffs"] = true,
					["detectStealable"] = true,
					["i_spacingY"] = 15,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["pointX"] = 0.4589285597998669,
					["bars"] = {
					},
					["detectNPCBuffs"] = true,
					["filterDebuffTable"] = "PlayerExclusions",
					["detectVehicleBuffs"] = true,
					["pointH"] = 14.99997265772085,
					["pointXR"] = 0.4404762430093736,
					["i_iconSize"] = 30,
					["detectBuffsCastBy"] = "anyone",
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["filterBuffTable"] = "PlayerExclusions",
					["pointY"] = 0.7219046652845075,
				},
				["TargetBuffs"] = {
					["filterBuffSpells"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["hideSpark"] = false,
					["parentFrame"] = "oUF_RealUITarget_Overlay",
					["iconInset"] = -15,
					["name"] = "TargetBuffs",
					["timeOffset"] = 14,
					["spacingX"] = -9,
					["barHeight"] = 5,
					["filterBuffList"] = {
					},
					["filterBuffTypes"] = false,
					["auto"] = true,
					["pointYT"] = 0.518095245174467,
					["i_spacingX"] = 3,
					["detectBuffs"] = true,
					["pointW"] = 37.00001862648837,
					["hideLabel"] = true,
					["spacingY"] = -9,
					["iconSize"] = 37,
					["filterDebuffTable"] = "PlayerExclusions",
					["filterCooldownTable"] = "PlayerExclusions",
					["timeAlign"] = "LEFT",
					["i_spacingY"] = 15,
					["pointX"] = 0.7625000985379706,
					["configuration"] = 9,
					["sor"] = "T",
					["maxBars"] = 12,
					["timeInset"] = 16,
					["pointH"] = 36.99993090627144,
					["pointXR"] = 0.215476081278574,
					["wrap"] = 6,
					["timeFormat"] = 23,
					["detectBuffsMonitor"] = "target",
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
					},
					["filterBuffTable"] = "TargetExclusions",
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["iconAlign"] = "RIGHT",
					["pointY"] = 0.4466667260750665,
					["i_iconSize"] = 30,
					["hideBar"] = true,
					["barWidth"] = 20,
					["iconOffset"] = 7,
				},
				["TargetBuffsExtra"] = {
					["filterBuffSpells"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["mergeInto"] = "TargetBuffs",
					["detectBuffsCastBy"] = "anyone",
					["name"] = "TargetBuffsExtra",
					["filterBuffTypes"] = true,
					["auto"] = true,
					["pointYT"] = 0.2380953150078984,
					["i_iconSize"] = 30,
					["detectCastable"] = true,
					["i_spacingX"] = 3,
					["detectBuffs"] = true,
					["pointW"] = 169.000114500187,
					["filterDebuffTable"] = "PlayerExclusions",
					["filterCooldownTable"] = "PlayerExclusions",
					["merged"] = true,
					["detectStealable"] = true,
					["i_spacingY"] = 15,
					["pointX"] = 0.4636904714981919,
					["detectNPCBuffs"] = true,
					["detectVehicleBuffs"] = true,
					["pointH"] = 14.99997265772085,
					["pointXR"] = 0.4357142242045586,
					["timeFormat"] = 23,
					["detectBuffsMonitor"] = "target",
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["filterBuffTable"] = "TargetExclusions",
					["bars"] = {
					},
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["pointY"] = 0.7476189970239821,
				},
				["ToTDebuffs"] = {
					["noPlayerDebuffs"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["hideSpark"] = false,
					["parentFrame"] = "oUF_RealUITargetTarget_Overlay",
					["iconInset"] = -15,
					["showNoDuration"] = true,
					["name"] = "ToTDebuffs",
					["timeOffset"] = 14,
					["spacingX"] = -9,
					["auto"] = true,
					["pointYT"] = 0.5733333416162352,
					["i_spacingX"] = -8,
					["pointW"] = 37.00001862648837,
					["hideLabel"] = true,
					["detectOtherDebuffs"] = false,
					["spacingY"] = -9,
					["iconSize"] = 37,
					["filterDebuffTable"] = "PlayerExclusions",
					["timeAlign"] = "LEFT",
					["i_spacingY"] = -8,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["pointX"] = 0.723214294894842,
					["barHeight"] = 5,
					["noTargetDebuffs"] = true,
					["configuration"] = 9,
					["barWidth"] = 20,
					["filterDebuffTypes"] = false,
					["sor"] = "T",
					["detectDebuffsMonitor"] = "targettarget",
					["pointH"] = 36.99996014634375,
					["maxBars"] = 8,
					["timeInset"] = 16,
					["pointXR"] = 0.2547618849217025,
					["noFocusDebuffs"] = false,
					["wrap"] = 8,
					["timeFormat"] = 23,
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
					},
					["filterBuffTable"] = "PlayerExclusions",
					["detectDebuffs"] = true,
					["iconAlign"] = "RIGHT",
					["pointY"] = 0.3914286017856108,
					["hideBar"] = true,
					["iconOffset"] = 7,
				},
				["FocusBuffs"] = {
					["detectDebuffsCastBy"] = "anyone",
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["hideSpark"] = false,
					["growDirection"] = false,
					["parentFrame"] = "oUF_RealUIFocus_Overlay",
					["iconInset"] = -15,
					["name"] = "FocusBuffs",
					["timeOffset"] = 14,
					["spacingX"] = -9,
					["auto"] = true,
					["pointYT"] = 0.5733333416162352,
					["i_iconSize"] = 30,
					["i_spacingX"] = 3,
					["detectBuffs"] = true,
					["pointW"] = 36.99998938641606,
					["hideLabel"] = true,
					["spacingY"] = -9,
					["iconSize"] = 37,
					["filterDebuffTable"] = "PlayerExclusions",
					["filterCooldownTable"] = "PlayerExclusions",
					["noPlayerBuffs"] = true,
					["timeAlign"] = "LEFT",
					["i_spacingY"] = 15,
					["pointX"] = 0.254761933119623,
					["barHeight"] = 5,
					["configuration"] = 9,
					["barWidth"] = 20,
					["filterDebuffTypes"] = true,
					["sor"] = "T",
					["detectDebuffsMonitor"] = "focus",
					["maxBars"] = 8,
					["timeInset"] = 16,
					["pointH"] = 36.99996014634375,
					["pointXR"] = 0.7232142641017262,
					["wrap"] = 8,
					["timeFormat"] = 23,
					["detectBuffsMonitor"] = "focus",
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
					},
					["filterBuffTable"] = "PlayerExclusions",
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["iconAlign"] = "RIGHT",
					["noTargetBuffs"] = false,
					["pointY"] = 0.3914286017856108,
					["hideBar"] = true,
					["iconOffset"] = 7,
				},
				["Buffs"] = {
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["hideSpark"] = false,
					["growDirection"] = false,
					["iconInset"] = -15,
					["showNoDuration"] = true,
					["name"] = "Buffs",
					["timeOffset"] = 14,
					["spacingX"] = -9,
					["anchorX"] = -2,
					["auto"] = true,
					["reverseSort"] = true,
					["pointYT"] = 0.001904841796002557,
					["i_iconSize"] = 30,
					["i_spacingX"] = 3,
					["detectBuffs"] = true,
					["pointW"] = 37.00001862648837,
					["anchorPoint"] = "TOPRIGHT",
					["hideLabel"] = true,
					["spacingY"] = -9,
					["checkDuration"] = true,
					["iconSize"] = 37,
					["filterDebuffTable"] = "PlayerDebuffExclusions",
					["checkTimeLeft"] = true,
					["filterDuration"] = 60,
					["barWidth"] = 20,
					["timeAlign"] = "LEFT",
					["i_spacingY"] = 15,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["pointX"] = 0.9767857393792347,
					["barHeight"] = 5,
					["configuration"] = 9,
					["sor"] = "T",
					["filterTimeLeft"] = 60,
					["pointH"] = 37.00001862648837,
					["maxBars"] = 40,
					["timeInset"] = 16,
					["pointXR"] = 0.00119044043730982,
					["wrap"] = 20,
					["timeFormat"] = 23,
					["detectBuffsCastBy"] = "anyone",
					["anchorY"] = -2,
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
					},
					["filterBuffTable"] = "PlayerExclusions",
					["iconAlign"] = "RIGHT",
					["pointY"] = 0.9628570459104687,
					["hideBar"] = true,
					["iconOffset"] = 7,
				},
				["TargetDebuffsExtra"] = {
					["detectDebuffsCastBy"] = "other",
					["detectNPCDebuffs"] = true,
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["showNoDuration"] = true,
					["name"] = "TargetDebuffsExtra",
					["auto"] = true,
					["pointYT"] = 0.2057143325963264,
					["i_iconSize"] = 30,
					["filterDebuffBars"] = true,
					["i_spacingX"] = 3,
					["pointW"] = 168.9999345612805,
					["filterDebuffBarGroup"] = "TargetDebuffs",
					["filterDebuffTable"] = "TargetExclusions",
					["merged"] = true,
					["i_spacingY"] = 15,
					["detectDispellable"] = true,
					["pointX"] = 0.4625000042842596,
					["detectInflictable"] = true,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["filterDebuffTypes"] = true,
					["detectBoss"] = true,
					["detectDebuffsMonitor"] = "target",
					["detectVehicleDebuffs"] = true,
					["pointH"] = 14.99997265772085,
					["pointXR"] = 0.4369047985249808,
					["mergeInto"] = "TargetDebuffs",
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
					},
					["filterBuffTable"] = "ClassBuffs",
					["detectDebuffs"] = true,
					["pointY"] = 0.779999979435554,
				},
				["TargetBuffsExtraPvP"] = {
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["showInstance"] = false,
					["mergeInto"] = "TargetBuffs",
					["showFishing"] = false,
					["showSolo"] = false,
					["showNoDuration"] = true,
					["detectBuffsCastBy"] = "anyone",
					["name"] = "TargetBuffsExtraPvP",
					["showCombat"] = false,
					["auto"] = true,
					["pointYT"] = 0.0600000274192614,
					["detectBuffs"] = true,
					["pointW"] = 168.9999345612805,
					["showFriendly"] = false,
					["filterDebuffTable"] = "PlayerDebuffExclusions",
					["filterCooldownTable"] = "PlayerDebuffExclusions",
					["merged"] = true,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["pointX"] = 0.4613095370703273,
					["bars"] = {
					},
					["pointH"] = 15.00003113786547,
					["pointXR"] = 0.4380952657389131,
					["timeFormat"] = 23,
					["detectBuffsMonitor"] = "target",
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["filterBuffTable"] = "PlayerDebuffExclusions",
					["pointY"] = 0.9257142289172442,
				},
				["TargetDebuffs"] = {
					["backdropFill"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["labelOffset"] = -1,
					["parentFrame"] = "oUF_RealUITarget_Overlay",
					["iconInset"] = 1,
					["showNoDuration"] = true,
					["name"] = "TargetDebuffs",
					["timeOffset"] = -1,
					["barColors"] = "Standard",
					["auto"] = true,
					["pointYT"] = 0.5076190458645412,
					["i_spacingX"] = 3,
					["pointW"] = 168.9999345612805,
					["labelInset"] = 3,
					["detectOtherDebuffs"] = false,
					["iconColors"] = "Normal",
					["filterDebuffTable"] = "TargetExclusions",
					["filterDebuffList"] = {
					},
					["timeAlign"] = "RIGHT",
					["i_spacingY"] = 15,
					["pointX"] = 0.7639881075808432,
					["borderColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["filterDebuffTypes"] = false,
					["sor"] = "T",
					["detectDebuffsMonitor"] = "target",
					["maxBars"] = 10,
					["pointH"] = 14.99997265772085,
					["pointXR"] = 0.1354166952283972,
					["i_iconSize"] = 30,
					["wrap"] = 10,
					["timeFormat"] = 23,
					["backdropColor"] = {
						["a"] = 1,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["bars"] = {
					},
					["filterBuffTable"] = "PlayerExclusions",
					["detectDebuffs"] = true,
					["filterDebuffSpells"] = true,
					["pointY"] = 0.4780952661673391,
					["iconOffset"] = -1,
				},
			},
			["Durations"] = {
				["Vanish"] = 3,
				["Deadly Poison"] = 12,
				["Blade Twisting"] = 8,
				["Earthbind"] = 5,
				["Eye of Vengeance"] = 10,
				["Rupture"] = 14,
				["Combat Readiness"] = 20,
				["Forbearance"] = 60,
				["Recuperate"] = 24,
				["Arcane Missiles!"] = 20,
				["Sprint"] = 8,
				["Hand of Protection"] = 10,
				["Resurrection Sickness"] = 600,
				["Deep Insight"] = 15,
				["Frostbolt"] = 9,
				["Revealing Strike"] = 15,
				["Plague of Ages"] = 9,
				["Shallow Insight"] = 15.002,
				["Cloak of Shadows"] = 5,
				["Recently Bandaged"] = 60,
				["Garrote"] = 18,
				["Tricks of the Trade"] = 6,
				["Harmony"] = 20,
				["Killing Spree"] = 2,
				["Slice and Dice"] = 22.5,
				["Moderate Insight"] = 15,
				["Kidney Shot"] = 2,
				["Deserter"] = 900,
				["Evasion"] = 15,
				["Enlightenment"] = 10,
				["First Aid"] = 8,
				["Hurricane"] = 12,
				["Adrenaline Rush"] = 20,
				["Grace"] = 15,
				["Honorless Target"] = 30,
				["Blind"] = 60,
				["Trick"] = 45,
				["Rejuvenation"] = 11.656,
				["Cheap Shot"] = 4,
				["Living Seed"] = 15,
			},
			["muteSFX"] = true,
			["Conditions"] = {
				["PALADIN"] = {
					["Cleanse (Poison)"] = {
						["tests"] = {
							["Debuff Type"] = {
								["toggle"] = false,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
					["Cleanse (Disease)"] = {
						["tests"] = {
							["Debuff Type"] = {
								["toggle"] = false,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
					["Seal Missing"] = {
						["tests"] = {
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["minHealth"] = 100,
								["minComboPoints"] = 5,
								["level"] = 80,
								["minPower"] = 100,
								["levelRanged"] = 1,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
					["Aura Missing"] = {
						["tests"] = {
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["minHealth"] = 100,
								["minComboPoints"] = 5,
								["level"] = 80,
								["minPower"] = 100,
								["levelRanged"] = 1,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
					["Cleanse (Magic)"] = {
						["tests"] = {
							["Debuff Type"] = {
								["toggle"] = false,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
							},
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["minHealth"] = 100,
								["minComboPoints"] = 5,
								["level"] = 80,
								["minPower"] = 100,
								["levelRanged"] = 1,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
					["Blessing Missing"] = {
						["tests"] = {
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["minHealth"] = 100,
								["minComboPoints"] = 5,
								["level"] = 80,
								["minPower"] = 100,
								["levelRanged"] = 1,
							},
							["Spell Ready"] = {
								["notUsable"] = false,
								["gcd"] = false,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
					["Crusader Aura!"] = {
						["tests"] = {
							["Player Status"] = {
								["levelOffHand"] = 1,
								["minShards"] = 1,
								["levelMainHand"] = 1,
								["minEclipsePower"] = 0,
								["minHolyPower"] = 1,
								["minHealth"] = 100,
								["minComboPoints"] = 5,
								["level"] = 80,
								["minPower"] = 100,
								["levelRanged"] = 1,
							},
							["Any Buffs"] = {
								["toggle"] = false,
							},
						},
						["result"] = false,
						["testResult"] = false,
					},
				},
			},
		},
	},
}









---------------
---- Skada ----
---------------

SkadaDB = {
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI-HR",
	},
	["profiles"] = {
		["RealUI"] = {
			["modules"] = {
				["notankwarnings"] = true,
			},
			["windows"] = {
				{
					["point"] = "BOTTOMRIGHT",
					["barcolor"] = {
						["r"] = 0.1058823529411765,
						["g"] = 0.1058823529411765,
						["b"] = 0.1058823529411765,
					},
					["barfontsize"] = 8,
					["barslocked"] = true,
					["barorientation"] = 3,
					["mode"] = "DPS",
					["spark"] = false,
					["bartexture"] = "Plain_Dark",
					["barwidth"] = 190,
					["hidden"] = true,
					["y"] = 20.5,
					["x"] = 0,
					["title"] = {
						["color"] = {
							["a"] = 0,
							["r"] = 0.1058823529411765,
							["g"] = 0.1058823529411765,
							["b"] = 0.3019607843137255,
						},
						["font"] = "pixel_lr_small",
						["fontsize"] = 8,
						["texture"] = "Flat",
					},
					["classcolorbars"] = false,
					["barfont"] = "pixel_lr_small",
					["classcolortext"] = true,
					["background"] = {
						["color"] = {
							["a"] = 0,
							["b"] = 0.5019607843137255,
						},
						["height"] = 160,
					},
				}, -- [1]
			},
			["columns"] = {
				["Healing_Healing"] = false,
				["Damage_Damage"] = false,
			},
			["hidesolo"] = true,
			["onlykeepbosses"] = true,
			["hidedisables"] = false,
			["icon"] = {
				["hide"] = true,
			},
			["report"] = {
				["channel"] = "Guild",
			},
		},
		["Default"] = {
			["modules"] = {
				["notankwarnings"] = true,
			},
			["onlykeepbosses"] = true,
			["icon"] = {
				["hide"] = true,
			},
			["windows"] = {
				{
					["y"] = 175.5,
					["x"] = 0,
					["barslocked"] = true,
					["bartexture"] = "Flat",
					["set"] = "total",
					["point"] = "BOTTOMRIGHT",
				}, -- [1]
			},
		},
		["RealUI-HR"] = {
			["modules"] = {
				["notankwarnings"] = true,
			},
			["windows"] = {
				{
					["barheight"] = 16,
					["barfont"] = "pixel_hr_small",
					["barcolor"] = {
						["r"] = 0.1058823529411765,
						["g"] = 0.1058823529411765,
						["b"] = 0.1058823529411765,
					},
					["barfontsize"] = 8,
					["barslocked"] = true,
					["barorientation"] = 3,
					["mode"] = "DPS",
					["spark"] = false,
					["bartexture"] = "Plain_Dark",
					["barwidth"] = 190,
					["hidden"] = true,
					["y"] = 24.5,
					["x"] = 0,
					["title"] = {
						["font"] = "pixel_hr_small",
						["fontsize"] = 8,
						["color"] = {
							["a"] = 0,
							["r"] = 0.1058823529411765,
							["g"] = 0.1058823529411765,
							["b"] = 0.3019607843137255,
						},
						["texture"] = "Flat",
					},
					["classcolorbars"] = false,
					["classcolortext"] = true,
					["background"] = {
						["color"] = {
							["a"] = 0,
							["b"] = 0.5019607843137255,
						},
						["height"] = 160,
					},
					["point"] = "BOTTOMRIGHT",
				}, -- [1]
			},
			["icon"] = {
				["hide"] = true,
			},
			["report"] = {
				["channel"] = "Guild",
			},
			["columns"] = {
				["Healing_Healing"] = false,
				["Damage_Damage"] = false,
			},
			["hidesolo"] = true,
			["hidedisables"] = false,
			["onlykeepbosses"] = true,
		},
	},
}


end -- LoadAddonData()