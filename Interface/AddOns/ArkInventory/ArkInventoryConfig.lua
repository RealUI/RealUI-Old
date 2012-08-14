--[[
	
	info.options = the options table
	info[0] = slash command
	info[1] = first group name
	info[#info] = current option name
	info.arg
	info.handler
	info.type
	info.option = current option
	info.uiType
	info.uiName
	
	Currently inherited are: set, get, func, confirm, validate, disabled, hidden
	
]]--

local function ConfigGetNode( info, level )
	
	local level = level or #info - 1
	if level < 1 then level = 1 end
	if level > #info then level = #info end
	
	local node = info.options
	
	for k = 1, level do
		node = node.args[info[k]]
	end
	
	return node
	
end

local function ConfigGetNodeArg( info, level )
	
	local n = ConfigGetNode( info, level )
	
	if not n or n.arg == nil then
		local p = ""
		for k = 1, #info do
			p = string.format( "%s:%s", p, info[k] )
		end
		ArkInventory.OutputWarning( "invalid data (level ", level - #info, ") requested from:  ", p )
		return nil
	end
	
	return n.arg
	
end

local anchorpoints = {
	[ArkInventory.Const.Anchor.TopRight] = ArkInventory.Localise["TOPRIGHT"],
	[ArkInventory.Const.Anchor.BottomRight] = ArkInventory.Localise["BOTTOMRIGHT"],
	[ArkInventory.Const.Anchor.BottomLeft] = ArkInventory.Localise["BOTTOMLEFT"],
	[ArkInventory.Const.Anchor.TopLeft] = ArkInventory.Localise["TOPLEFT"],
}

function ArkInventory.ConfigBlizzard( )
	
	local path = ArkInventory.Config.Blizzard
	
	path.args = {
		version = {
			order = 100,
			name = ArkInventory.Global.Version,
			type = "description",
		},
		notes = {
			order = 200,
			name = function( )
				local t = GetAddOnMetadata( ArkInventory.Const.Program.Name, string.format( "Notes-%s", GetLocale( ) ) ) or ""
				if t == "" then
					t = GetAddOnMetadata( ArkInventory.Const.Program.Name, "Notes" ) or ""
				end
				return t or ""
			end,
			type = "description",
		},
		config = {
			order = 300,
			name = ArkInventory.Localise["CONFIG"],
			desc = ArkInventory.Localise["CONFIG_TEXT"],
			type = "execute",
			func = function( )
				ArkInventory.Frame_Config_Show( )
			end,
		},
		enabled = {
			order = 400,
			name = ArkInventory.Localise["ENABLED"],
			type = "toggle",
			get = function( info )
				return ArkInventory:IsEnabled( )
			end,
			set = function( info, v )
				if v then
					ArkInventory:Enable( )
				else
					ArkInventory:Disable( )
				end
			end,
		},
		debug = {
			order = 500,
			name = ArkInventory.Localise["CONFIG_DEBUG"],
			type = "toggle",
			get = function( info )
				return ArkInventory.Const.Debug
			end,
			set = function( info, v )
				ArkInventory.OutputDebugModeSet( not ArkInventory.Const.Debug )
			end,
		},
		
		-- slash commands
		
		restack = {
			guiHidden = true,
			order = 9000,
			type = "execute",
			name = ArkInventory.Localise["RESTACK"],
			desc = ArkInventory.Localise["RESTACK_TEXT"],
			func = function( )
				ArkInventory.Restack( )
			end,
		},
		
		cache = {
			guiHidden = true,
			order = 9000,
			name = ArkInventory.Localise["SLASH_CACHE"],
			desc = ArkInventory.Localise["SLASH_CACHE_TEXT"],
			type = "group",
			args = {
				erase = {
					name = ArkInventory.Localise["SLASH_CACHE_ERASE"],
					desc = ArkInventory.Localise["SLASH_CACHE_ERASE_TEXT"],
					type = "group",
					args = {
						confirm = {
							name = ArkInventory.Localise["SLASH_CACHE_ERASE_CONFIRM"],
							desc = ArkInventory.Localise["SLASH_CACHE_ERASE_CONFIRM_TEXT"],
							type = "execute",
							func = function( )
								ArkInventory.EraseSavedData( )
							end,
						},
					},
				},
			},
		},
		
		edit = {
			guiHidden = true,
			order = 9000,
			name = ArkInventory.Localise["MENU_ACTION_EDITMODE"],
			type = "execute",
			func = function( )
				ArkInventory.Frame_Main_Show( ArkInventory.Const.Location.Bag )
				ArkInventory.ToggleEditMode( )
			end,
		},
		
		rules = {
			guiHidden = true,
			order = 9000,
			name = ArkInventory.Localise["CONFIG_RULES"],
			type = "execute",
			func = function( )
				ArkInventory.Frame_Rules_Toggle( )
			end,
		},
		
		search = {
			guiHidden = true,
			order = 9000,
			name = ArkInventory.Localise["SEARCH"],
			type = "execute",
			func = function( )
				ArkInventory.Frame_Search_Toggle( )
			end,
		},
		
		track = {
			guiHidden = true,
			order = 9000,
			name = ArkInventory.Localise["SLASH_TRACK"],
			desc = ArkInventory.Localise["SLASH_TRACK_TEXT"],
			type = "input",
			set = function( info, v )
				
				local name, h = GetItemInfo( v )
				
				if not name or not h then
					ArkInventory.OutputWarning( "no matching item found: ", v )
					return
				end
				
				local class, id = ArkInventory.ObjectStringDecode( h )
				
				if class ~= "item" then
					ArkInventory.OutputWarning( "not an item: ", v )
					return
				end
				
				if ArkInventory.db.global.option.tracking.items[id] then
					--remove
					ArkInventory.db.global.option.tracking.items[id] = nil
					ArkInventory.db.char.option.ldb.tracking.item.tracked[id] = false
					ArkInventory.Output( "Removed ", h, " from tracking list" )
				else
					--add
					ArkInventory.db.global.option.tracking.items[id] = true
					ArkInventory.db.char.option.ldb.tracking.item.tracked[id] = true
					ArkInventory.Output( "Added ", h, " to tracking list" )
				end
				
				ArkInventory.LDB.Tracking_Item:Update( )
				
			end,
		},
		
		translate = {
			guiHidden = true,
			order = 9000,
			name = "translate", -- ArkInventory.Localise["MENU_ACTION_EDITMODE"],
			desc = "attempts to get translations from the game again, a ui reload might be better",
			type = "execute",
			func = function( )
				ArkInventory.TranslateTryAgain( )
			end,
		},
		
		reposition = {
			guiHidden = true,
			order = 9000,
			name = "Reposition",
			desc = "repositions all arkinventory frames inside the game window, if the frame is already fully inside then it wont move",
			type = "execute",
			func = function( )
				ArkInventory.Frame_Main_Reposition_All( )
			end,
		},
		
		summon = {
			guiHidden = true,
			order = 9000,
			name = "summon a pet or mount",
			type = "group",
			args = {
				mount = {
					order = 100,
					name = ArkInventory.Localise["LDB_MOUNTS_SUMMON"],
					type = "execute",
					func = function( )
						ArkInventory.LDB.Mounts.OnClick( )
					end,
				},
				pet = {
					order = 100,
					name = ArkInventory.Localise["LDB_PETS_SUMMON"],
					type = "execute",
					func = function( )
						ArkInventory.LDB.Pets.OnClick( )
					end,
				},
			},
		},
		
--[[
		db = {
			guiHidden = true,
			order = 9000,
			name = ArkInventory.Localise["SLASH_DB"],
			desc = ArkInventory.Localise["SLASH_DB_TEXT"],
			type = "group",
			args = {
				reset = {
					name = ArkInventory.Localise["SLASH_DB_RESET"],
					desc = ArkInventory.Localise["SLASH_DB_RESET_TEXT"],
					type = "group",
					args = {
						confirm = {
							name = ArkInventory.Localise["SLASH_DB_RESET_CONFIRM"],
							desc = ArkInventory.Localise["SLASH_DB_RESET_CONFIRM_TEXT"],
							type = "execute",
							func = function( )
								ArkInventory.DatabaseReset( )
							end,
						},
					},
				},
			},
		},
]]--
		
	}
	
end

function ArkInventory.ConfigInternal( )
	
	local cp = ArkInventory.Global.Me
	local player_id = cp.info.player_id
	local path = ArkInventory.Config.Internal
	
	path.args = {
		
		version = {
			cmdHidden = true,
			order = 100,
			name = ArkInventory.Global.Version,
			type = "description",
		},
		
		notes = {
			cmdHidden = true,
			order = 200,
			name = function( ) 
				local t = GetAddOnMetadata( ArkInventory.Const.Program.Name, string.format( "Notes-%s", GetLocale( ) ) ) or ""
				if t == "" then
					t = GetAddOnMetadata( ArkInventory.Const.Program.Name, "Notes" ) or ""
				end
				return t or ""
			end,
			type = "description",
		},
		
		system = {
			cmdHidden = true,
			order = 300,
			name = ArkInventory.Localise["CONFIG_SYSTEM"],
			desc = ArkInventory.Localise["CONFIG_SYSTEM_TEXT"],
			type = "group",
			args = {
				font = {
					order = 100,
					name = ArkInventory.Localise["FONT"],
					desc = ArkInventory.Localise["CONFIG_SYSTEM_FONT_TEXT"],
					type = "select",
					dialogControl = "LSM30_Font",
					values = ArkInventory.Lib.SharedMedia:HashTable( ArkInventory.Lib.SharedMedia.MediaType.FONT ),
					get = function( info )
						return ArkInventory.db.profile.option.font.name or ArkInventory.Const.Font.Face
					end,
					set = function( info, v )
						ArkInventory.db.profile.option.font.name = v
						ArkInventory.MediaSetFontAll( )
					end,
				},
				framestrata = {
					order = 150,
					name = ArkInventory.Localise["CONFIG_SYSTEM_FRAMESTRATA"],
					desc = ArkInventory.Localise["CONFIG_SYSTEM_FRAMESTRATA_TEXT"],
					type = "select",
					values = function( )
						local t = { }
						t[1] = ArkInventory.Localise["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_LOW"]
						t[2] = ArkInventory.Localise["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_MEDIUM"]
						t[3] = ArkInventory.Localise["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_HIGH"]
						return t
					end,
					get = function( info )
						local v = ArkInventory.db.profile.option.frameStrata
						if v == "LOW" then
							return 1
						elseif v == "HIGH" then
							return 3
						else
							return 2
						end
					end,
					set = function( info, v )
						
						local v = v
						if v ==1 then
							v = "LOW"
						elseif v == 3 then
							v = "HIGH"
						else
							v = "MEDIUM"
						end
						
						ArkInventory.db.profile.option.frameStrata = v
						
						for loc_id in pairs( ArkInventory.Global.Location ) do
							ArkInventory.Frame_Main_Hide( loc_id )
						end
						
						ArkInventory.Frame_Search_Hide( )
						ArkInventory.Frame_Rules_Hide( )
						
					end,
				},
				tooltip = {
					order = 200,
					name = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP"],
					type = "group",
					--inline = true,
					args = {
						basic = {
							order = 100,
							name = ArkInventory.Localise["GENERAL"],
							type = "group",
							inline = true,
							args = {
								show = {
									order = 100,
									name = ArkInventory.Localise["ENABLED"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_ENABLE_TEXT"],
									type = "toggle",
									get = function( info )
										return ArkInventory.db.global.option.tooltip.show
									end,
									set = function( info, v )
										ArkInventory.db.global.option.tooltip.show = v
									end,
								},
								paint = {
									order = 200,
									name = ArkInventory.Localise["COLOUR"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_CLASSCOLOUR_TEXT"],
									type = "toggle",
									hidden = function( info )
										return not ArkInventory.db.global.option.tooltip.show
									end,
									get = function( info )
										return ArkInventory.db.global.option.tooltip.colour.class
									end,
									set = function( info, v )
										ArkInventory.db.global.option.tooltip.colour.class = v
										ArkInventory.ObjectCountClear( )
									end,
								},
								empty = {
									order = 300,
									name = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_EMPTY_ADD"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_EMPTY_ADD_TEXT"],
									type = "toggle",
									hidden = function( info )
										return not ArkInventory.db.global.option.tooltip.show
									end,
									get = function( info )
										return ArkInventory.db.global.option.tooltip.add.empty
									end,
									set = function( info, v )
										ArkInventory.db.global.option.tooltip.add.empty = v
									end,
								},
							},
						},
						scale = {
							order = 200,
							name = ArkInventory.Localise["SCALE"],
							type = "group",
							inline = true,
							hidden = function( info )
								return not ArkInventory.db.global.option.tooltip.show
							end,
							args = {
								enabled = {
									order = 100,
									name = ArkInventory.Localise["ENABLED"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_SCALE_TEXT"],
									type = "toggle",
									get = function( info )
										return ArkInventory.db.global.option.tooltip.scale.enabled
									end,
									set = function( info, v )
										ArkInventory.db.global.option.tooltip.scale.enabled = v
										for _, obj in pairs( ArkInventory.Global.Tooltip.WOW ) do
											if v then
												obj:SetScale( ArkInventory.db.global.option.tooltip.scale.amount or 1 )
											else
												obj:SetScale( 1 )
											end
										end
									end,
								},
								value = {
									order = 200,
									name = ArkInventory.Localise["SCALE"],
									type = "range",
									min = 0.5,
									max = 2,
									hidden = function( )
										return not ArkInventory.db.global.option.tooltip.scale.enabled
									end,
									step = 0.05,
									isPercent = true,
									get = function( info )
										return ArkInventory.db.global.option.tooltip.scale.amount
									end,
									set = function( info, v )
										local v = math.floor( v / 0.05 ) * 0.05
										if v < 0.5 then v = 0.5 end
										if v > 2 then v = 2 end
										if ArkInventory.db.global.option.tooltip.scale.amount ~= v then
											ArkInventory.db.global.option.tooltip.scale.amount = v
											for _, obj in pairs( ArkInventory.Global.Tooltip.WOW ) do
												obj:SetScale( ArkInventory.db.global.option.tooltip.scale.amount or 1 )
											end
										end
									end,
								},
							},
						},
						count = {
							order = 300,
							name = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_ADD"],
							type = "group",
							inline = true,
							hidden = function( info )
								return not ArkInventory.db.global.option.tooltip.show
							end,
							args = {
								enabled = {
									order = 100,
									name = ArkInventory.Localise["ENABLED"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_ADD_TEXT"],
									type = "toggle",
									get = function( info )
										return ArkInventory.db.global.option.tooltip.add.count
									end,
									set = function( info, v )
										ArkInventory.db.global.option.tooltip.add.count = v
									end,
								},
								colour = {
									order = 200,
									name = ArkInventory.Localise["COLOUR"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_COLOUR_TEXT"],
									type = "color",
									hasAlpha = false,
									hidden = function( )
										return not ArkInventory.db.global.option.tooltip.add.count
									end,
									get = function( info )
										local r = ArkInventory.db.global.option.tooltip.colour.count.r
										local g = ArkInventory.db.global.option.tooltip.colour.count.g
										local b = ArkInventory.db.global.option.tooltip.colour.count.b
										return r, g, b
									end,
									set = function( info, r, g, b )
										ArkInventory.db.global.option.tooltip.colour.count.r = r
										ArkInventory.db.global.option.tooltip.colour.count.g = g
										ArkInventory.db.global.option.tooltip.colour.count.b = b
									end,
								},
								me = {
									order = 300,
									name = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_SELF_ONLY"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_SELF_ONLY_TEXT"],
									type = "toggle",
									hidden = function( )
										return not ArkInventory.db.global.option.tooltip.show or not ArkInventory.db.global.option.tooltip.add.count
									end,
									get = function( info )
										return ArkInventory.db.global.option.tooltip.me
									end,
									set = function( info, v )
										ArkInventory.db.global.option.tooltip.me = v
										ArkInventory.ObjectCountClear( )
									end,
								},
								faction = {
									order = 400,
									name = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_FACTION_ONLY"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_FACTION_ONLY_TEXT"],
									type = "toggle",
									hidden = function( )
										return not ArkInventory.db.global.option.tooltip.show or not ArkInventory.db.global.option.tooltip.add.count or ArkInventory.db.global.option.tooltip.me
									end,
									get = function( info )
										return ArkInventory.db.global.option.tooltip.faction
									end,
									set = function( info, v )
										ArkInventory.db.global.option.tooltip.faction = v
										ArkInventory.ObjectCountClear( )
									end,
								},
								vault = {
									order = 500,
									name = ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].Name,
									desc = string.format( ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_VAULT_TEXT"], ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].Name ),
									type = "toggle",
									hidden = function( )
										return not ArkInventory.db.global.option.tooltip.show or not ArkInventory.db.global.option.tooltip.add.count or ArkInventory.db.global.option.tooltip.me
									end,
									get = function( info )
										return ArkInventory.db.global.option.tooltip.add.vault
									end,
									set = function( info, v )
										ArkInventory.db.global.option.tooltip.add.vault = v
										ArkInventory.ObjectCountClear( )
									end,
								},
								showtabs = {
									order = 600,
									name = ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_VAULT_TABS"],
									desc = string.format( ArkInventory.Localise["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_VAULT_TABS_TEXT"], ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].Name ),
									type = "toggle",
									hidden = function( )
										return not ArkInventory.db.global.option.tooltip.show or not ArkInventory.db.global.option.tooltip.add.count or ArkInventory.db.global.option.tooltip.me or not ArkInventory.db.global.option.tooltip.add.vault
									end,
									get = function( info )
										return ArkInventory.db.global.option.tooltip.add.tabs
									end,
									set = function( info, v )
										ArkInventory.db.global.option.tooltip.add.tabs = v
										ArkInventory.ObjectCountClear( )
									end,
								},
							},
						},
					},
				},
				bugfix = {
					order = 300,
					name = ArkInventory.Localise["CONFIG_SYSTEM_BUGFIX"],
					type = "group",
					--inline = true,
					args = {
						framelevel = {
							order = 100,
							name = ArkInventory.Localise["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL"],
							type = "group",
							inline = true,
							args = {
								desc = {
									order = 100,
									name = ArkInventory.Localise["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_TEXT"],
									type = "description",
								},
								enabled = {
									order = 200,
									name = ArkInventory.Localise["ENABLED"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_BUGFIX_TEXT"],
									type = "toggle",
									get = function( info )
										return ArkInventory.db.global.option.bugfix.framelevel.enable
									end,
									set = function( info, v )
										ArkInventory.db.global.option.bugfix.framelevel.enable = v
										ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Init )
									end,
								},
								alert = {
									order = 300,
									name = ArkInventory.Localise["ALERT"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_TEXT"],
									type = "select",
									hidden = function( )
										return not ArkInventory.db.global.option.bugfix.framelevel.enable
									end,
									values = function( )
										local t = { }
										t[0] = ArkInventory.Localise["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE0"]
										t[1] = ArkInventory.Localise["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE1"]
										t[2] = ArkInventory.Localise["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE2"]
										return t
									end,
									get = function( info )
										return ArkInventory.db.global.option.bugfix.framelevel.alert or 0
									end,
									set = function( info, v )
										ArkInventory.db.global.option.bugfix.framelevel.alert = v
									end,
								},
							},
						},
						zerosizebag = {
							order = 200,
							name = ArkInventory.Localise["CONFIG_SYSTEM_BUGFIX_ZEROSIZEBAG"],
							type = "group",
							inline = true,
							args = {
								desc = {
									order = 100,
									name = ArkInventory.Localise["CONFIG_SYSTEM_BUGFIX_ZEROSIZEBAG_TEXT"],
									type = "description",
								},
								enabled = {
									order = 200,
									name = ArkInventory.Localise["ENABLED"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_BUGFIX_TEXT"],
									type = "toggle",
									disabled = true,
									get = function( info )
										return ArkInventory.db.global.option.bugfix.zerosizebag.enable
									end,
									set = function( info, v )
										ArkInventory.db.global.option.bugfix.zerosizebag.enable = v
									end,
								},
								alert = {
									order = 300,
									name = ArkInventory.Localise["ALERT"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_BUGFIX_ZEROSIZEBAG_ALERT_TEXT"],
									type = "toggle",
									hidden = function( )
										return not ArkInventory.db.global.option.bugfix.zerosizebag.enable
									end,
									get = function( info )
										return ArkInventory.db.global.option.bugfix.zerosizebag.alert
									end,
									set = function( info, v )
										ArkInventory.db.global.option.bugfix.zerosizebag.alert = v
									end,
								},
							},
						},
					},
				},
				bucket = {
					cmdHidden = true,
					order = 400,
					name = "update timers",
					desc = "description for update timers",
					type = "group",
					--inline = true,
					args = {
						bag = {
							order = 100,
							name = ArkInventory.Localise["LOCATION_BAG"],
							type = "group",
							inline = true,
							args = {
								enabled = {
									order = 100,
									name = "customise",
									desc = "use a custom value for the bag update timer",
									type = "toggle",
									get = function( info )
										return ArkInventory.db.global.option.bucket[ArkInventory.Const.Location.Bag]
									end,
									set = function( info, v )
										if not v then
											ArkInventory.db.global.option.bucket[ArkInventory.Const.Location.Bag] = nil
										else
											ArkInventory.db.global.option.bucket[ArkInventory.Const.Location.Bag] = 0.5
										end
									end,
								},
								value = {
									order = 200,
									name = "seconds",
									type = "range",
									min = 0.1,
									max = 2,
									hidden = function( )
										return not ArkInventory.db.global.option.bucket[ArkInventory.Const.Location.Bag]
									end,
									step = 0.05,
									get = function( info )
										return ArkInventory.db.global.option.bucket[ArkInventory.Const.Location.Bag] or 0.5
									end,
									set = function( info, v )
										local v = math.floor( v / 0.05 ) * 0.05
										if v < 0.1 then v = 0.1 end
										if v > 2 then v = 2 end
										ArkInventory.db.global.option.bucket[ArkInventory.Const.Location.Bag] = v
									end,
								},
							},
						},
						vault = {
							order = 200,
							name = "vault",
							type = "group",
							inline = true,
							args = {
								enabled = {
									order = 100,
									name = "customise",
									desc = "use a custom value for the vault update timer",
									type = "toggle",
									get = function( info )
										return ArkInventory.db.global.option.bucket[ArkInventory.Const.Location.Vault]
									end,
									set = function( info, v )
										if not v then
											ArkInventory.db.global.option.bucket[ArkInventory.Const.Location.Vault] = nil
										else
											ArkInventory.db.global.option.bucket[ArkInventory.Const.Location.Vault] = 1.5
										end
									end,
								},
								value = {
									order = 200,
									name = "seconds",
									type = "range",
									min = 0.1,
									max = 4,
									hidden = function( )
										return not ArkInventory.db.global.option.bucket[ArkInventory.Const.Location.Vault]
									end,
									step = 0.05,
									get = function( info )
										return ArkInventory.db.global.option.bucket[ArkInventory.Const.Location.Vault] or 1.5
									end,
									set = function( info, v )
										local v = math.floor( v / 0.05 ) * 0.05
										if v < 0.1 then v = 0.1 end
										if v > 4 then v = 4 end
										ArkInventory.db.global.option.bucket[ArkInventory.Const.Location.Vault] = v
									end,
								},
							},
						},
					},
				},
				messages = {
					cmdHidden = true,
					order = 500,
					name = ArkInventory.Localise["CONFIG_SYSTEM_MESSAGES"],
					type = "group",
					args = {
						translation = {
							order = 100,
							name = ArkInventory.Localise["CONFIG_SYSTEM_MESSAGES_TRANSLATION"],
							type = "group",
							inline = true,
							args = {
								interim = {
									order = 100,
									name = ArkInventory.Localise["CONFIG_SYSTEM_MESSAGES_TRANSLATION_INTERIM"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_MESSAGES_TRANSLATION_INTERIM_TEXT"],
									type = "toggle",
									get = function( info )
										return ArkInventory.db.global.option.message.translation.interim
									end,
									set = function( info, v )
										ArkInventory.db.global.option.message.translation.interim = v
									end,
								},
								final = {
									order = 200,
									name = ArkInventory.Localise["CONFIG_SYSTEM_MESSAGES_TRANSLATION_FINAL"],
									desc = ArkInventory.Localise["CONFIG_SYSTEM_MESSAGES_TRANSLATION_FINAL_TEXT"],
									type = "toggle",
									get = function( info )
										return ArkInventory.db.global.option.message.translation.final
									end,
									set = function( info, v )
										ArkInventory.db.global.option.message.translation.final = v
									end,
								},
							},
						},
					},
				},
			},
		},
		
		auto = {
			cmdHidden = true,
			order = 400,
			name = ArkInventory.Localise["CONFIG_AUTO"],
			type = "group",
			args = {
				auto_open = {
					order = 100,
					type = "group",
					inline = true,
					name = ArkInventory.Localise["OPEN"],
					args = {
						bank = {
							order = 100,
							name = ArkInventory.Localise["CONFIG_AUTO_OPEN_BANK"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_OPEN"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_OPEN_BANK"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.open.bank
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.open.bank = v
							end,
						},
						vault = {
							order = 200,
							name = ArkInventory.Localise["CONFIG_AUTO_OPEN_VAULT"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_OPEN"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_OPEN_VAULT"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.open.vault
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.open.vault = v
							end,
						},
						mail = {
							order = 300,
							name = ArkInventory.Localise["CONFIG_AUTO_OPEN_MAIL"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_OPEN"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_OPEN_MAIL"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.open.mail
								--return true
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.open.mail = v
							end,
						},
						merchant = {
							order = 400,
							name = ArkInventory.Localise["CONFIG_AUTO_OPEN_MERCHANT"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_OPEN"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_OPEN_MERCHANT"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.open.merchant
								--return true
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.open.merchant = v
							end,
						},
						trade = {
							order = 500,
							name = ArkInventory.Localise["CONFIG_AUTO_OPEN_TRADE"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_OPEN"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_OPEN_TRADE"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.open.trade
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.open.trade = v
							end,
						},
						auction = {
							order = 600,
							name = ArkInventory.Localise["CONFIG_AUTO_OPEN_AUCTION"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_OPEN"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_OPEN_AUCTION"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.open.auction
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.open.auction = v
							end,
						},
						void = {
							order = 700,
							name = ArkInventory.Localise["CONFIG_AUTO_OPEN_VOID"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_OPEN"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_OPEN_VOID"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.open.void
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.open.void = v
							end,
						},
					},
				},
				auto_close = {
					order = 200,
					type = "group",
					inline = true,
					name = ArkInventory.Localise["CLOSE"],
					args = {
						bank = {
							order = 100,
							name = ArkInventory.Localise["CONFIG_AUTO_CLOSE_BANK"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_CLOSE"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_CLOSE_BANK"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.close.bank
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.close.bank = v
							end,
						},
						vault = {
							order = 200,
							name = ArkInventory.Localise["CONFIG_AUTO_CLOSE_VAULT"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_CLOSE"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_CLOSE_VAULT"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.close.vault
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.close.vault = v
							end,
						},
						mail = {
							order = 300,
							name = ArkInventory.Localise["CONFIG_AUTO_CLOSE_MAIL"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_CLOSE"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_CLOSE_MAIL"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.close.mail
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.close.mail = v
							end,
						},
						merchant = {
							order = 400,
							name = ArkInventory.Localise["CONFIG_AUTO_CLOSE_MERCHANT"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_CLOSE"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_CLOSE_MERCHANT"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.close.merchant
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.close.merchant = v
							end,
						},
						trade = {
							order = 500,
							name = ArkInventory.Localise["CONFIG_AUTO_CLOSE_TRADE"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_CLOSE"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_CLOSE_TRADE"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.close.trade
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.close.trade = v
							end,
						},
						auction = {
							order = 600,
							name = ArkInventory.Localise["CONFIG_AUTO_CLOSE_AUCTION"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_CLOSE"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_CLOSE_AUCTION"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.close.auction
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.close.auction = v
							end,
						},
						void = {
							order = 700,
							name = ArkInventory.Localise["CONFIG_AUTO_CLOSE_VOID"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_CLOSE"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_CLOSE_VOID"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.close.void
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.close.void = v
							end,
						},
						combat = {
							order = 800,
							name = ArkInventory.Localise["CONFIG_AUTO_CLOSE_COMBAT"],
							desc = string.format( ArkInventory.Localise["CONFIG_AUTO_CLOSE"], ArkInventory.Const.Program.Name, ArkInventory.Localise["LOCATION_BAG"], ArkInventory.Localise["CONFIG_AUTO_CLOSE_COMBAT"] ), 
							type = "toggle",
							get = function( info )
								return ArkInventory.db.global.option.auto.close.combat
							end,
							set = function( info, v )
								ArkInventory.db.global.option.auto.close.combat = v
							end,
						},
					},
				},
			},
		},
		
		sorting = {
			cmdHidden = true,
			order = 500,
			name = ArkInventory.Localise["CONFIG_SORTMETHOD"],
			type = "group",
			childGroups = "tab",
			args = { },
		},
		
		settings = {
			cmdHidden = true,
			order = 600,
			name = ArkInventory.Localise["CONFIG_SETTINGS"],
			type = "group",
			childGroups = "tab",
			args = { }, -- computed
		},
		
		control = {
			cmdHidden = true,
			order = 700,
			name = ArkInventory.Localise["CONFIG_CONTROL"],
			type = "group",
			childGroups = "tab",
			args = { }, -- computed 
		},
		
		categories = {
			cmdHidden = true,
			order = 800,
			name = ArkInventory.Localise["CONFIG_CATEGORY"],
			type = "group",
			childGroups = "tab",
			args = { },
		},
		
		search = {
			cmdHidden = true,
			order = 1000,
			name = ArkInventory.Localise["SEARCH"],
			type = "group",
			args = {
				display = {
					order = 100,
					name = ArkInventory.Localise["SHOW"],
					desc = ArkInventory.Localise["SEARCH"],
					type = "execute",
					func = function( )
						ArkInventory.Frame_Search_Show( )
					end,
				},
				scale = {
					order = 200,
					name = ArkInventory.Localise["SCALE"],
					desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_SCALE_TEXT"],
					type = "range",
					min = 0.4,
					max = 2,
					step = 0.05,
					isPercent = true,
					get = function( info )
						return ArkInventory.db.profile.option.ui.search.scale
					end,
					set = function( info, v )
						local v = math.floor( v / 0.05 ) * 0.05
						if v < 0.4 then v = 0.4 end
						if v > 2 then v = 2 end
						if ArkInventory.db.profile.option.ui.search.scale ~= v then
							ArkInventory.db.profile.option.ui.search.scale = v
							ArkInventory.Frame_Search_Paint( )
						end
					end,
				},
				background = {
					order = 200,
					name = ArkInventory.Localise["BACKGROUND"],
					type = "group",
					--inline = true,
					args = {
						style = {
							order = 100,
							name = ArkInventory.Localise["STYLE"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_BORDER_STYLE_TEXT"],
							type = "select",
							dialogControl = "LSM30_Background",
							values = ArkInventory.Lib.SharedMedia:HashTable( ArkInventory.Lib.SharedMedia.MediaType.BACKGROUND ),
							get = function( info )
								return ArkInventory.db.profile.option.ui.search.background.style or ArkInventory.Const.Texture.BackgroundDefault
							end,
							set = function( info, v )
								if ArkInventory.db.profile.option.ui.search.background.style ~= v then
									ArkInventory.db.profile.option.ui.search.background.style = v
									ArkInventory.Frame_Search_Paint( )
								end
							end,
						},
						colour = {
							order = 200,
							name = ArkInventory.Localise["COLOUR"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_BACKGROUND_COLOUR_TEXT"],
							type = "color",
							hasAlpha = true,
							hidden = function( info )
								return ArkInventory.db.profile.option.ui.search.background.style ~= ArkInventory.Const.Texture.BackgroundDefault
							end,
							get = function( info )
								return ArkInventory.db.profile.option.ui.search.background.colour.r, ArkInventory.db.profile.option.ui.search.background.colour.g, ArkInventory.db.profile.option.ui.search.background.colour.b, ArkInventory.db.profile.option.ui.search.background.colour.a
							end,
							set = function( info, r, g, b, a )
								ArkInventory.db.profile.option.ui.search.background.colour.r = r
								ArkInventory.db.profile.option.ui.search.background.colour.g = g
								ArkInventory.db.profile.option.ui.search.background.colour.b = b
								ArkInventory.db.profile.option.ui.search.background.colour.a = a
								ArkInventory.Frame_Search_Paint( )
							end,
						},
					},
				},
				border = {
					order = 300,
					name = ArkInventory.Localise["BORDER"],
					type = "group",
					--inline = true,
					args = {
						style = {
							order = 100,
							name = ArkInventory.Localise["STYLE"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_BORDER_STYLE_TEXT"],
							type = "select",
							dialogControl = "LSM30_Border",
							values = ArkInventory.Lib.SharedMedia:HashTable( ArkInventory.Lib.SharedMedia.MediaType.BORDER ),
							get = function( info )
								return ArkInventory.db.profile.option.ui.search.border.style or ArkInventory.Const.Texture.BorderDefault
							end,
							set = function( info, v )
								if ArkInventory.db.profile.option.ui.search.border.style ~= v then
									
									ArkInventory.db.profile.option.ui.search.border.style = v
									
									local sd = ArkInventory.Const.Texture.Border[v] or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault]
									ArkInventory.db.profile.option.ui.search.border.size = sd.size
									ArkInventory.db.profile.option.ui.search.border.offset = sd.offset
									ArkInventory.db.profile.option.ui.search.border.scale = sd.scale
									
									ArkInventory.Frame_Search_Paint( )
									
								end
							end,
						},
						colour = {
							order = 200,
							name = ArkInventory.Localise["COLOUR"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_BORDER_COLOUR_TEXT"],
							type = "color",
							hidden = function( )
								return ArkInventory.db.profile.option.ui.search.border.style == ArkInventory.Const.Texture.BorderNone
							end,
							hasAlpha = false,
							get = function( info )
								return ArkInventory.db.profile.option.ui.search.border.colour.r, ArkInventory.db.profile.option.ui.search.border.colour.g, ArkInventory.db.profile.option.ui.search.border.colour.b
							end,
							set = function( info, r, g, b )
								ArkInventory.db.profile.option.ui.search.border.colour.r = r
								ArkInventory.db.profile.option.ui.search.border.colour.g = g
								ArkInventory.db.profile.option.ui.search.border.colour.b = b
								ArkInventory.Frame_Search_Paint( )
							end,
						},
						size = {
							order = 300,
							name = ArkInventory.Localise["HEIGHT"],
							type = "input",
							hidden = function( )
								 return ArkInventory.db.profile.option.ui.search.border.style == ArkInventory.Const.Texture.BorderNone
							end,
							get = function( info )
								return string.format( "%i", ArkInventory.db.profile.option.ui.search.border.size or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].size )
							end,
							set = function( info, v )
								local v = math.floor( tonumber( v ) or 0 )
								if v < 0 then v = 0 end
								if ArkInventory.db.profile.option.ui.search.border.size ~= v then
									ArkInventory.db.profile.option.ui.search.border.size = v
									ArkInventory.Frame_Search_Paint( )
								end
							end,
						},
						offset = {
							order = 400,
							name = ArkInventory.Localise["OFFSET"],
							type = "input",
							hidden = function( info )
								return ArkInventory.db.profile.option.ui.search.border.style == ArkInventory.Const.Texture.BorderNone
							end,
							get = function( info )
								return string.format( "%i", ArkInventory.db.profile.option.ui.search.border.offset or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].offset  )
							end,
							set = function( info, v )
								local v = math.floor( tonumber( v ) or 0 )
								if v < 0 then v = 0 end
								if ArkInventory.db.profile.option.ui.search.border.offset ~= v then
									ArkInventory.db.profile.option.ui.search.border.offset = v
									ArkInventory.Frame_Search_Paint( )
								end
							end,
						},
						scale = {
							order = 500,
							name = ArkInventory.Localise["SCALE"],
							desc = ArkInventory.Localise["BORDER_SCALE_TEXT"],
							type = "range",
							hidden = function( )
								return ArkInventory.db.profile.option.ui.search.border.style == ArkInventory.Const.Texture.BorderNone
							end,
							min = 0.25,
							max = 4,
							step = 0.05,
							get = function( info )
								return ArkInventory.db.profile.option.ui.search.border.scale or 1
							end,
							set = function( info, v )
								local v = math.floor( v / 0.05 ) * 0.05
								if v < 0.25 then v = 0.25 end
								if v > 4 then v = 4 end
								if ArkInventory.db.profile.option.ui.search.border.scale ~= v then
									ArkInventory.db.profile.option.ui.search.border.scale = v
									ArkInventory.Frame_Search_Paint( )
								end
							end,
						},
					},
				},
			},
		},
		
		ldb = {
			cmdHidden = true,
			order = 1100,
			name = ArkInventory.Localise["LDB"],
			type = "group",
			childGroups = "tab",
			args = {
				mounts = {
					order = 100,
					type = "group",
					childGroups = "tab",
					name = function( )
						return ArkInventory.Localise["WOW_ITEM_TYPE_MISC_MOUNT"]
					end,
					args = { },
				},
			},
		},
		
		rules = {
			cmdHidden = true,
			order = 5000,
			name = ArkInventory.Localise["CONFIG_RULES"],
			type = "group",
			hidden = function( info )
				return not IsAddOnLoaded( "ArkInventoryRules" )
			end,
			args = {
				display = {
					order = 100,
					name = ArkInventory.Localise["SHOW"],
					desc = ArkInventory.Localise["CONFIG_RULES"],
					type = "execute",
					func = function( )
						ArkInventory.Frame_Rules_Show( )
					end,
				},
				scale = {
					order = 200,
					name = ArkInventory.Localise["SCALE"],
					desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_SCALE_TEXT"],
					type = "range",
					min = 0.4,
					max = 2,
					step = 0.05,
					isPercent = true,
					get = function( info )
						return ArkInventory.db.profile.option.ui.rules.scale
					end,
					set = function( info, v )
						local v = math.floor( v / 0.05 ) * 0.05
						if v < 0.4 then v = 0.4 end
						if v > 2 then v = 2 end
						if ArkInventory.db.profile.option.ui.rules.scale ~= v then
							ArkInventory.db.profile.option.ui.rules.scale = v
							ArkInventoryRules.Frame_Rules_Paint( )
						end
					end,
				},
				background = {
					order = 200,
					name = ArkInventory.Localise["BACKGROUND"],
					type = "group",
					--inline = true,
					args = {
						style = {
							order = 100,
							name = ArkInventory.Localise["BACKGROUND"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_BORDER_STYLE_TEXT"],
							type = "select",
							dialogControl = "LSM30_Background",
							values = ArkInventory.Lib.SharedMedia:HashTable( ArkInventory.Lib.SharedMedia.MediaType.BACKGROUND ),
							get = function( info )
								return ArkInventory.db.profile.option.ui.rules.background.style or ArkInventory.Const.Texture.BackgroundDefault
							end,
							set = function( info, v )
								if ArkInventory.db.profile.option.ui.rules.background.style ~= v then
									ArkInventory.db.profile.option.ui.rules.background.style = v
									ArkInventoryRules.Frame_Rules_Paint( )
								end
							end,
						},
						colour = {
							order = 200,
							name = ArkInventory.Localise["COLOUR"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_BACKGROUND_COLOUR_TEXT"],
							type = "color",
							hasAlpha = true,
							hidden = function( info )
								return ArkInventory.db.profile.option.ui.rules.background.style ~= ArkInventory.Const.Texture.BackgroundDefault
							end,
							get = function( info )
								return ArkInventory.db.profile.option.ui.rules.background.colour.r, ArkInventory.db.profile.option.ui.rules.background.colour.g, ArkInventory.db.profile.option.ui.rules.background.colour.b, ArkInventory.db.profile.option.ui.rules.background.colour.a
							end,
							set = function( info, r, g, b, a )
								ArkInventory.db.profile.option.ui.rules.background.colour.r = r
								ArkInventory.db.profile.option.ui.rules.background.colour.g = g
								ArkInventory.db.profile.option.ui.rules.background.colour.b = b
								ArkInventory.db.profile.option.ui.rules.background.colour.a = a
								ArkInventoryRules.Frame_Rules_Paint( )
							end,
						},
					},
				},
				border = {
					order = 300,
					name = ArkInventory.Localise["BORDER"],
					type = "group",
					--inline = true,
					args = {
						style = {
							order = 100,
							name = ArkInventory.Localise["STYLE"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_BORDER_STYLE_TEXT"],
							type = "select",
							dialogControl = "LSM30_Border",
							values = ArkInventory.Lib.SharedMedia:HashTable( ArkInventory.Lib.SharedMedia.MediaType.BORDER ),
							get = function( info )
								return ArkInventory.db.profile.option.ui.rules.border.style or ArkInventory.Const.Texture.BorderDefault
							end,
							set = function( info, v )
								if v ~= ArkInventory.db.profile.option.ui.rules.border.style then
									
									ArkInventory.db.profile.option.ui.rules.border.style = v
									
									local sd = ArkInventory.Const.Texture.Border[v] or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault]
									ArkInventory.db.profile.option.ui.rules.border.size = sd.size
									ArkInventory.db.profile.option.ui.rules.border.offset = sd.offset
									ArkInventory.db.profile.option.ui.rules.border.scale = sd.scale

									ArkInventoryRules.Frame_Rules_Paint( )
									
								end
							end,
						},
						colour = {
							order = 200,
							name = ArkInventory.Localise["COLOUR"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_BORDER_COLOUR_TEXT"],
							type = "color",
							hidden = function( )
								return ArkInventory.db.profile.option.ui.rules.border.style == ArkInventory.Const.Texture.BorderNone
							end,
							hasAlpha = false,
							get = function( info )
								return ArkInventory.db.profile.option.ui.rules.border.colour.r, ArkInventory.db.profile.option.ui.rules.border.colour.g, ArkInventory.db.profile.option.ui.rules.border.colour.b
							end,
							set = function( info, r, g, b )
								ArkInventory.db.profile.option.ui.rules.border.colour.r = r
								ArkInventory.db.profile.option.ui.rules.border.colour.g = g
								ArkInventory.db.profile.option.ui.rules.border.colour.b = b
								ArkInventoryRules.Frame_Rules_Paint( )
							end,
						},
						size = {
							order = 300,
							name = ArkInventory.Localise["HEIGHT"],
							type = "input",
							hidden = function( )
								return ArkInventory.db.profile.option.ui.rules.border.style == ArkInventory.Const.Texture.BorderNone
							end,
							get = function( info )
								return string.format( "%i", ArkInventory.db.profile.option.ui.rules.border.size or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].size )
							end,
							set = function( info, v )
								local v = math.floor( tonumber( v ) or 0 )
								if v < 0 then v = 0 end
								if ArkInventory.db.profile.option.ui.rules.border.size ~= v then
									ArkInventory.db.profile.option.ui.rules.border.size = v
									ArkInventoryRules.Frame_Rules_Paint( )
								end
							end,
						},
						offset = {
							order = 400,
							name = ArkInventory.Localise["OFFSET"],
							type = "input",
							hidden = function( info )
								return ArkInventory.db.profile.option.ui.rules.border.style == ArkInventory.Const.Texture.BorderNone
							end,
							get = function( info )
								return string.format( "%i", ArkInventory.db.profile.option.ui.rules.border.offset or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].offset  )
							end,
							set = function( info, v )
								local v = math.floor( tonumber( v ) or 0 )
								if v < 0 then v = 0 end
								if ArkInventory.db.profile.option.ui.rules.border.offset ~= v then
									ArkInventory.db.profile.option.ui.rules.border.offset = v
									ArkInventoryRules.Frame_Rules_Paint( )
								end
							end,
						},
						scale = {
							order = 500,
							name = ArkInventory.Localise["SCALE"],
							desc = ArkInventory.Localise["BORDER_SCALE_TEXT"],
							type = "range",
							hidden = function( )
								return ArkInventory.db.profile.option.ui.rules.border.style == ArkInventory.Const.Texture.BorderNone
							end,
							min = 0.25,
							max = 4,
							step = 0.05,
							get = function( info )
								return ArkInventory.db.profile.option.ui.rules.border.scale or 1
							end,
							set = function( info, v )
								local v = math.floor( v / 0.05 ) * 0.05
								if v < 0.25 then v = 0.25 end
								if v > 4 then v = 4 end
								if ArkInventory.db.profile.option.ui.rules.border.scale ~= v then
									ArkInventory.db.profile.option.ui.rules.border.scale = v
									ArkInventoryRules.Frame_Rules_Paint( )
								end
							end,
						},
					},
				},
			},
		},
			
		enabled = {
			cmdHidden = true,
			order = 1200,
			name = ArkInventory.Localise["ENABLED"],
			type = "toggle",
			get = function( info )
				return ArkInventory:IsEnabled( )
			end,
			set = function( info, v )
				if v then
					ArkInventory:Enable( )
				else
					ArkInventory:Disable( )
				end
			end,
		},
		
		debug = {
			cmdHidden = true,
			order = 1300,
			name = ArkInventory.Localise["CONFIG_DEBUG"],
			type = "toggle",
			get = function( info )
				return ArkInventory.Const.Debug
			end,
			set = function( info, v )
				ArkInventory.OutputDebugModeSet( not ArkInventory.Const.Debug )
			end,
		},
		
		profiles = LibStub( "AceDBOptions-3.0" ):GetOptionsTable( ArkInventory.db ),
		
	}
	
	path.args.profiles.order = 1100
	
	ArkInventory.ConfigInternalControlSettings( path.args.control.args )
	
	ArkInventory.ConfigInternalSettings( path.args.settings.args )
	
	ArkInventory.ConfigInternalSorting( )
	
	ArkInventory.ConfigInternalCategory( )
	
	ArkInventory.ConfigInternalLDBMounts( path.args.ldb.args.mounts.args )
	
end
 
function ArkInventory.ConfigInternalControlSettings( path )
	
	local args1 = {
		monitor = {
			order = 100,
			type = "toggle",
			name = ArkInventory.Localise["CONFIG_CONTROL_MONITOR"],
			desc = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return string.format( ArkInventory.Localise["CONFIG_CONTROL_MONITOR_TEXT"], ArkInventory.Global.Location[loc_id].Name, ArkInventory.Global.Me.info.name )
			end,
			disabled = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return not ArkInventory.Global.Location[loc_id].canPurge
			end,
			get = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.realm.player.data[ArkInventory.Global.Me.info.player_id].monitor[loc_id]
			end,
			set = function( info, v )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.db.realm.player.data[ArkInventory.Global.Me.info.player_id].monitor[loc_id] = v
			end,
		},
		save = {
			order = 200,
			type = "toggle",
			name = SAVE,
			desc = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return string.format( ArkInventory.Localise["CONFIG_CONTROL_SAVE_TEXT"], ArkInventory.Global.Location[loc_id].Name, ArkInventory.Global.Me.info.name )
			end,
			disabled = function( info )
				--local loc_id = ConfigGetNodeArg( info, #info - 1 )
				--return ( loc_id == ArkInventory.Const.Location.Vault )
			end,
			get = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.realm.player.data[ArkInventory.Global.Me.info.player_id].save[loc_id]
			end,
			set = function( info, v )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.db.realm.player.data[ArkInventory.Global.Me.info.player_id].save[loc_id] = v
			end,
		},
		notifyerase = {
			order = 300,
			type = "toggle",
			name = ArkInventory.Localise["CONFIG_CONTROL_NOTIFY_ERASE"],
			desc = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return string.format( ArkInventory.Localise["CONFIG_CONTROL_NOTIFY_ERASE_TEXT"], ArkInventory.Global.Location[loc_id].Name )
			end,
			disabled = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.realm.player.data[ArkInventory.Global.Me.info.player_id].save[loc_id]
			end,
			get = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.profile.option.location[loc_id].notifyerase
			end,
			set = function( info, v )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.db.profile.option.location[loc_id].notifyerase = v
			end,
		},
		override = {
			order = 400,
			type = "toggle",
			name = ArkInventory.Localise["CONFIG_CONTROL_OVERRIDE"],
			desc = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return string.format( ArkInventory.Localise["CONFIG_CONTROL_OVERRIDE_TEXT"], ArkInventory.Const.Program.Name, ArkInventory.Global.Location[loc_id].Name )
			end,
			disabled = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return not ArkInventory.Global.Location[loc_id].canOverride
			end,
			get = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.realm.player.data[ArkInventory.Global.Me.info.player_id].control[loc_id]
			end,
			set = function( info, v )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.LocationControlSet( loc_id, v )
			end,
		},
		anchor = {
			order = 500,
			name = ArkInventory.Localise["ANCHOR"],
			desc = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return string.format( ArkInventory.Localise["ANCHOR_TEXT1"], ArkInventory.Global.Location[loc_id].Name )
			end,
			type = "select",
			values = function( )
				return anchorpoints
			end,
			get = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.profile.option.anchor[loc_id].point
			end,
			set = function( info, v )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				if ArkInventory.db.profile.option.anchor[loc_id].point ~= v then
					ArkInventory.db.profile.option.anchor[loc_id].point = v
					ArkInventory.Frame_Main_Anchor_Set( loc_id )
				end
			end,
		},
		locked = {
			order = 600,
			type = "toggle",
			name = ArkInventory.Localise["LOCK"],
			desc = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return string.format( ArkInventory.Localise["CONFIG_CONTROL_ANCHOR_LOCK_TEXT"], ArkInventory.Global.Location[loc_id].Name )
			end,
			get = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.profile.option.anchor[loc_id].locked
			end,
			set = function( info, v )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.db.profile.option.anchor[loc_id].locked = v
				ArkInventory.Frame_Main_Anchor_Set( loc_id )
			end,
		},
		reposition_onload = {
			order = 700,
			name = ArkInventory.Localise["CONFIG_CONTROL_REPOSITION_ONLOAD"],
			desc = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return string.format( ArkInventory.Localise["CONFIG_CONTROL_REPOSITION_ONLOAD_TEXT"], ArkInventory.Global.Location[loc_id].Name )
			end,
			type = "toggle",
			get = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.profile.option.anchor[loc_id].reposition
			end,
			set = function( info, v )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.db.profile.option.anchor[loc_id].reposition = v
			end,
		},
		reposition_now = {
			order = 800,
			name = ArkInventory.Localise["CONFIG_CONTROL_REPOSITION_NOW"],
			desc = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return string.format( ArkInventory.Localise["CONFIG_CONTROL_REPOSITION_NOW_TEXT"], ArkInventory.Global.Location[loc_id].Name )
			end,
			type = "execute",
			func = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.Frame_Main_Reposition( loc_id )
				ArkInventory.Frame_Main_Show( loc_id )
			end,
		},
		settings = {
			order = 900,
			type = "select",
			name = ArkInventory.Localise["CONFIG_SETTINGS"],
			desc = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return string.format( ArkInventory.Localise["CONFIG_CONTROL_SETTINGS_TEXT"], ArkInventory.Global.Location[loc_id].Name )
			end,
			values = function( )
				local t = { }
				for loc_id, loc_data in ArkInventory.spairs( ArkInventory.Global.Location ) do
					if ArkInventory.Global.Location[loc_id].canView then
						t[loc_id] = loc_data.Name
					end
				end
				return t
			end,
			get = function( info )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.profile.option.use[loc_id] or loc_id
			end,
			set = function( info, v )
				local loc_id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.db.profile.option.use[loc_id] = v
				ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Init )
			end,
		},
	}
	
	for loc_id, data in pairs( ArkInventory.Global.Location ) do
		if data.canView then
			path[string.format( "%i", loc_id )] = {
				cmdHidden = true,
				order = loc_id,
				arg = loc_id,
				name = data.Name,
				type = "group",
				args = args1,
			}
		end
	end
	
 end
 
function ArkInventory.ConfigInternalSettings( path )
	
	-- items > empty > colour
	local args2 = { }
	for k, v in pairs( ArkInventory.Const.Slot.Data ) do
		if not v.hide then
			args2[string.format( "%i", k )] = {
				order = 100,
				name = v.long,
				desc = string.format( ArkInventory.Localise["CONFIG_SETTINGS_EMPTY_COLOUR_TEXT"], v.long ),
				type = "color",
				hasAlpha = false,
				hidden = false,
				get = function( info )
					local loc_id = ConfigGetNodeArg( info, #info - 4 )
					local r = ArkInventory.LocationOptionGet( loc_id, "slot", "data", k, "colour", "r" )
					local g = ArkInventory.LocationOptionGet( loc_id, "slot", "data", k, "colour", "g" )
					local b = ArkInventory.LocationOptionGet( loc_id, "slot", "data", k, "colour", "b" )
					return r, g, b
				end,
				set = function( info, r, g, b )
					local loc_id = ConfigGetNodeArg( info, #info - 4 )
					ArkInventory.LocationOptionSet( loc_id, "slot", "data", k, "colour", "r", r )
					ArkInventory.LocationOptionSet( loc_id, "slot", "data", k, "colour", "g", g )
					ArkInventory.LocationOptionSet( loc_id, "slot", "data", k, "colour", "b", b )
					ArkInventory.Frame_Item_Empty_Paint_All( )
				end,
			}
		end
	end
	
	
	local args1 = {
		
		window = {
			order = 100,
			name = ArkInventory.Localise["CONFIG_SETTINGS_FRAME"],
			type = "group",
			args = {
				scale = {
					order = 200,
					name = ArkInventory.Localise["SCALE"],
					desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_SCALE_TEXT"],
					type = "range",
					min = 0.4,
					max = 2,
					step = 0.05,
					isPercent = true,
					get = function( info )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						return ArkInventory.LocationOptionGetReal( loc_id, "window", "scale" )
					end,
					set = function( info, v )
						local v = math.floor( v / 0.05 ) * 0.05
						if v < 0.4 then v = 0.4 end
						if v > 2 then v = 2 end
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						if ArkInventory.LocationOptionGetReal( loc_id, "window", "scale" ) ~= v then
							ArkInventory.LocationOptionSetReal( loc_id, "window", "scale", v )
							ArkInventory.Frame_Main_Scale_All( )
						end
					end,
				},
				padding = {
					order = 300,
					name = ArkInventory.Localise["PADDING"],
					desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_PADDING_TEXT"],
					type = "range",
					min = 4,
					max = 32,
					step = 1,
					get = function( info )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						return ArkInventory.LocationOptionGetReal( loc_id, "window", "pad" )
					end,
					set = function( info, v )
						local v = math.floor( v )
						if v < 4 then v = 4 end
						if v > 32 then v = 32 end
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						if v ~= ArkInventory.LocationOptionGetReal( loc_id, "window", "pad" ) then
							ArkInventory.LocationOptionSetReal( loc_id, "window", "pad", math.floor( v ) )
							ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
						end
					end,
				},
				width = {
					order = 400,
					name = ArkInventory.Localise["WIDTH"],
					desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_WIDTH_TEXT"],
					type = "range",
					min = 6,
					max = 40,
					step = 1,
					get = function( info )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						return ArkInventory.LocationOptionGetReal( loc_id, "window", "width" )
					end,
					set = function( info, v )
						local v = math.floor( v )
						if v < 6 then v = 6 end
						if v > 40 then v = 40 end
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						if v ~= ArkInventory.LocationOptionGetReal( loc_id, "window", "width" ) then
							ArkInventory.LocationOptionSetReal( loc_id, "window", "width", v )
							ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
						end
					end,
				},
				sorting = {
					order = 450,
					name = ArkInventory.Localise["CONFIG_SORTMETHOD_SORT"],
					type = "group",
					args = {
						style = {
							order = 100,
							name = ArkInventory.Localise["STYLE"],
							desc = ArkInventory.Localise["CONFIG_SORTMETHOD_STYLE_TEXT"],
							type = "select",
							values = function( )
								local t = { }
								for k, v in pairs( ArkInventory.db.global.option.sort.data ) do
									if v.used then
										local n = string.format( "%s [%04i]", v.name, k )
										if k == 0 then
											n = string.format( "%s (%s)", n, ArkInventory.Localise["DEFAULT"] )
										end
										t[k] = n
									end
								end
								return t
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								local v = ArkInventory.LocationOptionGetReal( loc_id, "sort", "default" )
								return v
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "sort", "default", v )
								ArkInventory.LocationSetValue( nil, "resort", true )
								ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Resort )
							end,
						},
						open = {
							order = 200,
							name = ArkInventory.Localise["CONFIG_SETTINGS_SORTING_OPEN"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_SORTING_OPEN_TEXT"],
							type = "toggle",
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "sort", "open" )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "sort", "open", v )
							end,
						},
						instant = {
							order = 300,
							name = ArkInventory.Localise["CONFIG_SETTINGS_SORTING_INSTANT"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_SORTING_INSTANT_TEXT"],
							type = "toggle",
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "sort", "instant" )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "sort", "instant", v )
							end,
						},
					},
				},
				background = {
					order = 500,
					name = ArkInventory.Localise["BACKGROUND"],
					type = "group",
					--inline = true,
					args = {
						style = {
							order = 100,
							name = ArkInventory.Localise["STYLE"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_BORDER_STYLE_TEXT"],
							type = "select",
							dialogControl = "LSM30_Background",
							values = ArkInventory.Lib.SharedMedia:HashTable( ArkInventory.Lib.SharedMedia.MediaType.BACKGROUND ),
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "window", "background", "style" ) or ArkInventory.Const.Texture.BackgroundDefault
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "window", "background", "style" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "window", "background", "style", v )
									ArkInventory.Frame_Main_Paint_All( )
								end
							end,
						},
						colour = {
							order = 200,
							name = ArkInventory.Localise["BACKGROUND_COLOUR"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_BACKGROUND_COLOUR_TEXT"],
							type = "color",
							hasAlpha = true,
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "window", "background", "style" ) ~= ArkInventory.Const.Texture.BackgroundDefault
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								local r = ArkInventory.LocationOptionGetReal( loc_id, "window", "background", "colour", "r" )
								local g = ArkInventory.LocationOptionGetReal( loc_id, "window", "background", "colour", "g" )
								local b = ArkInventory.LocationOptionGetReal( loc_id, "window", "background", "colour", "b" )
								local a = ArkInventory.LocationOptionGetReal( loc_id, "window", "background", "colour", "a" )
								return r, g, b, a
							end,
							set = function( info, r, g, b, a )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "window", "background", "colour", "r", r )
								ArkInventory.LocationOptionSetReal( loc_id, "window", "background", "colour", "g", g )
								ArkInventory.LocationOptionSetReal( loc_id, "window", "background", "colour", "b", b )
								ArkInventory.LocationOptionSetReal( loc_id, "window", "background", "colour", "a", a )
								ArkInventory.Frame_Main_Paint_All( )
							end,
						},
					},
				},	
				border = {
					order = 600,
					name = ArkInventory.Localise["BORDER"],
					type = "group",
					--inline = true,
					args = {
						style = {
							order = 100,
							name = ArkInventory.Localise["STYLE"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_BORDER_STYLE_TEXT"],
							type = "select",
							dialogControl = "LSM30_Border",
							values = ArkInventory.Lib.SharedMedia:HashTable( ArkInventory.Lib.SharedMedia.MediaType.BORDER ),
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "style" ) or ArkInventory.Const.Texture.BorderDefault
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "style" ) ~= v then
									
									ArkInventory.LocationOptionSetReal( loc_id, "window", "border", "style", v )
									
									local sd = ArkInventory.Const.Texture.Border[v] or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault]
									ArkInventory.LocationOptionSetReal( loc_id, "window", "border", "size", sd.size )
									ArkInventory.LocationOptionSetReal( loc_id, "window", "border", "offset", sd.offset )
									ArkInventory.LocationOptionSetReal( loc_id, "window", "border", "scale", sd.scale )

									ArkInventory.Frame_Main_Paint_All( )
									
								end
							end,
						},
						colour = {
							order = 200,
							name = ArkInventory.Localise["COLOUR"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_BORDER_COLOUR_TEXT"],
							type = "color",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "style" ) == ArkInventory.Const.Texture.BorderNone
							end,
							hasAlpha = false,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								local r = ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "colour", "r" )
								local g = ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "colour", "g" )
								local b = ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "colour", "b" )
								return r, g, b
							end,
							set = function( info, r, g, b )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "window", "border", "colour", "r", r )
								ArkInventory.LocationOptionSetReal( loc_id, "window", "border", "colour", "g", g )
								ArkInventory.LocationOptionSetReal( loc_id, "window", "border", "colour", "b", b )
								ArkInventory.Frame_Main_Paint_All( )
							end,
						},
						size = {
							order = 300,
							name = ArkInventory.Localise["HEIGHT"],
							type = "input",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "style" ) == ArkInventory.Const.Texture.BorderNone
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return string.format( "%i", ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "size" ) or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].size )
							end,
							set = function( info, v )
								local v = math.floor( tonumber( v ) or 0 )
								if v < 0 then v = 0 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "size" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "window", "border", "size", v )
									ArkInventory.Frame_Main_Paint_All( )
								end
							end,
						},
						offset = {
							order = 400,
							name = ArkInventory.Localise["OFFSET"],
							type = "input",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "style" ) == ArkInventory.Const.Texture.BorderNone
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return string.format( "%i", ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "offset" ) or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].offset  )
							end,
							set = function( info, v )
								local v = math.floor( tonumber( v ) or 0 )
								if v < 0 then v = 0 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "offset" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "window", "border", "offset", v )
									ArkInventory.Frame_Main_Paint_All( )
								end
							end,
						},
						scale = {
							order = 500,
							name = ArkInventory.Localise["SCALE"],
							desc = ArkInventory.Localise["BORDER_SCALE_TEXT"],
							type = "range",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "style" ) == ArkInventory.Const.Texture.BorderNone
							end,
							min = 0.25,
							max = 4,
							step = 0.05,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "scale" ) or 1
							end,
							set = function( info, v )
								local v = math.floor( v / 0.05 ) * 0.05
								if v < 0.25 then v = 0.25 end
								if v > 4 then v = 4 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if v ~= ArkInventory.LocationOptionGetReal( loc_id, "window", "border", "scale" ) then
									ArkInventory.LocationOptionSetReal( loc_id, "window", "border", "scale", v )
									ArkInventory.Frame_Main_Paint_All( )
								end
							end,
						},
					},
				},
				frames = {
					order = 700,
					name = ArkInventory.Localise["FRAMES"],
					type = "group",
					--inline = true,
					args = {
						title = {
							order = 100,
							name = ArkInventory.Localise["SUBFRAME_NAME_TITLE"],
							type = "group",
							inline = false,
							args = {
								hide = {
									order = 100,
									type = "toggle",
									name = ArkInventory.Localise["HIDE"],
									desc = function( info )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										return string.format( ArkInventory.Localise["CONFIG_SETTINGS_FRAME_HIDE_TEXT"], ArkInventory.Global.Location[loc_id].Name, ArkInventory.Localise["SUBFRAME_NAME_TITLE"] )
									end,
									get = function( info )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										return ArkInventory.LocationOptionGetReal( loc_id, "title", "hide" )
									end,
									set = function( info, v )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										ArkInventory.LocationOptionSetReal( loc_id, "title", "hide", v )
										ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
									end,
								},
								size = {
									order = 200,
									type = "select",
									name = "size",
									disabled = function( info )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										return ArkInventory.LocationOptionGetReal( loc_id, "title", "hide" )
									end,
									values = function( )
										local t = { [ArkInventory.Const.Window.Title.SizeNormal] = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_TITLE_SIZE_NORMAL"], [ArkInventory.Const.Window.Title.SizeThin] = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_TITLE_SIZE_THIN"] }
										return t
									end,
									get = function( info )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										return ArkInventory.LocationOptionGetReal( loc_id, "title", "size" )
									end,
									set = function( info, v )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										ArkInventory.LocationOptionSetReal( loc_id, "title", "size", v )
										ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
									end,
								},
							},
						},
						search = {
							order = 200,
							name = ArkInventory.Localise["SEARCH"],
							type = "group",
							inline = false,
							args = {
								hide = {
									order = 100,
									name = ArkInventory.Localise["HIDE"],
									type = "toggle",
									desc = function( info )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										return string.format( ArkInventory.Localise["CONFIG_SETTINGS_FRAME_HIDE_TEXT"], ArkInventory.Global.Location[loc_id].Name, ArkInventory.Localise["SEARCH"] )
									end,
									disabled = function( info )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										return not ArkInventory.Global.Location[loc_id].canSearch
									end,
									get = function( info )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										return ArkInventory.LocationOptionGetReal( loc_id, "search", "hide" )
									end,
									set = function( info, v )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										ArkInventory.Global.Location[loc_id].filter = nil
										ArkInventory.LocationOptionSetReal( loc_id, "search", "hide", v )
										ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
									end,
								},
							},
						},
						changer = {
							order = 300,
							name = ArkInventory.Localise["SUBFRAME_NAME_BAGCHANGER"],
							type = "group",
							inline = false,
							args = {
								hide = {
									order = 100,
									name = ArkInventory.Localise["HIDE"],
									type = "toggle",
									desc = function( info )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										return string.format( ArkInventory.Localise["CONFIG_SETTINGS_FRAME_HIDE_TEXT"], ArkInventory.Global.Location[loc_id].Name, ArkInventory.Localise["SUBFRAME_NAME_BAGCHANGER"] )
									end,
									disabled = function( info )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										return not ArkInventory.Global.Location[loc_id].hasChanger
									end,
									get = function( info )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										return ArkInventory.LocationOptionGetReal( loc_id, "changer", "hide" )
									end,
									set = function( info, v )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										ArkInventory.LocationOptionSetReal( loc_id, "changer", "hide", v )
										ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
									end,
								},
								highlight = {
									order = 200,
									name = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT"],
									type = "group",
									inline = true,
									args = {
										show = {
											order = 100,
											name = ArkInventory.Localise["SHOW"],
											desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT_TEXT"],
											type = "toggle",
											get = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												return ArkInventory.LocationOptionGetReal( loc_id, "changer", "highlight", "show" )
											end,
											set = function( info, v )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												ArkInventory.LocationOptionSetReal( loc_id, "changer", "highlight", "show", v )
												ArkInventory.ItemCategoryClear( nil, nil, true )
												ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
											end,
										},
										colour = {
											order = 200,
											name = ArkInventory.Localise["COLOUR"],
											desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT_COLOUR_TEXT"],
											type = "color",
											hasAlpha = false,
											hidden = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												return not ArkInventory.LocationOptionGetReal( loc_id, "changer", "highlight", "show" )
											end,
											get = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												local r = ArkInventory.LocationOptionGetReal( loc_id, "changer", "highlight", "colour", "r" )
												local g = ArkInventory.LocationOptionGetReal( loc_id, "changer", "highlight", "colour", "g" )
												local b = ArkInventory.LocationOptionGetReal( loc_id, "changer", "highlight", "colour", "b" )
											return r, g, b
											end,
											set = function( info, r, g, b )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												ArkInventory.LocationOptionSetReal( loc_id, "changer", "highlight", "colour", "r", r )
												ArkInventory.LocationOptionSetReal( loc_id, "changer", "highlight", "colour", "g", g )
												ArkInventory.LocationOptionSetReal( loc_id, "changer", "highlight", "colour", "b", b )
												ArkInventory.Frame_Main_Paint_All( )
											end,	
										},
							},
						},
								free = {
									order = 300,
									name = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_CHANGER_FREE"],
									type = "group",
									inline = true,
									args = {
										show = {
											order = 100,
											name = ArkInventory.Localise["SHOW"],
											desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_CHANGER_FREE_TEXT"],
											type = "toggle",
											get = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												return ArkInventory.LocationOptionGetReal( loc_id, "changer", "freespace", "show" )
											end,
											set = function( info, v )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												ArkInventory.LocationOptionSetReal( loc_id, "changer", "freespace", "show", v )
												ArkInventory.ItemCategoryClear( nil, nil, true )
												ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
											end,
										},
										colour = {
											order = 200,
											name = ArkInventory.Localise["COLOUR"],
											desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_CHANGER_FREE_COLOUR_TEXT"],
											type = "color",
											hidden = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												return not ArkInventory.LocationOptionGetReal( loc_id, "changer", "freespace", "show" )
											end,
												hasAlpha = false,
												get = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												local r = ArkInventory.LocationOptionGetReal( loc_id, "changer", "freespace", "colour", "r" )
												local g = ArkInventory.LocationOptionGetReal( loc_id, "changer", "freespace", "colour", "g" )
												local b = ArkInventory.LocationOptionGetReal( loc_id, "changer", "freespace", "colour", "b" )
												return r, g, b
											end,
											set = function( info, r, g, b )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												ArkInventory.LocationOptionSetReal( loc_id, "changer", "freespace", "colour", "r", r )
												ArkInventory.LocationOptionSetReal( loc_id, "changer", "freespace", "colour", "g", g )
												ArkInventory.LocationOptionSetReal( loc_id, "changer", "freespace", "colour", "b", b )
												ArkInventory.Frame_Changer_Update( ArkInventory.Const.Location.Bag )
												ArkInventory.Frame_Changer_Update( ArkInventory.Const.Location.Bank )
												ArkInventory.Frame_Changer_Update( ArkInventory.Const.Location.Vault )
											end,
										},
									},
								},
							},
						},
						status = {
							order = 400,
							name = ArkInventory.Localise["STATUS"],
							type = "group",
							inline = false,
							args = {
								hide = {
									order = 100,
									name = ArkInventory.Localise["HIDE"],
									type = "toggle",
									desc = function( info )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										return string.format( ArkInventory.Localise["CONFIG_SETTINGS_FRAME_HIDE_TEXT"], ArkInventory.Global.Location[loc_id].Name, ArkInventory.Localise["STATUS"] )
									end,
									get = function( info )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										return ArkInventory.LocationOptionGetReal( loc_id, "status", "hide" )
									end,
									set = function( info, v )
										local loc_id = ConfigGetNodeArg( info, #info - 4 )
										ArkInventory.LocationOptionSetReal( loc_id, "status", "hide", v )
										ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
									end,
								},
								emptytext = {
									order = 200,
									name = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_STATUS_EMPTY"],
									type = "group",
									inline = true,
									args = {
										show = {
											order = 100,
											name = ArkInventory.Localise["SHOW"],
											desc = ArkInventory.Localise["CONFIG_SETTINGS_FRAME_STATUS_EMPTY_TEXT"],
											type = "toggle",
											get = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												return ArkInventory.LocationOptionGetReal( loc_id, "status", "emptytext", "show" )
											end,
											set = function( info, v )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												if ArkInventory.LocationOptionGetReal( loc_id, "status", "emptytext", "show" ) ~= v then
													ArkInventory.LocationOptionSetReal( loc_id, "status", "emptytext", "show", v )
													ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
												end
											end,
										},
										colour = {
											order = 200,
											name = ArkInventory.Localise["LDB_BAGS_COLOUR_USE"],
											desc = ArkInventory.Localise["LDB_BAGS_COLOUR_USE_TEXT"],
											type = "toggle",
											hidden = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												return not ArkInventory.LocationOptionGetReal( loc_id, "status", "emptytext", "show" )
											end,
											get = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												return ArkInventory.LocationOptionGetReal( loc_id, "status", "emptytext", "colour" )
											end,
											set = function( info, v )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												ArkInventory.LocationOptionSetReal( loc_id, "status", "emptytext", "colour", v )
												ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
											end,
										},
										full = {
											order = 300,
											name = ArkInventory.Localise["LDB_BAGS_STYLE"],
											desc = ArkInventory.Localise["LDB_BAGS_STYLE_TEXT"],
											type = "toggle",
											hidden = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												return not ArkInventory.LocationOptionGetReal( loc_id, "status", "emptytext", "show" )
											end,
											get = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												return ArkInventory.LocationOptionGetReal( loc_id, "status", "emptytext", "full" )
											end,
											set = function( info, v )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												ArkInventory.LocationOptionSetReal( loc_id, "status", "emptytext", "full", v )
												ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
											end,
										},
										includetype = {
											order = 400,
											name = ArkInventory.Localise["LDB_BAGS_INCLUDE_TYPE"],
											desc = ArkInventory.Localise["LDB_BAGS_INCLUDE_TYPE_TEXT"],
											type = "toggle",
											hidden = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												return not ArkInventory.LocationOptionGetReal( loc_id, "status", "emptytext", "show" )
											end,
											get = function( info )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												return ArkInventory.LocationOptionGetReal( loc_id, "status", "emptytext", "includetype" )
											end,
											set = function( info, v )
												local loc_id = ConfigGetNodeArg( info, #info - 5 )
												ArkInventory.LocationOptionSetReal( loc_id, "status", "emptytext", "includetype", v )
												ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
											end,
										},
									},
								},
							},
						},
					},
				},
			},
		},
		
		bars = {
			order = 200,
			name = ArkInventory.Localise["CONFIG_SETTINGS_BARS"],
			type = "group",
			args = {
				anchor = {
					order = 100,
					name = ArkInventory.Localise["ANCHOR"],
					desc = string.format( ArkInventory.Localise["ANCHOR_TEXT2"], ArkInventory.Localise["CONFIG_SETTINGS_BARS"], "" ),
					type = "select",
					values = function( )
						return anchorpoints
					end,
					get = function( info )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						return ArkInventory.LocationOptionGetReal( loc_id, "bar", "anchor" )
					end,
					set = function( info, v )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						if ArkInventory.LocationOptionGetReal( loc_id, "bar", "anchor" ) ~= v then
							ArkInventory.LocationOptionSetReal( loc_id, "bar", "anchor", v )
							ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
						end
					end,
				},
				per_bar = {
					order = 200,
					name = ArkInventory.Localise["CONFIG_SETTINGS_BARS_PER_ROW"],
					desc = ArkInventory.Localise["CONFIG_SETTINGS_BARS_PER_ROW_TEXT"],
					type = "range",
					min = 1,
					max = 16,
					step = 1,
					get = function( info )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						return ArkInventory.LocationOptionGetReal( loc_id, "bar", "per" )
					end,
					set = function( info, v )
						local v = math.floor( v )
						if v < 1 then v = 1 end
						if v > 16 then v = 16 end
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						if ArkInventory.LocationOptionGetReal( loc_id, "bar", "per" ) ~= v then
							ArkInventory.LocationOptionSetReal( loc_id, "bar", "per", v )
							ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
						end
					end,
				},
				compact = {
					order = 400,
					name = ArkInventory.Localise["CONFIG_SETTINGS_BARS_COMPACT"],
					desc = ArkInventory.Localise["CONFIG_SETTINGS_BARS_COMPACT_TEXT"],
					type = "toggle",
					get = function( info )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						return ArkInventory.LocationOptionGetReal( loc_id, "bar", "compact" )
					end,
					set = function( info, v )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						ArkInventory.LocationOptionSetReal( loc_id, "bar", "compact", v )
						ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
					end,
				},
				empty = {
					order = 500,
					name = ArkInventory.Localise["CONFIG_SETTINGS_BARS_SHOW_EMPTY"],
					desc = ArkInventory.Localise["CONFIG_SETTINGS_BARS_SHOW_EMPTY_TEXT"],
					type = "toggle",
					get = function( info )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						return ArkInventory.LocationOptionGetReal( loc_id, "bar", "showempty" )
					end,
					set = function( info, v )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						ArkInventory.LocationOptionSetReal( loc_id, "bar", "showempty", v )
						ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
					end,
				},
				padding = {
					order= 600,
					name = ArkInventory.Localise["PADDING"],
					type = "group",
					--inline = true,
					args = {
						internal = {
							order = 100,
							name = ArkInventory.Localise["INTERNAL"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_BARS_PADDING_INTERNAL_TEXT"],
							type = "range",
							min = 4,
							max = 32,
							step = 1,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "bar", "pad", "internal" )
							end,
							set = function( info, v )
								local v = math.floor( v )
								if v < 4 then v = 4 end
								if v > 32 then v = 32 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "bar", "pad", "internal" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "bar", "pad", "internal", v )
									ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
								end
							end,
						},
						external = {
							order = 200,
							name = ArkInventory.Localise["EXTERNAL"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_BARS_PADDING_EXTERNAL_TEXT"],
							type = "range",
							min = 0,
							max = 32,
							step = 1,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "bar", "pad", "external" )
							end,
							set = function( info, v )
								local v = math.floor( v )
								if v < 0 then v = 0 end
								if v > 32 then v = 32 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "bar", "pad", "external" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "bar", "pad", "external", v )
									ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
								end
							end,
						},
					},
				},
				background = {
					order = 650,
					name = ArkInventory.Localise["BACKGROUND"],
					type = "group",
					--inline = true,
					args = {
						style = {
							order = 100,
							name = ArkInventory.Localise["STYLE"],
							type = "select",
							disabled = true,
							dialogControl = "LSM30_Background",
							values = ArkInventory.Lib.SharedMedia:HashTable( ArkInventory.Lib.SharedMedia.MediaType.BACKGROUND ),
							get = function( info )
								--local loc_id = ConfigGetNodeArg( info, #info - 3 )
								--return ArkInventory.LocationOptionGetReal( loc_id, "bar", "background", "style" )
								return ArkInventory.Const.Texture.BackgroundDefault
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "bar", "background", "style", v )
								ArkInventory.Frame_Bar_Paint_All( )
							end,
						},
						colour = {
							order = 200,
							name = ArkInventory.Localise["COLOUR"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_BARS_BACKGROUND_TEXT"],
							type = "color",
							hasAlpha = true,
							hidden = function( info )
--								local loc_id = ConfigGetNodeArg( info, #info - 3 )
--								return ArkInventory.LocationOptionGetReal( loc_id, "bar", "background", "style" ) ~= ArkInventory.Const.Texture.BackgroundDefault
								return false
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								local r = ArkInventory.LocationOptionGetReal( loc_id, "bar", "background", "colour", "r" )
								local g = ArkInventory.LocationOptionGetReal( loc_id, "bar", "background", "colour", "g" )
								local b = ArkInventory.LocationOptionGetReal( loc_id, "bar", "background", "colour", "b" )
								local a = ArkInventory.LocationOptionGetReal( loc_id, "bar", "background", "colour", "a" )
								return r, g, b, a
							end,
							set = function( info, r, g, b, a )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "bar", "background", "colour", "r", r )
								ArkInventory.LocationOptionSetReal( loc_id, "bar", "background", "colour", "g", g )
								ArkInventory.LocationOptionSetReal( loc_id, "bar", "background", "colour", "b", b )
								ArkInventory.LocationOptionSetReal( loc_id, "bar", "background", "colour", "a", a )
								ArkInventory.Frame_Bar_Paint_All( )
							end,
						},
					},
				},	
				border = {
					order = 700,
					name = ArkInventory.Localise["BORDER"],
					type = "group",
					--inline = true,
					args = {
						style = {
							order = 100,
							name = ArkInventory.Localise["STYLE"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_BARS_BORDER_STYLE_TEXT"],
							type = "select",
							dialogControl = "LSM30_Border",
							values = ArkInventory.Lib.SharedMedia:HashTable( ArkInventory.Lib.SharedMedia.MediaType.BORDER ),
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "style" ) or ArkInventory.Const.Texture.BorderDefault
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if v ~= ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "style" ) then
									
									ArkInventory.LocationOptionSetReal( loc_id, "bar", "border", "style", v )
									
									local sd = ArkInventory.Const.Texture.Border[v] or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault]
									ArkInventory.LocationOptionSetReal( loc_id, "bar", "border", "size", sd.size )
									ArkInventory.LocationOptionSetReal( loc_id, "bar", "border", "offset", sd.offset )
									ArkInventory.LocationOptionSetReal( loc_id, "bar", "border", "scale", sd.scale )

									ArkInventory.Frame_Bar_Paint_All( )
									
								end
							end,
						},
						colour = {
							order = 200,
							name = ArkInventory.Localise["COLOUR"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_BARS_BORDER_COLOUR_TEXT"],
							type = "color",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "style" ) == ArkInventory.Const.Texture.BorderNone
							end,
							hasAlpha = false,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								local r = ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "colour", "r" )
								local g = ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "colour", "g" )
								local b = ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "colour", "b" )
								return r, g, b
							end,
							set = function( info, r, g, b )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "bar", "border", "colour", "r", r )
								ArkInventory.LocationOptionSetReal( loc_id, "bar", "border", "colour", "g", g )
								ArkInventory.LocationOptionSetReal( loc_id, "bar", "border", "colour", "b", b )
								ArkInventory.Frame_Bar_Paint_All( )
							end,
						},
						size = {
							order = 300,
							name = ArkInventory.Localise["HEIGHT"],
							type = "input",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "style" ) == ArkInventory.Const.Texture.BorderNone
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return string.format( "%i", ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "size" ) or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].size )
							end,
							set = function( info, v )
								local v = math.floor( tonumber( v ) or 0 )
								if v < 0 then v = 0 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "size" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "bar", "border", "size", v )
									ArkInventory.Frame_Bar_Paint_All( )
								end
							end,
						},
						offset = {
							order = 400,
							name = ArkInventory.Localise["OFFSET"],
							type = "input",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "style" ) == ArkInventory.Const.Texture.BorderNone
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return string.format( "%i", ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "offset" ) or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].offset  )
							end,
							set = function( info, v )
								local v = math.floor( tonumber( v ) or 0 )
								if v < 0 then v = 0 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "offset" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "bar", "border", "offset", v )
									ArkInventory.Frame_Main_Paint_All( )
								end
							end,
						},
						scale = {
							order = 500,
							name = ArkInventory.Localise["SCALE"],
							type = "range",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "style" ) == ArkInventory.Const.Texture.BorderNone
							end,
							min = 0.25,
							max = 4,
							step = 0.05,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "scale" ) or 1
							end,
							set = function( info, v )
								local v = math.floor( v / 0.05 ) * 0.05
								if v < 0.25 then v = 0.25 end
								if v > 4 then v = 4 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "bar", "border", "scale" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "bar", "border", "scale", v )
									ArkInventory.Frame_Bar_Paint_All( )
								end
							end,
						},
					},
				},
				label = {
					order = 800,
					name = ArkInventory.Localise["NAME"],
					type = "group",
					--inline = true,
					args = {
						show = {
							order = 100,
							type = "toggle",
							name = ArkInventory.Localise["SHOW"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_BARS_NAME_SHOW_TEXT"],
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "bar", "name", "show" )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "bar", "name", "show", v )
								ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
							end,
						},
						colour = {
							order = 200,
							name = ArkInventory.Localise["COLOUR"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_BARS_NAME_COLOUR_TEXT"],
							type = "color",
							hidden = function( info )
							local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return not ArkInventory.LocationOptionGetReal( loc_id, "bar", "name", "show" )
							end,
							hasAlpha = false,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								local r = ArkInventory.LocationOptionGetReal( loc_id, "bar", "name", "colour", "r" )
								local g = ArkInventory.LocationOptionGetReal( loc_id, "bar", "name", "colour", "g" )
								local b = ArkInventory.LocationOptionGetReal( loc_id, "bar", "name", "colour", "b" )
								return r, g, b
							end,
							set = function( info, r, g, b )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "bar", "name", "colour", "r", r )
								ArkInventory.LocationOptionSetReal( loc_id, "bar", "name", "colour", "g", g )
								ArkInventory.LocationOptionSetReal( loc_id, "bar", "name", "colour", "b", b )
								ArkInventory.Frame_Bar_Paint_All( )
							end,
						},
						height = {
							order = 300,
							name = ArkInventory.Localise["HEIGHT"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_BARS_NAME_HEIGHT_TEXT"],
							type = "range",
							min = 4,
							max = 32,
							step = 1,
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return not ArkInventory.LocationOptionGetReal( loc_id, "bar", "name", "show" )
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "bar", "name", "height" )
							end,
							set = function( info, v )
								local v = math.floor( v )
								if v < 4 then v = 4 end
								if v > 32 then v = 32 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "bar", "name", "height" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "bar", "name", "height", v )
									ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
								end
							end,
						},
						anchor = {
							order = 400,
							name = ArkInventory.Localise["ANCHOR"],
							desc = string.format( ArkInventory.Localise["ANCHOR_TEXT2"], ArkInventory.Localise["NAME"], "" ),
							type = "select",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return not ArkInventory.LocationOptionGetReal( loc_id, "bar", "name", "show" )
							end,
							values = function( )
								local anchorpoints = {
									[ArkInventory.Const.Anchor.Automatic] = ArkInventory.Localise["AUTOMATIC"],
									[ArkInventory.Const.Anchor.Top] = ArkInventory.Localise["TOP"],
									[ArkInventory.Const.Anchor.Bottom] = ArkInventory.Localise["BOTTOM"],
								}
								return anchorpoints
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "bar", "name", "anchor" )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "bar", "name", "anchor" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "bar", "name", "anchor", v )
									ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
								end
							end,
						},
					},
				},
			},
		},
		
		items = {
			order = 300,
			name = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS"],
			type = "group",
			args = {
				anchor = {
					order = 100,
					name = ArkInventory.Localise["ANCHOR"],
					desc = string.format( ArkInventory.Localise["ANCHOR_TEXT2"], ArkInventory.Localise["CONFIG_SETTINGS_ITEMS"], "" ),
					type = "select",
					values = function( )
						return anchorpoints
					end,
					get = function( info )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						return ArkInventory.LocationOptionGetReal( loc_id, "slot", "anchor" )
					end,
					set = function( info, v )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						if ArkInventory.LocationOptionGetReal( loc_id, "slot", "anchor" ) ~= v then
							ArkInventory.LocationOptionSetReal( loc_id, "slot", "anchor", v )
							ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
						end
					end,
				},
				padding = {
					order = 200,
					name = ArkInventory.Localise["PADDING"],
					desc = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_PADDING_TEXT"],
					type = "range",
					min = 1,
					max = 16,
					step = 1,
					get = function( info )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						return ArkInventory.LocationOptionGetReal( loc_id, "slot", "pad" )
					end,
					set = function( info, v )
						local v = math.floor( v )
						if v < 1 then v = 1 end
						if v > 16 then v = 16 end
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						if ArkInventory.LocationOptionGetReal( loc_id, "slot", "pad" ) ~= v then
							ArkInventory.LocationOptionSetReal( loc_id, "slot", "pad", v )
							ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
						end
					end,
				},
				hidden = {
					order = 300,
					name = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_HIDDEN"],
					desc = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_HIDDEN_TEXT"],
					type = "toggle",
					get = function( info )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						return ArkInventory.LocationOptionGetReal( loc_id, "slot", "ignorehidden" )
					end,
					set = function( info, v )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						ArkInventory.LocationOptionSetReal( loc_id, "slot", "ignorehidden", v )
						ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
					end,
				},
				fade = {
					order = 400,
					name = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_FADE"],
					desc = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_FADE_TEXT"],
					type = "toggle",
					get = function( info )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						return ArkInventory.LocationOptionGetReal( loc_id, "slot", "offline", "fade" )
					end,
					set = function( info, v )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						ArkInventory.LocationOptionSetReal( loc_id, "slot", "offline", "fade", v )
						ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
					end,
				},
				tint = {
					order = 500,
					name = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_TINT_USABLE"],
					desc = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_TINT_USABLE_TEXT"],
					type = "toggle",
					get = function( info )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						return ArkInventory.LocationOptionGetReal( loc_id, "slot", "unusable", "tint" )
					end,
					set = function( info, v )
						local loc_id = ConfigGetNodeArg( info, #info - 2 )
						ArkInventory.LocationOptionSetReal( loc_id, "slot", "unusable", "tint", v )
						ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
					end,
				},
				
				cooldown = {
					order = 550,
					name = ArkInventory.Localise["COOLDOWN"],
					type = "group",
					--inline = true,
					args = {
						enable = {
							order = 100,
							name = ArkInventory.Localise["SHOW"],
							desc = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return string.format( ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_COOLDOWN_SHOW_TEXT"], ArkInventory.Global.Location[loc_id].Name )
							end,
							type = "toggle",
							--disabled = true,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "cooldown", "show" )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "slot", "cooldown", "show", v )
								ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Refresh )
							end,
						},
						global = {
							order = 200,
							name = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_COOLDOWN_GLOBAL"],
							desc = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return string.format( ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_COOLDOWN_GLOBAL_TEXT"], ArkInventory.Global.Location[loc_id].Name )
							end,
							type = "toggle",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return not ArkInventory.LocationOptionGetReal( loc_id, "slot", "cooldown", "show" )
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "cooldown", "global" )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "slot", "cooldown", "global", v )
								ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Refresh )
							end,
						},
						combat = {
							order = 300,
							name = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_COOLDOWN_COMBAT"],
							desc = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return string.format( ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_COOLDOWN_COMBAT_TEXT"], ArkInventory.Global.Location[loc_id].Name )
							end,
							type = "toggle",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return not ArkInventory.LocationOptionGetReal( loc_id, "slot", "cooldown", "show" )
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "cooldown", "combat" )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "slot", "cooldown", "combat", v )
							end,
						},
					},
				},
				border = {
					order = 600,
					name = ArkInventory.Localise["BORDER"],
					type = "group",
					--inline = true,
					args = {
						style = {
							order = 100,
							name = ArkInventory.Localise["STYLE"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_BORDER_STYLE_TEXT"],
							type = "select",
							dialogControl = "LSM30_Border",
							values = ArkInventory.Lib.SharedMedia:HashTable( ArkInventory.Lib.SharedMedia.MediaType.BORDER ),
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "style" ) or ArkInventory.Const.Texture.BorderDefault
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if v ~= ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "style" ) then
									
									ArkInventory.LocationOptionSetReal( loc_id, "slot", "border", "style", v )
									
									local sd = ArkInventory.Const.Texture.Border[v] or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault]
									ArkInventory.LocationOptionSetReal( loc_id, "slot", "border", "size", sd.size )
									ArkInventory.LocationOptionSetReal( loc_id, "slot", "border", "offset", sd.offset )
									ArkInventory.LocationOptionSetReal( loc_id, "slot", "border", "scale", sd.scale )
									
									ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
									
								end
							end,
						},
						rarity = {
							order = 200,
							name = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_BORDER_RARITY"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_TEXT"],
							type = "toggle",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "style" ) == ArkInventory.Const.Texture.BorderNone
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "rarity" )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "slot", "border", "rarity", v )
								ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
							end,
						},
						raritycutoff = {
							order = 300,
							name = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_CUTOFF"],
							desc = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return string.format( ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_CUTOFF_TEXT"], _G[string.format( "ITEM_QUALITY%d_DESC", ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "raritycutoff" ) or 0 )] )
							end,
							type = "select",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "style" ) == ArkInventory.Const.Texture.BorderNone or not ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "rarity" )
							end,
							values = function( )
								local t = { }
								for z in pairs( ITEM_QUALITY_COLORS ) do
									if z >= 0 then
										t[tostring( z )] = _G[string.format( "ITEM_QUALITY%d_DESC", z )]
									end
								end
								return t
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return tostring( ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "raritycutoff" ) or 0 )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "slot", "border", "raritycutoff", tonumber( v ) )
								ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
							end,
						},
						size = {
							order = 400,
							name = ArkInventory.Localise["HEIGHT"],
							type = "input",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "style" ) == ArkInventory.Const.Texture.BorderNone
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return string.format( "%i", ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "size" ) or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].size )
							end,
							set = function( info, v )
								local v = math.floor( tonumber( v ) or 0 )
								if v < 0 then v = 0 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "size" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "slot", "border", "size", v )
									ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
								end
							end,
						},
						offset = {
							order = 500,
							name = ArkInventory.Localise["OFFSET"],
							type = "input",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "style" ) == ArkInventory.Const.Texture.BorderNone
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return string.format( "%i", ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "offset" ) or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].offset  )
							end,
							set = function( info, v )
								local v = math.floor( tonumber( v ) or 0 )
								if v < 0 then v = 0 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "offset" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "slot", "border", "offset", v )
									ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
								end
							end,
						},
						scale = {
							order = 600,
							name = ArkInventory.Localise["SCALE"],
							type = "range",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "style" ) == ArkInventory.Const.Texture.BorderNone
							end,
							min = 0.25,
							max = 4,
							step = 0.05,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "scale" ) or 1
							end,
							set = function( info, v )
								local v = math.floor( v / 0.05 ) * 0.05
								if v < 0.25 then v = 0.25 end
								if v > 4 then v = 4 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "slot", "border", "scale" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "slot", "border", "scale", v )
									ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
								end
							end,
						},
					},
				},
				empty = {
					order = 700,
					name = ArkInventory.Localise["CONFIG_SETTINGS_EMPTY"],
					type = "group",
					--inline = true,
					args = {
						icon = {
							order = 100,
							name = ArkInventory.Localise["CONFIG_SETTINGS_EMPTY_ICON"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_EMPTY_ICON_TEXT"],
							type = "toggle",
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "empty", "icon" )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "slot", "empty", "icon", v )
								ArkInventory.Frame_Item_Empty_Paint_All( )
							end,
						},
						clump = {
							order = 200,
							name = ArkInventory.Localise["CONFIG_SETTINGS_EMPTY_CLUMP"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_EMPTY_CLUMP_TEXT"],
							type = "toggle",
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "empty", "clump" )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "slot", "empty", "clump", v )
								ArkInventory.ItemCacheClear( )
								ArkInventory.ItemCategoryClear( nil, nil, true )
								ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
							end,
						},
						border = {
							order = 300,
							name = ArkInventory.Localise["CONFIG_SETTINGS_EMPTY_BORDER"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_EMPTY_BORDER_TEXT"],
							type = "toggle",
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "empty", "border" )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "slot", "empty", "border", v )
								ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
							end,
						},
						colour = {
							order = 400,
							name = ArkInventory.Localise["CONFIG_SETTINGS_EMPTY_COLOUR"],
							type = "group",
							inline = true,
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "empty", "icon" ) and not ArkInventory.LocationOptionGetReal( loc_id, "slot", "empty", "border" )
							end,
							args = args2,
						},
					},
				},
				age = {
					order = 900,
					name = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_AGE"],
					type = "group",
					--inline = true,
					args = {
						show = {
							order = 100,
							name = ArkInventory.Localise["SHOW"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_AGE_SHOW_TEXT"],
							type = "toggle",
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return ArkInventory.LocationOptionGetReal( loc_id, "slot", "new", "show" )
							end,
							set = function( info, v )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "slot", "new", "show", v )
								ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
							end,
						},
						colour = {
							order = 200,
							name = ArkInventory.Localise["COLOUR"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_AGE_COLOUR_TEXT"],
							type = "color",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return not ArkInventory.LocationOptionGetReal( loc_id, "slot", "new", "show" )
							end,
							hasAlpha = false,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								local r = ArkInventory.LocationOptionGetReal( loc_id, "slot", "new", "colour", "r" )
								local g = ArkInventory.LocationOptionGetReal( loc_id, "slot", "new", "colour", "g" )
								local b = ArkInventory.LocationOptionGetReal( loc_id, "slot", "new", "colour", "b" )
								return r, g, b
							end,
							set = function( info, r, g, b )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								ArkInventory.LocationOptionSetReal( loc_id, "slot", "new", "colour", "r", r )
								ArkInventory.LocationOptionSetReal( loc_id, "slot", "new", "colour", "g", g )
								ArkInventory.LocationOptionSetReal( loc_id, "slot", "new", "colour", "b", b )
								ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
							end,
						},
						cutoff = {
							order = 300,
							name = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_AGE_CUTOFF"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_AGE_CUTOFF_TEXT"],
							type = "input",
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return not ArkInventory.LocationOptionGetReal( loc_id, "slot", "new", "show" )
							end,
							get = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return string.format( "%i", ArkInventory.LocationOptionGetReal( loc_id, "slot", "new", "cutoff" ) )
							end,
							set = function( info, v )
								local v = math.floor( tonumber( v ) or 0 )
								if v < 0 then v = 0 end
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								if ArkInventory.LocationOptionGetReal( loc_id, "slot", "new", "cutoff" ) ~= v then
									ArkInventory.LocationOptionSetReal( loc_id, "slot", "new", "cutoff", v )
									ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
								end
							end,
						},
						reset = {
							order = 400,
							name = ArkInventory.Localise["CLEAR"],
							desc = ArkInventory.Localise["CONFIG_SETTINGS_ITEMS_AGE_RESET_TEXT"],
							type = "execute",
							disabled = function( )
								return true
							end,
							hidden = function( info )
								local loc_id = ConfigGetNodeArg( info, #info - 3 )
								return not ArkInventory.LocationOptionGetReal( loc_id, "slot", "new", "show" )
							end,
							func = function( )
								-- reset item ages
								ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
							end,
						},
					},
				},
			},
		},
		
	}
	
	
	
	for id, data in pairs( ArkInventory.Global.Location ) do
		
		if data.canView then
			
			path[string.format( "%i", id )] = {
				cmdHidden = true,
				order = id,
				arg = id,
				type = "group",
				name = data.Name,
				args = args1,
			}
			
		end
		
	end
	
 end
 
function ArkInventory.ConfigInternalCategory( )
	
	local path = ArkInventory.Config.Internal.args.categories.args
	
	path.custom = {
		type = "group",
		name = ArkInventory.Localise["CONFIG_CATEGORY_CUSTOM"],
		args = {
			add = {
				order = 100,
				name = ArkInventory.Localise["CONFIG_CATEGORY_ADD"],
				desc = ArkInventory.Localise["CONFIG_CATEGORY_ADD_TEXT"],
				type = "input",
				get = function( )
					return ""
				end,
				set = function( info, v )
					ArkInventory.CategoryCustomAdd( v )
					ArkInventory.ConfigInternalCategory( )
				end,
			},
			sortbyname = {
				order = 200,
				name = ArkInventory.Localise["SORT_BY_NAME"],
				type = "execute",
				func = function( )
					ArkInventory.Global.Options.CustomCategorySort = true
					ArkInventory.ConfigInternalCategory( )
				end,
			},
			sortbynumber = {
				order = 200,
				name = ArkInventory.Localise["SORT_BY_NUMBER"],
				type = "execute",
				func = function( )
					ArkInventory.Global.Options.CustomCategorySort = false
					ArkInventory.ConfigInternalCategory( )
				end,
			},
			reload = {
				order = 300,
				name = ArkInventory.Localise["RELOAD"],
				type = "execute",
				func = function( )
					ArkInventory.ConfigInternalCategory( )
				end,
			},
		},
	}
	
	ArkInventory.ConfigInternalCategoryCustom( path.custom.args )
	
end

function ArkInventory.ConfigInternalCategoryCustom( path )
	
	local args1 = {
		ren = { 
			order = 100,
			name = ArkInventory.Localise["RENAME"],
			desc = ArkInventory.Localise["CONFIG_CATEGORY_RENAME_TEXT"],
			type = "input",
			get = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.global.option.category[ArkInventory.Const.Category.Type.Custom].data[id].name
			end,
			set = function( info, v )
				local id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.CategoryCustomRename( id, v )
				ArkInventory.ConfigInternalCategory( )
			end,
		},
		del = { 
			order = 200,
			name = ArkInventory.Localise["DELETE"],
			desc = ArkInventory.Localise["CONFIG_CATEGORY_DELETE_TEXT"],
			type = "execute",
			func = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.CategoryCustomDelete( id, "DELETE" )
				ArkInventory.ConfigInternalCategory( )
			end,
		},
	}
	
	for k, cat in pairs( ArkInventory.db.global.option.category[ArkInventory.Const.Category.Type.Custom].data ) do
		
		if cat.used then
			
			local n = ""
			if ArkInventory.Global.Options.CustomCategorySort then
				n = string.format( "%s [%04i]", cat.name, k )
			else
				n = string.format( "[%04i] %s", k, cat.name )
			end
			
			path[string.format( "%i", k )] = {
				order = 100,
				name = n,
				arg = k,
				type = "group",
				args = args1,
			}
			
		end
		
	end
	
end
	
function ArkInventory.ConfigInternalSorting( )

	local path = ArkInventory.Config.Internal.args.sorting.args
	
	path.custom = {
		type = "group",
		name = ArkInventory.Localise["CONFIG_SORTMETHOD"],
		args = {
			add = {
				order = 100,
				name = ArkInventory.Localise["CONFIG_SORTMETHOD_ADD"],
				desc = ArkInventory.Localise["CONFIG_SORTMETHOD_ADD_TEXT"],
				type = "input",
				get = function( )
					return ""
				end,
				set = function( info, v )
					ArkInventory.SortKeyCustomAdd( v )
				end,
			},
			sortbyname = {
				order = 200,
				name = ArkInventory.Localise["SORT_BY_NAME"],
				type = "execute",
				func = function( )
					ArkInventory.Global.Options.CustomSortKeySort = true
					ArkInventory.ConfigInternalSorting( )
				end,
			},
			sortbynumber = {
				order = 200,
				name = ArkInventory.Localise["SORT_BY_NUMBER"],
				type = "execute",
				func = function( )
					ArkInventory.Global.Options.CustomSortKeySort = false
					ArkInventory.ConfigInternalSorting( )
				end,
			},
			reload = {
				order = 300,
				name = ArkInventory.Localise["RELOAD"],
				type = "execute",
				func = function( )
					ArkInventory.ConfigInternalSorting( )
				end,
			},
		},
	}
	
	ArkInventory.ConfigInternalSortingCustom( path.custom.args )
	
end

function ArkInventory.ConfigInternalSortingCustom( path )
	
	local args3 = {
		enabled = {
			order = 100,
			disabled = function( info )
				local id = ConfigGetNodeArg( info, #info - 3 )
				return ArkInventory.db.global.option.sort.data[id].system
			end,
			name = function( info )
				local id = ConfigGetNodeArg( info, #info - 3 )
				local key = ConfigGetNodeArg( info, #info - 1 )
				local checked = ArkInventory.db.global.option.sort.data[id].active[key]
				local n = ArkInventory.Localise[string.upper( string.format( "CONFIG_SORTMETHOD_INCLUDE_%s", key ) )]
				if checked then
					n = string.format( "%s%s%s", GREEN_FONT_COLOR_CODE, n, FONT_COLOR_CODE_CLOSE )
				else
					n = string.format( "%s%s%s", RED_FONT_COLOR_CODE, n, FONT_COLOR_CODE_CLOSE )
				end
				return n
			end,
			desc = function( info )
				local id = ConfigGetNodeArg( info, #info - 3 )
				local key = ConfigGetNodeArg( info, #info - 1 )
				local checked = ArkInventory.db.global.option.sort.data[id].active[key]
				local n = ArkInventory.Localise[string.upper( string.format( "CONFIG_SORTMETHOD_INCLUDE_%s_TEXT", key ) )]
				if not checked then
					n = string.format( "%s%s%s%s%s", n, "\n\n", RED_FONT_COLOR_CODE, ArkInventory.Localise["CONFIG_SORTMETHOD_NOT_INCLUDED"], FONT_COLOR_CODE_CLOSE )
				end
				return n
			end,
			type = "toggle",
			get = function( info )
				local id = ConfigGetNodeArg( info, #info - 3 )
				local key = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.global.option.sort.data[id].active[key]
			end,
			set = function( info, v )
				local id = ConfigGetNodeArg( info, #info - 3 )
				local key = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.db.global.option.sort.data[id].active[key] = v
				ArkInventory.LocationSetValue( nil, "resort", true )
				ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Resort )
			end,
		},
		up = {
			order = 200,
			name = ArkInventory.Localise["MOVE_UP"],
			desc = function( info )
				local key = ConfigGetNodeArg( info, #info - 1 )
				return string.format( ArkInventory.Localise["CONFIG_SORTMETHOD_MOVE_UP_TEXT"], string.format( "%s%s%s", LIGHTYELLOW_FONT_COLOR_CODE, ArkInventory.Localise[string.upper( string.format( "CONFIG_SORTMETHOD_INCLUDE_%s", key ) )], FONT_COLOR_CODE_CLOSE ) )
			end,
			type = "execute",
			disabled = function( info )
				local id = ConfigGetNodeArg( info, #info - 3 )
				local key = ConfigGetNodeArg( info, #info - 1 )
				local checked = ArkInventory.db.global.option.sort.data[id].active[key]
				return ArkInventory.db.global.option.sort.data[id].system or not checked
			end,
			func = function( info )
				local id = ConfigGetNodeArg( info, #info - 3 )
				local key = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.SortKeyMoveUp( id, key )
				ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Resort )
			end,
		},
		down = {
			order = 300,
			name = ArkInventory.Localise["MOVE_DOWN"],
			desc = function( info )
				local key = ConfigGetNodeArg( info, #info - 1 )
				return string.format( ArkInventory.Localise["CONFIG_SORTMETHOD_MOVE_DOWN_TEXT"], string.format( "%s%s%s", LIGHTYELLOW_FONT_COLOR_CODE, ArkInventory.Localise[string.upper( string.format( "CONFIG_SORTMETHOD_INCLUDE_%s", key ) )], FONT_COLOR_CODE_CLOSE ) )
			end,
			type = "execute",
			disabled = function( info )
				local id = ConfigGetNodeArg( info, #info - 3 )
				local key = ConfigGetNodeArg( info, #info - 1 )
				local checked = ArkInventory.db.global.option.sort.data[id].active[key]
				return ArkInventory.db.global.option.sort.data[id].system or not checked
			end,
			func = function( info )
				local id = ConfigGetNodeArg( info, #info - 3 )
				local key = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.SortKeyMoveDown( id, key )
				ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Resort )
			end,
		},
	}
	
	
	local args2 = { }
	for sortkey, active in pairs( ArkInventory.Const.SortKeys ) do
		
		if active then
			
			args2[sortkey] = {
				order = function( info )
					
					local p = 9000
					local id = ConfigGetNodeArg( info, #info - 2 )
					local t = ArkInventory.db.global.option.sort.data[id].order
					
					for k, v in ipairs( t ) do
						if info[#info] == v then
							p = k
							break
						end
					end
					
					return p
					
				end,
				name = "",
				type = "group",
				inline = true,
				hidden = false,
				arg = sortkey,
				args = args3,
			}
		end
	end
	
	
	local args1 = {
		ren = {
			order = 100,
			name = ArkInventory.Localise["RENAME"],
			desc = ArkInventory.Localise["CONFIG_SORTMETHOD_RENAME_TEXT"],
			type = "input",
			disabled = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.global.option.sort.data[id].system
			end,
			get = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.global.option.sort.data[id].name
			end,
			set = function( info, v )
				local id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.db.global.option.sort.data[id].name = strtrim( v )
				ArkInventory.ConfigInternalSorting( )
			end,
		},
		del = { 
			order = 200,
			name = ArkInventory.Localise["DELETE"],
			desc = ArkInventory.Localise["CONFIG_SORTMETHOD_DELETE_TEXT"],
			type = "execute",
			disabled = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.global.option.sort.data[id].system
			end,
			func = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.SortKeyCustomDelete( id, "DELETE" )
				ArkInventory.ConfigInternalSorting( )
			end,
		},
		style = {
			order = 300,
			name = ArkInventory.Localise["STYLE"],
			desc = ArkInventory.Localise["CONFIG_SORTMETHOD_STYLE_TEXT"],
			type = "select",
			disabled = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.global.option.sort.data[id].system
			end,
			values = function( )
				local t = { [1] = ArkInventory.Localise["CONFIG_SORTMETHOD_STYLE_BAGSLOT"], [2] = ArkInventory.Localise["CONFIG_SORTMETHOD_STYLE_USER"] }
				return t
			end,
			get = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				local v = ArkInventory.db.global.option.sort.data[id].bagslot
				if v then
					v = 1
				else
					v = 2
				end
				return v
			end,
			set = function( info, v )
				local id = ConfigGetNodeArg( info, #info - 1 )
				local v = v
				if v == 1 then
					v = true
				else
					v = false
				end
				ArkInventory.db.global.option.sort.data[id].bagslot = v
				ArkInventory.LocationSetValue( nil, "resort", true )
				ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Resort )
			end,
		},
		direction = {
			order = 400,
			name = ArkInventory.Localise["DIRECTION"],
			desc = ArkInventory.Localise["CONFIG_SORTMETHOD_DIRECTION_TEXT"],
			type = "select",
			disabled = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.global.option.sort.data[id].system
			end,
			values = function( )
				local t = { [1] = ArkInventory.Localise["ASCENDING"], [2] = ArkInventory.Localise["DECENDING"] }
				return t
			end,
			get = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				local v = ArkInventory.db.global.option.sort.data[id].ascending
				if v then
					v = 1
				else
					v = 2
				end
				return v
			end,
			set = function( info, v )
				local v = v
				if v == 1 then
					v = true
				else
					v = false
				end
				local id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.db.global.option.sort.data[id].ascending = v
				ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Resort )
			end,
		},
		order = {
			order = 500,
			name = ArkInventory.Localise["CONFIG_SORTMETHOD_ORDER"],
			type = "group",
			inline = true,
			disabled = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.global.option.sort.data[id].system
			end,
			hidden = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.global.option.sort.data[id].bagslot
			end,
			args = args2,
		},
		reverse = {
			order = 600,
			name = ArkInventory.Localise["CONFIG_SORTMETHOD_INCLUDE_NAME_REVERSE"],
			desc = ArkInventory.Localise["CONFIG_SORTMETHOD_INCLUDE_NAME_REVERSE_TEXT"],
			type = "toggle",
			disabled = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.global.option.sort.data[id].system
			end,
			hidden = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.global.option.sort.data[id].bagslot or not ArkInventory.db.global.option.sort.data[id].active.name
			end,
			get = function( info )
				local id = ConfigGetNodeArg( info, #info - 1 )
				return ArkInventory.db.global.option.sort.data[id].reversed
			end,
			set = function( info, v )
				local id = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.db.global.option.sort.data[id].reversed = v
				ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Resort )
			end,
		},
	}
	
	
	for id, data in pairs( ArkInventory.db.global.option.sort.data ) do
		
		if data.used then
			
			local n = ""
			if ArkInventory.Global.Options.CustomSortKeySort then
				n = string.format( "%s%s [%04i]", n, data.name or ArkInventory.Localise["UNKNOWN"], id )
			else
				n = string.format( "[%04i] %s%s", id, n, data.name or ArkInventory.Localise["UNKNOWN"] )
			end
			
			path[string.format( "%i", id )] = {
				order = 500,
				arg = id,
				name = n,
				type = "group",
				args = args1,
			}
			
		end
		
	end
	
end
	
function ArkInventory.Frame_Config_Hide( )
	return ArkInventory.Lib.Dialog:Close( ArkInventory.Const.Frame.Config.Internal )
end
	
function ArkInventory.Frame_Config_Show( ... )
	
	if not ArkInventory.Config.Internal.args then
		ArkInventory.ConfigInternal( )
	end
	
	ArkInventory.Config.Frame = ArkInventory.Lib.Dialog:Open( ArkInventory.Const.Frame.Config.Internal, ... )
	
end

function ArkInventory.Frame_Config_Toggle( )

	if not ArkInventory.Frame_Config_Hide( ) then
		ArkInventory.Frame_Config_Show( )
	end
	
end

function ArkInventory.ConfigInternalLDBMounts( path )
	
	local companionType = "MOUNT"
	
	local args3 = { }
	for k, mountType in pairs( { "ground", "flying", "water" } ) do
		
		args3[mountType] = {
			order = k,
			name = ArkInventory.Localise[string.upper( string.format( "LDB_MOUNTS_%s", mountType ) )],
			type = "select",
			values = function( info )
				
				local companionIndex = ConfigGetNodeArg( info, #info - 2 )
				local companionID, companionName, companionSpellID, texture, active = GetCompanionInfo( companionType, companionIndex )
				local companionData = ArkInventory.Const.CompanionData[companionSpellID]
				
				local t = { }
				t[1] = ArkInventory.Localise["NO"]
				t[2] = ArkInventory.Localise["YES"]
				
				if companionData.corrected and companionData.speed[mountType] then
					t[3] = ArkInventory.Localise["DEFAULT"]
				end
				
				return t
				
			end,
			get = function( info )
				
				local companionIndex = ConfigGetNodeArg( info, #info - 2 )
				local companionID, companionName, companionSpellID, texture, active = GetCompanionInfo( companionType, companionIndex )
				local companionData = ArkInventory.Const.CompanionData[companionSpellID]
				
				if not not companionData.usable[mountType] then
					return 2
				else
					return 1
				end
				
			end,
			set = function( info, v )
				
				local companionIndex = ConfigGetNodeArg( info, #info - 2 )
				local companionID, companionName, companionSpellID, texture, active = GetCompanionInfo( companionType, companionIndex )
				
				if v == 1 then
					ArkInventory.db.global.option.ldb.mounts[mountType].corrected[companionSpellID] = false
				elseif v == 2 then
					ArkInventory.db.global.option.ldb.mounts[mountType].corrected[companionSpellID] = true
				elseif v == 3 then
					ArkInventory.db.global.option.ldb.mounts[mountType].corrected[companionSpellID] = nil
				end
				
				ArkInventory.db.char.option.ldb.mounts[mountType].selected[companionSpellID] = nil
				
				ArkInventory.CompanionDataCorrect( )
				
				ArkInventory.LDB.Mounts:Update( )
				
				local args2 = ConfigGetNodeArg( info, #info - 1 )
				ArkInventory.ConfigInternalLDBMountsUpdate( path, args2 )
				
			end,
		}
		
	end
	
	local args2 = { }
	args2["mountname"] = {
		order = 1,
		type = "description",
		name = function( info ) 
			local companionIndex = ConfigGetNodeArg( info, #info - 1 )
			local companionID, companionName, companionSpellID, texture, active = GetCompanionInfo( companionType, companionIndex )
			return companionName
		end,
	}
	args2["capabilities"] = {
		order = 10,
		type = "group",
		name = "",
		inline = true,
		arg = args2,
		args = args3,
	}
	
	
	
	for k, mountType in pairs( { "ground", "flying", "water", "nodata" } ) do
		
		path[mountType] = {
			order = k,
			cmdHidden = true,
			type = "group",
			name = ArkInventory.Localise[string.upper( string.format( "LDB_MOUNTS_%s", mountType ) )],
			arg = mountType,
		}
		
	end
	
	ArkInventory.ConfigInternalLDBMountsUpdate( path, args2 )

end

function ArkInventory.ConfigInternalLDBMountsUpdate( path, args2 )
	
	local companionType = "MOUNT"
	
	
	for _, mountType in pairs( { "ground", "flying", "water", "nodata" } ) do
		
		if not path[mountType].args then
			path[mountType].args = { }
		end
		local mountList = path[mountType].args
		
		local n = GetNumCompanions( companionType )
		for companionIndex = 1, n do
			
			local companionID, companionName, companionSpellID, texture, active = GetCompanionInfo( companionType, companionIndex )
			local companionData = ArkInventory.Const.CompanionData[companionSpellID]
			local mountKey = tostring( companionIndex )
			
			local ok = false
			
			if ( not ok ) and ( mountType ~="nodata" ) and ( companionData.usable[mountType] ) then
				ok = true
			end
			
			if ( not ok ) and ( mountType == "nodata" ) and ( companionData.unknown or companionData.corrected ) then
				ok = true
			end
			
			if ok then
				if not mountList[mountKey] then
					--new mount, add it
					mountList[mountKey] = {
						type = "group",
						name = companionName,
						arg = companionIndex,
						args = args2,
					}
				else
					-- mount is already in the list, ignore
				end
			else
				if mountList[mountKey] then
					-- shouldnt be in this list, remove it 
					table.wipe( mountList[mountKey] )
					mountList[mountKey] = nil
				end
			end
			
		end
		
	end
	
end

