local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

local MODNAME = "UnitFrames"
local UnitFrames = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")
local RC = LibStub("LibRangeCheck-2.0")
local db, ndbc

local oUF = oUFembed
oUFembed = nil

local _G = getfenv(0)
local min = math.min
local max = math.max
local floor = _G.floor
local ceil = _G.ceil
local format = _G.format
local strform = _G.string.format
local tonumber = _G.tonumber
local tostring = _G.tostring
local strlen = _G.strlen
local strsub = _G.strsub

---------------------
------ Options ------
---------------------
local ModKeys = {
	"shift",
	"ctrl",
	"alt"
}
local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Unit Frames",
		arg = MODNAME,
		order = 2114,
		args = {
			header = {
				type = "header",
				name = "Unit Frames",
				order = 10,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Unit Frames module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
					nibRealUI:ReloadUIDialog()
				end,
				order = 20,
			},
			desc3 = {
				type = "description",
				name = "Note: You will need to reload the UI (/rl) for changes to take effect.",
				order = 21,
			},
			gap1 = {
				name = " ",
				type = "description",
				order = 22,
			},
			misc = {
				type = "group",
				name = "General",
				disabled = function() return not(nibRealUI:GetModuleEnabled(MODNAME)) end,
				order = 40,
				args = {
					focusclick = {
						type = "toggle",
						name = "Click Set Focus",
						desc = "Set focus by click+modifier on the Unit Frames.",
						get = function() return db.misc.focusclick end,
						set = function(info, value) 
							db.misc.focusclick = value
						end,
						order = 10,
					},
					gap1 = {
						name = " ",
						type = "description",
						order = 11,
					},
					focuskey = {
						type = "select",
						name = "Modifier Key",
						set = function(info, value)
							db.misc.focuskey = ModKeys[value]
						end,
						style = "dropdown",
						width = nil,
						values = ModKeys,
						order = 20,
					},
					focuskeyname = {
						name = function()
							return db.misc.focuskey
						end,
						type = "description",
						order = 21,
					},
				},
			},
			positions = {
				type = "group",
				name = "Positions",
				disabled = function() return not(nibRealUI:GetModuleEnabled(MODNAME)) end,
				childGroups = "tab",
				order = 60,
				args = {},
			},
			overlay = {
				type = "group",
				name = "Overlay",
				disabled = function() return not(nibRealUI:GetModuleEnabled(MODNAME)) end,
				childGroups = "tab",
				order = 70,
				args = {
					bar = {
						type = "group",
						name = "Bars",
						order = 10,
						args = {
							colors = {
								type = "group",
								inline = true,
								name = "Color Type",
								order = 10,
								args = {
									byhostility = {
										type = "toggle",
										name = "Color by Hostility",
										desc = "Color Unit Frame bars based on the unit's hostility towards you.",
										get = function() return db.overlay.bar.colors.byhostility end,
										set = function(info, value) 
											db.overlay.bar.colors.byhostility = value
										end,
										order = 10,
									},
									byclass = {
										type = "toggle",
										name = "Color by Class",
										desc = "Color Unit Frame bars based on the unit's class.",
										get = function() return db.overlay.bar.colors.byclass end,
										set = function(info, value) 
											db.overlay.bar.colors.byclass = value
										end,
										order = 20,
									},
								},
							},
							opacity = {
								type = "group",
								inline = true,
								name = "Opacity",
								order = 20,
								args = {
									surround = {
										type = "range",
										name = "Surround",
										min = 0, max = 1, step = 0.05,
										isPercent = true,
										get = function(info) return db.overlay.bar.opacity.surround end,
										set = function(info, value) db.overlay.bar.opacity.surround = value end,
										order = 10,
									},
									background = {
										type = "range",
										name = "Background",
										min = 0, max = 1, step = 0.05,
										isPercent = true,
										get = function(info) return db.overlay.bar.opacity.background end,
										set = function(info, value) db.overlay.bar.opacity.background = value end,
										order = 20,
									},
									status = {
										type = "range",
										name = "Status",
										min = 0, max = 1, step = 0.05,
										isPercent = true,
										get = function(info) return db.overlay.bar.opacity.status end,
										set = function(info, value) db.overlay.bar.opacity.status = value end,
										order = 30,
									},
									steps = {
										type = "range",
										name = "Steps",
										min = 0, max = 1, step = 0.05,
										isPercent = true,
										get = function(info) return db.overlay.bar.opacity.steps end,
										set = function(info, value) db.overlay.bar.opacity.steps = value end,
										order = 40,
									},
									gap1 = {
										name = " ",
										type = "description",
										order = 41,
									},
									bar = {
										type = "group",
										inline = true,
										name = "Health/Power Bars",
										order = 50,
										args = {
											start = {
												type = "range",
												name = "Start",
												min = 0, max = 1, step = 0.05,
												isPercent = true,
												get = function(info) return db.overlay.bar.opacity.bar[1] end,
												set = function(info, value) db.overlay.bar.opacity.bar[1] = value end,
												order = 10,
											},
											finish = {
												type = "range",
												name = "End",
												min = 0, max = 1, step = 0.05,
												isPercent = true,
												get = function(info) return db.overlay.bar.opacity.bar[2] end,
												set = function(info, value) db.overlay.bar.opacity.bar[2] = value end,
												order = 20,
											},
										},
									},
									gap2 = {
										name = " ",
										type = "description",
										order = 51,
									},
									bar2 = {
										type = "group",
										inline = true,
										name = "Pet/Vehicle Bars",
										order = 60,
										args = {
											start = {
												type = "range",
												name = "Start",
												min = 0, max = 1, step = 0.05,
												isPercent = true,
												get = function(info) return db.overlay.bar.opacity.bar2[1] end,
												set = function(info, value) db.overlay.bar.opacity.bar2[1] = value end,
												order = 10,
											},
											finish = {
												type = "range",
												name = "End",
												min = 0, max = 1, step = 0.05,
												isPercent = true,
												get = function(info) return db.overlay.bar.opacity.bar2[2] end,
												set = function(info, value) db.overlay.bar.opacity.bar2[2] = value end,
												order = 20,
											},
										},
									},
								},
							},
						},
					},
					arrow = {
						type = "group",
						name = "Arrows",
						order = 20,
						args = {
							opacity = {
								type = "group",
								inline = true,
								name = "Opacity",
								order = 10,
								args = {
									surround = {
										type = "range",
										name = "Surround",
										min = 0, max = 1, step = 0.05,
										isPercent = true,
										get = function(info) return db.overlay.arrow.opacity.surround end,
										set = function(info, value) db.overlay.arrow.opacity.surround = value end,
										order = 10,
									},
									background = {
										type = "range",
										name = "Background",
										min = 0, max = 1, step = 0.05,
										isPercent = true,
										get = function(info) return db.overlay.arrow.opacity.background end,
										set = function(info, value) db.overlay.arrow.opacity.background = value end,
										order = 20,
									},
								},
							},
							colors = {
								type = "group",
								inline = true,
								name = "Colors",
								order = 10,
								args = {
									step1 = {
										type = "color",
										name = "Full",
										get = function(info,r,g,b,a)
											return db.overlay.arrow.colors[1][1], db.overlay.arrow.colors[1][2], db.overlay.arrow.colors[1][3]
										end,
										set = function(info,r,g,b,a)
											db.overlay.arrow.colors[1][1] = r
											db.overlay.arrow.colors[1][2] = g
											db.overlay.arrow.colors[1][3] = b
										end,
										order = 10,
									},
									step2 = {
										type = "color",
										name = "Warning",
										get = function(info,r,g,b,a)
											return db.overlay.arrow.colors[2][1], db.overlay.arrow.colors[2][2], db.overlay.arrow.colors[2][3]
										end,
										set = function(info,r,g,b,a)
											db.overlay.arrow.colors[2][1] = r
											db.overlay.arrow.colors[2][2] = g
											db.overlay.arrow.colors[2][3] = b
										end,
										order = 20,
									},
									step3 = {
										type = "color",
										name = "Red Alert",
										get = function(info,r,g,b,a)
											return db.overlay.arrow.colors[3][1], db.overlay.arrow.colors[3][2], db.overlay.arrow.colors[3][3]
										end,
										set = function(info,r,g,b,a)
											db.overlay.arrow.colors[3][1] = r
											db.overlay.arrow.colors[3][2] = g
											db.overlay.arrow.colors[3][3] = b
										end,
										order = 30,
									},
									step4 = {
										type = "color",
										name = "Danger",
										get = function(info,r,g,b,a)
											return db.overlay.arrow.colors[4][1], db.overlay.arrow.colors[4][2], db.overlay.arrow.colors[4][3]
										end,
										set = function(info,r,g,b,a)
											db.overlay.arrow.colors[4][1] = r
											db.overlay.arrow.colors[4][2] = g
											db.overlay.arrow.colors[4][3] = b
										end,
										order = 40,
									},
								},
							},
						},
					},
					colors = {
						type = "group",
						name = "Colors",
						order = 30,
						args = {},
					},
				},
			},
		},
	}
	end
	
	---------------
	-- Positions --
	---------------
	local PositionLayoutOpts, PositionOpts = {}, {}
	local Opts_PositionOrderCnt = 10
	for kl,vl in pairs(db.positions) do
		local layout = kl == 1 and "Low Res" or "High Res"
		wipe(PositionOpts)
		for ip,vp in pairs(db.positions[kl]) do
			PositionOpts[ip] = {
				type = "group",
				inline = true,
				name = ip,
				order = Opts_PositionOrderCnt,
				args = {
					x = {
						type = "input",
						name = "X",
						width = "half",
						order = 10,
						get = function(info) return tostring(db.positions[kl][ip].x) end,
						set = function(info, value)
							value = nibRealUI:ValidateOffset(value)
							db.positions[kl][ip].x = value
						end,
					},
					y = {
						type = "input",
						name = "Y",
						width = "half",
						order = 20,
						get = function(info) return tostring(db.positions[kl][ip].y) end,
						set = function(info, value)
							value = nibRealUI:ValidateOffset(value)
							db.positions[kl][ip].y = value
						end,
					},
				},
			};
			
			Opts_PositionOrderCnt = Opts_PositionOrderCnt + 10
		end
		
		PositionLayoutOpts["res"..kl] = {
			type = "group",
			name = layout,
			order = kl,
			args = {}
		}
		for key, val in pairs(PositionOpts) do
			PositionLayoutOpts["res"..kl].args[key] = (type(val) == "function") and val() or val
		end
	end
	for key, val in pairs(PositionLayoutOpts) do
		options.args.positions.args[key] = (type(val) == "function") and val() or val
	end
	
	------------
	-- Colors --
	------------
	local ColorGroupOpts, ColorOpts = {}, {}
	local Opts_ColorGroupOrderCnt, Opts_ColorsOrderCnt = 10, 10
	for kl,vl in pairs(db.overlay.colors) do
		wipe(ColorOpts)
		for ic,vc in pairs(db.overlay.colors[kl]) do
			ColorOpts[ic] = {
				type = "color",
				name = ic,
				get = function(info,r,g,b,a)
					return db.overlay.colors[kl][ic][1], db.overlay.colors[kl][ic][2], db.overlay.colors[kl][ic][3]
				end,
				set = function(info,r,g,b,a)
					db.overlay.colors[kl][ic][1] = r
					db.overlay.colors[kl][ic][2] = g
					db.overlay.colors[kl][ic][3] = b
				end,
				order = 10,
			};
			
			Opts_ColorsOrderCnt = Opts_ColorsOrderCnt + 10
		end
		
		ColorGroupOpts[kl] = {
			type = "group",
			inline = true,
			name = kl,
			order = Opts_ColorGroupOrderCnt,
			args = {}
		}
		for key, val in pairs(ColorOpts) do
			ColorGroupOpts[kl].args[key] = (type(val) == "function") and val() or val
		end
		Opts_ColorGroupOrderCnt = Opts_ColorGroupOrderCnt + 10
	end
	for key, val in pairs(ColorGroupOpts) do
		options.args.overlay.args.colors.args[key] = (type(val) == "function") and val() or val
	end

	return options
end

---------------------
------ Overlay ------
---------------------
local PLAYER_ID = "player"
local PET_ID = "pet"
local VEHICLE_ID = "vehicle"
local FOCUS_ID = "focus"
local FOCUSTARGET_ID = "focustarget"
local TARGET_ID = "target"
local TARGETTARGET_ID = "targettarget"
local MAINTANK_ID = "maintank"

local Textures = {
	[1] = {
		f1 = {
			health = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_Health_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_Health_Bar]],
				step = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_Health_Step]],
				arrow = {
					surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_Health_Arrow_Surround]],
					background = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_Health_Arrow_Background]],
				},
			},
			power = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_Power_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_Power_Bar]],
				step = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_Power_Step]],
				arrow = {
					surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_Power_Arrow_Surround]],
					background = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_Power_Arrow_Background]],
				},
			},
			endbox = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_EndBox_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_EndBox_Bar]],
			},
			statusbox = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_StatusBox_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_StatusBox_Bar]],
			},
		},
		f2 = {
			health = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F2_Health_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F2_Health_Bar]],
			},
			endbox = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F2_EndBox_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F2_EndBox_Bar]],
			},
			statusbox = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_StatusBox_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_StatusBox_Bar]],
			},
		},
		f3 = {
			health = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F3_Health_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F3_Health_Bar]],
			},
			endbox = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F2_EndBox_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F2_EndBox_Bar]],
			},
			statusbox = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_StatusBox_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\small\F1_StatusBox_Bar]],
			},
		},
	},
	[2] = {
		f1 = {
			health = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_Health_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_Health_Bar]],
				step = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_Health_Step]],
				arrow = {
					surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_Health_Arrow_Surround]],
					background = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_Health_Arrow_Background]],
				},
			},
			power = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_Power_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_Power_Bar]],
				step = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_Power_Step]],
				arrow = {
					surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_Power_Arrow_Surround]],
					background = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_Power_Arrow_Background]],
				},
			},
			endbox = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_EndBox_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_EndBox_Bar]],
			},
			statusbox = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_StatusBox_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_StatusBox_Bar]],
			},
		},
		f2 = {
			health = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F2_Health_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F2_Health_Bar]],
			},
			endbox = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F2_EndBox_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F2_EndBox_Bar]],
			},
			statusbox = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_StatusBox_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_StatusBox_Bar]],
			},
		},
		f3 = {
			health = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F3_Health_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F3_Health_Bar]],
			},
			endbox = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F2_EndBox_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F2_EndBox_Bar]],
			},
			statusbox = {
				surround = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_StatusBox_Surround]],
				bar = [[Interface\AddOns\nibRealUI\HuD\UnitFrames\media\large\F1_StatusBox_Bar]],
			},
		},
	},
}

local HealthEndBarCoords = {
	[1] = {
		[PLAYER_ID] = {35/256, 43/256, 0, 1},
		[TARGET_ID] = {43/256, 35/256, 0, 1},
		[FOCUS_ID] = {101/256, 107/256, 0, 1},
		[FOCUSTARGET_ID] = {111/256, 117/256, 0, 1},
		[TARGETTARGET_ID] = {107/256, 101/256, 0, 1},
	},
	[2] = {
		[PLAYER_ID] = {15/256, 24/256, 0, 1},
		[TARGET_ID] = {24/256, 15/256, 0, 1},
		[FOCUS_ID] = {81/256, 88/256, 0, 1},
		[FOCUSTARGET_ID] = {91/256, 98/256, 0, 1},
		[TARGETTARGET_ID] = {88/256, 81/256, 0, 1},
	},
}

local PowerEndBarCoords = {
	[1] = {
		[PLAYER_ID] = {55/256, 61/256, 0, 1},
		[TARGET_ID] = {61/256, 55/256, 0, 1},
	},
	[2] = {
		[PLAYER_ID] = {35/256, 42/256, 0, 1},
		[TARGET_ID] = {42/256, 35/256, 0, 1},
	},
}

local UF = {
	[PLAYER_ID] = nil,
	[PET_ID] = nil,
	[TARGET_ID] = nil,
	[FOCUS_ID] = nil,
	[FOCUSTARGET_ID] = nil,
	[TARGETTARGET_ID] = nil,
	[MAINTANK_ID] = nil,
}

local ParentFrames = {
	[PLAYER_ID] = "oUF_RealUIPlayer",
	[PET_ID] = "oUF_RealUIPet",
	[TARGET_ID] = "oUF_RealUITarget",
	[FOCUS_ID] = "oUF_RealUIFocus",
	[FOCUSTARGET_ID] = "oUF_RealUIFocusTarget",
	[TARGETTARGET_ID] = "oUF_RealUITargetTarget",
	[MAINTANK_ID] = "oUF_RealUIMaintank",
}

local HealthWidth = {
	[1] = {
		[PLAYER_ID] = 220,
		[PET_ID] = 220,
		[TARGET_ID] = 220,
		[FOCUS_ID] = 154,
		[FOCUSTARGET_ID] = 145,
		[TARGETTARGET_ID] = 154,
		[MAINTANK_ID] = 145,
	},
	[2] = {
		[PLAYER_ID] = 240,
		[PET_ID] = 240,
		[TARGET_ID] = 240,
		[FOCUS_ID] = 174,
		[FOCUSTARGET_ID] = 165,
		[TARGETTARGET_ID] = 174,
		[MAINTANK_ID] = 165,
	},
}
local HealthWidthShort = {
	[1] = {
		[PLAYER_ID] = 212,
		[PET_ID] = 220,
		[TARGET_ID] = 212,
		[FOCUS_ID] = 148,
		[FOCUSTARGET_ID] = 138,
		[TARGETTARGET_ID] = 148,
		[MAINTANK_ID] = 138,
	},
	[2] = {
		[PLAYER_ID] = 231,
		[PET_ID] = 240,
		[TARGET_ID] = 231,
		[FOCUS_ID] = 168,
		[FOCUSTARGET_ID] = 157,
		[TARGETTARGET_ID] = 168,
		[MAINTANK_ID] = 157,
	},
}

local PowerWidth = {
	[1] = {
		[PLAYER_ID] = 200,
		[PET_ID] = 200,
		[TARGET_ID] = 200,
	},
	[2] = {
		[PLAYER_ID] = 220,
		[PET_ID] = 220,
		[TARGET_ID] = 220,
	},
}
local PowerWidthShort = {
	[1] = {
		[PLAYER_ID] = 194,
		[PET_ID] = 200,
		[TARGET_ID] = 194,
	},
	[2] = {
		[PLAYER_ID] = 213,
		[PET_ID] = 220,
		[TARGET_ID] = 213,
	},
}

local HealthTextYOffset = {
	[1] = {
		[PLAYER_ID] = 13,
		[TARGET_ID] = 13,
	},
	[2] = {
		[PLAYER_ID] = 14,
		[TARGET_ID] = 14,
	},
}

local PowerTextYOffset = {
	[1] = {
		[PLAYER_ID] = -4,
		[TARGET_ID] = -8,
	},
	[2] = {
		[PLAYER_ID] = -6,
		[TARGET_ID] = -10,
	},
}

local EndBoxTextXOffset = {
	[1] = {
		[PLAYER_ID] = -2,
	},
	[2] = {
		[PLAYER_ID] = -1,
	},
}

local HealthArrowYOffset = {
	[1] = 12,
	[2] = 13,
}

local PowerArrowYOffset = {
	[1] = -35,
	[2] = -35,
}

local PowerArrowTextYOffset = {
	[1] = -1,
	[2] = -2,
}

local NameLengths = {
	[1] = {
		[TARGET_ID] = 20,
		[FOCUS_ID] = 12,
		[FOCUSTARGET_ID] = 12,
		[TARGETTARGET_ID] = 12,
		[MAINTANK_ID] = 12,
	},
	[2] = {
		[TARGET_ID] = 18,
		[FOCUS_ID] = 12,
		[FOCUSTARGET_ID] = 12,
		[TARGETTARGET_ID] = 12,
		[MAINTANK_ID] = 12,
	},
}

local ReversePowers = {
	["RAGE"] = true,
	["RUNIC_POWER"] = true,
	["POWER_TYPE_SUN_POWER"] = true,
}

local PlayerStepPoints
local PowerColors = {}

local ClassificationShort = {
	["worldboss"] = "?",
	["rareelite"] = "R",
	["elite"] = "E",
	["rare"] = "r",
	["normal"] = "",
	["trivial"] = "",
	["pvp"] = "P",
}

local RangeColors = {
	[5] = {1, 1, 1},
	[30] = {1, 1, 0.6},
	[35] = {1, 0.9, 0},
	[40] = {1, 0.6, 0},
	[100] = {1, 0, 0},
}

local UnitHealthVal = {
	[PLAYER_ID] = 0,
	[TARGET_ID] = 0,
	[VEHICLE_ID] = 0,
}

---- MISC FUNCTIONS ----
local function UnitIsNotPvPPlayer(Unit, UFUnit)
	if not UnitIsPVP(Unit) then
		if (Unit == PLAYER_ID) and (UFUnit == PLAYER_ID) then
			return true
		elseif (Unit == TARGET_ID) and UnitExists(TARGET_ID) then
			if UnitIsPlayer(TARGET_ID) then
				return true
			end
		end
	end
	return false
end

local function UnitIsPvPPlayer(Unit, UFUnit)
	if UnitIsPVP(Unit) then
		if (Unit == PLAYER_ID) and (UFUnit == PLAYER_ID) then
			return true
		elseif (Unit == TARGET_ID) and UnitExists(TARGET_ID) then
			if UnitIsPlayer(TARGET_ID) then
				return true
			end
		end
	end
	return false
end

-- Seconds to Time
local function ConvertSecondstoTime(value)
	local minues, seconds
	minutes = floor(value / 60)
	seconds = floor(value - (minutes * 60))
	if ( minutes > 0 ) then
		if ( seconds < 10 ) then seconds = strform("0%d", seconds) end
		return strform("%s:%s", minutes, seconds)
	else
		return strform("%ss", seconds)
	end
end

-- Safe Unit Vals
local function GetSafeVals(vCur, vMax)
	local percent
	if vCur > 0 and vMax == 0 then
		vMax = vCur
		percent = 1
	elseif vCur == 0 and vMax == 0 then
		percent = 1
	else
		percent = vCur / vMax
	end
	return vCur, vMax, percent
end

-- Readable Numbers
local function ReadableNumber(num, places)
    local ret
    local placeValue = ("%%.%df"):format(places or 0)
    if not num then
        return 0
    elseif num >= 10000000 then
        ret = tostring(floor(num / 1000000)) .. "m" -- million (no decimal)
	elseif num >= 1000000 then
        ret = placeValue:format(num / 1000000) .. "m" -- million
	elseif num >= 200000 then
        places = 0
		ret = tostring(floor(num / 1000)) .. "k" -- thousand (no decimal)
    elseif num >= 1000 then
        ret = placeValue:format(num / 1000) .. "k" -- thousand
    else
        ret = num -- hundreds
    end
    return ret
end

-- Class Color
local classColors
local function GetClassColor(class)
	if not RAID_CLASS_COLORS[class] then return {1, 1, 1} end
	classColors = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
	return {classColors.r, classColors.g , classColors.b}
end

-- Power Colors
local function GetPowerColors()
	for pToken, color in pairs(db.overlay.colors.power) do
		if color[1] then
			PowerColors[pToken] = color
		end
	end
	PowerColors["POWER_TYPE_PYRITE"] = { 0, 0.79215693473816, 1 }
	PowerColors["POWER_TYPE_STEAM"] = { 0.94901967048645, 0.94901967048645, 0.94901967048645 }
	PowerColors["POWER_TYPE_HEAT"] = { 1, 0.490019610742107, 0 }
	PowerColors["POWER_TYPE_BLOOD_POWER"] = { 0.73725494556129, 0, 1 }
	PowerColors["POWER_TYPE_OOZE"] = { 0.75686281919479, 1, 0 }
end

-- Frame Position
local function SetFramePosition(frame, strata, level, width, height, ...)
	frame:ClearAllPoints()
	frame:SetFrameStrata(strata)
	frame:SetFrameLevel(level)
	frame:SetWidth(width)
	frame:SetHeight(height)
	if ... then
		frame:SetPoint(unpack(...))
	end
end

-- Text Position
local function SetTextPosition(frame, p1, p2)
	local cPos = (p1 ~= "CENTER") and p1..p2 or p1
	frame.text:ClearAllPoints()
	frame.text:SetPoint(cPos, frame, cPos, 0.5, 0.5)
	frame.text:SetJustifyH(p2)
	frame.text:SetJustifyV(p1)
end

-- Vehicle swap
local function PlayerOrVehicleIDs(UnitID)
	if ((UnitID == PLAYER_ID) or (UnitID == VEHICLE_ID)) then
		if UF[PLAYER_ID].vehicle then
			return VEHICLE_ID, PLAYER_ID
		else
			return PLAYER_ID, PLAYER_ID
		end
	elseif (UnitID == PET_ID) then
		return PET_ID, PLAYER_ID
	else
		return UnitID, UnitID
	end
end
local function SetPlayerVehicleFlag()
	UF[PLAYER_ID].vehicle = (UnitHasVehicleUI(PLAYER_ID) and UnitExists(VEHICLE_ID))
end

---- UNIT FRAME UPDATES ----
-- Smooth
local smoothing = {}
local function SetBarPosition(bar, pos)
	bar:SetWidth(pos)
	bar.pos = pos
	
	if pos > 1 then
		if not bar.ender.visible then
			bar.ender.visible = true
			bar.ender:Show()
		end
		
		if not bar.reverse then
			bar.alpha = db.overlay.bar.opacity.bar[1] + (db.overlay.bar.opacity.bar[2] - db.overlay.bar.opacity.bar[1]) * (pos / bar.maxwidth)
		else
			bar.alpha = db.overlay.bar.opacity.bar[1] + (db.overlay.bar.opacity.bar[2] - db.overlay.bar.opacity.bar[1]) * (1 - (pos / bar.maxwidth))
		end
		
		bar.bg:SetAlpha(bar.alpha)
		bar.ender.bg:SetAlpha(bar.alpha)
	else
		bar.bg:SetAlpha(0)
		if bar.ender.visible then
			bar.ender.visible = false
			bar.ender:Hide()
		end
	end
end

local function SetBarValue(bar, pos)
	pos = pos + 1
	if pos ~= bar.pos then
		smoothing[bar] = pos
	else
		SetBarPosition(bar, pos)
		smoothing[bar] = nil
	end
end

local smoothUpdateFrame = CreateFrame('Frame')
smoothUpdateFrame:SetScript('OnUpdate', function()
	local limit = 30 / GetFramerate()
	for bar, pos in pairs(smoothing) do
		local cur = bar.pos
		local new = cur + min((pos-cur)/3, max(pos-cur, limit))
		if new ~= new then
			new = pos
		end
		SetBarPosition(bar, new)
		if cur == pos or abs(new - pos) < 2 then
			SetBarPosition(bar, pos)
			smoothing[bar] = nil
		end
	end
end)


-- Range Display
function UnitFrames:UpdateUnitRange(UnitID)
	if not(UnitExists(UnitID)) then return end
	
	-- Get range
	local section
	local minRange, maxRange = RC:GetRange(UnitID)
	
	-- Pet/Player swap
	if (UnitID == PET_ID) or (UnitID == VEHICLE_ID) then UnitID = PLAYER_ID end
	
	-- No change? Skip
	if ((minRange == UF[UnitID].rangedisplay.lastmin) and (maxRange == UF[UnitID].rangedisplay.lastmin)) then return end
	
	-- Get Range section
	if UnitIsUnit(PLAYER_ID, UnitID) then maxRange = nil end
	if minRange > 80 then maxRange = nil end
	if maxRange then
		if maxRange <= 5 then
			section = 5
		elseif maxRange <= 30 then
			section = 30
		elseif maxRange <= 35 then
			section = 35
		elseif maxRange <= 40 then
			section = 40
		else
			section = 100
		end
		UF[UnitID].rangedisplay.text:SetFormattedText("%d", maxRange)
		UF[UnitID].rangedisplay.text:SetTextColor(RangeColors[section][1], RangeColors[section][2], RangeColors[section][3])
	else
		UF[UnitID].rangedisplay.text:SetText("")
	end
end

function UnitFrames:RangeDisplay_OnUpdate(self, elapsed, UnitID)
	self.elapsed = self.elapsed + elapsed
	if self.elapsed >= self.interval then
		UnitFrames:UpdateUnitRange(UnitID)
		self.elapsed = 0
	end
end

-- Text Positions
function UnitFrames:UpdateUnitTextPosition(UnitID, Text, Side)
	-- Player
	if UnitID == PLAYER_ID then
		if Text == "health.fullval" then
			if Side == "OUTSIDE" then
				SetFramePosition(UF[UnitID].health.fullval, "MEDIUM", UF[UnitID].health:GetFrameLevel(), 12, 12, {"BOTTOMLEFT", UF[UnitID].health, "BOTTOMLEFT", 256 - HealthWidthShort[ndbc.resolution][PLAYER_ID], HealthTextYOffset[ndbc.resolution][PLAYER_ID]})
				SetTextPosition(UF[UnitID].health.fullval, "BOTTOM", "LEFT")
			else
				SetFramePosition(UF[UnitID].health.fullval, "MEDIUM", UF[UnitID].health:GetFrameLevel(), 12, 12, {"BOTTOMRIGHT", UF[UnitID].health, "BOTTOMRIGHT", 1, HealthTextYOffset[ndbc.resolution][PLAYER_ID]})
				SetTextPosition(UF[UnitID].health.fullval, "BOTTOM", "RIGHT")
			end
		elseif Text == "power.fullval" then
			if Side == "OUTSIDE" then
				SetFramePosition(UF[UnitID].power.fullval, "MEDIUM", UF[UnitID].power:GetFrameLevel(), 12, 12, {"BOTTOMLEFT", UF[UnitID].power, "BOTTOMLEFT", 256 - PowerWidthShort[ndbc.resolution][PLAYER_ID], PowerTextYOffset[ndbc.resolution][PLAYER_ID]})
				SetTextPosition(UF[UnitID].power.fullval, "BOTTOM", "LEFT")
			else
				SetFramePosition(UF[UnitID].power.fullval, "MEDIUM", UF[UnitID].power:GetFrameLevel(), 12, 12, {"BOTTOMRIGHT", UF[UnitID].power, "BOTTOMRIGHT", 1, PowerTextYOffset[ndbc.resolution][PLAYER_ID]})
				SetTextPosition(UF[UnitID].power.fullval, "BOTTOM", "RIGHT")
			end
		end
	-- Target
	elseif UnitID == TARGET_ID then
		if Text == "health.fullval" then
			if Side == "OUTSIDE" then
				SetFramePosition(UF[UnitID].health.fullval, "MEDIUM", UF[UnitID].health:GetFrameLevel(), 12, 12, {"BOTTOMRIGHT", UF[UnitID].health, "BOTTOMRIGHT", -(256 - HealthWidthShort[ndbc.resolution][TARGET_ID]) + 2, HealthTextYOffset[ndbc.resolution][TARGET_ID]})
				SetTextPosition(UF[UnitID].health.fullval, "BOTTOM", "RIGHT")
			else
				SetFramePosition(UF[UnitID].health.fullval, "MEDIUM", UF[UnitID].health:GetFrameLevel(), 12, 12, {"BOTTOMLEFT", UF[UnitID].health, "BOTTOMLEFT", 1, HealthTextYOffset[ndbc.resolution][TARGET_ID]})
				SetTextPosition(UF[UnitID].health.fullval, "BOTTOM", "LEFT")
			end
		elseif Text == "power.fullval" then
			if Side == "OUTSIDE" then
				SetFramePosition(UF[UnitID].power.fullval, "MEDIUM", UF[UnitID].power:GetFrameLevel(), 12, 12, {"TOPRIGHT", UF[UnitID].power, "TOPRIGHT", -(256 - PowerWidthShort[ndbc.resolution][TARGET_ID] - 2), PowerTextYOffset[ndbc.resolution][TARGET_ID]})
				SetTextPosition(UF[UnitID].power.fullval, "BOTTOM", "RIGHT")
			else
				SetFramePosition(UF[UnitID].power.fullval, "MEDIUM", UF[UnitID].power:GetFrameLevel(), 12, 12, {"TOPLEFT", UF[UnitID].power, "TOPLEFT", 1, PowerTextYOffset[ndbc.resolution][TARGET_ID]})
				SetTextPosition(UF[UnitID].power.fullval, "BOTTOM", "LEFT")
			end
		end
	end
end

-- Unit Health
local ValidHealthUnit = {
	[PLAYER_ID] = true,
	[TARGET_ID] = true,
	[PET_ID] = true,
	[VEHICLE_ID] = true,
	[FOCUS_ID] = true,
	[FOCUSTARGET_ID] = true,
	[TARGETTARGET_ID] = true,
}
function UnitFrames:UpdateUnitHealth(UnitID, ...)
	local Unit, UFUnit = PlayerOrVehicleIDs(UnitID)
	
	-- Skip
	if not UF[UFUnit] then return end
	if not(ValidHealthUnit[Unit]) then return end
	if (UF[PLAYER_ID].vehicle and (Unit == PET_ID)) then return end
	if not UnitExists(Unit) then return end
	
	-- Vals
	local uHealth, uHealthMax, PerHP = GetSafeVals(UnitHealth(Unit), UnitHealthMax(Unit))
	if UnitHealthVal[Unit] then UnitHealthVal[Unit] = uHealth end
	
	-- Pet / Vehicle
	local xPos
	if ((Unit == PET_ID) and UF[PLAYER_ID].haspet) or ((Unit == VEHICLE_ID) and UF[PLAYER_ID].vehicle) then
		local PetPerHP = PerHP
		if (Unit ~= PET_ID) then
			PetPerHP = select(3, GetSafeVals(UnitHealth(UFUnit), UnitHealthMax(UFUnit)))
		end
		xPos = floor(HealthWidth[ndbc.resolution][PLAYER_ID] * (1 - (PetPerHP)))
		if (xPos == 0) then
			UF[PLAYER_ID].health2:Hide()
		else
			UF[PLAYER_ID].health2:Show()
			UF[PLAYER_ID].health2:SetWidth(xPos)
			UF[PLAYER_ID].health2.alpha = db.overlay.bar.opacity.bar2[1] + (db.overlay.bar.opacity.bar2[2] - db.overlay.bar.opacity.bar2[1]) * (1 - PetPerHP)
			UF[PLAYER_ID].health2:SetAlpha(UF[PLAYER_ID].health2.alpha)
		end
		if (Unit == PET_ID) then return end
	end
	
	-- Health hasn't changed? Skip
	if UF[UFUnit].health.position == PerHP and not(...) then return end
	UF[UFUnit].health.position = PerHP
	
	local xPosShort = floor(HealthWidthShort[ndbc.resolution][UFUnit] * (1 - PerHP))
	
	local FullValText
	if ((Unit == PLAYER_ID) or (Unit == VEHICLE_ID) or (Unit == TARGET_ID)) then
		-- Step
		local CurStep, NewStep, StepChanged = 0, 0, false
		local HealthStepPoints = db.misc.steppoints[nibRealUI.class] or {0.35, 0.25}
		CurStep = (PerHP < (HealthStepPoints[2] + 0.01)) and 2 or (PerHP < (HealthStepPoints[1] + 0.01)) and 1 or 0
		NewStep = CurStep
		if UF[UFUnit].health.arrow.step ~= CurStep then
			StepChanged = true
		end
		
		---- Arrow
		-- Change Health Arrow color
		if StepChanged then
			UF[UFUnit].health.arrow.background.bg:SetVertexColor(db.overlay.arrow.colors[NewStep+1][1], db.overlay.arrow.colors[NewStep+1][2], db.overlay.arrow.colors[NewStep+1][3], db.overlay.arrow.opacity.background)
			UF[UFUnit].health.arrow.percent.text:SetTextColor(db.overlay.arrow.colors[NewStep+1][1], db.overlay.arrow.colors[NewStep+1][2], db.overlay.arrow.colors[NewStep+1][3], db.overlay.arrow.opacity.surround)
			UF[UFUnit].health.arrow.step = NewStep
		end
		
		---- Texts
		local ArrowText = ""
		ArrowText = tostring(floor(PerHP * 100)).."%"
		if StepChanged then
			if CurStep == 0 then
				UnitFrames:UpdateUnitTextPosition(UFUnit, "health.fullval", "OUTSIDE")
			else
				UnitFrames:UpdateUnitTextPosition(UFUnit, "health.fullval", "INSIDE")
			end
		end
		UF[UFUnit].health.arrow.percent.text:SetText(ArrowText)
		
		FullValText = ReadableNumber(uHealth, 1)
	else
		FullValText = tostring(floor(PerHP * 100)).."%"
	end
	
	-- Health Text
	UF[UFUnit].health.fullval.text:SetText(FullValText)
	
	-- Set Bar
	SetBarValue(UF[UFUnit].health.bar, xPosShort)
end

function UnitFrames:Health_OnUpdate(self, elapsed, UnitID)
	self.elapsed = self.elapsed + elapsed
	if self.elapsed >= self.interval then
		UnitFrames:UpdateUnitHealth(UnitID)
		self.elapsed = 0
	end
end

-- Unit Power
local ValidPowerUnit = {
	[PLAYER_ID] = true,
	[TARGET_ID] = true,
	[PET_ID] = true,
	[VEHICLE_ID] = true,
}
function UnitFrames:UpdateUnitPower(UnitID, ...)
	local Unit, UFUnit = PlayerOrVehicleIDs(UnitID)
	
	-- Skip
	if not UF[UFUnit] then return end
	if not UF[UFUnit].power then return end
	if not(ValidPowerUnit[Unit]) then return end
	if (UF[PLAYER_ID].vehicle and (Unit == PET_ID)) then return end
	if not UnitExists(Unit) then return end
	
	local uPower, uPowerMax, PerMP = GetSafeVals(UnitPower(Unit), UnitPowerMax(Unit))
	local xPos, xPosShort
	
	-- Pet / Vehicle
	if ((Unit == PET_ID) and UF[PLAYER_ID].haspet) or ((Unit == VEHICLE_ID) and UF[PLAYER_ID].vehicle) then
		local PetPerMP = PerMP
		if (Unit ~= PET_ID) then
			PetPerMP = select(3, GetSafeVals(UnitPower(UFUnit), UnitPowerMax(UFUnit)))
		end
		xPos = floor(PowerWidth[ndbc.resolution][PLAYER_ID] * (1 - (PetPerMP)))
		if (xPos == 0) then
			UF[PLAYER_ID].power2:Hide()
		else
			UF[PLAYER_ID].power2:Show()
			UF[PLAYER_ID].power2:SetWidth(xPos)
			UF[PLAYER_ID].power2.alpha = db.overlay.bar.opacity.bar2[1] + (db.overlay.bar.opacity.bar2[2] - db.overlay.bar.opacity.bar2[1]) * (1 - PetPerMP)
			UF[PLAYER_ID].power2:SetAlpha(UF[PLAYER_ID].power2.alpha)
		end
		if (Unit == PET_ID) then return end
	end
	
	-- Power Disabled? Leave now
	if not(UF[UFUnit].power.enabled) then return end
	
	-- xPos
	if (UF[UFUnit].power.reverse) then
		xPos = floor(PowerWidth[ndbc.resolution][UFUnit] * PerMP)
		xPosShort = floor(PowerWidthShort[ndbc.resolution][UFUnit] * PerMP)
	else
		xPos = floor(PowerWidth[ndbc.resolution][UFUnit] * (1 - PerMP))
		xPosShort = floor(PowerWidthShort[ndbc.resolution][UFUnit] * (1 - PerMP))
	end
	
	-- Power hasn't changed? Skip
	if UF[UFUnit].power.position == PerMP and not(...) then return end
	UF[UFUnit].power.position = PerMP
	
	-- Power Info
	local pType, pToken, altR, altG, altB = UnitPowerType(Unit)
	
	-- Druid Mana
	if UF[UFUnit].power.druidmana or UF[UFUnit].power.monkmana then
		local xDMPos = floor(PowerWidth[ndbc.resolution][UFUnit] * (1 - (UnitPower(Unit, 0) / UnitPowerMax(Unit, 0))))
		if xDMPos == 0 then
			UF[UFUnit].power2:Hide()
		else
			UF[UFUnit].power2:Show()
			UF[UFUnit].power2:SetWidth(xDMPos)
		end
	end
	
	-- Step
	local CurStep, NewStep, StepChanged = 0, 0, false
	CurStep = 	((PerMP < (UF[UFUnit].power.steppoints[3] + 0.01)) and UF[UFUnit].power.sinrogue) and 3 or 
				(PerMP < (UF[UFUnit].power.steppoints[2] + 0.01)) and 2 or 
				(PerMP < (UF[UFUnit].power.steppoints[1] + 0.01)) and 1 or 0
	if UF[UFUnit].power.hassteps then
		if UF[UFUnit].power.sinrogue then
			if CurStep == 2 then
				NewStep = 3
			elseif CurStep == 3 then
				NewStep = 2
			else
				NewStep = CurStep
			end
		else
			NewStep = CurStep
		end
	end
	if UF[UFUnit].power.arrow.step ~= NewStep then
		StepChanged = true
	end
	
	---- Arrow
	-- Change Power Arrow color
	if StepChanged then
		UF[UFUnit].power.arrow.background.bg:SetVertexColor(db.overlay.arrow.colors[NewStep+1][1], db.overlay.arrow.colors[NewStep+1][2], db.overlay.arrow.colors[NewStep+1][3], db.overlay.arrow.opacity.background)
		UF[UFUnit].power.arrow.percent.text:SetTextColor(db.overlay.arrow.colors[NewStep+1][1], db.overlay.arrow.colors[NewStep+1][2], db.overlay.arrow.colors[NewStep+1][3], db.overlay.arrow.opacity.surround)
		UF[UFUnit].power.arrow.step = NewStep
	end
	
	---- Texts
	local ArrowText, FullValText = "", ""
	if pToken == "MANA" then
		ArrowText = tostring(floor(PerMP * 100)).."%"
		FullValText = ReadableNumber(uPower, 1)
	else
		ArrowText = tostring(uPower)
		FullValText = ""
	end
	if StepChanged then
		if CurStep == 0 then
			UnitFrames:UpdateUnitTextPosition(UFUnit, "power.fullval", "OUTSIDE")
		else
			UnitFrames:UpdateUnitTextPosition(UFUnit, "power.fullval", "INSIDE")
		end
	end
	UF[UFUnit].power.arrow.percent.text:SetText(ArrowText)
	UF[UFUnit].power.fullval.text:SetText(FullValText)
	
	-- Set Bar
	SetBarValue(UF[UFUnit].power.bar, xPosShort)
end

function UnitFrames:Power_OnUpdate(self, elapsed, UnitID)
	self.elapsed = self.elapsed + elapsed
	if self.elapsed >= self.interval then
		UnitFrames:UpdateUnitPower(UnitID)
		self.elapsed = 0
	end
end

-- Unit Health Bar
function UnitFrames:UpdateUnitHealthBarInfo(UnitID, ...)
	if (UnitID == PET_ID) then return end
	local Unit, UFUnit = PlayerOrVehicleIDs(UnitID)
	if not UF[UFUnit] then return end
	if not(ValidHealthUnit[Unit]) then return end
	if not(UnitExists(Unit)) then return end
	
	-- Find Color type
	local ColorType = "normal"
	if (Unit ~= PLAYER_ID) then
		if UnitIsDeadOrGhost(Unit) then
			ColorType = "dead"
		elseif (db.overlay.bar.colors.byclass and UnitIsPlayer(Unit)) then
			ColorType = "class"
		elseif db.overlay.bar.colors.byhostility then
			ColorType = "hostility"
		else
			ColorType = "normal"
		end
	else
		-- Player
		if UnitIsDeadOrGhost(Unit) then
			ColorType = "dead"
		else
			ColorType = "normal"
		end
	end
	
	-- Get new colors
	local hColor = {}
	local newColorID = ""
	if ColorType == "normal" then
		hColor = db.overlay.colors.health.normal
		newColorID = "normal"
	elseif ColorType == "dead" then
		hColor = db.overlay.colors.status.dead
		newColorID = "dead"
	elseif ColorType == "class" then
		local _, uClass = UnitClass(Unit)
		hColor = GetClassColor(uClass)
		newColorID = uClass
	elseif ColorType == "hostility" then
		if UnitIsEnemy("player", Unit) then
			hColor = db.overlay.colors.health.hostile
			newColorID = "hostile"
		elseif UnitCanAttack("player", Unit) then
			hColor = db.overlay.colors.health.neutral
			newColorID = "neutral"
		else
			hColor = db.overlay.colors.health.friendly
			newColorID = "friendly"
		end
	end
	
	-- Apply colors
	if UF[UFUnit].health.colorID ~= newColorID then
		UF[UFUnit].health.colorID = newColorID
		UF[UFUnit].health.bar.bg:SetVertexColor(hColor[1], hColor[2], hColor[3], UF[UFUnit].health.alpha)
		UF[UFUnit].health.bar.ender.bg:SetVertexColor(hColor[1], hColor[2], hColor[3], UF[UFUnit].health.alpha)
		UF[UFUnit].health.fullval.text:SetTextColor(1, 1, 1, db.overlay.bar.opacity.surround)
	end
	
	if not ... then
		-- Steps
		if ((UFUnit == PLAYER_ID) or (UFUnit == TARGET_ID)) then
			if UFUnit == PLAYER_ID then
				for i = 1, 2 do
					SetFramePosition(UF[PLAYER_ID].health.steps[i], "MEDIUM", UF[PLAYER_ID].health.surround:GetFrameLevel() + 2, 16, 16, {"BOTTOMRIGHT", UF[PLAYER_ID].health.surround, "BOTTOMRIGHT", floor(-(HealthWidthShort[ndbc.resolution][PLAYER_ID] - (HealthWidthShort[ndbc.resolution][PLAYER_ID] * PlayerStepPoints[i]))), 0})
					UF[PLAYER_ID].health.steps[i]:Show()
				end
			else
				for i = 1, 2 do
					SetFramePosition(UF[TARGET_ID].health.steps[i], "MEDIUM", UF[TARGET_ID].health.surround:GetFrameLevel() + 2, 16, 16, {"BOTTOMLEFT", UF[TARGET_ID].health.surround, "BOTTOMLEFT", floor(HealthWidthShort[ndbc.resolution][TARGET_ID] - (HealthWidthShort[ndbc.resolution][TARGET_ID] * PlayerStepPoints[i])), 0})
					UF[TARGET_ID].health.steps[i]:Show()
				end
			end
		end
	end
	
	--UnitFrames:UpdateUnitHealth(UFUnit)
end

-- Unit Power Bar Color
function UnitFrames:UpdateUnitPowerBarInfo(UnitID)
	if not((UnitID == PLAYER_ID) or (UnitID == TARGET_ID) or (UnitID == VEHICLE_ID)) then return end
	
	local Unit, UFUnit = PlayerOrVehicleIDs(UnitID)
	if not UF[UFUnit] then return end
	if not UF[UFUnit].power.enabled then return end
	if not(ValidPowerUnit[Unit]) then return end
	if not(UnitExists(Unit)) then return end
	
	-- Power info
	local pType, pToken, altR, altG, altB = UnitPowerType(Unit)
	local pMax = UnitPowerMax(Unit)
	if UFUnit == PLAYER_ID then
		UF[UFUnit].power.interval = db.misc.powerupdatespeed[pToken] or db.misc.powerupdatespeed["default"]
	end
	
	-- Set defaults
	UF[UFUnit].power.position = -1
	UF[UFUnit].power.arrow.step = -1
	
	-- Get Color
	local NewColor = ""
	local pColor
	if UnitIsDeadOrGhost(Unit) then
		pColor = db.overlay.colors.status.dead
		NewColor = "DEAD"	
	else
		if PowerColors[pToken] then
			pColor = PowerColors[pToken]
			NewColor = pToken
		else
			if not(altR) then
				pColor = PowerColors["MANA"]
				NewColor = "MANA"
			else
				pColor = {altR, altG, altB}
				NewColor = "ALT"
			end
		end
	end
	
	-- Reverse
	if ReversePowers[pToken] then
		UF[UFUnit].power.reverse = true
	else
		UF[UFUnit].power.reverse = false
	end
	
	-- Druid Mana
	UF[UFUnit].power.druidmana = false
	if ((Unit == PLAYER_ID) and (nibRealUI.class == "DRUID" or "MONK") and not(UF[PLAYER_ID].haspet)) then
		if ((pToken ~= "MANA") and (UnitPowerMax(Unit, 0) > 0)) then
			UF[UFUnit].power.druidmana = true
			UF[UFUnit].power.monkmana = true
		else
			UF[UFUnit].power2:Hide()
		end
	end
	
	-- Apply colors
	if (UF[UFUnit].power.color ~= NewColor) then
		UF[UFUnit].power.color = NewColor
		UF[UFUnit].power.bar.bg:SetVertexColor(pColor[1], pColor[2], pColor[3], UF[UFUnit].power.alpha)
		UF[UFUnit].power.bar.ender.bg:SetVertexColor(pColor[1], pColor[2], pColor[3], UF[UFUnit].power.alpha)
		UF[UFUnit].power.fullval.text:SetTextColor(1, 1, 1, db.overlay.bar.opacity.surround)
	end
	
	---- Steps
	-- Calc step points
	UF[UFUnit].power.steppoints = {}
	UF[UFUnit].power.steppoints[1] = PlayerStepPoints[1]
	UF[UFUnit].power.steppoints[2] = PlayerStepPoints[2]
	UF[UFUnit].power.steppoints[3] = 0
	UF[UFUnit].power.hassteps = false
	UF[UFUnit].power.sinrogue = ((nibRealUI.class == "ROGUE") and (GetSpecialization() == 1) and (UFUnit == PLAYER_ID))
	if ((pToken == "MANA") or ((pToken ~= "MANA") and (pMax == 100))) then
		UF[UFUnit].power.hassteps = true
	elseif UnitPowerMax(Unit) > 80 then
		local s = 1
		if UF[UFUnit].power.sinrogue then
			UF[UFUnit].power.steppoints[1] = 0.55 * (100 / pMax)
			s = 2
		else
			UF[UFUnit].power.steppoints[3] = 0
		end
		UF[UFUnit].power.steppoints[s] = PlayerStepPoints[1] * (100 / pMax)
		UF[UFUnit].power.steppoints[s + 1] = PlayerStepPoints[2] * (100 / pMax)
		UF[UFUnit].power.hassteps = true
	end
	-- Position steps
	local stepXMod = (UFUnit == PLAYER_ID) and -1 or 1
	local stepAnchor = (UFUnit == PLAYER_ID) and "BOTTOMRIGHT" or "BOTTOMLEFT"
	for i = 1, 3 do
		local xStepPos
		if UF[UFUnit].power.reverse then
			xStepPos = floor(stepXMod * (PowerWidthShort[ndbc.resolution][UFUnit] - (PowerWidthShort[ndbc.resolution][UFUnit] * (1 - UF[UFUnit].power.steppoints[i]))))
		else
			xStepPos = floor(stepXMod * (PowerWidthShort[ndbc.resolution][UFUnit] - (PowerWidthShort[ndbc.resolution][UFUnit] * UF[UFUnit].power.steppoints[i])))
		end
		SetFramePosition(UF[UFUnit].power.steps[i], "MEDIUM", UF[UFUnit].power.surround:GetFrameLevel() + 2, 16, 16, {stepAnchor, UF[UFUnit].power.surround, stepAnchor, xStepPos, 0})
		if UF[UFUnit].power.hassteps and (UF[UFUnit].power.steppoints[i] > 0) then
			UF[UFUnit].power.steps[i]:Show()
		else
			UF[UFUnit].power.steps[i]:Hide()
		end
	end
	
	UnitFrames:UpdateUnitPower(UFUnit)
end

-- Toggle Power
function UnitFrames:ToggleUnitPower(UnitID)
	local Unit, UFUnit = PlayerOrVehicleIDs(UnitID)
	if not UF[UFUnit] then return end
	if not UF[UFUnit].power then return end
	
	if UnitExists(Unit) and UnitPowerMax(Unit) > 0 then
		if not UF[UFUnit].power.enabled then
			UF[UFUnit].power.enabled = true
			UF[UFUnit].power.bar:Show()
			UF[UFUnit].power.fullval:Show()
		end
	else
		UF[UFUnit].power.enabled = false
		UF[UFUnit].power.bar.ender.visible = false
		UF[UFUnit].power.bar:Hide()
		UF[UFUnit].power.bar.ender:Hide()
		for i = 1, 2 do
			UF[UFUnit].power.steps[i]:Hide()
		end
		UF[UFUnit].power.fullval:Hide()
	end
end

-- Unit Info
function UnitFrames:UpdateUnitInfo(UnitID)
	if ((UnitID == PLAYER_ID) or (UnitID == PET_ID)) then return end
	if not(UF[UnitID]) then return end
	if not(UnitExists(UnitID)) then return end
	
	-- Name
	local oldName = UnitName(UnitID)
	local uName = (strlen(oldName) > NameLengths[ndbc.resolution][UnitID]) and gsub(oldName, "%s?(.[\128-\191]*)%S+%s", "%1.") or oldName
	if strlen(uName) > NameLengths[ndbc.resolution][UnitID] then
		uName = strsub(uName, 1, NameLengths[ndbc.resolution][UnitID] - 1)..".."
	end
	
	-- Level
	local uLevel = UnitLevel(UnitID)
	if uLevel <= 0 then
		uLevel = 99
	end
	local uLevelColor = GetQuestDifficultyColor(uLevel)
	
	-- Classification
	local uClassification = ClassificationShort[UnitClassification(UnitID)] or ""
	
	-- Set Texts
	if (UnitID == TARGET_ID) then
		if uLevel == 99 then 
			UF[UnitID].powertext.text:SetText("??")
		else
			UF[UnitID].powertext.text:SetText(uLevel)
		end
		UF[UnitID].healthtext.text:SetText(uName)
		UF[UnitID].powertext.text:SetTextColor(uLevelColor.r, uLevelColor.g, uLevelColor.b)
	else
		local InfoText = ""
		if uLevel == 99 then uLevel = "??" end
		if ((UnitID == FOCUS_ID) or (UnitID == FOCUSTARGET_ID)) then
			InfoText = strform("%s |cff%02x%02x%02x%s|r", uName, uLevelColor.r * 255, uLevelColor.g * 255, uLevelColor.b * 255, uLevel)
		else
			InfoText = strform("|cff%02x%02x%02x%s|r %s", uLevelColor.r * 255, uLevelColor.g * 255, uLevelColor.b * 255, uLevel, uName)
		end
		UF[UnitID].healthtext.text:SetText(InfoText)
	end
	if not UnitIsPvPPlayer(TARGET_ID, TARGET_ID) then
		UF[UnitID].endboxtext.text:SetText(uClassification)
	end
end

-- Unit Background Colors
local bgColor
function UnitFrames:UpdateUnitBackgroundColor(UnitID)
	local Unit, UFUnit = PlayerOrVehicleIDs(UnitID)
	if not UF[UFUnit] then return end
	
	local newColorID = ""
	if UnitIsPVP(Unit) then
		if UnitIsPvPPlayer(Unit, UFUnit) then
			UF[UFUnit].endboxtext.text:SetText(ClassificationShort["pvp"])
			bgColor = {0, 0, 0}
			newColorID = "black"
		elseif UnitIsFriend(Unit, PLAYER_ID) then
			bgColor = db.overlay.colors.status.pvpfriendly
			newColorID = "friendly"
		else
			bgColor = db.overlay.colors.status.pvpenemy
			newColorID = "pvpenemy"
		end
	else
		if (UnitIsTapped(Unit) and not(UnitIsTappedByPlayer(Unit))) then
			bgColor = db.overlay.colors.status.tapped
			newColorID = "tapped"
		else
			bgColor = {0, 0, 0}
			newColorID = "black"
		end
		if UnitIsNotPvPPlayer(Unit, UFUnit) then
			UF[UFUnit].endboxtext.text:SetText("")
		end
	end
	
	if (UF[UFUnit].backgroundColorID ~= newColorID) then
		UF[UFUnit].backgroundColorID = newColorID
		UF[UFUnit].health.background.bg:SetVertexColor(bgColor[1], bgColor[2], bgColor[3], db.overlay.bar.opacity.background)
		if UF[UFUnit].power then
			UF[UFUnit].power.background.bg:SetVertexColor(bgColor[1], bgColor[2], bgColor[3], db.overlay.bar.opacity.background)
		end
	end
end

-- End Box
function UnitFrames:UpdateEndBox(UnitID)
	local cColor, uClass
	if UnitID == PLAYER_ID then
		cColor = GetClassColor(nibRealUI.class)
		UF[PLAYER_ID].endbox.bar:SetVertexColor(cColor[1], cColor[2], cColor[3], db.overlay.bar.opacity.status)
		if UF[PLAYER_ID].haspet then
			UF[PLAYER_ID].endbox.bar:Show()
		else
			UF[PLAYER_ID].endbox.bar:Hide()
		end
	else
		UF[UnitID].endbox.bar:Show()
		if UnitIsPlayer(UnitID) then
			_, uClass = UnitClass(UnitID)
			cColor = GetClassColor(uClass)
		else
			if UnitIsEnemy("player", UnitID) then
				cColor = db.overlay.colors.health.hostile
			elseif UnitCanAttack("player", UnitID) then
				cColor = db.overlay.colors.health.neutral
			else
				cColor = db.overlay.colors.health.friendly
			end
		end
		UF[UnitID].endbox.bar:SetVertexColor(cColor[1], cColor[2], cColor[3], db.overlay.bar.opacity.status)
	end
end

-- PvP Timer
local PvPTimerFrame = CreateFrame("Frame")
PvPTimerFrame:Hide()
PvPTimerFrame.e = 0
PvPTimerFrame.i = 1
PvPTimerFrame.ticks = 0		-- Wait until one update passes to see if we're now under 301sec PvP timer
PvPTimerFrame.ms = 0
PvPTimerFrame.ts = ""
PvPTimerFrame:SetScript("OnUpdate", function(s, e)
	s.e = s.e + e
	if s.e >= s.i then
		s.ms = GetPVPTimer()
		if s.ticks >= 1 and s.ms < 301000 then
			s.ts = ConvertSecondstoTime(floor(s.ms / 1000))
			UF[PLAYER_ID].healthtext.text:SetText(s.ts)
		elseif s.ticks >= 1 then
			s.e = 0
			s.ticks = 0
			UF[PLAYER_ID].healthtext.text:SetText("")
			s:Hide()
		else
			s.ticks = s.ticks + 1
		end
		s.e = 0
	end
end)
function UnitFrames:UpdatePvPTimer()
	local ms = UnitIsPVP(PLAYER_ID) and GetPVPTimer() or 0
	if ms > 0 then
		PvPTimerFrame:Show()
	else
		PvPTimerFrame:Hide()
		PvPTimerFrame.ticks = 0
		UF[PLAYER_ID].healthtext.text:SetText("")
	end
end

-- Status
function UnitFrames:UpdateStatus(UnitID)
	if not(UF[UnitID]) then return end
	
	local S1, S2
	local S1Status, S2Status

	-- 2
	if UnitIsAFK(UnitID) then
		S2Status = db.overlay.colors.status.afk
		S2 = true
	elseif not(UnitIsConnected(UnitID)) then
		S2Status = db.overlay.colors.status.offline
		S2 = true
	elseif (UnitID == PLAYER_ID) and UnitIsGroupLeader(UnitID) then
		S2Status = db.overlay.colors.status.leader
		S2 = true
	else
		S2 = false
	end
	if S2 then
		UF[UnitID].statusbox[2]:Show()
		UF[UnitID].statusbox[2].bar:SetVertexColor(S2Status[1], S2Status[2], S2Status[3], db.overlay.bar.opacity.status)
	else
		UF[UnitID].statusbox[2]:Hide()
	end
	
	-- 1
	if UnitAffectingCombat(UnitID) then
		S1Status = db.overlay.colors.status.combat
		S1 = true
	elseif IsResting(UnitID) then
		S1Status = db.overlay.colors.status.resting
		S1 = true
	else
		S1 = false
	end
	if S2 and not(S1) then
		UF[UnitID].statusbox[1]:Show()
		UF[UnitID].statusbox[1].bar:SetVertexColor(0, 0, 0, 0)
	elseif S1 then
		UF[UnitID].statusbox[1]:Show()
		UF[UnitID].statusbox[1].bar:SetVertexColor(S1Status[1], S1Status[2], S1Status[3], db.overlay.bar.opacity.status)
	else
		UF[UnitID].statusbox[1]:Hide()
	end
	
	-- Pvp
	if UnitID == PLAYER_ID then
		self:UpdatePvPTimer()
	end
end

-- In Between
local function InBetween_OnUpdate(self, elapsed)
	self.elapsed = self.elapsed + elapsed
	if self.elapsed >= self.interval then
		local Now = GetTime()
		-- Check current status durations
		if self.wound and (self.woundend <= Now) then
			self.wound = false
		end
		if self.heal and (self.healend <= Now) then
			self.heal = false
		end
		
		-- Apply current status
		if self.heal then
			if not self.healset then self.bg:SetVertexColor(db.overlay.colors.status.heal[1], db.overlay.colors.status.heal[2], db.overlay.colors.status.heal[3], db.overlay.bar.opacity.status) end
			self.healset = true
			self.woundset = false
			self.inchealset = false
		elseif self.wound then
			if not self.woundset then self.bg:SetVertexColor(db.overlay.colors.status.damage[1], db.overlay.colors.status.damage[2], db.overlay.colors.status.damage[3], db.overlay.bar.opacity.status) end
			self.woundset = true
			self.healset = false
			self.inchealset = false
		elseif self.incheal then
			if not self.inchealset then self.bg:SetVertexColor(db.overlay.colors.status.incomingheal[1], db.overlay.colors.status.incomingheal[2], db.overlay.colors.status.incomingheal[3], db.overlay.bar.opacity.status) end
			self.inchealset = true
			self.healset = false
			self.woundset = false
		else
			if self.inchealset or self.healset or self.woundset then self.bg:SetVertexColor(1, 1, 1, 0) end
			self.healset = false
			self.woundset = false
			self.inchealset = false
		end
		
		self.elapsed = 0
	end
end

function UnitFrames:SetInBetween(UnitID, Event)
	if Event == "WOUND" then
		UF[UnitID].inbetween.wound = true
		UF[UnitID].inbetween.woundend = GetTime() + 0.5
	elseif Event == "HEAL" then
		UF[UnitID].inbetween.heal = true
		UF[UnitID].inbetween.healend = GetTime() + 0.5
	elseif Event == "INCHEAL" then
		UF[UnitID].inbetween.incheal = true
	elseif Event == "NOINCHEAL" then
		UF[UnitID].inbetween.incheal = false
	elseif Event == "NONE" then
		UF[UnitID].inbetween.wound = false
		UF[UnitID].inbetween.heal = false
		UF[UnitID].inbetween.incheal = false
	end
end

-- Pet Status
function UnitFrames:UpdatePetStatus()
	if UnitExists(PET_ID) then
		UF[PLAYER_ID].haspet = true
		UF[PLAYER_ID].health2:Show()
		UF[PLAYER_ID].power2:Show()
	else
		UF[PLAYER_ID].haspet = false
		UF[PLAYER_ID].health2:Hide()
		UF[PLAYER_ID].power2:Hide()
	end
end

-- End Icons
function UnitFrames:UpdateEndIcons()
	for k,v in pairs(UF) do
		if UF[k].endicon then
			if UnitHasIncomingResurrection(k) then
				UF[k].endicon.bg:SetTexture([[Interface\RaidFrame\Raid-Icon-Rez]])
				UF[k].endicon:Show()
			else
				local RIUnit = ((k == PLAYER_ID) and UnitHasVehicleUI(PLAYER_ID)) and VEHICLE_ID or k
				local index = GetRaidTargetIndex(RIUnit)
				if index then
					UF[k].endicon.bg:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
					SetRaidTargetIconTexture(UF[k].endicon.bg, index)
					UF[k].endicon:Show()
				else
					UF[k].endicon:Hide()
				end
			end
		end
	end
end

-- Refresh all units power and health
function UnitFrames:RefreshUnits()
	self:UpdatePetStatus()
	SetPlayerVehicleFlag()
	for k,v in pairs(UF) do
		if UnitExists(k) then
			if UF[k].health then
				self:UpdateUnitHealthBarInfo(k)
				self:UpdateUnitHealth(k)
			end
			if UF[k].power then
				self:ToggleUnitPower(k)
				self:UpdateUnitPowerBarInfo(k)
				self:UpdateUnitPower(k)
			end
			self:UpdateEndBox(k)
			self:UpdateStatus(k)
			self:UpdateUnitBackgroundColor(k)
			self:UpdateUnitInfo(k)
		end
	end
	self:UpdateEndIcons()
end

-- Font Update
function UnitFrames:UpdateFonts()
	for k,v in pairs(UF) do
		if type(v) == "table" then
			for k2,v2 in pairs(v) do
				if type(v2) == "table" then
					if UF[k][k2].text then
						UF[k][k2].text:SetFont(unpack(nibRealUI.font.pixel1))
					else
					
			for k3,v3 in pairs(v2) do
				if type(v3) == "table" then
					if UF[k][k2][k3].text then
						UF[k][k2][k3].text:SetFont(unpack(nibRealUI.font.pixel1))
					else

			for k4,v4 in pairs(v3) do
				if type(v4) == "table" then
					if UF[k][k2][k3][k4].text then
						UF[k][k2][k3][k4].text:SetFont(unpack(nibRealUI.font.pixel1))
		
		end; end; end; end; end; end; end; end; end; end
	end
end

-- Texture Update
local USTCExtras = {FOCUS_ID, FOCUSTARGET_ID, TARGETTARGET_ID}--, MAINTANK_ID}
function UnitFrames:UpdateTextures()
	---- Player ----
	-- Health
	UF[PLAYER_ID].health.surround.bg:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.surround)
	for i = 1, 2 do
		UF[PLAYER_ID].health.steps[i].bg:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.steps)
	end
	UF[PLAYER_ID].health.arrow.surround.bg:SetVertexColor(1, 1, 1, db.overlay.arrow.opacity.surround)
	UF[PLAYER_ID].health2.bg:SetVertexColor(1, 1, 1, 1)
	
	-- Power
	UF[PLAYER_ID].power.surround.bg:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.surround)
	for i = 1, 3 do
		UF[PLAYER_ID].power.steps[i].bg:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.steps)
	end
	UF[PLAYER_ID].power.arrow.surround.bg:SetVertexColor(1, 1, 1, db.overlay.arrow.opacity.surround)
	UF[PLAYER_ID].power2.bg:SetVertexColor(1, 1, 1, 1)
	
	-- End Box
	UF[PLAYER_ID].endbox.surround:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.surround)
	UF[PLAYER_ID].endbox.background:SetVertexColor(0, 0, 0, db.overlay.bar.opacity.background)
	
	-- Status Boxes
	for i = 1, 2 do
		UF[PLAYER_ID].statusbox[i].surround:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.surround)
		UF[PLAYER_ID].statusbox[i].background:SetVertexColor(0, 0, 0, db.overlay.bar.opacity.background)
	end
	
	---- Target ----
	-- Health
	UF[TARGET_ID].health.surround.bg:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.surround)
	for i = 1, 2 do
		UF[TARGET_ID].health.steps[i].bg:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.steps)
	end
	UF[TARGET_ID].health.arrow.surround.bg:SetVertexColor(1, 1, 1, db.overlay.arrow.opacity.surround)
	
	-- Power
	UF[TARGET_ID].power.surround.bg:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.surround)
	for i = 1, 3 do
		UF[TARGET_ID].power.steps[i].bg:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.steps)
	end
	UF[TARGET_ID].power.arrow.surround.bg:SetVertexColor(1, 1, 1, db.overlay.arrow.opacity.surround)
	
	-- End Box
	UF[TARGET_ID].endbox.surround:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.surround)
	UF[TARGET_ID].endbox.background:SetVertexColor(0, 0, 0, db.overlay.bar.opacity.background)
	
	-- Status Boxes
	for i = 1, 2 do
		UF[TARGET_ID].statusbox[i].surround:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.surround)
		UF[TARGET_ID].statusbox[i].background:SetVertexColor(0, 0, 0, db.overlay.bar.opacity.background)
	end
	
	---- Extras ----
	for k,v in pairs(USTCExtras) do
		-- Health
		UF[v].health.surround.bg:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.surround)
		
		-- End Box
		UF[v].endbox.surround:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.surround)
		UF[v].endbox.background:SetVertexColor(0, 0, 0, db.overlay.bar.opacity.background)
		
		-- Status Boxes
		for i = 1, 2 do
			UF[v].statusbox[i].surround:SetVertexColor(1, 1, 1, db.overlay.bar.opacity.surround)
			UF[v].statusbox[i].background:SetVertexColor(0, 0, 0, db.overlay.bar.opacity.background)
		end
	end
end

---- FRAME CREATION ----
local function CreateStatusBox(parent)
	local NewEndBox
	NewEndBox = CreateFrame("Frame", nil, parent)
	NewEndBox:SetParent(parent)
	NewEndBox.surround = NewEndBox:CreateTexture(nil, "ARTWORK")
	NewEndBox.surround:SetAllPoints()
	NewEndBox.background = NewEndBox:CreateTexture(nil, "BACKGROUND")
	NewEndBox.background:SetAllPoints()
	NewEndBox.bar = NewEndBox:CreateTexture(nil, "ARTWORK")
	NewEndBox.bar:SetAllPoints()
	return NewEndBox
end

local function CreateArtFrame(parent)
	local NewArtFrame
	NewArtFrame = CreateFrame("Frame", nil, parent)
	NewArtFrame:SetParent(parent)
	NewArtFrame.bg = NewArtFrame:CreateTexture(nil, "ARTWORK")
	NewArtFrame.bg:SetAllPoints()
	return NewArtFrame
end

local function CreateTextFrame(parent, position1, position2)
	local NewTextFrame
	NewTextFrame = CreateFrame("Frame", nil, parent)
	NewTextFrame.text = NewTextFrame:CreateFontString(nil, "ARTWORK")
	NewTextFrame.text:SetFont(unpack(nibRealUI.font.pixel1))
	SetTextPosition(NewTextFrame, position1, position2)
	return NewTextFrame
end

function UnitFrames:CreateFrames()
	local SimpleBackdrop = {
		bgFile = nibRealUI.media.textures.plain, 
		edgeFile = nibRealUI.media.textures.plain, 
		tile = false, tileSize = 0, edgeSize = 1, 
		insets = { left = 1, right = 1, top = 1, bottom = 1	}
	}
	
	----------------
	---- Player ----
	----------------
	local Parent = _G[ParentFrames[PLAYER_ID]] or UIParent
	UF[PLAYER_ID] = CreateFrame("Frame", ParentFrames[PLAYER_ID].."_Overlay", Parent)
	SetFramePosition(UF[PLAYER_ID], "MEDIUM", 0, 256, 32, {"BOTTOMRIGHT", Parent, "BOTTOMRIGHT", 0, -5})
	UF[PLAYER_ID].backgroundColorID = ""
	
	-- Health
	UF[PLAYER_ID].health = CreateFrame("Frame", nil, UF[PLAYER_ID])
	UF[PLAYER_ID].health:SetParent(UF[PLAYER_ID])
	SetFramePosition(UF[PLAYER_ID].health, "MEDIUM", UF[PLAYER_ID]:GetFrameLevel(), 256, 16, {"BOTTOMRIGHT", UF[PLAYER_ID], "BOTTOMRIGHT", 0, 16})
	UF[PLAYER_ID].health.colorID = ""
	UF[PLAYER_ID].health.alpha = 1
	UF[PLAYER_ID].health.position = -1
	UF[PLAYER_ID].health.elapsed = 0
	UF[PLAYER_ID].health.interval = 0.1
	UF[PLAYER_ID].health:SetScript("OnUpdate", function(self, elapsed)
		UnitFrames:Health_OnUpdate(self, elapsed, PLAYER_ID)
	end)
	
		-- Surround
		UF[PLAYER_ID].health.surround = CreateArtFrame(UF[PLAYER_ID].health)
		SetFramePosition(UF[PLAYER_ID].health.surround, "MEDIUM", UF[PLAYER_ID].health:GetFrameLevel() + 2, 256, 16, {"BOTTOMRIGHT", UF[PLAYER_ID].health, "BOTTOMRIGHT", 0, 0})
		UF[PLAYER_ID].health.surround.bg:SetTexture(Textures[ndbc.resolution].f1.health.surround)
		
		-- Background
		UF[PLAYER_ID].health.background = CreateArtFrame(UF[PLAYER_ID].health)
		SetFramePosition(UF[PLAYER_ID].health.background, "MEDIUM", UF[PLAYER_ID].health:GetFrameLevel(), 256, 16, {"BOTTOMRIGHT", UF[PLAYER_ID].health, "BOTTOMRIGHT", 0, 0})
		UF[PLAYER_ID].health.background.bg:SetTexture(Textures[ndbc.resolution].f1.health.bar)
		
		-- Bar
		UF[PLAYER_ID].health.bar = CreateArtFrame(UF[PLAYER_ID].health.background)
		UF[PLAYER_ID].health.bar.pos = 0
		UF[PLAYER_ID].health.bar.maxwidth = HealthWidthShort[ndbc.resolution][PLAYER_ID]
		SetFramePosition(UF[PLAYER_ID].health.bar, "MEDIUM", UF[PLAYER_ID].health.background:GetFrameLevel() + 1, 0, (ndbc.resolution == 1) and 9 or 10, {"BOTTOMRIGHT", UF[PLAYER_ID].health.background, "BOTTOMRIGHT", -1, 1})
		UF[PLAYER_ID].health.bar.bg:SetTexture(nibRealUI.media.textures.plain)
		
		-- Bar End
		UF[PLAYER_ID].health.bar.ender = CreateArtFrame(UF[PLAYER_ID].health.background)
		SetFramePosition(UF[PLAYER_ID].health.bar.ender, "MEDIUM", UF[PLAYER_ID].health.bar:GetFrameLevel(), (ndbc.resolution == 1) and 8 or 9, 16, {"BOTTOMRIGHT", UF[PLAYER_ID].health.bar, "BOTTOMLEFT", 0, -1})
		UF[PLAYER_ID].health.bar.ender.bg:SetTexture(Textures[ndbc.resolution].f1.health.bar)
		UF[PLAYER_ID].health.bar.ender.bg:SetTexCoord(unpack(HealthEndBarCoords[ndbc.resolution][PLAYER_ID]))
		UF[PLAYER_ID].health.bar.ender:Hide()
		
		-- HealthBar Text
		UF[PLAYER_ID].healthtext = CreateTextFrame(UF[PLAYER_ID].health, "BOTTOM", "RIGHT")
		SetFramePosition(UF[PLAYER_ID].healthtext, "MEDIUM", UF[PLAYER_ID].health:GetFrameLevel() + 2, 12, 12, {"BOTTOMRIGHT", UF[PLAYER_ID].health, "BOTTOMRIGHT", -6, 1})
		
		-- Health Text
		UF[PLAYER_ID].health.fullval = CreateTextFrame(UF[PLAYER_ID].health, "BOTTOM", "LEFT")
		
		-- Steps
		UF[PLAYER_ID].health.steps = {}
		for i = 1, 2 do
			UF[PLAYER_ID].health.steps[i] = CreateArtFrame(UF[PLAYER_ID].health.surround)
			SetFramePosition(UF[PLAYER_ID].health.steps[i], "MEDIUM", UF[PLAYER_ID].health.surround:GetFrameLevel() + 2, 16, 16, {"BOTTOMRIGHT", UF[PLAYER_ID].health.surround, "BOTTOMRIGHT", 0, 0})
			UF[PLAYER_ID].health.steps[i].bg:SetTexture(Textures[ndbc.resolution].f1.health.step)
			UF[PLAYER_ID].health.steps[i]:Hide()
		end
		
		-- Arrow
		UF[PLAYER_ID].health.arrow = {}
		UF[PLAYER_ID].health.arrow.step = -1
		
			-- Surround
			UF[PLAYER_ID].health.arrow.surround = CreateArtFrame(UF[PLAYER_ID].health.bar)
			SetFramePosition(UF[PLAYER_ID].health.arrow.surround, "MEDIUM", UF[PLAYER_ID].health:GetFrameLevel(), 64, 32, {"BOTTOM", UF[PLAYER_ID].health.bar, "BOTTOMLEFT", 2, HealthArrowYOffset[ndbc.resolution]})
			UF[PLAYER_ID].health.arrow.surround.bg:SetTexture(Textures[ndbc.resolution].f1.health.arrow.surround)
			
			-- Background
			UF[PLAYER_ID].health.arrow.background = CreateArtFrame(UF[PLAYER_ID].health.arrow.surround)
			SetFramePosition(UF[PLAYER_ID].health.arrow.background, "MEDIUM", UF[PLAYER_ID].health:GetFrameLevel(), 64, 32, {"BOTTOM", UF[PLAYER_ID].health.arrow.surround, "BOTTOM", 0, 0})
			UF[PLAYER_ID].health.arrow.background.bg:SetTexture(Textures[ndbc.resolution].f1.health.arrow.background)
			
			-- Percent Text
			UF[PLAYER_ID].health.arrow.percent = CreateTextFrame(UF[PLAYER_ID].health.arrow.surround, "BOTTOM", "RIGHT")
			SetFramePosition(UF[PLAYER_ID].health.arrow.percent, "MEDIUM", UF[PLAYER_ID].health:GetFrameLevel(), 12, 12, {"BOTTOMRIGHT", UF[PLAYER_ID].health.arrow.surround, "BOTTOMRIGHT", -44, 0})
		
		-- Secondary Health
		UF[PLAYER_ID].health2 = CreateArtFrame(UF[PLAYER_ID].health)
		SetFramePosition(UF[PLAYER_ID].health2, "MEDIUM", UF[PLAYER_ID].health:GetFrameLevel() + 3, HealthWidth[ndbc.resolution][PLAYER_ID], 3, {"BOTTOMRIGHT", UF[PLAYER_ID].health, "BOTTOMRIGHT", 0, 0})
		UF[PLAYER_ID].health2:SetBackdrop(SimpleBackdrop)
		UF[PLAYER_ID].health2:SetBackdropColor(1, 1, 1, 1)
		UF[PLAYER_ID].health2:SetBackdropBorderColor(0, 0, 0, 1)
		UF[PLAYER_ID].health2.alpha = 0
		UF[PLAYER_ID].health2.visible = true
		UF[PLAYER_ID].health2:Hide()
		
	-- Power
	UF[PLAYER_ID].power = CreateFrame("Frame", nil, UF[PLAYER_ID])
	UF[PLAYER_ID].power:SetParent(UF[PLAYER_ID])
	SetFramePosition(UF[PLAYER_ID].power, "MEDIUM", UF[PLAYER_ID]:GetFrameLevel(), 256, 16, {"BOTTOMRIGHT", UF[PLAYER_ID], "BOTTOMRIGHT", 0, -1})
	UF[PLAYER_ID].power.color = ""
	UF[PLAYER_ID].power.alpha = 1
	UF[PLAYER_ID].power.position = -1
	UF[PLAYER_ID].power.elapsed = 0
	UF[PLAYER_ID].power.interval = 0.2
	UF[PLAYER_ID].power:SetScript("OnUpdate", function(self, elapsed)
		UnitFrames:Power_OnUpdate(self, elapsed, PLAYER_ID)
	end)
	
		-- Surround
		UF[PLAYER_ID].power.surround = CreateArtFrame(UF[PLAYER_ID].power)
		SetFramePosition(UF[PLAYER_ID].power.surround, "MEDIUM", UF[PLAYER_ID].power:GetFrameLevel() + 2, 256, 16, {"BOTTOMRIGHT", UF[PLAYER_ID].power, "BOTTOMRIGHT", 0, 0})
		UF[PLAYER_ID].power.surround.bg:SetTexture(Textures[ndbc.resolution].f1.power.surround)
		
		-- Background
		UF[PLAYER_ID].power.background = CreateArtFrame(UF[PLAYER_ID].power)
		SetFramePosition(UF[PLAYER_ID].power.background, "MEDIUM", UF[PLAYER_ID].power:GetFrameLevel(), 256, 16, {"BOTTOMRIGHT", UF[PLAYER_ID].power, "BOTTOMRIGHT", 0, 0})
		UF[PLAYER_ID].power.background.bg:SetTexture(Textures[ndbc.resolution].f1.power.bar)
		
		-- Bar
		UF[PLAYER_ID].power.bar = CreateArtFrame(UF[PLAYER_ID].power.background)
		UF[PLAYER_ID].power.bar.pos = 0
		UF[PLAYER_ID].power.bar.maxwidth = PowerWidthShort[ndbc.resolution][PLAYER_ID]
		SetFramePosition(UF[PLAYER_ID].power.bar, "MEDIUM", UF[PLAYER_ID].power.background:GetFrameLevel() + 1, 0, (ndbc.resolution == 1) and 7 or 8, {"TOPRIGHT", UF[PLAYER_ID].power.background, "TOPRIGHT", 0, -1})
		UF[PLAYER_ID].power.bar.bg:SetTexture(nibRealUI.media.textures.plain)
		
		-- Bar End
		UF[PLAYER_ID].power.bar.ender = CreateArtFrame(UF[PLAYER_ID].power.background)
		SetFramePosition(UF[PLAYER_ID].power.bar.ender, "MEDIUM", UF[PLAYER_ID].power.bar:GetFrameLevel(), (ndbc.resolution == 1) and 6 or 7, 16, {"TOPRIGHT", UF[PLAYER_ID].power.bar, "TOPLEFT", 0, 1})
		UF[PLAYER_ID].power.bar.ender.bg:SetTexture(Textures[ndbc.resolution].f1.power.bar)
		UF[PLAYER_ID].power.bar.ender.bg:SetTexCoord(unpack(PowerEndBarCoords[ndbc.resolution][PLAYER_ID]))
		UF[PLAYER_ID].power.bar.ender:Hide()
		
		-- Power Text
		UF[PLAYER_ID].power.fullval = CreateTextFrame(UF[PLAYER_ID].power, "TOP", "LEFT")
		
		-- Steps
		UF[PLAYER_ID].power.steps = {}
		for i = 1, 3 do
			UF[PLAYER_ID].power.steps[i] = CreateArtFrame(UF[PLAYER_ID].power.surround)
			SetFramePosition(UF[PLAYER_ID].power.steps[i], "MEDIUM", UF[PLAYER_ID].power.surround:GetFrameLevel() + 2, 16, 16, {"BOTTOMRIGHT", UF[PLAYER_ID].power.surround, "BOTTOMRIGHT", 0, 0})
			UF[PLAYER_ID].power.steps[i].bg:SetTexture(Textures[ndbc.resolution].f1.power.step)
			UF[PLAYER_ID].power.steps[i]:Hide()
		end
		
		-- Arrow
		UF[PLAYER_ID].power.arrow = {}
		UF[PLAYER_ID].power.arrow.step = -1
		
			-- Surround
			UF[PLAYER_ID].power.arrow.surround = CreateArtFrame(UF[PLAYER_ID].power.bar)
			SetFramePosition(UF[PLAYER_ID].power.arrow.surround, "MEDIUM", UF[PLAYER_ID].power:GetFrameLevel(), 64, 32, {"BOTTOM", UF[PLAYER_ID].power.bar, "BOTTOMLEFT", 1, PowerArrowYOffset[ndbc.resolution]})
			UF[PLAYER_ID].power.arrow.surround.bg:SetTexture(Textures[ndbc.resolution].f1.power.arrow.surround)
			
			-- Background
			UF[PLAYER_ID].power.arrow.background = CreateArtFrame(UF[PLAYER_ID].power.arrow.surround)
			SetFramePosition(UF[PLAYER_ID].power.arrow.background, "MEDIUM", UF[PLAYER_ID].power:GetFrameLevel(), 64, 32, {"BOTTOM", UF[PLAYER_ID].power.arrow.surround, "BOTTOM", 0, 0})
			UF[PLAYER_ID].power.arrow.background.bg:SetTexture(Textures[ndbc.resolution].f1.power.arrow.background)
		
			-- Percent Text
			UF[PLAYER_ID].power.arrow.percent = CreateTextFrame(UF[PLAYER_ID].power.arrow.surround, "TOP", "RIGHT")
			SetFramePosition(UF[PLAYER_ID].power.arrow.percent, "MEDIUM", UF[PLAYER_ID].power:GetFrameLevel(), 12, 12, {"TOPRIGHT", UF[PLAYER_ID].power.arrow.surround, "TOPLEFT", 20, PowerArrowTextYOffset[ndbc.resolution]})
			
		-- Secondary Power
		UF[PLAYER_ID].power2 = CreateArtFrame(UF[PLAYER_ID].power)
		SetFramePosition(UF[PLAYER_ID].power2, "MEDIUM", UF[PLAYER_ID].power:GetFrameLevel() + 3, PowerWidth[ndbc.resolution][PLAYER_ID], 3, {"TOPRIGHT", UF[PLAYER_ID].power, "TOPRIGHT", 0, 0})
		UF[PLAYER_ID].power2:SetBackdrop(SimpleBackdrop)
		UF[PLAYER_ID].power2:SetBackdropColor(1, 1, 1, 1)
		UF[PLAYER_ID].power2:SetBackdropBorderColor(0, 0, 0, 1)
		UF[PLAYER_ID].power2.alpha = 0
		UF[PLAYER_ID].power2.visible = true
		UF[PLAYER_ID].power2:Hide()
	
	-- In Between
	UF[PLAYER_ID].inbetween = CreateArtFrame(UF[PLAYER_ID])
	SetFramePosition(UF[PLAYER_ID].inbetween, "MEDIUM", UF[PLAYER_ID]:GetFrameLevel(), PowerWidth[ndbc.resolution][PLAYER_ID] + 2, 1, {"RIGHT", UF[PLAYER_ID], "RIGHT", 0, -1})
	UF[PLAYER_ID].inbetween.bg:SetTexture(nibRealUI.media.textures.plain)
	UF[PLAYER_ID].inbetween.bg:SetVertexColor(1, 1, 1, 0)
	UF[PLAYER_ID].inbetween.wound = false
	UF[PLAYER_ID].inbetween.woundend = 0
	UF[PLAYER_ID].inbetween.heal = false
	UF[PLAYER_ID].inbetween.healend = 0
	UF[PLAYER_ID].inbetween.incheal = false
	UF[PLAYER_ID].inbetween.elapsed = 0
	UF[PLAYER_ID].inbetween.interval = 0.1
	UF[PLAYER_ID].inbetween:SetScript("OnUpdate", function(self, elapsed)
		InBetween_OnUpdate(self, elapsed)
	end)
	
	-- End Box
	UF[PLAYER_ID].endbox = CreateStatusBox(UF[PLAYER_ID])
	SetFramePosition(UF[PLAYER_ID].endbox, "MEDIUM", UF[PLAYER_ID]:GetFrameLevel(), 16, 32, {"LEFT", UF[PLAYER_ID], "RIGHT", 1, 0})
	UF[PLAYER_ID].endbox.surround:SetTexture(Textures[ndbc.resolution].f1.endbox.surround)
	UF[PLAYER_ID].endbox.background:SetTexture(Textures[ndbc.resolution].f1.endbox.bar)
	UF[PLAYER_ID].endbox.bar:SetTexture(Textures[ndbc.resolution].f1.endbox.bar)
	UF[PLAYER_ID].endbox.bar:SetVertexColor(0, 0, 0, 0)
	UF[PLAYER_ID].endbox.elapsed = 0
	UF[PLAYER_ID].endbox.interval = 0.2
	UF[PLAYER_ID].endbox:SetScript("OnUpdate", function(self, elapsed)
		if UF[PLAYER_ID].haspet then
			UnitFrames:Health_OnUpdate(self, elapsed, PET_ID)
			UnitFrames:Power_OnUpdate(self, elapsed, PET_ID)
		end
	end)
	
	
	-- End Box Text
	UF[PLAYER_ID].endboxtext = CreateTextFrame(UF[PLAYER_ID].endbox, "CENTER", "CENTER")
	SetFramePosition(UF[PLAYER_ID].endboxtext, "MEDIUM", UF[PLAYER_ID].endbox:GetFrameLevel() + 1, 12, 12, {"CENTER", UF[PLAYER_ID].endbox, "CENTER", EndBoxTextXOffset[ndbc.resolution][PLAYER_ID], 0})
	
	-- Range Display
	UF[PLAYER_ID].rangedisplay = CreateTextFrame(UF[PLAYER_ID].endbox, "BOTTOM", "LEFT")
	SetFramePosition(UF[PLAYER_ID].rangedisplay, "MEDIUM", UF[PLAYER_ID]:GetFrameLevel(), 12, 12, {"BOTTOMLEFT", UF[PLAYER_ID].endbox, "BOTTOMRIGHT", -2, 12})
	UF[PLAYER_ID].rangedisplay.elapsed = 0
	UF[PLAYER_ID].rangedisplay.interval = 0.2
	UF[PLAYER_ID].rangedisplay.lastmin = -1
	UF[PLAYER_ID].rangedisplay.lastmax = -1
	UF[PLAYER_ID].rangedisplay:SetScript("OnUpdate", function(self, elapsed)
		UnitFrames:RangeDisplay_OnUpdate(self, elapsed, PET_ID)
	end)
	
	-- Status Boxes
	UF[PLAYER_ID].statusbox = {}
	for i = 1, 2 do
		UF[PLAYER_ID].statusbox[i] = CreateStatusBox(UF[PLAYER_ID].power)
		SetFramePosition(UF[PLAYER_ID].statusbox[i], "MEDIUM", UF[PLAYER_ID].power:GetFrameLevel(), 16, 16, {"BOTTOMRIGHT", UF[PLAYER_ID].power, "BOTTOMLEFT", -((i-1)*5+(i)) + (256 - PowerWidthShort[ndbc.resolution][PLAYER_ID] - 1), 0})
		UF[PLAYER_ID].statusbox[i].surround:SetTexture(Textures[ndbc.resolution].f1.statusbox.surround)
		UF[PLAYER_ID].statusbox[i].background:SetTexture(Textures[ndbc.resolution].f1.statusbox.bar)
		UF[PLAYER_ID].statusbox[i].bar:SetTexture(Textures[ndbc.resolution].f1.statusbox.bar)
		UF[PLAYER_ID].statusbox[i].bar:SetVertexColor(0, 0, 0, 0)
	end
	
	-- End Icon
	UF[PLAYER_ID].endicon = CreateArtFrame(UF[PLAYER_ID])
	UF[PLAYER_ID].endicon:Hide()
	SetFramePosition(UF[PLAYER_ID].endicon, "MEDIUM", UF[PLAYER_ID]:GetFrameLevel(), 24, 24, {"BOTTOMRIGHT", UF[PLAYER_ID], "TOPLEFT", (256 - HealthWidthShort[ndbc.resolution][PLAYER_ID]) + 22, (ndbc.resolution == 1) and 16 or 20})
	UF[PLAYER_ID].endicon.bg:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
	
	
	----------------
	---- Target ----
	----------------
	local Parent = _G[ParentFrames[TARGET_ID]] or UIParent
	UF[TARGET_ID] = CreateFrame("Frame", ParentFrames[TARGET_ID].."_Overlay", Parent)
	UF[TARGET_ID]:Hide()
	SetFramePosition(UF[TARGET_ID], "MEDIUM", 0, 256, 32, {"BOTTOMLEFT", Parent, "BOTTOMLEFT", 0, -5})
	UF[TARGET_ID].backgroundColorID = ""
	
	-- Health
	UF[TARGET_ID].health = CreateFrame("Frame", nil, UF[TARGET_ID])
	UF[TARGET_ID].health:SetParent(UF[TARGET_ID])
	SetFramePosition(UF[TARGET_ID].health, "MEDIUM", UF[TARGET_ID]:GetFrameLevel(), 256, 16, {"BOTTOMLEFT", UF[TARGET_ID], "BOTTOMLEFT", 0, 16})
	UF[TARGET_ID].health.colorID = ""
	UF[TARGET_ID].health.alpha = 1
	UF[TARGET_ID].health.position = -1
	UF[TARGET_ID].health.elapsed = 0
	UF[TARGET_ID].health.interval = 0.2
	UF[TARGET_ID].health:SetScript("OnUpdate", function(self, elapsed)
		UnitFrames:Health_OnUpdate(self, elapsed, TARGET_ID)
	end)
	
		-- Surround
		UF[TARGET_ID].health.surround = CreateArtFrame(UF[TARGET_ID].health)
		SetFramePosition(UF[TARGET_ID].health.surround, "MEDIUM", UF[TARGET_ID].health:GetFrameLevel() + 2, 256, 16, {"BOTTOMLEFT", UF[TARGET_ID].health, "BOTTOMLEFT", 0, 0})
		UF[TARGET_ID].health.surround.bg:SetTexture(Textures[ndbc.resolution].f1.health.surround)
		UF[TARGET_ID].health.surround.bg:SetTexCoord(1, 0, 0, 1)
		
		-- Background
		UF[TARGET_ID].health.background = CreateArtFrame(UF[TARGET_ID].health)
		SetFramePosition(UF[TARGET_ID].health.background, "MEDIUM", UF[TARGET_ID].health:GetFrameLevel(), 256, 16, {"BOTTOMLEFT", UF[TARGET_ID].health, "BOTTOMLEFT", 0, 0})
		UF[TARGET_ID].health.background.bg:SetTexture(Textures[ndbc.resolution].f1.health.bar)
		UF[TARGET_ID].health.background.bg:SetTexCoord(1, 0, 0, 1)
		
		-- Bar
		UF[TARGET_ID].health.bar = CreateArtFrame(UF[TARGET_ID].health.background)
		UF[TARGET_ID].health.bar.pos = 0
		UF[TARGET_ID].health.bar.maxwidth = HealthWidthShort[ndbc.resolution][TARGET_ID]
		SetFramePosition(UF[TARGET_ID].health.bar, "MEDIUM", UF[TARGET_ID].health.background:GetFrameLevel() + 1, 0, (ndbc.resolution == 1) and 9 or 10, {"BOTTOMLEFT", UF[TARGET_ID].health.background, "BOTTOMLEFT", 1, 1})
		UF[TARGET_ID].health.bar.bg:SetTexture(nibRealUI.media.textures.plain)
		
		-- Bar End
		UF[TARGET_ID].health.bar.ender = CreateArtFrame(UF[TARGET_ID].health.background)
		SetFramePosition(UF[TARGET_ID].health.bar.ender, "MEDIUM", UF[TARGET_ID].health.bar:GetFrameLevel(), (ndbc.resolution == 1) and 8 or 9, 16, {"BOTTOMLEFT", UF[TARGET_ID].health.bar, "BOTTOMRIGHT", 0, -1})
		UF[TARGET_ID].health.bar.ender.bg:SetTexture(Textures[ndbc.resolution].f1.health.bar)
		UF[TARGET_ID].health.bar.ender.bg:SetTexCoord(unpack(HealthEndBarCoords[ndbc.resolution][TARGET_ID]))
		UF[TARGET_ID].health.bar.ender:Hide()
		
		-- HealthBar Text
		UF[TARGET_ID].healthtext = CreateTextFrame(UF[TARGET_ID].health, "BOTTOM", "LEFT")
		SetFramePosition(UF[TARGET_ID].healthtext, "MEDIUM", UF[TARGET_ID].health:GetFrameLevel() + 2, 12, 12, {"BOTTOMLEFT", UF[TARGET_ID].health, "BOTTOMLEFT", 8, 1})
		
		-- Health Text
		UF[TARGET_ID].health.fullval = CreateTextFrame(UF[TARGET_ID].health, "BOTTOM", "LEFT")
		
		-- Steps
		UF[TARGET_ID].health.steps = {}
		for i = 1, 2 do
			UF[TARGET_ID].health.steps[i] = CreateArtFrame(UF[TARGET_ID].health.surround)
			SetFramePosition(UF[TARGET_ID].health.steps[i], "MEDIUM", UF[TARGET_ID].health.surround:GetFrameLevel() + 2, 16, 16, {"BOTTOMLEFT", UF[TARGET_ID].health.surround, "BOTTOMLEFT", 0, 0})
			UF[TARGET_ID].health.steps[i].bg:SetTexture(Textures[ndbc.resolution].f1.health.step)
			UF[TARGET_ID].health.steps[i].bg:SetTexCoord(1, 0, 0, 1)
			UF[TARGET_ID].health.steps[i]:Hide()
		end
		
		-- Arrow
		UF[TARGET_ID].health.arrow = {}
		UF[TARGET_ID].health.arrow.step = -1
		
			-- Surround
			UF[TARGET_ID].health.arrow.surround = CreateArtFrame(UF[TARGET_ID].health.bar)
			SetFramePosition(UF[TARGET_ID].health.arrow.surround, "MEDIUM", UF[TARGET_ID].health:GetFrameLevel(), 64, 32, {"BOTTOM", UF[TARGET_ID].health.bar, "BOTTOMRIGHT", -2, HealthArrowYOffset[ndbc.resolution]})
			UF[TARGET_ID].health.arrow.surround.bg:SetTexture(Textures[ndbc.resolution].f1.health.arrow.surround)
			UF[TARGET_ID].health.arrow.surround.bg:SetTexCoord(1, 0, 0, 1)
			
			-- Background
			UF[TARGET_ID].health.arrow.background = CreateArtFrame(UF[TARGET_ID].health.arrow.surround)
			SetFramePosition(UF[TARGET_ID].health.arrow.background, "MEDIUM", UF[TARGET_ID].health:GetFrameLevel(), 64, 32, {"BOTTOM", UF[TARGET_ID].health.arrow.surround, "BOTTOM", 0, 0})
			UF[TARGET_ID].health.arrow.background.bg:SetTexture(Textures[ndbc.resolution].f1.health.arrow.background)
			UF[TARGET_ID].health.arrow.background.bg:SetTexCoord(1, 0, 0, 1)
			
			-- Percent Text
			UF[TARGET_ID].health.arrow.percent = CreateTextFrame(UF[TARGET_ID].health.arrow.surround, "BOTTOM", "LEFT")
			SetFramePosition(UF[TARGET_ID].health.arrow.percent, "MEDIUM", UF[TARGET_ID].health:GetFrameLevel(), 12, 12, {"BOTTOMLEFT", UF[TARGET_ID].health.arrow.surround, "BOTTOMRIGHT", -18, 0})
	
	-- Power
	UF[TARGET_ID].power = CreateFrame("Frame", nil, UF[TARGET_ID])
	UF[TARGET_ID].power:SetParent(UF[TARGET_ID])
	SetFramePosition(UF[TARGET_ID].power, "MEDIUM", UF[TARGET_ID]:GetFrameLevel(), 256, 16, {"BOTTOMLEFT", UF[TARGET_ID], "BOTTOMLEFT", 0, -1})
	UF[TARGET_ID].power.color = ""
	UF[TARGET_ID].power.alpha = 1
	UF[TARGET_ID].power.position = -1
	UF[TARGET_ID].power.elapsed = 0
	UF[TARGET_ID].power.interval = 0.1
	UF[TARGET_ID].power:SetScript("OnUpdate", function(self, elapsed)
		UnitFrames:Power_OnUpdate(self, elapsed, TARGET_ID)
	end)
	
		-- Surround
		UF[TARGET_ID].power.surround = CreateArtFrame(UF[TARGET_ID].power)
		SetFramePosition(UF[TARGET_ID].power.surround, "MEDIUM", UF[TARGET_ID].power:GetFrameLevel() + 2, 256, 16, {"BOTTOMLEFT", UF[TARGET_ID].power, "BOTTOMLEFT", 0, 0})
		UF[TARGET_ID].power.surround.bg:SetTexture(Textures[ndbc.resolution].f1.power.surround)
		UF[TARGET_ID].power.surround.bg:SetTexCoord(1, 0, 0, 1)
		
		-- Background
		UF[TARGET_ID].power.background = CreateArtFrame(UF[TARGET_ID].power)
		SetFramePosition(UF[TARGET_ID].power.background, "MEDIUM", UF[TARGET_ID].power:GetFrameLevel(), 256, 16, {"BOTTOMLEFT", UF[TARGET_ID].power, "BOTTOMLEFT", 0, 0})
		UF[TARGET_ID].power.background.bg:SetTexture(Textures[ndbc.resolution].f1.power.bar)
		UF[TARGET_ID].power.background.bg:SetTexCoord(1, 0, 0, 1)
		
		-- Bar
		UF[TARGET_ID].power.bar = CreateArtFrame(UF[TARGET_ID].power.background)
		UF[TARGET_ID].power.bar.pos = 0
		UF[TARGET_ID].power.bar.maxwidth = PowerWidthShort[ndbc.resolution][TARGET_ID]
		SetFramePosition(UF[TARGET_ID].power.bar, "MEDIUM", UF[TARGET_ID].power.background:GetFrameLevel() + 1, 0, (ndbc.resolution == 1) and 7 or 8, {"TOPLEFT", UF[TARGET_ID].power.background, "TOPLEFT", 0, -1})
		UF[TARGET_ID].power.bar.bg:SetTexture(nibRealUI.media.textures.plain)
		
		-- Bar End
		UF[TARGET_ID].power.bar.ender = CreateArtFrame(UF[TARGET_ID].power.background)
		SetFramePosition(UF[TARGET_ID].power.bar.ender, "MEDIUM", UF[TARGET_ID].power.bar:GetFrameLevel(), (ndbc.resolution == 1) and 6 or 7, 16, {"TOPLEFT", UF[TARGET_ID].power.bar, "TOPRIGHT", 0, 1})
		UF[TARGET_ID].power.bar.ender.bg:SetTexture(Textures[ndbc.resolution].f1.power.bar)
		UF[TARGET_ID].power.bar.ender.bg:SetTexCoord(unpack(PowerEndBarCoords[ndbc.resolution][TARGET_ID]))
		UF[TARGET_ID].power.bar.ender:Hide()
		
		-- PowerBar Text
		UF[TARGET_ID].powertext = CreateTextFrame(UF[TARGET_ID].power, "BOTTOM", "LEFT")
		SetFramePosition(UF[TARGET_ID].powertext, "MEDIUM", UF[TARGET_ID].power:GetFrameLevel() + 2, 10, 10, {"BOTTOMLEFT", UF[TARGET_ID].power, "BOTTOMLEFT", 8, (ndbc.resolution == 1) and 7 or 6})
		
		-- Power Text
		UF[TARGET_ID].power.fullval = CreateTextFrame(UF[TARGET_ID].power, "TOP", "RIGHT")
		
		-- Steps
		UF[TARGET_ID].power.steps = {}
		for i = 1, 3 do
			UF[TARGET_ID].power.steps[i] = CreateArtFrame(UF[TARGET_ID].power.surround)
			SetFramePosition(UF[TARGET_ID].power.steps[i], "MEDIUM", UF[TARGET_ID].power.surround:GetFrameLevel() + 2, 16, 16, {"BOTTOMLEFT", UF[TARGET_ID].power.surround, "BOTTOMLEFT", 0, 0})
			UF[TARGET_ID].power.steps[i].bg:SetTexture(Textures[ndbc.resolution].f1.power.step)
			UF[TARGET_ID].power.steps[i].bg:SetTexCoord(1, 0, 0, 1)
			UF[TARGET_ID].power.steps[i]:Hide()
		end
		
		-- Arrow
		UF[TARGET_ID].power.arrow = {}
		UF[TARGET_ID].power.arrow.step = -1
		
			-- Surround
			UF[TARGET_ID].power.arrow.surround = CreateArtFrame(UF[TARGET_ID].power.bar)
			SetFramePosition(UF[TARGET_ID].power.arrow.surround, "MEDIUM", UF[TARGET_ID].power:GetFrameLevel(), 64, 32, {"BOTTOM", UF[TARGET_ID].power.bar, "BOTTOMRIGHT", -1, PowerArrowYOffset[ndbc.resolution]})
			UF[TARGET_ID].power.arrow.surround.bg:SetTexture(Textures[ndbc.resolution].f1.power.arrow.surround)
			UF[TARGET_ID].power.arrow.surround.bg:SetTexCoord(1, 0, 0, 1)
			
			-- Background
			UF[TARGET_ID].power.arrow.background = CreateArtFrame(UF[TARGET_ID].power.arrow.surround)
			SetFramePosition(UF[TARGET_ID].power.arrow.background, "MEDIUM", UF[TARGET_ID].power:GetFrameLevel(), 64, 32, {"BOTTOM", UF[TARGET_ID].power.arrow.surround, "BOTTOM", 0, 0})
			UF[TARGET_ID].power.arrow.background.bg:SetTexture(Textures[ndbc.resolution].f1.power.arrow.background)
			UF[TARGET_ID].power.arrow.background.bg:SetTexCoord(1, 0, 0, 1)
		
			-- Percent Text
			UF[TARGET_ID].power.arrow.percent = CreateTextFrame(UF[TARGET_ID].power.arrow.surround, "TOP", "LEFT")
			SetFramePosition(UF[TARGET_ID].power.arrow.percent, "MEDIUM", UF[TARGET_ID].power:GetFrameLevel(), 12, 12, {"TOPLEFT", UF[TARGET_ID].power.arrow.surround, "TOPRIGHT", -18, PowerArrowTextYOffset[ndbc.resolution]})
		
	-- In Between
	UF[TARGET_ID].inbetween = CreateArtFrame(UF[TARGET_ID])
	SetFramePosition(UF[TARGET_ID].inbetween, "MEDIUM", UF[TARGET_ID]:GetFrameLevel(), PowerWidth[ndbc.resolution][TARGET_ID] + 2, 1, {"LEFT", UF[TARGET_ID], "LEFT", 0, -1})
	UF[TARGET_ID].inbetween.bg:SetTexture(nibRealUI.media.textures.plain)
	UF[TARGET_ID].inbetween.bg:SetVertexColor(1, 1, 1, 0)
	UF[TARGET_ID].inbetween.wound = false
	UF[TARGET_ID].inbetween.woundend = 0
	UF[TARGET_ID].inbetween.heal = false
	UF[TARGET_ID].inbetween.healend = 0
	UF[TARGET_ID].inbetween.incheal = false
	UF[TARGET_ID].inbetween.elapsed = 0
	UF[TARGET_ID].inbetween.interval = 0.1
	UF[TARGET_ID].inbetween:SetScript("OnUpdate", function(self, elapsed)
		InBetween_OnUpdate(self, elapsed)
	end)
	
	-- End Box
	UF[TARGET_ID].endbox = CreateStatusBox(UF[TARGET_ID])
	SetFramePosition(UF[TARGET_ID].endbox, "MEDIUM", UF[TARGET_ID]:GetFrameLevel(), 16, 32, {"RIGHT", UF[TARGET_ID], "LEFT", -1, 0})
	UF[TARGET_ID].endbox.surround:SetTexture(Textures[ndbc.resolution].f1.endbox.surround)
	UF[TARGET_ID].endbox.surround:SetTexCoord(1, 0, 0, 1)
	UF[TARGET_ID].endbox.background:SetTexture(Textures[ndbc.resolution].f1.endbox.bar)
	UF[TARGET_ID].endbox.background:SetTexCoord(1, 0, 0, 1)
	UF[TARGET_ID].endbox.bar:SetTexture(Textures[ndbc.resolution].f1.endbox.bar)
	UF[TARGET_ID].endbox.bar:SetTexCoord(1, 0, 0, 1)
	UF[TARGET_ID].endbox.bar:SetVertexColor(0, 0, 0, 0)
	
	-- End Box Text
	UF[TARGET_ID].endboxtext = CreateTextFrame(UF[TARGET_ID].endbox, "CENTER", "CENTER")
	SetFramePosition(UF[TARGET_ID].endboxtext, "MEDIUM", UF[TARGET_ID].endbox:GetFrameLevel() + 1, 12, 12, {"CENTER", UF[TARGET_ID].endbox, "CENTER", 4, 0})
	
	-- Range Display
	UF[TARGET_ID].rangedisplay = CreateTextFrame(UF[TARGET_ID].endbox, "BOTTOM", "RIGHT")
	SetFramePosition(UF[TARGET_ID].rangedisplay, "MEDIUM", UF[TARGET_ID]:GetFrameLevel(), 12, 12, {"BOTTOMRIGHT", UF[TARGET_ID].endbox, "BOTTOMLEFT", 4, 12})
	UF[TARGET_ID].rangedisplay.elapsed = 0
	UF[TARGET_ID].rangedisplay.interval = 0.2
	UF[TARGET_ID].rangedisplay.lastmin = -1
	UF[TARGET_ID].rangedisplay.lastmax = -1
	UF[TARGET_ID].rangedisplay:SetScript("OnUpdate", function(self, elapsed)
		UnitFrames:RangeDisplay_OnUpdate(self, elapsed, TARGET_ID)
	end)
	
	-- Status Boxes
	UF[TARGET_ID].statusbox = {}
	for i = 1, 2 do
		UF[TARGET_ID].statusbox[i] = CreateStatusBox(UF[TARGET_ID].power)
		SetFramePosition(UF[TARGET_ID].statusbox[i], "MEDIUM", UF[TARGET_ID].power:GetFrameLevel(), 16, 16, {"BOTTOMLEFT", UF[TARGET_ID].power, "BOTTOMRIGHT", ((i-1)*5+(i)) - (256 - PowerWidthShort[ndbc.resolution][TARGET_ID] - 1), 0})
		UF[TARGET_ID].statusbox[i].surround:SetTexture(Textures[ndbc.resolution].f1.statusbox.surround)
		UF[TARGET_ID].statusbox[i].surround:SetTexCoord(1, 0, 0, 1)
		UF[TARGET_ID].statusbox[i].background:SetTexture(Textures[ndbc.resolution].f1.statusbox.bar)
		UF[TARGET_ID].statusbox[i].background:SetTexCoord(1, 0, 0, 1)
		UF[TARGET_ID].statusbox[i].bar:SetTexture(Textures[ndbc.resolution].f1.statusbox.bar)
		UF[TARGET_ID].statusbox[i].bar:SetTexCoord(1, 0, 0, 1)
		UF[TARGET_ID].statusbox[i].bar:SetVertexColor(0, 0, 0, 0)
	end
	
	-- End Icon
	UF[TARGET_ID].endicon = CreateArtFrame(UF[TARGET_ID])
	UF[TARGET_ID].endicon:Hide()
	SetFramePosition(UF[TARGET_ID].endicon, "MEDIUM", UF[TARGET_ID]:GetFrameLevel(), 24, 24, {"BOTTOMLEFT", UF[TARGET_ID], "TOPRIGHT", -(256 - HealthWidthShort[ndbc.resolution][TARGET_ID]) - 22, (ndbc.resolution == 1) and 16 or 20})
	UF[TARGET_ID].endicon.bg:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
	
	
	---------------
	---- Focus ----
	---------------
	local Parent = _G[ParentFrames[FOCUS_ID]] or UIParent
	UF[FOCUS_ID] = CreateFrame("Frame", ParentFrames[FOCUS_ID].."_Overlay", Parent)
	UF[FOCUS_ID]:Hide()
	SetFramePosition(UF[FOCUS_ID], "MEDIUM", 0, 256, 16, {"BOTTOMRIGHT", Parent, "BOTTOMRIGHT", 0, 0})
	UF[FOCUS_ID].backgroundColorID = ""
	
	-- Health
	UF[FOCUS_ID].health = CreateFrame("Frame", nil, UF[FOCUS_ID])
	UF[FOCUS_ID].health:SetParent(UF[FOCUS_ID])
	SetFramePosition(UF[FOCUS_ID].health, "MEDIUM", UF[FOCUS_ID]:GetFrameLevel(), 256, 16, {"BOTTOMRIGHT", UF[FOCUS_ID], "BOTTOMRIGHT", 0, 0})
	UF[FOCUS_ID].health.colorID = ""
	UF[FOCUS_ID].health.alpha = 1
	UF[FOCUS_ID].health.position = -1
	UF[FOCUS_ID].health.elapsed = 0
	UF[FOCUS_ID].health.interval = 0.2
	UF[FOCUS_ID].health:SetScript("OnUpdate", function(self, elapsed)
		UnitFrames:Health_OnUpdate(self, elapsed, FOCUS_ID)
	end)
	
		-- Surround
		UF[FOCUS_ID].health.surround = CreateArtFrame(UF[FOCUS_ID].health)
		SetFramePosition(UF[FOCUS_ID].health.surround, "MEDIUM", UF[FOCUS_ID].health:GetFrameLevel(), 256, 16, {"BOTTOMRIGHT", UF[FOCUS_ID].health, "BOTTOMRIGHT", 0, 0})
		UF[FOCUS_ID].health.surround.bg:SetTexture(Textures[ndbc.resolution].f2.health.surround)
		
		-- Background
		UF[FOCUS_ID].health.background = CreateArtFrame(UF[FOCUS_ID].health)
		SetFramePosition(UF[FOCUS_ID].health.background, "MEDIUM", UF[FOCUS_ID].health:GetFrameLevel(), 256, 16, {"BOTTOMRIGHT", UF[FOCUS_ID].health, "BOTTOMRIGHT", 0, 0})
		UF[FOCUS_ID].health.background.bg:SetTexture(Textures[ndbc.resolution].f2.health.bar)
		
		-- Bar
		UF[FOCUS_ID].health.bar = CreateArtFrame(UF[FOCUS_ID].health.background)
		UF[FOCUS_ID].health.bar.pos = 0
		UF[FOCUS_ID].health.bar.maxwidth = HealthWidthShort[ndbc.resolution][FOCUS_ID]
		SetFramePosition(UF[FOCUS_ID].health.bar, "MEDIUM", UF[FOCUS_ID].health.background:GetFrameLevel() + 1, 0, (ndbc.resolution == 1) and 7 or 8, {"BOTTOMRIGHT", UF[FOCUS_ID].health.background, "BOTTOMRIGHT", -1, 1})
		UF[FOCUS_ID].health.bar.bg:SetTexture(nibRealUI.media.textures.plain)
		
		-- Bar End
		UF[FOCUS_ID].health.bar.ender = CreateArtFrame(UF[FOCUS_ID].health.background)
		SetFramePosition(UF[FOCUS_ID].health.bar.ender, "MEDIUM", UF[FOCUS_ID].health.bar:GetFrameLevel(), (ndbc.resolution == 1) and 6 or 7, 16, {"BOTTOMRIGHT", UF[FOCUS_ID].health.bar, "BOTTOMLEFT", 0, -1})
		UF[FOCUS_ID].health.bar.ender.bg:SetTexture(Textures[ndbc.resolution].f2.health.bar)
		UF[FOCUS_ID].health.bar.ender.bg:SetTexCoord(unpack(HealthEndBarCoords[ndbc.resolution][FOCUS_ID]))
		UF[FOCUS_ID].health.bar.ender:Hide()
		
		-- HealthBar Text
		UF[FOCUS_ID].healthtext = CreateTextFrame(UF[FOCUS_ID].health, "BOTTOM", "RIGHT")
		SetFramePosition(UF[FOCUS_ID].healthtext, "MEDIUM", UF[FOCUS_ID].health:GetFrameLevel() + 2, 12, 12, {"BOTTOMRIGHT", UF[FOCUS_ID].health, "BOTTOMRIGHT", -4, 0})
		
		-- Health Text
		UF[FOCUS_ID].health.fullval = CreateTextFrame(UF[FOCUS_ID].health, "BOTTOM", "LEFT")
		SetFramePosition(UF[FOCUS_ID].health.fullval, "MEDIUM", UF[FOCUS_ID].health:GetFrameLevel() + 2, 12, 12, {"BOTTOMLEFT", UF[FOCUS_ID].health, "BOTTOMLEFT", 256 - HealthWidthShort[ndbc.resolution][FOCUS_ID], 0})
		
	-- End Box
	UF[FOCUS_ID].endbox = CreateStatusBox(UF[FOCUS_ID])
	SetFramePosition(UF[FOCUS_ID].endbox, "MEDIUM", UF[FOCUS_ID]:GetFrameLevel(), 16, 16, {"LEFT", UF[FOCUS_ID], "RIGHT", 1, 0})
	UF[FOCUS_ID].endbox.surround:SetTexture(Textures[ndbc.resolution].f2.endbox.surround)
	UF[FOCUS_ID].endbox.background:SetTexture(Textures[ndbc.resolution].f2.endbox.bar)
	UF[FOCUS_ID].endbox.bar:SetTexture(Textures[ndbc.resolution].f2.endbox.bar)
	UF[FOCUS_ID].endbox.bar:SetVertexColor(0, 0, 0, 0)
	
	-- End Box Text
	UF[FOCUS_ID].endboxtext = CreateTextFrame(UF[FOCUS_ID].endbox, "CENTER", "CENTER")
	SetFramePosition(UF[FOCUS_ID].endboxtext, "MEDIUM", UF[FOCUS_ID].endbox:GetFrameLevel() + 1, 12, 12, {"CENTER", UF[FOCUS_ID].endbox, "CENTER", -2, -4})
	
	-- Range Display
	UF[FOCUS_ID].rangedisplay = CreateTextFrame(UF[FOCUS_ID].endbox, "BOTTOM", "LEFT")
	SetFramePosition(UF[FOCUS_ID].rangedisplay, "MEDIUM", UF[FOCUS_ID]:GetFrameLevel(), 12, 12, {"BOTTOMLEFT", UF[FOCUS_ID].endbox, "BOTTOMRIGHT", -2, 0})
	UF[FOCUS_ID].rangedisplay.elapsed = 0
	UF[FOCUS_ID].rangedisplay.interval = 0.2
	UF[FOCUS_ID].rangedisplay.lastmin = -1
	UF[FOCUS_ID].rangedisplay.lastmax = -1
	UF[FOCUS_ID].rangedisplay:SetScript("OnUpdate", function(self, elapsed)
		UnitFrames:RangeDisplay_OnUpdate(self, elapsed, FOCUS_ID)
	end)
	
	-- Status Boxes
	UF[FOCUS_ID].statusbox = {}
	for i = 1, 2 do
		UF[FOCUS_ID].statusbox[i] = CreateStatusBox(UF[FOCUS_ID].health)
		SetFramePosition(UF[FOCUS_ID].statusbox[i], "MEDIUM", UF[FOCUS_ID].health:GetFrameLevel(), 16, 16, {"BOTTOMRIGHT", UF[FOCUS_ID].health, "BOTTOMLEFT", -((i-1)*5+(i)) + (256 - HealthWidthShort[ndbc.resolution][FOCUS_ID] - 1), (ndbc.resolution == 1) and -7 or -6})
		UF[FOCUS_ID].statusbox[i].surround:SetTexture(Textures[ndbc.resolution].f1.statusbox.surround)
		UF[FOCUS_ID].statusbox[i].background:SetTexture(Textures[ndbc.resolution].f1.statusbox.bar)
		UF[FOCUS_ID].statusbox[i].bar:SetTexture(Textures[ndbc.resolution].f1.statusbox.bar)
		UF[FOCUS_ID].statusbox[i].bar:SetVertexColor(0, 0, 0, 0)
	end
	
	-- End Icon
	UF[FOCUS_ID].endicon = CreateArtFrame(UF[FOCUS_ID])
	UF[FOCUS_ID].endicon:Hide()
	SetFramePosition(UF[FOCUS_ID].endicon, "MEDIUM", UF[FOCUS_ID]:GetFrameLevel(), 12, 12, {"BOTTOMLEFT", UF[FOCUS_ID], "TOPLEFT", (256 - HealthWidthShort[ndbc.resolution][FOCUS_ID]) - 9, -4})
	UF[FOCUS_ID].endicon.bg:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
	
	
	----------------------
	---- Focus Target ----
	----------------------
	local Parent = _G[ParentFrames[FOCUSTARGET_ID]] or UIParent
	UF[FOCUSTARGET_ID] = CreateFrame("Frame", ParentFrames[FOCUSTARGET_ID].."_Overlay", Parent)
	UF[FOCUSTARGET_ID]:Hide()
	SetFramePosition(UF[FOCUSTARGET_ID], "MEDIUM", 0, 256, 16, {"BOTTOMRIGHT", Parent, "BOTTOMRIGHT", 0, (ndbc.resolution == 1) and 0 or -1})
	UF[FOCUSTARGET_ID].backgroundColorID = ""
	
	-- Health
	UF[FOCUSTARGET_ID].health = CreateFrame("Frame", nil, UF[FOCUSTARGET_ID])
	UF[FOCUSTARGET_ID].health:SetParent(UF[FOCUSTARGET_ID])
	SetFramePosition(UF[FOCUSTARGET_ID].health, "MEDIUM", UF[FOCUSTARGET_ID]:GetFrameLevel(), 256, 16, {"BOTTOMRIGHT", UF[FOCUSTARGET_ID], "BOTTOMRIGHT", 0, 0})
	UF[FOCUSTARGET_ID].health.colorID = ""
	UF[FOCUSTARGET_ID].health.alpha = 1
	UF[FOCUSTARGET_ID].health.position = -1
	UF[FOCUSTARGET_ID].health.elapsed = 0
	UF[FOCUSTARGET_ID].health.interval = 0.2
	UF[FOCUSTARGET_ID].health:SetScript("OnUpdate", function(self, elapsed)
		UnitFrames:Health_OnUpdate(self, elapsed, FOCUSTARGET_ID)
	end)
	
		-- Surround
		UF[FOCUSTARGET_ID].health.surround = CreateArtFrame(UF[FOCUSTARGET_ID].health)
		SetFramePosition(UF[FOCUSTARGET_ID].health.surround, "MEDIUM", UF[FOCUSTARGET_ID].health:GetFrameLevel(), 256, 16, {"BOTTOMRIGHT", UF[FOCUSTARGET_ID].health, "BOTTOMRIGHT", 0, 0})
		UF[FOCUSTARGET_ID].health.surround.bg:SetTexture(Textures[ndbc.resolution].f3.health.surround)
		
		-- Background
		UF[FOCUSTARGET_ID].health.background = CreateArtFrame(UF[FOCUSTARGET_ID].health)
		SetFramePosition(UF[FOCUSTARGET_ID].health.background, "MEDIUM", UF[FOCUSTARGET_ID].health:GetFrameLevel(), 256, 16, {"BOTTOMRIGHT", UF[FOCUSTARGET_ID].health, "BOTTOMRIGHT", 0, 0})
		UF[FOCUSTARGET_ID].health.background.bg:SetTexture(Textures[ndbc.resolution].f3.health.bar)
		
		-- Bar
		UF[FOCUSTARGET_ID].health.bar = CreateArtFrame(UF[FOCUSTARGET_ID].health.background)
		UF[FOCUSTARGET_ID].health.bar.pos = 0
		UF[FOCUSTARGET_ID].health.bar.maxwidth = HealthWidthShort[ndbc.resolution][FOCUSTARGET_ID]
		SetFramePosition(UF[FOCUSTARGET_ID].health.bar, "MEDIUM", UF[FOCUSTARGET_ID].health.background:GetFrameLevel() + 1, 0, (ndbc.resolution == 1) and 7 or 8, {"BOTTOMRIGHT", UF[FOCUSTARGET_ID].health.background, "BOTTOMRIGHT", -1, 1})
		UF[FOCUSTARGET_ID].health.bar.bg:SetTexture(nibRealUI.media.textures.plain)
		
		-- Bar End
		UF[FOCUSTARGET_ID].health.bar.ender = CreateArtFrame(UF[FOCUSTARGET_ID].health.background)
		SetFramePosition(UF[FOCUSTARGET_ID].health.bar.ender, "MEDIUM", UF[FOCUSTARGET_ID].health.bar:GetFrameLevel(), (ndbc.resolution == 1) and 6 or 7, 16, {"BOTTOMRIGHT", UF[FOCUSTARGET_ID].health.bar, "BOTTOMLEFT", 0, -1})
		UF[FOCUSTARGET_ID].health.bar.ender.bg:SetTexture(Textures[ndbc.resolution].f3.health.bar)
		UF[FOCUSTARGET_ID].health.bar.ender.bg:SetTexCoord(unpack(HealthEndBarCoords[ndbc.resolution][FOCUSTARGET_ID]))
		UF[FOCUSTARGET_ID].health.bar.ender:Hide()
		
		-- HealthBar Text
		UF[FOCUSTARGET_ID].healthtext = CreateTextFrame(UF[FOCUSTARGET_ID].health, "BOTTOM", "RIGHT")
		SetFramePosition(UF[FOCUSTARGET_ID].healthtext, "MEDIUM", UF[FOCUSTARGET_ID].health:GetFrameLevel() + 2, 12, 12, {"BOTTOMRIGHT", UF[FOCUSTARGET_ID].health, "BOTTOMRIGHT", -4, 0})
		
		-- Health Text
		UF[FOCUSTARGET_ID].health.fullval = CreateTextFrame(UF[FOCUSTARGET_ID].health, "BOTTOM", "LEFT")
		SetFramePosition(UF[FOCUSTARGET_ID].health.fullval, "MEDIUM", UF[FOCUSTARGET_ID].health:GetFrameLevel() + 2, 12, 12, {"BOTTOMLEFT", UF[FOCUSTARGET_ID].health, "BOTTOMLEFT", 256 - HealthWidthShort[ndbc.resolution][FOCUSTARGET_ID], 0})
		
	-- End Box
	UF[FOCUSTARGET_ID].endbox = CreateStatusBox(UF[FOCUSTARGET_ID])
	SetFramePosition(UF[FOCUSTARGET_ID].endbox, "MEDIUM", UF[FOCUSTARGET_ID]:GetFrameLevel(), 16, 16, {"LEFT", UF[FOCUSTARGET_ID], "RIGHT", 1, 0})
	UF[FOCUSTARGET_ID].endbox.surround:SetTexture(Textures[ndbc.resolution].f2.endbox.surround)
	UF[FOCUSTARGET_ID].endbox.background:SetTexture(Textures[ndbc.resolution].f2.endbox.bar)
	UF[FOCUSTARGET_ID].endbox.bar:SetTexture(Textures[ndbc.resolution].f2.endbox.bar)
	UF[FOCUSTARGET_ID].endbox.bar:SetVertexColor(0, 0, 0, 0)
	
	-- End Box Text
	UF[FOCUSTARGET_ID].endboxtext = CreateTextFrame(UF[FOCUSTARGET_ID].endbox, "CENTER", "CENTER")
	SetFramePosition(UF[FOCUSTARGET_ID].endboxtext, "MEDIUM", UF[FOCUSTARGET_ID].endbox:GetFrameLevel() + 1, 12, 12, {"CENTER", UF[FOCUSTARGET_ID].endbox, "CENTER", -2, -4})
	
	-- Range Display
	UF[FOCUSTARGET_ID].rangedisplay = CreateTextFrame(UF[FOCUSTARGET_ID].endbox, "BOTTOM", "LEFT")
	SetFramePosition(UF[FOCUSTARGET_ID].rangedisplay, "MEDIUM", UF[FOCUSTARGET_ID]:GetFrameLevel(), 12, 12, {"BOTTOMLEFT", UF[FOCUSTARGET_ID].endbox, "BOTTOMRIGHT", -2, 0})
	UF[FOCUSTARGET_ID].rangedisplay.elapsed = 0
	UF[FOCUSTARGET_ID].rangedisplay.interval = 0.2
	UF[FOCUSTARGET_ID].rangedisplay.lastmin = -1
	UF[FOCUSTARGET_ID].rangedisplay.lastmax = -1
	UF[FOCUSTARGET_ID].rangedisplay:SetScript("OnUpdate", function(self, elapsed)
		UnitFrames:RangeDisplay_OnUpdate(self, elapsed, FOCUSTARGET_ID)
	end)
	
	-- Status Boxes
	UF[FOCUSTARGET_ID].statusbox = {}
	for i = 1, 2 do
		UF[FOCUSTARGET_ID].statusbox[i] = CreateStatusBox(UF[FOCUSTARGET_ID].health)
		SetFramePosition(UF[FOCUSTARGET_ID].statusbox[i], "MEDIUM", UF[FOCUSTARGET_ID].health:GetFrameLevel(), 16, 16, {"BOTTOMRIGHT", UF[FOCUSTARGET_ID].health, "BOTTOMLEFT", -((i-1)*5+(i)) + (256 - HealthWidthShort[ndbc.resolution][FOCUSTARGET_ID] - 1), (ndbc.resolution == 1) and -7 or -6})
		UF[FOCUSTARGET_ID].statusbox[i].surround:SetTexture(Textures[ndbc.resolution].f1.statusbox.surround)
		UF[FOCUSTARGET_ID].statusbox[i].background:SetTexture(Textures[ndbc.resolution].f1.statusbox.bar)
		UF[FOCUSTARGET_ID].statusbox[i].bar:SetTexture(Textures[ndbc.resolution].f1.statusbox.bar)
		UF[FOCUSTARGET_ID].statusbox[i].bar:SetVertexColor(0, 0, 0, 0)
	end
	
	-- End Icon
	UF[FOCUSTARGET_ID].endicon = CreateArtFrame(UF[FOCUSTARGET_ID])
	UF[FOCUSTARGET_ID].endicon:Hide()
	SetFramePosition(UF[FOCUSTARGET_ID].endicon, "MEDIUM", UF[FOCUSTARGET_ID]:GetFrameLevel(), 12, 12, {"TOPLEFT", UF[FOCUSTARGET_ID], "BOTTOMLEFT", (256 - HealthWidthShort[ndbc.resolution][FOCUSTARGET_ID]) - 1, -3})
	UF[FOCUSTARGET_ID].endicon.bg:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
	
	
	----------------------
	---- TargetTarget ----
	----------------------
	local Parent = _G[ParentFrames[TARGETTARGET_ID]] or UIParent
	UF[TARGETTARGET_ID] = CreateFrame("Frame", ParentFrames[TARGETTARGET_ID].."_Overlay", Parent)
	UF[TARGETTARGET_ID]:Hide()
	SetFramePosition(UF[TARGETTARGET_ID], "MEDIUM", 0, 256, 16, {"BOTTOMLEFT", Parent, "BOTTOMLEFT", 0, 0})
	UF[TARGETTARGET_ID].backgroundColorID = ""
	
	-- Health
	UF[TARGETTARGET_ID].health = CreateFrame("Frame", nil, UF[TARGETTARGET_ID])
	UF[TARGETTARGET_ID].health:SetParent(UF[TARGETTARGET_ID])
	SetFramePosition(UF[TARGETTARGET_ID].health, "MEDIUM", UF[TARGETTARGET_ID]:GetFrameLevel(), 256, 16, {"BOTTOMLEFT", UF[TARGETTARGET_ID], "BOTTOMLEFT", 0, 0})
	UF[TARGETTARGET_ID].health.colorID = ""
	UF[TARGETTARGET_ID].health.alpha = 1
	UF[TARGETTARGET_ID].health.position = -1
	UF[TARGETTARGET_ID].health.elapsed = 0
	UF[TARGETTARGET_ID].health.interval = 0.2
	UF[TARGETTARGET_ID].health:SetScript("OnUpdate", function(self, elapsed)
		UnitFrames:Health_OnUpdate(self, elapsed, TARGETTARGET_ID)
	end)
	
		-- Surround
		UF[TARGETTARGET_ID].health.surround = CreateArtFrame(UF[TARGETTARGET_ID].health)
		SetFramePosition(UF[TARGETTARGET_ID].health.surround, "MEDIUM", UF[TARGETTARGET_ID].health:GetFrameLevel(), 256, 16, {"BOTTOMLEFT", UF[TARGETTARGET_ID].health, "BOTTOMLEFT", 0, 0})
		UF[TARGETTARGET_ID].health.surround.bg:SetTexture(Textures[ndbc.resolution].f2.health.surround)
		UF[TARGETTARGET_ID].health.surround.bg:SetTexCoord(1, 0, 0, 1)
		
		-- Background
		UF[TARGETTARGET_ID].health.background = CreateArtFrame(UF[TARGETTARGET_ID].health)
		SetFramePosition(UF[TARGETTARGET_ID].health.background, "MEDIUM", UF[TARGETTARGET_ID].health:GetFrameLevel(), 256, 16, {"BOTTOMLEFT", UF[TARGETTARGET_ID].health, "BOTTOMLEFT", 0, 0})
		UF[TARGETTARGET_ID].health.background.bg:SetTexture(Textures[ndbc.resolution].f2.health.bar)
		UF[TARGETTARGET_ID].health.background.bg:SetTexCoord(1, 0, 0, 1)
		
		-- Bar
		UF[TARGETTARGET_ID].health.bar = CreateArtFrame(UF[TARGETTARGET_ID].health.background)
		UF[TARGETTARGET_ID].health.bar.pos = 0
		UF[TARGETTARGET_ID].health.bar.maxwidth = HealthWidthShort[ndbc.resolution][TARGETTARGET_ID]
		SetFramePosition(UF[TARGETTARGET_ID].health.bar, "MEDIUM", UF[TARGETTARGET_ID].health.background:GetFrameLevel() + 1, 0, (ndbc.resolution == 1) and 7 or 8, {"BOTTOMLEFT", UF[TARGETTARGET_ID].health.background, "BOTTOMLEFT", 1, 1})
		UF[TARGETTARGET_ID].health.bar.bg:SetTexture(nibRealUI.media.textures.plain)
		
		-- Bar End
		UF[TARGETTARGET_ID].health.bar.ender = CreateArtFrame(UF[TARGETTARGET_ID].health.background)
		SetFramePosition(UF[TARGETTARGET_ID].health.bar.ender, "MEDIUM", UF[TARGETTARGET_ID].health.bar:GetFrameLevel(), (ndbc.resolution == 1) and 6 or 7, 16, {"BOTTOMLEFT", UF[TARGETTARGET_ID].health.bar, "BOTTOMRIGHT", 0, -1})
		UF[TARGETTARGET_ID].health.bar.ender.bg:SetTexture(Textures[ndbc.resolution].f2.health.bar)
		UF[TARGETTARGET_ID].health.bar.ender.bg:SetTexCoord(unpack(HealthEndBarCoords[ndbc.resolution][TARGETTARGET_ID]))
		UF[TARGETTARGET_ID].health.bar.ender:Hide()
		
		-- HealthBar Text
		UF[TARGETTARGET_ID].healthtext = CreateTextFrame(UF[TARGETTARGET_ID].health, "BOTTOM", "LEFT")
		SetFramePosition(UF[TARGETTARGET_ID].healthtext, "MEDIUM", UF[TARGETTARGET_ID].health:GetFrameLevel() + 2, 12, 12, {"BOTTOMLEFT", UF[TARGETTARGET_ID].health, "BOTTOMLEFT", 6, 0})
		
		-- Health Text
		UF[TARGETTARGET_ID].health.fullval = CreateTextFrame(UF[TARGETTARGET_ID].health, "BOTTOM", "RIGHT")
		SetFramePosition(UF[TARGETTARGET_ID].health.fullval, "MEDIUM", UF[TARGETTARGET_ID].health:GetFrameLevel() + 2, 12, 12, {"BOTTOMRIGHT", UF[TARGETTARGET_ID].health, "BOTTOMRIGHT", -(256 - HealthWidthShort[ndbc.resolution][TARGETTARGET_ID]) + 2, 0})
		
	-- End Box
	UF[TARGETTARGET_ID].endbox = CreateStatusBox(UF[TARGETTARGET_ID])
	SetFramePosition(UF[TARGETTARGET_ID].endbox, "MEDIUM", UF[TARGETTARGET_ID]:GetFrameLevel(), 16, 16, {"RIGHT", UF[TARGETTARGET_ID], "LEFT", -1, 0})
	UF[TARGETTARGET_ID].endbox.surround:SetTexture(Textures[ndbc.resolution].f2.endbox.surround)
	UF[TARGETTARGET_ID].endbox.surround:SetTexCoord(1, 0, 0, 1)
	UF[TARGETTARGET_ID].endbox.background:SetTexture(Textures[ndbc.resolution].f2.endbox.bar)
	UF[TARGETTARGET_ID].endbox.background:SetTexCoord(1, 0, 0, 1)
	UF[TARGETTARGET_ID].endbox.bar:SetTexture(Textures[ndbc.resolution].f2.endbox.bar)
	UF[TARGETTARGET_ID].endbox.bar:SetTexCoord(1, 0, 0, 1)
	UF[TARGETTARGET_ID].endbox.bar:SetVertexColor(0, 0, 0, 0)
	
	-- End Box Text
	UF[TARGETTARGET_ID].endboxtext = CreateTextFrame(UF[TARGETTARGET_ID].endbox, "CENTER", "CENTER")
	SetFramePosition(UF[TARGETTARGET_ID].endboxtext, "MEDIUM", UF[TARGETTARGET_ID].endbox:GetFrameLevel() + 1, 12, 12, {"CENTER", UF[TARGETTARGET_ID].endbox, "CENTER", 4, -4})
	
	-- Range Display
	UF[TARGETTARGET_ID].rangedisplay = CreateTextFrame(UF[TARGETTARGET_ID].endbox, "BOTTOM", "RIGHT")
	SetFramePosition(UF[TARGETTARGET_ID].rangedisplay, "MEDIUM", UF[TARGETTARGET_ID]:GetFrameLevel(), 12, 12, {"BOTTOMRIGHT", UF[TARGETTARGET_ID].endbox, "BOTTOMLEFT", 4, 0})
	UF[TARGETTARGET_ID].rangedisplay.elapsed = 0
	UF[TARGETTARGET_ID].rangedisplay.interval = 0.2
	UF[TARGETTARGET_ID].rangedisplay.lastmin = -1
	UF[TARGETTARGET_ID].rangedisplay.lastmax = -1
	UF[TARGETTARGET_ID].rangedisplay:SetScript("OnUpdate", function(self, elapsed)
		UnitFrames:RangeDisplay_OnUpdate(self, elapsed, TARGETTARGET_ID)
	end)
	
	-- Status Boxes
	UF[TARGETTARGET_ID].statusbox = {}
	for i = 1, 2 do
		UF[TARGETTARGET_ID].statusbox[i] = CreateStatusBox(UF[TARGETTARGET_ID].health)
		SetFramePosition(UF[TARGETTARGET_ID].statusbox[i], "MEDIUM", UF[TARGETTARGET_ID].health:GetFrameLevel(), 16, 16, {"BOTTOMLEFT", UF[TARGETTARGET_ID].health, "BOTTOMRIGHT", ((i-1)*5+(i)) - (256 - HealthWidthShort[ndbc.resolution][TARGETTARGET_ID] - 1), (ndbc.resolution == 1) and -7 or -6})
		UF[TARGETTARGET_ID].statusbox[i].surround:SetTexture(Textures[ndbc.resolution].f1.statusbox.surround)
		UF[TARGETTARGET_ID].statusbox[i].surround:SetTexCoord(1, 0, 0, 1)
		UF[TARGETTARGET_ID].statusbox[i].background:SetTexture(Textures[ndbc.resolution].f1.statusbox.bar)
		UF[TARGETTARGET_ID].statusbox[i].background:SetTexCoord(1, 0, 0, 1)
		UF[TARGETTARGET_ID].statusbox[i].bar:SetTexture(Textures[ndbc.resolution].f1.statusbox.bar)
		UF[TARGETTARGET_ID].statusbox[i].bar:SetTexCoord(1, 0, 0, 1)
		UF[TARGETTARGET_ID].statusbox[i].bar:SetVertexColor(0, 0, 0, 0)
	end
	
	-- End Icon
	UF[TARGETTARGET_ID].endicon = CreateArtFrame(UF[TARGETTARGET_ID])
	UF[TARGETTARGET_ID].endicon:Hide()
	SetFramePosition(UF[TARGETTARGET_ID].endicon, "MEDIUM", UF[TARGETTARGET_ID]:GetFrameLevel(), 12, 12, {"BOTTOMRIGHT", UF[TARGETTARGET_ID], "TOPRIGHT", -(256 - HealthWidthShort[ndbc.resolution][TARGETTARGET_ID]) + 9, -4})
	UF[TARGETTARGET_ID].endicon.bg:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
end

---- EVENTS ----
-- End Icon
function UnitFrames:EndIconEvent()
	self:UpdateEndIcons()
end

-- Death Event
function UnitFrames:PlayerDeathEvent()
	self:UpdateUnitHealthBarInfo(PLAYER_ID)
	self:UpdateUnitPowerBarInfo(PLAYER_ID)
	self:UpdateEndIcons()
end

-- Classification Event
function UnitFrames:ClassificationEvent(event, UnitID)
	if not UF[UnitID] then return end
	self:UpdateUnitInfo(UnitID)
end

-- Status Event
local SEOtherUnitsTimer = CreateFrame("Frame")
SEOtherUnitsTimer:Hide()
SEOtherUnitsTimer.e = 0
SEOtherUnitsTimer.i = 0.25
SEOtherUnitsTimer.updateHealthInfo = false
SEOtherUnitsTimer:SetScript("OnUpdate", function(s, e)
	s.e = s.e + e
	if s.e >= s.i then
		UnitFrames:UpdateStatus(TARGETTARGET_ID)
		UnitFrames:UpdateUnitBackgroundColor(TARGETTARGET_ID)
		UnitFrames:UpdateStatus(FOCUSTARGET_ID)
		UnitFrames:UpdateUnitBackgroundColor(FOCUSTARGET_ID)
		if s.updateHealthInfo then
			UnitFrames:UpdateUnitHealthBarInfo(TARGETTARGET_ID, true)
			UnitFrames:UpdateUnitHealthBarInfo(FOCUSTARGET_ID, true)
		end
		s.e = 0
		s:Hide()
	end
end)
function UnitFrames:StatusEvent(event, ...)
	local UnitID = ... or PLAYER_ID
	if UF[UnitID] then
		-- Update Status of unit
		self:UpdateStatus(UnitID)
		self:UpdateUnitBackgroundColor(UnitID)
		self:UpdateUnitInfo(UnitID)
		-- Target/Focus hostility change
		if (event == "UNIT_FACTION") then
			self:UpdateUnitHealthBarInfo(UnitID, true)
			SEOtherUnitsTimer.updateHealthInfo = true
		end
		-- Update Other units
		SEOtherUnitsTimer:Show()
	end
end

-- Combat Event
local ceEvent, ceAIH, ceMIH
function UnitFrames:CombatEvent(event, ...)
	local UnitID = ...
	if not((UnitID == PLAYER_ID) or (UnitID == TARGET_ID) or (UnitID == VEHICLE_ID)) then return end
	
	local Unit, UFUnit = PlayerOrVehicleIDs(UnitID)
	if not(UnitExists(Unit)) then return end
	
	if (event == "UNIT_COMBAT") then
		local _, ceEvent = ...
		if ((ceEvent == "WOUND") or (ceEvent == "HEAL")) then
			self:SetInBetween(UFUnit, ceEvent)
		end
	elseif (event == "UNIT_HEAL_PREDICTION") then
		local ceMIH = UnitGetIncomingHeals(Unit, PLAYER_ID) or 0
		local ceAIH = UnitGetIncomingHeals(Unit) or 0
		
		if (ceAIH < ceMIH) then
			ceAIH = 0
		else
			ceAIH = ceAIH - ceMIH
		end
		
		if (ceAIH >= (UnitHealthVal[Unit] * 0.05)) then
			self:SetInBetween(UFUnit, "INCHEAL")
		else
			self:SetInBetween(UFUnit, "NOINCHEAL")
		end
	end
end

-- Power
function UnitFrames:PowerUpdateMajor(event, UnitID)
	if not((UnitID == PLAYER_ID) or (UnitID == TARGET_ID) or (UnitID == VEHICLE_ID)) then return end
	
	self:ToggleUnitPower(UnitID)
	self:UpdateUnitPowerBarInfo(UnitID)
end

-- Health
function UnitFrames:HealthUpdate(event, UnitID)
	self:UpdateUnitHealth(UnitID, true)
end

-- Unit Target
function UnitFrames:UnitTargetUpdate(event, UnitID)
	if (UnitID == PLAYER_ID) then return end
	
	local UnitTargetID = UnitID.."target"
	if not UF[UnitTargetID] then return end
	
	if UnitExists(UnitTargetID) then
		if not UF[UnitTargetID]:IsVisible() then UF[UnitTargetID]:Show() end
		self:UpdateUnitHealthBarInfo(UnitTargetID)
		self:UpdateUnitHealth(UnitTargetID, true)
		self:UpdateEndBox(UnitTargetID)
		self:UpdateStatus(UnitTargetID)
		self:UpdateUnitBackgroundColor(UnitTargetID)
		self:UpdateUnitInfo(UnitTargetID)
		self:UpdateUnitRange(UnitTargetID)
		self:UpdateEndIcons()
	else
		if UF[UnitTargetID]:IsVisible() then UF[UnitTargetID]:Hide() end
	end
end

-- Focus
function UnitFrames:FocusUpdate()
	if UnitExists(FOCUS_ID) then
		if not UF[FOCUS_ID]:IsVisible() then UF[FOCUS_ID]:Show() end
		self:UpdateUnitHealthBarInfo(FOCUS_ID)
		self:UpdateUnitHealth(FOCUS_ID, true)
		self:UpdateEndBox(FOCUS_ID)
		self:UpdateStatus(FOCUS_ID)
		self:UpdateUnitBackgroundColor(FOCUS_ID)
		self:UpdateUnitInfo(FOCUS_ID)
		self:UpdateUnitRange(FOCUS_ID)
		self:UpdateEndIcons()
		self:UnitTargetUpdate("fu", FOCUS_ID)
	else
		if UF[FOCUS_ID]:IsVisible() then UF[FOCUS_ID]:Hide() end
	end
end

-- Vehicle
function UnitFrames:VehicleEvent()
	-- Vehicle flag
	SetPlayerVehicleFlag()
	
	-- Update
	self:UpdatePetStatus()
	self:UpdateEndBox(PLAYER_ID)
	self:SetInBetween(PLAYER_ID, "NONE")
	self:ToggleUnitPower(VEHICLE_ID)
	self:UpdateUnitPowerBarInfo(VEHICLE_ID)
	self:UpdateUnitPower(VEHICLE_ID, true)
	self:UpdateUnitHealthBarInfo(VEHICLE_ID)
	self:UpdateUnitHealth(VEHICLE_ID, true)
	self:UpdateUnitBackgroundColor(VEHICLE_ID)
	self:UpdateEndIcons()
end

-- Pet
function UnitFrames:PetEvent()
	self:UpdatePetStatus()
	self:UpdateEndBox(PLAYER_ID)
	self:UpdateUnitHealth(PET_ID, true) 
	self:UpdateUnitPower(PET_ID, true)
	self:UpdateUnitRange(PET_ID)
end

-- Player Target
function UnitFrames:PlayerTargetUpdate()
	if UnitExists(TARGET_ID) then
		if not UF[TARGET_ID]:IsVisible() then UF[TARGET_ID]:Show() end
		self:ToggleUnitPower(TARGET_ID)
		self:UpdateUnitPowerBarInfo(TARGET_ID)
		self:UpdateUnitPower(TARGET_ID, true)
		self:UpdateUnitHealthBarInfo(TARGET_ID)
		self:UpdateUnitHealth(TARGET_ID, true)
		self:UpdateEndBox(TARGET_ID)
		self:UpdateStatus(TARGET_ID)
		self:UpdateUnitBackgroundColor(TARGET_ID)
		self:UpdateUnitInfo(TARGET_ID)
		self:UpdateUnitRange(TARGET_ID)
		self:SetInBetween(TARGET_ID, "NONE")
		self:UpdateEndIcons()
	else
		if UF[TARGET_ID]:IsVisible() then UF[TARGET_ID]:Hide() end
		SetBarValue(UF[TARGET_ID].health.bar, 1)
		SetBarValue(UF[TARGET_ID].power.bar, 1)
	end
	self:UnitTargetUpdate("ptu", FOCUS_ID)	-- Update FocusTarget
	self:UnitTargetUpdate("ptu", TARGET_ID)	-- Update TargetTarget
end

-- Entering World
function UnitFrames:PLAYER_ENTERING_WORLD()
	self:RefreshUnits()
end

---- INITIALIZATION ----
function UnitFrames:Refresh()
	-- Update Unit Frames
	self:UpdateTextures()
	self:UpdateFonts()
	self:RefreshUnits()
end

local function ClassColorsUpdate()
	for k,v in pairs(UF) do
		UnitFrames:UpdateUnitHealthBarInfo(k)
		UnitFrames:UpdateEndBox(k)
	end
end

function UnitFrames:InitializeOverlay()
	---- Player info
	PlayerStepPoints = db.misc.steppoints[nibRealUI.class] or db.misc.steppoints["default"]
	GetPowerColors()
	
	UnitFrames:CreateFrames()
	UnitFrames:Refresh()
	
	---- Events
	UnitFrames:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	-- Target update 
	UnitFrames:RegisterEvent("PLAYER_TARGET_CHANGED", "PlayerTargetUpdate")
	UnitFrames:RegisterEvent("UNIT_TARGET", "UnitTargetUpdate")
	
	-- Focus update
	UnitFrames:RegisterEvent("PLAYER_FOCUS_CHANGED", "FocusUpdate")
	
	-- Health update
	UnitFrames:RegisterEvent("UNIT_MAXHEALTH", "HealthUpdate")
	
	-- Power update
	UnitFrames:RegisterEvent("UNIT_MAXPOWER", "PowerUpdateMajor")
	UnitFrames:RegisterEvent("UNIT_DISPLAYPOWER", "PowerUpdateMajor")
	
	-- Pet update 
	UnitFrames:RegisterEvent("UNIT_PET", "PetEvent")
	
	-- Vehicle update
	UnitFrames:RegisterEvent("UNIT_ENTERED_VEHICLE", "VehicleEvent")
	UnitFrames:RegisterEvent("UNIT_EXITED_VEHICLE", "VehicleEvent")
	
	-- Combat Event
	UnitFrames:RegisterEvent("UNIT_COMBAT", "CombatEvent")
	UnitFrames:RegisterEvent("UNIT_HEAL_PREDICTION", "CombatEvent")
	
	-- Status
	UnitFrames:RegisterEvent("PLAYER_FLAGS_CHANGED", "StatusEvent")
	UnitFrames:RegisterEvent("UNIT_FLAGS", "StatusEvent")
	UnitFrames:RegisterEvent("UPDATE_FACTION", "StatusEvent")
	UnitFrames:RegisterEvent("UNIT_FACTION", "StatusEvent")
	
	-- Classification
	UnitFrames:RegisterEvent("UNIT_CLASSIFICATION_CHANGED", "ClassificationEvent")
	
	-- Death
	UnitFrames:RegisterEvent("PLAYER_DEAD", "PlayerDeathEvent")
	UnitFrames:RegisterEvent("PLAYER_UNGHOST", "PlayerDeathEvent")
	UnitFrames:RegisterEvent("PLAYER_ALIVE", "PlayerDeathEvent")
	
	-- End Icon
	UnitFrames:RegisterEvent("RAID_TARGET_UPDATE", "EndIconEvent")
	UnitFrames:RegisterEvent("INCOMING_RESURRECT_CHANGED", "EndIconEvent")
	
	-- UnitFrames:SetScript("OnEvent", OverlayEvent)
	
	---- ClassColors support
	if CUSTOM_CLASS_COLORS then
		CUSTOM_CLASS_COLORS:RegisterCallback(ClassColorsUpdate)
	end
	
	---- Combat Fader
	local CF = nibRealUI:GetModule("CombatFader", true)
	if CF then CF:FadeFrames() end
end


--------------------
------ Layout ------
--------------------

-- Unit Frames Sizes
local unit_sizes = {
	[1] = {
		player = 		{width = 224, height = 22},
		pet = 			{width = 10, height = 22},
		focus = 		{width = 158, height = 10},
		focustarget = 	{width = 148, height = 10},
		target = 		{width = 224, height = 22},
		targettarget = 	{width = 158, height = 10},
		tank = 			{width = 158, height = 10},
	},
	[2] = {
		player = 		{width = 244, height = 22},
		pet = 			{width = 11, height = 22},
		focus = 		{width = 168, height = 10},
		focustarget = 	{width = 158, height = 10},
		target = 		{width = 244, height = 22},
		targettarget = 	{width = 168, height = 10},
		tank = 			{width = 168, height = 10},
	},
}

-- Mouse Event
local OnEnter = function(self)
	UnitFrame_OnEnter(self)
end

local OnLeave = function(self)
	UnitFrame_OnLeave(self)
end

-- Dropdown Menu
local dropdown = CreateFrame('Frame', 'RealUIUnitFramesDropDown', UIParent, 'UIDropDownMenuTemplate')

-- local function DisplayPetDismissPopUp()
	-- StaticPopupDialogs["RUIPETDISMISSHELP"] = {
		-- text = "Blizzard has "..ACTION_SPELL_AURA_REMOVED.." the ability to |cffffff20"..PET_ACTION_DISMISS.." "..PET_TYPE_PET.."|r via Custom "..UNITFRAME_LABEL..".\n\nPlease drag the |cffffff20"..PET_ACTION_DISMISS.." "..PET_TYPE_PET.."|r ability to your |cffffff20"..ACTIONBAR_LABEL.."|r from the |cffffff20"..SPELLBOOK.."|r.",
		-- button1 = OKAY,
		-- OnAccept = function() return end,
		-- timeout = 0,
		-- whileDead = true,
		-- hideOnEscape = true,
		-- notClosableByLogout = false,
	-- }
	-- StaticPopup_Show("RUIPETDISMISSHELP")
-- end

local function DisplayFocusPopUp()
	StaticPopupDialogs["RUIFOCUSHELP"] = {
		text = "Use Shift+Click to set focus.",
		button1 = OKAY,
		OnAccept = function() return end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		notClosableByLogout = false,
	}
	StaticPopup_Show("RUIFOCUSHELP")
end

hooksecurefunc("UnitPopup_OnClick",function(self)
	local button = self.value
	if button == "SET_FOCUS" or button == "CLEAR_FOCUS" then
		if StaticPopup1 then
			StaticPopup1:Hide()
		end
		DisplayFocusPopUp()
	elseif button == "PET_DISMISS" then
		if StaticPopup1 then
			StaticPopup1:Hide()
		end
	end
end)

local function menu(self)
	dropdown:SetParent(self)
	return ToggleDropDownMenu(1, nil, dropdown, 'cursor', 0, 0)
end

local init = function(self)
	local unit = self:GetParent().unit
	local menu, name, id
	
	if (not unit) then
		return
	end
	
	if (UnitIsUnit(unit, "player")) then
		menu = "SELF"
	elseif (UnitIsUnit(unit, "vehicle")) then
		menu = "VEHICLE"
	elseif (UnitIsUnit(unit, "pet")) then
		menu = "PET"
	elseif (UnitIsPlayer(unit)) then
		id = UnitInRaid(unit)
		if(id) then
			menu = "RAID_PLAYER"
			name = GetRaidRosterInfo(id)
		elseif(UnitInParty(unit)) then
			menu = "PARTY"
		else
			menu = "PLAYER"
		end
	else
		menu = "TARGET"
		name = RAID_TARGET_ICON
	end
	
	if (menu) then
		UnitPopup_ShowMenu(self, menu, unit, name, id)
	end
end

UIDropDownMenu_Initialize(dropdown, init, 'MENU')

-- Frames
local Shared = function(self, unit)
	self.menu = menu
	
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:RegisterForClicks"AnyUp"
	
  	if db.misc.focusclick then
		local ModKey = db.misc.focuskey
		local MouseButton = 1
		local key = ModKey .. '-type' .. (MouseButton or '')
		if(self.unit == 'focus') then
			self:SetAttribute(key, 'macro')
			self:SetAttribute('macrotext', '/clearfocus')
		else
			self:SetAttribute(key, 'focus')
		end
	end
end

function UnitFrames:InitializeLayout()
	ndbc.resolution = ndbc.resolution
	
	local UnitSpecific = {
		player = function(self, ...)
			Shared(self, ...)
			self:SetSize(unit_sizes[ndbc.resolution].player.width, unit_sizes[ndbc.resolution].player.height)
		end,
		
		focus = function(self, ...)
			Shared(self, ...)
			self:SetSize(unit_sizes[ndbc.resolution].focus.width, unit_sizes[ndbc.resolution].focus.height)
		end,
		
		focustarget = function(self, ...)
			Shared(self, ...)
			self:SetSize(unit_sizes[ndbc.resolution].focustarget.width, unit_sizes[ndbc.resolution].focustarget.height)
		end,
		
		pet = function(self, ...)
			Shared(self, ...)
			self:SetSize(unit_sizes[ndbc.resolution].pet.width, unit_sizes[ndbc.resolution].pet.height)
		end,
		
		target = function(self, ...)
			Shared(self, ...)
			self:SetSize(unit_sizes[ndbc.resolution].target.width, unit_sizes[ndbc.resolution].target.height)
		end,
		
		targettarget = function(self, ...)
			Shared(self, ...)
			self:SetSize(unit_sizes[ndbc.resolution].targettarget.width, unit_sizes[ndbc.resolution].targettarget.height)
		end,
		
		-- tank = function(self, ...)
			-- Shared(self, ...)
			-- self:SetSize(unit_sizes[ndbc.resolution].tank.width, unit_sizes[ndbc.resolution].tank.height)
		-- end,
	}

	oUF:RegisterStyle("RealUI", Shared)

	for unit,layout in next, UnitSpecific do
		oUF:RegisterStyle('RealUI - ' .. unit:gsub("^%l", string.upper), layout)
	end

	local spawnHelper = function(self, unit, ...)
		if (UnitSpecific[unit]) then
			self:SetActiveStyle('RealUI - ' .. unit:gsub("^%l", string.upper))
		elseif(UnitSpecific[unit:match('[^%d]+')]) then 
			self:SetActiveStyle('RealUI - ' .. unit:match('[^%d]+'):gsub("^%l", string.upper))
		else
			self:SetActiveStyle'RealUI'
		end
		
		local object = self:Spawn(unit)
		object:SetPoint(...)
		return object
	end

	oUF:Factory(function(self)
		spawnHelper(self, "player", 		"RIGHT", "RealUIPositionersUnitFrames", "LEFT",	db.positions[ndbc.resolution].player.x, 			db.positions[ndbc.resolution].player.y)
		spawnHelper(self, "pet", 			"RIGHT", "oUF_RealUIPlayer", 						db.positions[ndbc.resolution].pet.x, 			db.positions[ndbc.resolution].pet.y)
		spawnHelper(self, "focus", 			"RIGHT", "oUF_RealUIPlayer", 						db.positions[ndbc.resolution].focus.x, 			db.positions[ndbc.resolution].focus.y)
		spawnHelper(self, "focustarget", 	"RIGHT", "oUF_RealUIFocus", 						db.positions[ndbc.resolution].focustarget.x, 	db.positions[ndbc.resolution].focustarget.y)
		spawnHelper(self, "target", 		"LEFT", "RealUIPositionersUnitFrames", "RIGHT",	db.positions[ndbc.resolution].target.x, 			db.positions[ndbc.resolution].target.y)
		spawnHelper(self, "targettarget", 	"LEFT", "oUF_RealUITarget", 						db.positions[ndbc.resolution].targettarget.x, 	db.positions[ndbc.resolution].targettarget.y)
		
		UnitFrames:InitializeOverlay()
	end)
end


----------------------------
------ Initialization ------
----------------------------
function UnitFrames:OnInitialize()
	local otherFaction = nibRealUI:OtherFaction(nibRealUI.faction)
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			misc = {
				focusclick = true,
				focuskey = "shift",
				steppoints = {
					["default"] = 	{0.35, 0.25},
					["HUNTER"] = 	{0.35, 0.2},
					["PALADIN"] = 	{0.35, 0.2},
					["WARLOCK"] = 	{0.35, 0.2},
					["WARRIOR"] = 	{0.35, 0.2},
				},
				powerupdatespeed = {
					["default"] = 	1/10,
					["ENERGY"] = 	1/20,
				},
			},
			units = {
				arena = false,
				tank = false,
			},
			positions = {
				[1] = {
					player = 		{ x = 0,	y = 0},		-- Anchored to Positioner
					pet = 			{ x = 11, 	y = 0},		-- Anchored to Player
					focus = 		{ x = 0,	y = -51},	-- Anchored to Player
					focustarget = 	{ x = 0,	y = -10},	-- Anchored to Focus
					target = 		{ x = 0,	y = 0},	-- Anchored to Positioner
					targettarget = 	{ x = 0,	y = -51},	-- Anchored to Target
					-- tank = 			{ x = 0,	y = -10},	-- Anchored to TargetTarget
				},
				[2] = {
					player = 		{ x = 0,	y = 0},		-- Anchored to Positioner
					pet = 			{ x = 11, 	y = 0},		-- Anchored to Player
					focus = 		{ x = 0,	y = -51},	-- Anchored to Player
					focustarget = 	{ x = 0,	y = -10},	-- Anchored to Focus
					target = 		{ x = 0,	y = 0},	-- Anchored to Positioner
					targettarget = 	{ x = 0,	y = -51},	-- Anchored to Target
					-- tank = 			{ x = 0,	y = -10},	-- Anchored to TargetTarget
				},
			},
			overlay = {
				bar = {
					opacity = {
						surround = 		1,				-- Border of objects
						background = 	0.6,			-- Background of unit frame
						status = 		0.8,			-- Background of objects (arrow, end box, etc)
						bar = 			{0.0, 0.8},		-- Health/Power gradient {start, end}
						bar2 = 			{0.4, 0.9},		-- Pet/Vehicle Health/Power gradient {start, end}
						steps = 		0.7,			-- Tiny step indicator
					},
					colors = {
						byhostility = true,
						byclass = true,
					},
				},
				arrow = {
					opacity = {
						surround = 		1,
						background = 	0.8,
					},
					colors = {
						[1] = {1, 1, 1},
						[2] = {1, 1, 0},
						[3] = {1, 0, 0},
						[4] = {1, 0.5, 0},
					},
				},
				colors = {
					health = {
						normal = 	{0.7, 0.1, 0.1},
						hostile = 	{0.7, 0.1, 0.1},
						neutral = 	{0.75, 0.75, 0},
						friendly = 	{0.1, 0.7, 0.25},
					},
					power = {
						["MANA"] = 			{0.00, 0.00, 1.00},
						["RAGE"] = 			{1.00, 0.00, 0.00},
						["FOCUS"] = 		{1.00, 0.50, 0.25},
						["ENERGY"] = 		{1.00, 1.00, 0.00},
						["LIGHT_FORCE"] = 	{0.71, 1.0, 0.92},	--chi
						["RUNES"] = 		{0.50, 0.50, 0.50},
						["RUNIC_POWER"] = 	{0.00, 0.82, 1.00},
						["SOUL_SHARDS"] = 	{0.50, 0.32, 0.55},
						["HOLY_POWER"] = 	{0.95, 0.90, 0.60},
						["AMMOSLOT"] = 		{0.80, 0.60, 0.00},
						["FUEL"] = 			{0.0, 0.55, 0.5},
					},
					status = {
						damage = 		{1, 0, 0},
						incomingheal = 	{1, 1, 0},
						heal = 			{0, 1, 0},
						resting = 		{0, 1, 0},
						combat = 		{1, 0, 0},
						afk = 			{1, 1, 0},
						offline = 		{0.6, 0.6, 0.6},
						leader = 		{0, 1, 1},
						tapped = 		{0.4, 0.4, 0.4},
						pvpenemy = 		{0.2, 0, 0},
						pvpfriendly = 	{0, 0.2, 0},
						dead = 			{0.6, 0.4, 0.4},
					},
				},
			},
		},
	})
	db = self.db.profile
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterHuDOptions(MODNAME, GetOptions)
end

function UnitFrames:OnEnable()
	UnitFrames:InitializeLayout()
end