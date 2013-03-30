local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db, ndb, ndbc

local _
local MODNAME = "FrameMover"
local FrameMover = nibRealUI:NewModule(MODNAME, "AceEvent-3.0", "AceBucket-3.0")

local EnteredWorld

local GarbageTimerInt = 1
local GarbageTimerFrame

local FrameList = {
	addons = {
		grid = {
			name = "Grid",
			addon = "Grid",
			hashealing = true,
			highres = true,
			frames = {[1] = {name = "GridLayoutFrame"},},
			frameshealing = {[1] = {name = "GridLayoutFrame"},},
			frameshr = {[1] = {name = "GridLayoutFrame"},},
			frameshrhealing = {[1] = {name = "GridLayoutFrame"},},
		},
		raven = {
			name = "Raven",
			addon = "Raven",
			frames = {
				[1] = {name = "RavenBarGroupPlayerBuffs"},
				[2] = {name = "RavenBarGroupPlayerDebuffs"},
				[3] = {name = "RavenBarGroupTargetBuffs"},
				[4] = {name = "RavenBarGroupTargetDebuffs"},
				[5] = {name = "RavenBarGroupFocusBuffs"},
				[6] = {name = "RavenBarGroupFocusDebuffs"},
				[7] = {name = "RavenBarGroupToTDebuffs"},
				-- [8] = {name = "RavenBarGroupBuffs"},
			},
		},
	},
	uiframes = {
		zonetext = {
			name = "Zoning Text",
			frames = {[1] = {name = "ZoneTextFrame"},},
		},
		raidmessages = {
			name = "Raid Alerts",
			frames = {[1] = {name = "RaidWarningFrame"},},
		},
		ticketstatus = {
			name = "Ticket Status",
			frames = {[1] = {name = "TicketStatusFrame"},},
		},
		worldstate = {
			name = "World State",
			frames = {[1] = {name = "WorldStateAlwaysUpFrame"},},
		},
		errorframe = {
			name = "Errors",
			frames = {[1] = {name = "UIErrorsFrame"},},
		},
		vsi = {
			name = "Vehicle Seat",
			frames = {[1] = {name = "VehicleSeatIndicator"},},
		},
		playerpowerbaralt = {
			name = "Alternate Power Bar",
			frames = {[1] = {name = "PlayerPowerBarAlt"},},
		},
	},
	hide = {
		durabilityframe = {
			name = "Durability Frame",
			frames = {[1] = {name = "DurabilityFrame"},},
		},
		bossframes = {
			name = "Boss Frames",
			frames = {
				[1] = {name = "Boss1TargetFrame"},
				[2] = {name = "Boss2TargetFrame"},
				[3] = {name = "Boss3TargetFrame"},
				[4] = {name = "Boss4TargetFrame"},
			},
		},
		raid = {
			name = "Raid",
			frames = {},
		},
		party = {
			name = "Party",
			frames = {},
		},
	},
}

-- Options
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

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Frame Mover",
		desc = "Automatically Move/Hide certain AddOns/Frames.",
		arg = MODNAME,
		order = 618,
		args = {
			header = {
				type = "header",
				name = "Frame Mover/Hider",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Automatically Move/Hide certain AddOns/Frames.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Frame Mover module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
					nibRealUI:ReloadUIDialog()
				end,
				order = 30,
			},
			note = {
				type = "description",
				name = "Note: Enabling/Disabling this module will require a UI Reload to take full effect (type: /rl).",
				order = 40,
			},
		},
	}
	end
	
	-- Create Addons options table
	local addonOpts = {
		name = "Addons",
		type = "group",
		disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
		order = 50,
		args = {},
	}
	local addonOrderCnt = 10	
	for k_a,v_a in pairs(FrameList.addons) do
		-- Create base options for Addons
		addonOpts.args[k_a] = {
			type = "group",
			name = FrameList.addons[k_a].name,
			childGroups = "tab",
			order = addonOrderCnt,
			disabled = function() return not(IsAddOnLoaded(FrameList.addons[k_a].addon) and nibRealUI:GetModuleEnabled(MODNAME)) end,
			args = {
				header = {
					type = "header",
					name = string.format("Frame Mover - Addons - %s", FrameList.addons[k_a].name),
					order = 10,
				},
				enabled = {
					type = "toggle",
					name = string.format("Move %s", FrameList.addons[k_a].name),
					get = function(info)
						if k_a == "grid" then
							return ndb.addonControl.grid
						else
							return db.addons[k_a].move
						end
					end,
					set = function(info, value) 
						if k_a == "grid" then
							ndb.addonControl.grid = value 
							if ndb.addonControl.grid then
								FrameMover:MoveAddons()
							end
						else
							db.addons[k_a].move = value
							if db.addons[k_a].move then
								FrameMover:MoveAddons()
							end
						end
					end,
					order = 20,
				},
				normal = {
					type = "group",
					name = "Normal / Low Res",
					order = 50,
					args = {},
				},
				highres = {
					type = "group",
					name = "High Res",
					disabled = function() return not FrameList.addons[k_a].highres end,
					order = 60,
					args = {},
				},
			},
		}
		
		-- Healing Enable option
		if FrameList.addons[k_a].hashealing then
			addonOpts.args[k_a].args.healingenabled = {
				type = "toggle",
				name = "Enable Healing Layout",
				get = function(info) return db.addons[k_a].healing end,
				set = function(info, value) 
					db.addons[k_a].healing = value 
					if db.addons[k_a].move then
						FrameMover:MoveAddons()
					end
				end,
				order = 30,
			}
		end
		
		-- High Res Enable option
		if FrameList.addons[k_a].highres then
			addonOpts.args[k_a].args.highresenabled = {
				type = "toggle",
				name = "Enable High Res Layout",
				get = function(info) return db.addons[k_a].highres end,
				set = function(info, value) 
					db.addons[k_a].highres = value 
					if db.addons[k_a].move then
						FrameMover:MoveAddons()
					end
				end,
				order = 40,
			}
		end
		
		-- Normal / Low Res
		-- Create options table for Frames
		local normalFrameOpts = {
			name = "Frames",
			type = "group",
			inline = true,
			disabled = function() if db.addons[k_a].move then return false else return true end end,
			order = 10,
			args = {},
		}
		local normalFrameOrderCnt = 10		
		for k_f,v_f in ipairs(FrameList.addons[k_a].frames) do	
			normalFrameOpts.args[tostring(k_f)] = {
				type = "group",
				name = FrameList.addons[k_a].frames[k_f].name,
				inline = true,
				order = normalFrameOrderCnt,
				args = {
					x = {
						type = "input",
						name = "X Offset",
						width = "half",
						order = 10,
						get = function(info) return tostring(db.addons[k_a].frames[k_f].x) end,
						set = function(info, value)
							value = nibRealUI:ValidateOffset(value)
							db.addons[k_a].frames[k_f].x = value
							FrameMover:MoveAddons()
						end,
					},
					yoffset = {
						type = "input",
						name = "Y Offset",
						width = "half",
						order = 20,
						get = function(info) return tostring(db.addons[k_a].frames[k_f].y) end,
						set = function(info, value)
							value = nibRealUI:ValidateOffset(value)
							db.addons[k_a].frames[k_f].y = value
							FrameMover:MoveAddons()
						end,
					},
					anchorto = {
						type = "select",
						name = "Anchor To",
						get = function(info) 
							for k_ta,v_ta in pairs(table_AnchorPoints) do
								if v_ta == db.addons[k_a].frames[k_f].rpoint then return k_ta end
							end
						end,
						set = function(info, value)
							db.addons[k_a].frames[k_f].rpoint = table_AnchorPoints[value]
							FrameMover:MoveAddons()
						end,
						style = "dropdown",
						width = nil,
						values = table_AnchorPoints,
						order = 30,
					},
					anchorfrom = {
						type = "select",
						name = "Anchor From",
						get = function(info) 
							for k_ta,v_ta in pairs(table_AnchorPoints) do
								if v_ta == db.addons[k_a].frames[k_f].point then return k_ta end
							end
						end,
						set = function(info, value)
							db.addons[k_a].frames[k_f].point = table_AnchorPoints[value]
							FrameMover:MoveAddons()
						end,
						style = "dropdown",
						width = nil,
						values = table_AnchorPoints,
						order = 40,
					},
					parent = {
						type = "input",
						name = "Parent",
						width = "double",
						order = 50,
						get = function(info) return db.addons[k_a].frames[k_f].parent end,
						set = function(info, value)
							if not _G[value] then value = "UIParent" end
							db.addons[k_a].frames[k_f].parent = value
							FrameMover:MoveAddons()
						end,
					},
				},
			}
			normalFrameOrderCnt = normalFrameOrderCnt + 10
		end
		
		-- Create options table for Healing Frames
		local normalHealingFrameOpts = nil
		if FrameList.addons[k_a].hashealing then
			normalHealingFrameOpts = {
				name = "Healing Layout Frames",
				type = "group",
				inline = true,
				disabled = function() return not ( db.addons[k_a].move and db.addons[k_a].healing ) end,
				order = 50,
				args = {},
			}
			local normalHealingFrameOrderCnt = 10		
			for k_f,v_f in ipairs(FrameList.addons[k_a].frameshealing) do	
				normalHealingFrameOpts.args[tostring(k_f)] = {
					type = "group",
					name = FrameList.addons[k_a].frameshealing[k_f].name,
					inline = true,
					order = normalHealingFrameOrderCnt,
					args = {
						x = {
							type = "input",
							name = "X Offset",
							width = "half",
							order = 10,
							get = function(info) return tostring(db.addons[k_a].frameshealing[k_f].x) end,
							set = function(info, value)
								value = nibRealUI:ValidateOffset(value)
								db.addons[k_a].frameshealing[k_f].x = value
								FrameMover:MoveAddons()
							end,
						},
						yoffset = {
							type = "input",
							name = "Y Offset",
							width = "half",
							order = 20,
							get = function(info) return tostring(db.addons[k_a].frameshealing[k_f].y) end,
							set = function(info, value)
								value = nibRealUI:ValidateOffset(value)
								db.addons[k_a].frameshealing[k_f].y = value
								FrameMover:MoveAddons()
							end,
						},
						anchorto = {
							type = "select",
							name = "Anchor To",
							get = function(info) 
								for k_ta,v_ta in pairs(table_AnchorPoints) do
									if v_ta == db.addons[k_a].frameshealing[k_f].rpoint then return k_ta end
								end
							end,
							set = function(info, value)
								db.addons[k_a].frameshealing[k_f].rpoint = table_AnchorPoints[value]
								FrameMover:MoveAddons()
							end,
							style = "dropdown",
							width = nil,
							values = table_AnchorPoints,
							order = 30,
						},
						anchorfrom = {
							type = "select",
							name = "Anchor From",
							get = function(info) 
								for k_ta,v_ta in pairs(table_AnchorPoints) do
									if v_ta == db.addons[k_a].frameshealing[k_f].point then return k_ta end
								end
							end,
							set = function(info, value)
								db.addons[k_a].frameshealing[k_f].point = table_AnchorPoints[value]
								FrameMover:MoveAddons()
							end,
							style = "dropdown",
							width = nil,
							values = table_AnchorPoints,
							order = 40,
						},
						parent = {
							type = "input",
							name = "Parent",
							width = "double",
							order = 50,
							get = function(info) return db.addons[k_a].frameshealing[k_f].parent end,
							set = function(info, value)
								if not _G[value] then value = "UIParent" end
								db.addons[k_a].frameshealing[k_f].parent = value
								FrameMover:MoveAddons()
							end,
						},
					},
				}
				normalHealingFrameOrderCnt = normalHealingFrameOrderCnt + 10
			end
		end

		-- Add Frames to Addons options
		addonOpts.args[k_a].args.normal.args.frames = normalFrameOpts
		if normalHealingFrameOpts ~= nil then addonOpts.args[k_a].args.normal.args.healingframes = normalHealingFrameOpts end
		
		-- High Res
		if FrameList.addons[k_a].highres then
			-- Create options table for Frames
			local highresFrameOpts = {
				name = "Frames",
				type = "group",
				inline = true,
				disabled = function() return not ( db.addons[k_a].move and db.addons[k_a].highres ) end,
				order = 10,
				args = {},
			}
			local highresFrameOrderCnt = 10		
			for k_f,v_f in ipairs(FrameList.addons[k_a].frameshr) do	
				highresFrameOpts.args[tostring(k_f)] = {
					type = "group",
					name = FrameList.addons[k_a].frameshr[k_f].name,
					inline = true,
					order = highresFrameOrderCnt,
					args = {
						x = {
							type = "input",
							name = "X Offset",
							width = "half",
							order = 10,
							get = function(info) return tostring(db.addons[k_a].frameshr[k_f].x) end,
							set = function(info, value)
								value = nibRealUI:ValidateOffset(value)
								db.addons[k_a].frameshr[k_f].x = value
								FrameMover:MoveAddons()
							end,
						},
						yoffset = {
							type = "input",
							name = "Y Offset",
							width = "half",
							order = 20,
							get = function(info) return tostring(db.addons[k_a].frameshr[k_f].y) end,
							set = function(info, value)
								value = nibRealUI:ValidateOffset(value)
								db.addons[k_a].frameshr[k_f].y = value
								FrameMover:MoveAddons()
							end,
						},
						anchorto = {
							type = "select",
							name = "Anchor To",
							get = function(info) 
								for k_ta,v_ta in pairs(table_AnchorPoints) do
									if v_ta == db.addons[k_a].frameshr[k_f].rpoint then return k_ta end
								end
							end,
							set = function(info, value)
								db.addons[k_a].frameshr[k_f].rpoint = table_AnchorPoints[value]
								FrameMover:MoveAddons()
							end,
							style = "dropdown",
							width = nil,
							values = table_AnchorPoints,
							order = 30,
						},
						anchorfrom = {
							type = "select",
							name = "Anchor From",
							get = function(info) 
								for k_ta,v_ta in pairs(table_AnchorPoints) do
									if v_ta == db.addons[k_a].frameshr[k_f].point then return k_ta end
								end
							end,
							set = function(info, value)
								db.addons[k_a].frameshr[k_f].point = table_AnchorPoints[value]
								FrameMover:MoveAddons()
							end,
							style = "dropdown",
							width = nil,
							values = table_AnchorPoints,
							order = 40,
						},
						parent = {
							type = "input",
							name = "Parent",
							width = "double",
							order = 50,
							get = function(info) return db.addons[k_a].frameshr[k_f].parent end,
							set = function(info, value)
								if not _G[value] then value = "UIParent" end
								db.addons[k_a].frameshr[k_f].parent = value
								FrameMover:MoveAddons()
							end,
						},
					},
				}
				highresFrameOrderCnt = highresFrameOrderCnt + 10
			end
			
			-- Create options table for Healing Frames
			local highresHealingFrameOpts = nil
			if FrameList.addons[k_a].hashealing then
				highresHealingFrameOpts = {
					name = "Healing Layout Frames",
					type = "group",
					inline = true,
					disabled = function() return not ( db.addons[k_a].move and db.addons[k_a].healing and db.addons[k_a].highres ) end,
					order = 50,
					args = {},
				}
				local highresHealingFrameOrderCnt = 10		
				for k_f,v_f in ipairs(FrameList.addons[k_a].frameshrhealing) do	
					highresHealingFrameOpts.args[tostring(k_f)] = {
						type = "group",
						name = FrameList.addons[k_a].frameshrhealing[k_f].name,
						inline = true,
						order = highresHealingFrameOrderCnt,
						args = {
							x = {
								type = "input",
								name = "X Offset",
								width = "half",
								order = 10,
								get = function(info) return tostring(db.addons[k_a].frameshrhealing[k_f].x) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.addons[k_a].frameshrhealing[k_f].x = value
									FrameMover:MoveAddons()
								end,
							},
							yoffset = {
								type = "input",
								name = "Y Offset",
								width = "half",
								order = 20,
								get = function(info) return tostring(db.addons[k_a].frameshrhealing[k_f].y) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.addons[k_a].frameshrhealing[k_f].y = value
									FrameMover:MoveAddons()
								end,
							},
							anchorto = {
								type = "select",
								name = "Anchor To",
								get = function(info) 
									for k_ta,v_ta in pairs(table_AnchorPoints) do
										if v_ta == db.addons[k_a].frameshrhealing[k_f].rpoint then return k_ta end
									end
								end,
								set = function(info, value)
									db.addons[k_a].frameshrhealing[k_f].rpoint = table_AnchorPoints[value]
									FrameMover:MoveAddons()
								end,
								style = "dropdown",
								width = nil,
								values = table_AnchorPoints,
								order = 30,
							},
							anchorfrom = {
								type = "select",
								name = "Anchor From",
								get = function(info) 
									for k_ta,v_ta in pairs(table_AnchorPoints) do
										if v_ta == db.addons[k_a].frameshrhealing[k_f].point then return k_ta end
									end
								end,
								set = function(info, value)
									db.addons[k_a].frameshrhealing[k_f].point = table_AnchorPoints[value]
									FrameMover:MoveAddons()
								end,
								style = "dropdown",
								width = nil,
								values = table_AnchorPoints,
								order = 40,
							},
							parent = {
								type = "input",
								name = "Parent",
								width = "double",
								order = 50,
								get = function(info) return db.addons[k_a].frameshrhealing[k_f].parent end,
								set = function(info, value)
									if not _G[value] then value = "UIParent" end
									db.addons[k_a].frameshrhealing[k_f].parent = value
									FrameMover:MoveAddons()
								end,
							},
						},
					}
					highresHealingFrameOrderCnt = highresHealingFrameOrderCnt + 10
				end
			end

			-- Add Frames to Addons options
			addonOpts.args[k_a].args.highres.args.frames = highresFrameOpts
			if highresHealingFrameOpts ~= nil then addonOpts.args[k_a].args.highres.args.healingframes = highresHealingFrameOpts end
		end
		
		addonOrderCnt = addonOrderCnt + 10	
	end
	
	-- Create UIFrames options table
	local uiframesopts = {
		name = "UI Frames",
		type = "group",
		disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
		order = 60,
		args = {},
	}
	local uiframesordercnt = 10	
	for k_u,v_u in pairs(FrameList.uiframes) do
		-- Create base options for UIFrames
		uiframesopts.args[k_u] = {
			type = "group",
			name = FrameList.uiframes[k_u].name,
			order = uiframesordercnt,
			args = {
				header = {
					type = "header",
					name = string.format("Frame Mover - UI Frames - %s", FrameList.uiframes[k_u].name),
					order = 10,
				},
				enabled = {
					type = "toggle",
					name = string.format("Move %s", FrameList.uiframes[k_u].name),
					get = function(info) return db.uiframes[k_u].move end,
					set = function(info, value) 
						db.uiframes[k_u].move = value 
						if db.uiframes[k_u].move and FrameList.uiframes[k_u].frames then FrameMover:MoveIndividualFrameGroup(FrameList.uiframes[k_u].frames, db.uiframes[k_u].frames) end
					end,
					order = 20,
				},
			},
		}
		
		-- Create options table for Frames
		if FrameList.uiframes[k_u].frames then
			local frameopts = {
				name = "Frames",
				type = "group",
				inline = true,
				disabled = function() if db.uiframes[k_u].move then return false else return true end end,
				order = 30,
				args = {},
			}
			local FrameOrderCnt = 10		
			for k_f,v_f in ipairs(FrameList.uiframes[k_u].frames) do	
				frameopts.args[tostring(k_f)] = {
					type = "group",
					name = FrameList.uiframes[k_u].frames[k_f].name,
					inline = true,
					order = FrameOrderCnt,
					args = {
						x = {
							type = "input",
							name = "X Offset",
							width = "half",
							order = 10,
							get = function(info) return tostring(db.uiframes[k_u].frames[k_f].x) end,
							set = function(info, value)
								value = nibRealUI:ValidateOffset(value)
								db.uiframes[k_u].frames[k_f].x = value
								FrameMover:MoveIndividualFrameGroup(FrameList.uiframes[k_u].frames, db.uiframes[k_u].frames)
							end,
						},
						yoffset = {
							type = "input",
							name = "Y Offset",
							width = "half",
							order = 20,
							get = function(info) return tostring(db.uiframes[k_u].frames[k_f].y) end,
							set = function(info, value)
								value = nibRealUI:ValidateOffset(value)
								db.uiframes[k_u].frames[k_f].y = value
								FrameMover:MoveIndividualFrameGroup(FrameList.uiframes[k_u].frames, db.uiframes[k_u].frames)
							end,
						},
						anchorto = {
							type = "select",
							name = "Anchor To",
							get = function(info) 
								for k_ta,v_ta in pairs(table_AnchorPoints) do
									if v_ta == db.uiframes[k_u].frames[k_f].rpoint then return k_ta end
								end
							end,
							set = function(info, value)
								db.uiframes[k_u].frames[k_f].rpoint = table_AnchorPoints[value]
								FrameMover:MoveIndividualFrameGroup(FrameList.uiframes[k_u].frames, db.uiframes[k_u].frames)
							end,
							style = "dropdown",
							width = nil,
							values = table_AnchorPoints,
							order = 30,
						},
						anchorfrom = {
							type = "select",
							name = "Anchor From",
							get = function(info) 
								for k_ta,v_ta in pairs(table_AnchorPoints) do
									if v_ta == db.uiframes[k_u].frames[k_f].point then return k_ta end
								end
							end,
							set = function(info, value)
								db.uiframes[k_u].frames[k_f].point = table_AnchorPoints[value]
								FrameMover:MoveIndividualFrameGroup(FrameList.uiframes[k_u].frames, db.uiframes[k_u].frames)
							end,
							style = "dropdown",
							width = nil,
							values = table_AnchorPoints,
							order = 40,
						},
					},
				}
				FrameOrderCnt = FrameOrderCnt + 10
			end
			
			-- Add Frames to UI Frames options
			uiframesopts.args[k_u].args.frames = frameopts
			uiframesordercnt = uiframesordercnt + 10
		end
	end
	
	-- Create Hide options table
	local hideopts = {
		name = "Hide Frames",
		type = "group",
		disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
		order = 70,
		args = {
			header = {
				type = "header",
				name = string.format("Frame Mover - Hide Frames"),
				order = 10,
			},
			sep = {
				type = "description",
				name = " ",
				order = 20,
			},
			note = {
				type = "description",
				name = "Note: To make a frame visible again after it has been hidden, you will need to reload the UI (type: /rl).",
				order = 30,
			},
			hideframes = {
				type = "group",
				name = "Hide",
				inline = true,
				order = 40,
				args = {},
			},
		},
	}
	-- Add all frames to Hide Frames options
	local hideordercnt = 10	
	for k_u,v_u in pairs(FrameList.hide) do
		-- Create base options for Hide
		hideopts.args.hideframes.args[k_u] = {
			type = "toggle",
			name = FrameList.hide[k_u].name,
			get = function(info) return db.hide[k_u].hide end,
			set = function(info, value) 
				db.hide[k_u].hide = value 
				if db.hide[k_u].hide then
					FrameMover:HideFrames()
				else
					nibRealUI:ReloadUIDialog()
				end
			end,
			order = hideordercnt,
		}

		hideordercnt = hideordercnt + 10		
	end

	-- Add extra options to Options table
	options.args.addons = addonOpts
	options.args.uiframes = uiframesopts
	options.args.hide = hideopts
	return options
end

-- Hide a Frame	
local function HideFrame(FrameName)
	local frame = _G[FrameName]
	if not frame then return end
	
	frame:UnregisterAllEvents()
	frame:Hide()	
	frame:SetScript("OnShow", function(self) self:Hide() end)
end

function FrameMover:HideIndividualFrameGroup(FramesTable)
	for k,v in pairs(FramesTable) do
		local FrameName = FramesTable[k].name
		HideFrame(FrameName)
	end
end

-- Move a Frame
local function MoveFrame(FrameName, point, rframe, rpoint, x, y, ...)
	local frame = _G[FrameName]
	if not frame then return end
	
	frame:ClearAllPoints()
	frame:SetPoint(point, rframe, rpoint, x, y)
	
	local scale = ...
	if scale ~= nil then frame:SetScale(scale) end
end

-- Move a single Addon/UIFrame group from saved variables
function FrameMover:MoveIndividualFrameGroup(FramesTable, DBTable)
	local FrameDB = {}
	for k,v in pairs(FramesTable) do
		local FrameName = FramesTable[k].name
		FrameDB = DBTable[k]
		local scale = nil
		if FrameDB.scale then scale = FrameDB.scale end
		local parent = _G[FrameDB.parent] or UIParent
		MoveFrame(FrameName, FrameDB.point, parent, FrameDB.rpoint, FrameDB.x, FrameDB.y, scale)
	end
end

-- Move all Addons
function FrameMover:MoveAddons()
	local FrameDB = {}
	for k,v in pairs(FrameList.addons) do
		if (k ~= "grid" and db.addons[k].move) or (k == "grid" and ndb.addonControl.grid) then
			
			local IsHealing = ( FrameList.addons[k].hashealing and db.addons[k].healing and nibRealUI.db.char.layout.current == 2 )
			local IsHighRes = ( FrameList.addons[k].highres and db.addons[k].highres and ndbc.resolution == 2 )
			
			if IsHighRes then
				if IsHealing then
					-- Healing Layout
					for k2,v2 in ipairs(FrameList.addons[k].frameshrhealing) do
						local FrameName = FrameList.addons[k].frameshrhealing[k2].name
						FrameDB = db.addons[k].frameshrhealing[k2]
						local scale = nil
						if FrameDB.scale then scale = FrameDB.scale end
						local parent = _G[FrameDB.parent] or UIParent
						MoveFrame(FrameName, FrameDB.point, parent, FrameDB.rpoint, FrameDB.x, FrameDB.y, scale)
					end
				else
					-- Normal Layout
					for k2,v2 in ipairs(FrameList.addons[k].frameshr) do
						local FrameName = FrameList.addons[k].frameshr[k2].name
						FrameDB = db.addons[k].frameshr[k2]
						local scale = nil
						if FrameDB.scale then scale = FrameDB.scale end
						local parent = _G[FrameDB.parent] or UIParent
						MoveFrame(FrameName, FrameDB.point, parent, FrameDB.rpoint, FrameDB.x, FrameDB.y, scale)
					end
				end
			else
				if IsHealing then
					-- Healing Layout
					for k2,v2 in ipairs(FrameList.addons[k].frameshealing) do
						local FrameName = FrameList.addons[k].frameshealing[k2].name
						FrameDB = db.addons[k].frameshealing[k2]
						local scale = nil
						if FrameDB.scale then scale = FrameDB.scale end
						local parent = _G[FrameDB.parent] or UIParent
						MoveFrame(FrameName, FrameDB.point, parent, FrameDB.rpoint, FrameDB.x, FrameDB.y, scale)
					end
				else
					-- Normal Layout
					for k2,v2 in ipairs(FrameList.addons[k].frames) do
						local FrameName = FrameList.addons[k].frames[k2].name
						FrameDB = db.addons[k].frames[k2]
						local scale = nil
						if FrameDB.scale then scale = FrameDB.scale end
						local parent = _G[FrameDB.parent] or UIParent
						MoveFrame(FrameName, FrameDB.point, parent, FrameDB.rpoint, FrameDB.x, FrameDB.y, scale)
					end
				end
			end
		end
	end
end

-- Move all UI Frames
function FrameMover:MoveUIFrames()
	local FrameDB = {}
	for k,v in pairs(FrameList.uiframes) do
		if db.uiframes[k].move and FrameList.uiframes[k].frames then
			for k2,v2 in ipairs(FrameList.uiframes[k].frames) do
				local FrameName = FrameList.uiframes[k].frames[k2].name
				FrameDB = db.uiframes[k].frames[k2]
				local scale = nil
				if FrameDB.scale then scale = FrameDB.scale end
				MoveFrame(FrameName, FrameDB.point, FrameDB.parent, FrameDB.rpoint, FrameDB.x, FrameDB.y, scale)
			end
		end
	end
end

-- Hide Party/Raid Frames
local compactRaid = "1"
local function FrameMover_RaidFramesCheck()
	if not InCombatLockdown() then
		if db.hide.raid.hide and compactRaid ~= "0" then
			CompactRaidFrameManager_SetSetting("IsShown","0")
		else
			CompactRaidFrameManager_SetSetting("IsShown","1")
		end
	end
end

function FrameMover:HidePartyRaid()
	if db.hide.raid.hide then
		FrameMover_RaidFramesCheck()
	end
	
	if not InCombatLockdown() then
		if not self.partyhidden and EnteredWorld and db.hide.party.hide then
			self.partyhidden = true
			for i = 1, 4 do
				local frame = _G["PartyMemberFrame"..i]
				frame:UnregisterAllEvents()
				frame:Hide()
				frame.Show = function() end
			end
		end
	end
end

-- Hide all UI Frames
function FrameMover:HideFrames()
	for k,v in pairs(FrameList.hide) do
		if db.hide[k].hide then
			for k2,v2 in ipairs(FrameList.hide[k].frames) do
				local FrameName = FrameList.hide[k].frames[k2].name
				HideFrame(FrameName)
			end
		end
	end
end

-- Garbage Timer
local function CreateGarbageTimer()
	GarbageTimerFrame = CreateFrame("Frame")
	GarbageTimerFrame:Hide()
	GarbageTimerFrame:SetScript("OnUpdate", function(self, elapsed)
		GarbageTimerInt = GarbageTimerInt - elapsed
		if GarbageTimerInt <= 0 then
			collectgarbage("collect")
			GarbageTimerFrame:Hide()
			GarbageTimerInt = 1
		end	
	end)
end


---- Hook into addons to display PopUpMessage and reposition frames
-- VSI
local function Hook_VSI()
	hooksecurefunc(VehicleSeatIndicator, "SetPoint", function(_, _, parent)
		if nibRealUI:GetModuleEnabled(MODNAME) and db.uiframes.vsi.move then
			if (parent == "MinimapCluster") or (parent == _G["MinimapCluster"]) then
				FrameMover:MoveIndividualFrameGroup(FrameList.uiframes.vsi.frames, db.uiframes.vsi.frames)
			end
		end
	end)
end

-- Raven - To stop bars repositioning themselves
local function Hook_Raven()
	if not IsAddOnLoaded("Raven") then return end
	
	local t = CreateFrame("Frame")
	t:Hide()
	t.e = 0
	t:SetScript("OnUpdate", function(s, e)
		t.e = t.e + e
		if t.e >= 0.5 then
			FrameMover:MoveIndividualFrameGroup(FrameList.addons.raven.frames, db.addons.raven.frames)
			t.e = 0
			t:Hide()
		end
	end) 
	
	hooksecurefunc("Nest_SetAnchorPoint", function()
		t:Show()
	end)
end

-- Action Bars - hook when configuring
local function AB_Notification()
	if nibRealUI:GetModuleEnabled(MODNAME) and ndb.addonControl.actionBars then
		nibRealUI:Notification("RealUI is controlling Action Bar positioning.", true, "Type |cFFFFAE5E/hud|r for positioning options.")
	end
end
local function Hook_AB()
	if not Bartender4 then return end
	hooksecurefunc(LibStub("AceConfigDialog-3.0"), "Open", function(...)
		if select(2, ...) == "Bartender4" then
			AB_Notification()
		end
	end)
	hooksecurefunc(Bartender4, "ShowUnlockDialog", function()
		AB_Notification()
	end)
end

-- Grid - Hook when Grid is moved
local function Hook_Grid()
	local gridframe = _G["GridLayoutFrame"]
	if not gridframe then return end
	
	hooksecurefunc(gridframe, "StopMovingOrSizing", function()
		if nibRealUI:GetModuleEnabled(MODNAME) and ndb.addonControl.grid then
			nibRealUI:Notification("RealUI is controlling Grid positioning.", true, "Type |cFFFFAE5E/hud|r for positioning options.")
			FrameMover:MoveAddons()
		end
	end)
end

function RealUI_MoveAll()
	FrameMover:MoveUIFrames()
	FrameMover:MoveAddons()
end

function FrameMover:RefreshMod()
	db = self.db.profile
	RealUI_MoveAll()
end

function FrameMover:PLAYER_ENTERING_WORLD()
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end
	
	if not EnteredWorld then
		Hook_Grid()
		Hook_AB()
		Hook_Raven()
		Hook_VSI()
		
		self:MoveUIFrames()
		self:MoveAddons()
		self:HideFrames()
		
		CreateGarbageTimer()
	end
	EnteredWorld = true
	
	self:HidePartyRaid("PLAYER_ENTERING_WORLD")
	
	GarbageTimerFrame:Show()
end

function FrameMover:ADDON_LOADED(event, addon)
	if addon == "MSBTOptions" then
		if nibRealUI:GetModuleEnabled(MODNAME) and ndb.addonControl.msbt then
			nibRealUI:Notification("RealUI is controlling MSBT positioning.", "Type |cFFFFAE5E/hud|r for positioning options.")
		end
	end
end

----
local LockdownTimer = CreateFrame("Frame")
LockdownTimer.Elapsed = 0
LockdownTimer:Hide()
LockdownTimer:SetScript("OnUpdate", function(self, elapsed)
	LockdownTimer.Elapsed = LockdownTimer.Elapsed + elapsed
	if LockdownTimer.Elapsed >= 1 then
		if not InCombatLockdown() then
			FrameMover:HidePartyRaid()
			LockdownTimer.Elapsed = 0
			LockdownTimer:Hide()
		else
			LockdownTimer.Elapsed = 0
		end
	end
end)
function FrameMover:UpdateLockdown(...)
	LockdownTimer:Show()
end

function FrameMover:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			addons = {
				["**"] = {
					move = true,
					healing = false,
					highres = false,
				},
				grid = {
					healing = true,
					highres = true,
					frames = {
						[1] = {name = "GridLayoutFrame", parent = "UIParent", point = "BOTTOM", rpoint = "BOTTOM", x = -0.5, y = -1},
					},
					frameshealing = {
						[1] = {name = "GridLayoutFrame", parent = "RealUIPositionersLayoutBottomItem", point = "TOP", rpoint = "CENTER", x = 0, y = 0},
					},
					frameshr = {
						[1] = {name = "GridLayoutFrame", parent = "UIParent", point = "BOTTOM", rpoint = "BOTTOM", x = -0.5, y = 2},
					},
					frameshrhealing = {
						[1] = {name = "GridLayoutFrame", parent = "RealUIPositionersLayoutBottomItem", point = "TOP", rpoint = "CENTER", x = 0, y = 0},
					},
				},
				raven = {
					frames = {
						[1] = {name = "RavenBarGroupPlayerBuffs", 	parent = "oUF_RealUIPlayer", 	point = "LEFT", 	rpoint = "LEFT", 	x = -49, 	y = 0.5},
						[2] = {name = "RavenBarGroupPlayerDebuffs", parent = "oUF_RealUIPlayer", 	point = "LEFT", 	rpoint = "LEFT", 	x = -183.5, y = 22.5},
						[3] = {name = "RavenBarGroupTargetBuffs", 	parent = "oUF_RealUITarget", 	point = "RIGHT", 	rpoint = "RIGHT", 	x = 49, 	y = 0.5},
						[4] = {name = "RavenBarGroupTargetDebuffs", parent = "oUF_RealUITarget", 	point = "RIGHT", 	rpoint = "RIGHT", 	x = 183.5, 	y = 22.5},
						[5] = {name = "RavenBarGroupFocusBuffs", 	parent = "oUF_RealUIFocus", 	point = "LEFT", 	rpoint = "LEFT", 	x = -59, 	y = -6.5},
						[6] = {name = "RavenBarGroupFocusDebuffs", 	parent = "oUF_RealUIFocus", 	point = "LEFT", 	rpoint = "LEFT", 	x = -59, 	y = -34.5},
						[7] = {name = "RavenBarGroupToTDebuffs", 	parent = "oUF_RealUITargetTarget", point = "RIGHT", rpoint = "RIGHT", 	x = 59, 	y = -6.5},
					},
				},
			},
			uiframes = {
				["**"] = {
					move = true,
				},
				zonetext = {
					frames = {
						[1] = {name = "ZoneTextFrame", parent = "UIParent", point = "TOP", rpoint = "TOP", x = 0, y = -85},
					},
				},
				raidmessages = {
					frames = {
						[1] = {name = "RaidWarningFrame", parent = "RealUIPositionersCenter", point = "CENTER", rpoint = "CENTER", x = 0, y = 183},
					},
				},
				errorframe = {
					frames = {
						[1] = {name = "UIErrorsFrame", parent = "RealUIPositionersCenter", point = "BOTTOM", rpoint = "CENTER", x = 0, y = 138},
					},
				},
				ticketstatus = {
					frames = {
						[1] = {name = "TicketStatusFrame", parent = "UIParent", point = "TOP", rpoint = "TOP", x = -220, y = -8},
					},
				},
				worldstate = {
					frames = {
						[1] = {name = "WorldStateAlwaysUpFrame", parent = "UIParent", point = "TOP", rpoint = "TOP", x = -5, y = -20},
					},
				},
				vsi = {
					frames = {
						[1] = {name = "VehicleSeatIndicator", parent = "UIParent", point = "TOPRIGHT", rpoint = "TOPRIGHT", x = -10, y = -72},
					},
				},
				playerpowerbaralt = {
					frames = {
						[1] = {name = "PlayerPowerBarAlt", parent = "UIParent", point = "CENTER", rpoint = "CENTER", x = 295, y = -275},
					},
				},
			},
			hide = {
				["**"] = {
					hide = true,
				},
				raid = {
					hide = true,
				},
			},
		},
	})
	db = self.db.profile
	ndb = nibRealUI.db.profile
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterPlainOptions(MODNAME, GetOptions)
end

function FrameMover:OnEnable()
	if db.hide.raid.hide then
		CompactUnitFrameProfiles:UnregisterAllEvents()
		
		if not IsAddOnLoaded("Blizzard_CompactRaidFrames") then
			LoadAddOn("Blizzard_CompactRaidFrames")
			compactRaid = CompactRaidFrameManager_GetSetting("IsShown")
		end
		CompactRaidFrameManager:UnregisterAllEvents()
		CompactRaidFrameContainer:UnregisterAllEvents()
		InterfaceOptionsFrameCategoriesButton11:SetScale(0.0001)
	end
	if db.hide.party.hide then
		InterfaceOptionsFrameCategoriesButton10:SetScale(0.0001)
	end
	if db.hide.raid.hide and db.hide.part.hide then
		InterfaceOptionsFrameCategoriesButton9:SetScale(0.0001)
	end
	
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("GROUP_ROSTER_UPDATE", "HidePartyRaid")
	self:RegisterEvent("PLAYER_ALIVE", "HidePartyRaid")
	self:RegisterEvent("PLAYER_DEAD", "HidePartyRaid")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateLockdown")
end

function FrameMover:OnDisable()
	self:UnregisterAllEvents()
end