local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db, ndbc
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local MODNAME = "WatchFrame Adv."
local WatchFrameAdv = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

local LoggedIn = false

local WF
local OrigWFSetPoint, OrigWFClearAllPoints
local origWFHighlight
local WFColorsHooked = false

local FadeTime = 0.25
local status

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
		name = "WatchFrame Adv.",
		desc = "Adjust the position, size, colors and automatic hiding of the Quest Watch Frame.",
		childGroups = "tab",
		arg = MODNAME,
		order = 2301,
		args = {
			header = {
				type = "header",
				name = "WatchFrame Adv.",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Adjust the position, size, colors and automatic hiding of the Quest Watch Frame.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the WatchFrame Adv. module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
					WatchFrameAdv:RefreshMod()				
				end,
				order = 30,
			},
			gap1 = {
				name = " ",
				type = "description",
				order = 31,
			},
			sizeposition = {
				name = "Size/Position",
				type = "group",
				inline = true,
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				order = 60,
				args = {
					header = {
						type = "description",
						name = "Adjust the Size and Position of the Quest Tracker.",
						order = 10,
					},
					enabled = {
						type = "toggle",
						name = "Enabled",
						get = function(info) return db.position.enabled end,
						set = function(info, value) 
							db.position.enabled = value
							WatchFrameAdv:UpdatePosition()
							nibRealUI:ReloadUIDialog()
						end,
						order = 20,
					},
					note1 = {
						type = "description",
						name = "Note: Enabling/Disabling the Size/Position adjustments will require a UI Reload to take full effect.",
						order = 30,
					},
					gap1 = {
						name = " ",
						type = "description",
						order = 31,
					},
					offsets = {
						type = "group",
						name = "Offsets",
						disabled = function() if not db.position.enabled then return true else return false end end,
						inline = true,
						order = 40,
						args = {
							xoffset = {
								type = "input",
								name = "X Offset",
								width = "half",
								order = 10,
								get = function(info) return tostring(db.position.x) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.position.x = value
									WatchFrameAdv:UpdatePosition()
								end,
							},
							yoffset = {
								type = "input",
								name = "Y Offset",
								width = "half",
								order = 20,
								get = function(info) return tostring(db.position.y) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.position.y = value
									WatchFrameAdv:UpdatePosition()
								end,
							},
							negheightoffset = {
								type = "input",
								name = "Height Offset",
								desc = "How much shorter than Screen Height the Quest Tracker will be.",
								width = "half",
								order = 30,
								get = function(info) return tostring(db.position.negheightofs) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.position.negheightofs = value
									WatchFrameAdv:UpdatePosition()
								end,
							},
						},
					},
					gap2 = {
						name = " ",
						type = "description",
						order = 41,
					},
					anchor = {
						type = "group",
						name = "Position",
						inline = true,
						disabled = function() if not db.position.enabled then return true else return false end end,
						order = 50,
						args = {
							anchorto = {
								type = "select",
								name = "Anchor To",
								get = function(info) 
									for k,v in pairs(table_AnchorPoints) do
										if v == db.position.anchorto then return k end
									end
								end,
								set = function(info, value)
									db.position.anchorto = table_AnchorPoints[value]
									WatchFrameAdv:UpdatePosition()
								end,
								style = "dropdown",
								width = nil,
								values = table_AnchorPoints,
								order = 10,
							},
							anchorfrom = {
								type = "select",
								name = "Anchor From",
								get = function(info) 
									for k,v in pairs(table_AnchorPoints) do
										if v == db.position.anchorfrom then return k end
									end
								end,
								set = function(info, value)
									db.position.anchorfrom = table_AnchorPoints[value]
									WatchFrameAdv:UpdatePosition()
								end,
								style = "dropdown",
								width = nil,
								values = table_AnchorPoints,
								order = 20,
							},
						},
					},
				},
			},
			gap2 = {
				name = " ",
				type = "description",
				order = 61,
			},
			hidden = {
				name = "Automatic Collapse/Hide",
				type = "group",
				inline = true,
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				order = 70,
				args = {
					header = {
						type = "description",
						name = "Automatically collapse the Quest Tracker in certain zones.",
						order = 10,
					},
					enabled = {
						type = "toggle",
						name = "Enabled",
						get = function(info) return db.hidden.enabled end,
						set = function(info, value) 
							db.hidden.enabled = value
							WatchFrameAdv:UpdateCollapseState()
						end,
						order = 20,
					},
					gap1 = {
						name = " ",
						type = "description",
						order = 21,
					},
					collapse = {
						type = "group",
						name = "Collapse the Quest Tracker in..",
						inline = true,
						disabled = function() if not db.hidden.enabled then return true else return false end end,
						order = 30,
						args = {
							arena = {
								type = "toggle",
								name = "Arenas",
								get = function(info) return db.hidden.collapse.arena end,
								set = function(info, value) 
									db.hidden.collapse.arena = value
									WatchFrameAdv:UpdateCollapseState()
								end,
								order = 10,
							},
							pvp = {
								type = "toggle",
								name = "Battlegrounds",
								get = function(info) return db.hidden.collapse.pvp end,
								set = function(info, value)
									db.hidden.collapse.pvp = value
									WatchFrameAdv:UpdateCollapseState()
								end,
								order = 20,
							},
							party = {
								type = "toggle",
								name = "5 Man Dungeons",
								get = function(info) return db.hidden.collapse.party end,
								set = function(info, value) 
									db.hidden.collapse.party = value
									WatchFrameAdv:UpdateCollapseState()
								end,
								order = 30,
							},
							raid = {
								type = "toggle",
								name = "Raid Dungeons",
								get = function(info) return db.hidden.collapse.raid end,
								set = function(info, value) 
									db.hidden.collapse.raid = value 
									WatchFrameAdv:UpdateCollapseState()
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
					hide = {
						type = "group",
						name = "Hide the Quest Tracker completely in..",
						inline = true,
						disabled = function() if not db.hidden.enabled then return true else return false end end,
						order = 40,
						args = {
							arena = {
								type = "toggle",
								name = "Arenas",
								get = function(info) return db.hidden.hide.arena end,
								set = function(info, value) 
									db.hidden.hide.arena = value
									WatchFrameAdv:UpdateHideState()
								end,
								order = 10,
							},
							pvp = {
								type = "toggle",
								name = "Battlegrounds",
								get = function(info) return db.hidden.hide.pvp end,
								set = function(info, value)
									db.hidden.hide.pvp = value
									WatchFrameAdv:UpdateHideState()
								end,
								order = 20,
							},
							party = {
								type = "toggle",
								name = "5 Man Dungeons",
								get = function(info) return db.hidden.hide.party end,
								set = function(info, value) 
									db.hidden.hide.party = value
									WatchFrameAdv:UpdateHideState()
								end,
								order = 30,
							},
							raid = {
								type = "toggle",
								name = "Raid Dungeons",
								get = function(info) return db.hidden.hide.raid end,
								set = function(info, value) 
									db.hidden.hide.raid = value 
									WatchFrameAdv:UpdateHideState()
								end,
								order = 40,
							},
						},
					},
				},
			},
			gap3 = {
				name = " ",
				type = "description",
				order = 71,
			},
			colors = {
				type = "group",
				inline = true,
				name = "Colors",
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				order = 80,
				args = {
					enabled = {
						type = "toggle",
						name = "Enabled",
						get = function() return db.colors.enabled end,
						set = function(info, value) 
							db.colors.enabled = value 
							if value and not WFColorsHooked then
								WatchFrameAdv:UpdateStyle()
							end
						end,
						order = 10,
					},
					note = {
						type = "description",
						name = "Note: Enabling/disabling Colors will require a UI reload for changes to fully take affect (Type: /rl).",
						order = 20,
					},
					gap1 = {
						name = " ",
						type = "description",
						order = 21,
					},
					title = {
						type = "group",
						name = "Title",
						inline = true,
						disabled = function() if (db.colors.enabled and nibRealUI:GetModuleEnabled(MODNAME)) then return false else return true end end,
						order = 30,
						args = {
							color = {
								type = "color",
								name = "Color",
								hasAlpha = false,
								get = function(info,r,g,b)
									return db.colors.title.r, db.colors.title.g, db.colors.title.b
								end,
								set = function(info,r,g,b)
									db.colors.title.r = r
									db.colors.title.g = g
									db.colors.title.b = b
									WatchFrameAdv:UpdateStyle()
								end,
								order = 10,
							},
						},
					},
					gap2 = {
						name = " ",
						type = "description",
						order = 31,
					},
					lines = {
						type = "group",
						name = "Achievement/Quests",
						inline = true,
						disabled = function() if (db.colors.enabled and nibRealUI:GetModuleEnabled(MODNAME)) then return false else return true end end,
						order = 40,
						args = {
							normal = {
								type = "group",
								name = "Normal",
								inline = true,
								order = 10,
								args = {
									header = {
										type = "color",
										name = "Ach/Quest Name",
										hasAlpha = false,
										get = function(info,r,g,b)
											return db.colors.lines.normal.header.r, db.colors.lines.normal.header.g, db.colors.lines.normal.header.b
										end,
										set = function(info,r,g,b)
											db.colors.lines.normal.header.r = r
											db.colors.lines.normal.header.g = g
											db.colors.lines.normal.header.b = b
											WatchFrameAdv:UpdateStyle()
										end,
										order = 10,
									},
									objectives = {
										type = "color",
										name = "Objectives",
										hasAlpha = false,
										get = function(info,r,g,b)
											return db.colors.lines.normal.objectives.r, db.colors.lines.normal.objectives.g, db.colors.lines.normal.objectives.b
										end,
										set = function(info,r,g,b)
											db.colors.lines.normal.objectives.r = r
											db.colors.lines.normal.objectives.g = g
											db.colors.lines.normal.objectives.b = b
											WatchFrameAdv:UpdateStyle()
										end,
										order = 20,
									},
								},
							},
							highlight = {
								type = "group",
								name = "Highlight",
								inline = true,
								order = 10,
								args = {
									header = {
										type = "color",
										name = "Ach/Quest Name",
										hasAlpha = false,
										get = function(info,r,g,b)
											return db.colors.lines.highlight.header.r, db.colors.lines.highlight.header.g, db.colors.lines.highlight.header.b
										end,
										set = function(info,r,g,b)
											db.colors.lines.highlight.header.r = r
											db.colors.lines.highlight.header.g = g
											db.colors.lines.highlight.header.b = b
											WatchFrameAdv:UpdateStyle()
										end,
										order = 10,
									},
									objectives = {
										type = "color",
										name = "Objectives",
										hasAlpha = false,
										get = function(info,r,g,b)
											return db.colors.lines.highlight.objectives.r, db.colors.lines.highlight.objectives.g, db.colors.lines.highlight.objectives.b
										end,
										set = function(info,r,g,b)
											db.colors.lines.highlight.objectives.r = r
											db.colors.lines.highlight.objectives.g = g
											db.colors.lines.highlight.objectives.b = b
											WatchFrameAdv:UpdateStyle()
										end,
										order = 20,
									},
								},
							},
						},
					},
				},
			},
		},
	}
	end
	return options
end

-- Hide Quest Tracker based on zone
function WatchFrameAdv:UpdateHideState()
	if not WF then WF = _G["WatchFrame"] end
	
	local Inst, InstType = IsInInstance()
	local Hide = false
	if db.hidden.enabled and Inst and nibRealUI:GetModuleEnabled(MODNAME) then
		if (InstType == "pvp" and db.hidden.hide.pvp) then			-- Battlegrounds
			Hide = true
		elseif (InstType == "arena" and db.hidden.hide.arena) then	-- Arena
			Hide = true
		elseif (InstType == "party" and db.hidden.hide.party) then	-- 5 Man Dungeons
			Hide = true
		elseif (InstType == "raid" and db.hidden.hide.raid) then	-- Raid Dungeons
			Hide = true
		end
	end
	if Hide then WF:Hide() else WF:Show() end
end

-- Collapse Quest Tracker based on zone
function WatchFrameAdv:UpdateCollapseState()
	if not WF then WF = _G["WatchFrame"] end
	if not (db.hidden.enabled and nibRealUI:GetModuleEnabled(MODNAME)) then return end
	
	local Inst, InstType = IsInInstance()
	local Collapsed = false
	if Inst then
		if (InstType == "pvp" and db.hidden.collapse.pvp) then			-- Battlegrounds
			Collapsed = true
		elseif (InstType == "arena" and db.hidden.collapse.arena) then	-- Arena
			Collapsed = true
		elseif (InstType == "party" and db.hidden.collapse.party) then	-- 5 Man Dungeons
			Collapsed = true
		elseif (InstType == "raid" and db.hidden.collapse.raid) then	-- Raid Dungeons
			Collapsed = true
		end
	end
	
	if Collapsed then
		WF.userCollapsed = true
		WatchFrame_Collapse(WF)
	else
		WF.userCollapsed = false
		WatchFrame_Expand(WF)
	end	
end

-- Update font
function WatchFrameAdv:UpdateFont()
	local nextline = 1

	WatchFrameTitle:SetFont(unpack(nibRealUI.font.pixel1))
	WatchFrameTitle:SetShadowColor(0, 0, 0, 0)

	hooksecurefunc("WatchFrame_Update", function()
		for i = nextline, 50 do
			local line = _G["WatchFrameLine"..i]
			if line then
				line.text:SetFont(unpack(nibRealUI.font.pixel1))
				line.text:SetSpacing(db.resolution[ndbc.resolution].linespacing)
				line.text:SetShadowColor(0, 0, 0, 0)
				
				line.dash:SetFont(unpack(nibRealUI.font.pixel1))
				line.dash:SetShadowColor(0, 0, 0, 0)
				line.dash:SetTextColor(0, 0, 0, 0)
				
				line.square = CreateFrame("Frame", nil, line)
				line.square:SetPoint("TOPRIGHT", line, "TOPLEFT", 8, -6)
				line.square:SetSize(5, 5)
				nibRealUI:CreateBD(line.square, 1)
				line.square:SetBackdropColor(nibRealUI.media.colors.red[1] * 0.9, nibRealUI.media.colors.red[2] * 0.9, nibRealUI.media.colors.red[3] * 0.9)
				if line.hasdash then
					line.square:Show()
				else
					line.square:Hide()
				end
			else
				nextline = i
				break
			end
		end
	end)
end

-- Position the Quest Tracker
function WatchFrameAdv:UpdatePosition()
	if not WF then WF = _G["WatchFrame"] end
	if not (db.position.enabled and nibRealUI:GetModuleEnabled(MODNAME)) then return end
	
	if not OrigWFSetPoint then
		OrigWFSetPoint = WF.SetPoint
	else
		WF.SetPoint = OrigWFSetPoint
	end
	if not OrigWFClearAllPoints then
		OrigWFClearAllPoints = WF.ClearAllPoints
	else
		WF.ClearAllPoints = OrigWFClearAllPoints
	end
	
	WF:ClearAllPoints()
	WF:SetPoint(db.position.anchorfrom, "UIParent", db.position.anchorto, db.position.x, db.position.y)
	WF:SetHeight(UIParent:GetHeight() - db.position.negheightofs)
	WF.ClearAllPoints = function() end
	WF.SetPoint = function() end
	
	WatchFrameCollapseExpandButton:SetPoint("TOPRIGHT", WF, "TOPRIGHT", -12, -1)
end

-- Udate WatchFrame styling
function WatchFrameAdv:UpdateStyle()
	-- Header
	if db.colors.enabled then
		if not WFColorsHooked then self:HookWFColors() end
		local WFT = _G["WatchFrameTitle"]
		if WFT then	
			WFT:SetTextColor(db.colors.title.r, db.colors.title.g, db.colors.title.b)
		end
	
		-- Update all lines
		for i = 1, #WATCHFRAME_LINKBUTTONS do
			WatchFrameLinkButtonTemplate_Highlight(WATCHFRAME_LINKBUTTONS[i], false)
		end
	end
end

-- Hook into / replace WatchFrame functions for Colors
function WatchFrameAdv:HookWFColors()
	-- Colors
	if db.colors.enabled then
		local lc = {
			n = {h = db.colors.lines.normal.header, o = db.colors.lines.normal.objectives},
			h = {h = db.colors.lines.highlight.header, o = db.colors.lines.highlight.objectives},
		}
		local dc = {
			n = {r = nibRealUI.media.colors.red[1] * 0.9, g = nibRealUI.media.colors.red[2] * 0.9, b = nibRealUI.media.colors.red[3] * 0.9},
			h = {r = nibRealUI.media.colors.red[1], g = nibRealUI.media.colors.red[2], b = nibRealUI.media.colors.red[3]},
		}

		-- Hook into SetLine to change color of lines	
		hooksecurefunc("WatchFrame_SetLine", function(line, anchor, verticalOffset, isHeader, text, dash, hasItem, isComplete)
			if dash == 1 then
				line.hasdash = true
			else
				line.hasdash = false
			end
			if line.square then
				if line.hasdash then
					line.square:Show()
				else
					line.square:Hide()
				end
			end
			if isHeader then
				line.text:SetTextColor(lc.n.h.r, lc.n.h.g, lc.n.h.b)
			else
				line.text:SetTextColor(lc.n.o.r, lc.n.o.g, lc.n.o.b)
			end
		end)
		
		-- Replace Highlight function
		WatchFrameLinkButtonTemplate_Highlight = function(self, onEnter)
			local line
			for index = self.startLine, self.lastLine do
				line = self.lines[index]
				if line then
					if index == self.startLine then
						-- header
						if onEnter then
							line.text:SetTextColor(lc.h.h.r, lc.h.h.g, lc.h.h.b)
						else
							line.text:SetTextColor(lc.n.h.r, lc.n.h.g, lc.n.h.b)
						end
					else
						if onEnter then
							line.text:SetTextColor(lc.h.o.r, lc.h.o.g, lc.h.o.b)
							if line.square then line.square:SetBackdropColor(dc.h.r, dc.h.g, dc.h.b) end
						else
							line.text:SetTextColor(lc.n.o.r, lc.n.o.g, lc.n.o.b)
							if line.square then line.square:SetBackdropColor(dc.n.r, dc.n.g, dc.n.b) end
						end
					end
				end
			end
		end
		WFColorsHooked = true
	end
end

----
function WatchFrameAdv:RefreshMod()
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end
	
	db = self.db.profile
	ndbc = nibRealUI.db.char
	
	self:HookWFColors()
	self:UpdatePosition()
	self:UpdateStyle()
	self:UpdateCollapseState()
	self:UpdateHideState()
end

function WatchFrameAdv:UI_SCALE_CHANGED()
	self:UpdatePosition()
end

function WatchFrameAdv:PLAYER_ENTERING_WORLD()
	self:UpdateCollapseState()
	self:UpdateHideState()
end

function WatchFrameAdv:PLAYER_LOGIN()
	LoggedIn = true

	if nibRealUI:GetModuleEnabled(MODNAME) then
		self:HookWFColors()
		self:UpdatePosition()
		self:UpdateStyle()
		self:UpdateFont()
	end
end

function WatchFrameAdv:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			position = {
				enabled = true,
				anchorto = "TOPRIGHT",
				anchorfrom = "TOPRIGHT",
				x = -32,
				y = -200,
				negheightofs = 300,
			},
			colors = {
				enabled = true,
				title = {r = 1, g = 1, b = 1},
				lines = {
					normal = {
						header = {r = 0.9, g = 0.9, b = 0.9},
						objectives = {r = 0.8, g = 0.8, b = 0.8},
					},
					highlight = {
						header = {r = 1, g = 1, b = 1},
						objectives = {r = 0.9, g = 0.9, b = 0.9},
					},
				},
			},
			hidden = {
				enabled = true,
				collapse = {
					pvp = true,
					arena = false,
					party = true,
					raid = true,
				},
				hide = {
					pvp = false,
					arena = true,
					party = false,
					raid = false,
				},
			},
			fading = {
				enabled = true,
				incombat = 0.3,
				harmtarget = 0.7,
				outofcombat = 1,
			},
			resolution = {
				[1] = {
					linespacing = 4,
				},
				[2] = {
					linespacing = 5,
				},
			},
		},
	})
	db = self.db.profile
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterModuleOptions(MODNAME, GetOptions)
	
	self:RegisterEvent("PLAYER_LOGIN")
end

function WatchFrameAdv:OnEnable()	
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UI_SCALE_CHANGED")
	
	if LoggedIn then self:RefreshMod() end
end

function WatchFrameAdv:OnDisable()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end
