local lastCustomModule = "Bar"
local _
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

nibIceHUD_Options = {}

local table_Outline = {
	"NONE",
	"OUTLINE",
	"THICKOUTLINE",
	"MONOCHROMEOUTLINE",
}

local options =
{
	type = 'group',
	name = "nibIceHUD",
	desc = "nibIceHUD",
	icon = "Interface\\Icons\\Spell_Frost_Frost",
	args =
	{
		headerGeneral = {
			type = 'header',
			name = "General Settings",
			order = 10
		},
		
		-- positioningSettings = {
			-- type = 'group',
			-- name = "Positioning Settings",
			-- desc = "Settings related to positioning and alpha",
			-- order = 11,
			-- args = {

				-- gap1 = {
					-- type = 'range',
					-- name = "Gap - Low Res",
					-- desc = "Distance between the left and right bars",
					-- get = function()
						-- return nibIceHUD.IceCore:GetGap(1)
					-- end,
					-- set = function(info, v)
						-- nibIceHUD.IceCore:SetGap(v, 1)
					-- end,
					-- min = 50,
					-- max = 700,
					-- step = 5,
					-- order = 13,
				-- },
				-- gap2 = {
					-- type = 'range',
					-- name = "Gap - High Res",
					-- desc = "Distance between the left and right bars",
					-- get = function()
						-- return nibIceHUD.IceCore:GetGap(2)
					-- end,
					-- set = function(info, v)
						-- nibIceHUD.IceCore:SetGap(v, 2)
					-- end,
					-- min = 50,
					-- max = 700,
					-- step = 5,
					-- order = 15,
				-- },

			-- }
		-- },


		alphaSettings = {
			type = 'group',
			name = "Transparency Settings",
			desc = "Settings for bar transparencies",
			order = 12,
			args = {
				headerAlpha = {
					type = 'header',
					name = "Bar Alpha",
					order = 10
				},

				alphaic = {
					type = 'range',
					name = "Alpha in combat",
					desc = "Bar alpha In Combat",
					get = function()
						return nibIceHUD.IceCore:GetAlpha("IC")
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetAlpha("IC", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 11,
				},

				alphaooc = {
					type = 'range',
					name = "Alpha out of combat",
					desc = "Bar alpha Out Of Combat without target",
					get = function()
						return nibIceHUD.IceCore:GetAlpha("OOC")
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetAlpha("OOC", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 12,
				},

				alphaTarget = {
					type = 'range',
					name = "Alpha OOC and Target",
					desc = "Bar alpha Out Of Combat with target accuired (takes precedence over Not Full)",
					get = function()
						return nibIceHUD.IceCore:GetAlpha("Target")
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetAlpha("Target", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 13,
				},

				alphaNotFull = {
					type = 'range',
					name = "Alpha OOC and not full",
					desc = "Bar alpha Out Of Combat with target accuired or bar not full (Target takes precedence over this)",
					get = function()
						return nibIceHUD.IceCore:GetAlpha("NotFull")
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetAlpha("NotFull", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 14,
				},


				headerAlphaBackground = {
					type = 'header',
					name = "Background Alpha",
					order = 20
				},

				alphaicbg = {
					type = 'range',
					name = "BG Alpha in combat",
					desc = "Background alpha for bars IC",
					get = function()
						return nibIceHUD.IceCore:GetAlphaBG("IC")
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetAlphaBG("IC", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 21,
				},

				alphaoocbg = {
					type = 'range',
					name = "BG Alpha out of combat",
					desc = "Background alpha for bars OOC without target",
					get = function()
						return nibIceHUD.IceCore:GetAlphaBG("OOC")
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetAlphaBG("OOC", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 22,
				},

				alphaTargetbg = {
					type = 'range',
					name = "BG Alpha OOC and Target",
					desc = "Background alpha for bars OOC and target accuired (takes precedence over Not Full)",
					get = function()
						return nibIceHUD.IceCore:GetAlphaBG("Target")
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetAlphaBG("Target", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 23,
				},

				alphaNotFullbg = {
					type = 'range',
					name = "BG Alpha OOC and not Full",
					desc = "Background alpha for bars OOC and bar not full (Target takes precedence over this)",
					get = function()
						return nibIceHUD.IceCore:GetAlphaBG("NotFull")
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetAlphaBG("NotFull", v)
					end,
					min = 0,
					max = 1,
					step = 0.05,
					isPercent = true,
					order = 24,
				},


				headerBarAdvanced = {
					type = 'header',
					name = "Other",
					order = 30
				},

				backgroundToggle = {
					type = "toggle",
					name = "Contextual Background",
					desc = "Toggles contextual background coloring",
					get = function()
						return nibIceHUD.IceCore:GetBackgroundToggle()
					end,
					set = function(info, value)
						nibIceHUD.IceCore:SetBackgroundToggle(value)
					end,
					order = 31
				},

				backgroundColor = {
					type = 'color',
					name = "Background Color",
					desc = "Background Color",
					get = function()
						return nibIceHUD.IceCore:GetBackgroundColor()
					end,
					set = function(info, r, g, b)
						nibIceHUD.IceCore:SetBackgroundColor(r, g, b)
					end,
					order = 32,
				},
			}
		},


		textSettings = {
			type = 'group',
			name = "Font",
			order = 19,
			args = {
				lowres = {
					type = "group",
					name = "Low Res",
					order = 10,
					args = {
						font = {
							type = 'select',
							dialogControl = "LSM30_Font",
							name = "Font",
							get = function(info)
								return nibIceHUD.IceCore:GetFontFamily(1)
							end,
							set = function(info, value)
								nibIceHUD.IceCore:SetFontFamily(value, 1)
							end,
							disabled = function()
								return not nibIceHUD.IceCore:IsEnabled()
							end,
							values = AceGUIWidgetLSMlists.font,
							order = 94.75,
						},
						fontsize = {
							type = 'range',
							name = "Bar Font Size",
							get = function()
								return nibIceHUD.IceCore:GetFontSize(1)
							end,
							set = function(info, value)
								nibIceHUD.IceCore:SetFontSize(value, 1)
							end,
							min = 6,
							max = 20,
							step = 1,
							disabled = function()
								return not nibIceHUD.IceCore:IsEnabled()
							end,
							order = 94.80
						},
						fontlarge = {
							type = 'select',
							dialogControl = "LSM30_Font",
							name = "Font".." (large)",
							get = function(info)
								return nibIceHUD.IceCore:GetFontFamilyLarge(1)
							end,
							set = function(info, value)
								nibIceHUD.IceCore:SetFontFamilyLarge(value, 1)
							end,
							disabled = function()
								return not nibIceHUD.IceCore:IsEnabled()
							end,
							values = AceGUIWidgetLSMlists.font,
							order = 94.85,
						},
						fontsizelarge = {
							type = 'range',
							name = "Bar Font Size".." (large)",
							get = function()
								return nibIceHUD.IceCore:GetFontSizeLarge(1)
							end,
							set = function(info, value)
								nibIceHUD.IceCore:SetFontSizeLarge(value, 1)
							end,
							min = 6,
							max = 20,
							step = 1,
							disabled = function()
								return not nibIceHUD.IceCore:IsEnabled()
							end,
							order = 94.90
						},
						outline = {
							type = 'select',
							name = "Outline",
							get = function(info)
								for k,v in pairs(table_Outline) do
									if v == nibIceHUD.IceCore:GetFontOutline(1) then return k end
								end
							end,
							set = function(info, value)
								nibIceHUD.IceCore:SetFontOutline(table_Outline[value], 1)
							end,
							disabled = function()
								return not nibIceHUD.IceCore:IsEnabled()
							end,
							values = table_Outline,
							order = 94.95,
						},
					},
				},
				highres = {
					type = "group",
					name = "High Res",
					order = 20,
					args = {
						font = {
							type = 'select',
							dialogControl = "LSM30_Font",
							name = "Font",
							get = function(info)
								return nibIceHUD.IceCore:GetFontFamily(2)
							end,
							set = function(info, value)
								nibIceHUD.IceCore:SetFontFamily(value, 2)
							end,
							disabled = function()
								return not nibIceHUD.IceCore:IsEnabled()
							end,
							values = AceGUIWidgetLSMlists.font,
							order = 94.75,
						},
						fontsize = {
							type = 'range',
							name = "Bar Font Size",
							get = function()
								return nibIceHUD.IceCore:GetFontSize(2)
							end,
							set = function(info, value)
								nibIceHUD.IceCore:SetFontSize(value, 2)
							end,
							min = 6,
							max = 20,
							step = 1,
							disabled = function()
								return not nibIceHUD.IceCore:IsEnabled()
							end,
							order = 94.80
						},
						fontlarge = {
							type = 'select',
							dialogControl = "LSM30_Font",
							name = "Font".." (large)",
							get = function(info)
								return nibIceHUD.IceCore:GetFontFamilyLarge(2)
							end,
							set = function(info, value)
								nibIceHUD.IceCore:SetFontFamilyLarge(value, 2)
							end,
							disabled = function()
								return not nibIceHUD.IceCore:IsEnabled()
							end,
							values = AceGUIWidgetLSMlists.font,
							order = 94.85,
						},
						fontsizelarge = {
							type = 'range',
							name = "Bar Font Size".." (large)",
							get = function()
								return nibIceHUD.IceCore:GetFontSizeLarge(2)
							end,
							set = function(info, value)
								nibIceHUD.IceCore:SetFontSizeLarge(value, 2)
							end,
							min = 6,
							max = 20,
							step = 1,
							disabled = function()
								return not nibIceHUD.IceCore:IsEnabled()
							end,
							order = 94.90
						},
						outline = {
							type = 'select',
							name = "Outline",
							get = function(info)
								for k,v in pairs(table_Outline) do
									if v == nibIceHUD.IceCore:GetFontOutline(2) then return k end
								end
							end,
							set = function(info, value)
								nibIceHUD.IceCore:SetFontOutline(table_Outline[value], 2)
							end,
							disabled = function()
								return not nibIceHUD.IceCore:IsEnabled()
							end,
							values = table_Outline,
							order = 94.95,
						},
					},
				},
			},
			

		},

		barSettings = {
			type = 'group',
			name = "Bar Settings",
			desc = "Settings related to bars",
			order = 20,
			args = {
				headerBarAdvanced = {
					type = 'header',
					name = "Advanced Bar Settings",
					order = 10
				},
				
				barWidth = {
					type = 'range',
					name = "Bar Width",
					desc = "Bar texture width (not the actual bar!)",
					get = function()
						return nibIceHUD.IceCore:GetBarWidth()
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetBarWidth(v)
					end,
					min = 20,
					max = 200,
					step = 1,
					order = 12
				},

				barHeight = {
					type = 'range',
					name = "Bar Height",
					desc = "Bar texture height (not the actual bar!)",
					get = function()
						return nibIceHUD.IceCore:GetBarHeight()
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetBarHeight(v)
					end,
					min = 100,
					max = 300,
					step = 1,
					order = 13
				},

				barProportion = {
					type = 'range',
					name = "Bar Proportion",
					desc = "Determines the bar width compared to the whole texture width",
					get = function()
						return nibIceHUD.IceCore:GetBarProportion()
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetBarProportion(v)
					end,
					min = 0.01,
					max = 0.5,
					step = 0.01,
					isPercent = true,
					order = 14
				},

				barSpace = {
					type = 'range',
					name = "Bar Space",
					desc = "Space between bars on the same side",
					get = function()
						return nibIceHUD.IceCore:GetBarSpace()
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetBarSpace(v)
					end,
					min = -10,
					max = 30,
					step = 1,
					order = 15
				},

				bgBlendMode = {
					type = 'select',
					name = "Bar Background Blend Mode",
					desc = "nibIceHUD Bar Background Blend mode",
					get = function(info)
						return nibIceHUD.IceCore:GetBarBgBlendMode()
					end,
					set = function(info, value)
						nibIceHUD.IceCore:SetBarBgBlendMode(value)
					end,
					values = { BLEND = "Blend", ADD = "Additive" }, --"Disable", "Alphakey", "Mod" },
					order = 16
				},

				barBlendMode = {
					type = 'select',
					name = "Bar Blend Mode",
					desc = "nibIceHUD Bar Blend mode",
					get = function(info)
						return nibIceHUD.IceCore:GetBarBlendMode()
					end,
					set = function(info, value)
						nibIceHUD.IceCore:SetBarBlendMode(value)
					end,
					values = { BLEND = "Blend", ADD = "Additive" }, --"Disable", "Alphakey", "Mod" },
					order = 17
				},
			}
		},


		modules = {
			type='group',
			desc = "Module configuration options",
			name = "Module Settings",
			args = {},
			order = 41
		},

		colors = {
			type='group',
			desc = "Module color configuration options",
			name = "Colors",
			args = {},
			order = 42
		},

		enabled = {
			type = "toggle",
			name = "Enabled",
			desc = "Enable/disable nibIceHUD",
			get = function()
				return nibIceHUD.IceCore:IsEnabled()
			end,
			set = function(info, value)
				if (value) then
					nibIceHUD.IceCore:Enable(true)
				else
					nibIceHUD.IceCore:Disable(true)
				end
			end,
			order = 91
		},

		debug = {
			type = "toggle",
			name = "Debugging",
			desc = "Enable/disable debug messages",
			get = function()
				return nibIceHUD.IceCore:GetDebug()
			end,
			set = function(info, value)
				nibIceHUD.IceCore:SetDebug(value)
			end,
			hidden =
				--@non-debug@
				true
				--@end-non-debug@
				--[===[@debug@
				false
				--@end-debug@]===]
			,
			disabled =
				-- hello, snooper! this feature doesn't actually work yet, so enabling it won't help you much :)
				--@non-debug@
				true
				--@end-non-debug@
				--[===[@debug@
				false
				--@end-debug@]===]
			,
			order = 92
		},

		configMode = {
			type = 'toggle',
			name = "Configuration Mode",
			desc = "Makes all modules visible so you can see where they're placed and find any that are overlapping.",
			get = function()
				return nibIceHUD.IceCore:IsInConfigMode()
			end,
			set = function(info, value)
				nibIceHUD.IceCore:ConfigModeToggle(value)
			end,
			disabled = function()
				return not nibIceHUD.IceCore:IsEnabled()
			end,
			order = 94.6
		},

		customModuleCreate = {
			type = "execute",
			name = "Create custom timer",
			func = function()
				nibIceHUD:CreateCustomModuleAndNotify("Bar")
			end,
			disabled = function()
				return not nibIceHUD.IceCore:IsEnabled()
			end,
			order = 95,
		},
	}
}

nibIceHUD_Options.options = options

function nibIceHUD_Options:GenerateModuleOptions(firstLoad)
	self.options.args.modules.args = nibIceHUD.IceCore:GetModuleOptions()
	if not firstLoad then
		nibIceHUD:NotifyOptionsChange()
	end
end

function nibIceHUD_Options:OnLoad()
	self:GenerateModuleOptions(true)
	self.options.args.colors.args = nibIceHUD.IceCore:GetColorOptions()
	self.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(nibIceHUD.db)
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibIceHUD", options, "nibIceHUDcl")
end

if nibIceHUD and nibIceHUD.IceCore then
	nibIceHUD_Options:OnLoad()
end
