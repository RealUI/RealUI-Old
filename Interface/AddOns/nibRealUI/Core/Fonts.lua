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
				name = "Note: 3rd party addons such as MSBT will need fonts adjusted through their own configuration window.",
				order = 22,
			},
			desc4 = {
				type = "description",
				name = "Note2: You will need to reload the UI (/rl) for changes to take effect.",
				order = 23,
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
				},
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
	
	STANDARD_TEXT_FONT = font
	UNIT_NAME_FONT     = font
	DAMAGE_TEXT_FONT   = font
	NAMEPLATE_FONT     = font

	-- Base fonts
	NumberFont_OutlineThick_Mono_Small:SetFont(font, 12 + resSizeExtra + adjSize, "OUTLINE")
	NumberFont_Outline_Huge:SetFont(font, 30 + adjSize, "OUTLINE")
	NumberFont_Outline_Large:SetFont(font, 16 + adjSize, "OUTLINE")
	NumberFont_Outline_Med:SetFont(font, 14 + adjSize, "OUTLINE")
	NumberFont_Shadow_Med:SetFont(font, 14 + adjSize)
	NumberFont_Shadow_Small:SetFont(font, 12 + resSizeExtra + adjSize)
	QuestFont:SetFont(font, 12 + resSizeExtra + adjSize)
	QuestFont_Shadow_Small:SetFont(font, 14 + adjSize)
	QuestFont_Large:SetFont(font, 15 + adjSize)
	QuestFont_Shadow_Huge:SetFont(font, 17 + adjSize)
	QuestFont_Super_Huge:SetFont(font, 22 + adjSize)
	SubSpellFont:SetFont(font, 10 + resSizeExtra + adjSize)
	FriendsFont_UserText:SetFont(font, 11 + resSizeExtra + adjSize)
	SystemFont_InverseShadow_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	SystemFont_Large:SetFont(font, 15 + adjSize)
	SystemFont_Huge1:SetFont(font, 18 + adjSize)
	SystemFont_Med1:SetFont(font, 11 + resSizeExtra + adjSize)
	SystemFont_Med2:SetFont(font, 12 + resSizeExtra + adjSize)
	SystemFont_Med3:SetFont(font, 13 + resSizeExtra + adjSize)
	SystemFont_OutlineThick_WTF:SetFont(font, 28 + adjSize, "THICKOUTLINE")
	SystemFont_OutlineThick_Huge2:SetFont(font, 20 + adjSize, "THICKOUTLINE")
	SystemFont_OutlineThick_Huge4:SetFont(font, 24 + adjSize, "THICKOUTLINE")
	SystemFont_Outline_Small:SetFont(font, 10 + resSizeExtra + adjSize, "OUTLINE")
	SystemFont_Outline:SetFont(font, 13 + resSizeExtra + adjSize, "OUTLINE")
	SystemFont_Shadow_Large:SetFont(font, 15 + adjSize)
	SystemFont_Shadow_Med1:SetFont(font, 11 + resSizeExtra + adjSize)
	SystemFont_Shadow_Med2:SetFont(font, 12 + resSizeExtra + adjSize)
	SystemFont_Shadow_Med3:SetFont(font, 13 + resSizeExtra + adjSize)
	SystemFont_Shadow_Outline_Huge2:SetFont(font, 20 + adjSize, "OUTLINE")
	SystemFont_Shadow_Huge1:SetFont(font, 18 + adjSize)
	SystemFont_Shadow_Huge3:SetFont(font, 23 + adjSize)
	SystemFont_Shadow_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	SystemFont_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	SystemFont_Tiny:SetFont(font, 9 + resSizeExtra + adjSize)
	SpellFont_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	Tooltip_Med:SetFont(font, 12 + resSizeExtra + adjSize)
	Tooltip_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	CombatTextFont:SetFont(font, 25 + adjSize)
	MailFont_Large:SetFont(font, 15 + adjSize)
	InvoiceFont_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	InvoiceFont_Med:SetFont(font, 12 + resSizeExtra + adjSize)
	ReputationDetailFont:SetFont(font, 10 + resSizeExtra + adjSize)
	AchievementFont_Small:SetFont(font, 10 + resSizeExtra + adjSize)
	GameFont_Gigantic:SetFont(font, 28 + adjSize)
	ErrorFont:SetFont(font, 13 + resSizeExtra + adjSize, "OUTLINE")
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
	RealUIFontTiny = nibRealUI.font.pixeltiny
	RealUIFontLarge = nibRealUI.font.pixellarge
	
	self:UpdateUIFonts()
	
	self:RegisterEvent("PLAYER_LOGIN")
end