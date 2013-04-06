local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db, ndbc
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local MODNAME = "Fonts"
local Fonts = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

nibRealUI.font = {
	standard = nil,
	pixel1 = nil,
	pixel2 = nil,
	pixellarge = nil,
	pixeltiny = nil,
}

RealUIFontTiny = CreateFont("RealUIFontObjectTiny")
RealUIFontLarge = CreateFont("RealUIFontObjectLarge")
RealUIFontPixel = CreateFont("RealUIFontObjectPixel")

-- Options
local table_Outline = {
	"NONE",
	"OUTLINE",
	"THICKOUTLINE",
	"MONOCHROMEOUTLINE",
}

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Fonts",
		desc = "Adjust the fonts used in RealUI.",
		arg = MODNAME,
		order = 9900,
		args = {
			header = {
				type = "header",
				name = "Fonts",
				order = 10,
			},
			desc1 = {
				type = "description",
				name = "Adjust the fonts used in RealUI.",
				fontSize = "medium",
				order = 20,
			},
			desc2 = {
				type = "description",
				name = " ",
				order = 21,
			},
			desc3 = {
				type = "description",
				name = "Note: Some 3rd party addons (such as MSBT) will need fonts adjusted through their own configuration window.",
				order = 22,
			},
			desc4 = {
				type = "description",
				name = "Note2: You will need to reload the UI (/rl) for changes to take effect.",
				order = 23,
			},
			gap1 = {
				name = " ",
				type = "description",
				order = 24,
			},
			standard = {
				name = "Standard",
				type = "group",
				inline = true,
				order = 30,
				args = {
					font = {
						type = "select",
						name = "Font",
						values = AceGUIWidgetLSMlists.font,
						get = function()
							return nibRealUI.media.font.standard[1]
						end,
						set = function(info, value)
							nibRealUI.media.font.standard[1] = value
						end,
						dialogControl = "LSM30_Font",
						order = 10,
					},
					sizeadjust = {
						type = "range",
						name = "Adjust Size",
						min = -6, max = 6, step = 1,
						get = function(info) return db.standard.sizeadjust end,
						set = function(info, value) 
							db.standard.sizeadjust = value
						end,
						order = 20,
					},
					changeYellow = {
						type = "toggle",
						name = "Adjust Yellow Fonts",
						desc = "Change the color of WoW's 'yellow' fonts.",
						get = function() return db.standard.changeYellow end,
						set = function(info, value) 
							db.standard.changeYellow = value
							InfoLine:Refresh()
						end,
						order = 30,
					},
					yellowColor = {
						type = "color",
						name = "Yellow Font Color",
						hasAlpha = false,
						get = function(info,r,g,b)
							return db.standard.yellowColor[1], db.standard.yellowColor[2], db.standard.yellowColor[3]
						end,
						set = function(info,r,g,b)
							db.standard.yellowColor[1] = r
							db.standard.yellowColor[2] = g
							db.standard.yellowColor[3] = b
						end,
						order = 40,
					},
				},
			},
			gap2 = {
				name = " ",
				type = "description",
				order = 31,
			},
			lowres = {
				name = "Low Res",
				type = "group",
				inline = true,
				order = 40,
				args = {
					pixel_lr_small = {
						name = "Pixel (Small)",
						type = "group",
						inline = true,
						order = 10,
						args = {
							font = {
								type = "select",
								name = "Font",
								values = AceGUIWidgetLSMlists.font,
								get = function()
									return nibRealUI.media.font.pixel.lowres.small[1]
								end,
								set = function(info, value)
									nibRealUI.media.font.pixel.lowres.small[1] = value
								end,
								dialogControl = "LSM30_Font",
								order = 10,
							},
							size = {
								type = "range",
								name = "Size",
								min = 6, max = 28, step = 1,
								get = function(info) return nibRealUI.media.font.pixel.lowres.small[2] end,
								set = function(info, value)
									nibRealUI.media.font.pixel.lowres.small[2] = value
								end,
								order = 20,
							},
							outline = {
								type = "select",
								name = "Outline",
								values = table_Outline,
								get = function()
									for k,v in pairs(table_Outline) do
										if v == nibRealUI.media.font.pixel.lowres.small[3] then return k end
									end
								end,
								set = function(info, value)
									nibRealUI.media.font.pixel.lowres.small[3] = table_Outline[value]
								end,
								order = 30,
							},
						},
					},
					pixel_lr_large = {
						name = "Pixel (Large)",
						type = "group",
						inline = true,
						order = 20,
						args = {
							font = {
								type = "select",
								name = "Font",
								values = AceGUIWidgetLSMlists.font,
								get = function()
									return nibRealUI.media.font.pixel.lowres.large[1]
								end,
								set = function(info, value)
									nibRealUI.media.font.pixel.lowres.large[1] = value
								end,
								dialogControl = "LSM30_Font",
								order = 10,
							},
							size = {
								type = "range",
								name = "Size",
								min = 6, max = 28, step = 1,
								get = function(info) return nibRealUI.media.font.pixel.lowres.large[2] end,
								set = function(info, value)
									nibRealUI.media.font.pixel.lowres.large[2] = value
								end,
								order = 20,
							},
							outline = {
								type = "select",
								name = "Outline",
								values = table_Outline,
								get = function()
									for k,v in pairs(table_Outline) do
										if v == nibRealUI.media.font.pixel.lowres.large[3] then return k end
									end
								end,
								set = function(info, value)
									nibRealUI.media.font.pixel.lowres.large[3] = table_Outline[value]
								end,
								order = 30,
							},
						},
					},
				},
			},
			gap3 = {
				name = " ",
				type = "description",
				order = 41,
			},
			highres = {
				name = "High Res",
				type = "group",
				inline = true,
				order = 50,
				args = {
					pixel_hr_small = {
						name = "Pixel (Small)",
						type = "group",
						inline = true,
						order = 10,
						args = {
							font = {
								type = "select",
								name = "Font",
								values = AceGUIWidgetLSMlists.font,
								get = function()
									return nibRealUI.media.font.pixel.highres.small[1]
								end,
								set = function(info, value)
									nibRealUI.media.font.pixel.highres.small[1] = value
								end,
								dialogControl = "LSM30_Font",
								order = 10,
							},
							size = {
								type = "range",
								name = "Size",
								min = 6, max = 28, step = 1,
								get = function(info) return nibRealUI.media.font.pixel.highres.small[2] end,
								set = function(info, value)
									nibRealUI.media.font.pixel.highres.small[2] = value
								end,
								order = 20,
							},
							outline = {
								type = "select",
								name = "Outline",
								values = table_Outline,
								get = function()
									for k,v in pairs(table_Outline) do
										if v == nibRealUI.media.font.pixel.highres.small[3] then return k end
									end
								end,
								set = function(info, value)
									nibRealUI.media.font.pixel.highres.small[3] = table_Outline[value]
								end,
								order = 30,
							},
						},
					},
					pixel_hr_large = {
						name = "Pixel (Large)",
						type = "group",
						inline = true,
						order = 20,
						args = {
							font = {
								type = "select",
								name = "Font",
								values = AceGUIWidgetLSMlists.font,
								get = function()
									return nibRealUI.media.font.pixel.highres.large[1]
								end,
								set = function(info, value)
									nibRealUI.media.font.pixel.highres.large[1] = value
								end,
								dialogControl = "LSM30_Font",
								order = 10,
							},
							size = {
								type = "range",
								name = "Size",
								min = 6, max = 28, step = 1,
								get = function(info) return nibRealUI.media.font.pixel.highres.large[2] end,
								set = function(info, value)
									nibRealUI.media.font.pixel.highres.large[2] = value
								end,
								order = 20,
							},
							outline = {
								type = "select",
								name = "Outline",
								values = table_Outline,
								get = function()
									for k,v in pairs(table_Outline) do
										if v == nibRealUI.media.font.pixel.highres.large[3] then return k end
									end
								end,
								set = function(info, value)
									nibRealUI.media.font.pixel.highres.large[3] = table_Outline[value]
								end,
								order = 30,
							},
						},
					},
				},
			},
		},
	};
	end
	return options;
end

function Fonts:UpdateUIFonts2()
	local font = nibRealUI.font.standard
	local resSizeExtra = db.resolution[ndbc.resolution].size
	local adjSize = db.standard.sizeadjust
	
	RaidWarningFrame.slot1:SetFont(font, 20, "OUTLINE")
	RaidWarningFrame.slot2:SetFont(font, 20, "OUTLINE")
	RaidBossEmoteFrame.slot1:SetFont(font, 20, "OUTLINE")
	RaidBossEmoteFrame.slot2:SetFont(font, 20, "OUTLINE")
	
	STANDARD_TEXT_FONT = font
	UNIT_NAME_FONT     = font
	DAMAGE_TEXT_FONT   = font
	NAMEPLATE_FONT     = font

	-- Base fonts
	AchievementFont_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	AchievementFont_Small:SetShadowColor(0, 0, 0)
	AchievementFont_Small:SetShadowOffset(1, -1)
	CoreAbilityFont:SetFont(font, 32)
	CoreAbilityFont:SetShadowColor(0, 0, 0)
	CoreAbilityFont:SetShadowOffset(1, -1)
	DestinyFontHuge:SetFont(font, 32)
	DestinyFontHuge:SetShadowColor(0, 0, 0)
	DestinyFontHuge:SetShadowOffset(1, -1)
	DestinyFontLarge:SetFont(font, 18)
	DestinyFontLarge:SetShadowColor(0, 0, 0)
	DestinyFontLarge:SetShadowOffset(1, -1)
	FriendsFont_Normal:SetFont(font, 11 + resSizeExtra + adjSize)
	FriendsFont_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	FriendsFont_Large:SetFont(font, 13)
	FriendsFont_UserText:SetFont(font, 10 + resSizeExtra + adjSize)
	GameFont_Gigantic:SetFont(font, 32)
	GameTooltipHeader:SetFont(font, 13)
	GameTooltipHeader:SetShadowColor(0, 0, 0)
	GameTooltipHeader:SetShadowOffset(1, -1)
	InvoiceFont_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	InvoiceFont_Small:SetShadowColor(0, 0, 0)
	InvoiceFont_Small:SetShadowOffset(1, -1)
	InvoiceFont_Med:SetFont(font, 11 + resSizeExtra + adjSize)
	InvoiceFont_Med:SetShadowColor(0, 0, 0)
	InvoiceFont_Med:SetShadowOffset(1, -1)
	MailFont_Large:SetFont(font, 15)
	NumberFont_OutlineThick_Mono_Small:SetFont(font, 10 + resSizeExtra + adjSize, "OUTLINE")
	NumberFont_Outline_Huge:SetFont(font, 30, "OUTLINE")
	NumberFont_Outline_Large:SetFont(font, 15, "OUTLINE")
	NumberFont_Outline_Med:SetFont(font, 12, "OUTLINE")
	NumberFont_Shadow_Med:SetFont(font, 12)
	NumberFont_Shadow_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	QuestFont_Shadow_Small:SetFont(font, 10)
	QuestFont_Large:SetFont(font, 12)
	QuestFont_Large:SetShadowColor(0, 0, 0)
	QuestFont_Large:SetShadowOffset(1, -1)
	QuestFont_Shadow_Huge:SetFont(font, 18)
	QuestFont_Super_Huge:SetFont(font, 24)
	QuestFont_Super_Huge:SetShadowColor(0, 0, 0)
	QuestFont_Super_Huge:SetShadowOffset(1, -1)
	ReputationDetailFont:SetFont(font, 10 + resSizeExtra + adjSize)
	SpellFont_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	SpellFont_Small:SetShadowColor(0, 0, 0)
	SpellFont_Small:SetShadowOffset(1, -1)
	SystemFont_InverseShadow_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	GameFontNormal:SetFont(font, 11 + resSizeExtra + adjSize)
	SystemFont_Large:SetFont(font, 15)
	SystemFont_Large:SetShadowColor(0, 0, 0)
	SystemFont_Large:SetShadowOffset(1, -1)
	SystemFont_Huge1:SetFont(font, 20)
	SystemFont_Huge1:SetShadowColor(0, 0, 0)
	SystemFont_Huge1:SetShadowOffset(1, -1)
	SystemFont_Med1:SetFont(font, 11 + resSizeExtra + adjSize)
	SystemFont_Med1:SetShadowColor(0, 0, 0)
	SystemFont_Med1:SetShadowOffset(1, -1)
	SystemFont_Med2:SetFont(font, 12 + resSizeExtra + adjSize)
	SystemFont_Med2:SetShadowColor(0, 0, 0)
	SystemFont_Med2:SetShadowOffset(1, -1)
	SystemFont_Med3:SetFont(font, 13 + resSizeExtra + adjSize)
	SystemFont_Med3:SetShadowColor(0, 0, 0)
	SystemFont_Med3:SetShadowOffset(1, -1)
	SystemFont_OutlineThick_WTF:SetFont(font, 32, "THICKOUTLINE")
	SystemFont_OutlineThick_Huge2:SetFont(font, 22, "THICKOUTLINE")
	SystemFont_OutlineThick_Huge4:SetFont(font, 26, "THICKOUTLINE")
	SystemFont_Outline_Small:SetFont(font, 10 + resSizeExtra + adjSize, "OUTLINE")
	SystemFont_Outline:SetFont(font, 11 + resSizeExtra + adjSize, "OUTLINE")
	SystemFont_Shadow_Large:SetFont(font, 15)
	SystemFont_Shadow_Large_Outline:SetFont(font, 15)
	SystemFont_Shadow_Med1:SetFont(font, 11 + resSizeExtra + adjSize)
	SystemFont_Shadow_Med1_Outline:SetFont(font, 11 + resSizeExtra + adjSize, "OUTLINE")
	SystemFont_Shadow_Med2:SetFont(font, 12 + resSizeExtra + adjSize)
	SystemFont_Shadow_Med3:SetFont(font, 13 + resSizeExtra + adjSize)
	SystemFont_Shadow_Outline_Huge2:SetFont(font, 22, "OUTLINE")
	SystemFont_Shadow_Huge1:SetFont(font, 20)
	SystemFont_Shadow_Huge3:SetFont(font, 25)
	SystemFont_Shadow_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	SystemFont_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	SystemFont_Small:SetShadowColor(0, 0, 0)
	SystemFont_Small:SetShadowOffset(1, -1)
	SystemFont_Tiny:SetFont(font, 9 + resSizeExtra + adjSize)
	SystemFont_Tiny:SetShadowColor(0, 0, 0)
	SystemFont_Tiny:SetShadowOffset(1, -1)
	Tooltip_Med:SetFont(font, 11 + resSizeExtra + adjSize)
	Tooltip_Med:SetShadowColor(0, 0, 0)
	Tooltip_Med:SetShadowOffset(1, -1)
	Tooltip_Small:SetFont(font, 9 + resSizeExtra + adjSize)
	Tooltip_Small:SetShadowColor(0, 0, 0)
	Tooltip_Small:SetShadowOffset(1, -1)
	
	if db.standard.changeYellow then
		local yellowFonts = {
			GameFontNormal,
			GameFontNormalSmall,
			GameFontNormalMed3,
			GameFontNormalLarge,
			GameFontNormalHuge,
			BossEmoteNormalHuge,
			NumberFontNormalRightYellow,
			NumberFontNormalYellow,
			NumberFontNormalLargeRightYellow,
			NumberFontNormalLargeYellow,
			QuestTitleFontBlackShadow,
			DialogButtonNormalText,
			AchievementPointsFont,
			AchievementPointsFontSmall,
			AchievementDateFont,
			FocusFontSmall
		}
		for k, font in pairs(yellowFonts) do
			font:SetTextColor(db.standard.yellowColor[1], db.standard.yellowColor[2], db.standard.yellowColor[3])
		end
	end
end

function Fonts:UpdateUIFonts()
	-- Font code from Fontifier/FreeUI
	local font = nibRealUI.font.standard
	local resSizeExtra = db.resolution[ndbc.resolution].size
	local adjSize = db.standard.sizeadjust
	
	RaidWarningFrame.slot1:SetFont(font, 20 + adjSize, "OUTLINE")
	RaidWarningFrame.slot2:SetFont(font, 20 + adjSize, "OUTLINE")
	RaidBossEmoteFrame.slot1:SetFont(font, 20 + adjSize, "OUTLINE")
	RaidBossEmoteFrame.slot2:SetFont(font, 20 + adjSize, "OUTLINE")

	STANDARD_TEXT_FONT = font
	UNIT_NAME_FONT     = font
	DAMAGE_TEXT_FONT   = font
	NAMEPLATE_FONT     = font
	
	UIErrorsFrame:SetFont(font, 12 + resSizeExtra + adjSize, "OUTLINE")
	UIErrorsFrame:SetShadowOffset(0, 0)

	HelpFrameKnowledgebaseNavBarHomeButtonText:SetFont(font, 12 + resSizeExtra + adjSize)
end

function Fonts:PLAYER_LOGIN()
	self:UpdateUIFonts2()
end

function Fonts:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			standard = {
				sizeadjust = 0,
				changeYellow = true,
				yellowColor = {1, 0.65, 0}
			},
			resolution = {
				[1] = {
					size = 0,
				},
				[2] = {
					size = 1,
				},
			},
		}
	})
	db = self.db.profile
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(true)
	nibRealUI:RegisterPlainOptions(MODNAME, GetOptions)
	
	nibRealUI.font.standard = nibRealUI:GetFont("standard")
	nibRealUI.font.pixel1 = nibRealUI:GetFont("small")
	nibRealUI.font.pixel2 = nibRealUI:GetFont("large")
	nibRealUI.font.pixeltiny = {nibRealUI:RetrieveFont(nibRealUI.media.font.pixel.lowres.small[1]), nibRealUI.media.font.pixel.lowres.small[2], nibRealUI.media.font.pixel.lowres.small[3]}
	nibRealUI.font.pixellarge = {nibRealUI:RetrieveFont(nibRealUI.media.font.pixel.highres.small[1]), nibRealUI.media.font.pixel.highres.small[2], nibRealUI.media.font.pixel.highres.small[3]}
	
	RealUIFontTiny:SetFont(unpack(nibRealUI.font.pixeltiny))
	RealUIFontLarge:SetFont(unpack(nibRealUI.font.pixellarge))
	RealUIFontPixel:SetFont(unpack(nibRealUI.font.pixel1))
	
	self:UpdateUIFonts()
	
	self:RegisterEvent("PLAYER_LOGIN")
end