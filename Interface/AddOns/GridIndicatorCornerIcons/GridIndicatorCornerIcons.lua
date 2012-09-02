-- -------------------------------------------------------------------------- --
-- GridIndicatorCornerIcons by kunda                                          --
-- -------------------------------------------------------------------------- --

local L = GridIndicatorCornerIcons_Locales
local media = LibStub("LibSharedMedia-3.0", true)

local Grid = Grid

local GridFrame = Grid:GetModule("GridFrame")
local GridIndicatorCornerIcons = GridFrame:NewModule("GridIndicatorCornerIcons", "AceEvent-3.0")

local configMode = false

GridIndicatorCornerIcons.defaultDB = {
	iconSizeTopLeftCorner = 10,
	iconSizeTopRightCorner = 10,
	iconSizeBottomLeftCorner = 10,
	iconSizeBottomRightCorner = 10,
	xoffset = -4,
	yoffset = 2,
	iconBorderSize = 0,
	enableIconStackText = false,
	enableIconCooldown = false,
	IconStackTextSize = 8,
	IconStackTextXYaxis = 0,
	OriginalSize = false,
}

local options = {--GridIndicatorCornerIcons.options = {
	type = "group",
	--inline = true,
	icon = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-TRTLBLBR",
	name = L["Icon (Corners)"],
	desc = L["Options for Icon (Corners) indicators."],
	order = -0.571,--451,
	args = {
		["configuration"] = {
			type = "toggle",
			name = L["Configuration Mode"],
			desc = L["Shows all Icon (Corners) indicators."],
			order = 10,
			get = function() return configMode end,
			set = function(_, v)
				configMode = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons:GridIndicatorCornerIconsConfig(f) end)
			end
		},
		["header1"] = {
			type = "header",
			order = 15,
			width = "full",
			name = "",
		},
		["xoffset"] = {
			type = "range",
			name = L["Offset X-axis"],
			desc = L["Adjust the offset of the X-axis."],
			order = 20,
			width = "double",
			min = -20,
			max = 20,
			step = 1,
			get = function()
				return GridIndicatorCornerIcons.db.profile.xoffset
			end,
			set = function(_, v)
				GridIndicatorCornerIcons.db.profile.xoffset = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons.SetIconSize(f, v) end)
			end,
		},
		["yoffset"] = {
			type = "range",
			name = L["Offset Y-axis"],
			desc = L["Adjust the offset of the Y-axis."],
			order = 30,
			width = "double",
			min = -20,
			max = 20,
			step = 1,
			get = function()
				return GridIndicatorCornerIcons.db.profile.yoffset
			end,
			set = function(_, v)
				GridIndicatorCornerIcons.db.profile.yoffset = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons.SetIconSize(f, v) end)
			end,
		},
		["header2"] = {
			type = "header",
			order = 35,
			width = "full",
			name = "",
		},
		["originalsize"] = {
			type = "toggle",
			name = L["Same settings as Grid"],
			desc = L["If enabled, the settings for the Icon (Corners) indicators are adjustable with the standard Grid options. If deactivated, you can set individual settings for the Icon (Corners) indicators."],
			order = 40,
			width = "double",
			get = function()
				return GridIndicatorCornerIcons.db.profile.OriginalSize
			end,
			set = function(_, v)
				GridIndicatorCornerIcons.db.profile.OriginalSize = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons.SetIconSize(f, GridFrame.db.profile.iconSize) end)
				if configMode then GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons:GridIndicatorCornerIconsConfig(f) end) end
			end,
		},
		["header3"] = {
			type = "header",
			order = 45,
			width = "full",
			name = "",
		},
		["iconbordersize"] = {
			type = "range",
			name = L["Icon Border Size"],
			desc = L["Adjust the size of the icon's border."],
			order = 50,
			width = "double",
			disabled = function() return GridIndicatorCornerIcons.db.profile.OriginalSize end,
			min = 0,
			max = 4,
			step = 1,
			get = function()
				return GridIndicatorCornerIcons.db.profile.iconBorderSize
			end,
			set = function(_, v)
				GridIndicatorCornerIcons.db.profile.iconBorderSize = v
				GridFrame:UpdateAllFrames()
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons.SetIconSize(f, nil, v) end)
				if configMode then GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons:GridIndicatorCornerIconsConfig(f) end) end
			end,
		},
		["header4"] = {
			type = "header",
			order = 55,
			width = "full",
			name = "",
		},
		["iconcooldown"] = {
			type = "toggle",
			name = L["Enable Icon Cooldown Frame"],
			desc = L["Toggle icon's cooldown frame."],
			order = 60,
			width = "double",
			disabled = function() return GridIndicatorCornerIcons.db.profile.OriginalSize end,
			get = function()
				return GridIndicatorCornerIcons.db.profile.enableIconCooldown
			end,
			set = function(_, v)
				GridIndicatorCornerIcons.db.profile.enableIconCooldown = v
				GridFrame:UpdateAllFrames()
				if configMode then GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons:GridIndicatorCornerIconsConfig(f) end) end
			end,
		},
		["iconstacktext"] = {
			type = "toggle",
			name = L["Enable Icon Stack Text"],
			desc = L["Toggle icon's stack count text."],
			order = 70,
			width = "double",
			disabled = function() return GridIndicatorCornerIcons.db.profile.OriginalSize end,
			get = function()
				return GridIndicatorCornerIcons.db.profile.enableIconStackText
			end,
			set = function(_, v)
				GridIndicatorCornerIcons.db.profile.enableIconStackText = v
				GridFrame:UpdateAllFrames()
				if configMode then GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons:GridIndicatorCornerIconsConfig(f) end) end
			end,
		},
		["header5"] = {
			type = "header",
			order = 75,
			width = "full",
			name = "",
		},
		["iconstacktextfontsize"] = {
			type = "range",
			name = L["Icon Stack Text: Font Size"],
			desc = L["Adjust the font size for Icon Stack Text."],
			order = 80,
			width = "double",
			disabled = function() return not GridIndicatorCornerIcons.db.profile.enableIconStackText or GridIndicatorCornerIcons.db.profile.OriginalSize end,
			min = 6,
			max = 24,
			step = 1,
			get = function()
				return GridIndicatorCornerIcons.db.profile.IconStackTextSize
			end,
			set = function(_, v)
				GridIndicatorCornerIcons.db.profile.IconStackTextSize = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons.SetIconSize(f, v) end)
			end,
		},
		["iconstacktextxyoffset"] = {
			type = "range",
			name = L["Icon Stack Text: Offset XY-axis"],
			desc = L["Adjust the offset for Icon Stack Text of the XY-axis."],
			order = 90,
			width = "double",
			disabled = function() return not GridIndicatorCornerIcons.db.profile.enableIconStackText or GridIndicatorCornerIcons.db.profile.OriginalSize end,
			min = -4,
			max = 4,
			step = 1,
			get = function()
				return GridIndicatorCornerIcons.db.profile.IconStackTextXYaxis
			end,
			set = function(_, v)
				GridIndicatorCornerIcons.db.profile.IconStackTextXYaxis = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons.SetIconSize(f, v) end)
			end,
		},
		["header6"] = {
			type = "header",
			order = 95,
			width = "full",
			name = "",
		},
		["iconsizetopleftcorner"] = {
			type = "range",
			icon = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-TL",
			name = L["Icon Size Top Left Corner"],
			desc = L["Adjust the size of the 2 Top Left Corner Icons."],
			order = 100,
			width = "double",
			disabled = function() return GridIndicatorCornerIcons.db.profile.OriginalSize end,
			min = 5,
			max = 50,
			step = 1,
			get = function()
				return GridIndicatorCornerIcons.db.profile.iconSizeTopLeftCorner
			end,
			set = function(_, v)
				GridIndicatorCornerIcons.db.profile.iconSizeTopLeftCorner = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons.SetIconSize(f, v) end)
			end,
		},
		["iconsizetoprightcorner"] = {
			type = "range",
			icon = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-TR",
			name = L["Icon Size Top Right Corner"],
			desc = L["Adjust the size of the 2 Top Right Corner Icons."],
			order = 110,
			width = "double",
			disabled = function() return GridIndicatorCornerIcons.db.profile.OriginalSize end,
			min = 5,
			max = 50,
			step = 1,
			get = function()
				return GridIndicatorCornerIcons.db.profile.iconSizeTopRightCorner
			end,
			set = function(_, v)
				GridIndicatorCornerIcons.db.profile.iconSizeTopRightCorner = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons.SetIconSize(f, v) end)
			end,
		},
		["iconsizebottomleftcorner"] = {
			type = "range",
			icon = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-BL",
			name = L["Icon Size Bottom Left Corner"],
			desc = L["Adjust the size of the 2 Bottom Left Corner Icons."],
			order = 120,
			width = "double",
			disabled = function() return GridIndicatorCornerIcons.db.profile.OriginalSize end,
			min = 5,
			max = 50,
			step = 1,
			get = function()
				return GridIndicatorCornerIcons.db.profile.iconSizeBottomLeftCorner
			end,
			set = function(_, v)
				GridIndicatorCornerIcons.db.profile.iconSizeBottomLeftCorner = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons.SetIconSize(f, v) end)
			end,
		},
		["iconsizebottomrightcorner"] = {
			type = "range",
			icon = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-BR",
			name = L["Icon Size Bottom Right Corner"],
			desc = L["Adjust the size of the 2 Bottom Right Corner Icons."],
			order = 130,
			width = "double",
			disabled = function() return GridIndicatorCornerIcons.db.profile.OriginalSize end,
			min = 5,
			max = 50,
			step = 1,
			get = function()
				return GridIndicatorCornerIcons.db.profile.iconSizeBottomRightCorner
			end,
			set = function(_, v)
				GridIndicatorCornerIcons.db.profile.iconSizeBottomRightCorner = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerIcons.SetIconSize(f, v) end)
			end,
		}
	}
}
Grid.options.args["GridIndicatorCornerIcons"] = options

local indicators = GridFrame.prototype.indicators
table.insert(indicators, { type = "iconTLcornerleft",  order = 7.21, name = L["Top Left Corner Icon (Left)"] })
table.insert(indicators, { type = "iconTLcornerright", order = 7.22, name = L["Top Left Corner Icon (Right)"] })
table.insert(indicators, { type = "iconTRcornerleft",  order = 7.23, name = L["Top Right Corner Icon (Left)"] })
table.insert(indicators, { type = "iconTRcornerright", order = 7.24, name = L["Top Right Corner Icon (Right)"] })
table.insert(indicators, { type = "iconBLcornerleft",  order = 7.25, name = L["Bottom Left Corner Icon (Left)"] })
table.insert(indicators, { type = "iconBLcornerright", order = 7.26, name = L["Bottom Left Corner Icon (Right)"] })
table.insert(indicators, { type = "iconBRcornerleft",  order = 7.27, name = L["Bottom Right Corner Icon (Left)"] })
table.insert(indicators, { type = "iconBRcornerright", order = 7.28, name = L["Bottom Right Corner Icon (Right)"] })

local statusmap = GridFrame.db.profile.statusmap
if not statusmap["iconTLcornerleft"] then
	statusmap["iconTLcornerleft"] = {}
	statusmap["iconTLcornerright"] = {}
	statusmap["iconTRcornerleft"] = {}
	statusmap["iconTRcornerright"] = {}
	statusmap["iconBLcornerleft"] = {}
	statusmap["iconBLcornerright"] = {}
	statusmap["iconBRcornerleft"] = {}
	statusmap["iconBRcornerright"] = {}
end

function GridIndicatorCornerIcons:OnInitialize()
	GridFrame:RegisterModule(self.moduleName, self)

	hooksecurefunc(GridFrame, "UpdateOptionsMenu", self.CleanOptionsMenu)
	self:CleanOptionsMenu()

	--hook the functions we need.
	hooksecurefunc(GridFrame.prototype, "CreateIndicator", self.CreateIndicator)
	hooksecurefunc(GridFrame.prototype, "SetIndicator", self.SetIndicator)
	hooksecurefunc(GridFrame.prototype, "ClearIndicator", self.ClearIndicator)
	hooksecurefunc(GridFrame.prototype, "SetIconSize", self.SetIconSize)
end

function GridIndicatorCornerIcons:OnEnable()
	self:RegisterMessage("Grid_Enabled", "DisableConfigMode")
	self:RegisterMessage("Grid_Disabled", "DisableConfigMode")
end

function GridIndicatorCornerIcons:OnDisable()
	configMode = false
	self:UnregisterMessage("Grid_Enabled")
	self:UnregisterMessage("Grid_Disabled")
end

function GridIndicatorCornerIcons:Reset()
end

function GridIndicatorCornerIcons:DisableConfigMode()
	configMode = false
end

function GridIndicatorCornerIcons:CleanOptionsMenu()
	if not Grid.options.args.Indicators.args.iconTLcornerleft then return end
	if not GridIndicatorCornerIcons:IsEnabled() then return end

	Grid.options.args.Indicators.args.GridIndicatorCornerIcons = {
		type = "group",
		icon = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-TRTLBLBR",
		name = L["Icon (Corners)"],
		desc = L["Options for Icon (Corners) indicators."],
		order = 8.2,
		args = {
			["iconTLcornerleft"]  = Grid.options.args.Indicators.args.iconTLcornerleft,
			["iconTLcornerright"] = Grid.options.args.Indicators.args.iconTLcornerright,
			["iconTRcornerleft"]  = Grid.options.args.Indicators.args.iconTRcornerleft,
			["iconTRcornerright"] = Grid.options.args.Indicators.args.iconTRcornerright,
			["iconBLcornerleft"]  = Grid.options.args.Indicators.args.iconBLcornerleft,
			["iconBLcornerright"] = Grid.options.args.Indicators.args.iconBLcornerright,
			["iconBRcornerleft"]  = Grid.options.args.Indicators.args.iconBRcornerleft,
			["iconBRcornerright"] = Grid.options.args.Indicators.args.iconBRcornerright
		}
	}

	Grid.options.args.Indicators.args.GridIndicatorCornerIcons.args.iconTLcornerleft.icon  = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-TLleft"
	Grid.options.args.Indicators.args.GridIndicatorCornerIcons.args.iconTLcornerright.icon = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-TLright"
	Grid.options.args.Indicators.args.GridIndicatorCornerIcons.args.iconTRcornerleft.icon  = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-TRleft"
	Grid.options.args.Indicators.args.GridIndicatorCornerIcons.args.iconTRcornerright.icon = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-TRright"
	Grid.options.args.Indicators.args.GridIndicatorCornerIcons.args.iconBLcornerleft.icon  = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-BLleft"
	Grid.options.args.Indicators.args.GridIndicatorCornerIcons.args.iconBLcornerright.icon = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-BLright"
	Grid.options.args.Indicators.args.GridIndicatorCornerIcons.args.iconBRcornerleft.icon  = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-BRleft"
	Grid.options.args.Indicators.args.GridIndicatorCornerIcons.args.iconBRcornerright.icon = "Interface\\AddOns\\GridIndicatorCornerIcons\\GridIndicatorCornerIcons-icon-BRright"

	Grid.options.args.Indicators.args.iconTLcornerleft = nil
	Grid.options.args.Indicators.args.iconTLcornerright = nil
	Grid.options.args.Indicators.args.iconTRcornerleft = nil
	Grid.options.args.Indicators.args.iconTRcornerright = nil
	Grid.options.args.Indicators.args.iconBLcornerleft = nil
	Grid.options.args.Indicators.args.iconBLcornerright = nil
	Grid.options.args.Indicators.args.iconBRcornerleft = nil
	Grid.options.args.Indicators.args.iconBRcornerright = nil
end

function GridIndicatorCornerIcons:GridIndicatorCornerIconsConfig(frame)
	if configMode then
		local curTime = GetTime()
		self.SetIndicator(frame, "iconTLcornerleft",  {r=0.22, g=0.65, b=0.81, a=1}, "1", 1, 8, "Interface\\GroupFrame\\UI-Group-LeaderIcon",            curTime,  10, 8)
		self.SetIndicator(frame, "iconTLcornerright", {r=0.87, g=0.62, b=0.06, a=1}, "2", 2, 8, "Interface\\GroupFrame\\UI-Group-MasterLooter",          curTime,  30, 8)
		self.SetIndicator(frame, "iconTRcornerleft",  {r=0.29, g=0.21, b=0.81, a=1}, "3", 3, 8, "Interface\\Icons\\Spell_Holy_ArcaneIntellect",          curTime,  50, 8)
		self.SetIndicator(frame, "iconTRcornerright", {r=0.12, g=0.46, b=0.97, a=1}, "4", 4, 8, "Interface\\Icons\\Spell_Holy_PrayerOfFortitude",        curTime,  70, 8)
		self.SetIndicator(frame, "iconBLcornerleft",  {r=0.42, g=0.07, b=0.24, a=1}, "5", 5, 8, "Interface\\TargetingFrame\\UI-RaidTargetingIcon_2",     curTime,  90, 8)
		self.SetIndicator(frame, "iconBLcornerright", {r=0.17, g=0.65, b=0.33, a=1}, "6", 6, 8, "Interface\\Icons\\Spell_Holy_PrayerofSpirit",           curTime, 110, 8)
		self.SetIndicator(frame, "iconBRcornerleft",  {r=0.86, g=0.11, b=0.16, a=1}, "7", 7, 8, "Interface\\Icons\\Spell_Holy_PrayerofShadowProtection", curTime, 130, 8)
		self.SetIndicator(frame, "iconBRcornerright", {r=0.16, g=0.78, b=0.21, a=1}, "8", 8, 8, "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8",     curTime, 150, 8)
	else
		self.ClearIndicator(frame, "iconTLcornerleft")
		self.ClearIndicator(frame, "iconTLcornerright")
		self.ClearIndicator(frame, "iconTRcornerleft")
		self.ClearIndicator(frame, "iconTRcornerright")
		self.ClearIndicator(frame, "iconBLcornerleft")
		self.ClearIndicator(frame, "iconBLcornerright")
		self.ClearIndicator(frame, "iconBRcornerleft")
		self.ClearIndicator(frame, "iconBRcornerright")
		GridFrame:UpdateAllFrames()
	end
end

function GridIndicatorCornerIcons.CreateIndicator(f, indicator)
	local font = media and media:Fetch("font", GridFrame.db.profile.font) or STANDARD_TEXT_FONT
	local xoffset = GridIndicatorCornerIcons.db.profile.xoffset
	local yoffset = GridIndicatorCornerIcons.db.profile.yoffset
	local borderSize = GridIndicatorCornerIcons.db.profile.iconBorderSize
	local iconStackTextSize = GridIndicatorCornerIcons.db.profile.IconStackTextSize
	local iconStackTextXYaxis = GridIndicatorCornerIcons.db.profile.IconStackTextXYaxis
	if GridIndicatorCornerIcons.db.profile.OriginalSize then
		borderSize = GridFrame.db.profile.iconBorderSize
		iconStackTextSize = GridFrame.db.profile.fontSize
		iconStackTextXYaxis = 2
	end

	if indicator == "iconTLcornerleft" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeTopLeftCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			wh = GridFrame.db.profile.iconSize
		end

		-- create icon background/border
		f.iconTLcornerleftBG = CreateFrame("Frame", nil, f)
		f.iconTLcornerleftBG:SetWidth(wh + (2*borderSize))
		f.iconTLcornerleftBG:SetHeight(wh + (2*borderSize))
		f.iconTLcornerleftBG:SetPoint("TOPLEFT", f, "TOPLEFT", xoffset, yoffset)
		f.iconTLcornerleftBG:SetBackdrop({
					edgeFile = "Interface\\Addons\\Grid\\white16x16", edgeSize = 2,
					insets = {left = 2, right = 2, top = 2, bottom = 2},
					})
		f.iconTLcornerleftBG:SetBackdropBorderColor(1, 1, 1, 0)
		f.iconTLcornerleftBG:SetBackdropColor(0, 0, 0, 0)
		f.iconTLcornerleftBG:SetFrameLevel(5)
		f.iconTLcornerleftBG:Hide()

		-- create icon
		f.iconTLcornerleft = f.iconTLcornerleftBG:CreateTexture(nil, "OVERLAY")
		f.iconTLcornerleft:SetWidth(wh)
		f.iconTLcornerleft:SetHeight(wh)
		f.iconTLcornerleft:SetPoint("CENTER", f.iconTLcornerleftBG, "CENTER")
		f.iconTLcornerleft:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconTLcornerleft:SetTexture(1, 1, 1, 0)

		-- create icon text
		f.iconTLcornerleftText = f.iconTLcornerleftBG:CreateFontString(nil, "OVERLAY")
		f.iconTLcornerleftText:SetAllPoints(f.iconTLcornerleftBG)
		f.iconTLcornerleftText:SetFontObject(GameFontHighlightSmall)
		f.iconTLcornerleftText:SetFont(font, GridFrame.db.profile.fontSize)
		f.iconTLcornerleftText:SetJustifyH("CENTER")
		f.iconTLcornerleftText:SetJustifyV("CENTER")

		-- create icon cooldown
		f.iconTLcornerleftCD = CreateFrame("Cooldown", nil, f.iconTLcornerleftBG, "CooldownFrameTemplate")
		f.iconTLcornerleftCD:SetAllPoints(f.iconTLcornerleft)
		f.iconTLcornerleftCD:SetScript("OnHide", function()
			f.iconTLcornerleftStackText:SetParent(f.iconTLcornerleftBG)
			f.iconTLcornerleftStackText:SetPoint("BOTTOMRIGHT", f.iconTLcornerleftBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		end)

		-- create icon stack text
		f.iconTLcornerleftStackText = f.iconTLcornerleftBG:CreateFontString(nil, "OVERLAY")
		f.iconTLcornerleftStackText:SetPoint("BOTTOMRIGHT", f.iconTLcornerleftBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		f.iconTLcornerleftStackText:SetFontObject(GameFontHighlightSmall)
		f.iconTLcornerleftStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconTLcornerleftStackText:SetJustifyH("RIGHT")
		f.iconTLcornerleftStackText:SetJustifyV("BOTTOM")
	elseif indicator == "iconTLcornerright" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeTopLeftCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			wh = GridFrame.db.profile.iconSize
		end

		-- create icon background/border
		f.iconTLcornerrightBG = CreateFrame("Frame", nil, f)
		f.iconTLcornerrightBG:SetWidth(wh + (2*borderSize))
		f.iconTLcornerrightBG:SetHeight(wh + (2*borderSize))
		f.iconTLcornerrightBG:SetPoint("TOPLEFT", f, "TOPLEFT", (wh+xoffset)+(2*borderSize), yoffset)
		f.iconTLcornerrightBG:SetBackdrop({
					edgeFile = "Interface\\Addons\\Grid\\white16x16", edgeSize = 2,
					insets = {left = 2, right = 2, top = 2, bottom = 2},
					})
		f.iconTLcornerrightBG:SetBackdropBorderColor(1, 1, 1, 0)
		f.iconTLcornerrightBG:SetBackdropColor(0, 0, 0, 0)
		f.iconTLcornerrightBG:SetFrameLevel(5)
		f.iconTLcornerrightBG:Hide()

		-- create icon
		f.iconTLcornerright = f.iconTLcornerrightBG:CreateTexture(nil, "OVERLAY")
		f.iconTLcornerright:SetWidth(wh)
		f.iconTLcornerright:SetHeight(wh)
		f.iconTLcornerright:SetPoint("CENTER", f.iconTLcornerrightBG, "CENTER")
		f.iconTLcornerright:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconTLcornerright:SetTexture(1, 1, 1, 0)

		-- create icon text
		f.iconTLcornerrightText = f.iconTLcornerrightBG:CreateFontString(nil, "OVERLAY")
		f.iconTLcornerrightText:SetAllPoints(f.iconTLcornerrightBG)
		f.iconTLcornerrightText:SetFontObject(GameFontHighlightSmall)
		f.iconTLcornerrightText:SetFont(font, GridFrame.db.profile.fontSize)
		f.iconTLcornerrightText:SetJustifyH("CENTER")
		f.iconTLcornerrightText:SetJustifyV("CENTER")

		-- create icon cooldown
		f.iconTLcornerrightCD = CreateFrame("Cooldown", nil, f.iconTLcornerrightBG, "CooldownFrameTemplate")
		f.iconTLcornerrightCD:SetAllPoints(f.iconTLcornerright)
		f.iconTLcornerrightCD:SetScript("OnHide", function()
			f.iconTLcornerrightStackText:SetParent(f.iconTLcornerrightBG)
			f.iconTLcornerrightStackText:SetPoint("BOTTOMRIGHT", f.iconTLcornerrightBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		end)

		-- create icon stack text
		f.iconTLcornerrightStackText = f.iconTLcornerrightBG:CreateFontString(nil, "OVERLAY")
		f.iconTLcornerrightStackText:SetPoint("BOTTOMRIGHT", f.iconTLcornerrightBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		f.iconTLcornerrightStackText:SetFontObject(GameFontHighlightSmall)
		f.iconTLcornerrightStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconTLcornerrightStackText:SetJustifyH("RIGHT")
		f.iconTLcornerrightStackText:SetJustifyV("BOTTOM")
	elseif indicator == "iconTRcornerleft" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeTopRightCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			wh = GridFrame.db.profile.iconSize
		end

		-- create icon background/border
		f.iconTRcornerleftBG = CreateFrame("Frame", nil, f)
		f.iconTRcornerleftBG:SetWidth(wh + (2*borderSize))
		f.iconTRcornerleftBG:SetHeight(wh + (2*borderSize))
		f.iconTRcornerleftBG:SetPoint("TOPRIGHT", f, "TOPRIGHT", ((wh*-1)+(xoffset*-1))-(2*borderSize), yoffset)
		f.iconTRcornerleftBG:SetBackdrop({
					edgeFile = "Interface\\Addons\\Grid\\white16x16", edgeSize = 2,
					insets = {left = 2, right = 2, top = 2, bottom = 2},
					})
		f.iconTRcornerleftBG:SetBackdropBorderColor(1, 1, 1, 0)
		f.iconTRcornerleftBG:SetBackdropColor(0, 0, 0, 0)
		f.iconTRcornerleftBG:SetFrameLevel(5)
		f.iconTRcornerleftBG:Hide()

		-- create icon
		f.iconTRcornerleft = f.iconTRcornerleftBG:CreateTexture(nil, "OVERLAY")
		f.iconTRcornerleft:SetWidth(wh)
		f.iconTRcornerleft:SetHeight(wh)
		f.iconTRcornerleft:SetPoint("CENTER", f.iconTRcornerleftBG, "CENTER")
		f.iconTRcornerleft:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconTRcornerleft:SetTexture(1, 1, 1, 0)

		-- create icon text
		f.iconTRcornerleftText = f.iconTRcornerleftBG:CreateFontString(nil, "OVERLAY")
		f.iconTRcornerleftText:SetAllPoints(f.iconTRcornerleftBG)
		f.iconTRcornerleftText:SetFontObject(GameFontHighlightSmall)
		f.iconTRcornerleftText:SetFont(font, GridFrame.db.profile.fontSize)
		f.iconTRcornerleftText:SetJustifyH("CENTER")
		f.iconTRcornerleftText:SetJustifyV("CENTER")

		-- create icon cooldown
		f.iconTRcornerleftCD = CreateFrame("Cooldown", nil, f.iconTRcornerleftBG, "CooldownFrameTemplate")
		f.iconTRcornerleftCD:SetAllPoints(f.iconTRcornerleft)
		f.iconTRcornerleftCD:SetScript("OnHide", function()
			f.iconTRcornerleftStackText:SetParent(f.iconTRcornerleftBG)
			f.iconTRcornerleftStackText:SetPoint("BOTTOMRIGHT", f.iconTRcornerleftBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		end)

		-- create icon stack text
		f.iconTRcornerleftStackText = f.iconTRcornerleftBG:CreateFontString(nil, "OVERLAY")
		f.iconTRcornerleftStackText:SetPoint("BOTTOMRIGHT", f.iconTRcornerleftBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		f.iconTRcornerleftStackText:SetFontObject(GameFontHighlightSmall)
		f.iconTRcornerleftStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconTRcornerleftStackText:SetJustifyH("RIGHT")
		f.iconTRcornerleftStackText:SetJustifyV("BOTTOM")
	elseif indicator == "iconTRcornerright" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeTopRightCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			wh = GridFrame.db.profile.iconSize
		end

		-- create icon background/border
		f.iconTRcornerrightBG = CreateFrame("Frame", nil, f)
		f.iconTRcornerrightBG:SetWidth(wh + (2*borderSize))
		f.iconTRcornerrightBG:SetHeight(wh + (2*borderSize))
		f.iconTRcornerrightBG:SetPoint("TOPRIGHT", f, "TOPRIGHT", (xoffset*-1), yoffset)
		f.iconTRcornerrightBG:SetBackdrop({
					edgeFile = "Interface\\Addons\\Grid\\white16x16", edgeSize = 2,
					insets = {left = 2, right = 2, top = 2, bottom = 2},
					})
		f.iconTRcornerrightBG:SetBackdropBorderColor(1, 1, 1, 0)
		f.iconTRcornerrightBG:SetBackdropColor(0, 0, 0, 0)
		f.iconTRcornerrightBG:SetFrameLevel(5)
		f.iconTRcornerrightBG:Hide()

		-- create icon
		f.iconTRcornerright = f.iconTRcornerrightBG:CreateTexture(nil, "OVERLAY")
		f.iconTRcornerright:SetWidth(wh)
		f.iconTRcornerright:SetHeight(wh)
		f.iconTRcornerright:SetPoint("CENTER", f.iconTRcornerrightBG, "CENTER")
		f.iconTRcornerright:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconTRcornerright:SetTexture(1, 1, 1, 0)

		-- create icon text
		f.iconTRcornerrightText = f.iconTRcornerrightBG:CreateFontString(nil, "OVERLAY")
		f.iconTRcornerrightText:SetAllPoints(f.iconTRcornerrightBG)
		f.iconTRcornerrightText:SetFontObject(GameFontHighlightSmall)
		f.iconTRcornerrightText:SetFont(font, GridFrame.db.profile.fontSize)
		f.iconTRcornerrightText:SetJustifyH("CENTER")
		f.iconTRcornerrightText:SetJustifyV("CENTER")

		-- create icon cooldown
		f.iconTRcornerrightCD = CreateFrame("Cooldown", nil, f.iconTRcornerrightBG, "CooldownFrameTemplate")
		f.iconTRcornerrightCD:SetAllPoints(f.iconTRcornerright)
		f.iconTRcornerrightCD:SetScript("OnHide", function()
			f.iconTRcornerrightStackText:SetParent(f.iconTRcornerrightBG)
			f.iconTRcornerrightStackText:SetPoint("BOTTOMRIGHT", f.iconTRcornerrightBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		end)

		-- create icon stack text
		f.iconTRcornerrightStackText = f.iconTRcornerrightBG:CreateFontString(nil, "OVERLAY")
		f.iconTRcornerrightStackText:SetPoint("BOTTOMRIGHT", f.iconTRcornerrightBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		f.iconTRcornerrightStackText:SetFontObject(GameFontHighlightSmall)
		f.iconTRcornerrightStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconTRcornerrightStackText:SetJustifyH("RIGHT")
		f.iconTRcornerrightStackText:SetJustifyV("BOTTOM")
	elseif indicator == "iconBLcornerleft" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeBottomLeftCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			wh = GridFrame.db.profile.iconSize
		end

		-- create icon background/border
		f.iconBLcornerleftBG = CreateFrame("Frame", nil, f)
		f.iconBLcornerleftBG:SetWidth(wh + (2*borderSize))
		f.iconBLcornerleftBG:SetHeight(wh + (2*borderSize))
		f.iconBLcornerleftBG:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", xoffset, (yoffset*-1))
		f.iconBLcornerleftBG:SetBackdrop({
					edgeFile = "Interface\\Addons\\Grid\\white16x16", edgeSize = 2,
					insets = {left = 2, right = 2, top = 2, bottom = 2},
					})
		f.iconBLcornerleftBG:SetBackdropBorderColor(1, 1, 1, 0)
		f.iconBLcornerleftBG:SetBackdropColor(0, 0, 0, 0)
		f.iconBLcornerleftBG:SetFrameLevel(5)
		f.iconBLcornerleftBG:Hide()

		-- create icon
		f.iconBLcornerleft = f.iconBLcornerleftBG:CreateTexture(nil, "OVERLAY")
		f.iconBLcornerleft:SetWidth(wh)
		f.iconBLcornerleft:SetHeight(wh)
		f.iconBLcornerleft:SetPoint("CENTER", f.iconBLcornerleftBG, "CENTER")
		f.iconBLcornerleft:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconBLcornerleft:SetTexture(1, 1, 1, 0)

		-- create icon text
		f.iconBLcornerleftText = f.iconBLcornerleftBG:CreateFontString(nil, "OVERLAY")
		f.iconBLcornerleftText:SetAllPoints(f.iconBLcornerleftBG)
		f.iconBLcornerleftText:SetFontObject(GameFontHighlightSmall)
		f.iconBLcornerleftText:SetFont(font, GridFrame.db.profile.fontSize)
		f.iconBLcornerleftText:SetJustifyH("CENTER")
		f.iconBLcornerleftText:SetJustifyV("CENTER")

		-- create icon cooldown
		f.iconBLcornerleftCD = CreateFrame("Cooldown", nil, f.iconBLcornerleftBG, "CooldownFrameTemplate")
		f.iconBLcornerleftCD:SetAllPoints(f.iconBLcornerleft)
		f.iconBLcornerleftCD:SetScript("OnHide", function()
			f.iconBLcornerleftStackText:SetParent(f.iconBLcornerleftBG)
			f.iconBLcornerleftStackText:SetPoint("BOTTOMRIGHT", f.iconBLcornerleftBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		end)

		-- create icon stack text
		f.iconBLcornerleftStackText = f.iconBLcornerleftBG:CreateFontString(nil, "OVERLAY")
		f.iconBLcornerleftStackText:SetPoint("BOTTOMRIGHT", f.iconBLcornerleftBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		f.iconBLcornerleftStackText:SetFontObject(GameFontHighlightSmall)
		f.iconBLcornerleftStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconBLcornerleftStackText:SetJustifyH("RIGHT")
		f.iconBLcornerleftStackText:SetJustifyV("BOTTOM")
	elseif indicator == "iconBLcornerright" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeBottomLeftCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			wh = GridFrame.db.profile.iconSize
		end

		-- create icon background/border
		f.iconBLcornerrightBG = CreateFrame("Frame", nil, f)
		f.iconBLcornerrightBG:SetWidth(wh + (2*borderSize))
		f.iconBLcornerrightBG:SetHeight(wh + (2*borderSize))
		f.iconBLcornerrightBG:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", (wh+xoffset)+(2*borderSize), (yoffset*-1))
		f.iconBLcornerrightBG:SetBackdrop({
					edgeFile = "Interface\\Addons\\Grid\\white16x16", edgeSize = 2,
					insets = {left = 2, right = 2, top = 2, bottom = 2},
					})
		f.iconBLcornerrightBG:SetBackdropBorderColor(1, 1, 1, 0)
		f.iconBLcornerrightBG:SetBackdropColor(0, 0, 0, 0)
		f.iconBLcornerrightBG:SetFrameLevel(5)
		f.iconBLcornerrightBG:Hide()

		-- create icon
		f.iconBLcornerright = f.iconBLcornerrightBG:CreateTexture(nil, "OVERLAY")
		f.iconBLcornerright:SetWidth(wh)
		f.iconBLcornerright:SetHeight(wh)
		f.iconBLcornerright:SetPoint("CENTER", f.iconBLcornerrightBG, "CENTER")
		f.iconBLcornerright:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconBLcornerright:SetTexture(1, 1, 1, 0)

		-- create icon text
		f.iconBLcornerrightText = f.iconBLcornerrightBG:CreateFontString(nil, "OVERLAY")
		f.iconBLcornerrightText:SetAllPoints(f.iconBLcornerrightBG)
		f.iconBLcornerrightText:SetFontObject(GameFontHighlightSmall)
		f.iconBLcornerrightText:SetFont(font, GridFrame.db.profile.fontSize)
		f.iconBLcornerrightText:SetJustifyH("CENTER")
		f.iconBLcornerrightText:SetJustifyV("CENTER")

		-- create icon cooldown
		f.iconBLcornerrightCD = CreateFrame("Cooldown", nil, f.iconBLcornerrightBG, "CooldownFrameTemplate")
		f.iconBLcornerrightCD:SetAllPoints(f.iconBLcornerright)
		f.iconBLcornerrightCD:SetScript("OnHide", function()
			f.iconBLcornerrightStackText:SetParent(f.iconBLcornerrightBG)
			f.iconBLcornerrightStackText:SetPoint("BOTTOMRIGHT", f.iconBLcornerrightBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		end)

		-- create icon stack text
		f.iconBLcornerrightStackText = f.iconBLcornerrightBG:CreateFontString(nil, "OVERLAY")
		f.iconBLcornerrightStackText:SetPoint("BOTTOMRIGHT", f.iconBLcornerrightBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		f.iconBLcornerrightStackText:SetFontObject(GameFontHighlightSmall)
		f.iconBLcornerrightStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconBLcornerrightStackText:SetJustifyH("RIGHT")
		f.iconBLcornerrightStackText:SetJustifyV("BOTTOM")
	elseif indicator == "iconBRcornerleft" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeBottomRightCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			wh = GridFrame.db.profile.iconSize
		end

		-- create icon background/border
		f.iconBRcornerleftBG = CreateFrame("Frame", nil, f)
		f.iconBRcornerleftBG:SetWidth(wh + (2*borderSize))
		f.iconBRcornerleftBG:SetHeight(wh + (2*borderSize))
		f.iconBRcornerleftBG:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", ((wh*-1)+(xoffset*-1))-(2*borderSize), (yoffset*-1))
		f.iconBRcornerleftBG:SetBackdrop({
					edgeFile = "Interface\\Addons\\Grid\\white16x16", edgeSize = 2,
					insets = {left = 2, right = 2, top = 2, bottom = 2},
					})
		f.iconBRcornerleftBG:SetBackdropBorderColor(1, 1, 1, 0)
		f.iconBRcornerleftBG:SetBackdropColor(0, 0, 0, 0)
		f.iconBRcornerleftBG:SetFrameLevel(5)
		f.iconBRcornerleftBG:Hide()

		-- create icon
		f.iconBRcornerleft = f.iconBRcornerleftBG:CreateTexture(nil, "OVERLAY")
		f.iconBRcornerleft:SetWidth(wh)
		f.iconBRcornerleft:SetHeight(wh)
		f.iconBRcornerleft:SetPoint("CENTER", f.iconBRcornerleftBG, "CENTER")
		f.iconBRcornerleft:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconBRcornerleft:SetTexture(1, 1, 1, 0)

		-- create icon text
		f.iconBRcornerleftText = f.iconBRcornerleftBG:CreateFontString(nil, "OVERLAY")
		f.iconBRcornerleftText:SetAllPoints(f.iconBRcornerleftBG)
		f.iconBRcornerleftText:SetFontObject(GameFontHighlightSmall)
		f.iconBRcornerleftText:SetFont(font, GridFrame.db.profile.fontSize)
		f.iconBRcornerleftText:SetJustifyH("CENTER")
		f.iconBRcornerleftText:SetJustifyV("CENTER")

		-- create icon cooldown
		f.iconBRcornerleftCD = CreateFrame("Cooldown", nil, f.iconBRcornerleftBG, "CooldownFrameTemplate")
		f.iconBRcornerleftCD:SetAllPoints(f.iconBRcornerleft)
		f.iconBRcornerleftCD:SetScript("OnHide", function()
			f.iconBRcornerleftStackText:SetParent(f.iconBRcornerleftBG)
			f.iconBRcornerleftStackText:SetPoint("BOTTOMRIGHT", f.iconBRcornerleftBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		end)

		-- create icon stack text
		f.iconBRcornerleftStackText = f.iconBRcornerleftBG:CreateFontString(nil, "OVERLAY")
		f.iconBRcornerleftStackText:SetPoint("BOTTOMRIGHT", f.iconBRcornerleftBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		f.iconBRcornerleftStackText:SetFontObject(GameFontHighlightSmall)
		f.iconBRcornerleftStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconBRcornerleftStackText:SetJustifyH("RIGHT")
		f.iconBRcornerleftStackText:SetJustifyV("BOTTOM")
	elseif indicator == "iconBRcornerright" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeBottomRightCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			wh = GridFrame.db.profile.iconSize
		end

		-- create icon background/border
		f.iconBRcornerrightBG = CreateFrame("Frame", nil, f)
		f.iconBRcornerrightBG:SetWidth(wh + (2*borderSize))
		f.iconBRcornerrightBG:SetHeight(wh + (2*borderSize))
		f.iconBRcornerrightBG:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", (xoffset*-1), (yoffset*-1))
		f.iconBRcornerrightBG:SetBackdrop({
					edgeFile = "Interface\\Addons\\Grid\\white16x16", edgeSize = 2,
					insets = {left = 2, right = 2, top = 2, bottom = 2},
					})
		f.iconBRcornerrightBG:SetBackdropBorderColor(1, 1, 1, 0)
		f.iconBRcornerrightBG:SetBackdropColor(0, 0, 0, 0)
		f.iconBRcornerrightBG:SetFrameLevel(5)
		f.iconBRcornerrightBG:Hide()

		-- create icon
		f.iconBRcornerright = f.iconBRcornerrightBG:CreateTexture(nil, "OVERLAY")
		f.iconBRcornerright:SetWidth(wh)
		f.iconBRcornerright:SetHeight(wh)
		f.iconBRcornerright:SetPoint("CENTER", f.iconBRcornerrightBG, "CENTER")
		f.iconBRcornerright:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconBRcornerright:SetTexture(1, 1, 1, 0)

		-- create icon text
		f.iconBRcornerrightText = f.iconBRcornerrightBG:CreateFontString(nil, "OVERLAY")
		f.iconBRcornerrightText:SetAllPoints(f.iconBRcornerrightBG)
		f.iconBRcornerrightText:SetFontObject(GameFontHighlightSmall)
		f.iconBRcornerrightText:SetFont(font, GridFrame.db.profile.fontSize)
		f.iconBRcornerrightText:SetJustifyH("CENTER")
		f.iconBRcornerrightText:SetJustifyV("CENTER")

		-- create icon cooldown
		f.iconBRcornerrightCD = CreateFrame("Cooldown", nil, f.iconBRcornerrightBG, "CooldownFrameTemplate")
		f.iconBRcornerrightCD:SetAllPoints(f.iconBRcornerright)
		f.iconBRcornerrightCD:SetScript("OnHide", function()
			f.iconBRcornerrightStackText:SetParent(f.iconBRcornerrightBG)
			f.iconBRcornerrightStackText:SetPoint("BOTTOMRIGHT", f.iconBRcornerrightBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		end)

		-- create icon stack text
		f.iconBRcornerrightStackText = f.iconBRcornerrightBG:CreateFontString(nil, "OVERLAY")
		f.iconBRcornerrightStackText:SetPoint("BOTTOMRIGHT", f.iconBRcornerrightBG, iconStackTextXYaxis, -iconStackTextXYaxis)
		f.iconBRcornerrightStackText:SetFontObject(GameFontHighlightSmall)
		f.iconBRcornerrightStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconBRcornerrightStackText:SetJustifyH("RIGHT")
		f.iconBRcornerrightStackText:SetJustifyV("BOTTOM")
	end
end

function GridIndicatorCornerIcons.SetIndicator(frame, indicator, color, text, value, maxValue, texture, start, duration, stack)
	if indicator == "iconTLcornerleft"
	or indicator == "iconTLcornerright"
	or indicator == "iconTRcornerleft"
	or indicator == "iconTRcornerright"
	or indicator == "iconBLcornerleft"
	or indicator == "iconBLcornerright"
	or indicator == "iconBRcornerleft"
	or indicator == "iconBRcornerright"
	then
		if not frame[indicator] then
			GridIndicatorCornerIcons.CreateIndicator(frame, indicator)
		end
		if texture then
			local borderSize = GridIndicatorCornerIcons.db.profile.iconBorderSize
			local enabledCD = GridIndicatorCornerIcons.db.profile.enableIconCooldown
			local XYaxis = GridIndicatorCornerIcons.db.profile.IconStackTextXYaxis
			local enabledStackTxt = GridIndicatorCornerIcons.db.profile.enableIconStackText
			if GridIndicatorCornerIcons.db.profile.OriginalSize then
				borderSize = GridFrame.db.profile.iconBorderSize
				enabledCD = GridFrame.db.profile.enableIconCooldown
				XYaxis = 2
				enabledStackTxt = GridFrame.db.profile.enableIconStackText
			end

			if type(texture) == "table" then
				frame[indicator]:SetTexture(texture.r, texture.g, texture.b, texture.a or 1)
			else
				frame[indicator]:SetTexture(texture)
			end

			if type(color) == "table" then
				if not color.ignore then
					if borderSize > 0 then
						frame[indicator.."BG"]:SetBackdropBorderColor(color.r, color.g, color.b, color.a or 1)
					end
				else
					frame[indicator.."BG"]:SetBackdropBorderColor(0, 0, 0, 0)
				end
				frame[indicator]:SetAlpha(color.a or 1)
			else
				frame[indicator.."BG"]:SetBackdropBorderColor(0, 0, 0, 0)
				frame[indicator]:SetAlpha(1)
			end

			if enabledCD and type(duration) == "number" and duration > 0 and type(start) == "number" and start > 0 then
				frame[indicator.."CD"]:SetCooldown(start, duration)
				frame[indicator.."CD"]:Show()
				frame[indicator.."StackText"]:SetParent(frame[indicator.."CD"])
				frame[indicator.."StackText"]:SetPoint("BOTTOMRIGHT", frame[indicator.."BG"], XYaxis, -XYaxis)
			else
				frame[indicator.."CD"]:Hide()
			end

			if enabledStackTxt and tonumber(stack) and tonumber(stack) > 1 then
				frame[indicator.."StackText"]:SetText(stack)
			else
				frame[indicator.."StackText"]:SetText("")
			end

			frame[indicator.."BG"]:Show()
			frame[indicator]:Show()
		else
			frame[indicator.."BG"]:Hide()
		end
	end
end

function GridIndicatorCornerIcons.ClearIndicator(frame, indicator)
	if indicator == "iconTLcornerleft"
	or indicator == "iconTLcornerright"
	or indicator == "iconTRcornerleft"
	or indicator == "iconTRcornerright"
	or indicator == "iconBLcornerleft"
	or indicator == "iconBLcornerright"
	or indicator == "iconBRcornerleft"
	or indicator == "iconBRcornerright"
	then
		if frame[indicator] then
			frame[indicator]:SetTexture(1, 1, 1, 0)
			frame[indicator.."BG"]:Hide()
			frame[indicator.."StackText"]:SetText("")
			frame[indicator.."CD"]:Hide()
		end
	end
end

function GridIndicatorCornerIcons.SetIconSize(f, size, borderSize)
	local xoffset = GridIndicatorCornerIcons.db.profile.xoffset
	local yoffset = GridIndicatorCornerIcons.db.profile.yoffset
	local borderSize = GridIndicatorCornerIcons.db.profile.iconBorderSize
	local iconStackTextSize = GridIndicatorCornerIcons.db.profile.IconStackTextSize
	local iconStackTextXYaxis = GridIndicatorCornerIcons.db.profile.IconStackTextXYaxis
	local font = media and media:Fetch("font", GridFrame.db.profile.font) or STANDARD_TEXT_FONT
	if GridIndicatorCornerIcons.db.profile.OriginalSize then
		borderSize = GridFrame.db.profile.iconBorderSize
		iconStackTextSize = GridFrame.db.profile.fontSize
		iconStackTextXYaxis = 2
	end

	if f.iconTLcornerleft then
		local size = GridIndicatorCornerIcons.db.profile.iconSizeTopLeftCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			size = GridFrame.db.profile.iconSize
		end

		local backdrop = f.iconTLcornerleftBG:GetBackdrop()

		backdrop.edgeSize = borderSize
		backdrop.insets.left = borderSize
		backdrop.insets.right = borderSize
		backdrop.insets.top = borderSize
		backdrop.insets.bottom = borderSize

		local r, g, b, a = f.iconTLcornerleftBG:GetBackdropBorderColor()

		f.iconTLcornerleftBG:SetBackdrop(backdrop)
		if borderSize == 0 then
			f.iconTLcornerleftBG:SetBackdropBorderColor(0, 0, 0, 0)
		else
			f.iconTLcornerleftBG:SetBackdropBorderColor(r, g, b, a)
		end

		f.iconTLcornerleftBG:SetPoint("TOPLEFT", f, "TOPLEFT", xoffset, yoffset)
		f.iconTLcornerleftBG:SetWidth(size + (2*borderSize))
		f.iconTLcornerleftBG:SetHeight(size + (2*borderSize))

		f.iconTLcornerleft:SetWidth(size)
		f.iconTLcornerleft:SetHeight(size)

		f.iconTLcornerleftStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconTLcornerleftStackText:SetPoint("BOTTOMRIGHT", f.iconTLcornerleftBG, iconStackTextXYaxis, -iconStackTextXYaxis)
	end
	if f.iconTLcornerright then
		local size = GridIndicatorCornerIcons.db.profile.iconSizeTopLeftCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			size = GridFrame.db.profile.iconSize
		end

		local backdrop = f.iconTLcornerrightBG:GetBackdrop()

		backdrop.edgeSize = borderSize
		backdrop.insets.left = borderSize
		backdrop.insets.right = borderSize
		backdrop.insets.top = borderSize
		backdrop.insets.bottom = borderSize

		local r, g, b, a = f.iconTLcornerrightBG:GetBackdropBorderColor()

		f.iconTLcornerrightBG:SetBackdrop(backdrop)
		if borderSize == 0 then
			f.iconTLcornerrightBG:SetBackdropBorderColor(0, 0, 0, 0)
		else
			f.iconTLcornerrightBG:SetBackdropBorderColor(r, g, b, a)
		end

		f.iconTLcornerrightBG:SetPoint("TOPLEFT", f, "TOPLEFT", (size+xoffset)+(2*borderSize), yoffset)
		f.iconTLcornerrightBG:SetWidth(size + (2*borderSize))
		f.iconTLcornerrightBG:SetHeight(size + (2*borderSize))

		f.iconTLcornerright:SetWidth(size)
		f.iconTLcornerright:SetHeight(size)

		f.iconTLcornerrightStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconTLcornerrightStackText:SetPoint("BOTTOMRIGHT", f.iconTLcornerrightBG, iconStackTextXYaxis, -iconStackTextXYaxis)
	end
	if f.iconTRcornerleft then
		local size = GridIndicatorCornerIcons.db.profile.iconSizeTopRightCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			size = GridFrame.db.profile.iconSize
		end

		local backdrop = f.iconTRcornerleftBG:GetBackdrop()

		backdrop.edgeSize = borderSize
		backdrop.insets.left = borderSize
		backdrop.insets.right = borderSize
		backdrop.insets.top = borderSize
		backdrop.insets.bottom = borderSize

		local r, g, b, a = f.iconTRcornerleftBG:GetBackdropBorderColor()

		f.iconTRcornerleftBG:SetBackdrop(backdrop)
		if borderSize == 0 then
			f.iconTRcornerleftBG:SetBackdropBorderColor(0, 0, 0, 0)
		else
			f.iconTRcornerleftBG:SetBackdropBorderColor(r, g, b, a)
		end

		f.iconTRcornerleftBG:SetPoint("TOPRIGHT", f, "TOPRIGHT", ((size*-1)+(xoffset*-1))-(2*borderSize), yoffset)
		f.iconTRcornerleftBG:SetWidth(size + (2*borderSize))
		f.iconTRcornerleftBG:SetHeight(size + (2*borderSize))

		f.iconTRcornerleft:SetWidth(size)
		f.iconTRcornerleft:SetHeight(size)

		f.iconTRcornerleftStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconTRcornerleftStackText:SetPoint("BOTTOMRIGHT", f.iconTRcornerleftBG, iconStackTextXYaxis, -iconStackTextXYaxis)
	end
	if f.iconTRcornerright then
		local size = GridIndicatorCornerIcons.db.profile.iconSizeTopRightCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			size = GridFrame.db.profile.iconSize
		end

		local backdrop = f.iconTRcornerrightBG:GetBackdrop()

		backdrop.edgeSize = borderSize
		backdrop.insets.left = borderSize
		backdrop.insets.right = borderSize
		backdrop.insets.top = borderSize
		backdrop.insets.bottom = borderSize

		local r, g, b, a = f.iconTRcornerrightBG:GetBackdropBorderColor()

		f.iconTRcornerrightBG:SetBackdrop(backdrop)
		if borderSize == 0 then
			f.iconTRcornerrightBG:SetBackdropBorderColor(0, 0, 0, 0)
		else
			f.iconTRcornerrightBG:SetBackdropBorderColor(r, g, b, a)
		end

		f.iconTRcornerrightBG:SetPoint("TOPRIGHT", f, "TOPRIGHT", (xoffset*-1), yoffset)
		f.iconTRcornerrightBG:SetWidth(size + (2*borderSize))
		f.iconTRcornerrightBG:SetHeight(size + (2*borderSize))

		f.iconTRcornerright:SetWidth(size)
		f.iconTRcornerright:SetHeight(size)

		f.iconTRcornerrightStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconTRcornerrightStackText:SetPoint("BOTTOMRIGHT", f.iconTRcornerrightBG, iconStackTextXYaxis, -iconStackTextXYaxis)
	end
	if f.iconBLcornerleft then
		local size = GridIndicatorCornerIcons.db.profile.iconSizeBottomLeftCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			size = GridFrame.db.profile.iconSize
		end

		local backdrop = f.iconBLcornerleftBG:GetBackdrop()

		backdrop.edgeSize = borderSize
		backdrop.insets.left = borderSize
		backdrop.insets.right = borderSize
		backdrop.insets.top = borderSize
		backdrop.insets.bottom = borderSize

		local r, g, b, a = f.iconBLcornerleftBG:GetBackdropBorderColor()

		f.iconBLcornerleftBG:SetBackdrop(backdrop)
		if borderSize == 0 then
			f.iconBLcornerleftBG:SetBackdropBorderColor(0, 0, 0, 0)
		else
			f.iconBLcornerleftBG:SetBackdropBorderColor(r, g, b, a)
		end

		f.iconBLcornerleftBG:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", xoffset, (yoffset*-1))
		f.iconBLcornerleftBG:SetWidth(size + (2*borderSize))
		f.iconBLcornerleftBG:SetHeight(size + (2*borderSize))

		f.iconBLcornerleft:SetWidth(size)
		f.iconBLcornerleft:SetHeight(size)

		f.iconBLcornerleftStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconBLcornerleftStackText:SetPoint("BOTTOMRIGHT", f.iconBLcornerleftBG, iconStackTextXYaxis, -iconStackTextXYaxis)
	end
	if f.iconBLcornerright then
		local size = GridIndicatorCornerIcons.db.profile.iconSizeBottomLeftCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			size = GridFrame.db.profile.iconSize
		end

		local backdrop = f.iconBLcornerrightBG:GetBackdrop()

		backdrop.edgeSize = borderSize
		backdrop.insets.left = borderSize
		backdrop.insets.right = borderSize
		backdrop.insets.top = borderSize
		backdrop.insets.bottom = borderSize

		local r, g, b, a = f.iconBLcornerrightBG:GetBackdropBorderColor()

		f.iconBLcornerrightBG:SetBackdrop(backdrop)
		if borderSize == 0 then
			f.iconBLcornerrightBG:SetBackdropBorderColor(0, 0, 0, 0)
		else
			f.iconBLcornerrightBG:SetBackdropBorderColor(r, g, b, a)
		end

		f.iconBLcornerrightBG:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", (size+xoffset)+(2*borderSize), (yoffset*-1))
		f.iconBLcornerrightBG:SetWidth(size + (2*borderSize))
		f.iconBLcornerrightBG:SetHeight(size + (2*borderSize))

		f.iconBLcornerright:SetWidth(size)
		f.iconBLcornerright:SetHeight(size)

		f.iconBLcornerrightStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconBLcornerrightStackText:SetPoint("BOTTOMRIGHT", f.iconBLcornerrightBG, iconStackTextXYaxis, -iconStackTextXYaxis)
	end
	if f.iconBRcornerleft then
		local size = GridIndicatorCornerIcons.db.profile.iconSizeBottomRightCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			size = GridFrame.db.profile.iconSize
		end

		local backdrop = f.iconBRcornerleftBG:GetBackdrop()

		backdrop.edgeSize = borderSize
		backdrop.insets.left = borderSize
		backdrop.insets.right = borderSize
		backdrop.insets.top = borderSize
		backdrop.insets.bottom = borderSize

		local r, g, b, a = f.iconBRcornerleftBG:GetBackdropBorderColor()

		f.iconBRcornerleftBG:SetBackdrop(backdrop)
		if borderSize == 0 then
			f.iconBRcornerleftBG:SetBackdropBorderColor(0, 0, 0, 0)
		else
			f.iconBRcornerleftBG:SetBackdropBorderColor(r, g, b, a)
		end

		f.iconBRcornerleftBG:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", ((size*-1)+(xoffset*-1))-(2*borderSize), (yoffset*-1))
		f.iconBRcornerleftBG:SetWidth(size + (2*borderSize))
		f.iconBRcornerleftBG:SetHeight(size + (2*borderSize))

		f.iconBRcornerleft:SetWidth(size)
		f.iconBRcornerleft:SetHeight(size)

		f.iconBRcornerleftStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconBRcornerleftStackText:SetPoint("BOTTOMRIGHT", f.iconBRcornerleftBG, iconStackTextXYaxis, -iconStackTextXYaxis)
	end
	if f.iconBRcornerright then
		local size = GridIndicatorCornerIcons.db.profile.iconSizeBottomRightCorner
		if GridIndicatorCornerIcons.db.profile.OriginalSize then
			size = GridFrame.db.profile.iconSize
		end

		local backdrop = f.iconBRcornerrightBG:GetBackdrop()

		backdrop.edgeSize = borderSize
		backdrop.insets.left = borderSize
		backdrop.insets.right = borderSize
		backdrop.insets.top = borderSize
		backdrop.insets.bottom = borderSize

		local r, g, b, a = f.iconBRcornerrightBG:GetBackdropBorderColor()

		f.iconBRcornerrightBG:SetBackdrop(backdrop)
		if borderSize == 0 then
			f.iconBRcornerrightBG:SetBackdropBorderColor(0, 0, 0, 0)
		else
			f.iconBRcornerrightBG:SetBackdropBorderColor(r, g, b, a)
		end

		f.iconBRcornerrightBG:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", (xoffset*-1), (yoffset*-1))
		f.iconBRcornerrightBG:SetWidth(size + (2*borderSize))
		f.iconBRcornerrightBG:SetHeight(size + (2*borderSize))

		f.iconBRcornerright:SetWidth(size)
		f.iconBRcornerright:SetHeight(size)

		f.iconBRcornerrightStackText:SetFont(font, iconStackTextSize, "OUTLINE")
		f.iconBRcornerrightStackText:SetPoint("BOTTOMRIGHT", f.iconBRcornerrightBG, iconStackTextXYaxis, -iconStackTextXYaxis)
	end
end