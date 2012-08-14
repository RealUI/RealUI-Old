local nibSpellAlertConfig = LibStub("AceAddon-3.0"):GetAddon("nibSpellAlertConfig");
local db;

local table_Strata = {
	"BACKGROUND",
	"LOW",
	"MEDIUM",
	"HIGH",
	"DIALOG",
	"TOOLTIP",
};

local table_Outline = {
	"NONE",
	"OUTLINE",
	"THINOUTLINE",
	"THICKOUTLINE",
};

local ClassAlerts_Sides = {
	"None",
	"Killing Machine",
	"Sudden Doom",
	"Clearcasting",
	"Focus Fire",
	"Arcane Missiles",
	"Brain Freeze",
	"Hot Streak",
	"Art of War",
	"Daybreak",
	"Grand Crusader",
	"Surge of Light",
	"Nightfall",
	"Empowered Imp",
	"Molten Core",
	"Bloodsurge",
	"Sudden Death",
	"Sword and Board",
};

local ClassAlerts_Top = {
	"None",
	"Dark Transformation",
	"Freezing Fog",
	"Fury of Stormrage",
	"Shooting Stars",
	"Lock and Load",
	"Ready, Set, Aim",
	"Fingers of Frost",
	"Impact",
	"Hand of Light",
	"Maelstrom Weapon",
	"Backlash",
};

local ClassAlerts_TopRight = {
	"None",
	"Eclipse (Solar)",
};

local ClassAlerts_TopLeft = {
	"None",
	"Eclipse (Lunar)",
};

local table_AlertPositions = {
	"Left + Right (Flipped)",
	"Top",
	"TopRight",
	"TopLeft",
	"Top + Bottom (Flipped)",
	"Bottom",
	"BottomRight",
	"BottomLeft",
	"Bottom (Flipped)",
};

local table_Units = {
	"player",
	"target",
};

local function ValidateOffset(value)
	val = tonumber(value);
	if val == nil then val = 0; end;
	if val < -5000 then val = 5000 elseif val > 5000 then val = 5000; end;
	return val;
end

local function GetAlertName(index)
	local AlertName;
	if db.custom[index].aura.auraname ~= "" then
		AlertName = "Alert "..tostring(index).." - "..tostring(db.custom[index].aura.auraname);
	else
		AlertName = "Alert "..tostring(index)
	end
	return AlertName
end

-- Return the Options table
local options = nil;
local function GetOptions()
	if not options then
		options = {
			name = "nibSpellAlertConfig",
			handler = nibSpellAlertConfig,
			type = "group",
			childGroups = "tab",
			args = {
			-- Config Guide
				configguide = {
					name = "Config Guide",
					type = "group",
					order = 10,
					args = {
						enabled = {
							name = "Enabled",
							type = "toggle",
							get = function() return db.configguide.enabled end,
							set = function(info, value) 
								db.configguide.enabled = value;
								nibSpellAlertConfig:ShowPreviewArea();
							end,
							order = 10,
						},
						displayspells = {
							name = "Config Guide display",
							type = "group",
							inline = true,
							order = 20,
							args = {
								sides = {
									name = "Sides",
									type = "select",
									get = function(info) 
										for k_ts,v_ts in pairs(ClassAlerts_Sides) do
											if v_ts == db.configguide.spells.sides then return k_ts end
										end
									end,
									set = function(info, value)
										nibSpellAlertConfig:HidePreviewAlerts("Sides");
										db.configguide.spells.sides = ClassAlerts_Sides[value];	
									end,
									values = ClassAlerts_Sides,
									order = 10,
								},
								top = {
									name = "Top",
									type = "select",
									get = function(info) 
										for k_ts,v_ts in pairs(ClassAlerts_Top) do
											if v_ts == db.configguide.spells.top then return k_ts end
										end
									end,
									set = function(info, value)
										nibSpellAlertConfig:HidePreviewAlerts("Top");
										db.configguide.spells.top = ClassAlerts_Top[value];
									end,
									values = ClassAlerts_Top,
									order = 20,
								},
								topright = {
									name = "Top Right",
									type = "select",
									get = function(info) 
										for k_ts,v_ts in pairs(ClassAlerts_TopRight) do
											if v_ts == db.configguide.spells.topright then return k_ts end
										end
									end,
									set = function(info, value)
										nibSpellAlertConfig:HidePreviewAlerts("TopRight");
										db.configguide.spells.topright = ClassAlerts_TopRight[value];
									end,
									values = ClassAlerts_TopRight,
									order = 30,
								},
								topleft = {
									name = "Top Left",
									type = "select",
									get = function(info) 
										for k_ts,v_ts in pairs(ClassAlerts_TopLeft) do
											if v_ts == db.configguide.spells.topleft then return k_ts end
										end
									end,
									set = function(info, value)
										nibSpellAlertConfig:HidePreviewAlerts("TopLeft");
										db.configguide.spells.topleft = ClassAlerts_TopLeft[value];
									end,
									values = ClassAlerts_TopLeft,
									order = 40,
								},
							},
						},						
					},
				},
			-- Basic Settings
				basic = {
					name = "Basic Settings",
					type = "group",
					order = 30,
					args = {
						position = {
							name = "Position",
							type = "group",
							inline = true,
							order = 10,
							args = {
								xofs = {
									type = "input",
									name = "X Offset",
									width = "half",
									order = 10,
									get = function(info) return tostring(db.position.x) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.position.x = value
										nibSpellAlertConfig:UpdatePosition()
									end,
								},
								yofs = {
									type = "input",
									name = "Y Offset",
									width = "half",
									order = 20,
									get = function(info) return tostring(db.position.y) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.position.y = value
										nibSpellAlertConfig:UpdatePosition()
									end,
								},
								framelevelarea = {
									name = "Frame Level",
									type = "group",
									inline = true,
									order = 30,
									args = {
										framestrata = {
											type = "select",
											name = "Frame Strata",
											get = function(info) 
												for k_ts,v_ts in pairs(table_Strata) do
													if v_ts == db.framelevel.strata then return k_ts end
												end
											end,
											set = function(info, value)
												db.framelevel.strata = table_Strata[value]
												nibSpellAlertConfig:UpdatePosition()
											end,
											style = "dropdown",
											width = nil,
											values = table_Strata,
											order = 10,
										},
										level = {
											type = "range",
											name = "Frame Level",
											min = 1, max = 50, step = 1,
											get = function(info) return db.framelevel.level end,
											set = function(info, value) 
												db.framelevel.level = value
												nibSpellAlertConfig:UpdatePosition()
											end,
											order = 20,
										},
									},
								},
							},
						},
						size = {
							type = "group",
							name = "Size",
							inline = true,
							order = 20,
							args = {
								width = {
									type = "input",
									name = "Width",
									width = "half",
									order = 10,
									get = function(info) return tostring(db.size.width) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.size.width = value
										nibSpellAlertConfig:UpdatePosition()
									end,
								},
								height = {
									type = "input",
									name = "Height",
									width = "half",
									order = 20,
									get = function(info) return tostring(db.size.height) end,
									set = function(info, value)
										value = ValidateOffset(value)
										db.size.height = value
										nibSpellAlertConfig:UpdatePosition()
									end,
								},
								scale = {
									type = "range",
									name = "Scale",
									min = 0.2, max = 2, step = 0.01,
									isPercent = true,
									get = function(info) return db.size.scale end,
									set = function(info, value) 
										db.size.scale = value
										nibSpellAlertConfig:UpdatePosition()
									end,
									order = 30,
								},
							},
						},
						appearance = {
							name = "Appearance",
							type = "group",
							inline = true,
							order = 30,
							args = {
								opacity = {
									type = "range",
									name = "Opacity",
									min = 0, max = 1, step = 0.05,
									isPercent = true,
									get = function(info) return db.appearance.opacity end,
									set = function(info, value) 
										db.appearance.opacity = value
										nibSpellAlertConfig:UpdateAppearance()
									end,
									order = 10,
								},
							},
						},
					},
				},
			-- Custom Alerts
				custom = {
					name = "Custom Alerts",
					type = "group",
					childGroups = "list",
					order = 60,
					args = {},
				},
			},
		};				
	end
	
	-- Custom Alerts
	local CustomOpts = {
		enabled = {
			name = "Enabled",
			type = "toggle",
			desc = "Enable or Disable the Custom Alerts module",
			get = function() return db.custom.enabled end,
			set = function(info, value) 
				db.custom.enabled = value;
				nibSpellAlertConfig:UpdateCustomEnabled();
			end,
			order = 10,
		},
	};
	
	local CustomOpts_OrderCnt = 10;	
	for k_c,v_c in ipairs(db.custom) do		
		CustomOpts["Alert"..tostring(k_c)] = {
			name = GetAlertName(k_c),
			type = "group",
			childGroups = "tab",
			disabled = function() if db.custom.enabled then return false else return true end end,
			order = CustomOpts_OrderCnt,
			args = {
				enabled = {
					name = "Enabled",
					type = "toggle",
					get = function() return db.custom[k_c].enabled end,
					set = function(info, value) 
						db.custom[k_c].enabled = value;
						nibSpellAlertConfig:UpdateCAF()
						nibSpellAlertConfig:UpdateCustom("_UPDATE")
					end,
					order = 10,
				},
				configguide = {
					name = "Preview",
					type = "toggle",
					desc = "Show this Custom Alert",
					get = function() return db.custom[k_c].configguide end,
					set = function(info, value) 
						db.custom[k_c].configguide = value;
						nibSpellAlertConfig:UpdateCAFSettings()
						nibSpellAlertConfig:UpdateCustom("_UPDATE")
					end,
					order = 30,
				},
				aura = {
					name = "Aura",
					type = "group",
					order = 40,
					disabled = function() if db.custom.enabled then return false else return true end end,
					args = {
						auraname = {
							type = "input",
							name = "Buff Name / ID",
							desc = "Enter either the exact Buff Name or the SpellID.",
							order = 10,
							get = function(info) return tostring(db.custom[k_c].aura.auraname) end,
							set = function(info, value)
								db.custom[k_c].aura.auraname = strtrim(value)
								db.custom[k_c].configguide = false
								nibSpellAlertConfig:UpdateCustom("_UPDATE")
								options.args.custom.args["Alert"..tostring(k_c)].name = GetAlertName(k_c)
							end,
						},
						sep1 = {
							type = "description",
							name = " ",
							order = 11,
						},
						isdebuff = {
							name = "Is Debuff",
							type = "toggle",
							get = function() return db.custom[k_c].aura.isdebuff end,
							set = function(info, value) 
								db.custom[k_c].aura.isdebuff = value;
								db.custom[k_c].configguide = false
								nibSpellAlertConfig:UpdateCustom("_UPDATE")
							end,
							order = 20,
						},
						sep2 = {
							type = "description",
							name = " ",
							order = 21,
						},
						unit = {
							type = "select",
							name = "Unit",
							get = function(info) 
								for k_ts,v_ts in pairs(table_Units) do
									if v_ts == db.custom[k_c].aura.unit then return k_ts end
								end
							end,
							set = function(info, value)
								db.custom[k_c].aura.unit = table_Units[value]
								db.custom[k_c].configguide = false
								nibSpellAlertConfig:UpdateCustom("_UPDATE")
							end,
							style = "dropdown",
							width = nil,
							values = table_Units,
							order = 30,
						},
					},
				},
				position = {
					name = "Position",
					type = "group",
					order = 50,
					disabled = function() if db.custom.enabled then return false else return true end end,
					args = {
						positions = {
							type = "select",
							name = "Alert Position",
							get = function(info) 
								for k_ts,v_ts in pairs(table_AlertPositions) do
									if v_ts == db.custom[k_c].position.positions then return k_ts end
								end
							end,
							set = function(info, value)
								db.custom[k_c].position.positions = table_AlertPositions[value]
								db.custom[k_c].configguide = false
								nibSpellAlertConfig:UpdateCAFSettings()
							end,
							style = "dropdown",
							width = nil,
							values = table_AlertPositions,
							order = 10,
						},
						scale = {
							type = "range",
							name = "Scale",
							min = 0.1,
							max = 2,
							step = 0.05,
							isPercent = true,
							get = function(info) return db.custom[k_c].position.scale end,
							set = function(info, value) 
								db.custom[k_c].position.scale = value
								db.custom[k_c].configguide = false
								nibSpellAlertConfig:UpdateCAFSettings()
							end,
							order = 20,
						},
					},
				},
				texture = {
					name = "Texture",
					type = "group",
					order = 60,
					disabled = function() if db.custom.enabled then return false else return true end end,
					args = {
						texture = {
							type = "select",
							name = "Texture",
							values = AceGUIWidgetLSMlists.background,
							get = function()
								return db.custom[k_c].texture.texture
							end,
							set = function(info, value)
								db.custom[k_c].texture.texture = value
								db.custom[k_c].configguide = false
							end,
							dialogControl='LSM30_Background',
							order = 10,
						},
						sep1 = {
							type = "description",
							name = " ",
							order = 11,
						},
						color = {
							type = "color",
							name = "Color",
							hasAlpha = false,
							get = function(info,r,g,b)
								return db.custom[k_c].texture.color.r, db.custom[k_c].texture.color.g, db.custom[k_c].texture.color.b
							end,
							set = function(info,r,g,b)
								db.custom[k_c].texture.color.r = r
								db.custom[k_c].texture.color.g = g
								db.custom[k_c].texture.color.b = b
								db.custom[k_c].configguide = false
								nibSpellAlertConfig:UpdateCustom("_UPDATE")
							end,
							order = 20,
						},
					},
				},
				texts = {
					name = "Timer/Stacks",
					type = "group",
					childGroups = "tab",
					order = 70,
					disabled = function() if db.custom.enabled then return false else return true end end,
					args = {
						enabled = {
							name = "Enabled",
							type = "toggle",
							get = function() return db.custom[k_c].texts.enabled end,
							set = function(info, value) 
								db.custom[k_c].texts.enabled = value;
								db.custom[k_c].configguide = false
								nibSpellAlertConfig:UpdateCAF()
								nibSpellAlertConfig:UpdateCustom("_UPDATE")
							end,
							order = 10,
						},
						time = {
							name = "Timer",
							type = "group",
							childGroups = "tab",
							order = 20,
							disabled = function() if db.custom[k_c].texts.enabled then return false else return true end end,
							args = {
								enabled = {
									name = "Enabled",
									type = "toggle",
									get = function() return db.custom[k_c].texts.time.enabled end,
									set = function(info, value) 
										db.custom[k_c].texts.time.enabled = value;
										db.custom[k_c].configguide = false
										nibSpellAlertConfig:UpdateCAF()
										nibSpellAlertConfig:UpdateCustom("_UPDATE")
									end,
									order = 10,
								},
								font = {
									name = "Font",
									type = "group",
									disabled = function() if db.custom[k_c].texts.time.enabled then return false else return true end end,
									order = 20,
									args = {
										name = {
											type = "select",
											name = "Font",
											values = AceGUIWidgetLSMlists.font,
											get = function()
												return db.custom[k_c].texts.time.font.name
											end,
											set = function(info, value)
												db.custom[k_c].texts.time.font.name = value
												nibSpellAlertConfig:UpdateCAFSettings()
											end,
											dialogControl='LSM30_Font',
											order = 10,
										},
										size = {
											type = "range",
											name = "Size",
											min = 6, max = 28, step = 1,
											get = function(info) return db.custom[k_c].texts.time.font.size end,
											set = function(info, value)
												db.custom[k_c].texts.time.font.size = value
												nibSpellAlertConfig:UpdateCAFSettings()
											end,
											order = 20,
										},
										style = {
											type = "group",
											name = "Style",
											inline = true,
											order = 30,
											args = {
												color = {
													name = "Color",
													type = "color",
													hasAlpha = true,
													get = function(info,r,g,b,a)
														return db.custom[k_c].texts.time.font.color.r, db.custom[k_c].texts.time.font.color.g, db.custom[k_c].texts.time.font.color.b, db.custom[k_c].texts.time.font.color.a
													end,
													set = function(info,r,g,b,a)
														db.custom[k_c].texts.time.font.color.r = r
														db.custom[k_c].texts.time.font.color.g = g
														db.custom[k_c].texts.time.font.color.b = b
														db.custom[k_c].texts.time.font.color.a = a
														nibSpellAlertConfig:UpdateCAFSettings()
													end,
													order = 10,
												},
												sep1 = {
													type = "description",
													name = " ",
													order = 11,
												},
												outline = {
													type = "select",
													name = "Outline",
													values = table_Outline,
													get = function()
														for k,v in pairs(table_Outline) do
															if v == db.custom[k_c].texts.time.font.outline then return k end
														end
													end,
													set = function(info, value)
														db.custom[k_c].texts.time.font.outline = table_Outline[value]
														nibSpellAlertConfig:UpdateCAFSettings()
													end,
													order = 20,
												},
												shadow = {
													name = "Shadow",
													type = "group",
													inline = true,
													order = 30,
													args = {
														useshadow = {
															name = "Use Shadow",
															type = "toggle",
															get = function(info) return db.custom[k_c].texts.time.font.shadow.useshadow end,
															set = function(info, value)
																db.custom[k_c].texts.time.font.shadow.useshadow = value
																nibSpellAlertConfig:UpdateCAFSettings()
															end,
															order = 10,							
														},
														position = {
															name = "Position",
															type = "group",
															inline = true,
															disabled = function() if db.custom[k_c].texts.time.font.shadow.useshadow then return false else return true end end,
															order = 20,
															args = {
																shadowx = {
																	type = "range",
																	name = "X Offset",
																	min = -8,
																	max = 8,
																	step = 1,
																	get = function(info) return db.custom[k_c].texts.time.font.shadow.position.x end,
																	set = function(info, value)
																		db.custom[k_c].texts.time.font.shadow.position.x = value
																		nibSpellAlertConfig:UpdateCAFSettings()
																	end,
																	order = 10,
																},
																shadowy = {
																	type = "range",
																	name = "Y Offset",
																	min = -8,
																	max = 8,
																	step = 1,
																	get = function(info) return db.custom[k_c].texts.time.font.shadow.position.y end,
																	set = function(info, value)
																		db.custom[k_c].texts.time.font.shadow.position.y = value
																		nibSpellAlertConfig:UpdateCAFSettings()
																	end,
																	order = 20,
																},
															},
														},
													},
												},
											},
										},
									},
								},
								position = {
									name = "Position",
									type = "group",
									disabled = function() if db.custom[k_c].texts.time.enabled then return false else return true end end,
									order = 30,
									args = {
										xofs = {
											type = "input",
											name = "X Offset",
											width = "half",
											order = 10,
											get = function(info) return tostring(db.custom[k_c].texts.time.position.xofs) end,
											set = function(info, value)
												value = ValidateOffset(value)
												db.custom[k_c].texts.time.position.xofs = value
												nibSpellAlertConfig:UpdateCAFSettings()
											end,
										},
										yofs = {
											type = "input",
											name = "Y Offset",
											width = "half",
											order = 20,
											get = function(info) return tostring(db.custom[k_c].texts.time.position.yofs) end,
											set = function(info, value)
												value = ValidateOffset(value)
												db.custom[k_c].texts.time.position.yofs = value
												nibSpellAlertConfig:UpdateCAFSettings()
											end,
										},
									},
								},
							},
						},
						stacks = {
							name = "Stack Count",
							type = "group",
							childGroups = "tab",
							order = 30,
							disabled = function() if db.custom[k_c].texts.enabled then return false else return true end end,
							args = {
								enabled = {
									name = "Enabled",
									type = "toggle",
									get = function() return db.custom[k_c].texts.stacks.enabled end,
									set = function(info, value) 
										db.custom[k_c].texts.stacks.enabled = value;
										db.custom[k_c].configguide = false
										nibSpellAlertConfig:UpdateCAF()
										nibSpellAlertConfig:UpdateCustom("_UPDATE")
									end,
									order = 10,
								},
								font = {
									name = "Font",
									type = "group",
									disabled = function() if db.custom[k_c].texts.stacks.enabled then return false else return true end end,
									order = 20,
									args = {
										name = {
											type = "select",
											name = "Font",
											values = AceGUIWidgetLSMlists.font,
											get = function()
												return db.custom[k_c].texts.stacks.font.name
											end,
											set = function(info, value)
												db.custom[k_c].texts.stacks.font.name = value
												nibSpellAlertConfig:UpdateCAFSettings()
											end,
											dialogControl='LSM30_Font',
											order = 10,
										},
										size = {
											type = "range",
											name = "Size",
											min = 6, max = 28, step = 1,
											get = function(info) return db.custom[k_c].texts.stacks.font.size end,
											set = function(info, value)
												db.custom[k_c].texts.stacks.font.size = value
												nibSpellAlertConfig:UpdateCAFSettings()
											end,
											order = 20,
										},
										style = {
											type = "group",
											name = "Style",
											inline = true,
											order = 30,
											args = {
												color = {
													name = "Color",
													type = "color",
													hasAlpha = true,
													get = function(info,r,g,b,a)
														return db.custom[k_c].texts.stacks.font.color.r, db.custom[k_c].texts.stacks.font.color.g, db.custom[k_c].texts.stacks.font.color.b, db.custom[k_c].texts.stacks.font.color.a
													end,
													set = function(info,r,g,b,a)
														db.custom[k_c].texts.stacks.font.color.r = r
														db.custom[k_c].texts.stacks.font.color.g = g
														db.custom[k_c].texts.stacks.font.color.b = b
														db.custom[k_c].texts.stacks.font.color.a = a
														nibSpellAlertConfig:UpdateCAFSettings()
													end,
													order = 10,
												},
												sep1 = {
													type = "description",
													name = " ",
													order = 11,
												},
												outline = {
													type = "select",
													name = "Outline",
													values = table_Outline,
													get = function()
														for k,v in pairs(table_Outline) do
															if v == db.custom[k_c].texts.stacks.font.outline then return k end
														end
													end,
													set = function(info, value)
														db.custom[k_c].texts.stacks.font.outline = table_Outline[value]
														nibSpellAlertConfig:UpdateCAFSettings()
													end,
													order = 20,
												},
												shadow = {
													name = "Shadow",
													type = "group",
													inline = true,
													order = 30,
													args = {
														useshadow = {
															name = "Use Shadow",
															type = "toggle",
															get = function(info) return db.custom[k_c].texts.stacks.font.shadow.useshadow end,
															set = function(info, value)
																db.custom[k_c].texts.stacks.font.shadow.useshadow = value
																nibSpellAlertConfig:UpdateCAFSettings()
															end,
															order = 10,							
														},
														position = {
															name = "Position",
															type = "group",
															inline = true,
															disabled = function() if db.custom[k_c].texts.stacks.font.shadow.useshadow then return false else return true end end,
															order = 20,
															args = {
																shadowx = {
																	type = "range",
																	name = "X Offset",
																	min = -8,
																	max = 8,
																	step = 1,
																	get = function(info) return db.custom[k_c].texts.stacks.font.shadow.position.x end,
																	set = function(info, value)
																		db.custom[k_c].texts.stacks.font.shadow.position.x = value
																		nibSpellAlertConfig:UpdateCAFSettings()
																	end,
																	order = 10,
																},
																shadowy = {
																	type = "range",
																	name = "Y Offset",
																	min = -8,
																	max = 8,
																	step = 1,
																	get = function(info) return db.custom[k_c].texts.stacks.font.shadow.position.y end,
																	set = function(info, value)
																		db.custom[k_c].texts.stacks.font.shadow.position.y = value
																		nibSpellAlertConfig:UpdateCAFSettings()
																	end,
																	order = 20,
																},
															},
														},
													},
												},
											},
										},
									},
								},
								position = {
									name = "Position",
									type = "group",
									disabled = function() if db.custom[k_c].texts.stacks.enabled then return false else return true end end,
									order = 30,
									args = {
										xofs = {
											type = "input",
											name = "X Offset",
											width = "half",
											order = 10,
											get = function(info) return tostring(db.custom[k_c].texts.stacks.position.xofs) end,
											set = function(info, value)
												value = ValidateOffset(value)
												db.custom[k_c].texts.stacks.position.xofs = value
												nibSpellAlertConfig:UpdateCAFSettings()
											end,
										},
										yofs = {
											type = "input",
											name = "Y Offset",
											width = "half",
											order = 20,
											get = function(info) return tostring(db.custom[k_c].texts.stacks.position.yofs) end,
											set = function(info, value)
												value = ValidateOffset(value)
												db.custom[k_c].texts.stacks.position.yofs = value
												nibSpellAlertConfig:UpdateCAFSettings()
											end,
										},
									},
								},
							},
						},
					},
				},
			},
		};
		
		CustomOpts_OrderCnt = CustomOpts_OrderCnt + 10;
	end
	options.args.custom.args = CustomOpts;
	
	return options
end

local intoptions = nil;
local function GetIntOptions()
	if not intoptions then
		intoptions = {
			name = "nibSpellAlertConfig",
			handler = nibSpellAlertConfig,
			type = "group",
			args = {
				note = {
					type = "description",
					name = "You can access the nibSpellAlert options by typing: /nibspac",
					order = 10,
				},
				openoptions = {
					type = "execute",
					name = "Open config...",
					func = function() 
						nibSpellAlertConfig:OpenOptions()
					end,
					order = 20,
				},
			},
		};
	end
	return intoptions;
end

function nibSpellAlertConfig:OpenOptions()
	if not options then nibSpellAlertConfig:SetUpOptions() end
	LibStub("AceConfigDialog-3.0"):Open("nibSpellAlertConfig");
end

function nibSpellAlertConfig:ChatCommand(input)
	nibSpellAlertConfig:OpenOptions();
end

function nibSpellAlertConfig:ConfigRefresh()
	db = self.db.profile;
end

function nibSpellAlertConfig:SetUpInitialOptions()
	-- Chat Command
	self:RegisterChatCommand("nibspellalertconfig", "ChatCommand");
	self:RegisterChatCommand("nibspac", "ChatCommand");
	
	-- Interface panel options
	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibSpellAlertConfig-Int", GetIntOptions);
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("nibSpellAlertConfig-Int", "nibSpellAlertConfig");
end

function nibSpellAlertConfig:SetUpOptions()
	db = self.db.profile;
	
	-- Options Window
	GetOptions();
	
	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db);
	options.args.profiles.order = 10000;
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibSpellAlertConfig", options);
	LibStub("AceConfigDialog-3.0"):SetDefaultSize("nibSpellAlertConfig", 800, 600)
end