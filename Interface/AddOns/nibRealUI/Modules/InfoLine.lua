local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local L = LibStub("AceLocale-3.0"):GetLocale("nibRealUI")
local LSM = LibStub("LibSharedMedia-3.0")
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local _
local Tablet20 = LibStub("Tablet-2.0")
local Tablets = {
	guild = Tablet20,
	friends = Tablet20,
	currency = Tablet20,
	sysinfo = Tablet20,
	spec = Tablet20
}

local db, dbc, dbg, ndbc, ndbg

local MODNAME = "InfoLine"
local InfoLine = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

local _G = getfenv(0)
local date = _G.date
local GetGameTime = _G.GetGameTime
local min = _G.min
local max = _G.max
local floor = _G.floor
local abs = _G.abs
local mod = _G.mod
local tonumber = _G.tonumber
local tostring = _G.tostring
local strform = _G.string.format
local gsub = _G.gsub
local strsub = _G.strsub
local sort = _G.sort

local LoggedIn
local NeedRefreshed = true

local ILFrames
local FramesCreated = false

local TextColorNormal
local TextColorHighlight
local TextColorNormalVals
local TextColorHighlightVals
local TextColorDisabledVals
local TextColorWhite
local TextColorTTHeader
local TextColorOrange1
local TextColorOrange2
local TextColorBlue1

local resSizeExtra

local ClassLookup

local PlayerStatusValToStr = {
	[1] = CHAT_FLAG_AFK,
	[2] = CHAT_FLAG_DND,
}

local Elements = {
	options = 		{L["Options"]},
	micromenu = 	{L["Micromenu"]},
	guild = 		{L["Guild"]},
	friends = 		{L["Friends"]},
	durability = 	{L["Durability"]},
	bag = 			{L["Bag"]},
	currency = 		{L["Currency"]},
	xprep = 		{L["XP/Rep"]},
	clock = 		{L["Clock"]},
	sysinfo = 		{L["SysInfo"]},
	specchanger = 	{L["Spec Changer"]},
	layoutchanger =	{L["Layout Changer"]},
	metertoggle = 	{L["Meter Toggle"]},
}

local MMButtonTable = {
	[1] = "character",
	[2] = "spellbook",
	[3] = "talents",
	[4] = "achievements",
	[5] = "questlog",
	[6] = "social",
	[7] = "guild",
	[8] = "pvp",
	[9] = "dungeonfinder",
--	[10] = "raidfinder",
	[10] = "mountsandpets",
	[11] = "dungeonjournal",
	[12] = "helprequest",
}
local MMButtonTexts = {
	[1] = "C",
	[2] = "S",
	[3] = "T",
	[4] = "A",
	[5] = "Q",
	[6] = "O",
	[7] = "G",
	[8] = "P",
	[9] = "D",
--	[10] = "R",
	[10] = "M",
	[11] = "J",
	[12] = "?",
}
local MMIDs = {
	Char = 1,
	SpellBook = 2,
	Talents = 3,
	Achievements = 4,
	QuestLog = 5,
	Social = 6,
	Guild = 7,
	PvP = 8,
	LFD = 9,
--	LFR = 10,
	MountsPets = 10,
	DJ = 11,
	Help = 12,
}

local HPName, CPName, JPName, VPName, GoldName
local CurrencyStartSet

-- Options
local table_Sides = {
	"LEFT",
	"RIGHT"
}

local function AddCustomFrame(name)
	if name == "" then return end
	local f = _G[name]
	if not f then
		print("Frame not found!")
		return
	end
	for k,v in ipairs(db.customframes) do
		if v[1] == name then
			print("This frame is already included!")
			return
		end
	end
	tinsert(db.customframes, {name, "LEFT", 0})
	InfoLine:UpdatePositions()
end

local function RemoveCustomFrame(index)
	tremove(db.customframes, index)
	InfoLine:UpdatePositions()
end

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Info Line",
		desc = "Information / Button display.",
		arg = MODNAME,
		childGroups = "tab",
		order = 914,
		args = {
			header = {
				type = "header",
				name = "Info Line",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Information / Button display.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Info Line module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
					nibRealUI:ReloadUIDialog()
				end,
				order = 30,
			},
			position = {
				name = "Position/Size",
				type = "group",
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				order = 50,
				args = {
					parent = {
						type = "group",
						name = "Parent",
						inline = true,
						order = 10,
						args = {
							xl = {
								type = "input",
								name = "X Left",
								width = "half",
								order = 10,
								get = function(info) return tostring(db.position.xl) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.position.xl = value
									InfoLine:UpdatePositions()
								end,
							},
							xr = {
								type = "input",
								name = "X Right",
								width = "half",
								order = 20,
								get = function(info) return tostring(db.position.xr) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.position.xr = value
									InfoLine:UpdatePositions()
								end,
							},
							xgap = {
								type = "input",
								name = "Padding",
								width = "half",
								order = 30,
								get = function(info) return tostring(db.position.xgap) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.position.xgap = value
									InfoLine:UpdatePositions()
								end,
							},
							y = {
								type = "input",
								name = "Y Offset",
								width = "half",
								order = 40,
								get = function(info) return tostring(db.position.y) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.position.y = value
									InfoLine:UpdatePositions()
								end,
							},
						},
					},
					text = {
						type = "group",
						name = "Text",
						inline = true,
						order = 20,
						args = {
							yoffset = {
								type = "input",
								name = "Y Offset",
								width = "half",
								get = function(info) return tostring(db.text.yoffset) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.text.yoffset = value
									InfoLine:UpdatePositions()
								end,
								order = 10,
							},
						},
					},
					iconbuttons = {
						type = "group",
						name = "Icons",
						inline = true,
						order = 30,
						args = {
							size = {
								type = "range",
								name = "Size",
								min = 6, max = 32, step = 1,
								get = function(info) return db.iconbuttons.size end,
								set = function(info, value) 
									db.iconbuttons.size = value
									InfoLine:UpdatePositions()
								end,
								order = 10,
							},
							yoffset = {
								type = "input",
								name = "Y Offset",
								width = "half",
								order = 20,
								get = function(info) return tostring(db.iconbuttons.yoffset) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.iconbuttons.yoffset = value
									InfoLine:UpdatePositions()
								end,
							},
						},
					},
				},
			},
			colors = {
				name = "Colors",
				type = "group",
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				order = 60,
				args = {
					normal = {
						type = "color",
						name = "Normal",
						hasAlpha = false,
						get = function(info,r,g,b)
							return db.colors.normal[1], db.colors.normal[2], db.colors.normal[3]
						end,
						set = function(info,r,g,b)
							db.colors.normal[1] = r
							db.colors.normal[2] = g
							db.colors.normal[3] = b
							InfoLine:Refresh()
						end,
						order = 10,
					},
					sep1 = {
						type = "description",
						name = " ",
						order = 20,
					},
					highlight = {
						type = "color",
						name = "Highlight",
						hasAlpha = false,
						get = function(info,r,g,b)
							return db.colors.highlight[1], db.colors.highlight[2], db.colors.highlight[3]
						end,
						set = function(info,r,g,b)
							db.colors.highlight[1] = r
							db.colors.highlight[2] = g
							db.colors.highlight[3] = b
							InfoLine:Refresh()
						end,
						disabled = function()
							if db.colors.classcolorhighlight then return true else return false; end 
						end,
						order = 30,
					},
					classcolorhighlight = {
						type = "toggle",
						name = "Class Color Highlight",
						desc = "Use your Class Color for the highlight text.",
						get = function() return db.colors.classcolorhighlight end,
						set = function(info, value) 
							db.colors.classcolorhighlight = value
							InfoLine:Refresh()
						end,
						order = 40,
					},
					sep2 = {
						type = "description",
						name = " ",
						order = 50,
					},
					disabled = {
						type = "color",
						name = "Disabled",
						hasAlpha = false,
						get = function(info,r,g,b)
							return db.colors.disabled[1], db.colors.disabled[2], db.colors.disabled[3]
						end,
						set = function(info,r,g,b)
							db.colors.disabled[1] = r
							db.colors.disabled[2] = g
							db.colors.disabled[3] = b
							InfoLine:Refresh()
						end,
						order = 60,
					},
					ttheader = {
						type = "color",
						name = "Tooltip Header 1",
						hasAlpha = false,
						get = function(info,r,g,b)
							return db.colors.ttheader[1], db.colors.ttheader[2], db.colors.ttheader[3]
						end,
						set = function(info,r,g,b)
							db.colors.ttheader[1] = r
							db.colors.ttheader[2] = g
							db.colors.ttheader[3] = b
							InfoLine:Refresh()
						end,
						order = 70,
					},
					orange1 = {
						type = "color",
						name = "Header 1",
						hasAlpha = false,
						get = function(info,r,g,b)
							return db.colors.orange1[1], db.colors.orange1[2], db.colors.orange1[3]
						end,
						set = function(info,r,g,b)
							db.colors.orange1[1] = r
							db.colors.orange1[2] = g
							db.colors.orange1[3] = b
							InfoLine:Refresh()
						end,
						order = 80,
					},
					orange2 = {
						type = "color",
						name = "Header 2",
						hasAlpha = false,
						get = function(info,r,g,b)
							return db.colors.orange2[1], db.colors.orange2[2], db.colors.orange2[3]
						end,
						set = function(info,r,g,b)
							db.colors.orange2[1] = r
							db.colors.orange2[2] = g
							db.colors.orange2[3] = b
							InfoLine:Refresh()
						end,
						order = 90,
					},
					blue1 = {
						type = "color",
						name = "Header 3",
						hasAlpha = false,
						get = function(info,r,g,b)
							return db.colors.blue1[1], db.colors.blue1[2], db.colors.blue1[3]
						end,
						set = function(info,r,g,b)
							db.colors.blue1[1] = r
							db.colors.blue1[2] = g
							db.colors.blue1[3] = b
							InfoLine:Refresh()
						end,
						order = 100,
					},
				},
			},
			other = {
				name = "Other",
				type = "group",
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				order = 70,
				args = {
					clock = {
						type = "group",
						name = "Clock",
						inline = true,
						order = 10,
						args = {
							clock24 = {
								type = "toggle",
								name = "24 hour clock",
								desc = "Show the time in 24 hour format.",
								get = function() return db.other.clock.hr24 end,
								set = function(info, value) 
									db.other.clock.hr24 = value
									InfoLine:Refresh()
								end,
								order = 10,
							},
							clocklocal = {
								type = "toggle",
								name = "Use local time",
								desc = "Show the time at your home.",
								get = function() return db.other.clock.uselocal end,
								set = function(info, value) 
									db.other.clock.uselocal = value
									InfoLine:Refresh()
								end,
								order = 20,
							},
						},
					},
					tablets = {
						type = "group",
						name = "Info Displays",
						inline = true,
						order = 20,
						args = {
							maxheight = {
								type = "input",
								name = "Max Height",
								desc = "Maximum height of the Info Displays. May require a UI reload (/rl) to take effect.",
								width = "half",
								get = function(info) return tostring(db.other.tablets.maxheight) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.other.tablets.maxheight = value
								end,
								order = 10,
							},
						},
					},
				},
			},
		},
	}
	end
	
	-- Create Elements options table
	local elementopts = {
		name = "Elements",
		type = "group",
		disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
		order = 40,
		args = {},
	}
	local elementordercnt = 10;	
	for k_e, v_e in pairs(Elements) do
		-- Create base options for Elements
		elementopts.args[k_e] = {
			type = "toggle",
			name = Elements[k_e][1],
			desc = "Enable the "..Elements[k_e][1].." element.",
			get = function() return db.elements[k_e] end,
			set = function(info, value) 
				db.elements[k_e] = value
				InfoLine:Refresh()
			end,
			order = elementordercnt,
		}
		elementordercnt = elementordercnt + 10
	end
	options.args.elements = elementopts
	
	-- Create Custom Frames options table
	local customopts = {
		name = "Custom Frames",
		type = "group",
		disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
		order = 80,
		args = {
			desc = {
				type = "description",
				name = "Add your own frames/info displays to the Info Line.",
				fontSize = "medium",
				order = 1,
			},
			sep1 = {
				type = "description",
				name = " ",
				order = 2,
			},
			addframe = {
				type = "input",
				name = "Add Frame",
				desc = "Frame name to add to the Info Line.\n\nTo find out the name of a frame, you can type '/fstack' then mouse over the frame.",
				get = function(info) return nil end,
				set = function(info, value)
					AddCustomFrame(value)
					GetOptions()
				end,
				order = 4,
			},
			sep2 = {
				type = "description",
				name = " ",
				order = 5,
			},
		},
	}
	local customordercnt = 20;	
	for k_c, v_c in ipairs(db.customframes) do
		-- Create base options for Elements
		customopts.args[v_c[1]..tostring(customordercnt)] = {
			type = "group",
			name = v_c[1],
			arg = k_c,
			inline = true,
			order = customordercnt,
			args = {
				removeframe = {
					type = "execute",
					name = "Remove",
					desc = "Remove this frame from the Info Line.",
					func = function(info)
						RemoveCustomFrame(k_c)
						GetOptions()
						nibRealUI:ReloadUIDialog()
					end,
					order = 10,
				},
				side = {
					type = "select",
					name = "Side",
					get = function(info) 
						for k,v in pairs(table_Sides) do
							if v == v_c[2] then return k end
						end
					end,
					set = function(info, value)
						db.customframes[k_c][2] = table_Sides[value]
						InfoLine:UpdatePositions()
					end,
					style = "dropdown",
					values = table_Sides,
					order = 20,
				},
				yoffset = {
					type = "input",
					name = "Y Offset",
					width = "half",
					order = 30,
					get = function(info) return tostring(v_c[3]) end,
					set = function(info, value)
						value = nibRealUI:ValidateOffset(value)
						db.customframes[k_c][3] = value
						InfoLine:UpdatePositions()
					end,
				},
			},
		}
		customordercnt = customordercnt + 10
	end
	options.args.customframes = customopts
	
	return options
end
----

--------------------
-- Misc Functions --
--------------------
-- Color table to String
local function ColorTableToStr(vals)
	return strform("%02x%02x%02x", vals[1] * 255, vals[2] * 255, vals[3] * 255)
end

-- Create Copy Frame
local CopyFrame

local function CreateCopyFrame()
	local frame = CreateFrame("Frame", "RealUICopyFrame", UIParent)
	tinsert(UISpecialFrames, "RealUICopyFrame")
	
	frame:SetBackdrop({
		bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
		edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 3, right = 3, top = 5, bottom = 3 }
	})
	frame:SetBackdropColor(0,0,0,1)
	frame:SetWidth(400)
	frame:SetHeight(200)
	frame:SetPoint("CENTER", UIParent, "CENTER")
	frame:Hide()
	frame:SetFrameStrata("DIALOG")
	CopyFrame = frame
	
	local scrollArea = CreateFrame("ScrollFrame", "RealUICopyScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)
	
	local editBox = CreateFrame("EditBox", nil, frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:SetWidth(350)
	editBox:SetHeight(170)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
	CopyFrame.editBox = editBox
	
	scrollArea:SetScrollChild(editBox)
	
	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
end

-- Sort by Realm
local function RealmSort(a, b)
	if a.name == nibRealUI.realm then 
		return true
	elseif b.name == nibRealUI.realm then
		return false
	else
		return a.name < b.name
	end
end

-- Sort by Character
local function CharSort(a, b)
	if a[2] == b[2] then
		return a[9] < b[9]
	end
	return a[2] < b[2]
end

-- Gold string
local function convertMoney(money)
	money = money or 0
	local gold, silver, copper = abs(money / 10000), abs(mod(money / 100, 100)), abs(mod(money, 100))
	if floor(gold) > 0 then
		return format("|cff%s%d|r|cffffd700g|r", TextColorNormal, gold)
	elseif floor(silver) > 0 then
		return format("|cff%s%d|r|cffc7c7cfs|r", TextColorNormal, silver)
	else
		return format("|cff%s%d|r|cffeda55fc|r", TextColorNormal, copper)
	end
end

-- Get Realm time
local function RetrieveGameTime(...)
	local serTime, serAMPM
	local hour, min = GetGameTime()
	
	if ( min < 10 ) then min = strform("%s%s", "0", min) end
	
	if ... then
		-- 12 hour clock
		if hour >= 12 then 
			serAMPM = "PM"
			hour = hour - 12
		else
			serAMPM = "AM"
			if hour == 0 then hour = 12 end
		end
		serTime = strform("%s:%s %s", hour, min, serAMPM)
	else
		serAMPM = ""
		serTime = strform("%s:%s", hour, min)
	end
	
	return serTime, serAMPM
end

-- Seconds to Time
local function ConvertSecondstoTime(value)
	local hours, minues, seconds
	hours = floor(value / 3600)
	minutes = floor((value - (hours * 3600)) / 60)
	seconds = floor(value - ((hours * 3600) + (minutes * 60)))

	if ( hours > 0 ) then
		return strform("%dh %dm", hours, minutes)
	elseif ( minutes > 0 ) then
		if minutes >= 10 then
			return strform("%dm", minutes)
		else
			return strform("%dm %ds", minutes, seconds)
		end
	else
		return strform("%ds", seconds)
	end
end

-- Text width
local TestStr = CreateFrame("Frame", nil, UIParent)
TestStr.text = TestStr:CreateFontString()
local function GetTextWidth(str, size)
	TestStr.text:SetFont(nibRealUI.font.standard, size)
	TestStr.text:SetText(str)
	return TestStr.text:GetWidth() + 4
end

local function GetStrToDistance(str, size, fontsize, ...)
	local newStr
	for i = 1, strlen(str) do
		newStr = strsub(str, 1, i)
		if GetTextWidth(newStr, fontsize) > size then
			if ... then
				return {strsub(newStr, 1, i), i}
			else
				return strsub(newStr, 1, i - 2).."..."
			end
		end
	end
	if ... then 
		return {str, nil}
	else
		return str
	end
end

-- Add blank line to Tablet
local function AddBlankTabLine(cat, ...)
	local blank = {"blank", true, "fakeChild", true, "noInherit", true}
	local cnt = ... or 1
	for i = 1, cnt do
		cat:AddLine(blank)
	end
end

-- Construct standard Header for tablets
local function MakeTabletHeader(col, size, indentation, justifyTable)
	local header = {}
	local colors = {}
	colors = db.colors.orange1
	
	for i = 1, #col do
		if ( i == 1 ) then
			header["text"] = col[i]
			header["justify"] = justifyTable[i]
			header["size"] = size
			header["textR"] = colors[1]
			header["textG"] = colors[2]
			header["textB"] = colors[3]
			header["indentation"] = indentation
		else
			header["text"..i] = col[i]
			header["justify"..i] = justifyTable[i]
			header["size"..i] = size
			header["text"..i.."R"] = colors[1]
			header["text"..i.."G"] = colors[2]
			header["text"..i.."B"] = colors[3]
			header["indentation"] = indentation
		end
	end
	return header
end

-- Element Width
local function UpdateElementWidth(e, ...)
	if ... or e.hidden then
		e.curwidth = 0
		InfoLine:UpdatePositions()
	else
		local OldWidth = e.curwidth
		local div = db.position.xgap / 2
		e.curwidth = (ceil(e.text:GetWidth() / div) * div) + db.position.xgap
		if e.curwidth ~= OldWidth then
			InfoLine:UpdatePositions()
		end
	end
end

------------
-- GRAPHS --
------------

local Graphs = {}
local GraphHeight = 20
local GraphLineWidth = 3
local GraphColor1 = 1
local GraphColor2 = 0.3

-- Create Graph
local function CreateGraph(id, maxVal, numVals, parentFrame)
	if Graphs[id] then return end
	
	-- Create Graph frame
	Graphs[id] = CreateFrame("Frame", nil, UIParent)
	Graphs[id].parentFrame = parentFrame
	Graphs[id]:SetHeight(GraphHeight)
	
	Graphs[id].gridTop = CreateFrame("Frame", nil, Graphs[id])
	Graphs[id].gridTop:SetHeight(1)
	Graphs[id].gridTop:SetPoint("TOPLEFT", Graphs[id], 0, 0)
	Graphs[id].gridTop:SetPoint("TOPRIGHT", Graphs[id], 0, 0)
	Graphs[id].gridTop.bg = Graphs[id].gridTop:CreateTexture()
	Graphs[id].gridTop.bg:SetAllPoints()
	Graphs[id].gridTop.bg:SetTexture(GraphColor2, GraphColor2, GraphColor2, GraphColor2)
	
	Graphs[id].gridCenter = CreateFrame("Frame", nil, Graphs[id])
	Graphs[id].gridCenter:SetHeight(1)
	Graphs[id].gridCenter:SetPoint("LEFT", Graphs[id], 0, 0)
	Graphs[id].gridCenter:SetPoint("RIGHT", Graphs[id], 0, 0)
	Graphs[id].gridCenter.bg = Graphs[id].gridCenter:CreateTexture()
	Graphs[id].gridCenter.bg:SetAllPoints()
	Graphs[id].gridCenter.bg:SetTexture(GraphColor2, GraphColor2, GraphColor2, GraphColor2)
	
	Graphs[id].gridBot = CreateFrame("Frame", nil, Graphs[id])
	Graphs[id].gridBot:SetHeight(1)
	Graphs[id].gridBot:SetPoint("BOTTOMLEFT", Graphs[id], 0, 0)
	Graphs[id].gridBot:SetPoint("BOTTOMRIGHT", Graphs[id], 0, 0)
	Graphs[id].gridBot.bg = Graphs[id].gridBot:CreateTexture()
	Graphs[id].gridBot.bg:SetAllPoints()
	Graphs[id].gridBot.bg:SetTexture(GraphColor2, GraphColor2, GraphColor2, GraphColor2)
	
	Graphs[id].lines = {}
	for i = 1, numVals do
		Graphs[id].lines[i] = CreateFrame("Frame", nil, Graphs[id])
		Graphs[id].lines[i]:SetPoint("BOTTOMLEFT", Graphs[id], "BOTTOMLEFT", (i - 1) * GraphLineWidth, 0)
		Graphs[id].lines[i]:SetHeight(GraphHeight)
		Graphs[id].lines[i]:SetWidth(GraphLineWidth)
		
		Graphs[id].lines[i].point = Graphs[id].lines[i]:CreateTexture()
		Graphs[id].lines[i].point:SetPoint("BOTTOM", Graphs[id].lines[i], "BOTTOM", 0, 0)
		Graphs[id].lines[i].point:SetHeight(1)
		Graphs[id].lines[i].point:SetWidth(GraphLineWidth)
		Graphs[id].lines[i].point:SetTexture(GraphColor1, GraphColor1, GraphColor1, GraphColor1)
	end
	
	-- Fill out Graph info
	Graphs[id].max = maxVal
	Graphs[id].numVals = numVals
	Graphs[id].vals = {}
	for i = 1, numVals do
		Graphs[id].vals[i] = 0
	end
end

-- Update Graph
local function UpdateGraph(id, vals, ...)
	if not Graphs[id] then return end
	if not Graphs[id].enabled then return end
	
	numVals = Graphs[id].numVals
	
	-- Set new Min/Max
	newMax = ...
	if newMax then
		Graphs[id].max = newMax
	end
	
	-- Update Vals
	if Graphs[id].shown then
		for i = 1, numVals do
			Graphs[id].vals[i] = min(vals[i] or 0, Graphs[id].max)
			Graphs[id].vals[i] = max(Graphs[id].vals[i], 0)
			Graphs[id].lines[i].point:SetPoint("BOTTOM", Graphs[id].lines[i], "BOTTOM", 0, Graphs[id].vals[i] * (GraphHeight / Graphs[id].max))
		end
	end
end

-- Show Graph
local function ShowGraph(id, parent, relPoint, point, x, y, parentFrame)
	Graphs[id]:SetParent(parent)
	Graphs[id]:SetFrameStrata("TOOLTIP")
	Graphs[id]:SetFrameLevel(20)
	Graphs[id]:SetPoint(relPoint, parent, point, x, y)
	Graphs[id]:SetWidth(Graphs[id].numVals * 3)
	
	Graphs[id]:Show()
	Graphs[id].shown = true
end

-- Hide Graph
local function HideGraph(id)
	Graphs[id]:Hide()
	Graphs[id].shown = false
end

-- Hide non-parented Graphs
local function HideOtherGraphs(parentFrame)
	for k, v in pairs(Graphs) do
		if (Graphs[k].parentFrame ~= parentFrame) and Graphs[k].shown then
			HideGraph(k)
		end
	end
end

----------
-- Text --
----------
---- XP/Rep
local xp, lvl, xpmax, restxp
local rep, replvlmax, repStandingID, repstatus, watchedFaction
function InfoLine_XR_OnLeave(self)
	if ( (repstatus == "---") and (UnitLevel("player") == MAX_PLAYER_LEVEL) ) then
		-- Max Level and no Rep tracked, hide display
		self:SetAlpha(0)
	end
	if GameTooltip:IsShown() then GameTooltip:Hide() end
end

function InfoLine_XR_OnEnter(self)
	self:SetAlpha(1)

	GameTooltip:SetOwner(self, "ANCHOR_TOP"..self.side, 0, 2)
	
	if UnitLevel("player") < MAX_PLAYER_LEVEL then
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorTTHeader, XP.." / "..REPUTATION))
		GameTooltip:AddLine(" ")
		
		if IsXPUserDisabled() then
			GameTooltip:AddLine(strform("|cff%s%s|r", TextColorOrange1, COMBAT_XP_GAIN.." ("..VIDEO_OPTIONS_DISABLED..")"))
		else
			GameTooltip:AddLine(strform("|cff%s%s|r", TextColorOrange1, COMBAT_XP_GAIN))
		end
		GameTooltip:AddDoubleLine(L["Current"], nibRealUI:ReadableNumber(xp), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
		GameTooltip:AddDoubleLine(L["Remaining"], nibRealUI:ReadableNumber(xpmax - xp), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
		if not restxp then
			GameTooltip:AddDoubleLine(TUTORIAL_TITLE26, "0", 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
		else
			GameTooltip:AddDoubleLine(TUTORIAL_TITLE26, nibRealUI:ReadableNumber(restxp), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
		end
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorOrange1, REPUTATION))
	else
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorOrange1, REPUTATION))
		GameTooltip:AddLine(" ")
	end
	local repStandingColor = {0.9, 0.9, 0.9}
	if (repstatus ~= "---") then
		repStandingColor = {FACTION_BAR_COLORS[repStandingID].r, FACTION_BAR_COLORS[repStandingID].g, FACTION_BAR_COLORS[repStandingID].b}
	end
	GameTooltip:AddDoubleLine(FACTION, watchedFaction, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
	GameTooltip:AddDoubleLine(STATUS, repstatus, 0.9, 0.9, 0.9, repStandingColor[1], repStandingColor[2], repStandingColor[3])
	GameTooltip:AddDoubleLine(L["Current"], nibRealUI:ReadableNumber(rep), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
	GameTooltip:AddDoubleLine(L["Remaining"], nibRealUI:ReadableNumber(replvlmax - rep), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
	
	-- Hint
	if (UnitLevel("player") < MAX_PLAYER_LEVEL) and not(IsXPUserDisabled()) then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(strform("|cff00ff00%s|r", L["<Click> to switch between"]))
		GameTooltip:AddLine(strform("|cff00ff00%s|r", "    "..L["XP and Rep display."]))
	end
	
	GameTooltip:Show()
end

function InfoLine_XR_Update(self)
	-- XP Data
	xp = UnitXP("player")
	lvl = UnitLevel("player")
	xpmax = UnitXPMax("player")
	restxp = GetXPExhaustion() or 0
	local percentXP = (xp/xpmax)*100
	if (xp <= 0) or (xpmax <= 0) then
		percentXP = 0
	else
		percentXP = (xp/xpmax)*100
	end
	local percentXPStr = tostring(percentXP)
	local percentRestXPStr = tostring(floor((restxp / xpmax) * 100))
	
	-- Currency
	dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].level = lvl
	
	-- Rep Data
	local CurWatchedFaction, replvl, repmin, repmax, repvalue = GetWatchedFactionInfo()
	watchedFaction = CurWatchedFaction
	rep = repvalue - repmin
	replvlmax = repmax - repmin
	repstatus = getglobal("FACTION_STANDING_LABEL"..replvl)
	repStandingID = replvl
	
 	local percentRep
	if (replvlmax <= 0) then
		percentRep = 0
	else
		percentRep = (rep/(replvlmax))*100
	end
	local percentRepStr = tostring(percentRep)
	
	if not watchedFaction then
		watchedFaction = L["Faction not set"]
		repstatus = "---"
		rep = 0
		replvlmax = 0
		percentRepStr = "---"
	end
	
	-- Set Info Text
	local XRSuffix, XRStr, XRPer, XRLen, XRRested
	local HideMe = false
	if ( (dbc.xrstate == "x") and not(UnitLevel("player") == MAX_PLAYER_LEVEL) and not(IsXPUserDisabled()) ) then
		XRSuffix, XRStr, XRPer = "XP:", percentXPStr, percentXP
		if restxp > 0 then
			XRRested = percentRestXPStr
		else
			XRRested = ""
		end
	else
		if ( (repstatus == "---") and (UnitLevel("player") == MAX_PLAYER_LEVEL) ) then
			-- Max Level and no Rep tracked, hide display
			HideMe = true
		end
		XRSuffix, XRStr, XRPer, XRRested = "Rep:", percentRepStr, percentRep, ""
	end
	if XRPer < 10 then XRLen = 3 else XRLen = 4 end
	if XRSuffix == "XP:" then
		if XRRested ~= "" then
			self.text:SetFormattedText("|cff%s%s|r|cff%s %s%% (%s%%)|r", TextColorHighlight, XRSuffix, TextColorNormal, strsub(XRStr, 1, XRLen), XRRested)
		else
			self.text:SetFormattedText("|cff%s%s|r|cff%s %s%%|r", TextColorHighlight, XRSuffix, TextColorNormal, strsub(XRStr, 1, XRLen))
		end
	else
		self.text:SetFormattedText("|cff%s%s|r|cff%s %s%%|r", TextColorHighlight, XRSuffix, TextColorNormal, strsub(XRStr, 1, XRLen))
	end
	
	self.hidden = HideMe
	if HideMe then
		self.text:SetText("")
		UpdateElementWidth(self)
	else
		UpdateElementWidth(self)
	end
end

function InfoLine_XR_OnMouseDown(self)
	dbc.xrstate = (dbc.xrstate == "x") and "r" or "x"
	if UnitLevel("player") == MAX_PLAYER_LEVEL and not InCombatLockdown() then
		ToggleCharacter("ReputationFrame")
	end
	InfoLine_XR_Update(self)
end

---- Currency
local CurrencyTabletData = {}
local CurrencyTabletDataRK = {}
local CurrencyTabletDataStart = {}
local CurrencyTabletDataCurrent = {}

local function Currency_GetDifference(startVal, endVal, isGold)
	startVal = startVal or 0
	endVal = endVal or 0
	local newVal = endVal - startVal
	local newPrefix, newSuffix = "", ""
	
	if newVal > 0 then
		newPrefix = "|cff00c000+"
	elseif newVal < 0 then
		newPrefix = "|cffe00000-"
	else
		newPrefix = "|cff4D4D4D"
	end
	
	if isGold and newVal ~= 0 then
		local gold, silver, copper = abs(newVal / 10000), abs(mod(newVal / 100, 100)), abs(mod(newVal, 100))
		if floor(gold) > 0 then
			newVal = floor(gold)
			newSuffix = "|cffffd700g|r"
		elseif floor(silver) > 0 then
			newVal = floor(silver)
			newSuffix = "|cffc7c7cfs|r"
		else
			newVal = floor(copper)
			newSuffix = "|cffeda55fc|r"
		end
	else
		newSuffix = "|r"
	end
	
	return string.format(newPrefix.."%s"..newSuffix, newVal ~= 0 and abs(newVal) or "~")
end

local function Currency_TabletClickFunc(realm, faction, name)
	if not name then return end
	if realm == nibRealUI.realm and faction == nibRealUI.faction and name == nibRealUI.name then return end
	if IsAltKeyDown() then
		dbg.currency[realm][faction][name] = nil
		ILFrames.currency.needrefreshed = true
		ILFrames.currency.elapsed = 1
	end
end

local RealmSection, MaxWidth = {}, {}
local FactionList = {nibRealUI.faction, nibRealUI:OtherFaction(nibRealUI.faction)}
local function Currency_UpdateTablet()
	if not CurrencyTabletData then return end
	
	local FactionList = {nibRealUI.faction, nibRealUI:OtherFaction(nibRealUI.faction)}
	resSizeExtra = db.resolution[ndbc.resolution].tabfontsize
	
	local HasMaxLvl, OnlyMe = false, true
	
	-- Get max col widths
	MaxWidth = {[1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0}
	for kr, vr in pairs(CurrencyTabletData) do
		local realm = kr
		if (CurrencyTabletData[realm]["Alliance"] and (#CurrencyTabletData[realm]["Alliance"] > 0)) or
			(CurrencyTabletData[realm]["Horde"] and (#CurrencyTabletData[realm]["Horde"] > 0)) then
			
			local TotalGold = 0
			for kf, vf in ipairs(FactionList) do
				if CurrencyTabletData[realm][vf] and #CurrencyTabletData[realm][vf] > 0 then
					for kn, vn in pairs(CurrencyTabletData[realm][vf]) do
						if vn[2] == MAX_PLAYER_LEVEL then HasMaxLvl = true end
						TotalGold = TotalGold + vn[3]
						MaxWidth[3] = max(MaxWidth[3], GetTextWidth(convertMoney(vn[3]), 11 + resSizeExtra))
						for i = 4, 9 do
							MaxWidth[i] = max(MaxWidth[i], GetTextWidth(vn[i], 11 + resSizeExtra))
						end
					end
				end
			end
			MaxWidth[3] = max(MaxWidth[3], GetTextWidth(convertMoney(TotalGold), 11 + resSizeExtra))
		end
	end
	MaxWidth[2] = 20
	
	wipe(RealmSection)
	local line = {}
	for kr, vr in ipairs(CurrencyTabletDataRK) do
		local realm = CurrencyTabletDataRK[kr].name
		if 	(CurrencyTabletData[realm]["Alliance"] and (#CurrencyTabletData[realm]["Alliance"] > 0)) or
			(CurrencyTabletData[realm]["Horde"] and (#CurrencyTabletData[realm]["Horde"] > 0)) then
			
			-- Realm Category
			RealmSection[realm] = {}
			RealmSection[realm].cat = Tablets.currency:AddCategory()
			if kr > 1 then
				AddBlankTabLine(RealmSection[realm].cat, 4)
			end
			RealmSection[realm].cat:AddLine("text", realm, "size", 13 + resSizeExtra, "textR", 1, "textG", 1, "textB", 1)
			AddBlankTabLine(RealmSection[realm].cat, 2)

			-- Characters
			local charCols = {
				NAME,
				LEVEL_ABBR,
				GoldName,
				L["Justice Points"],
				L["Valor Points"],
				L["Honor Points"],
				L["Conquest Points"],
				L["Updated"]
			}
			RealmSection[realm].charCat = Tablets.currency:AddCategory("columns", #charCols)
			local charHeader = MakeTabletHeader(charCols, 10 + resSizeExtra, 12, {"LEFT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT"})
			RealmSection[realm].charCat:AddLine(charHeader)
			AddBlankTabLine(RealmSection[realm].charCat, 1)
			
			local TotalGold, TotalRealmChars = 0, 0
			for kf, vf in ipairs(FactionList) do
				if CurrencyTabletData[realm][vf] and #CurrencyTabletData[realm][vf] > 0 then
					sort(CurrencyTabletData[realm][vf], CharSort)
					for kn, vn in pairs(CurrencyTabletData[realm][vf]) do
						TotalRealmChars = TotalRealmChars + 1
						local isPlayer = ((realm == nibRealUI.realm) and (vf == nibRealUI.faction) and (vn[9] == nibRealUI.name))
						if not isPlayer then OnlyMe = false end
						local NormColor = isPlayer and 1 or 0.7
						local ZeroShade = isPlayer and 0.1 or 0.4
						
						wipe(line)
						for i = 1, #charCols do
							if i == 1 then
								line["indentation"] = 12.5
								if isPlayer then
									line["hasCheck"] = true
									line["checked"] = true
									line["isRadio"] = true
									line["indentation"] = 0
								end
								line["text"] = vn[i]
								line["justify"] = "LEFT"
								line["func"] = function() Currency_TabletClickFunc(realm, vf, vn[9]) end
								line["size"] = 11 + resSizeExtra
								line["customwidth"] = MaxWidth[9]
							elseif i == 2 or i == 8 then
								line["text"..i] = vn[i]
								line["justify"..i] = "RIGHT"
								line["text"..i.."R"] = NormColor
								line["text"..i.."G"] = NormColor
								line["text"..i.."B"] = NormColor
								line["customwidth"..i] = MaxWidth[i]
								line["indentation"..i] = 12.5
							elseif i == 3 then
								TotalGold = TotalGold + vn[i]
								line["text"..i] = convertMoney(vn[i])
								line["justify"..i] = "RIGHT"
								line["customwidth"..i] = MaxWidth[i]
								line["indentation"..i] = 12.5
							else
								line["text"..i] = vn[i]
								line["justify"..i] = "RIGHT"
								line["customwidth"..i] = MaxWidth[i]
								line["indentation"..i] = 12.5
								if vn[i + 6] == 0 then
									line["text"..i.."R"] = NormColor - ZeroShade
									line["text"..i.."G"] = NormColor - ZeroShade
									line["text"..i.."B"] = NormColor - ZeroShade
								else
									line["text"..i.."R"] = NormColor
									line["text"..i.."G"] = NormColor
									line["text"..i.."B"] = NormColor
								end
								
							end
						end
						RealmSection[realm].charCat:AddLine(line)
						
						-- Start values
						if isPlayer then
							NormColor = 0.5
							wipe(line)
							for i = 1, #charCols do
								if i == 1 then
									line["indentation"] = 12
									line["text"] = ""
									line["justify"] = "LEFT"
									line["size"] = 10 + resSizeExtra
									line["customwidth"] = MaxWidth[9]
								elseif i == 2 or i == 8 then
									line["text"..i] = ""
									line["justify"..i] = "RIGHT"
									line["size"..i] = 10 + resSizeExtra
									line["customwidth"..i] = MaxWidth[i]
									line["indentation"..i] = 12
								elseif i == 3 then
									line["text"..i] = Currency_GetDifference(CurrencyTabletDataStart[3], CurrencyTabletDataCurrent[3], true)
									line["justify"..i] = "RIGHT"
									line["size"..i] = 10 + resSizeExtra
									line["customwidth"..i] = MaxWidth[3]
									line["indentation"..i] = 12
								else
									line["text"..i] = Currency_GetDifference(CurrencyTabletDataStart[i + 6], CurrencyTabletDataCurrent[i + 6], false)
									line["justify"..i] = "RIGHT"
									line["size"..i] = 10 + resSizeExtra
									line["customwidth"..i] = MaxWidth[i]
									line["indentation"..i] = 12
								end
							end
							RealmSection[realm].charCat:AddLine(line)
							AddBlankTabLine(RealmSection[realm].charCat, 4)
						end
					end
					AddBlankTabLine(RealmSection[realm].charCat, 4)
				end
			end
			
			-- Realm Total
			if TotalRealmChars > 1 then
				RealmSection[realm].charCat:AddLine(
					"text3", convertMoney(TotalGold),
					"justify3", "RIGHT",
					"customwidth3", MaxWidth[3],
					"indentation3", 12
				)
				AddBlankTabLine(RealmSection[realm].charCat, 4)
			end
		end
	end
	
	-- Hint
	local hint
	if OnlyMe then
		hint = L["<Click> to switch currency displayed."]
	else
		if HasMaxLvl then
			hint = L["<Click> to switch currency displayed."].."\n"..L["<Alt+Click> to erase highlighted character data."].."\n"..L["<Shift+Click> to reset weekly caps."]
		else
			hint = L["<Click> to switch currency displayed."].."\n"..L["<Alt+Click> to erase highlighted character data."]
		end
	end
	local hintCat = Tablets.currency:AddCategory()
	AddBlankTabLine(hintCat, 10)
	hintCat:AddLine(
		"text", hint,
		"textR", 0,
		"textG", 1,
		"textB", 0,
		"wrap", true
	)
	if not OnlyMe and HasMaxLvl then
		AddBlankTabLine(hintCat, 2)
		hintCat:AddLine(
			"text", L["Note: Weekly caps will reset upon loading currency data"].."\n  "..L["on a character whose weekly caps have reset."],
			"size", 9 + resSizeExtra,
			"textR", 0.7,
			"textG", 0.7,
			"textB", 0.7,
			"wrap", true
		)
	end
end

local function Currency_ResetWeeklyValues()
	for kr, vr in pairs(dbg.currency) do
		if vr then
			for kf, vf in pairs(dbg.currency[kr]) do
				if vf then
					for kn, vn in pairs(dbg.currency[kr][kf]) do
						if vn then
							dbg.currency[kr][kf][kn].vpw = 0
							dbg.currency[kr][kf][kn].cpw = 0
						end
					end
				end
			end
		end
	end
end

local function Currency_GetWeeklyValues()
	local Name, earnedTotal, earnedThisWeek, weeklyMax, IsDiscovered
	local valorTotal, valorThisWeek, valorWeeklyMax, conquestTotal, conquestThisWeek, conquestWeeklyMax
	
	-- Valor
	Name, earnedTotal, _, earnedThisWeek, weeklyMax, _, IsDiscovered = GetCurrencyInfo(396)
	if Name and IsDiscovered then
		valorTotal = earnedTotal or 0
		valorThisWeek = earnedThisWeek or 0
		valorWeeklyMax = weeklyMax/100 or 0
	end
	
	-- Conquest
	Name, earnedTotal, _, earnedThisWeek, weeklyMax, _, IsDiscovered = GetCurrencyInfo(390)
	if Name and IsDiscovered then
		conquestTotal = earnedTotal or 0
		conquestThisWeek = earnedThisWeek or 0
		conquestWeeklyMax = weeklyMax or 0
	end
	
	return valorTotal, valorThisWeek, valorWeeklyMax, conquestTotal, conquestThisWeek, conquestWeeklyMax
end

local function Currency_GetVals()
	local curr = {}
	curr[HPName] = 0	
	curr[CPName] = 0
	curr[JPName] = 0
	curr[VPName] = 0
	
	local currencySize = GetCurrencyListSize()
	for i = 1, currencySize do
		local name, isHeader, _, _, _, count = GetCurrencyListInfo(i)
		if curr[name] and (not isHeader) then
			curr[name] = count or 0
		end
	end
	
	return curr
end

local function Currency_Update(self)
	dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].class = nibRealUI.class
	
	local money = GetMoney()
	local currVals = Currency_GetVals()
	local valorTotal, valorThisWeek, valorWeeklyMax, conquestTotal, conquestThisWeek, conquestWeeklyMax = Currency_GetWeeklyValues()
	
	local curDate = date("%d/%m")
	if strsub(curDate, 1, 1) == "0" then
		curDate = strsub(curDate, 2)
	end
	
	dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].gold = money or 0
	dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].updated = curDate
	dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].jp = currVals[JPName] or 0
	dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].vp = currVals[VPName] or 0
	dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].hp = currVals[HPName] or 0
	dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].cp = currVals[CPName] or 0
	
	if self.hasshown or self.initialized then
		local oldVPW = dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].vpw
		local oldCPW = dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].cpw
		dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].vpw = valorThisWeek
		dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].cpw = conquestThisWeek
	
		if (valorThisWeek < oldVPW) or (conquestThisWeek < oldCPW) then
			-- Weekly reset
			Currency_ResetWeeklyValues()
		end
	
		-- Quick Current reference list
		CurrencyTabletDataCurrent = {
			"",
			"",
			dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].gold,
			dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].jp,
			"",
			dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].hp,
			"",
			"",
			kn,
			dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].jp,
			dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].vp,
			dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].hp,
			dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].cp
		}
		
		-- Start Session
		if not CurrencyStartSet then
			CurrencyTabletDataStart = CurrencyTabletDataCurrent
			CurrencyStartSet = true
		end
	end
	
	-- Fill out columns
	wipe(CurrencyTabletData)
	wipe(CurrencyTabletDataRK)
	local rCnt = 0
	for kr, vr in pairs(dbg.currency) do
		rCnt = rCnt + 1
		CurrencyTabletData[kr] = {}
		CurrencyTabletDataRK[rCnt] = {name = kr}
		
		if vr then
			for kf, vf in pairs(dbg.currency[kr]) do
				CurrencyTabletData[kr][kf] = {}
				
				if vf then
					for kn, vn in pairs(dbg.currency[kr][kf]) do
						if vn then
							local vpStr = tostring(dbg.currency[kr][kf][kn].vp)
							local cpStr = tostring(dbg.currency[kr][kf][kn].cp)
							if dbg.currency[kr][kf][kn].level == MAX_PLAYER_LEVEL then
								vpStr = vpStr.." ("..tostring(dbg.currency[kr][kf][kn].vpw or 0).."/"..valorWeeklyMax..")"
								cpStr = cpStr.." ("..tostring(dbg.currency[kr][kf][kn].cpw or 0).."/"..conquestWeeklyMax..")"
							end
							
							local classColor = nibRealUI:GetClassColor(dbg.currency[kr][kf][kn].class, true)
							local nameStr = strform("|cff%02x%02x%02x%s|r", classColor[1] * 255, classColor[2] * 255, classColor[3] * 255, kn)
							
							tinsert(CurrencyTabletData[kr][kf], {
								nameStr,
								dbg.currency[kr][kf][kn].level,
								dbg.currency[kr][kf][kn].gold,
								dbg.currency[kr][kf][kn].jp,
								vpStr,
								dbg.currency[kr][kf][kn].hp,
								cpStr,
								dbg.currency[kr][kf][kn].updated,
								kn,
								dbg.currency[kr][kf][kn].jp,
								dbg.currency[kr][kf][kn].vp,
								dbg.currency[kr][kf][kn].hp,
								dbg.currency[kr][kf][kn].cp
							})
						end
						
					end
				end
			end
		end
	end
	
	-- Refresh tablet
	if Tablets.currency:IsRegistered(self) then
		if Tablet20Frame:IsShown() then
			Tablets.currency:Refresh(self)
		end
	end
	
	-- Info Text
	local CurText
	if dbc.currencystate == 1 then
		CurText = convertMoney(money)
	elseif dbc.currencystate == 2 then
		CurText = tostring(dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].jp) .. " JP"
	elseif dbc.currencystate == 3 then
		CurText = tostring(dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].vp) .. " VP"
	elseif dbc.currencystate == 4 then
		CurText = tostring(dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].vpw) .. " VPw"
	elseif dbc.currencystate == 5 then
		CurText = tostring(dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].hp) .. " HP"
	elseif dbc.currencystate == 6 then
		CurText = tostring(dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].cp) .. " CP"
	elseif dbc.currencystate == 7 then
		CurText = tostring(dbg.currency[nibRealUI.realm][nibRealUI.faction][nibRealUI.name].cpw) .. " CPw"
	end
	self.text:SetFormattedText("|cff%s%s|r %s", TextColorHighlight, "C:", CurText)
	
	UpdateElementWidth(self)
end

local function Currency_OnEnter(self)
	-- Register Tablets.currency
	if not Tablets.currency:IsRegistered(self) then
		Tablets.currency:Register(self,
			"children", function()
				Currency_UpdateTablet()
			end,
			"point", function()
				return "BOTTOMLEFT"
			end,
			"relativePoint", function()
				return "TOPLEFT"
			end,
			"maxHeight", db.other.tablets.maxheight,
			"clickable", true,
			"hideWhenEmpty", true
		)
	end
	
	if Tablets.currency:IsRegistered(self) then
		-- Tablets.currency appearance
		Tablets.currency:SetColor(self, 0, 0, 0)
		Tablets.currency:SetTransparency(self, .85)
		Tablets.currency:SetFontSizePercent(self, 1)
		
		-- Open
		Tablets.currency:Open(self)
		
		HideOtherGraphs(self)
	end
	
	self.hasshown = true
	Currency_Update(self)
	
end

function Currency_OnMouseDown(self)
	if IsShiftKeyDown() then
		Currency_ResetWeeklyValues()
		Currency_Update(self)
		print("|cff00ffffRealUI: |r|cffffffffWeekly caps have been reset.")
	elseif IsAltKeyDown() then
		print("|cff00ffffRealUI: |r|cffffffffTo erase character data, mouse-over their entry in the Currency display and then Alt+Click.")
	else
		dbc.currencystate = (dbc.currencystate < 7) and (dbc.currencystate + 1) or 1
		if UnitLevel("player") < MAX_PLAYER_LEVEL then
			if dbc.currencystate == 3 or dbc.currencystate == 4 then
				dbc.currencystate = 5
			elseif dbc.currencystate == 6 or dbc.currencystate == 7 then
				dbc.currencystate = 1
			end
		end
		if not InCombatLockdown() then
			ToggleCharacter("CurrencyFrame")
		end
		Currency_Update(self)
	end
end

---- Bag
function InfoLine_Bag_Update(self)
	local freeSlots, totalSlots = 0, 0
	
	-- Cycle through bags
	for i = 0, 4 do
		local slots, slotsTotal = GetContainerNumFreeSlots(i), GetContainerNumSlots(i)
		if ( i >= 1 ) then	-- Extra bag
			local bagLink = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
			if bagLink then
				freeSlots =  freeSlots + slots
				totalSlots = totalSlots + slotsTotal
			end
		else -- Backpack, we count slots
			freeSlots =  freeSlots + slots
			totalSlots = totalSlots + slotsTotal
		end
	end

	-- Info Text
	self.text:SetFormattedText("|cff%s%s|r|cff%s %d|r", TextColorHighlight, "B:", TextColorNormal, freeSlots)
	UpdateElementWidth(self)
end

function InfoLine_Bag_OnMouseDown(self)
	if ContainerFrame1:IsShown() then
		ToggleBackpack()
	else
		ToggleBackpack()
		for i = 1, NUM_BAG_SLOTS do
			ToggleBag(i)
		end
	end
end

---- Durability
local SlotNameTable = {
	[1] = { slot = "HeadSlot", name = "Head" },
	[2] = { slot = "ShoulderSlot", name = "Shoulder" },
	[3] = { slot = "ChestSlot", name = "Chest" },
	[4] = { slot = "WaistSlot", name = "Waist" },
	[5] = { slot = "WristSlot", name = "Wrist" },
	[6] = { slot = "HandsSlot", name = "Hands" },
	[7] = { slot = "LegsSlot", name = "Legs" },
	[8] = { slot = "FeetSlot", name = "Feet" },
	[9] = { slot = "MainHandSlot", name = "Main Hand" },
	[10] = { slot = "SecondaryHandSlot", name = "Off Hand" },
}
local DuraSlotInfo = { }

function InfoLine_Durability_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP"..self.side, 0, 2)
	GameTooltip:AddLine(strform("|cff%s%s|r", TextColorTTHeader, DURABILITY))
	GameTooltip:AddLine(" ")
	for i = 1, 10 do
		local durastring
		if ( DuraSlotInfo[i].equip and DuraSlotInfo[i].max ~= nil ) then
			if ( DuraSlotInfo[i].perc <= 50 ) then
				durastring = strform("%s%d%%|r", "|cffffff00", DuraSlotInfo[i].perc)
			elseif ( DuraSlotInfo[i].perc <= 25 ) then
				durastring = strform("%s%d%%|r", "|cffff0000", DuraSlotInfo[i].perc)
			else
				durastring = strform("%d%%", DuraSlotInfo[i].perc)
			end
			GameTooltip:AddDoubleLine(SlotNameTable[i].name, durastring, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
		end
	end
	GameTooltip:Show()
end

function InfoLine_Durability_Update(self)
	local durability
	local minVal = 100
	
	for i = 1, 10 do
		if not DuraSlotInfo[i] then tinsert(DuraSlotInfo, i, {equip, value, max, perc}) end
		local slotID = GetInventorySlotInfo(SlotNameTable[i].slot)
		local itemLink = GetInventoryItemLink("player", slotID)
		local value, maximum = 0, 0
		if itemLink ~= nil then
			DuraSlotInfo[i].equip = true
			value, maximum = GetInventoryItemDurability(slotID)
		else
			DuraSlotInfo[i].equip = false
		end
		if ( DuraSlotInfo[i].equip and maximum ~= nil ) then
			DuraSlotInfo[i].value = value
			DuraSlotInfo[i].max = maximum
			DuraSlotInfo[i].perc = floor((DuraSlotInfo[i].value/DuraSlotInfo[i].max)*100)
		end
	end
	for i = 1, 10 do
		if ( DuraSlotInfo[i].equip and DuraSlotInfo[i].max ~= nil ) then
			if DuraSlotInfo[i].perc < minVal then minVal = DuraSlotInfo[i].perc end
		end
	end
	
	-- Info Text
	if minVal <= 90 then
		self.hidden = false
		self.text:SetFormattedText("|cff%s%s|r|cff%s %d%%|r", TextColorHighlight, "A:", TextColorNormal, minVal)
	else
		self.hidden = true
		self.text:SetText("")
	end
	UpdateElementWidth(self)
end

function InfoLine_Durability_OnMouseDown(self)
	if not InCombatLockdown() then
		ToggleCharacter("PaperDollFrame")
	end
end

---- Friends
local FriendsTabletData
local FriendsTabletDataNames
local FriendsOnline = 0

local function Friends_TabletClickFunc(name, iname, BNid)
	--print("Name: "..name.." iName: "..iname.." BNid: "..BNid)
	if not name then return end
	if IsAltKeyDown() then
		if iname == "" then
			InviteUnit(name)
		else
			InviteUnit(iname)
		end
	elseif BNid then
		SetItemRef("BNplayer:"..name..":"..BNid, "|HBNplayer:"..name.."|h["..name.."|h", "LeftButton")
	else
		SetItemRef("player:"..name, "|Hplayer:"..name.."|h["..name.."]|h", "LeftButton")
	end
end

local FriendsCat
local function Friends_UpdateTablet()
	if ( FriendsOnline > 0 and FriendsTabletData ) then
		resSizeExtra = db.resolution[ndbc.resolution].tabfontsize
		local Cols, lineHeader
		
		-- Title
		local Cols = {
			NAME,
			LEVEL_ABBR,
			ZONE,
			FACTION,
			GAME
		}
		FriendsCat = Tablets.friends:AddCategory("columns", #Cols)
		lineHeader = MakeTabletHeader(Cols, 10 + resSizeExtra, 0, {"LEFT", "RIGHT", "LEFT", "LEFT", "LEFT"})
		FriendsCat:AddLine(lineHeader)
		AddBlankTabLine(FriendsCat)
		
		-- Friends
		for _, val in ipairs(FriendsTabletData) do
			local line = {}
			for i = 1, #Cols do
				if i == 1 then	-- Name
					line["text"] = val[i]
					line["justify"] = "LEFT"
					line["func"] = function() Friends_TabletClickFunc(val[6],val[8],val[9]) end
					line["size"] = 11 + resSizeExtra
				elseif i == 2 then	-- Level
					line["text"..i] = val[2]
					line["justify"..i] = "RIGHT"
					local uLevelColor = GetQuestDifficultyColor(tonumber(val[2]) or 1)
					line["text"..i.."R"] = uLevelColor.r
					line["text"..i.."G"] = uLevelColor.g
					line["text"..i.."B"] = uLevelColor.b
					line["size"..i] = 11 + resSizeExtra
				else	-- The rest
					line["text"..i] = val[i]
					line["justify"..i] = "LEFT"
					line["text"..i.."R"] = 0.8
					line["text"..i.."G"] = 0.8
					line["text"..i.."B"] = 0.8
					line["size"..i] = 11 + resSizeExtra
				end
			end
			FriendsCat:AddLine(line)
		end
		
		-- Hint
		Tablets.friends:SetHint(L["<Click> to whisper, <Alt+Click> to invite."])
	end
end

local function Friends_OnEnter(self)
	-- Register Tablets.friends
	if not Tablets.friends:IsRegistered(self) then
		Tablets.friends:Register(self,
			"children", function()
				Friends_UpdateTablet()
			end,
			"point", function()
				return "BOTTOMLEFT"
			end,
			"relativePoint", function()
				return "TOPLEFT"
			end,
			"maxHeight", db.other.tablets.maxheight,
			"clickable", true,
			"hideWhenEmpty", true
		)
	end
	
	if Tablets.friends:IsRegistered(self) then
		-- Tablets.friends appearance
		Tablets.friends:SetColor(self, 0, 0, 0)
		Tablets.friends:SetTransparency(self, .85)
		Tablets.friends:SetFontSizePercent(self, 1)
		
		-- Open
		if ( FriendsOnline > 0 ) then
			ShowFriends()
		end
		Tablets.friends:Open(self)
		
		HideOtherGraphs(self)
	end
end

local function Friends_Update(self)
	FriendsTabletData = nil
	FriendsTabletDataNames = nil
	local curFriendsOnline = 0
	
	-- Standard Friends
	for i = 1, GetNumFriends() do
		local name, lvl, class, area, online, status, note = GetFriendInfo(i)
		if online then
			if ( not FriendsTabletData or FriendsTabletData == nil ) then FriendsTabletData = {} end
			if ( not FriendsTabletDataNames or FriendsTabletDataNames == nil ) then FriendsTabletDataNames = {} end
			
			curFriendsOnline = curFriendsOnline + 1
			
			-- Class
			local classColor = nibRealUI:GetClassColor(ClassLookup[class], true)
			class = strform("|cff%02x%02x%02x%s|r", classColor[1] * 255, classColor[2] * 255, classColor[3] * 255, class)
			
			-- Name
			local cname
			if ( status == "" and name ) then
				cname = strform("|cff%02x%02x%02x%s|r", classColor[1] * 255, classColor[2] * 255, classColor[3] * 255, name)
			elseif ( name ) then
				cname = strform("%s |cff%02x%02x%02x%s|r", status, classColor[1] * 255, classColor[2] * 255, classColor[3] * 255, name)
			end
			
			-- Add Friend to list
			tinsert(FriendsTabletData, { cname, lvl, area, nibRealUI.faction, "WoW", name, note, "" })
			if name then
				FriendsTabletDataNames[name] = true
			end
		end
	end
	
	-- Battle.net Friends
	for t = 1, BNGetNumFriends() do
		local BNid, BNname, battletag, isBattleTagPresence, toonname, toonid, client, online, lastonline, isafk, isdnd, broadcast, note = BNGetFriendInfo(t)
		--print("BNname: "..BNname.." BNid: "..BNid)
		-- WoW friends
		if ( online and client=="WoW" ) then
			if ( not FriendsTabletData or FriendsTabletData == nil ) then FriendsTabletData = {} end
			if ( not FriendsTabletDataNames or FriendsTabletDataNames == nil ) then FriendsTabletDataNames = {} end
			
			local _,name, _, realmName, _, faction, race, class, guild, area, lvl = BNGetToonInfo(toonid)
			curFriendsOnline = curFriendsOnline + 1
			
			if (realmName == nibRealUI.realm) then
				FriendsTabletDataNames[toonname] = true
			end

			-- Class
			local classColor = nibRealUI:GetClassColor(ClassLookup[class], true) or {1, 1, 1}
			class = strform("|cff%02x%02x%02x%s|r", classColor[1] * 255, classColor[2] * 255, classColor[3] * 255, class)
			
			-- Name
			local cname
			if ( realmName == GetRealmName() ) then
				-- On My Realm
				cname = strform(
					"|cff%02x%02x%02x%s|r |cffcccccc(|r|cff%02x%02x%02x%s|r|cffcccccc)|r",
					FRIENDS_BNET_NAME_COLOR.r * 255, FRIENDS_BNET_NAME_COLOR.g * 255, FRIENDS_BNET_NAME_COLOR.b * 255,
					BNname,
					classColor[1] * 255, classColor[2] * 255, classColor[3] * 255,
					name
				)
			else
				-- On Another Realm
				cname = strform(
					"|cff%02x%02x%02x%s|r |cffcccccc(|r|cff%02x%02x%02x%s|r|cffcccccc-%s)|r",
					FRIENDS_BNET_NAME_COLOR.r * 255, FRIENDS_BNET_NAME_COLOR.g * 255, FRIENDS_BNET_NAME_COLOR.b * 255,
					BNname,
					classColor[1] * 255, classColor[2] * 255, classColor[3] * 255,
					name,
					realmName
				)
			end
			if (isafk and name ) then
				cname = strform("%s %s", CHAT_FLAG_AFK, cname)
			elseif(isdnd and name) then
				cname = strform("%s %s", CHAT_FLAG_DND, cname)
			end
			
			-- Add Friend to list
			tinsert(FriendsTabletData, { cname, lvl, area, faction, client, BNname, note, name, BNid })
			
		-- SC2 friends
		elseif ( online and client=="S2" ) then
			if ( not FriendsTabletData or FriendsTabletData == nil ) then FriendsTabletData = {} end
			
			local _,name, _, realmName, faction, _, race, class, guild, area, lvl, gametext = BNGetToonInfo(toonid)
			client = "SC2"
			curFriendsOnline = curFriendsOnline + 1
			
			-- Name
			local cname
			cname = strform(
				"|cff%02x%02x%02x%s|r |cffcccccc(%s)|r",
				FRIENDS_BNET_NAME_COLOR.r * 255, FRIENDS_BNET_NAME_COLOR.g * 255, FRIENDS_BNET_NAME_COLOR.b * 255,
				BNname,
				toonname
			)
			if ( isafk and toonname ) then
				cname = strform("%s %s", CHAT_FLAG_AFK, cname)
			elseif ( isdnd and toonname ) then
				cname = strform("%s %s", CHAT_FLAG_DND, cname)
			end
			
			-- Add Friend to list
			tinsert(FriendsTabletData, { cname, "", gametext, "", client, BNname, note, "", BNid })
		-- D3 friends
		elseif ( online and client=="D3" ) then
			if ( not FriendsTabletData or FriendsTabletData == nil ) then FriendsTabletData = {} end
			
			local _,name, _, realmName, faction, _, race, class, guild, area, lvl, gametext = BNGetToonInfo(toonid)
			client = "D3"
			curFriendsOnline = curFriendsOnline + 1
			
			-- Name
			local cname
			cname = strform(
				"|cff%02x%02x%02x%s|r |cffcccccc(%s)|r",
				FRIENDS_BNET_NAME_COLOR.r * 255, FRIENDS_BNET_NAME_COLOR.g * 255, FRIENDS_BNET_NAME_COLOR.b * 255,
				BNname,
				toonname
			)
			if ( isafk and toonname ) then
				cname = strform("%s %s", CHAT_FLAG_AFK, cname)
			elseif ( isdnd and toonname ) then
				cname = strform("%s %s", CHAT_FLAG_DND, cname)
			end
			
			-- Add Friend to list
			tinsert(FriendsTabletData, { cname, lvl, gametext, class, client, BNname, note, "", BNid })
		end
	end
	
	-- OnEnter
	FriendsOnline = curFriendsOnline
	if FriendsOnline > 0 then
		self:SetScript("OnEnter", function(self) 
			Friends_OnEnter(self)
		end)
	else
		self:SetScript("OnEnter", nil)
	end
	
	-- Refresh tablet
	if Tablets.friends:IsRegistered(self) then
		if Tablet20Frame:IsShown() then
			Tablets.friends:Refresh(self)
		end
	end
	
	-- Info Text
	self.text:SetFormattedText("|cff%s%s|r|cff%s %d|r", TextColorHighlight, "F:", TextColorNormal, FriendsOnline)
	UpdateElementWidth(self)
end

function Friends_OnMouseDown(self)
	if not InCombatLockdown() then
		ToggleFriendsFrame()
	end
end

---- Guild
local GuildTabletData
local GuildOnline = 0

local function Guild_GMOTDClickFunc(gmotd)
	CopyFrame:Show()
	CopyFrame.editBox:SetText(gmotd)
	CopyFrame.editBox:HighlightText(0)
end

local function Guild_TabletClickFunc(name)
	if not name then return end
	if IsAltKeyDown() then
		InviteUnit(name)
	else
		SetItemRef("player:"..name, "|Hplayer:"..name.."|h["..name.."|h", "LeftButton")
	end
end

local GuildSection = {}
local function Guild_UpdateTablet()
	if ( IsInGuild() and GuildOnline > 0 ) then
		resSizeExtra = db.resolution[ndbc.resolution].tabfontsize
		local Cols, lineHeader
		wipe(GuildSection)
		
		-- Guild Name
		local gname, _, _ = GetGuildInfo("player")
		GuildSection.headerCat = Tablets.guild:AddCategory()
		GuildSection.headerCat:AddLine("text", gname, "size", 13 + resSizeExtra, "textR", db.colors.ttheader[1], "textG", db.colors.ttheader[2], "textB", db.colors.ttheader[3])
		GuildSection.headerCat:AddLine("isLine", true, "text", "")
		
		-- Guild Level
		GuildSection.headerCat:AddLine("text", (GetGuildFactionGroup() == 0) and strform(GUILD_LEVEL_AND_FACTION, GetGuildLevel(), FACTION_HORDE) or strform(GUILD_LEVEL_AND_FACTION, GetGuildLevel(), FACTION_ALLIANCE), "size", 10 + resSizeExtra, "textR", 0.7, "textG", 0.7, "textB", 0.7)
		
		-- Reputation
		GuildSection.headerCat:AddLine("text", GetText("FACTION_STANDING_LABEL"..GetGuildFactionInfo(), UnitSex("player")), "size", 11 + resSizeExtra, "textR", 0.7, "textG", 0.7, "textB", 0.7)
		AddBlankTabLine(GuildSection.headerCat, 5)
		
		-- GMOTD
		local gmotd = GetGuildRosterMOTD()
		if gmotd ~= "" then
			GuildSection.headerCat:AddLine("text", gmotd, "wrap", true, "textR", 1, "textG", 1, "textB", 1, "func", function() Guild_GMOTDClickFunc(gmotd) end)
			AddBlankTabLine(GuildSection.headerCat, 5)
		end
		AddBlankTabLine(GuildSection.headerCat)
		
		-- Titles
		local Cols = {
			NAME,
			LEVEL_ABBR,
			ZONE,
			RANK,
			LABEL_NOTE
		}
		if CanViewOfficerNote() then
			tinsert(Cols, "Officer Note")
		end
		
		GuildSection.guildCat = Tablets.guild:AddCategory("columns", #Cols)
		lineHeader = MakeTabletHeader(Cols, 10 + resSizeExtra, 0, {"LEFT", "RIGHT", "LEFT", "LEFT", "LEFT", "LEFT"})
		GuildSection.guildCat:AddLine(lineHeader)
		AddBlankTabLine(GuildSection.guildCat)
		
		-- Guild Members
		local nameslot = #Cols + 1
		local isPlayer, isFriend, isGM, normColor
		local line = {}
		for _, val in ipairs(GuildTabletData) do
			isPlayer = val[7] == nibRealUI.name
			if FriendsTabletDataNames then
				isFriend = (not isPlayer) and FriendsTabletDataNames[val[7]] or false
			end
			isGM = val[4] == GUILD_RANK0_DESC
			normColor = 	isPlayer and {0.3, 1, 0.3} or 
							isFriend and {0, 0.8, 0.8} or 
							isGM and {1, 0.65, 0.2} or
							{0.8, 0.8, 0.8}
			wipe(line)
			for i = 1, #Cols do
				if i == 1 then	-- Name
					line["text"] = val[i]
					line["justify"] = "LEFT"
					line["func"] = function() Guild_TabletClickFunc(val[7]) end
					line["size"] = 11 + resSizeExtra
				elseif i == 2 then	-- Level
					line["text"..i] = val[i]
					line["justify"..i] = "RIGHT"
					local uLevelColor = GetQuestDifficultyColor(val[2])
					line["text"..i.."R"] = uLevelColor.r
					line["text"..i.."G"] = uLevelColor.g
					line["text"..i.."B"] = uLevelColor.b
					line["size"..i] = 11 + resSizeExtra
				else	-- The rest
					line["text"..i] = val[i]
					line["justify"..i] = "LEFT"
					line["text"..i.."R"] = normColor[1]
					line["text"..i.."G"] = normColor[2]
					line["text"..i.."B"] = normColor[3]
					line["size"..i] = 11 + resSizeExtra
				end
			end
			GuildSection.guildCat:AddLine(line)
		end
		
		-- Hint
		Tablets.guild:SetHint(L["<Click> to whisper, <Alt+Click> to invite."])
	end
end

local function Guild_OnEnter(self)
	-- Register Tablets.guild
	if not Tablets.guild:IsRegistered(self) then
		Tablets.guild:Register(self,
			"children", function()
				Guild_UpdateTablet()
			end,
			"point", function()
				return "BOTTOMLEFT"
			end,
			"relativePoint", function()
				return "TOPLEFT"
			end,
			"maxHeight", db.other.tablets.maxheight,
			"clickable", true,
			"hideWhenEmpty", true
		)
	end
	
	if Tablets.guild:IsRegistered(self) then
		-- Tablets.guild appearance
		Tablets.guild:SetColor(self, 0, 0, 0)
		Tablets.guild:SetTransparency(self, .85)
		Tablets.guild:SetFontSizePercent(self, 1)
		
		-- Open
		if ( IsInGuild() and GuildOnline > 0 ) then
			GuildRoster()
		end
		Tablets.guild:Open(self)
		
		HideOtherGraphs(self)
	end
end

local function Guild_Update(self)
	-- If not in guild, set members to 0
	local guildonline = 0
	if not IsInGuild() then
		self.hidden = true
		self.text:SetText("")
		UpdateElementWidth(self)
		return
	end
	
	GuildTabletData = nil
	-- Total Online Guildies
	for i = 1, GetNumGuildMembers() do
		if ( not GuildTabletData or GuildTabletData == nil ) then GuildTabletData = {} end		
		local gPrelist
		local name, rank, _, lvl, _class, zone, note, offnote, online, status, class, _, _, mobile = GetGuildRosterInfo(i)
		
		-- Class Color
		local classColor = nibRealUI:GetClassColor(class, true) or {1, 1, 1}
		class = strform("|cff%02x%02x%02x%s|r", classColor[1] * 255, classColor[2] * 255, classColor[3] * 255, class)
		
		-- Player Name
		local cname
		if status == 0 then
			cname = strform("|cff%02x%02x%02x%s|r", classColor[1] * 255, classColor[2] * 255, classColor[3] * 255, name)
		else
			local curStatus = PlayerStatusValToStr[status] or ""
			cname = strform("%s |cff%02x%02x%02x%s|r", curStatus, classColor[1] * 255, classColor[2] * 255, classColor[3] * 255, name)
		end
		
		-- Mobile
		if mobile then
			cname = ChatFrame_GetMobileEmbeddedTexture(73/255, 177/255, 73/255)..cname
			zone = REMOTE_CHAT
		end
		
		-- Note
		if CanViewOfficerNote() then
			gPrelist = { cname, lvl, zone, rank, note, offnote, name }
		else
			gPrelist = { cname, lvl, zone, rank, note, " ", name }
		end
		
		-- Add to list
		if (online or mobile) then
			tinsert(GuildTabletData, gPrelist)
			guildonline = guildonline + 1
		end
	end
	
	-- OnEnter
	GuildOnline = guildonline
	if GuildOnline > 0 then
		self:SetScript("OnEnter", function(self) 
			Guild_OnEnter(self)
		end)
	else
		self:SetScript("OnEnter", nil)
	end
	
	-- Refresh tablet
	if Tablets.guild:IsRegistered(self) then
		Tablets.guild:Refresh(self)
	end
	
	-- Info Text
	self.hidden = false
	self.text:SetFormattedText("|cff%s%s|r|cff%s %d|r", TextColorHighlight, "G:", TextColorNormal, guildonline)
	UpdateElementWidth(self)
end

function Guild_OnMouseDown(self)
	if not InCombatLockdown() then
		ToggleGuildFrame()
	end
end

-- Meters
local function Meter_ButtonUpdate(self, shown)
	if not self.initialized then return end
	
	if shown then
		self.windowopen = true
	else
		self.windowopen = false
	end
	InfoLine:UpdateTextButtonColors()
end

local function Meter_Toggle(self)
	if not self.initialized then return end
	
	if not self.windowopen then
		if self.arecount then
			self.frecount.MainWindow:Show()
			self.frecount:RefreshMainWindow()
		end
		if self.askada then
			if not self.fskada:IsVisible() then
				Skada:ToggleWindow()
			end
		end
		Meter_ButtonUpdate(self, true)
		PlaySound("igMiniMapOpen")
	else
		if self.arecount then
			self.frecount.MainWindow:Hide()
		end
		if self.askada then
			if self.fskada:IsVisible() then
				Skada:ToggleWindow()
			end
		end
		Meter_ButtonUpdate(self, false)
		PlaySound("igMiniMapClose")
	end
end

local function Meter_Update(self)
	if not self.initialized then
		self.askada = IsAddOnLoaded("Skada")
		self.arecount = IsAddOnLoaded("Recount")
		self.fskada = _G.SkadaBarWindowSkada
		self.frecount = _G.Recount
		self.hidden = not((self.askada and self.fskada) or (self.arecount and self.frecount))
		self.initialized = true
	end
	
	if self.hidden then
		self.text:SetText("")
		UpdateElementWidth(self, true)
	else
		local SkadaOpen, RecountOpen
		if self.fskada then
			SkadaOpen = self.fskada:IsVisible()
		end
		if self.frecount then
			RecountOpen = self.frecount.MainWindow:IsVisible()
		end
		
		self.windowopen = SkadaOpen or RecountOpen

		InfoLine:UpdateTextButtonColors()
		
		self.text:SetText(L["Meters"])
		UpdateElementWidth(self)
	end
end

---- Layout Button
local function Layout_Update(self)
	local CurLayoutText = ndbc.layout.current == 1 and L["DPS/Tank"] or L["Healing"]
	local CurResText = ndbc.resolution == 1 and L["LR"]..":" or L["HR"]..":"
	self.text:SetText(CurResText..CurLayoutText)
	UpdateElementWidth(self)
end

---- Spec Button
local SpecEquipList = {}

local function SpecChangeClickFunc(self, ...)
	if ... then
		if GetActiveSpecGroup() == ... then return end
	end
	
	if GetNumSpecGroups() > 1 then
		local NewTG = GetActiveSpecGroup() == 1 and 2 or 1
		
		if NewTG == 1 then
			if dbc.specgear.primary > 0 then
				EquipmentManager_EquipSet(GetEquipmentSetInfo(dbc.specgear.primary))
			end
		else
			if dbc.specgear.secondary > 0 then
				EquipmentManager_EquipSet(GetEquipmentSetInfo(dbc.specgear.secondary))
			end
		end
		
		SetActiveSpecGroup(NewTG)
	end
end

local function SpecGearClickFunc(self, index, equipName)
	if not index then return end
	
	if IsShiftKeyDown() then
		if dbc.specgear.primary == index then
			dbc.specgear.primary = -1
		end
		if dbc.specgear.secondary == index then
			dbc.specgear.secondary = -1
		end
	elseif IsAltKeyDown() then
		dbc.specgear.secondary = index
	elseif IsControlKeyDown() then
		dbc.specgear.primary = index
	else
		EquipmentManager_EquipSet(equipName)
	end
	
	Tablets.spec:Refresh(self)
end

local function SpecAddEquipListToCat(self, cat)
	resSizeExtra = db.resolution[ndbc.resolution].tabfontsize
	local numSpecGroups = GetNumSpecGroups()
	
	-- Sets
	local line = {}
	if #SpecEquipList > 0 then
		for k, v in ipairs(SpecEquipList) do
			local _, _, _, isEquipped = GetEquipmentSetInfo(k)
			
			wipe(line)
			for i = 1, 4 do
				if i == 1 then
					line["text"] = strform("|T%s:%d:%d:%d:%d|t %s", SpecEquipList[k].icon, 11 + resSizeExtra, 11 + resSizeExtra, 0, 0, SpecEquipList[k].name)
					line["size"] = 11 + resSizeExtra
					line["justify"] = "LEFT"
					line["textR"] = 0.9
					line["textG"] = 0.9
					line["textB"] = 0.9
					line["hasCheck"] = true
					line["isRadio"] = true
					line["checked"] = isEquipped
					line["func"] = function() SpecGearClickFunc(self, k, SpecEquipList[k].name) end
					line["customwidth"] = 110
				elseif i == 2 then
					line["text"..i] = PRIMARY
					line["size"..i] = 11 + resSizeExtra
					line["justify"..i] = "LEFT"
					line["text"..i.."R"] = (dbc.specgear.primary == k) and db.colors.orange2[1] or 0.3
					line["text"..i.."G"] = (dbc.specgear.primary == k) and db.colors.orange2[2] or 0.3
					line["text"..i.."B"] = (dbc.specgear.primary == k) and db.colors.orange2[3] or 0.3
				elseif (i == 3) and (numSpecGroups > 1) then
					line["text"..i] = SECONDARY
					line["size"..i] = 11 + resSizeExtra
					line["justify"..i] = "LEFT"
					line["text"..i.."R"] = (dbc.specgear.secondary == k) and db.colors.orange2[1] or 0.3
					line["text"..i.."G"] = (dbc.specgear.secondary == k) and db.colors.orange2[2] or 0.3
					line["text"..i.."B"] = (dbc.specgear.secondary == k) and db.colors.orange2[3] or 0.3
				end
			end
			
			cat:AddLine(line)
		end
	end
end

local TalentInfo = {}
local function SpecAddTalentGroupLineToCat(self, cat, talentGroup)
	resSizeExtra = db.resolution[ndbc.resolution].tabfontsize
	
	local ActiveGroupColor = db.colors.orange2
	local InactiveColor = db.colors.disabled
	local ActiveSpecColor = db.colors.blue1
	
	local activeSpecGroup = GetActiveSpecGroup()
	local activeSpec = GetSpecialization()
	local id, name, description, icon, spec
	local defaultSpecTexture = "Interface\\Icons\\Ability_Marksmanship"
	local line = {}
	
	for i = 1, 2 do
		local GroupColor = (activeSpecGroup == talentGroup) and ActiveGroupColor or InactiveColor
		local SpecColor = (activeSpecGroup == talentGroup) and ActiveSpecColor or InactiveColor
		if i == 1 then
			line["text"] = talentGroup == 1 and PRIMARY or SECONDARY
			line["justify"] = "LEFT"
			line["size"] = 11 + resSizeExtra
			line["textR"] = GroupColor[1]
			line["textG"] = GroupColor[2]
			line["textB"] = GroupColor[3]
			line["hasCheck"] = true
			line["checked"] = activeSpecGroup == talentGroup
			line["isRadio"] = true
			line["func"] = function() SpecChangeClickFunc(self, talentGroup) end
			line["customwidth"] = 130
		elseif i == 2 then
			spec = GetSpecialization(false, false, talentGroup)
			if spec then
				id, name, description, icon = GetSpecializationInfo(spec)
			else
				id, name, description, icon = nil, NONE, nil, defaultSpecTexture
			end
			line["text"..i] = strform("|T%s:%d:%d:%d:%d|t %s", icon, 11 + resSizeExtra, 11 + resSizeExtra, 0, 0, name)
			line["justify"..i] = "LEFT"
			line["text"..i.."R"] = SpecColor[1]
			line["text"..i.."G"] = SpecColor[2]
			line["text"..i.."B"] = SpecColor[3]
			line["customwidth"..i] = 130
		end
	end
	cat:AddLine(line)
end

local SpecSection = {}
local function Spec_UpdateTablet(self)
	resSizeExtra = db.resolution[ndbc.resolution].tabfontsize
	local Cols, lineHeader
	
	local numSpecGroups = GetNumSpecGroups()
	
--	if (numSpecGroups > 1) and (GetSpecialization(false, false, 2)) then
		wipe(SpecSection)
	
		-- Spec Category
		SpecSection["specs"] = {}
		SpecSection["specs"].cat = Tablets.spec:AddCategory()
		SpecSection["specs"].cat:AddLine("text", SPECIALIZATION, "size", 13 + resSizeExtra, "textR", 1, "textG", 1, "textB", 1)
		
		-- Spec Cat
		SpecSection["specs"].talentCat = Tablets.spec:AddCategory("columns", 2)
		AddBlankTabLine(SpecSection["specs"].talentCat, 1)
		
		-- Primary Spec
		SpecAddTalentGroupLineToCat(self, SpecSection["specs"].talentCat, 1)
		
		-- Secondary Spec
		SpecAddTalentGroupLineToCat(self, SpecSection["specs"].talentCat, 2)
--	end
	
	local numEquipSets = GetNumEquipmentSets()
	if numEquipSets > 0 then
		if numSpecGroups > 1 then
			AddBlankTabLine(SpecSection["specs"].talentCat, 8)
		end
		
		-- Equipment Category
		SpecSection["equipment"] = {}
		SpecSection["equipment"].cat = Tablets.spec:AddCategory()
		SpecSection["equipment"].cat:AddLine("text", EQUIPMENT_MANAGER, "size", 13 + resSizeExtra, "textR", 1, "textG", 1, "textB", 1)
		AddBlankTabLine(SpecSection["equipment"].cat, 2)
		
		-- Equipment Cat
		SpecSection["equipment"].equipCat = Tablets.spec:AddCategory("columns", 3)
		AddBlankTabLine(SpecSection["equipment"].equipCat, 1)
		
		SpecAddEquipListToCat(self, SpecSection["equipment"].equipCat)
	end
	
	-- Hint
	if (numSpecGroups > 1) and (numEquipSets > 0) then
		Tablets.spec:SetHint(L["<Click> to change talent specs."].."\n"..L["<Equip Click> to equip."].."\n"..L["<Equip Ctl+Click> to assign to "]..PRIMARY..".\n"..L["<Equip Alt+Click> to assign to "]..SECONDARY..".\n"..L["<Equip Shift+Click> to unassign."])
	elseif numSpecGroups > 1 then
		Tablets.spec:SetHint(L["<Click> to change talent specs."])
	elseif numEquipSets > 0 then
		Tablets.spec:SetHint(L["<Equip Click> to equip."].."\n"..L["<Equip Ctl+Click> to assign to "]..PRIMARY.."\n"..L["<Equip Shift+Click> to unassign."])
	end
end

local function Spec_OnEnter(self)
	-- Register Tablets.spec
	if not Tablets.spec:IsRegistered(self) then
		Tablets.spec:Register(self,
			"children", function()
				Spec_UpdateTablet(self)
			end,
			"point", function()
				return "BOTTOMRIGHT"
			end,
			"relativePoint", function()
				return "TOPRIGHT"
			end,
			"maxHeight", db.other.tablets.maxheight,
			"clickable", true,
			"hideWhenEmpty", true
		)
	end
	
	if Tablets.spec:IsRegistered(self) then
		-- Tablets.spec appearance
		Tablets.spec:SetColor(self, 0, 0, 0)
		Tablets.spec:SetTransparency(self, .85)
		Tablets.spec:SetFontSizePercent(self, 1)
		
		-- Open
		Tablets.spec:Open(self)
		
		HideOtherGraphs(self)
	end
	
	self.mouseover = true
	self.text:SetTextColor(unpack(TextColorHighlightVals))
end

local function Spec_Update(self)
	resSizeExtra = db.resolution[ndbc.resolution].tabfontsize
	
	-- Talent Info
	wipe(TalentInfo)
	local numSpecGroups = GetNumSpecGroups()
	for i = 1, numSpecGroups do
		TalentInfo[i] = {}
		for t = 1, 3 do
			local _, _, _, specIcon, pointsSpent = GetSpecializationInfo(t, false, false, i)
			TalentInfo[i][t] = {
				points = pointsSpent,
				icon = specIcon,
			}
		end
	end
	
	-- Gear sets
	wipe(SpecEquipList)
	local numEquipSets = GetNumEquipmentSets()
	if numEquipSets > 0 then
		for index = 1, numEquipSets do
			local equipName, equipIcon = GetEquipmentSetInfo(index)
			SpecEquipList[index] = {
				name = equipName,
				icon = equipIcon,
			}
		end
	end
	if dbc.specgear.primary > numEquipSets then
		dbc.specgear.primary = -1
	end
	if dbc.specgear.secondary > numEquipSets then
		dbc.specgear.secondary = -1
	end
	
	-- Info text
	if (numSpecGroups > 1) then
		-- Active talent tree
		self.hidden = false
		if GetActiveSpecGroup() == 1 then
			self.text:SetText(PRIMARY)
			UpdateElementWidth(self)
		else
			self.text:SetText(SECONDARY)
			UpdateElementWidth(self)
		end
	elseif (numEquipSets > 0) then
		-- Plain Equip manager
		self.hidden = false
		self.text:SetText(EQUIPSET_EQUIP)
		UpdateElementWidth(self)
	else
		-- Hidden
		self.hidden = true
		self.text:SetText("")
		UpdateElementWidth(self, true)
	end
	
	-- Refresh Tablet
	if not self.hidden then
		if Tablets.spec:IsRegistered(self) then
			if Tablet20Frame:IsShown() then
				Tablets.spec:Refresh(self)
			end
		end
	end
end

---- SysInfo
local SysStats = {
	netTally = 0,
	bwIn = 		{cur = 0, tally = {}, avg = 0, min = 0, max = 0},
	bwOut = 	{cur = 0, tally = {}, avg = 0, min = 0, max = 0},
	lagHome = 	{cur = 0, tally = {}, avg = 0, min = 0, max = 0},
	lagWorld = 	{cur = 0, tally = {}, avg = 0, min = 0, max = 0},
	fpsTally = -5,
	fps = 		{cur = 0, tally = {}, avg = 0, min = 0, max = 0},
}

local SysSection = {}
local function SysInfo_UpdateTablet()
	resSizeExtra = db.resolution[ndbc.resolution].tabfontsize
	local Cols, lineHeader
	wipe(SysSection)
	
	-- Network Category
	SysSection["network"] = {}
	SysSection["network"].cat = Tablets.sysinfo:AddCategory()
	SysSection["network"].cat:AddLine("text", L["Network"], "size", 13 + resSizeExtra, "textR", 1, "textG", 1, "textB", 1)
	AddBlankTabLine(SysSection["network"].cat, 2)
	
	-- Lines
	Cols = {
		L["Stat"],
		L["Cur"],
		L["Max"],
		L["Min"],
		L["Avg"],
	}
	SysSection["network"].lineCat = Tablets.sysinfo:AddCategory("columns", #Cols)
	lineHeader = MakeTabletHeader(Cols, 10 + resSizeExtra, 12, {"LEFT", "RIGHT", "RIGHT", "RIGHT", "RIGHT"})
	SysSection["network"].lineCat:AddLine(lineHeader)
	AddBlankTabLine(SysSection["network"].lineCat, 1)
	
	local NetworkLines = {
		[1] = {L["In"], L["kbps"], "%.2f", SysStats.bwIn},
		[2] = {L["Out"], L["kbps"], "%.2f", SysStats.bwOut},
		[3] = {L["Home"], L["ms"], "%d", SysStats.lagHome},
		[4] = {L["World"], L["ms"], "%d", SysStats.lagWorld},
	}
	local line = {}
	for l = 1, #NetworkLines do
		wipe(line)
		for i = 1, #Cols do
			if i == 1 then
				line["text"] = strform("|cffe5e5e5%s|r |cff808080(%s)|r", NetworkLines[l][1], NetworkLines[l][2])
				line["justify"] = "LEFT"
				line["size"] = 11 + resSizeExtra
				line["indentation"] = 12.5
				line["customwidth"] = 90
			elseif i == 2 then
				line["text"..i] = strform(NetworkLines[l][3], NetworkLines[l][4].cur)
				line["justify"..i] = "RIGHT"
				line["text"..i.."R"] = 0.9
				line["text"..i.."G"] = 0.9
				line["text"..i.."B"] = 0.9
				line["indentation"..i] = 12.5
				line["customwidth"..i] = 30
			elseif i == 3 then
				line["text"..i] = strform(NetworkLines[l][3], NetworkLines[l][4].max)
				line["justify"..i] = "RIGHT"
				line["text"..i.."R"] = 0.7
				line["text"..i.."G"] = 0.7
				line["text"..i.."B"] = 0.7
				line["indentation"..i] = 12.5
				line["customwidth"..i] = 30
			elseif i == 4 then
				line["text"..i] = strform(NetworkLines[l][3], NetworkLines[l][4].min)
				line["justify"..i] = "RIGHT"
				line["text"..i.."R"] = 0.7
				line["text"..i.."G"] = 0.7
				line["text"..i.."B"] = 0.7
				line["indentation"..i] = 12.5
				line["customwidth"..i] = 30
			elseif i == 5 then
				line["text"..i] = strform(NetworkLines[l][3], NetworkLines[l][4].avg)
				line["justify"..i] = "RIGHT"
				line["text"..i.."R"] = 0.7
				line["text"..i.."G"] = 0.7
				line["text"..i.."B"] = 0.7
				line["indentation"..i] = 12.5
				line["customwidth"..i] = 30
			end
		end
		SysSection["network"].lineCat:AddLine(line)
	end
	AddBlankTabLine(SysSection["network"].lineCat, 4)
	
	-- Computer Category
	SysSection["computer"] = {}
	SysSection["computer"].cat = Tablets.sysinfo:AddCategory()
	SysSection["computer"].cat:AddLine("text", L["Computer"], "size", 13 + resSizeExtra, "textR", 1, "textG", 1, "textB", 1)
	AddBlankTabLine(SysSection["computer"].cat, 2)
	
	-- Lines
	Cols = {
		L["Stat"],
		L["Cur"],
		L["Max"],
		L["Min"],
		L["Avg"],
	}
	SysSection["computer"].lineCat = Tablets.sysinfo:AddCategory("columns", #Cols)
	lineHeader = MakeTabletHeader(Cols, 10 + resSizeExtra, 12, {"LEFT", "RIGHT", "RIGHT", "RIGHT", "RIGHT"})
	SysSection["computer"].lineCat:AddLine(lineHeader)
	AddBlankTabLine(SysSection["computer"].lineCat, 1)
	
	local ComputerLines = {
		[1] = {L["FPS"], SysStats.fps},
	}
	for l = 1, #ComputerLines do
		wipe(line)
		for i = 1, #Cols do
			if i == 1 then
				line["text"] = strform("|cffe5e5e5%s|r", ComputerLines[l][1])
				line["justify"] = "LEFT"
				line["size"] = 11 + resSizeExtra
				line["indentation"] = 12.5
				line["customwidth"] = 90
			elseif i == 2 then
				line["text"..i] = ComputerLines[l][2].cur
				line["justify"..i] = "RIGHT"
				line["text"..i.."R"] = 0.9
				line["text"..i.."G"] = 0.9
				line["text"..i.."B"] = 0.9
				line["indentation"..i] = 12.5
				line["customwidth"..i] = 30
			elseif i == 3 then
				line["text"..i] = ComputerLines[l][2].max
				line["justify"..i] = "RIGHT"
				line["text"..i.."R"] = 0.7
				line["text"..i.."G"] = 0.7
				line["text"..i.."B"] = 0.7
				line["indentation"..i] = 12.5
				line["customwidth"..i] = 30
			elseif i == 4 then
				line["text"..i] = ComputerLines[l][2].min
				line["justify"..i] = "RIGHT"
				line["text"..i.."R"] = 0.7
				line["text"..i.."G"] = 0.7
				line["text"..i.."B"] = 0.7
				line["indentation"..i] = 12.5
				line["customwidth"..i] = 30
			elseif i == 5 then
				line["text"..i] = ComputerLines[l][2].avg
				line["justify"..i] = "RIGHT"
				line["text"..i.."R"] = 0.7
				line["text"..i.."G"] = 0.7
				line["text"..i.."B"] = 0.7
				line["indentation"..i] = 12.5
				line["customwidth"..i] = 30
			end
		end
		SysSection["computer"].lineCat:AddLine(line)
	end
	AddBlankTabLine(SysSection["computer"].lineCat, 8)	-- Space for graph
end

local function SysInfo_OnLeave(self)
	if Tablets.sysinfo:IsRegistered(self) then
		Tablets.sysinfo:Close(self)
		HideGraph("fps")
	end
end

local function SysInfo_OnEnter(self)
	-- Register Tablets.sysinfo
	if not Tablets.sysinfo:IsRegistered(self) then
		Tablets.sysinfo:Register(self,
			"children", function()
				SysInfo_UpdateTablet()
			end,
			"point", function()
				return "BOTTOMRIGHT"
			end,
			"relativePoint", function()
				return "TOPRIGHT"
			end,
			"maxHeight", db.other.tablets.maxheight,
			"clickable", true,
			"hideWhenEmpty", true
		)
	end
	
	if Tablets.sysinfo:IsRegistered(self) then
		-- Tablets.sysinfo appearance
		Tablets.sysinfo:SetColor(self, 0, 0, 0)
		Tablets.sysinfo:SetTransparency(self, .85)
		Tablets.sysinfo:SetFontSizePercent(self, 1)
		
		Tablets.sysinfo:Open(self)
		
		ShowGraph("fps", Tablet20Frame, "BOTTOMRIGHT", "BOTTOMRIGHT", -10, 10, self)
		HideOtherGraphs(self)
	end
end

local function SysInfo_Update(self, short)
	if short then	
		-- FPS
		SysStats.fps.cur = floor((GetFramerate() or 0) + 0.5)
		
		-- Get last 60 second data
		if ( (SysStats.fps.cur > 0) and (SysStats.fps.cur < 120) ) then
			if SysStats.fpsTally < 0 then
				-- Skip first 5 seconds upon login
				SysStats.fpsTally = SysStats.fpsTally + 1
			else
				local fpsCount = 60
				if SysStats.fpsTally < fpsCount then
					-- fpsCount up to our 60-sec of total tallying
					SysStats.fpsTally = SysStats.fpsTally + 1
					SysStats.fps.tally[SysStats.fpsTally] = SysStats.fps.cur
					fpsCount = SysStats.fpsTally
				else
					-- Shift our tally table down by 1
					for i = 1, fpsCount - 1 do
						SysStats.fps.tally[i] = SysStats.fps.tally[i + 1]
					end
					SysStats.fps.tally[fpsCount] = SysStats.fps.cur
				end
				
				-- Get Average/Min/Max fps
				local minfps, maxfps, totalfps = nil, 0, 0
				for i = 1, fpsCount do
					totalfps = totalfps + SysStats.fps.tally[i]
					if not minfps then minfps = SysStats.fps.tally[i] else minfps = min(minfps, SysStats.fps.tally[i]) end
					maxfps = max(maxfps, SysStats.fps.tally[i])
				end
				SysStats.fps.avg = floor((totalfps / fpsCount) + 0.5)
				SysStats.fps.min = minfps
				SysStats.fps.max = maxfps
			end
		end
		
		-- Graph
		UpdateGraph("fps", SysStats.fps.tally)
	else
		-- Net
		SysStats.bwIn.cur, SysStats.bwOut.cur, SysStats.lagHome.cur, SysStats.lagWorld.cur = GetNetStats()
		SysStats.bwIn.cur = floor(SysStats.bwIn.cur * 100 + 0.5 ) / 100
		SysStats.bwOut.cur = floor(SysStats.bwOut.cur * 100 + 0.5 ) / 100
		
		-- Get last 60 net updates
		local netCount = 60
		if SysStats.netTally < netCount then
			-- Tally up to 60
			SysStats.netTally = SysStats.netTally + 1
			
			SysStats.bwIn.tally[SysStats.netTally] = SysStats.bwIn.cur
			SysStats.bwOut.tally[SysStats.netTally] = SysStats.bwOut.cur
			SysStats.lagHome.tally[SysStats.netTally] = SysStats.lagHome.cur
			SysStats.lagWorld.tally[SysStats.netTally] = SysStats.lagWorld.cur
			
			netCount = SysStats.netTally
		else
			-- Shift our tally table down by 1
			for i = 1, netCount - 1 do
				SysStats.bwIn.tally[i] = SysStats.bwIn.tally[i + 1]
				SysStats.bwOut.tally[i] = SysStats.bwOut.tally[i + 1]
				SysStats.lagHome.tally[i] = SysStats.lagHome.tally[i + 1]
				SysStats.lagWorld.tally[i] = SysStats.lagWorld.tally[i + 1]
			end
			-- Store new values
			SysStats.bwIn.tally[netCount] = SysStats.bwIn.cur
			SysStats.bwOut.tally[netCount] = SysStats.bwOut.cur
			SysStats.lagHome.tally[netCount] = SysStats.lagHome.cur
			SysStats.lagWorld.tally[netCount] = SysStats.lagWorld.cur
		end
		
		-- Get Average/Min/Max
		local minBwIn, maxBwIn, totalBwIn = nil, 0, 0
		local minBwOut, maxBwOut, totalBwOut = nil, 0, 0
		local minLagHome, maxLagHome, totalLagHome = nil, 0, 0
		local minLagWorld, maxLagWorld, totalLagWorld = nil, 0, 0
		
		for i = 1, netCount do
			totalBwIn = totalBwIn + SysStats.bwIn.tally[i]
			if not minBwIn then minBwIn = SysStats.bwIn.tally[i] else minBwIn = min(minBwIn, SysStats.bwIn.tally[i]) end
			maxBwIn = max(maxBwIn, SysStats.bwIn.tally[i])
			
			totalBwOut = totalBwOut + SysStats.bwOut.tally[i]
			if not minBwOut then minBwOut = SysStats.bwOut.tally[i] else minBwOut = min(minBwOut, SysStats.bwOut.tally[i]) end
			maxBwOut = max(maxBwOut, SysStats.bwOut.tally[i])
			
			totalLagHome = totalLagHome + SysStats.lagHome.tally[i]
			if not minLagHome then minLagHome = SysStats.lagHome.tally[i] else minLagHome = min(minLagHome, SysStats.lagHome.tally[i]) end
			maxLagHome = max(maxLagHome, SysStats.lagHome.tally[i])
			
			totalLagWorld = totalLagWorld + SysStats.lagWorld.tally[i]
			if not minLagWorld then minLagWorld = SysStats.lagWorld.tally[i] else minLagWorld = min(minLagWorld, SysStats.lagWorld.tally[i]) end
			maxLagWorld = max(maxLagWorld, SysStats.lagWorld.tally[i])
		end
		
		SysStats.bwIn.avg = floor((totalBwIn / netCount) * 100 + 0.5) / 100
		SysStats.bwIn.min = minBwIn
		SysStats.bwIn.max = maxBwIn
		
		SysStats.bwOut.avg = floor((totalBwOut / netCount) * 100 + 0.5) / 100
		SysStats.bwOut.min = minBwOut
		SysStats.bwOut.max = maxBwOut
		
		SysStats.lagHome.avg = floor((totalLagHome / netCount) + 0.5)
		SysStats.lagHome.min = minLagHome
		SysStats.lagHome.max = maxLagHome
		
		SysStats.lagWorld.avg = floor((totalLagWorld / netCount) + 0.5)
		SysStats.lagWorld.min = minLagWorld
		SysStats.lagWorld.max = maxLagWorld
	end
	
	-- Info Text
	self.text:SetFormattedText("|cff%s%d|r|cff%s%s|r  |cff%s%d|r|cff%s%s|r", TextColorNormal, SysStats.lagWorld.cur, TextColorHighlight, "ms", TextColorNormal, floor(SysStats.fps.cur + 0.5), TextColorHighlight, "fps")
	UpdateElementWidth(self)
	
	-- Tablet
	if Tablets.sysinfo:IsRegistered(self) then
		if Tablet20Frame:IsShown() then
			Tablets.sysinfo:Refresh(self)
		end
	end
end

---- Clock
local function Clock_StopPulse()
	if not(db.elements.clock) then return end
	
	ILFrames.clock.pulse:SetScript("OnUpdate", nil)
	ILFrames.clock.pulse:Hide()
	ILFrames.clock:SetAlpha(1)
	InfoLine:UpdatePositions()
end

local function Clock_StartPulse()
	if not(db.elements.clock) then return end
	
	ILFrames.clock.pulse.int = 1
	ILFrames.clock.pulse.elapsed = 0
	ILFrames.clock.pulse:Show()
	ILFrames.clock.pulse:SetScript("OnUpdate", function(self, elapsed)
		self.elapsed = self.elapsed - elapsed;
		if self.elapsed <= 0 then
			if pulsedown then
				UIFrameFadeOut(ILFrames.clock, self.int, ILFrames.clock:GetAlpha(), 0.25);
				pulsedown = false;
			else
				UIFrameFadeIn(ILFrames.clock, self.int, ILFrames.clock:GetAlpha(), 1);
				pulsedown = true;
			end
			self.elapsed = self.int
		end
	end)
end

local function Clock_Update(self, ...)
	-- Time
	local newTime
	if db.other.clock.uselocal then
		newTime = db.other.clock.hr24 and date("%H:%M") or date("%I:%M %p")
		if strsub(newTime, 1, 1) == "0" then
			newTime = strsub(newTime, 2)
		end
	else
		newTime = db.other.clock.hr24 and RetrieveGameTime() or RetrieveGameTime(true)
	end
	
	
	if ( WGTime ~= nil ) then
		if (WGTime == 300) and db.other.clock.wgalert then
			print(format("|cffff0000%s|r", L["5 minutes until Wintergrasp"]))
			
		end
	end
	if ( TBTime ~= nil ) and db.other.clock.tbalert then
		if TBTime == 300 then
			print(format("|cffff0000%s|r", L["5 minutes until Tol Barad"]))
		end
	end
	
	-- Calendar
	if ... and db.elements.clock then
		local pendingCalendarInvites = CalendarGetNumPendingInvites()
		if ( pendingCalendarInvites > self.pendingCalendarInvites ) then
			if ( not CalendarFrame or (CalendarFrame and not CalendarFrame:IsShown()) ) then
				self.flashing = true
				Clock_StartPulse()
				self.pendingCalendarInvites = pendingCalendarInvites
			end
		elseif ( pendingCalendarInvites == 0 ) then
			self.flashing = false
			Clock_StopPulse()
			self.pendingCalendarInvites = 0
		end
		GameTimeFrame_SetDate()
	end
	
	-- Info Text
	self.text:SetFormattedText("|cff%s%s|r", TextColorNormal, newTime)
	UpdateElementWidth(self)
end

local function Clock_OnEnter(self)
	local locTime = date("%H:%M")
	local serTime = RetrieveGameTime()
	local caltext = date("%b %d (%a)")

	local _, _, _, _, WGTime = GetWorldPVPAreaInfo(1)
	local _, _, _, _, TBTime = GetWorldPVPAreaInfo(2)
	
	-- Wintergrasp
	if ( WGTime ~= nil ) then
		WGTime = ConvertSecondstoTime(WGTime)
	else
		WGTime = L["No Wintergrasp Time Available"]
	end

	-- Tol Barad
	if ( TBTime ~= nil ) then
		TBTime = ConvertSecondstoTime(TBTime)
	else
		TBTime = L["No Tol Barad Time Available"]
	end

	GameTooltip:SetOwner(self, "ANCHOR_TOP"..self.side, 0, 2)
	GameTooltip:AddLine(strform("|cff%s%s|r", TextColorTTHeader, TIMEMANAGER_TOOLTIP_TITLE))
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(strform("|cff%s%s|r", TextColorOrange2, TIMEMANAGER_TOOLTIP_REALMTIME), strform("%s", serTime), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
	GameTooltip:AddDoubleLine(strform("|cff%s%s|r", TextColorOrange2, TIMEMANAGER_TOOLTIP_LOCALTIME), strform("%s", locTime), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
	GameTooltip:AddDoubleLine(strform("|cff%s%s:|r", TextColorOrange2, L["Date"]), caltext, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
	GameTooltip:AddLine(" ")
	if ( WGTime ~= nil ) then
		GameTooltip:AddDoubleLine(strform("|cff%s%s|r", TextColorOrange2, L["Wintergrasp Time Left"]), strform("%s", WGTime), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
	else
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorOrange2, L["No Wintergrasp Time Available"]))
	end
	if ( TBTime ~= nil ) then
		GameTooltip:AddDoubleLine(strform("|cff%s%s|r", TextColorOrange2, L["Tol Barad Time Left"]), strform("%s", TBTime), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
	else
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorOrange2, L["No Tol Barad Time Available"]))
	end
	GameTooltip:AddLine(" ")
	if self.pendingCalendarInvites > 0 then
		GameTooltip:AddDoubleLine(strform("|cff%s%s|r", TextColorOrange2, L["Pending Invites:"]), strform("%s", self.pendingCalendarInvites), 0.9, 0.9, 0.9, 0.9, 0.9, 0.9)
		GameTooltip:AddLine(" ")
	end
	GameTooltip:AddLine(strform("|cff00ff00%s|r", L["<Click> to show calendar."]))
	GameTooltip:AddLine(strform("|cff00ff00%s|r", L["<Shift+Click> to show timer."]))
	GameTooltip:Show()
end

local function Clock_OnMouseDown(self)
	if IsShiftKeyDown() then
		ToggleTimeManager()
	else
		if IsAddOnLoaded("GroupCalendar5") and SlashCmdList.CAL then
			SlashCmdList.CAL("show")
		else
			ToggleCalendar()
		end
	end
end

---- Text Functions
function InfoLine:Text_OnLeave(self)
	if GameTooltip:IsShown() then GameTooltip:Hide() end
end

-------------
-- Buttons --
-------------
---- MM Button Functions
function InfoLine:UpdateMMButtonColors(...)
	local i1, i2 = ... or 1, ... or 12
	for i = i1, i2 do
		local newcolors
		if not ILFrames.micromenu.buttons[i].disabled then
			if ILFrames.micromenu.buttons[i].highlight or ILFrames.micromenu.buttons[i].windowopen then
				-- Highlight
				newcolors = TextColorHighlightVals
			else
				-- Normal
				newcolors = TextColorNormalVals
			end
		else	-- Disable
			newcolors = TextColorDisabledVals
		end
		if ILFrames.micromenu.buttons[i] ~= nil then
			ILFrames.micromenu.buttons[i].text:SetTextColor(unpack(newcolors))
		end
	end
end

function InfoLine:UpdateMMButtonState()
	local playerLevel = UnitLevel("player")
	local factionGroup = UnitFactionGroup("player")
	
	-- Character
	if CharacterFrame:IsShown() then
		ILFrames.micromenu.buttons[MMIDs.Char].windowopen = true
	else
		ILFrames.micromenu.buttons[MMIDs.Char].windowopen = false
	end
	
	-- SpellBook
	if SpellBookFrame:IsShown() then
		ILFrames.micromenu.buttons[MMIDs.SpellBook].windowopen = true
	else
		ILFrames.micromenu.buttons[MMIDs.SpellBook].windowopen = false
	end

	-- Talents
	if PlayerTalentFrame and PlayerTalentFrame:IsShown() then
		ILFrames.micromenu.buttons[MMIDs.Talents].windowopen = true
	else
		if (playerLevel < SHOW_SPEC_LEVEL) then
			ILFrames.micromenu.buttons[MMIDs.Talents].disabled = true
		else
			ILFrames.micromenu.buttons[MMIDs.Talents].disabled = false
			ILFrames.micromenu.buttons[MMIDs.Talents].windowopen = false
		end
	end
	
	-- Achievements
	if AchievementFrame and AchievementFrame:IsShown() then
		ILFrames.micromenu.buttons[MMIDs.Achievements].windowopen = true
	else
		if (HasCompletedAnyAchievement() or IsInGuild()) and CanShowAchievementUI() then
			ILFrames.micromenu.buttons[MMIDs.Achievements].disabled = false
			ILFrames.micromenu.buttons[MMIDs.Achievements].windowopen = false			
		else
			ILFrames.micromenu.buttons[MMIDs.Achievements].disabled = true
		end
	end

	-- QuestLog
	if QuestLogFrame and QuestLogFrame:IsShown() then
		ILFrames.micromenu.buttons[MMIDs.QuestLog].windowopen = true
	else
		ILFrames.micromenu.buttons[MMIDs.QuestLog].windowopen = false
	end
	
	-- Social
	if FriendsFrame and FriendsFrame:IsShown() then
		ILFrames.micromenu.buttons[MMIDs.Social].windowopen = true
	else
		ILFrames.micromenu.buttons[MMIDs.Social].windowopen = false
	end
	
	-- Guild
	if ( IsTrialAccount() or factionGroup == "Neutral" ) then
		ILFrames.micromenu.buttons[MMIDs.Guild].disabled = true
	elseif (GuildFrame and GuildFrame:IsShown()) or (LookingForGuildFrame and LookingForGuildFrame:IsShown()) then
		ILFrames.micromenu.buttons[MMIDs.Guild].windowopen = true
	else
		ILFrames.micromenu.buttons[MMIDs.Guild].disabled = false
		ILFrames.micromenu.buttons[MMIDs.Guild].windowopen = false
	end
	
	-- PvP
	if PVPFrame and PVPFrame:IsShown() then
		ILFrames.micromenu.buttons[MMIDs.PvP].windowopen = true
	else
		if playerLevel < PVPMicroButton.minLevel or factionGroup == "Neutral" then
			ILFrames.micromenu.buttons[MMIDs.PvP].disabled = true
		else
			ILFrames.micromenu.buttons[MMIDs.PvP].disabled = false
			ILFrames.micromenu.buttons[MMIDs.PvP].windowopen = false
		end
	end	

	-- LFD
	if PVEFrame and PVEFrame:IsShown() then
		ILFrames.micromenu.buttons[MMIDs.LFD].windowopen = true
	else
		if playerLevel < LFDMicroButton.minLevel or factionGroup == "Neutral" then
			ILFrames.micromenu.buttons[MMIDs.LFD].disabled = true
		else
			ILFrames.micromenu.buttons[MMIDs.LFD].disabled = false
			ILFrames.micromenu.buttons[MMIDs.LFD].windowopen = false
		end
	end
	
--[[	-- LFR
	if ( RaidParentFrame:IsShown() ) then
		ILFrames.micromenu.buttons[MMIDs.LFR].windowopen = true
	else
		if playerLevel < RaidMicroButton.minLevel then
			ILFrames.micromenu.buttons[MMIDs.LFR].disabled = true
		else
			ILFrames.micromenu.buttons[MMIDs.LFR].disabled = false
			ILFrames.micromenu.buttons[MMIDs.LFR].windowopen = false
		end
	end]]

	-- Mounts & Pets
	if PetJournalParent and PetJournalParent:IsShown() then
		ILFrames.micromenu.buttons[MMIDs.MountsPets].windowopen = true
	else
		ILFrames.micromenu.buttons[MMIDs.MountsPets].disabled = false
		ILFrames.micromenu.buttons[MMIDs.MountsPets].windowopen = false
	end

	-- EJ
	if EncounterJournal and EncounterJournal:IsShown() then
		ILFrames.micromenu.buttons[MMIDs.DJ].windowopen = true
	else
		ILFrames.micromenu.buttons[MMIDs.DJ].disabled = false
		ILFrames.micromenu.buttons[MMIDs.DJ].windowopen = false
	end

	-- Help Request
	if HelpFrame:IsShown() then
		ILFrames.micromenu.buttons[MMIDs.Help].windowopen = true
	else
		ILFrames.micromenu.buttons[MMIDs.Help].windowopen = false
	end
	
	-- Update Buttons with new information
	InfoLine:UpdateMMButtonColors()
end

function InfoLine:MMButton_OnLeave(button)
	ILFrames.micromenu.buttons[button].highlight = false
	InfoLine:UpdateMMButtonColors(button)
	
	if GameTooltip:IsShown() then GameTooltip:Hide() end
end

function InfoLine:MMButton_OnEnter(button)
	ILFrames.micromenu.buttons[button].highlight = true
	InfoLine:UpdateMMButtonColors(button)
	
	local tt, tto = "", nil
	tto = ILFrames.micromenu.buttons[button]
	if button == MMIDs.Char then
		tt = MicroButtonTooltipText(CHARACTER_BUTTON, "TOGGLECHARACTER0")
	elseif button == MMIDs.SpellBook then
		tt = MicroButtonTooltipText(SPELLBOOK_ABILITIES_BUTTON, "TOGGLESPELLBOOK")
	elseif button == MMIDs.Talents then
		tt = MicroButtonTooltipText(TALENTS_BUTTON, "TOGGLETALENTS")
	elseif button == MMIDs.Achievements then
		tt = MicroButtonTooltipText(ACHIEVEMENT_BUTTON, "TOGGLEACHIEVEMENT")
	elseif button == MMIDs.QuestLog then
		tt = MicroButtonTooltipText(QUESTLOG_BUTTON, "TOGGLEQUESTLOG")
	elseif button == MMIDs.Social then
		tt = MicroButtonTooltipText(SOCIAL_BUTTON, "TOGGLESOCIAL")
	elseif button == MMIDs.Guild then
		if ( IsInGuild() ) then
			tt = MicroButtonTooltipText(GUILD, "TOGGLEGUILDTAB")
		else
			tt = MicroButtonTooltipText(LOOKINGFORGUILD, "TOGGLEGUILDTAB");
		end
	elseif button == MMIDs.PvP then
		tt = MicroButtonTooltipText(PLAYER_V_PLAYER, "TOGGLECHARACTER4")
	elseif button == MMIDs.LFD then
		tt = MicroButtonTooltipText(DUNGEONS_BUTTON, "TOGGLELFGPARENT")
	elseif button == MMIDs.LFR then
		tt = MicroButtonTooltipText(RAID_FINDER, "TOGGLERAIDFINDER")
	elseif button == MMIDs.MountsPets then
		tt = MicroButtonTooltipText(MOUNTS_AND_PETS, "TOGGLEPETJOURNAL")
	elseif button == MMIDs.DJ then
		tt = MicroButtonTooltipText(ENCOUNTER_JOURNAL, "TOGGLEENCOUNTERJOURNAL")
	elseif button == MMIDs.Help then
		tt = HELP_BUTTON
	end
	GameTooltip:SetOwner(tto, "ANCHOR_TOP"..ILFrames.micromenu.side, 0, 2)
	GameTooltip_AddNewbieTip(tto, tt, 1.0, 1.0, 1.0, "")
	GameTooltip:Show()
end

---- Text Button Functions
function InfoLine:UpdateTextButtonColors()
	-- Spec Button
	if ILFrames.spec.mouseover then
		ILFrames.spec.text:SetTextColor(unpack(TextColorHighlightVals))
	else
		ILFrames.spec.text:SetTextColor(unpack(TextColorNormalVals))
	end
	-- Layout Button
	if ILFrames.layout.mouseover then
		ILFrames.layout.text:SetTextColor(unpack(TextColorHighlightVals))
	else
		ILFrames.layout.text:SetTextColor(unpack(TextColorNormalVals))
	end
	-- Meters Button
	if ILFrames.meter.windowopen or ILFrames.meter.mouseover then
		ILFrames.meter.text:SetTextColor(unpack(TextColorHighlightVals))
	else
		ILFrames.meter.text:SetTextColor(unpack(TextColorNormalVals))
	end
end

function InfoLine:TextButton_OnMouseDown(self)
	if self.tag == "spec" then
		-- Spec Button
		SpecChangeClickFunc(self)
	elseif self.tag == "layout" then
		-- Layout Button
		if IsAltKeyDown() then
			if InCombatLockdown() then
				print("|cff00ffffRealUI:|r You can not change the Resolution Layout during combat. Please leave combat and try again.")
			else
				local NewRes = ndbc.resolution == 1 and 2 or 1
				ndbg.resolution = NewRes
				ndbc.resolution = NewRes
				nibRealUICharacter.resolution = NewRes
				nibRealUI:UpdateResolution()
			end
			Layout_Update(self)
		else
			local NewLayout = ndbc.layout.current == 1 and 2 or 1
			ndbc.layout.current = NewLayout
			nibRealUI:UpdateLayout()
		end
	elseif self.tag == "meter" then
		-- Meter Button
		Meter_Toggle(self)
	end
end

function InfoLine:TextButton_OnLeave(self)
	-- Unhighlight
	self.mouseover = false
	if not self.windowopen then
		self.text:SetTextColor(unpack(TextColorNormalVals))
	end
	if GameTooltip:IsShown() then GameTooltip:Hide() end
end

function InfoLine:TextButton_OnEnter(self)
	-- Highlight
	self.mouseover = true
	self.text:SetTextColor(unpack(TextColorHighlightVals))
	
	if self.tag == "layout" then
		-- Layout Button
		local CurLayoutText = ndbc.layout.current == 1 and "DPS/Tank" or "Healing"
		local CurResText = ndbc.resolution == 1 and "Low" or "High"
		GameTooltip:SetOwner(self, "ANCHOR_TOP"..self.side, 0, 2)
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorTTHeader, L["Layout Changer"]))
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(strform("|cff%s%s |r|cff%s%s|r", TextColorOrange2, L["Current Layout:"], TextColorWhite, CurLayoutText))
		GameTooltip:AddLine(strform("|cff%s%s |r|cff%s%s|r", TextColorOrange2, L["Current Resolution:"], TextColorWhite, CurResText))
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorBlue1, L["Resolution Note:"]))
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorWhite, L["Different Resolutions are designed to better"]))
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorWhite, L["optimize RealUI for your current screen size."]))
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorBlue1, L["Minimum Screen Sizes:"]))
		GameTooltip:AddLine(strform("|cff%s%s |r|cff%s%s|r", TextColorOrange2, L["Low Res:"], TextColorWhite, "1280 x 768"))
		GameTooltip:AddLine(strform("|cff%s%s |r|cff%s%s|r", TextColorOrange2, L["High Res:"], TextColorWhite, "1280 x 900"))
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(strform("|cff00ff00%s|r", L["<Click> to change layouts."]))
		GameTooltip:AddLine(strform("|cff00ff00%s|r", L["<Alt+Click> to change resolution."]))
		GameTooltip:Show()
		
		-- Tip
		ILFrames.layout.tip:Hide()
		ndbg.tags.layouttip = false
	elseif self.tag == "meter" then
		-- Meter Button
		GameTooltip:SetOwner(self, "ANCHOR_TOP"..self.side, 0, 2)
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorTTHeader, L["Meter Toggle"]))
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorOrange2, L["Active Meters:"]))
		if IsAddOnLoaded("Recount") then
			GameTooltip:AddLine(strform("|cff%s%s|r", TextColorWhite, "Recount"))
		end
		if IsAddOnLoaded("Skada") then
			GameTooltip:AddLine(strform("|cff%s%s|r", TextColorWhite, "Skada"))
		end
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(strform("|cff00ff00%s|r", L["<Click> to toggle meters."]))
		GameTooltip:Show()
	end
end

---- Icon Button Functions
function InfoLine:UpdateIconButtonColors()
	-- Options Button
	if ILFrames.options.mouseover then
		ILFrames.options.icon:SetVertexColor(unpack(TextColorHighlightVals))
	else
		ILFrames.options.icon:SetVertexColor(unpack(TextColorNormalVals))
	end
end

function InfoLine:IconButton_OnMouseDown(self)
	if self.tag == "options" then
		-- Options Button
		nibRealUI:OpenOptions()
	end
end

function InfoLine:IconButton_OnLeave(self)
	-- Unhighlight
	self.mouseover = false
	self.icon:SetVertexColor(unpack(TextColorNormalVals))
	if GameTooltip:IsShown() then GameTooltip:Hide() end
end

function InfoLine:IconButton_OnEnter(self)
	-- Highlight
	self.mouseover = true
	self.icon:SetVertexColor(unpack(TextColorHighlightVals))
	
	if self.tag == "options" then
		-- Options Button
		GameTooltip:SetOwner(self, "ANCHOR_TOP"..self.side, 0, -1)
		GameTooltip:AddLine(strform("|cff%s%s|r", TextColorTTHeader, L["RealUI Options"]))
		GameTooltip:AddLine(strform("%s", nibRealUI:GetVerString(true)))
		GameTooltip:Show()
	end
end

-------------------
-- Frame Updates --
-------------------
-- Font
function InfoLine:UpdateFont()
	local ShadowX, ShadowY = 1, -1
	if db.text.outline ~= "NONE" then
		ShadowX, ShadowY = 0, 0
	end
	
	-- Text frames
	for i,v in pairs(ILFrames) do
		if ILFrames[i].text then
			ILFrames[i].text:SetFont(unpack(nibRealUI.font.pixel1))
			ILFrames[i].text:SetShadowOffset(ShadowX, ShadowY)
			UpdateElementWidth(ILFrames[i])
		end
	end
	
	-- Micro Menu
	for i = 1, 11 do
		ILFrames.micromenu.buttons[i].text:SetFont(unpack(nibRealUI.font.pixel1))
		ILFrames.micromenu.buttons[i].text:SetShadowOffset(ShadowX, ShadowY)
	end
end

-- Textures
function InfoLine:UpdateTextures()
	-- Options Button
	ILFrames.options.icon:SetTexture(db.resolution[ndbc.resolution].configicon)
end

-- Positions
local function SetPosition(info, parent, anchor, x, y, height, width)
	info:ClearAllPoints()
	info:SetPoint(anchor, parent, anchor, x, y)
	if width ~= nil then
		info:SetWidth(width)
		info:SetHeight(height)
		if info.text then
			local xt = info.side == "LEFT" and (db.position.xgap / 2) or -(db.position.xgap / 2)
			info.text:ClearAllPoints()
			info.text:SetPoint(info.side, info, info.side, xt, 0)
		end
	end
end

function InfoLine:UpdateMMPositions()
	local XPos = 0
	local EHeight = nibRealUI.font.pixel1[2] + 2
	local EWidth = nibRealUI.font.pixel1[2] + db.resolution[ndbc.resolution].micromenupadding
	
	for i = 1, 12 do
		ILFrames.micromenu.buttons[i]:SetPoint("BOTTOMLEFT", ILFrames.micromenu, "BOTTOMLEFT", XPos, 0)
		ILFrames.micromenu.buttons[i]:SetHeight(EHeight + 2)
		ILFrames.micromenu.buttons[i]:SetWidth(EWidth)
		XPos = XPos + EWidth
	end
	
	ILFrames.micromenu.curwidth = XPos + db.position.xgap - 2
end

local AlreadyUpdating

local HookedFrames = {}
local function FinalizeCustomFrame(f, index)
	if not HookedFrames[name] then
		hooksecurefunc(f, "SetWidth", function()
			if not AlreadyUpdating then
				InfoLine:UpdatePositions()
			end
		end)
		HookedFrames[name] = true
	end

	-- Try to fix up text
	for i= 1, f:GetNumRegions() do
		local region = select(i, f:GetRegions())
		if region:GetObjectType() == "FontString" then
			f.text = region
			break
		end
	end
	if f.text then
		local fontName, fontHeight = f.text:GetFont()
		f.text:SetFont(fontName, fontHeight, nibRealUI.font.pixel1[3])
	end
end

function InfoLine:UpdatePositions()
	if InCombatLockdown() then
		-- In combat, set flag so we can refresh once combat ends
		NeedRefreshed = true
		return
	end
	
	if AlreadyUpdating then return end
	AlreadyUpdating = true
	
	local XPos = 0
	local EHeight = nibRealUI.font.pixel1[2] + 2
	
	-- Parent
	ILFrames.parent:ClearAllPoints()
	ILFrames.parent:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT",  db.position.xl, db.position.y)
	ILFrames.parent:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT",  -db.position.xr, db.position.y)
	ILFrames.parent:SetHeight(20)
	
	---- LEFT
	-- Options Button
	if db.elements.options then
		ILFrames.options:Show()
		SetPosition(ILFrames.options, ILFrames.parent, "BOTTOMLEFT", XPos, db.iconbuttons.yoffset, db.iconbuttons.size, db.iconbuttons.size)
		XPos = XPos + ILFrames.options:GetWidth() + 4
	else
		ILFrames.options:Hide()
	end
	
	-- Micro Menu
	if db.elements.micromenu then
		ILFrames.micromenu:Show()
		InfoLine:UpdateMMPositions()
		SetPosition(ILFrames.micromenu, ILFrames.parent, "BOTTOMLEFT", XPos, db.text.yoffset, EHeight + 2, ILFrames.micromenu.curwidth)
		XPos = XPos + ILFrames.micromenu.curwidth
	else
		ILFrames.micromenu:Hide()
	end
	
	-- Guild
	if db.elements.guild and not(ILFrames.guild.hidden) then
		ILFrames.guild:Show()
		SetPosition(ILFrames.guild, ILFrames.parent, "BOTTOMLEFT", XPos, db.text.yoffset, EHeight, ILFrames.guild.curwidth)
		XPos = XPos + ILFrames.guild.curwidth
	else
		ILFrames.guild:Hide()
	end
	
	-- Friends
	if db.elements.friends then
		ILFrames.friends:Show()
		SetPosition(ILFrames.friends, ILFrames.parent, "BOTTOMLEFT", XPos, db.text.yoffset, EHeight, ILFrames.friends.curwidth)
		XPos = XPos + ILFrames.friends.curwidth
	else
		ILFrames.friends:Hide()
	end
	
	-- Durability
	if db.elements.durability then
		ILFrames.durability:Show()
		SetPosition(ILFrames.durability, ILFrames.parent, "BOTTOMLEFT", XPos, db.text.yoffset, EHeight, ILFrames.durability.curwidth)
		XPos = XPos + ILFrames.durability.curwidth
	else
		ILFrames.durability:Hide()
	end
	
	-- Bag
	if db.elements.bag then
		ILFrames.bag:Show()
		SetPosition(ILFrames.bag, ILFrames.parent, "BOTTOMLEFT", XPos, db.text.yoffset, EHeight, ILFrames.bag.curwidth)
		XPos = XPos + ILFrames.bag.curwidth
	else
		ILFrames.bag:Hide()
	end
	
	-- Currency
	if db.elements.currency then
		ILFrames.currency:Show()
		SetPosition(ILFrames.currency, ILFrames.parent, "BOTTOMLEFT", XPos, db.text.yoffset, EHeight, ILFrames.currency.curwidth)
		XPos = XPos + ILFrames.currency.curwidth
	else
		ILFrames.currency:Hide()
	end
	
	-- XP/Rep
	if db.elements.xprep and not(ILFrames.xr.hidden) then
		ILFrames.xr:Show()
		SetPosition(ILFrames.xr, ILFrames.parent, "BOTTOMLEFT", XPos, db.text.yoffset, EHeight, ILFrames.xr.curwidth)
		XPos = XPos + ILFrames.xr.curwidth
	else
		ILFrames.xr:Hide()
	end
	
	-- Custom
	for k, v in ipairs(db.customframes) do
		if v ~= nil then
			if v[2] == "LEFT" then
				local f = _G[v[1]]
				if f then
					SetPosition(f, ILFrames.parent, "BOTTOMLEFT", XPos, db.text.yoffset + v[3], EHeight, nil)
					XPos = XPos + f:GetWidth()
					FinalizeCustomFrame(f, v[1])
				end
			end
		end
	end
	
	---- RIGHT
	XPos = 0
	-- Clock
	if db.elements.clock then
		ILFrames.clock:Show()
		SetPosition(ILFrames.clock, ILFrames.parent, "BOTTOMRIGHT", XPos, db.text.yoffset, EHeight, ILFrames.clock.curwidth)
		XPos = XPos - ILFrames.clock.curwidth
	else
		ILFrames.clock:Hide()
	end
	
	-- SysInfo
	if db.elements.sysinfo then
		ILFrames.sysinfo:Show()
		SetPosition(ILFrames.sysinfo, ILFrames.parent, "BOTTOMRIGHT", XPos, db.text.yoffset, EHeight, ILFrames.sysinfo.curwidth)
		XPos = XPos - ILFrames.sysinfo.curwidth
	else
		ILFrames.sysinfo:Hide()
	end
	
	-- Spec Button
	if db.elements.specchanger and not(ILFrames.spec.hidden) then
		ILFrames.spec:Show()
		SetPosition(ILFrames.spec, ILFrames.parent, "BOTTOMRIGHT", XPos, db.text.yoffset, EHeight, ILFrames.spec.curwidth)
		XPos = XPos - ILFrames.spec.curwidth
	else
		ILFrames.spec:Hide()
	end
	
	-- Layout Button
	if db.elements.layoutchanger then
		ILFrames.layout:Show()
		SetPosition(ILFrames.layout, ILFrames.parent, "BOTTOMRIGHT", XPos, db.text.yoffset, EHeight, ILFrames.layout.curwidth)
		XPos = XPos - ILFrames.layout.curwidth
	else
		ILFrames.layout:Hide()
	end
	
	-- Meter Button
	if db.elements.metertoggle and not(ILFrames.meter.hidden) then
		ILFrames.meter:Show()
		SetPosition(ILFrames.meter, ILFrames.parent, "BOTTOMRIGHT", XPos, db.text.yoffset, EHeight, ILFrames.meter.curwidth)
		XPos = XPos - ILFrames.meter.curwidth
	else
		ILFrames.meter:Hide()
	end
	
	-- Custom
	for k, v in ipairs(db.customframes) do
		if v ~= nil then
			if v[2] == "RIGHT" then
				local f = _G[v[1]]
				if f then
					SetPosition(f, ILFrames.parent, "BOTTOMRIGHT", XPos, db.text.yoffset + v[3], EHeight, nil)
					XPos = XPos - f:GetWidth()
					FinalizeCustomFrame(f, v[1])
				end
			end
		end
	end
	
	AlreadyUpdating = false
end

--------------------
-- Frame Creation --
--------------------
local function CreateTipFrame(parent, width, height, header, body)
	local NewTF = CreateFrame("Frame", nil, parent, "GlowBoxTemplate")
	NewTF:Hide()
	NewTF:SetPoint("BOTTOM", parent, "TOP", 0, 20)
	NewTF:SetWidth(width)
	NewTF:SetHeight(height)
	
	NewTF.header = NewTF:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
	NewTF.header:SetPoint("TOP", NewTF, "TOP", 0, -6)
	NewTF.header:SetText(header)
	
	NewTF.body = NewTF:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
	NewTF.body:SetPoint("TOP", NewTF.header, "BOTTOM", 0, -6)
	NewTF.body:SetText(body)
	
	NewTF.arrow = CreateFrame("Frame", nil, NewTF, "GlowBoxArrowTemplate")
	NewTF.arrow:SetPoint("TOP", NewTF, "BOTTOM", 0, 4)
	
	return NewTF
end

local function CreateMicroMenuFrame(side)
	local NewMM = CreateFrame("Frame", nil, UIParent)
	NewMM.side = side
	
	NewMM:SetFrameStrata(ILFrames.parent:GetFrameStrata())
	NewMM:SetFrameLevel(ILFrames.parent:GetFrameLevel() + 1)
	
	-- Buttons
	NewMM.buttons = {}
	for i,v in ipairs(MMButtonTable) do
		NewMM.buttons[i] = CreateFrame("Button", "RealUI_InfoLine_MM_"..v, NewMM, "SecureActionButtonTemplate")
		NewMM.buttons[i]:SetAttribute("type", "click")
		NewMM.buttons[i].highlight = false
		NewMM.buttons[i].windowopen = false
		NewMM.buttons[i].disabled = false
		
		NewMM.buttons[i].text = NewMM.buttons[i]:CreateFontString()
		NewMM.buttons[i].text:SetPoint("CENTER", NewMM.buttons[i], "CENTER", 0.5, -1.5)
		NewMM.buttons[i].text:SetFont(unpack(nibRealUI.font.pixel1))
		NewMM.buttons[i].text:SetText(MMButtonTexts[i])
		
		NewMM.buttons[i]:SetScript("OnEnter", function() InfoLine:MMButton_OnEnter(i) end)
		NewMM.buttons[i]:SetScript("OnLeave", function() InfoLine:MMButton_OnLeave(i) end)	
	end

	-- Set Macro texts
	NewMM.buttons[1]:SetAttribute("type", "macro")
	NewMM.buttons[1]:SetAttribute("macrotext", "/run ToggleCharacter('PaperDollFrame')")
	NewMM.buttons[2]:SetAttribute("clickbutton", SpellbookMicroButton)
	NewMM.buttons[3]:SetAttribute("clickbutton", TalentMicroButton)
	NewMM.buttons[4]:SetAttribute("clickbutton", AchievementMicroButton)
	NewMM.buttons[5]:SetAttribute("clickbutton", QuestLogMicroButton)
	NewMM.buttons[6]:SetAttribute("clickbutton", FriendsMicroButton)
	NewMM.buttons[7]:SetAttribute("clickbutton", GuildMicroButton)
	NewMM.buttons[8]:SetAttribute("type", "macro")
	NewMM.buttons[8]:SetAttribute("macrotext", "/run TogglePVPFrame()")
	NewMM.buttons[9]:SetAttribute("clickbutton", LFDMicroButton)
--	NewMM.buttons[10]:SetAttribute("clickbutton", RaidMicroButton)
	NewMM.buttons[10]:SetAttribute("clickbutton", CompanionsMicroButton)
	NewMM.buttons[11]:SetAttribute("clickbutton", EJMicroButton)
	NewMM.buttons[12]:SetAttribute("clickbutton", HelpMicroButton)
	
	return NewMM
end

local function CreateTextButtonFrame(side)
	local NewButton = CreateFrame("Frame", nil, UIParent)
	NewButton.side = side
	
	NewButton:SetFrameStrata(ILFrames.parent:GetFrameStrata())
	NewButton:SetFrameLevel(ILFrames.parent:GetFrameLevel() + 1)
	
	NewButton.text = NewButton:CreateFontString(nil, "ARTWORK")
	NewButton.text:SetPoint(side, NewButton, side, 0, 0.5)
	NewButton.text:SetFont(unpack(nibRealUI.font.pixel1))
	NewButton.text:SetJustifyH(side)
	
	NewButton:EnableMouse(true)
	NewButton.mouseover = false
	NewButton:SetScript("OnEnter", function(self) InfoLine:TextButton_OnEnter(self) end)
	NewButton:SetScript("OnLeave", function(self) InfoLine:TextButton_OnLeave(self) end)
	NewButton:SetScript("OnMouseDown", function(self) InfoLine:TextButton_OnMouseDown(self) end)
	
	NewButton.curwidth = 0
	
	return NewButton
end

local function CreateIconButtonFrame(side)
	local NewButton = CreateFrame("Frame", nil, UIParent)
	NewButton.side = side
	
	NewButton:SetFrameStrata(ILFrames.parent:GetFrameStrata())
	NewButton:SetFrameLevel(ILFrames.parent:GetFrameLevel() + 1)
	
	NewButton.icon = NewButton:CreateTexture(nil, "ARTWORK")
	NewButton.icon:SetAllPoints(NewButton)
	
	NewButton:EnableMouse(true)
	NewButton.mouseover = false
	NewButton:SetScript("OnEnter", function(self) InfoLine:IconButton_OnEnter(self) end)
	NewButton:SetScript("OnLeave", function(self) InfoLine:IconButton_OnLeave(self) end)
	NewButton:SetScript("OnMouseDown", function(self) InfoLine:IconButton_OnMouseDown(self) end)
	
	return NewButton
end

local function CreateTextFrame(side)
	local NewText = CreateFrame("Frame", nil, UIParent)
	NewText.side = side
	
	NewText:SetFrameStrata(ILFrames.parent:GetFrameStrata())
	NewText:SetFrameLevel(ILFrames.parent:GetFrameLevel() + 1)
	
	NewText.text = NewText:CreateFontString(nil, "ARTWORK")
	NewText.text:SetPoint(side, NewText, side, 0, 0.5)
	NewText.text:SetFont(unpack(nibRealUI.font.pixel1))
	NewText.text:SetJustifyH(side)
	
	NewText.curwidth = 50.5
	
	NewText:EnableMouse(true)
	NewText:SetScript("OnLeave", function(self) 
		InfoLine:Text_OnLeave(self)
	end)
	
	return NewText
end

function InfoLine:CreateFrames()
	if InCombatLockdown() or FramesCrated then return end
	
	ILFrames = {}
	
	-- Parent
	ILFrames.parent = CreateFrame("Frame", "RealUI_InfoLine", UIParent)
	ILFrames.parent:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", db.position.x, db.position.y)
	ILFrames.parent:SetFrameStrata("LOW")
	ILFrames.parent:SetFrameLevel(0)
	
	
	---- LEFT
	-- Options Button
	ILFrames.options = CreateIconButtonFrame("LEFT")
	ILFrames.options.tag = "options"
	
	-- Micro Menu
	ILFrames.micromenu = CreateMicroMenuFrame("LEFT")
	hooksecurefunc("UpdateMicroButtons", function() InfoLine:UpdateMMButtonState() end)
	
	-- Guild
	ILFrames.guild = CreateTextFrame("LEFT")
	ILFrames.guild:RegisterEvent("GUILD_ROSTER_UPDATE")
	ILFrames.guild:RegisterEvent("GUILD_PERK_UPDATE")
	ILFrames.guild:RegisterEvent("GUILD_MOTD")
	ILFrames.guild:RegisterEvent("PLAYER_ENTERING_WORLD")
	ILFrames.guild:SetScript("OnEvent", function(self, event)
		if not db.elements.guild then return end
		if event == "GUILD_MOTD" then
			if not self.hidden then return end
			self.needrefreshed = true
			self.elapsed = -2
		else
			self.needrefreshed = true
			self.elapsed = 0
		end
	end)
	ILFrames.guild.elapsed = 1
	ILFrames.guild:SetScript("OnUpdate", function(self, elapsed) 
		self.elapsed = self.elapsed + elapsed
		if self.elapsed >= 1 then
			if self.needrefreshed then
				Guild_Update(self)
				self.needrefreshed = false
			end
			self.elapsed = 0
		end
	end)
	ILFrames.guild:SetScript("OnMouseDown", function(self) Guild_OnMouseDown(self) end)
	
	-- Friends
	ILFrames.friends = CreateTextFrame("LEFT")
	ILFrames.friends:RegisterEvent("FRIENDLIST_UPDATE")
	ILFrames.friends:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
	ILFrames.friends:RegisterEvent("BN_FRIEND_ACCOUNT_OFFLINE")
	ILFrames.friends:RegisterEvent("PLAYER_ENTERING_WORLD")
	ILFrames.friends:SetScript("OnEvent", function(self) 
		if not db.elements.friends then return end
		self.needrefreshed = true
		self.elapsed = 0
	end)
	ILFrames.friends.elapsed = 1
	ILFrames.friends:SetScript("OnUpdate", function(self, elapsed) 
		self.elapsed = self.elapsed + elapsed
		if self.elapsed >= 1 then
			if self.needrefreshed then
				Friends_Update(self)
				self.needrefreshed = false
			end
			self.elapsed = 0
		end
	end)
	ILFrames.friends:SetScript("OnMouseDown", function(self) Friends_OnMouseDown(self) end)
	
	-- Durability
	ILFrames.durability = CreateTextFrame("LEFT")
	ILFrames.durability:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
	ILFrames.durability:RegisterEvent("PLAYER_ENTERING_WORLD")
	ILFrames.durability:SetScript("OnEvent", function(self) 
		if not db.elements.durability then return end
		InfoLine_Durability_Update(self)
	end)
	ILFrames.durability:SetScript("OnEnter", function(self) InfoLine_Durability_OnEnter(self) end)
	ILFrames.durability:SetScript("OnMouseDown", function(self) InfoLine_Durability_OnMouseDown(self) end)
	
	-- Bag Space
	ILFrames.bag = CreateTextFrame("LEFT")
	ILFrames.bag:RegisterEvent("InfoLine_Bag_Update")
	ILFrames.bag:RegisterEvent("UNIT_INVENTORY_CHANGED")
	ILFrames.bag:RegisterEvent("BAG_UPDATE")
	ILFrames.bag:RegisterEvent("PLAYER_ENTERING_WORLD")
	ILFrames.bag:SetScript("OnEvent", function(self) 
		if not db.elements.bag then return end
		InfoLine_Bag_Update(self)
	end)
	ILFrames.bag:SetScript("OnMouseDown", function(self) InfoLine_Bag_OnMouseDown(self) end)
	
	-- Currency
	ILFrames.currency = CreateTextFrame("LEFT")
	ILFrames.currency:RegisterEvent("PLAYER_ENTERING_WORLD")
	ILFrames.currency:RegisterEvent("SEND_MAIL_MONEY_CHANGED")
	ILFrames.currency:RegisterEvent("SEND_MAIL_COD_CHANGED")
	ILFrames.currency:RegisterEvent("PLAYER_TRADE_MONEY")
	ILFrames.currency:RegisterEvent("TRADE_MONEY_CHANGED")
	ILFrames.currency:RegisterEvent("PLAYER_MONEY")
	ILFrames.currency:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	ILFrames.currency:RegisterEvent("UPDATE_PENDING_MAIL")
	local MoneyPossibilityEvents = {
		["AUCTION_HOUSE_SHOW"] = true,
		["MAIL_SHOW"] = true,
		["TRADE_SHOW"] = true,
		["TRAINER_SHOW"] = true,
		["MERCHANT_SHOW"] = true,
		["GUILDBANKFRAME_OPENED"] = true,
		["FORGE_MASTER_OPENED"] = true,
		["VOID_STORAGE_OPEN"] = true,
		["TRANSMOGRIFY_OPEN"] = true,
		["TAXIMAP_OPENED"] = true,
		["GOSSIP_SHOW"] = true,
		["QUEST_COMPLETE"] = true,
	}
	for k, v in pairs(MoneyPossibilityEvents) do
		if v then
			ILFrames.currency:RegisterEvent(k)
		end
	end
	ILFrames.currency:SetScript("OnEvent", function(self, event)
		if not db.elements.currency then return end
		if event == "UPDATE_PENDING_MAIL" then
			self.ingame = true
			self:UnregisterEvent("UPDATE_PENDING_MAIL")
		elseif MoneyPossibilityEvents[event] then
			if self.ingame then
				self.initialized = true
			end
			if MoneyPossibilityEvents[event] then 
				for k, v in pairs(MoneyPossibilityEvents) do
					if v then
						ILFrames.currency:UnregisterEvent(k)
					end
				end
			end
		end
		self.needrefreshed = true
		self.elapsed = 0
	end)
	ILFrames.currency.elapsed = 1
	ILFrames.currency:SetScript("OnUpdate", function(self, elapsed) 
		self.elapsed = self.elapsed + elapsed
		if self.elapsed >= 1 then
			if self.needrefreshed then
				Currency_Update(self)
				self.needrefreshed = false
			end
			self.elapsed = 0
		end
	end)
	ILFrames.currency:SetScript("OnMouseDown", function(self) Currency_OnMouseDown(self) end)
	ILFrames.currency:SetScript("OnEnter", function(self) Currency_OnEnter(self) end)
	
	-- XP/Rep
	ILFrames.xr = CreateTextFrame("LEFT")
	ILFrames.xr.hidden = false
	ILFrames.xr:RegisterEvent("PLAYER_XP_UPDATE")
	ILFrames.xr:RegisterEvent("UPDATE_FACTION")
	ILFrames.xr:RegisterEvent("DISABLE_XP_GAIN")
	ILFrames.xr:RegisterEvent("ENABLE_XP_GAIN")
	ILFrames.xr:RegisterEvent("PLAYER_ENTERING_WORLD")
	ILFrames.xr:SetScript("OnEvent", function(self) 
		if not db.elements.xprep then return end
		InfoLine_XR_Update(self)
	end)
	ILFrames.xr:SetScript("OnEnter", function(self) InfoLine_XR_OnEnter(self) end)
	ILFrames.xr:SetScript("OnLeave", function(self) InfoLine_XR_OnLeave(self) end)
	ILFrames.xr:SetScript("OnMouseDown", function(self) InfoLine_XR_OnMouseDown(self) end)
	
	
	---- RIGHT
	-- Clock
	ILFrames.clock = CreateTextFrame("RIGHT")
	ILFrames.clock.pendingCalendarInvites = 0
	ILFrames.clock:RegisterEvent("PLAYER_ENTERING_WORLD")
	ILFrames.clock:RegisterEvent("CALENDAR_UPDATE_PENDING_INVITES")
	ILFrames.clock:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	ILFrames.clock:SetScript("OnEvent", function(self) 
		if not db.elements.clock then return end
		Clock_Update(self, true)
	end)
	ILFrames.clock.elapsed1 = 1
	ILFrames.clock.elapsed2 = 10
	ILFrames.clock:SetScript("OnUpdate", function(self, elapsed) 
		if not db.elements.clock then return end
		self.elapsed1 = self.elapsed1 + elapsed
		self.elapsed2 = self.elapsed2 + elapsed
		if self.elapsed1 >= 1 then
			Clock_Update(self)
			self.elapsed1 = 0
		end
		if self.elapsed2 >= 10 then
			Clock_Update(self, true)
			self.elapsed2 = 0
		end
	end)
	ILFrames.clock:SetScript("OnEnter", function(self) Clock_OnEnter(self) end)
	ILFrames.clock:SetScript("OnMouseDown", function(self) Clock_OnMouseDown(self) end)
	ILFrames.clock.pulse = CreateFrame("Frame")
	ILFrames.clock.pulse:Hide()
	
	-- SysInfo
	ILFrames.sysinfo = CreateTextFrame("RIGHT")
	CreateGraph("fps", 60, 60, ILFrames.sysinfo)
	ILFrames.sysinfo:RegisterEvent("UPDATE_PENDING_MAIL")
	ILFrames.sysinfo:SetScript("OnEvent", function(self)
		if not db.elements.sysinfo then return end
		ILFrames.sysinfo.ready = true
		Graphs["fps"].enabled = true
		ILFrames.sysinfo:UnregisterEvent("UPDATE_PENDING_MAIL")
	end)
	ILFrames.sysinfo.elapsed1 = 1
	ILFrames.sysinfo.elapsed2 = 5
	ILFrames.sysinfo:SetScript("OnUpdate", function(self, elapsed) 
		if not db.elements.sysinfo then return end
		if ILFrames.sysinfo.ready then
			self.elapsed1 = self.elapsed1 + elapsed
			self.elapsed2 = self.elapsed2 + elapsed
			if self.elapsed1 >= 1 then
				-- FPS update
				SysInfo_Update(self, true)
				self.elapsed1 = 0
			end
			if self.elapsed2 >= 5 then
				SysInfo_Update(self, false)
				self.elapsed2 = 0
			end
		end
	end)
	ILFrames.sysinfo:SetScript("OnEnter", function(self) SysInfo_OnEnter(self) end)
	ILFrames.sysinfo:SetScript("OnLeave", function(self) SysInfo_OnLeave(self) end)
	
	-- Spec Button
	ILFrames.spec = CreateTextButtonFrame("RIGHT")
	ILFrames.spec.tag = "spec"
	ILFrames.spec:RegisterEvent("PLAYER_ENTERING_WORLD")
	ILFrames.spec:RegisterEvent("UPDATE_PENDING_MAIL")
	ILFrames.spec:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	ILFrames.spec:RegisterEvent("EQUIPMENT_SETS_CHANGED")
	ILFrames.spec:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	--ILFrames.spec:RegisterEvent("EQUIPMENT_SWAP_FINISHED")
	ILFrames.spec:SetScript("OnEvent", function(self) 
		if not db.elements.specchanger then return end
		if event == "UPDATE_PENDING_MAIL" then
			ILFrames.spec:UnregisterEvent("UPDATE_PENDING_MAIL")
		end
		Spec_Update(self)
	end)
	ILFrames.spec:SetScript("OnEnter", function(self) Spec_OnEnter(self) end)
	
	-- Layout Button
	ILFrames.layout = CreateTextButtonFrame("RIGHT")
	ILFrames.layout.tag = "layout"
	ILFrames.layout:RegisterEvent("PLAYER_ENTERING_WORLD")
	ILFrames.layout:SetScript("OnEvent", function(self) 
		if not db.elements.layoutchanger then return end
		Layout_Update(self)
	end)
	ILFrames.layout.tip = CreateTipFrame(ILFrames.layout, db.resolution[ndbc.resolution].layouttipsize.width, db.resolution[ndbc.resolution].layouttipsize.height, "Layout Changer", "Use this button to change\nlayouts based on your current\nScreen Size and Role.")
	if ndbg.tags.layouttip then
		if db.elements.layoutchanger then ILFrames.layout.tip:Show() end
		ndbg.tags.layouttip = false
	end
	
	-- Meter Button
	ILFrames.meter = CreateTextButtonFrame("RIGHT")
	ILFrames.meter.tag = "meter"
	ILFrames.meter:RegisterEvent("PLAYER_ENTERING_WORLD")
	ILFrames.meter:SetScript("OnEvent", function(self) 
		if not db.elements.metertoggle then return end
		Meter_Update(self)
	end)
	ILFrames.meter.elapsed = 2
	ILFrames.meter:SetScript("OnUpdate", function(self, elapsed) 
		if not db.elements.metertoggle then return end
		self.elapsed = self.elapsed + elapsed
		if self.elapsed >= 2 then
			Meter_Update(self)
			self.elapsed = 0
		end
	end)
	
	FramesCreated = true
end

------------------
-- Core Updates --
------------------
function InfoLine:UpdateAllInfo()
	Guild_Update(ILFrames.guild)
	Friends_Update(ILFrames.friends)
	InfoLine_Durability_Update(ILFrames.durability)
	InfoLine_Bag_Update(ILFrames.bag)
	Currency_Update(ILFrames.currency)
	InfoLine_XR_Update(ILFrames.xr)
	Clock_Update(ILFrames.clock, true)
	SysInfo_Update(ILFrames.sysinfo, true)
	Spec_Update(ILFrames.spec)
	Layout_Update(ILFrames.layout)
	Meter_Update(ILFrames.meter)
end

function InfoLine:Refresh()
	-- Refresh Mod
	if InCombatLockdown() then
		-- In combat, set flag so we can refresh once combat ends
		NeedRefreshed = true
	else
		-- Ready to refresh
		NeedRefreshed = false
		
		-- Get Colors
		TextColorNormal = ColorTableToStr(db.colors.normal)
		TextColorNormalVals = db.colors.normal
		if db.colors.classcolorhighlight then
			local classColor = nibRealUI:GetClassColor(nibRealUI.class) or {1, 1, 1}
			TextColorHighlight = ColorTableToStr(classColor)
			TextColorHighlightVals = {classColor[1], classColor[2], classColor[3]}
		else
			TextColorHighlight = ColorTableToStr(db.colors.highlight)
			TextColorHighlightVals = db.colors.highlight
		end
		TextColorDisabledVals = db.colors.disabled
		TextColorWhite = ColorTableToStr({1, 1, 1})
		TextColorTTHeader = ColorTableToStr(db.colors.ttheader)
		TextColorOrange1 = ColorTableToStr(db.colors.orange1)
		TextColorOrange2 = ColorTableToStr(db.colors.orange2)
		TextColorBlue1 = ColorTableToStr(db.colors.blue1)
		
		-- Create Frames if it has been delayed
		if not FramesCreated then
			InfoLine:CreateFrames()
		end
		
		-- Update
		InfoLine:UpdateFont()
		InfoLine:UpdatePositions()
		InfoLine:UpdateTextures()
		
		InfoLine:UpdateIconButtonColors()
		InfoLine:UpdateTextButtonColors()
		InfoLine:UpdateMMButtonState()
		
		InfoLine:UpdateAllInfo()
	end
end

-- Lockdown Timer
local LockdownTimer = CreateFrame("Frame")
LockdownTimer.e = 0
LockdownTimer:Hide()
LockdownTimer:SetScript("OnUpdate", function(s, e)
	s.e = s.e + e
	if s.e >= 1 then
		if not InCombatLockdown() then
			if NeedRefreshed then
				InfoLine:Refresh()
			end
			s.e = 0
			s:Hide()
		else
			s.e = 0
		end
	end
end)
function InfoLine:UpdateLockdown()
	LockdownTimer:Show()
end

local function ClassColorsUpdate()
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end
	InfoLine:Refresh()
end

function InfoLine:PLAYER_LOGIN()
	LoggedIn = true
	
	-- Class Name lookup table
	ClassLookup = {}
	for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		ClassLookup[v] = k
	end
	for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
		ClassLookup[v] = k
	end
	
	-- Class Colors
	if CUSTOM_CLASS_COLORS then
		CUSTOM_CLASS_COLORS:RegisterCallback(ClassColorsUpdate)
	end
	
	-- Currency Names
	HPName = GetCurrencyInfo(392)
	CPName = GetCurrencyInfo(390)
	JPName = GetCurrencyInfo(395)
	VPName = GetCurrencyInfo(396)
	
	GoldName = strtrim(strsub(strform(nibRealUI.goldstr or GOLD_AMOUNT, 0), 2))
	
	InfoLine:Refresh()
end

function InfoLine:RefreshMod()
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end
	
	db = self.db.profile
	ndbc = nibRealUI.db.char
	ndbg = nibRealUI.db.global
	
	InfoLine:Refresh()
end

--------------------
-- Initialization --
--------------------
function InfoLine:OnInitialize()
	local otherFaction = nibRealUI:OtherFaction(nibRealUI.faction)
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		char = {
			xrstate = "x",
			currencystate = 1,
			specgear = {
				primary = -1,
				secondary = -1,
			},
		},
		global = {
			currency = {
				[nibRealUI.realm] = {
					[nibRealUI.faction] = {
						[nibRealUI.name] = {
							class = "",
							level = 0,
							gold = -1,
							jp = -1,
							vp = -1,
							vpw = -1,
							hp = -1,
							cp = -1,
							cpw = -1,
							updated = "",
						},
					},
					[otherFaction] = {},
				},
			},
		},
		profile = {
			position = {
				xl = 4,
				xr = 0,
				xgap = 10,
				y = 4,
			},
			text = {
				yoffset = 0.5,
			},
			iconbuttons = {
				size = 16,
				yoffset = -2,
			},
			colors = {
				normal = {1, 1, 1},
				highlight = {1, 1, 1},
				classcolorhighlight = true,
				disabled = {0.5, 0.5, 0.5},
				ttheader = {1, 1, 1},
				orange1 = {1, 0.4, 0},
				orange2 = {1, 0.73, 0.3},
				blue1 = {0.2, 0.9, 0.9},
			},
			other = {
				clock = {
					hr24 = false,
					uselocal = true,
					wgalert = false,
					tbalert = true,
				},
				tablets = {
					maxheight = 500,
				},
			},
			elements = {
				options = true,
				micromenu = true,
				guild = true,
				friends = true,
				durability = true,
				bag = true,
				currency = true,
				xprep = true,
				clock = true,
				sysinfo = true,
				specchanger = true,
				layoutchanger = true,
				metertoggle = true,
			},
			customframes = {},
			resolution = {
				[1] = {
					micromenupadding = 0,
					tabfontsize = 0,
					layouttipsize = {width = 186, height = 65},
					configicon = [[Interface\AddOns\nibRealUI\Media\InfoLine\Config]]
				},
				[2] = {
					micromenupadding = 2,
					tabfontsize = 1,
					layouttipsize = {width = 200, height = 68},
					configicon = [[Interface\AddOns\nibRealUI\Media\InfoLine\Config_HR]]
				},
			},
		},
	})
	db = self.db.profile
	dbc = self.db.char
	dbg = self.db.global
	ndbc = nibRealUI.db.char
	ndbg = nibRealUI.db.global
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterPlainOptions(MODNAME, GetOptions)
end

function InfoLine:OnEnable()
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateLockdown")
	
	CreateCopyFrame()
	
	if LoggedIn then
		InfoLine:Refresh()
	end
end