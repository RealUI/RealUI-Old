local nibPointDisplay_RealUI = LibStub("AceAddon-3.0"):GetAddon("nibPointDisplay_RealUI");
local db;

local Types = nibPointDisplay_RealUI.Types;

local table_AnchorPoints = {
	"BOTTOM",
	"BOTTOMLEFT",
	"BOTTOMRIGHT",
	"CENTER",
	"LEFT",
	"RIGHT",
	"TOP",
	"TOPLEFT",
	"TOPRIGHT",
};

local table_Orientation = {
	"Horizontal",
	"Vertical",
};

local table_Strata = {
	"BACKGROUND",
	"LOW",
	"MEDIUM",
	"HIGH",
	"DIALOG",
	"TOOLTIP",
};

local table_Specs = {
	"None",
	"Primary",
	"Secondary",
};

local function ValidateOffset(value)
	val = tonumber(value);
	if val == nil then val = 0; end;
	if val < -5000 then val = 5000 elseif val > 5000 then val = 5000; end;
	return val;
end

-- Return the Options table
local options = nil;
local function GetOptions()
	if not options then
		options = {
			name = "nibPointDisplay_RealUI",
			handler = nibPointDisplay_RealUI,
			type = "group",
			args = {
				updatespeed = {
					type = "range",
					name = "Update Speed (r/sec)",
					desc = "Throttle the Point Display updates to X times a second.\n\nHigher = faster updates, but more CPU usage.\n\nRequires a UI Reload (/rl) to take effect.",
					min = 1, max = 30, step = 1,
					get = function(info) return db.updatespeed end,
					set = function(info, value) db.updatespeed = value end,
					order = 10,
				},
				sep = {
					type = "description",
					name = " ",
				},
			},
		};
	end
	
	-- Create Copy All table
	local CopyAllFromTable = {};
	local CopyAllFromTableShort = {};
	local cnt = 1;
	for ic,vc in pairs(Types) do
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id	
			
			tinsert(CopyAllFromTable, cnt)
			tinsert(CopyAllFromTableShort, cnt)
			CopyAllFromTable[cnt] = {
				name = Types[ic].points[it].name,
				class = ic,
				typeid = tid,
				typenum = it,
			};
			CopyAllFromTableShort[cnt] = Types[ic].points[it].name;
			
			cnt = cnt + 1;
		end		
	end
	
	local ClassOpts, TypeOpts, BarOpts = {}, {}, {};
	local Opts_ClassOrderCnt = 30;
	local Opts_TypeOrderCnt = 10;
	
	for ic,vc in pairs(Types) do
		local ClassID = Types[ic].name;
		
		wipe(TypeOpts);
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id			
			local TypeDesc = Types[ic].points[it].name;
			
			TypeOpts[tid] = {
				type = "group",
				name = TypeDesc,
				childGroups = "tab",
				order = Opts_TypeOrderCnt,
				args = {
					header = {
						type = "header",
						name = string.format("%s - %s", ClassID, TypeDesc),
						order = 10,
					},
					enabled = {
						type = "toggle",
						name = "Enabled",
						desc = string.format("Enable/Disable the %s display.", TypeDesc),
						get = function() return db[ic].types[tid].enabled end,
						set = function(info, value) 
							db[ic].types[tid].enabled = value;
							db[ic].types[tid].configmode.enabled = false
							if not value then
								nibPointDisplay_RealUI:DisablePointDisplay(ic, tid);
							else
								nibPointDisplay_RealUI:EnablePointDisplay(ic, tid);
							end
						end,
						order = 20,					
					},
					sep = {
						type = "description",
						name = " ",
						order = 22,
					},
					copy = {
						type = "select",
						name = "Copy settings from",
						desc = "Copy all settings from another Point Display to this one.",
						set = function(info, value)
							local FromIC = CopyAllFromTable[value].class
							local FromTID = CopyAllFromTable[value].typeid
							local FromNum = CopyAllFromTable[value].typenum
							if FromTID ~= tid then
								nibPointDisplay_RealUI:CopyAllSettings(db[FromIC].types[FromTID], db[ic].types[tid], FromIC, ic, FromTID, tid, FromNum, it)
								nibPointDisplay_RealUI:GetTextures()
								nibPointDisplay_RealUI:UpdateBGPanelTextures()
								nibPointDisplay_RealUI:UpdatePosition()
								nibPointDisplay_RealUI:UpdatePoints("ENABLE")
							end
						end,
						style = "dropdown",
						width = nil,
						values = CopyAllFromTableShort,
						order = 24,
					},
					config = {
						name = "Configuration",
						type = "group",
						order = 30,
						disabled = function() if db[ic].types[tid].enabled then return false else return true end end,
						args = {
							configmode = {
								type = "toggle",
								name = "Configuration Mode",
								get = function(info) return db[ic].types[tid].configmode.enabled end,
								set = function(info, value) 
									db[ic].types[tid].configmode.enabled = value;
									nibPointDisplay_RealUI:UpdatePoints("ENABLE");
								end,
								order = 10,
							},
							configmodecount = {
								type = "range",
								name = "Config Mode point count",
								min = 0, max = Types[ic].points[it].barcount, step = 1,
								get = function(info) return db[ic].types[tid].configmode.count end,
								set = function(info, value) 
									db[ic].types[tid].configmode.count = value
									nibPointDisplay_RealUI:UpdatePoints("ENABLE")
								end,
								disabled = function() if db[ic].types[tid].configmode.enabled and db[ic].types[tid].enabled then return false else return true end end,
								order = 20,
							},
						},
					},				
					general = {
						name = "General Settings",
						type = "group",
						order = 70,
						disabled = function() if db[ic].types[tid].enabled then return false else return true end end,
						args = {
							appearance = {
								name = "Appearance",
								type = "group",
								order = 10,
								inline = true,
								args = {
									hideui = {
										type = "toggle",
										name = "Hide default UI display",
										desc = "Note: A UI reload (/reload ui) is required to make the default UI display visible again if you have it hidden.",
										width = "full",
										get = function(info) return db[ic].types[tid].general.hideui end,
										set = function(info, value) 
											db[ic].types[tid].general.hideui = value;
											nibPointDisplay_RealUI:HideUIElements();
										end,
										order = 10,
										disabled = function() if (tid == "cp" or tid == "hp" or tid == "ss") then return false else return true end end,
									},
									hideempty = {
										type = "toggle",
										name = "Hide unused points/stacks",
										desc = "Only show used the number of points/stacks you have. IE. If you have 4 Combo Points, the 5th Combo Point bar will remain hidden.",
										width = "full",
										get = function(info) return db[ic].types[tid].general.hideempty end,
										set = function(info, value) 
											db[ic].types[tid].general.hideempty = value;
											nibPointDisplay_RealUI:UpdatePoints("ENABLE");
										end,
										order = 20,
									},
									smarthide = {
										type = "toggle",
										name = "Smart hide",
										desc = "Hide while solo, ungrouped, not in an instance. Will still show if you have an attackable target selected or are in combat.",
										width = "full",
										get = function(info) return db[ic].types[tid].general.smarthide end,
										set = function(info, value) 
											db[ic].types[tid].general.smarthide = value;
											nibPointDisplay_RealUI:UpdateSmartHideConditions()
											nibPointDisplay_RealUI:UpdatePointDisplay()
										end,
										order = 30,
									},
									hidein = {
										type = "group",
										name = "Hide in",
										inline = true,
										order = 40,
										args = {
											vehicle = {
												type = "toggle",
												name = "Vehicle",
												desc = "Hide when in a Vehicle.",
												width = "full",
												get = function(info) return db[ic].types[tid].general.hidein.vehicle end,
												set = function(info, value) 
													db[ic].types[tid].general.hidein.vehicle = value;
													nibPointDisplay_RealUI:UpdatePoints("ENABLE");
												end,
												order = 10,
											},
											spec = {
												type = "select",
												name = "Spec",
												get = function(info)
													return db[ic].types[tid].general.hidein.spec
												end,
												set = function(info, value)
													db[ic].types[tid].general.hidein.spec = value
													nibPointDisplay_RealUI:UpdatePoints("ENABLE");
												end,
												style = "dropdown",
												width = nil,
												values = table_Specs,
												order = 30,
											},
										},
									},
									direction = {
										type = "group",
										name = "Direction",
										inline = true,
										order = 40,
										args = {
											reverse = {
												type = "toggle",
												name = "Reverse orientation",
												desc = string.format("Reverse the orientation of the %s display.", TypeDesc),
												width = "full",
												get = function(info) return db[ic].types[tid].general.direction.reverse end,
												set = function(info, value) 
													db[ic].types[tid].general.direction.reverse = value;
													nibPointDisplay_RealUI:UpdatePosition();
												end,
												order = 20,
											},
										},
									},									
								},
							},
						},
					},
					position = {
						type = "group",
						name = "Position",
						order = 80,
						disabled = function() if db[ic].types[tid].enabled then return false else return true end end,
						args = {
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
										order = 10,
										get = function(info) return tostring(db[ic].types[tid].position.x) end,
										set = function(info, value)
											value = ValidateOffset(value)
											db[ic].types[tid].position.x = value
											nibPointDisplay_RealUI:UpdatePosition()
										end,
									},
									yoffset = {
										type = "input",
										name = "Y Offset",
										width = "half",
										order = 20,
										get = function(info) return tostring(db[ic].types[tid].position.y) end,
										set = function(info, value)
											value = ValidateOffset(value)
											db[ic].types[tid].position.y = value
											nibPointDisplay_RealUI:UpdatePosition()
										end,
									},
								},
							},
							framelevel = {
								type = "group",
								name = "Strata",
								inline = true,
								order = 30,
								args = {
									strata = {
										type = "select",
										name = "Strata",
										get = function(info) 
											for k,v in pairs(table_Strata) do
												if v == db[ic].types[tid].position.framelevel.strata then return k end
											end
										end,
										set = function(info, value)
											db[ic].types[tid].position.framelevel.strata = table_Strata[value]
											nibPointDisplay_RealUI:UpdatePosition()
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
										get = function(info) return db[ic].types[tid].position.framelevel.level end,
										set = function(info, value) 
											db[ic].types[tid].position.framelevel.level = value
											nibPointDisplay_RealUI:UpdatePosition()
										end,
										order = 20,
									},
								},
							},
						},
					},
					bars = {
						name = "Point Bars",
						type = "group",
						childGroups = "tab",
						order = 90,
						disabled = function() if db[ic].types[tid].enabled then return false else return true end end,					
						args = {
							usecustom = {
								type = "toggle",
								name = "Use Custom RealUI Textures",
								width = "double",
								disabled = function() return tid ~= "hp" end,
								get = function(info) return db[ic].types[tid].bars.custom end,
								set = function(info, value) 
									db[ic].types[tid].bars.custom = value
									nibPointDisplay_RealUI:UpdatePoints("ENABLE")
								end,
								order = 10,
							},
							positionsize = {
								name = "Position/Size",
								type = "group",
								order = 20,
								args = {
									size = {
										type = "group",
										name = "Size",
										inline = true,
										order = 10,
										args = {
											width = {
												type = "input",
												name = "Width",
												width = "half",
												order = 10,
												get = function(info) return tostring(db[ic].types[tid].bars.size.width) end,
												set = function(info, value)
													value = ValidateOffset(value)
													db[ic].types[tid].bars.size.width = value
													nibPointDisplay_RealUI:UpdatePosition()
													nibPointDisplay_RealUI:UpdatePoints("ENABLE")
												end,
											},
											height = {
												type = "input",
												name = "Height",
												width = "half",
												order = 20,
												get = function(info) return tostring(db[ic].types[tid].bars.size.height) end,
												set = function(info, value)
													value = ValidateOffset(value)
													db[ic].types[tid].bars.size.height = value
													nibPointDisplay_RealUI:UpdatePosition()
													nibPointDisplay_RealUI:UpdatePoints("ENABLE")
												end,
											},
										},							
									},
									position = {
										name = "Position",
										type = "group",
										inline = true,
										order = 20,
										args = {
											gap = {
												type = "input",
												name = "Gap",
												desc = "Set the space between each Bar. Negative values bring them closer together. Positive values push them further apart.",
												width = "half",
												order = 30,
												get = function(info) return tostring(db[ic].types[tid].bars.position.gap) end,
												set = function(info, value)
													value = ValidateOffset(value)
													db[ic].types[tid].bars.position.gap = value
													nibPointDisplay_RealUI:UpdatePosition()
												end,
											},
										},
									},
								},
							},
							background = {
								name = "Background",
								type = "group",
								-- disabled = function() return db[ic].types[tid].bars.custom end,
								order = 30,
								args = {
									empty = {
										name = "Empty",
										type = "group",
										inline = true,
										order = 10,
										args = {
											texture = {
												type = "select",
												name = "Texture",
												values = AceGUIWidgetLSMlists.background,
												get = function()
													return db[ic].types[tid].bars.bg.empty.texture
												end,
												set = function(info, value)
													db[ic].types[tid].bars.bg.empty.texture = value
													nibPointDisplay_RealUI:GetTextures()
													nibPointDisplay_RealUI:UpdatePoints("ENABLE")
												end,
												dialogControl='LSM30_Background',
												order = 10,
											},
											color = {
												type = "color",
												name = "Color",
												hasAlpha = true,
												get = function(info,r,g,b,a)
													return db[ic].types[tid].bars.bg.empty.color.r, db[ic].types[tid].bars.bg.empty.color.g, db[ic].types[tid].bars.bg.empty.color.b, db[ic].types[tid].bars.bg.empty.color.a
												end,
												set = function(info,r,g,b,a)
													db[ic].types[tid].bars.bg.empty.color.r = r
													db[ic].types[tid].bars.bg.empty.color.g = g
													db[ic].types[tid].bars.bg.empty.color.b = b
													db[ic].types[tid].bars.bg.empty.color.a = a
													nibPointDisplay_RealUI:UpdatePoints("ENABLE")
												end,
												order = 20,
											},
										},
									},
									full = {
										name = "Full",
										type = "group",
										inline = true,
										order = 20,
										args = {
											texture = {
												type = "select",
												name = "Texture",
												values = AceGUIWidgetLSMlists.background,
												get = function()
													return db[ic].types[tid].bars.bg.full.texture
												end,
												set = function(info, value)
													db[ic].types[tid].bars.bg.full.texture = value
													nibPointDisplay_RealUI:GetTextures()
													nibPointDisplay_RealUI:UpdatePoints("ENABLE")
												end,
												dialogControl='LSM30_Background',
												order = 10,
											},
											colors = {
												type = "group",
												name = "Colors",
												inline = true,
												order = 20,
												args = {
													color = {
														type = "color",
														name = "Normal",
														hasAlpha = true,
														get = function(info,r,g,b,a)
															return db[ic].types[tid].bars.bg.full.color.r, db[ic].types[tid].bars.bg.full.color.g, db[ic].types[tid].bars.bg.full.color.b, db[ic].types[tid].bars.bg.full.color.a
														end,
														set = function(info,r,g,b,a)
															db[ic].types[tid].bars.bg.full.color.r = r
															db[ic].types[tid].bars.bg.full.color.g = g
															db[ic].types[tid].bars.bg.full.color.b = b
															db[ic].types[tid].bars.bg.full.color.a = a
															nibPointDisplay_RealUI:UpdatePoints("ENABLE")
														end,
														order = 10,
													},
													maxcolor = {
														type = "color",
														name = "Max Points",
														desc = string.format("%s %s %s", "Set the background color of this Bar when", TypeDesc, "reaches it's maximum stacks."),
														hasAlpha = true,
														get = function(info,r,g,b,a)
															return db[ic].types[tid].bars.bg.full.maxcolor.r, db[ic].types[tid].bars.bg.full.maxcolor.g, db[ic].types[tid].bars.bg.full.maxcolor.b, db[ic].types[tid].bars.bg.full.maxcolor.a
														end,
														set = function(info,r,g,b,a)
															db[ic].types[tid].bars.bg.full.maxcolor.r = r
															db[ic].types[tid].bars.bg.full.maxcolor.g = g
															db[ic].types[tid].bars.bg.full.maxcolor.b = b
															db[ic].types[tid].bars.bg.full.maxcolor.a = a
															nibPointDisplay_RealUI:UpdatePoints("ENABLE")
														end,
														order = 20,
													},
												},
											},
										},
									},
								},
							},
							surround = {
								name = "Surround",
								type = "group",
								disabled = function() return db[ic].types[tid].bars.custom end,
								order = 40,
								args = {
									texture = {
										type = "select",
										name = "Texture",
										values = AceGUIWidgetLSMlists.background,
										get = function()
											return db[ic].types[tid].bars.surround.texture
										end,
										set = function(info, value)
											db[ic].types[tid].bars.surround.texture = value
											nibPointDisplay_RealUI:GetTextures()
											nibPointDisplay_RealUI:UpdatePoints("ENABLE")
										end,
										dialogControl='LSM30_Background',
										order = 10,
									},
									color = {
										type = "color",
										name = "Color",
										hasAlpha = true,
										get = function(info,r,g,b,a)
											return db[ic].types[tid].bars.surround.color.r, db[ic].types[tid].bars.surround.color.g, db[ic].types[tid].bars.surround.color.b, db[ic].types[tid].bars.surround.color.a
										end,
										set = function(info,r,g,b,a)
											db[ic].types[tid].bars.surround.color.r = r
											db[ic].types[tid].bars.surround.color.g = g
											db[ic].types[tid].bars.surround.color.b = b
											db[ic].types[tid].bars.surround.color.a = a
											nibPointDisplay_RealUI:UpdatePoints("ENABLE")
										end,
										order = 20,
									},
								},
							},
						},
					},
				},
			};
			
			Opts_TypeOrderCnt = Opts_TypeOrderCnt + 10;
		end
		
		-- Create new Class table
		ClassOpts[ic] = {
			name = ClassID,
			type = "group",
			order = Opts_ClassOrderCnt,
			args = {},
		};
		-- Fill out new Class table with it's Types
		for key, val in pairs(TypeOpts) do
			ClassOpts[ic].args[key] = (type(val) == "function") and val() or val
		end
		
		Opts_ClassOrderCnt = Opts_ClassOrderCnt + 10;
	end
	
	-- Combat Fader
	local Opts_CombatFader = {
		["combatfader"] = {
			type = "group",
			name = "Combat Fader",
			childGroups = "tab",
			order = 5,
			args = {
				header = {
					type = "header",
					name = "Combat Fader",
					order = 10,
				},
				desc = {
					type = "description",
					name = "Controls the fading of the Point Displays based on player status.",
					order = 20,
				},
				enabled = {
					type = "toggle",
					name = "Enabled",
					desc = "Enable/Disable combat fading.",
					get = function() return db.combatfader.enabled end,
					set = function(info, value) 
						db.combatfader.enabled = value
						nibPointDisplay_RealUI:UpdateCombatFader()
					end,
					order = 30,
				},
				sep = {
					type = "description",
					name = " ",
					order = 40,
				},
				opacity = {
					type = "group",
					name = "Opacity",
					inline = true,
					disabled = function() if db.combatfader.enabled then return false else return true end end,
					order = 60,
					args = {
						incombat = {
							type = "range",
							name = "In-combat",
							min = 0, max = 1, step = 0.05,
							isPercent = true,
							get = function(info) return db.combatfader.opacity.incombat end,
							set = function(info, value) db.combatfader.opacity.incombat = value; nibPointDisplay_RealUI:UpdateCombatFader(); end,
							order = 10,
						},
						hurt = {
							type = "range",
							name = "Hurt",
							min = 0, max = 1, step = 0.05,
							isPercent = true,
							get = function(info) return db.combatfader.opacity.hurt end,
							set = function(info, value) db.combatfader.opacity.hurt = value; nibPointDisplay_RealUI:UpdateCombatFader(); end,
							order = 20,
						},
						target = {
							type = "range",
							name = "Target-selected",
							min = 0, max = 1, step = 0.05,
							isPercent = true,
							get = function(info) return db.combatfader.opacity.target end,
							set = function(info, value) db.combatfader.opacity.target = value; nibPointDisplay_RealUI:UpdateCombatFader(); end,
							order = 30,
						},
						outofcombat = {
							type = "range",
							name = "Out-of-combat",
							min = 0, max = 1, step = 0.05,
							isPercent = true,
							get = function(info) return db.combatfader.opacity.outofcombat end,
							set = function(info, value) db.combatfader.opacity.outofcombat = value; nibPointDisplay_RealUI:UpdateCombatFader(); end,
							order = 40,
						},
					},
				},
			},
		},
	}
	for k, v in pairs(Opts_CombatFader) do
		ClassOpts[k] = (type(v) == "function") and v() or v
	end
	
	-- Fill out Options table with all Classes
	for key, val in pairs(ClassOpts) do
		options.args[key] = (type(val) == "function") and val() or val
	end
end

-- Copy All Settings
function nibPointDisplay_RealUI:CopyAllSettings(FromTable, ToTable, FromIC, ToIC, FromTID, ToTID, FromNum, ToNum)
	if not FromTable or not ToTable then return false end
	for i,v in pairs(FromTable) do
		if type(FromTable[i]) == "table" then
			for i2,v2 in pairs(FromTable[i]) do
				if type(FromTable[i][i2]) == "table" then
					for i3,v3 in pairs(FromTable[i][i2]) do
						if type(FromTable[i][i2][i3]) == "table" then
							for i4,v4 in pairs(FromTable[i][i2][i3]) do
								if type(FromTable[i][i2][i3][i4]) == "table" then
									for i5,v5 in pairs(FromTable[i][i2][i3][i4]) do
										if type(FromTable[i][i2][i3][i4][i5]) == "table" then
											for i6,v6 in pairs(FromTable[i][i2][i3][i4][i5]) do
												if type(FromTable[i][i2][i3][i4][i5][i6]) == "table" then
													for i7,v7 in pairs(FromTable[i][i2][i3][i4][i5][i6]) do
														ToTable[i][i2][i3][i4][i5][i6][i7] = FromTable[i][i2][i3][i4][i5][i6][i7]
													end
												else
													ToTable[i][i2][i3][i4][i5][i6] = FromTable[i][i2][i3][i4][i5][i6]
												end
											end
										else
											ToTable[i][i2][i3][i4][i5] = FromTable[i][i2][i3][i4][i5]
										end
									end
								else
									ToTable[i][i2][i3][i4] = FromTable[i][i2][i3][i4]
								end
							end
						else
							ToTable[i][i2][i3] = FromTable[i][i2][i3]
						end
					end
				else
					ToTable[i][i2] = FromTable[i][i2]
				end
			end
		else
			ToTable[i] = FromTable[i]
		end
	end
	
	-- Disable config mode
	db[ToIC].types[ToTID].configmode.enabled = false;
	db[ToIC].types[ToTID].configmode.count = 2;
	
	return true
end

-- Copy Bar Settings
function nibPointDisplay_RealUI:CopyBarSettings(FromTable, ToTable)
	if not FromTable or not ToTable then return false end
	for i,v in pairs(FromTable) do
		if type(FromTable[i]) == "table" then
			for i2,v2 in pairs(FromTable[i]) do
				if type(FromTable[i][i2]) == "table" then
					for i3,v3 in pairs(FromTable[i][i2]) do
						if type(FromTable[i][i2][i3]) == "table" then
							for i4,v4 in pairs(FromTable[i][i2][i3]) do
								if type(FromTable[i][i2][i3][i4]) == "table" then
									for i5,v5 in pairs(FromTable[i][i2][i3][i4]) do
										if type(FromTable[i][i2][i3][i4][i5]) == "table" then
											for i6,v6 in pairs(FromTable[i][i2][i3][i4][i5]) do
												ToTable[i][i2][i3][i4][i5][i6] = FromTable[i][i2][i3][i4][i5][i6]
											end
										else
											ToTable[i][i2][i3][i4][i5] = FromTable[i][i2][i3][i4][i5]
										end
									end
								else
									ToTable[i][i2][i3][i4] = FromTable[i][i2][i3][i4]
								end
							end
						else
							ToTable[i][i2][i3] = FromTable[i][i2][i3]
						end
					end
				else
					ToTable[i][i2] = FromTable[i][i2]
				end
			end
		else
			ToTable[i] = FromTable[i]
		end
	end
	
	return true
end

local intoptions = nil;
local function GetIntOptions()
	if not intoptions then
		intoptions = {
			name = "nibPointDisplay_RealUI",
			handler = nibPointDisplay_RealUI,
			type = "group",
			args = {
				note = {
					type = "description",
					name = "You can access the nibPointDisplay_RealUI options by typing: /nibpd",
					order = 10,
				},
				openoptions = {
					type = "execute",
					name = "Open config...",
					func = function() 
						InterfaceOptionsFrame_Show()
						nibPointDisplay_RealUI:OpenOptions()
					end,
					order = 20,
				},
			},
		};
	end
	return intoptions;
end

function nibPointDisplay_RealUI:OpenOptions()
	if not options then nibPointDisplay_RealUI:SetUpOptions() end
	LibStub("AceConfigDialog-3.0"):Open("nibPointDisplay_RealUI");
end

function nibPointDisplay_RealUI:ChatCommand(input)
	nibPointDisplay_RealUI:OpenOptions()
end

function nibPointDisplay_RealUI:ConfigRefresh()
	db = self.db.profile;
end

function nibPointDisplay_RealUI:SetUpInitialOptions()
	-- Chat commands
	self:RegisterChatCommand("nibpd", "ChatCommand");
	self:RegisterChatCommand("nibPointDisplay_RealUI", "ChatCommand");
	
	-- Interface panel options
	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibPointDisplay_RealUI-Int", GetIntOptions);
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("nibPointDisplay_RealUI-Int", "nibPointDisplay_RealUI");
end

function nibPointDisplay_RealUI:SetUpOptions()
	db = self.db.profile;
	
	-- Primary options
	GetOptions();
	
	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db);
	options.args.profiles.order = 10000;
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibPointDisplay_RealUI", options);
	LibStub("AceConfigDialog-3.0"):SetDefaultSize("nibPointDisplay_RealUI", 800, 600)
end