local LibDualSpec = LibStub('LibDualSpec-1.0', true)
local L = LibStub("AceLocale-3.0"):GetLocale("nibIceHUD", false)
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
	name = L["nibIceHUD"],
	desc = L["nibIceHUD"],
	icon = "Interface\\Icons\\Spell_Frost_Frost",
	args =
	{
		headerGeneral = {
			type = 'header',
			name = L["General Settings"],
			order = 10
		},

		faq = {
			type = 'group',
			name = L["FAQs"],
			desc = L["Answers to questions that are frequently asked."],
			order = 1,
			args = {
				test = {
					type = 'description',
					fontSize = "medium",
					name = [[|cff9999ff1. How do I hide the HUD or change its transparency based on combat, targeting, etc.?|r
Check the "Transparency Settings" section. Nearly any combination of states should be available for tweaking.

|cff9999ff2. What's this thing at the top of the player's cast bar? It's darker than the rest of the bar.|r
That's the Cast Lag Indicator that shows you when you can start casting a new spell and still be able to finish the current one (based on your lag to the server). You can disable this in the Player Cast Bar module settings.

|cff9999ff3. Is there a bar that shows breath underwater, and if so how can I adjust it?|r
Yes, this is called the MirrorBarHandler in the |cffffdc42Module Settings|r. It's called that because it mirrors casting bar behavior, displays more than just breathing (fatigue is one example), and that's what Blizzard calls it. It can be moved/adjusted/resized/etc. as with any other module.

|cff9999ff4. How do I turn off these big huge bars that pulse whenever one of my abilities procs?|r
This isn't |cff9999ffnibIceHUD|r - it's Blizzard's new Spell Alerts they added in 4.0.1. Interface options => Combat => "Show Spell Alerts" to turn them off.]]
				}
			}
		},

		positioningSettings = {
			type = 'group',
			name = L["Positioning Settings"],
			desc = L["Settings related to positioning and alpha"],
			order = 11,
			args = {
				vpos = {
					type = 'range',
					name = L["Vertical position"],
					desc = L["Vertical position"],
					get = function()
						return nibIceHUD.IceCore:GetVerticalPos()
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetVerticalPos(v)
					end,
					min = -700,
					max = 700,
					step = 1,
					order = 11
				},

				hpos = {
					type = 'range',
					name = L["Horizontal position"],
					desc = L["Horizontal position (for you dual screen freaks)"],
					get = function()
						return nibIceHUD.IceCore:GetHorizontalPos()
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetHorizontalPos(v)
					end,
					min = -2000,
					max = 2000,
					step = 1,
					order = 12
				},

				gap = {
					type = 'range',
					name = L["Gap"],
					desc = L["Distance between the left and right bars"],
					get = function()
						return nibIceHUD.IceCore:GetGap()
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetGap(v)
					end,
					min = 50,
					max = 700,
					step = 5,
					order = 13,
				},

				scale = {
					type = 'range',
					name = L["Scale"],
					desc = L["HUD scale"],
					get = function()
						return nibIceHUD.IceCore:GetScale()
					end,
					set = function(info, v)
						nibIceHUD.IceCore:SetScale(v)
					end,
					min = 0.5,
					max = 1.5,
					step = 0.01,
					isPercent = true,
					order = 14,
				},
			}
		},


		alphaSettings = {
			type = 'group',
			name = L["Transparency Settings"],
			desc = L["Settings for bar transparencies"],
			order = 12,
			args = {
				headerAlpha = {
					type = 'header',
					name = L["Bar Alpha"],
					order = 10
				},

				alphaic = {
					type = 'range',
					name = L["Alpha in combat"],
					desc = L["Bar alpha In Combat"],
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
					name = L["Alpha out of combat"],
					desc = L["Bar alpha Out Of Combat without target"],
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
					name = L["Alpha OOC and Target"],
					desc = L["Bar alpha Out Of Combat with target accuired (takes precedence over Not Full)"],
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
					name = L["Alpha OOC and not full"],
					desc = L["Bar alpha Out Of Combat with target accuired or bar not full (Target takes precedence over this)"],
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
					name = L["Background Alpha"],
					order = 20
				},

				alphaicbg = {
					type = 'range',
					name = L["BG Alpha in combat"],
					desc = L["Background alpha for bars IC"],
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
					name = L["BG Alpha out of combat"],
					desc = L["Background alpha for bars OOC without target"],
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
					name = L["BG Alpha OOC and Target"],
					desc = L["Background alpha for bars OOC and target accuired (takes precedence over Not Full)"],
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
					name = L["BG Alpha OOC and not Full"],
					desc = L["Background alpha for bars OOC and bar not full (Target takes precedence over this)"],
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
					name = L["Other"],
					order = 30
				},

				backgroundToggle = {
					type = "toggle",
					name = L["Contextual Background"],
					desc = L["Toggles contextual background coloring"],
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
					name = L["Background Color"],
					desc = L["Background Color"],
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
			name = L["Font"],
			order = 19,
			args = {
				font = {
					type = 'select',
					dialogControl = "LSM30_Font",
					name = L["Font"],
					get = function(info)
						return nibIceHUD.IceCore:GetFontFamily()
					end,
					set = function(info, value)
						nibIceHUD.IceCore:SetFontFamily(value)
					end,
					disabled = function()
						return not nibIceHUD.IceCore:IsEnabled()
					end,
					values = AceGUIWidgetLSMlists.font,
					order = 94.75,
				},
				fontsize = {
					type = 'range',
					name = L["Bar Font Size"],
					get = function()
						return nibIceHUD.IceCore:GetFontSize()
					end,
					set = function(info, value)
						nibIceHUD.IceCore:SetFontSize(value)
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
					name = L["Font"].." (large)",
					get = function(info)
						return nibIceHUD.IceCore:GetFontFamilyLarge()
					end,
					set = function(info, value)
						nibIceHUD.IceCore:SetFontFamilyLarge(value)
					end,
					disabled = function()
						return not nibIceHUD.IceCore:IsEnabled()
					end,
					values = AceGUIWidgetLSMlists.font,
					order = 94.85,
				},
				fontsizelarge = {
					type = 'range',
					name = L["Bar Font Size"].." (large)",
					get = function()
						return nibIceHUD.IceCore:GetFontSizeLarge()
					end,
					set = function(info, value)
						nibIceHUD.IceCore:SetFontSizeLarge(value)
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
							if v == nibIceHUD.IceCore:GetFontOutline() then return k end
						end
					end,
					set = function(info, value)
						nibIceHUD.IceCore:SetFontOutline(table_Outline[value])
					end,
					disabled = function()
						return not nibIceHUD.IceCore:IsEnabled()
					end,
					values = table_Outline,
					order = 94.95,
				},
			},
			

		},

		barSettings = {
			type = 'group',
			name = L["Bar Settings"],
			desc = L["Settings related to bars"],
			order = 20,
			args = {
				headerBarAdvanced = {
					type = 'header',
					name = L["Advanced Bar Settings"],
					order = 10
				},

				barTexture = {
					type = 'select',
					name = L["Bar Texture"],
					desc = L["nibIceHUD Bar Texture"],
					get = function(info)
						return nibIceHUD:GetSelectValue(info, nibIceHUD.IceCore:GetBarTexture())
					end,
					set = function(info, value)
						nibIceHUD.IceCore:SetBarTexture(nibIceHUD.validBarList[value])
					end,
					values = nibIceHUD.validBarList,
					order = 11
				},

				barWidth = {
					type = 'range',
					name = L["Bar Width"],
					desc = L["Bar texture width (not the actual bar!)"],
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
					name = L["Bar Height"],
					desc = L["Bar texture height (not the actual bar!)"],
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
					name = L["Bar Proportion"],
					desc = L["Determines the bar width compared to the whole texture width"],
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
					name = L["Bar Space"],
					desc = L["Space between bars on the same side"],
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
					name = L["Bar Background Blend Mode"],
					desc = L["nibIceHUD Bar Background Blend mode"],
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
					name = L["Bar Blend Mode"],
					desc = L["nibIceHUD Bar Blend mode"],
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
			desc = L["Module configuration options"],
			name = L["Module Settings"],
			args = {},
			order = 41
		},

		colors = {
			type='group',
			desc = L["Module color configuration options"],
			name = L["Colors"],
			args = {},
			order = 42
		},

		enabled = {
			type = "toggle",
			name = L["Enabled"],
			desc = L["Enable/disable nibIceHUD"],
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
			name = L["Debugging"],
			desc = L["Enable/disable debug messages"],
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

		customModuleSelect = {
			type = "select",
			name = L["Create custom module"],
			desc = L["Select a custom module that you want to create here, then press the 'Create' button."],
			get = function(info)
				return lastCustomModule
			end,
			set = function(info, v)
				lastCustomModule = v
			end,
			values = nibIceHUD.validCustomModules,
			order = 94.5,
		},

		customModuleCreate = {
			type = "execute",
			name = L["Create"],
			desc = L["Creates the selected custom module"],
			func = function()
				nibIceHUD:CreateCustomModuleAndNotify(lastCustomModule)
			end,
			disabled = function()
				return not nibIceHUD.IceCore:IsEnabled()
			end,
			order = 94.6,
		},

		configMode = {
			type = 'toggle',
			name = L["Configuration Mode"],
			desc = L["Makes all modules visible so you can see where they're placed and find any that are overlapping."],
			get = function()
				return nibIceHUD.IceCore:IsInConfigMode()
			end,
			set = function(info, value)
				nibIceHUD.IceCore:ConfigModeToggle(value)
			end,
			disabled = function()
				return not nibIceHUD.IceCore:IsEnabled()
			end,
			order = 95
		},

		updatePeriod = {
			type = 'range',
			name = L["Update Period"],
			desc = L["Number of updates per second. The higher this number is, the smoother bars will animate. However, higher settings will also use more CPU, so balance it to your liking. 30 is the recommended setting."],
			get = function()
				return math.ceil(1/nibIceHUD.IceCore:UpdatePeriod())
			end,
			set = function(info, v)
				nibIceHUD.IceCore:SetUpdatePeriod(1/v)
			end,
			min = 15,
			max = 60,
			step = 1,
			order = 97
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

	-- Add dual-spec support
	if nibIceHUD.db ~= nil and LibDualSpec then
		LibDualSpec:EnhanceOptions(nibIceHUD_Options.options.args.profiles, nibIceHUD.db)
	end

	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibIceHUD", options, "nibIceHUDcl")
end

if nibIceHUD and nibIceHUD.IceCore then
	nibIceHUD_Options:OnLoad()
end
