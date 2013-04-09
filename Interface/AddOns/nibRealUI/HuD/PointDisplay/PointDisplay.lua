local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

local MODNAME = "PointDisplay"
local PointDisplay = nibRealUI:NewModule(MODNAME, "AceEvent-3.0", "AceBucket-3.0")
local LSM = LibStub("LibSharedMedia-3.0")
local db, ndbc

local floor = math.floor

local Types = {
	["GENERAL"] = {
		name = "General",
		points = {
			[1] = {name = "Combo Points", id = "cp", barcount = 5},
		},
	},
	["DEATHKNIGHT"] = {
		name = "Death Knight",
		points = {
			[1] = {name = "Shadow Infusion", id = "si", barcount = 5},
			[2] = {name = "Bone Shield", id = "bs", barcount = 6},
		},
	},
	["DRUID"] = {
		name = "Druid",
		points = {
			[1] = {name = "Lunar Shower", id = "lus", barcount = 3},
			[2] = {name = "Lacerate", id = "lac", barcount = 3},
			[3] = {name = "Wild Mushroom", id = "wm", barcount = 3},
			[4] = {name = "Astral Alignment", id = "al", barcount = 3},
			[5] = {name = "Dream of Cenarius (DPS)", id = "docd", barcount = 2},
			[6] = {name = "Dream of Cenarius (Heal)", id = "doch", barcount = 2},
		},
	},
	["HUNTER"] = {
		name = "Hunter",
		points = {
			[1] = {name = "Ready Set Aim", id = "rsa", barcount = 3},
			[2] = {name = "Frenzy Effect", id = "fe", barcount = 5},
		},
	},
	["MAGE"] = {
		name = "Mage",
		points = {
			[1] = {name = "Arcane Blast", id = "ab", barcount = 6},
			[2] = {name = "Fingers of Frost", id = "ff", barcount = 2},
		},
	},
	["MONK"] = {
		name = "Monk",
		points = {
			[1] = {name = "Chi", id = "chi", barcount = 5},
			[2] = {name = "Serpents Zeal", id = "sz", barcount = 2},
			[3] = {name = "Vital Mists", id = "vm", barcount = 5},
			[4] = {name = "Elusive Brew", id = "eb", barcount = 5},
		},
	},
	["PALADIN"] = {
		name = "Paladin",
		points = {
			[1] = {name = "Holy Power", id = "hp", barcount = 5},
		},
	},
	["PRIEST"] = {
		name = "Priest",
		points = {
			[1] = {name = "Evangelism", id = "eva", barcount = 5},
			[2] = {name = "Shadow Orbs", id = "so", barcount = 3},
			[3] = {name = "Serendipity", id = "ser", barcount = 2},
			[4] = {name = "Mind Spike", id = "ms", barcount = 2},
		},
	},
	["ROGUE"] = {
		name = "Rogue",
		points = {
			[1] = {name = "Anticipation Points", id = "ap", barcount = 5},
		},
	},
	["SHAMAN"] = {
		name = "Shaman",
		points = {
			[1] = {name = "Maelstrom Weapon", id = "mw", barcount = 5},
			[2] = {name = "Lighting Shield", id = "ls", barcount = 6},
			[3] = {name = "Tidal Waves", id = "tw", barcount = 2},
			[4] = {name = "Water Shield", id = "ws", barcount = 3},
		},		
	},
	["WARLOCK"] = {
		name = "Warlock",
		points = {
			[1] = {name = "Soul Shards", id = "ss", barcount = 4},
			[2] = {name = "Burning Embers", id = "be", barcount = 4},
			[3] = {name = "Molten Core", id = "mco", barcount = 3},
		},
	},
	["WARRIOR"] = {
		name = "Warrior",
		points = {
			[1] = {name = "Thunderstruck", id = "ts", barcount = 3},
			[2] = {name = "Meat Cleaver", id = "mc", barcount = 3},
			[3] = {name = "Sunder Armor", id = "sa", barcount = 3},
			[4] = {name = "Taste for Blood", id = "tb", barcount = 5},
		},
	},
}

-----------------
---- Options ----
-----------------
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
}

local table_Orientation = {
	"Horizontal",
	"Vertical",
}

local table_Strata = {
	"BACKGROUND",
	"LOW",
	"MEDIUM",
	"HIGH",
	"DIALOG",
	"TOOLTIP",
}

local table_Specs = {
	"None",
	"Primary",
	"Secondary",
}

-- Return the Options table
local options = nil
local function GetOptions()
	if not options then
		options = {
			type = "group",
			name = "Point Display",
			arg = MODNAME,
			order = 1615,
			args = {
				header = {
					type = "header",
					name = "Point Display",
					order = 10,
				},
				enabled = {
					type = "toggle",
					name = "Enabled",
					desc = "Enable/Disable the Point Display module.",
					get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
					set = function(info, value) 
						nibRealUI:SetModuleEnabled(MODNAME, value)
						nibRealUI:ReloadUIDialog()
					end,
					order = 20,
				},
				gap1 = {
					name = " ",
					type = "description",
					order = 21,
				},
				updatespeed = {
					type = "range",
					name = "Update Speed (r/sec)",
					desc = "Throttle the Point Display updates to X times a second.\n\nHigher = faster updates, but more CPU usage.\n\nRequires a UI Reload (/rl) to take effect.",
					disabled = function() return not(nibRealUI:GetModuleEnabled(MODNAME)) end,
					min = 1, max = 30, step = 1,
					get = function(info) return db.updatespeed end,
					set = function(info, value) db.updatespeed = value end,
					order = 30,
				},
			},
		}
	end
	
	-- Create Copy All table
	local CopyAllFromTable = {}
	local CopyAllFromTableShort = {}
	local cnt = 1
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
			}
			CopyAllFromTableShort[cnt] = Types[ic].points[it].name
			
			cnt = cnt + 1
		end		
	end
	
	local ClassOpts, TypeOpts, BarOpts = {}, {}, {}
	local Opts_ClassOrderCnt = 40
	local Opts_TypeOrderCnt = 10
	
	for ic,vc in pairs(Types) do
		local ClassID = Types[ic].name
		
		wipe(TypeOpts)
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id			
			local TypeDesc = Types[ic].points[it].name
			
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
							db[ic].types[tid].enabled = value
							db[ic].types[tid].configmode.enabled = false
							if not value then
								PointDisplay:DisablePointDisplay(ic, tid)
							else
								PointDisplay:EnablePointDisplay(ic, tid)
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
								PointDisplay:CopyAllSettings(db[FromIC].types[FromTID], db[ic].types[tid], FromIC, ic, FromTID, tid, FromNum, it)
								PointDisplay:GetTextures()
								PointDisplay:UpdateBGPanelTextures()
								PointDisplay:UpdatePosition()
								PointDisplay:UpdatePoints("ENABLE")
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
									db[ic].types[tid].configmode.enabled = value
									PointDisplay:UpdatePoints("ENABLE")
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
									PointDisplay:UpdatePoints("ENABLE")
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
											db[ic].types[tid].general.hideui = value
											PointDisplay:HideUIElements()
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
											db[ic].types[tid].general.hideempty = value
											PointDisplay:UpdatePoints("ENABLE")
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
											db[ic].types[tid].general.smarthide = value
											PointDisplay:UpdateSmartHideConditions()
											PointDisplay:UpdatePointDisplay()
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
													db[ic].types[tid].general.hidein.vehicle = value
													PointDisplay:UpdatePoints("ENABLE")
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
													PointDisplay:UpdatePoints("ENABLE")
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
													db[ic].types[tid].general.direction.reverse = value
													PointDisplay:UpdatePosition()
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
											value = nibRealUI:ValidateOffset(value)
											db[ic].types[tid].position.x = value
											PointDisplay:UpdatePosition()
										end,
									},
									yoffset = {
										type = "input",
										name = "Y Offset",
										width = "half",
										order = 20,
										get = function(info) return tostring(db[ic].types[tid].position.y) end,
										set = function(info, value)
											value = nibRealUI:ValidateOffset(value)
											db[ic].types[tid].position.y = value
											PointDisplay:UpdatePosition()
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
											PointDisplay:UpdatePosition()
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
											PointDisplay:UpdatePosition()
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
									PointDisplay:UpdatePoints("ENABLE")
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
													value = nibRealUI:ValidateOffset(value)
													db[ic].types[tid].bars.size.width = value
													PointDisplay:UpdatePosition()
													PointDisplay:UpdatePoints("ENABLE")
												end,
											},
											height = {
												type = "input",
												name = "Height",
												width = "half",
												order = 20,
												get = function(info) return tostring(db[ic].types[tid].bars.size.height) end,
												set = function(info, value)
													value = nibRealUI:ValidateOffset(value)
													db[ic].types[tid].bars.size.height = value
													PointDisplay:UpdatePosition()
													PointDisplay:UpdatePoints("ENABLE")
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
													value = nibRealUI:ValidateOffset(value)
													db[ic].types[tid].bars.position.gap = value
													PointDisplay:UpdatePosition()
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
													PointDisplay:GetTextures()
													PointDisplay:UpdatePoints("ENABLE")
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
													PointDisplay:UpdatePoints("ENABLE")
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
													PointDisplay:GetTextures()
													PointDisplay:UpdatePoints("ENABLE")
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
															PointDisplay:UpdatePoints("ENABLE")
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
															PointDisplay:UpdatePoints("ENABLE")
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
											PointDisplay:GetTextures()
											PointDisplay:UpdatePoints("ENABLE")
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
											PointDisplay:UpdatePoints("ENABLE")
										end,
										order = 20,
									},
								},
							},
						},
					},
				},
			}
			
			Opts_TypeOrderCnt = Opts_TypeOrderCnt + 10
		end
		
		-- Create new Class table
		ClassOpts[ic] = {
			name = ClassID,
			type = "group",
			order = Opts_ClassOrderCnt,
			args = {},
		}
		-- Fill out new Class table with it's Types
		for key, val in pairs(TypeOpts) do
			ClassOpts[ic].args[key] = (type(val) == "function") and val() or val
		end
		
		Opts_ClassOrderCnt = Opts_ClassOrderCnt + 10
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
						PointDisplay:UpdateCombatFader()
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
							set = function(info, value) db.combatfader.opacity.incombat = value; PointDisplay:UpdateCombatFader(); end,
							order = 10,
						},
						hurt = {
							type = "range",
							name = "Hurt",
							min = 0, max = 1, step = 0.05,
							isPercent = true,
							get = function(info) return db.combatfader.opacity.hurt end,
							set = function(info, value) db.combatfader.opacity.hurt = value; PointDisplay:UpdateCombatFader(); end,
							order = 20,
						},
						target = {
							type = "range",
							name = "Target-selected",
							min = 0, max = 1, step = 0.05,
							isPercent = true,
							get = function(info) return db.combatfader.opacity.target end,
							set = function(info, value) db.combatfader.opacity.target = value; PointDisplay:UpdateCombatFader(); end,
							order = 30,
						},
						outofcombat = {
							type = "range",
							name = "Out-of-combat",
							min = 0, max = 1, step = 0.05,
							isPercent = true,
							get = function(info) return db.combatfader.opacity.outofcombat end,
							set = function(info, value) db.combatfader.opacity.outofcombat = value; PointDisplay:UpdateCombatFader(); end,
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
	
	return options
end

-- Copy All Settings
function PointDisplay:CopyAllSettings(FromTable, ToTable, FromIC, ToIC, FromTID, ToTID, FromNum, ToNum)
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
	db[ToIC].types[ToTID].configmode.enabled = false
	db[ToIC].types[ToTID].configmode.count = 2
	
	return true
end

-- Copy Bar Settings
function PointDisplay:CopyBarSettings(FromTable, ToTable)
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

---- Spell Info table
local SpellInfo = {
	["si"] = nil,
	["bs"] = nil,
	["lus"] = nil,
	["lac"] = nil,
	["docd"] = nil,
	["doch"] = nil,
	["al"] = nil,
	["rsa"] = nil,
	["fe"] = nil,
	["ab"] = nil,
	["ff"] = nil,
	["sz"] = nil,
	["vm"] = nil,
	["eb"] = nil,
	["eva"] = nil,
	["ser"] = nil,
	["ap"] = nil,
	["mw"] = nil,
	["ls"] = nil,
	["tw"] = nil,
	["ws"] = nil,
	["mco"] = nil,
	["ts"] = nil,
	["mc"] = nil,
	["sa"] = nil,
	["tb"] = nil,
}

-- Point Display tables
local Frames = {}
local BG = {}

-- Points
local Points = {}
local PointsChanged = {}
local EBPoints = 0	-- Elusive Brew

local HolyPowerTexture
local SoulShardBG

local PlayerClass
local PlayerSpec
local PlayerTalent = 0
local PlayerInCombat
local PlayerTargetHostile
local PlayerInInstance
local SmartHideConditions
local ValidClasses

-- Combat Fader
local CFFrame = CreateFrame("Frame")
local FadeTime = 0.25
local CFStatus = nil

-- Power 'Full' check
local power_check = {
	MANA = function()
		return UnitMana("player") < UnitManaMax("player")
	end,
	RAGE = function()
		return UnitMana("player") > 0
	end,
	ENERGY = function()
		return UnitMana("player") < UnitManaMax("player")
	end,
	RUNICPOWER = function()
		return UnitMana("player") > 0
	end,
}

-- Fade frame
local function FadeIt(self, NewOpacity)
	local CurrentOpacity = self:GetAlpha()
	if NewOpacity > CurrentOpacity then
		UIFrameFadeIn(self, FadeTime, CurrentOpacity, NewOpacity)
	elseif NewOpacity < CurrentOpacity then
		UIFrameFadeOut(self, FadeTime, CurrentOpacity, NewOpacity)
	end
end

-- Determine new opacity values for frames
function PointDisplay:FadeFrames()
	for ic,vc in pairs(Types) do
		for it,vt in ipairs(Types[ic].points) do
			local NewOpacity
			local tid = Types[ic].points[it].id
			-- Retrieve opacity/visibility for current status
			NewOpacity = 1
			if db.combatfader.enabled then
				if CFStatus == "DISABLED" then
					NewOpacity = 1
				elseif CFStatus == "INCOMBAT" then
					NewOpacity = db.combatfader.opacity.incombat
				elseif CFStatus == "TARGET" then
					NewOpacity = db.combatfader.opacity.target
				elseif CFStatus == "HURT" then
					NewOpacity = db.combatfader.opacity.hurt
				elseif CFStatus == "OUTOFCOMBAT" then
					NewOpacity = db.combatfader.opacity.outofcombat
				end

				-- Fade Frame
				FadeIt(Frames[ic][tid].bgpanel.frame, NewOpacity)
			else
				-- Combat Fader disabled for this frame
				if Frames[ic][tid].bgpanel.frame:GetAlpha() < 1 then
					FadeIt(Frames[ic][tid].bgpanel.frame, NewOpacity)
				end
			end
		end
	end
	PointDisplay:UpdatePointDisplay("ENABLE")
end

function PointDisplay:UpdateCFStatus()
	local OldStatus = CFStatus
	
	-- Combat Fader based on status
	if UnitAffectingCombat("player") then
		CFStatus = "INCOMBAT"
	elseif UnitExists("target") then
		CFStatus = "TARGET"
	elseif UnitHealth("player") < UnitHealthMax("player") then
		CFStatus = "HURT"
	else
		local _, power_token = UnitPowerType("player")
		local func = power_check[power_token]
		if func and func() then
			CFStatus = "HURT"
		else
			CFStatus = "OUTOFCOMBAT"
		end
	end
	if CFStatus ~= OldStatus then PointDisplay:FadeFrames() end
end

function PointDisplay:UpdateCombatFader()
	CFStatus = nil
	PointDisplay:UpdateCFStatus()
end

-- On combat state change
function PointDisplay:CombatFaderCombatState()
	-- If in combat, then don't worry about health/power events
	if UnitAffectingCombat("player") then
		CFFrame:UnregisterEvent("UNIT_HEALTH")
		CFFrame:UnregisterEvent("UNIT_POWER")
		CFFrame:UnregisterEvent("UNIT_DISPLAYPOWER")
	else
		CFFrame:RegisterEvent("UNIT_HEALTH")
		CFFrame:RegisterEvent("UNIT_POWER")
		CFFrame:RegisterEvent("UNIT_DISPLAYPOWER")
	end
end

-- Register events for Combat Fader status
function PointDisplay:UpdateCombatFaderEnabled()
	CFFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	CFFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	CFFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	CFFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	
	CFFrame:SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_REGEN_DISABLED" then
			PointDisplay:CombatFaderCombatState()
			PointDisplay:UpdateCFStatus()
		elseif event == "UNIT_HEALTH" or event == "UNIT_POWER" or event == "UNIT_DISPLAYPOWER" then
			local unit = ...
			if unit == "player" then
				PointDisplay:UpdateCFStatus()
			end
		elseif event == "PLAYER_TARGET_CHANGED" then
			PointDisplay:UpdateCFStatus()
		elseif event == "PLAYER_ENTERING_WORLD" then
			PointDisplay:CombatFaderCombatState()
			PointDisplay:UpdateCombatFader()
		end
	end)
	
	PointDisplay:UpdateCombatFader()
	PointDisplay:FadeFrames()
end

-- Update Point Bars
local PBTex = {}
local ebColors = {
	[1] = {1, 1, 1},
	[2] = {1, 1, 0},
	[0] = {1, 0, 0}
}
local function SetPointBarTextures(shown, ic, it, tid, i)
	if tid == "hp" and db[ic].types[tid].bars.custom then
		PBTex.empty = nil
		PBTex.full = HolyPowerTexture[i]
		PBTex.surround = nil
	else
		PBTex.empty = BG[ic][tid].bars.empty
		PBTex.full = BG[ic][tid].bars.full
		PBTex.surround = BG[ic][tid].bars.surround
	end
	
	-- Visible Bar
	if shown then
		-- BG
		Frames[ic][tid].bars[i].bg:SetTexture(PBTex.full)
		
		-- Colors
		if tid == "eb" then	-- Elusive Brew stack coloring
			local ebColor
			for ebi = 1, 5 do
				Frames[ic][tid].bars[ebi].bg:SetVertexColor(ebColors[0][1], ebColors[0][2], ebColors[0][3], 1)
			end
			if i == Points["eb"] then
				ebColor = ebColors[(EBPoints % 3)]
				Frames[ic][tid].bars[i].bg:SetVertexColor(ebColor[1], ebColor[2], ebColor[3], 1)
			end
		else
			if Points[tid] < Types[ic].points[it].barcount then
				Frames[ic][tid].bars[i].bg:SetVertexColor(db[ic].types[tid].bars.bg.full.color.r, db[ic].types[tid].bars.bg.full.color.g, db[ic].types[tid].bars.bg.full.color.b, db[ic].types[tid].bars.bg.full.color.a)
			else
				Frames[ic][tid].bars[i].bg:SetVertexColor(db[ic].types[tid].bars.bg.full.maxcolor.r, db[ic].types[tid].bars.bg.full.maxcolor.g, db[ic].types[tid].bars.bg.full.maxcolor.b, db[ic].types[tid].bars.bg.full.maxcolor.a)
			end
		end
		Frames[ic][tid].bars[i].surround:SetVertexColor(db[ic].types[tid].bars.surround.color.r, db[ic].types[tid].bars.surround.color.g, db[ic].types[tid].bars.surround.color.b, db[ic].types[tid].bars.surround.color.a)
		
	-- Empty Bar
	else
		-- BG
		Frames[ic][tid].bars[i].bg:SetTexture(PBTex.empty)
		Frames[ic][tid].bars[i].bg:SetVertexColor(db[ic].types[tid].bars.bg.empty.color.r, db[ic].types[tid].bars.bg.empty.color.g, db[ic].types[tid].bars.bg.empty.color.b, db[ic].types[tid].bars.bg.empty.color.a)
	end
	Frames[ic][tid].bars[i].surround:SetTexture(PBTex.surround)
end

function PointDisplay:UpdatePointDisplay(...)
	local UpdateList
	if ... == "ENABLE" then
		-- Update everything
		UpdateList = Types
	else
		UpdateList = ValidClasses
	end
	
	-- Cycle through all Types that need updating
	for ic,vc in pairs(UpdateList) do
		-- Cycle through all Point Displays in current Type
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id
			
			-- Do we hide the Display
			if ((Points[tid] == 0)
				or (ic ~= PlayerClass and ic ~= "GENERAL") 
				or ((PlayerClass ~= "ROGUE") and (PlayerClass ~= "DRUID") and (ic == "GENERAL") and not UnitHasVehicleUI("player"))
				or ((PlayerClass == "WARLOCK") and (PlayerTalent == 1) and (tid == "be")) --
				or ((PlayerClass == "WARLOCK") and (PlayerTalent == 3) and (tid == "ss")) --	
				or (db[ic].types[tid].general.hidein.vehicle and UnitHasVehicleUI("player")) 
				or ((db[ic].types[tid].general.hidein.spec - 1) == PlayerSpec)
				or (db[ic].types[tid].general.smarthide and SmartHideConditions))
				and not db[ic].types[tid].configmode.enabled then
					-- Hide Display	
					Frames[ic][tid].bgpanel.frame:Hide()
			else
			-- Update the Display
				-- Update Bars if their Points have changed
				if PointsChanged[tid] then
					for i = 1, Types[ic].points[it].barcount do
						if Points[tid] == nil then Points[tid] = 0 end
						if Points[tid] >= i then
						-- Show bar and set textures to "Full"
							Frames[ic][tid].bars[i].frame:Show()
							SetPointBarTextures(true, ic, it, tid, i)
						else
							if db[ic].types[tid].general.hideempty then
							-- Hide "empty" bar
								Frames[ic][tid].bars[i].frame:Hide()
							else
							-- Show bar and set textures to "Empty"
								Frames[ic][tid].bars[i].frame:Show()
								SetPointBarTextures(false, ic, it, tid, i)
							end				
						end
						
					end
					-- Show the Display
					Frames[ic][tid].bgpanel.frame:Show()
					
					-- Flag as having been changed
					PointsChanged[tid] = false
				end
			end
		end
	end
end

-- Point retrieval
local function GetDebuffCount(SpellID, ...)
	if not SpellID then return end
	local unit = ... or "target"
	local _,_,_,count,_,_,_,caster = UnitDebuff(unit, SpellID)
	if count == nil then count = 0 end
	if caster ~= "player" then count = 0 end	-- Only show Debuffs cast by me
	return count
end

local function GetBuffCount(SpellID, ...)
	if not SpellID then return end
	local unit = ... or "player"
	local _,_,_,count = UnitAura(unit, SpellID)
	if count == nil then count = 0 end
	return count
end

function PointDisplay:GetPoints(CurClass, CurType)
	local NewPoints
	-- General
	if CurClass == "GENERAL" then
		-- Combo Points
		if CurType == "cp" then
			NewPoints = GetComboPoints(UnitHasVehicleUI("player") and "vehicle" or "player", "target")
		end
	-- Death Knight
	elseif CurClass == "DEATHKNIGHT" then
		-- Shadow Infusion
		if CurType == "si" then
			NewPoints = GetBuffCount(SpellInfo[CurType], "pet")
		-- Bone Shield
		elseif CurType == "bs" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		end
	-- Druid
	elseif CurClass == "DRUID" then
		-- Lunar Shower
		if CurType == "lus" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Lacerate
		elseif CurType == "lac" then
			NewPoints = GetDebuffCount(SpellInfo[CurType])
		-- Wild Mushroom
		elseif CurType == "wm" then
			local WMCount = 0
			if PlayerClass == "DRUID" then
				if GetTotemTimeLeft(1) > 0 then WMCount = WMCount + 1 end
				if GetTotemTimeLeft(2) > 0 then WMCount = WMCount + 1 end
				if GetTotemTimeLeft(3) > 0 then WMCount = WMCount + 1 end
			end
			NewPoints = WMCount
		-- Astral Alignment
		elseif CurType == "al" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Dream of Cenarius (DPS)
		elseif CurType == "docd" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Dream of Cenarius (Heal)
		elseif CurType == "doch" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		end
	-- Hunter
	elseif CurClass == "HUNTER" then
		-- Ready, Set, Aim...
		if CurType == "rsa" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Frenzy Effect
		elseif CurType == "fe" then
			NewPoints = GetBuffCount(SpellInfo[CurType], "pet")
		end
	-- Mage
	elseif CurClass == "MAGE" then
		-- Arcane Blast
		if CurType == "ab" then
			NewPoints = GetDebuffCount(SpellInfo[CurType], "player")
		elseif CurType == "ff" then
			NewPoints = GetBuffCount(SpellInfo[CurType], "player")
		end
	-- Monk
	elseif CurClass == "MONK" then
		-- Chi
		if CurType == "chi" then
			NewPoints = UnitPower("player", SPELL_POWER_CHI)
		elseif CurType == "sz" then
			NewPoints = GetBuffCount(SpellInfo[CurType], "player")
		elseif CurType == "vm" then
			NewPoints = GetBuffCount(SpellInfo[CurType], "player")
		elseif CurType == "eb" then
			EBPoints = GetBuffCount(SpellInfo[CurType], "player")
			NewPoints = ceil(EBPoints / 3)
		end
	-- Priest
	elseif CurClass == "PALADIN" then
		-- Holy Power
		if CurType == "hp" then
			NewPoints = UnitPower("player", SPELL_POWER_HOLY_POWER)
		end
	-- Priest
	elseif CurClass == "PRIEST" then
		-- Evangelism
		if CurType == "eva" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Shadow Orb
		elseif CurType == "so" then
			NewPoints = UnitPower("player", SPELL_POWER_SHADOW_ORBS)
		-- Serendipity
		elseif CurType == "ser" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Mind Spike
		elseif CurType == "ms" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		end
	-- Rogue
	elseif CurClass == "ROGUE" then
		-- Deadly Poison
		if CurType == "ap" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		end
	-- Shaman
	elseif CurClass == "SHAMAN" then
		-- Maelstrom Weapon
		if CurType == "mw" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Lightning Shield (Fulmination)
		elseif CurType == "ls" then
			NewPoints = max(GetBuffCount(SpellInfo[CurType]) - 1, 0)
		-- Tidal Waves
		elseif CurType == "tw" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Water Shield
		elseif CurType == "ws" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		end
	-- Warlock
	elseif CurClass == "WARLOCK" then
		-- Soul Shards
		if CurType == "ss" and PlayerTalent == 1 then
			NewPoints = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
		-- Burning Embers
		elseif CurType == "be" and PlayerTalent == 3 then
			NewPoints = UnitPower("player", SPELL_POWER_BURNING_EMBERS)
		-- Molten Core
		elseif CurType == "mco" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		end
	-- Warrior
	elseif CurClass == "WARRIOR" then
		-- Thunderstruck
		if CurType == "ts" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Meat Cleaver
		elseif CurType == "mc" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		-- Sunder Armor
		elseif CurType == "sa" then
			NewPoints = GetDebuffCount(SpellInfo[CurType])
		-- Taste for Blood
		elseif CurType == "tb" then
			NewPoints = GetBuffCount(SpellInfo[CurType])
		end
	end
	Points[CurType] = NewPoints
end

-- Update all valid Point Displays
function PointDisplay:UpdatePoints(...)	
	local HasChanged = false
	local Enable = ...
	
	local UpdateList
	if ... == "ENABLE" then
		-- Update everything
		UpdateList = Types
	else
		UpdateList = ValidClasses
	end
	
	-- ENABLE update: Config Mode / Reset displays
	if Enable == "ENABLE" then
		HasChanged = true
		for ic,vc in pairs(Types) do
			for it,vt in ipairs(Types[ic].points) do
				local tid = Types[ic].points[it].id
				PointsChanged[tid] = true
				if ( db[ic].types[tid].enabled and db[ic].types[tid].configmode.enabled ) then
					-- If Enabled and Config Mode is on, then set points
					Points[tid] = db[ic].types[tid].configmode.count
				else
					Points[tid] = 0
				end
			end
		end
	end
	
	-- Normal update: Cycle through valid classes
	for ic,vc in pairs(UpdateList) do
		-- Cycle through point types for current class
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id
			if ( db[ic].types[tid].enabled and not db[ic].types[tid].configmode.enabled ) then
				-- Retrieve new point count
				local OldPoints = (tid == "eb") and EBPoints or Points[tid]
				PointDisplay:GetPoints(ic, tid)
				local NewPoints = (tid == "eb") and EBPoints or Points[tid]
				if NewPoints ~= OldPoints then
					-- Points have changed, flag for updating
					HasChanged = true
					PointsChanged[tid] = true
				end
			end
		end
	end
	
	-- Update Point Displays
	if HasChanged then PointDisplay:UpdatePointDisplay(Enable) end
end

-- Enable a Point Display
function PointDisplay:EnablePointDisplay(c, t)
	PointDisplay:UpdatePoints("ENABLE")
end

-- Disable a Point Display
function PointDisplay:DisablePointDisplay(c, t)
	-- Set to 0 points
	Points[t] = 0
	PointsChanged[t] = true
	
	-- Update Point Displays
	PointDisplay:UpdatePointDisplay("ENABLE")
end

-- Update frame positions/sizes
function PointDisplay:UpdatePosition()
	for ic,vc in pairs(Types) do
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id

			---- BG Panel
			local Parent = _G.RealUIPositionersCenterAuras
			
			Frames[ic][tid].bgpanel.frame:SetParent(Parent)
			Frames[ic][tid].bgpanel.frame:ClearAllPoints()
			Frames[ic][tid].bgpanel.frame:SetPoint(db[ic].types[tid].position.side, Parent, db[ic].types[tid].position.side, db[ic].types[tid].position.x, db[ic].types[tid].position.y)
			Frames[ic][tid].bgpanel.frame:SetFrameStrata(db[ic].types[tid].position.framelevel.strata)
			Frames[ic][tid].bgpanel.frame:SetFrameLevel(db[ic].types[tid].position.framelevel.level)
			Frames[ic][tid].bgpanel.frame:SetWidth(10)
			Frames[ic][tid].bgpanel.frame:SetHeight(10)
			
			---- Point Bars
			local IsRev = db[ic].types[tid].general.direction.reverse
			local XPos, YPos, CPRatio, TWidth, THeight
			local Positions = {}
			local CPSize = {}
			
			-- Get total Width and Height of Point Display, and the size of each Bar
			TWidth = 0
			THeight = 0
			for i = 1, Types[ic].points[it].barcount do
				CPSize[i] = db[ic].types[tid].bars.size.width + db[ic].types[tid].bars.position.gap
				TWidth = TWidth + db[ic].types[tid].bars.size.width + db[ic].types[tid].bars.position.gap
			end
			
			-- Calculate position of each Bar
			for i = 1, Types[ic].points[it].barcount do
				local CurPos = 0
				local TVal = TWidth
				
				-- Add up position of each Bar in sequence
				if i == 1 then
					CurPos = 0
				else
					for j = 1, i-1 do
						CurPos = CurPos + CPSize[j]
					end
				end					
				
				-- Found Position of Bar
				Positions[i] = CurPos
			end
			
			-- Position each Bar
			for i = 1, Types[ic].points[it].barcount do
				local RevMult = 1
				if IsRev then RevMult = -1 end			
				
				Frames[ic][tid].bars[i].frame:SetParent(Frames[ic][tid].bgpanel.frame)
				Frames[ic][tid].bars[i].frame:ClearAllPoints()
				
				XPos = Positions[i] * RevMult
				YPos = 0
				
				Frames[ic][tid].bars[i].frame:SetPoint(db[ic].types[tid].position.side, Frames[ic][tid].bgpanel.frame, db[ic].types[tid].position.side, XPos, YPos)
				
				Frames[ic][tid].bars[i].frame:SetFrameStrata(db[ic].types[tid].position.framelevel.strata)
				Frames[ic][tid].bars[i].frame:SetFrameLevel(db[ic].types[tid].position.framelevel.level + i + 2)
				Frames[ic][tid].bars[i].frame:SetWidth(db[ic].types[tid].bars.size.width)
				Frames[ic][tid].bars[i].frame:SetHeight(db[ic].types[tid].bars.size.height)
			end
			
			Frames[ic][tid].bgpanel.frame:SetWidth(Positions[Types[ic].points[it].barcount] + db[ic].types[tid].bars.size.width)
		end
	end
end

function PointDisplay:ToggleClassConfig(val)
	for ic,vc in pairs(ValidClasses) do
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id
			db[ic].types[tid].configmode.enabled = val
			if val then
				db[ic].types[tid].configmode.count = Types[ic].points[it].barcount
			else
				db[ic].types[tid].configmode.count = 2
			end
		end
	end
	self:UpdatePoints("ENABLE")
end
function PDTCC(val)
	PointDisplay:ToggleClassConfig(val)
end

-- Retrieve SharedMedia backgound
local function RetrieveBackground(background)
	background = LSM:Fetch("background", background, true)
	return background
end

local function VerifyBackground(background)
	local newbackground = ""
	if background and strlen(background) > 0 then 
		newbackground = RetrieveBackground(background)
		if background ~= "None" then
			if not newbackground then
				print("Background "..background.." was not found in SharedMedia.")
				newbackground = ""
			end
		end
	end	
	return newbackground
end

-- Retrieve Background textures and store in tables
function PointDisplay:GetTextures()
	for ic,vc in pairs(Types) do
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id
			BG[ic][tid].bars.empty = VerifyBackground(db[ic].types[tid].bars.bg.empty.texture)
			BG[ic][tid].bars.full = VerifyBackground(db[ic].types[tid].bars.bg.full.texture)
			BG[ic][tid].bars.surround = VerifyBackground(db[ic].types[tid].bars.surround.texture)
		end
	end
end

-- Frame Creation
local function CreateFrames(config)
	for ic,vc in pairs(Types) do
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id
			
			-- BG Panel
			local FrameName = "PointDisplay_Frames_"..tid
			Frames[ic][tid].bgpanel.frame = CreateFrame("Frame", FrameName, UIParent)
			
			Frames[ic][tid].bgpanel.bg = Frames[ic][tid].bgpanel.frame:CreateTexture(nil, "ARTWORK")
			Frames[ic][tid].bgpanel.bg:SetAllPoints(Frames[ic][tid].bgpanel.frame)
			
			Frames[ic][tid].bgpanel.frame:Hide()
			
			-- Point bars
			for i = 1, Types[ic].points[it].barcount do
				local BarFrameName = "PointDisplay_Frames_"..tid.."_bar"..tostring(i)
				Frames[ic][tid].bars[i].frame = CreateFrame("Frame", BarFrameName, UIParent)
				
				Frames[ic][tid].bars[i].bg = Frames[ic][tid].bars[i].frame:CreateTexture(nil, "ARTWORK")
				Frames[ic][tid].bars[i].bg:SetAllPoints(Frames[ic][tid].bars[i].frame)
				
				Frames[ic][tid].bars[i].surround = Frames[ic][tid].bars[i].frame:CreateTexture(nil, "ARTWORK")
				Frames[ic][tid].bars[i].surround:SetAllPoints(Frames[ic][tid].bars[i].frame)
				
				Frames[ic][tid].bars[i].frame:Show()
			end
		end
	end
end

-- Table creation
local function CreateTables(config)
	-- Frames
	wipe(Frames)
	wipe(BG)
	wipe(Points)
	wipe(PointsChanged)
	
	for ic,vc in pairs(Types) do
		-- Insert Class header
		tinsert(Frames, ic)
		Frames[ic] = {}
		tinsert(BG, ic)
		BG[ic] = {}
		
		for it,vt in ipairs(Types[ic].points) do	-- Iterate through Types table
			local tid = Types[ic].points[it].id
			
			-- Insert point type (ie "cp") into table and fill out table
			-- Frames
			tinsert(Frames[ic], tid)
			tinsert(BG[ic], tid)
			
			Frames[ic][tid] = {
				bgpanel = {frame = nil, bg = nil},
				bars = {},				
			}
			BG[ic][tid] = {
				bars = {},
			}
			for i = 1, Types[ic].points[it].barcount do
				Frames[ic][tid].bars[i] = {frame = nil, bg = nil, surround = nil}
				BG[ic][tid].bars[i] = {empty = "", full = "", surround = ""}
			end
			
			-- Points			
			Points[tid] = 0
			
			-- Set up Points Changed table
			PointsChanged[tid] = false
		end
	end
end

-- Refresh PointDisplay
function PointDisplay:Refresh()
	PointDisplay:UpdateSpec()
	PointDisplay:UpdateCombatFaderEnabled()
	PointDisplay:GetTextures()
	PointDisplay:UpdatePosition()
	PointDisplay:UpdatePoints("ENABLE")
end

-- Hide default UI frames
function PointDisplay:HideUIElements()
	if db["GENERAL"].types["cp"].enabled and db["GENERAL"].types["cp"].general.hideui then
		for i = 1,5 do
			_G["ComboPoint"..i]:Hide()
			_G["ComboPoint"..i]:SetScript("OnShow", function(self) self:Hide() end)
		end
	end
	
	if db["PALADIN"].types["hp"].enabled and db["PALADIN"].types["hp"].general.hideui then
		local HPF = _G["PaladinPowerBar"]
		if HPF then
			HPF:Hide()
			HPF:SetScript("OnShow", function(self) self:Hide() end)
		end
	end
	
	if db["WARLOCK"].types["ss"].enabled and db["WARLOCK"].types["ss"].general.hideui then
		local SSF = _G["ShardBarFrame"]
		if SSF then
			SSF:Hide()
			SSF:SetScript("OnShow", function(self) self:Hide() end)
		end
	end
end

function PointDisplay:UpdateSpec()
	PlayerSpec = GetActiveSpecGroup()
	PlayerTalent = GetSpecialization()
end

function PointDisplay:UpdateSmartHideConditions()
	if PlayerInCombat or PlayerTargetHostile or PlayerInInstance then
		SmartHideConditions = false
	else
		SmartHideConditions = true
	end
	PointDisplay:UpdatePoints("ENABLE")
end

function PointDisplay:PLAYER_TARGET_CHANGED()
	PlayerTargetHostile = (UnitIsEnemy("player", "target") or UnitCanAttack("player", "target"))
	PointDisplay:UpdateSmartHideConditions()
end

function PointDisplay:PLAYER_REGEN_DISABLED()
	PlayerInCombat = true
	PointDisplay:UpdateSmartHideConditions()
end

function PointDisplay:PLAYER_REGEN_ENABLED()
	PlayerInCombat = false
	PointDisplay:UpdateSmartHideConditions()
end

function PointDisplay:PLAYER_ENTERING_WORLD()
	PlayerInInstance = IsInInstance()
	PointDisplay:UpdateSpec()
	PointDisplay:UpdatePosition()
	PointDisplay:UpdateSmartHideConditions()
end

function PointDisplay:PLAYER_LOGIN()
	PlayerClass = nibRealUI.class
	
	-- Build Class list to run updates on
	ValidClasses = {
		["GENERAL"] = true,
		[PlayerClass] = true,
	},
	
	-- Register Media
	LSM:Register("background", "Round_Large_BG", [[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\Round_Large_BG]])
	LSM:Register("background", "Round_Large_Surround", [[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\Round_Large_Surround]])
	LSM:Register("background", "Round_Small_BG", [[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\Round_Small_BG]])
	LSM:Register("background", "Round_Small_Surround", [[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\Round_Small_Surround]])
	LSM:Register("background", "Round_Larger_BG", [[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\Round_Larger_BG]])
	LSM:Register("background", "Round_Larger_Surround", [[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\Round_Larger_Surround]])
	LSM:Register("background", "Soul_Shard_BG", [[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\SoulShard_BG]])
	LSM:Register("background", "Soul_Shard_Surround", [[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\SoulShard_Surround]])
	
	HolyPowerTexture = {[[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\HolyPower1]], [[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\HolyPower2]], [[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\HolyPower3]], [[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\HolyPower4]], [[Interface\Addons\nibRealUI\HuD\PointDisplay\Media\HolyPower5]]}
	
	-- Get Spell Info
	-- Death Knight
	SpellInfo["si"] = GetSpellInfo(91342)		-- Shadow Infusion
	SpellInfo["bs"] = GetSpellInfo(49222)		-- Bone Shield
	-- Druid
	SpellInfo["lus"] = GetSpellInfo(81192)		-- Lunar Shower
	SpellInfo["lac"] = GetSpellInfo(33745)		-- Lacerate
	SpellInfo["al"] = GetSpellInfo(90164)		-- Astral Alignment
	SpellInfo["docd"] = GetSpellInfo(108381)	-- Dream of Cenarius (DPS)
	SpellInfo["doch"] = GetSpellInfo(108382)	-- Dream of Cenarius (Heal)
	-- Hunter
	SpellInfo["rsa"] = GetSpellInfo(82925)		-- Ready, Set, Aim...
	SpellInfo["fe"] = GetSpellInfo(19615)		-- Frenzy Effect
	-- Mage
	SpellInfo["ab"] = GetSpellInfo(36032)		-- Arcane Blast
	SpellInfo["ff"] = GetSpellInfo(44544)		-- Fingers of Frost
	-- Monk
	SpellInfo["sz"] = GetSpellInfo(127722)		-- Serpents Zeal
	SpellInfo["vm"] = GetSpellInfo(118674)		-- Vital Mists
	SpellInfo["eb"] = GetSpellInfo(128939)		-- Elusive Brew
	-- Priest
	SpellInfo["eva"] = GetSpellInfo(81661)		-- Evangelism
	SpellInfo["so"] = GetSpellInfo(77487)		-- Shadow Orb
	SpellInfo["ser"] = GetSpellInfo(63735)		-- Serendipity
	SpellInfo["ms"] = GetSpellInfo(33371)		-- Mind Spike
	-- Rogue	
	SpellInfo["ap"] = GetSpellInfo(114015)		-- Deadly Poison
	-- Shaman
	SpellInfo["mw"] = GetSpellInfo(65986)		-- Maelstrom Weapon
	SpellInfo["ls"] = GetSpellInfo(324)			-- Lightning Shield
	SpellInfo["tw"] = GetSpellInfo(53390)		-- Tidal Waves
	SpellInfo["ws"] = GetSpellInfo(52128)		-- Water Shield
	-- Warlock
	SpellInfo["mco"] = GetSpellInfo(122351)		-- Molten Core
	-- Warrior
	SpellInfo["ts"] = GetSpellInfo(87096)		-- Thunderstruck
	SpellInfo["mc"] = GetSpellInfo(85739)		-- Meat Cleaver
	SpellInfo["sa"] = GetSpellInfo(58567)		-- Sunder Armor
	SpellInfo["tb"] = GetSpellInfo(56638)
		
	-- Hide Elements
	PointDisplay:HideUIElements()
	
	-- Register Events
	-- Throttled Events
	local EventList = {
		"UNIT_COMBO_POINTS",
		"VEHICLE_UPDATE",
		"UNIT_AURA",
	}		
	if ( PlayerClass == "DEATHKNIGHT" or PlayerClass == "HUNTER" ) then
		tinsert(EventList, "UNIT_PET")
	end
	if (PlayerClass == "DRUID") then
		tinsert(EventList, "PLAYER_TOTEM_UPDATE")
	end
	if (PlayerClass == "MONK") then
		tinsert(EventList, "UNIT_POWER")
	end
	if (PlayerClass == "PALADIN") then
		tinsert(EventList, "UNIT_POWER")
	end
	if (PlayerClass == "WARLOCK") then
		tinsert(EventList, "UNIT_POWER")
		tinsert(EventList, "UNIT_DISPLAYPOWER")
	end	
	local UpdateSpeed = (1 / db.updatespeed)
	self:RegisterBucketEvent(EventList, UpdateSpeed, "UpdatePoints")	
	
	-- Refresh Addon
	PointDisplay:Refresh()
end

function PointDisplay:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults(nibRealUI:GetPointDisplayDefaults())
	
	db = self.db.profile
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterHuDOptions(MODNAME, GetOptions)
end

function PointDisplay:OnEnable()
	CreateTables()
	CreateFrames()
	
	-- Turn off Config Mode
	for ic,vc in pairs(Types) do
		for it,vt in ipairs(Types[ic].points) do
			local tid = Types[ic].points[it].id
			db[ic].types[tid].configmode.enabled = false
		end
	end
	
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "UpdateSpec")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
end