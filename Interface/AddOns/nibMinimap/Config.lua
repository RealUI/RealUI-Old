local nibMinimap = LibStub("AceAddon-3.0"):GetAddon("nibMinimap")
local db
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local table_AnchorPointsMinimap = {
	"BOTTOMLEFT",
	"TOPLEFT",
}

local table_Outline = {
	"NONE",
	"OUTLINE",
	"THICKOUTLINE",
	"MONOCHROMEOUTLINE",
}

local function ValidateOffset(value)
	val = tonumber(value)
	if val == nil then val = 0 end
	if val < -5000 then val = 5000 elseif val > 5000 then val = 5000 end
	return val
end

local options = nil
local function GetOptions()
	if not options then
		options = {
			type = "group",
			name = "nibMinimap",
			childGroups = "tab",
			args = {
				hidden = {
					name = "Automatic Hide/Show",
					type = "group",
					order = 10,
					args = {
						enabled = {
							type = "toggle",
							name = "Enabled",
							get = function(info) return db.hidden.enabled end,
							set = function(info, value) db.hidden.enabled = value end,
							order = 1,
						},
						zones = {
							type = "group",
							name = "Hide in..",
							inline = true,
							disabled = function() if not db.hidden.enabled then return true else return false end end,
							order = 20,
							args = {
								arena = {
									type = "toggle",
									name = "Arenas",
									get = function(info) return db.hidden.zones.arena end,
									set = function(info, value) db.hidden.zones.arena = value end,
									order = 10,
								},
								pvp = {
									type = "toggle",
									name = BATTLEGROUNDS,
									get = function(info) return db.hidden.zones.pvp end,
									set = function(info, value) db.hidden.zones.pvp = value end,
									order = 200,
								},
								party = {
									type = "toggle",
									name = DUNGEONS,
									get = function(info) return db.hidden.zones.party end,
									set = function(info, value) db.hidden.zones.party = value end,
									order = 30,
								},
								raid = {
									type = "toggle",
									name = RAIDS,
									get = function(info) return db.hidden.zones.raid end,
									set = function(info, value) db.hidden.zones.raid = value end,
									order = 40,
								},
							},
						},
					},
				},
				sizeposition = {
					name = "Size/Position",
					type = "group",
					order = 20,
					args = {
						position = {
							name = "Position",
							type = "group",
							inline = true,
							order = 10,
							args = {
								scale = {
									type = "range",
									name = "Scale",
									min = 0.5,
									max = 2,
									step = 0.05,
									isPercent = true,
									get = function(info) return db.position.scale end,
									set = function(info, value)
										db.position.scale = value
										nibMinimap:UpdateMinimapPosition()
										nibMinimap:UpdateBG()
									end,
									order = 10,
								},
								xoffset = {
									type = "input",
									name = "X Offset",
									width = "half",
									get = function(info) return tostring(db.position.x) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.position.x = value
										nibMinimap:UpdateMinimapPosition()
									end,
									order = 20,
								},
								yoffset = {
									type = "input",
									name = "Y Offset",
									width = "half",
									get = function(info) return tostring(db.position.y) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.position.y = value
										nibMinimap:UpdateMinimapPosition()
									end,
									order = 30,
								},
								anchorto = {
									type = "select",
									name = "Anchor To",
									get = function(info) 
										for k,v in pairs(table_AnchorPointsMinimap) do
											if v == db.position.anchorto then return k end
										end
									end,
									set = function(info, value)
										db.position.anchorto = table_AnchorPointsMinimap[value]
										nibMinimap:UpdateMinimapPosition()
									end,
									style = "dropdown",
									width = nil,
									values = table_AnchorPointsMinimap,
									order = 40,
								},
							},
						},
					},
				},
				expand = {
					name = "Farm Mode",
					type = "group",
					order = 20,
					args = {
						appearance = {
							name = APPEARANCE_LABEL,
							type = "group",
							inline = true,
							order = 10,
							args = {
								scale = {
									type = "range",
									name = "Scale",
									min = 0.5,
									max = 2,
									step = 0.05,
									isPercent = true,
									get = function(info) return db.expand.appearance.scale end,
									set = function(info, value) 
										db.expand.appearance.scale = value
										nibMinimap:UpdateMinimapPosition()
										nibMinimap:UpdateBG()
									end,
									order = 10,
								},
								opacity = {
									type = "range",
									name = "Opacity",
									min = 0,
									max = 1,
									step = 0.05,
									isPercent = true,
									get = function(info) return db.expand.appearance.opacity end,
									set = function(info, value) db.expand.appearance.opacity = value; nibMinimap:UpdateMinimapPosition(); end,
									order = 20,
								},
							},
						},
						position = {
							name = "Position",
							type = "group",
							inline = true,
							order = 20,
							args = {
								xoffset = {
									type = "input",
									name = "X Offset",
									width = "half",
									get = function(info) return tostring(db.expand.position.x) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.expand.position.x = value
										nibMinimap:UpdateMinimapPosition()
									end,
									order = 10,
								},
								yoffset = {
									type = "input",
									name = "Y Offset",
									width = "half",
									get = function(info) return tostring(db.expand.position.y) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.expand.position.y = value
										nibMinimap:UpdateMinimapPosition()
									end,
									order = 20,
								},
								anchorto = {
									type = "select",
									name = "Anchor To",
									get = function(info) 
										for k,v in pairs(table_AnchorPointsMinimap) do
											if v == db.expand.position.anchorto then return k end
										end
									end,
									set = function(info, value)
										db.expand.position.anchorto = table_AnchorPointsMinimap[value]
										nibMinimap:UpdateMinimapPosition()
									end,
									style = "dropdown",
									width = nil,
									values = table_AnchorPointsMinimap,
									order = 30,
								},
							},
						},
						extras = {
							name = "Extras",
							type = "group",
							inline = true,
							order = 30,
							args = {
								gatherertoggle = {
									type = "toggle",
									name = "Gatherer toggle",
									disabled = function() if not Gatherer then return true else return false end end,
									desc = "If you have Gatherer installed, then nibMinimap will automatically disable Gatherer's minimap icons and HUD while not in Farm Mode, and enable them while in Farm Mode.",
									get = function(info) return db.expand.extras.gatherertoggle end,
									set = function(info, value) db.expand.extras.gatherertoggle = value; nibMinimap:ToggleGatherer(); end,
									order = 10,
								},
								clickthrough = {
									type = "toggle",
									name = "Clickthrough",
									desc = "Make the Minimap clickthrough (won't respond to mouse clicks) while in Farm Mode.",
									get = function(info) return db.expand.extras.clickthrough end,
									set = function(info, value) db.expand.extras.clickthrough = value; nibMinimap:UpdateClickthrough(); end,
									order = 20,
								},
								hidepoi = {
									type = "toggle",
									name = "Hide POI icons",
									get = function(info) return db.expand.extras.hidepoi end,
									set = function(info, value) db.expand.extras.hidepoi = value; nibMinimap:UpdateFarmModePOI(); end,
									order = 30,
								},
							},
						},
					},
				},
				backdrop = {
					name = "Background",
					type = "group",
					order = 30,
					args = {
						color = {
							type = "color",
							name = "Color",
							hasAlpha = true,
							get = function(info,r,g,b,a)
								return db.backdrop.color.r, db.backdrop.color.g, db.backdrop.color.b, db.backdrop.color.a
							end,
							set = function(info,r,g,b,a)
								db.backdrop.color.r = r
								db.backdrop.color.g = g
								db.backdrop.color.b = b
								db.backdrop.color.a = a
								nibMinimap:UpdateBG()
							end,
							order = 10,
						},
						inset = {
							type = "range",
							name = "Inset",
							min = -32, max = 32, step = 1,
							get = function(info) return db.backdrop.inset end,
							set = function(info, value) db.backdrop.inset = value; nibMinimap:UpdateBG(); end,
							order = 20,
						},
					},
				},
				border = {
					name = "Border",
					type = "group",
					order = 40,
					args = {
						texture = {
							type = "select",
							name = "Texture",
							values = AceGUIWidgetLSMlists.border,
							get = function()
								return db.border.texture
							end,
							set = function(info, value)
								db.border.texture = value
								nibMinimap:UpdateBG()
							end,
							dialogControl='LSM30_Border',
							order = 10,
						},
						inset = {
							type = "range",
							name = "Inset",
							min = -32, max = 32, step = 1,
							get = function(info) return db.border.inset end,
							set = function(info, value) db.border.inset = value; nibMinimap:UpdateBG(); end,
							order = 20,
						},
						edgesize = {
							type = "range",
							name = "Edge Size",
							min = -32, max = 32, step = 1,
							get = function(info) return db.border.edgesize end,
							set = function(info, value) db.border.edgesize = value; nibMinimap:UpdateBG(); end,
							order = 30,
						},
						color = {
							type = "color",
							name = "Color",
							hasAlpha = true,
							get = function(info,r,g,b,a)
								return db.border.color.r, db.border.color.g, db.border.color.b, db.border.color.a
							end,
							set = function(info,r,g,b,a)
								db.border.color.r = r
								db.border.color.g = g
								db.border.color.b = b
								db.border.color.a = a
								nibMinimap:UpdateBG()
							end,
							order = 40,
						},
					},
				},
				information = {
					name = "Information",
					type = "group",
					childGroups = "tab",
					order = 50,
					args = {
						location = {
							type = "toggle",
							name = "Location Name",
							desc = "Show the name of your current location underneath the Minimap.",
							get = function(info) return db.information.location end,
							set = function(info, value) 
								db.information.location = value
								nibMinimap:UpdateInfoPosition()
							end,
							order = 10,
						},
						font = {
							name = "Font",
							type = "group",
							order = 10,
							args = {
								font = {
									name = "Font",
									type = "group",
									inline = true,
									order = 10,
									args = {
										fontname = {
											type = "select",
											name = "Font",
											values = AceGUIWidgetLSMlists.font,
											get = function()
												return db.information.font.name
											end,
											set = function(info, value)
												db.information.font.name = value
												nibMinimap:UpdateFonts()
												nibMinimap:UpdateInfoPosition()
											end,
											dialogControl='LSM30_Font',
											order = 10,
										},
										size = {
											type = "range",
											name = "Size",
											min = 6, max = 28, step = 1,
											get = function(info) return db.information.font.size end,
											set = function(info, value)
												db.information.font.size = value
												nibMinimap:UpdateFonts()
												nibMinimap:UpdateInfoPosition()
											end,
											order = 20,
										},
										outline = {
											type = "select",
											name = "Outline",
											values = table_Outline,
											get = function()
												for k,v in pairs(table_Outline) do
													if v == db.information.font.outline then return k end
												end
											end,
											set = function(info, value)
												db.information.font.outline = table_Outline[value]
												nibMinimap:UpdateFonts()
											end,
											order = 30,
										},
									},
								},
								gap = {
									type = "range",
									name = "Gap",
									min = 1, max = 28, step = 1,
									get = function(info) return db.information.font.gap end,
									set = function(info, value)
										db.information.font.gap = value
										nibMinimap:UpdateFonts()
										nibMinimap:UpdateInfoPosition()
									end,
									order = 20,
								},
							},
						},
						position = {
							name = "Position",
							type = "group",
							order = 20,
							args = {
								xoffset = {
									type = "input",
									name = "X Offset",
									width = "half",
									order = 10,
									get = function(info) return tostring(db.information.position.x) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.information.position.x = value
										nibMinimap:UpdateInfoPosition()
									end,
								},
								yoffset = {
									type = "input",
									name = "Y Offset",
									width = "half",
									order = 20,
									get = function(info) return tostring(db.information.position.y) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.information.position.y = value
										nibMinimap:UpdateInfoPosition()
									end,
								},
							},
						},
					},
				},
				poi = {
					name = "POI",
					type = "group",
					order = 60,
					args = {
						enabled = {
							type = "toggle",
							name = "Enabled",
							desc = "Enable/Disable the displaying of POI icons on the minimap.",
							get = function(info) return db.poi.enabled end,
							set = function(info, value) db.poi.enabled = value; nibMinimap:UpdatePOIEnabled() end,
							order = 10,
						},
						general = {
							type = "group",
							name = "General Settings",
							inline = true,
							disabled = function() if not db.poi.enabled then return true else return false end end,
							order = 20,
							args = {
								watchedOnly = {
									type = "toggle",
									name = "Watched Only",
									desc = "Only show POI icons for watched quests.",
									get = function(info) return db.poi.watchedOnly end,
									set = function(info, value) 
										db.poi.watchedOnly = value
										nibMinimap:POIUpdate()
									end,
									order = 10,
								},
								fadeEdge = {
									type = "toggle",
									name = "Fade at Edge",
									desc = "Fade icons when they go off the edge of the minimap.",
									get = function(info) return db.poi.fadeEdge end,
									set = function(info, value) 
										db.poi.fadeEdge = value
										nibMinimap:POIUpdate()
									end,
									order = 10,
								},
							},
						},
						icons = {
							type = "group",
							name = "Icon Settings",
							inline = true,
							disabled = function() if not db.poi.enabled then return true else return false end end,
							order = 30,
							args = {
								scale = {
									type = "range",
									name = "Scale",
									min = 0.1,
									max = 1.5,
									step = 0.05,
									isPercent = true,
									get = function(info) return db.poi.icons.scale end,
									set = function(info, value) db.poi.icons.scale = value; nibMinimap:POIUpdate(); end,
									order = 10,
								},
								opacity = {
									type = "range",
									name = "Opacity",
									min = 0.1,
									max = 1,
									step = 0.05,
									isPercent = true,
									get = function(info) return db.poi.icons.opacity end,
									set = function(info, value) db.poi.icons.opacity = value; nibMinimap:POIUpdate(); end,
									order = 10,
								},
							},
						},
					},
				},
			},
		}
	end
	return options
end

function nibMinimap:ChatCommand()
	InterfaceOptionsFrame_OpenToCategory(self.profilesFrame)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
	InterfaceOptionsFrame:Raise()
end

function nibMinimap:ConfigRefresh()
	db = self.db.profile
end

function nibMinimap:SetUpOptions()
	db = self.db.profile
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibMinimap", GetOptions)
	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibMinimap-Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db))
	nibMinimap.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("nibMinimap", "nibMinimap")
	nibMinimap.profilesFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("nibMinimap-Profiles", "Profiles", "nibMinimap")
	
	nibMinimap:RegisterChatCommand("nibminimap", "ChatCommand")
end