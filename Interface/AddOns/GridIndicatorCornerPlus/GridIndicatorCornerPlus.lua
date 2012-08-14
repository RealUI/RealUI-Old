-- -------------------------------------------------------------------------- --
-- GridIndicatorCornerPlus by kunda                                           --
-- -------------------------------------------------------------------------- --

local L = GridIndicatorCornerPlus_Locales

local Grid = Grid
local GridFrame = Grid:GetModule("GridFrame")
local GridIndicatorCornerPlus = GridFrame:NewModule("GridIndicatorCornerPlus", "AceEvent-3.0")

local configMode = false

GridIndicatorCornerPlus.defaultDB = {
	CornerPlusSpace = 1,
	CornerPlusSize = 5,
	CornerPlusOriginalSize = true,
}

GridIndicatorCornerPlus.options = {
	type = "group",
	icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-TRTLBLBR",
	name = L["Corner Plus"],
	desc = L["Options for Corner Plus."],
	order = 108,
	args = {
		["configuration"] = {
			type = "toggle",
			name = L["Configuration Mode"],
			desc = L["Shows all Corner Plus indicators."],
			order = 10,
			get = function() return configMode end,
			set = function(_, v) 
				configMode = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerPlus:GridIndicatorCornerPlusConfig(f) end)
			end
		},
		["header1"] = {
			type = "header",
			order = 15,
			name = " ",
		},
		["cornerplusspace"] = {
			type = "range",
			name = L["Corner Plus Space"],
			desc = L["Adjust the space between the Corner Plus indicators."],
			order = 20,
			min = 0,
			max = 10,
			step = 1,
			get = function() return GridIndicatorCornerPlus.db.profile.CornerPlusSpace end,
			set = function(_, v)
				GridIndicatorCornerPlus.db.profile.CornerPlusSpace = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerPlus.SetCornerSize(f, v) end)
			end,
		},
		["cornerplusoriginalsize"] = {
			type = "toggle",
			name = L["Same size as Grid standard"],
			desc = L["If enabled, the size of the Corner Plus indicator is adjustable with the standard Grid corner option. If deactivated, you can set an individual size for the Corner Plus indicators."],
			order = 30,
			get = function() return GridIndicatorCornerPlus.db.profile.CornerPlusOriginalSize end,
			set = function(_, v)
				GridIndicatorCornerPlus.db.profile.CornerPlusOriginalSize = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerPlus.SetCornerSize(f, v) end)
			end,
		},
		["cornerplussize"] = {
			type = "range",
			name = L["Corner Plus Size"],
			desc = L["Adjust the size of the Corner Plus indicators."],
			order = 40,
			disabled = function() return GridIndicatorCornerPlus.db.profile.CornerPlusOriginalSize end,
			min = 5,
			max = 20,
			step = 1,
			get = function() return GridIndicatorCornerPlus.db.profile.CornerPlusSize end,
			set = function(_, v)
				GridIndicatorCornerPlus.db.profile.CornerPlusSize = v
				GridFrame:WithAllFrames(function(f) GridIndicatorCornerPlus.SetCornerSize(f, v) end)
			end,
		}
	}
}

local indicators = GridFrame.prototype.indicators
table.insert(indicators, { type = "cornerPlusTLtopright",    order = 8.61,  name = L["Top Left Corner (top right)"] })
table.insert(indicators, { type = "cornerPlusTLbottomleft",  order = 8.62,  name = L["Top Left Corner (bottom left)"] })
table.insert(indicators, { type = "cornerPlusTLbottomright", order = 8.63,  name = L["Top Left Corner (bottom right)"] })
table.insert(indicators, { type = "cornerPlusTRtopleft",     order = 9.61,  name = L["Top Right Corner (top left)"] })
table.insert(indicators, { type = "cornerPlusTRbottomleft",  order = 9.62,  name = L["Top Right Corner (bottom left)"] })
table.insert(indicators, { type = "cornerPlusTRbottomright", order = 9.63,  name = L["Top Right Corner (bottom right)"] })
table.insert(indicators, { type = "cornerPlusBLtopleft",     order = 10.61, name = L["Bottom Left Corner (top left)"] })
table.insert(indicators, { type = "cornerPlusBLtopright",    order = 10.62, name = L["Bottom Left Corner (top right)"] })
table.insert(indicators, { type = "cornerPlusBLbottomright", order = 10.63, name = L["Bottom Left Corner (bottom right)"] })
table.insert(indicators, { type = "cornerPlusBRtopleft",     order = 11.61, name = L["Bottom Right Corner (top left)"] })
table.insert(indicators, { type = "cornerPlusBRtopright",    order = 11.62, name = L["Bottom Right Corner (top right)"] })
table.insert(indicators, { type = "cornerPlusBRbottomleft",  order = 11.63, name = L["Bottom Right Corner (bottom left)"] })

local statusmap = GridFrame.db.profile.statusmap
if not statusmap["cornerPlusTLtopright"] then
	statusmap["cornerPlusTLtopright"] = {}
	statusmap["cornerPlusTLbottomleft"] = {}
	statusmap["cornerPlusTLbottomright"] = {}
	statusmap["cornerPlusTRtopleft"] = {}
	statusmap["cornerPlusTRbottomleft"] = {}
	statusmap["cornerPlusTRbottomright"] = {}
	statusmap["cornerPlusBLtopleft"] = {}
	statusmap["cornerPlusBLtopright"] = {}
	statusmap["cornerPlusBLbottomright"] = {}
	statusmap["cornerPlusBRtopleft"] = {}
	statusmap["cornerPlusBRtopright"] = {}
	statusmap["cornerPlusBRbottomleft"] = {}
end

function GridIndicatorCornerPlus:OnInitialize()
	GridFrame:RegisterModule(self.moduleName, self)

	-- hack for better indicator menu
	hooksecurefunc(GridFrame, "UpdateOptionsMenu", self.CleanOptionsMenu)
	self:CleanOptionsMenu()

	--hook the functions we need.
	hooksecurefunc(GridFrame.prototype, "ClearIndicator", self.ClearIndicator)
	hooksecurefunc(GridFrame.prototype, "CreateIndicator", self.CreateIndicator)
	hooksecurefunc(GridFrame.prototype, "SetCornerSize", self.SetCornerSize)
	hooksecurefunc(GridFrame.prototype, "SetIndicator", self.SetIndicator)
end

function GridIndicatorCornerPlus:OnEnable()
	self:RegisterMessage("Grid_Enabled", "DisableConfigMode")
	self:RegisterMessage("Grid_Disabled", "DisableConfigMode")
end

function GridIndicatorCornerPlus:OnDisable()
	configMode = false
	self:UnregisterMessage("Grid_Enabled")
	self:UnregisterMessage("Grid_Disabled")
end

function GridIndicatorCornerPlus:Reset()
end

function GridIndicatorCornerPlus:DisableConfigMode()
	configMode = false
end

function GridIndicatorCornerPlus:CleanOptionsMenu()
	if not Grid.options.args["Indicators"].args.cornerPlusTLtopright then return end
	if not GridIndicatorCornerPlus:IsEnabled() then return end

	Grid.options.args.Indicators.args.cornerPlusTL = {
		type = "group",
		icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-TL",
		name = L["Top Left Corner Plus"],
		desc = L["Options for Top Left Corner Plus indicators."],
		order = 58.61,
		args = {
			["cornerPlusTLtopright"]    = Grid.options.args.Indicators.args.cornerPlusTLtopright,
			["cornerPlusTLbottomleft"]  = Grid.options.args.Indicators.args.cornerPlusTLbottomleft,
			["cornerPlusTLbottomright"] = Grid.options.args.Indicators.args.cornerPlusTLbottomright
		}
	}
	Grid.options.args.Indicators.args.cornerPlusTL.args.cornerPlusTLtopright.icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-TL-TR"
	Grid.options.args.Indicators.args.cornerPlusTL.args.cornerPlusTLbottomleft.icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-TL-BL"
	Grid.options.args.Indicators.args.cornerPlusTL.args.cornerPlusTLbottomright.icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-TL-BR"
	Grid.options.args.Indicators.args.cornerPlusTLtopright = nil
	Grid.options.args.Indicators.args.cornerPlusTLbottomleft = nil
	Grid.options.args.Indicators.args.cornerPlusTLbottomright = nil

	Grid.options.args.Indicators.args.cornerPlusTR = {
		type = "group",
		icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-TR",
		name = L["Top Right Corner Plus"],
		desc = L["Options for Top Right Corner Plus indicators."],
		order = 59.61,
		args = {
			["cornerPlusTRtopleft"]     = Grid.options.args.Indicators.args.cornerPlusTRtopleft,
			["cornerPlusTRbottomleft"]  = Grid.options.args.Indicators.args.cornerPlusTRbottomleft,
			["cornerPlusTRbottomright"] = Grid.options.args.Indicators.args.cornerPlusTRbottomright
		}
	}
	Grid.options.args.Indicators.args.cornerPlusTR.args.cornerPlusTRtopleft.icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-TR-TL"
	Grid.options.args.Indicators.args.cornerPlusTR.args.cornerPlusTRbottomleft.icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-TR-BL"
	Grid.options.args.Indicators.args.cornerPlusTR.args.cornerPlusTRbottomright.icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-TR-BR"
	Grid.options.args.Indicators.args.cornerPlusTRtopleft = nil
	Grid.options.args.Indicators.args.cornerPlusTRbottomleft = nil
	Grid.options.args.Indicators.args.cornerPlusTRbottomright = nil

	Grid.options.args.Indicators.args.cornerPlusBL = {
		type = "group",
		icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-BL",
		name = L["Bottom Left Corner Plus"],
		desc = L["Options for Bottom Left Corner Plus indicators."],
		order = 60.61,
		args = {
			["cornerPlusBLtopleft"]     = Grid.options.args.Indicators.args.cornerPlusBLtopleft,
			["cornerPlusBLtopright"]    = Grid.options.args.Indicators.args.cornerPlusBLtopright,
			["cornerPlusBLbottomright"] = Grid.options.args.Indicators.args.cornerPlusBLbottomright
		}
	}
	Grid.options.args.Indicators.args.cornerPlusBL.args.cornerPlusBLtopleft.icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-BL-TL"
	Grid.options.args.Indicators.args.cornerPlusBL.args.cornerPlusBLtopright.icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-BL-TR"
	Grid.options.args.Indicators.args.cornerPlusBL.args.cornerPlusBLbottomright.icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-BL-BR"
	Grid.options.args.Indicators.args.cornerPlusBLtopleft = nil
	Grid.options.args.Indicators.args.cornerPlusBLtopright = nil
	Grid.options.args.Indicators.args.cornerPlusBLbottomright = nil

	Grid.options.args.Indicators.args.cornerPlusBR = {
		type = "group",
		icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-BR",
		name = L["Bottom Right Corner Plus"],
		desc = L["Options for Bottom Right Corner Plus indicators."],
		order = 61.61,
		args = {
			["cornerPlusBRtopleft"]    = Grid.options.args.Indicators.args.cornerPlusBRtopleft,
			["cornerPlusBRtopright"]   = Grid.options.args.Indicators.args.cornerPlusBRtopright,
			["cornerPlusBRbottomleft"] = Grid.options.args.Indicators.args.cornerPlusBRbottomleft
		}
	}
	Grid.options.args.Indicators.args.cornerPlusBR.args.cornerPlusBRtopleft.icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-BR-TL"
	Grid.options.args.Indicators.args.cornerPlusBR.args.cornerPlusBRtopright.icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-BR-TR"
	Grid.options.args.Indicators.args.cornerPlusBR.args.cornerPlusBRbottomleft.icon = "Interface\\AddOns\\GridIndicatorCornerPlus\\GridIndicatorCornerPlus-icon-BR-BL"
	Grid.options.args.Indicators.args.cornerPlusBRtopleft = nil
	Grid.options.args.Indicators.args.cornerPlusBRtopright = nil
	Grid.options.args.Indicators.args.cornerPlusBRbottomleft = nil
end

function GridIndicatorCornerPlus:GridIndicatorCornerPlusConfig(frame)
	if configMode then
		local curTime = GetTime()
		self.SetIndicator(frame, "cornerPlusTLtopright",    {r=0.22, g=0.85, b=0.81, a=1})
		self.SetIndicator(frame, "cornerPlusTLbottomleft",  {r=0.87, g=0.62, b=0.06, a=1})
		self.SetIndicator(frame, "cornerPlusTLbottomright", {r=0.29, g=0.34, b=0.67, a=1})
		self.SetIndicator(frame, "cornerPlusTRtopleft",     {r=0.12, g=0.46, b=0.97, a=1})
		self.SetIndicator(frame, "cornerPlusTRbottomleft",  {r=0.42, g=0.07, b=0.24, a=1})
		self.SetIndicator(frame, "cornerPlusTRbottomright", {r=0.17, g=0.65, b=0.33, a=1})
		self.SetIndicator(frame, "cornerPlusBLtopleft",     {r=0.21, g=0.74, b=0.81, a=1})
		self.SetIndicator(frame, "cornerPlusBLtopright",    {r=0.87, g=0.71, b=0.06, a=1})
		self.SetIndicator(frame, "cornerPlusBLbottomright", {r=0.29, g=0.21, b=0.36, a=1})
		self.SetIndicator(frame, "cornerPlusBRtopleft",     {r=0.31, g=0.46, b=0.97, a=1})
		self.SetIndicator(frame, "cornerPlusBRtopright",    {r=0.42, g=0.77, b=0.85, a=1})
		self.SetIndicator(frame, "cornerPlusBRbottomleft",  {r=0.65, g=0.65, b=0.89, a=1})
	else
		self.ClearIndicator(frame, "cornerPlusTLtopright")
		self.ClearIndicator(frame, "cornerPlusTLbottomleft")
		self.ClearIndicator(frame, "cornerPlusTLbottomright")
		self.ClearIndicator(frame, "cornerPlusTRtopleft")
		self.ClearIndicator(frame, "cornerPlusTRbottomleft")
		self.ClearIndicator(frame, "cornerPlusTRbottomright")
		self.ClearIndicator(frame, "cornerPlusBLtopleft")
		self.ClearIndicator(frame, "cornerPlusBLtopright")
		self.ClearIndicator(frame, "cornerPlusBLbottomright")
		self.ClearIndicator(frame, "cornerPlusBRtopleft")
		self.ClearIndicator(frame, "cornerPlusBRtopright")
		self.ClearIndicator(frame, "cornerPlusBRbottomleft")
		GridFrame:UpdateAllFrames()
	end
end

function GridIndicatorCornerPlus.CreateIndicator(f, indicator)
	local wh
	local space = GridIndicatorCornerPlus.db.profile.CornerPlusSpace
	local nwh = GridIndicatorCornerPlus.db.profile.CornerPlusSize
	local owh = GridFrame.db.profile.cornerSize
	local spacePositiv = owh+space
	local spaceNegativ = (owh+space)*-1
	if GridIndicatorCornerPlus.db.profile.CornerPlusOriginalSize then
		wh = owh
	else
		wh = nwh
	end
	if indicator == "cornerPlusTLtopright" then
		f.cornerPlusTLtopright:SetPoint("TOPLEFT", f, "TOPLEFT", spacePositiv, -1)
		f.cornerPlusTLtopright:SetWidth(wh)
		f.cornerPlusTLtopright:SetHeight(wh)
	elseif indicator == "cornerPlusTLbottomleft" then
		f.cornerPlusTLbottomleft:SetPoint("TOPLEFT", f, "TOPLEFT", 1, spaceNegativ)
		f.cornerPlusTLbottomleft:SetWidth(wh)
		f.cornerPlusTLbottomleft:SetHeight(wh)
	elseif indicator == "cornerPlusTLbottomright" then
		f.cornerPlusTLbottomright:SetPoint("TOPLEFT", f, "TOPLEFT", spacePositiv, spaceNegativ)
		f.cornerPlusTLbottomright:SetWidth(wh)
		f.cornerPlusTLbottomright:SetHeight(wh)
	elseif indicator == "cornerPlusTRtopleft" then
		f.cornerPlusTRtopleft:SetPoint("TOPRIGHT", f, "TOPRIGHT", spaceNegativ, -1)
		f.cornerPlusTRtopleft:SetWidth(wh)
		f.cornerPlusTRtopleft:SetHeight(wh)
	elseif indicator == "cornerPlusTRbottomleft" then
		f.cornerPlusTRbottomleft:SetPoint("TOPRIGHT", f, "TOPRIGHT", spaceNegativ, spaceNegativ)
		f.cornerPlusTRbottomleft:SetWidth(wh)
		f.cornerPlusTRbottomleft:SetHeight(wh)
	elseif indicator == "cornerPlusTRbottomright" then
		f.cornerPlusTRbottomright:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, spaceNegativ)
		f.cornerPlusTRbottomright:SetWidth(wh)
		f.cornerPlusTRbottomright:SetHeight(wh)
	elseif indicator == "cornerPlusBLtopleft" then
		f.cornerPlusBLtopleft:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, spacePositiv)
		f.cornerPlusBLtopleft:SetWidth(wh)
		f.cornerPlusBLtopleft:SetHeight(wh)
	elseif indicator == "cornerPlusBLtopright" then
		f.cornerPlusBLtopright:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", spacePositiv, spacePositiv)
		f.cornerPlusBLtopright:SetWidth(wh)
		f.cornerPlusBLtopright:SetHeight(wh)
	elseif indicator == "cornerPlusBLbottomright" then
		f.cornerPlusBLbottomright:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", spacePositiv, 1)
		f.cornerPlusBLbottomright:SetWidth(wh)
		f.cornerPlusBLbottomright:SetHeight(wh)
	elseif indicator == "cornerPlusBRtopleft" then
		f.cornerPlusBRtopleft:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", spaceNegativ, spacePositiv)
		f.cornerPlusBRtopleft:SetWidth(wh)
		f.cornerPlusBRtopleft:SetHeight(wh)
	elseif indicator == "cornerPlusBRtopright" then
		f.cornerPlusBRtopright:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, spacePositiv)
		f.cornerPlusBRtopright:SetWidth(wh)
		f.cornerPlusBRtopright:SetHeight(wh)
	elseif indicator == "cornerPlusBRbottomleft" then
		f.cornerPlusBRbottomleft:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", spaceNegativ, 1)
		f.cornerPlusBRbottomleft:SetWidth(wh)
		f.cornerPlusBRbottomleft:SetHeight(wh)
	end
end

function GridIndicatorCornerPlus.SetIndicator(frame, indicator, color, text, value, maxValue, texture, start, duration, stack)
	if indicator == "cornerPlusTLtopright"
	or indicator == "cornerPlusTLbottomleft"
	or indicator == "cornerPlusTLbottomright"
	or indicator == "cornerPlusTRtopleft"
	or indicator == "cornerPlusTRbottomleft"
	or indicator == "cornerPlusTRbottomright"
	or indicator == "cornerPlusBLtopleft"
	or indicator == "cornerPlusBLtopright"
	or indicator == "cornerPlusBLbottomright"
	or indicator == "cornerPlusBRtopleft"
	or indicator == "cornerPlusBRtopright"
	or indicator == "cornerPlusBRbottomleft"
	then
		if not frame[indicator] then
			frame.CreateIndicator(frame, indicator)
		end
		if not color then color = { r = 1, g = 1, b = 1, a = 1 } end
		frame[indicator]:SetBackdropColor(color.r, color.g, color.b, color.a)
		frame[indicator]:Show()
	end
end

function GridIndicatorCornerPlus.ClearIndicator(frame, indicator)
	if indicator == "cornerPlusTLtopright"
	or indicator == "cornerPlusTLbottomleft"
	or indicator == "cornerPlusTLbottomright"
	or indicator == "cornerPlusTRtopleft"
	or indicator == "cornerPlusTRbottomleft"
	or indicator == "cornerPlusTRbottomright"
	or indicator == "cornerPlusBLtopleft"
	or indicator == "cornerPlusBLtopright"
	or indicator == "cornerPlusBLbottomright"
	or indicator == "cornerPlusBRtopleft"
	or indicator == "cornerPlusBRtopright"
	or indicator == "cornerPlusBRbottomleft"
	then
		if frame[indicator] then
			frame[indicator]:SetBackdropColor(1, 1, 1, 1)
			frame[indicator]:Hide()
		end
	end
end

function GridIndicatorCornerPlus.SetCornerSize(f, size)
	local wh
	local space = GridIndicatorCornerPlus.db.profile.CornerPlusSpace
	local nwh = GridIndicatorCornerPlus.db.profile.CornerPlusSize
	local owh = GridFrame.db.profile.cornerSize
	local spacePositiv = owh+space
	local spaceNegativ = (owh+space)*-1
	if GridIndicatorCornerPlus.db.profile.CornerPlusOriginalSize then
		wh = owh
	else
		wh = nwh
	end
	if f.cornerPlusTLtopright then
		f.cornerPlusTLtopright:SetPoint("TOPLEFT", f, "TOPLEFT", spacePositiv, -1)
		f.cornerPlusTLtopright:SetWidth(wh)
		f.cornerPlusTLtopright:SetHeight(wh)
	end
	if f.cornerPlusTLbottomleft then
		f.cornerPlusTLbottomleft:SetPoint("TOPLEFT", f, "TOPLEFT", 1, spaceNegativ)
		f.cornerPlusTLbottomleft:SetWidth(wh)
		f.cornerPlusTLbottomleft:SetHeight(wh)
	end
	if f.cornerPlusTLbottomright then
		f.cornerPlusTLbottomright:SetPoint("TOPLEFT", f, "TOPLEFT", spacePositiv, spaceNegativ)
		f.cornerPlusTLbottomright:SetWidth(wh)
		f.cornerPlusTLbottomright:SetHeight(wh)
	end
	if f.cornerPlusTRtopleft then
		f.cornerPlusTRtopleft:SetPoint("TOPRIGHT", f, "TOPRIGHT", spaceNegativ, -1)
		f.cornerPlusTRtopleft:SetWidth(wh)
		f.cornerPlusTRtopleft:SetHeight(wh)
	end
	if f.cornerPlusTRbottomleft then
		f.cornerPlusTRbottomleft:SetPoint("TOPRIGHT", f, "TOPRIGHT", spaceNegativ, spaceNegativ)
		f.cornerPlusTRbottomleft:SetWidth(wh)
		f.cornerPlusTRbottomleft:SetHeight(wh)
	end
	if f.cornerPlusTRbottomright then
		f.cornerPlusTRbottomright:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, spaceNegativ)
		f.cornerPlusTRbottomright:SetWidth(wh)
		f.cornerPlusTRbottomright:SetHeight(wh)
	end
	if f.cornerPlusBLtopleft then
		f.cornerPlusBLtopleft:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, spacePositiv)
		f.cornerPlusBLtopleft:SetWidth(wh)
		f.cornerPlusBLtopleft:SetHeight(wh)
	end
	if f.cornerPlusBLtopright then
		f.cornerPlusBLtopright:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", spacePositiv, spacePositiv)
		f.cornerPlusBLtopright:SetWidth(wh)
		f.cornerPlusBLtopright:SetHeight(wh)
	end
	if f.cornerPlusBLbottomright then
		f.cornerPlusBLbottomright:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", spacePositiv, 1)
		f.cornerPlusBLbottomright:SetWidth(wh)
		f.cornerPlusBLbottomright:SetHeight(wh)
	end
	if f.cornerPlusBRtopleft then
		f.cornerPlusBRtopleft:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", spaceNegativ, spacePositiv)
		f.cornerPlusBRtopleft:SetWidth(wh)
		f.cornerPlusBRtopleft:SetHeight(wh)
	end
	if f.cornerPlusBRtopright then
		f.cornerPlusBRtopright:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, spacePositiv)
		f.cornerPlusBRtopright:SetWidth(wh)
		f.cornerPlusBRtopright:SetHeight(wh)
	end
	if f.cornerPlusBRbottomleft then
		f.cornerPlusBRbottomleft:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", spaceNegativ, 1)
		f.cornerPlusBRbottomleft:SetWidth(wh)
		f.cornerPlusBRbottomleft:SetHeight(wh)
	end
end