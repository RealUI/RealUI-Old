-- aThreatmeter by Alza, partially modified.

local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db, ndbc

local mass
if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local _
local MODNAME = "ThreatMeter"
local ThreatMeter = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

local format, wipe, sort, tinsert, min, max, strsub = 
		format, table.wipe, sort, tinsert, math.min, math.max, strsub

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Threat Meter",
		arg = MODNAME,
		childGroups = "tab",
		order = 2008,
		args = {
			header = {
				type = "header",
				name = "Threat Meter",
				order = 10,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Threat Meter module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
					nibRealUI:ReloadUIDialog()
				end,
				order = 30,
			},
			smallfont = {
				type = "toggle",
				name = "Use Small Font",
				get = function() return db.smallfont end,
				set = function(info, value) 
					db.smallfont = value
				end,
				order = 40,
			},
		},
	}
	end
	return options
end

local bar, tList, barList = {}, {}, {}
local targeted = false

local function AddUnit(unit)
	local _, _, pct = UnitDetailedThreatSituation(unit, "target")
	if (not pct or pct < 1) then return end
	
	local _, class = UnitClass(unit)
	local guid = UnitGUID(unit)
	if not tList[guid] then
		tinsert(barList, guid)
		tList[guid] = {
			name = UnitName(unit),
			class = UnitIsPlayer(unit) and class or "PET",
		}
	end
	tList[guid].pct = pct or 0
end

local function CheckUnit(unit)
	if UnitExists(unit) and UnitIsVisible(unit) then
		AddUnit(unit)
		if UnitExists(unit.."pet") then
			AddUnit(unit.."pet")
		end
	end
end

local function SortMethod(a, b)
	return tList[b].pct < tList[a].pct
end

local cColor
local function SetValues(row, name, class, perc)
	cColor = nibRealUI:GetClassColor(class)
	ThreatMeter.Names[row]:SetText(strsub(name, 1, 4))
	ThreatMeter.Names[row]:SetTextColor(cColor[1], cColor[2], cColor[3])
	ThreatMeter.Percent[row]:SetText(format("%d%%", perc))
	ThreatMeter.Percent[row]:SetTextColor(cColor[1], cColor[2], cColor[3])
end

local function ToggleRow(row, state)
	if state then
		ThreatMeter.Names[row]:Show()
		ThreatMeter.Percent[row]:Show()
	else
		ThreatMeter.Names[row]:Hide()
		ThreatMeter.Percent[row]:Hide()
	end
end

function ThreatMeter:UpdateBars()
	ToggleRow(1, false)
	ToggleRow(2, false)
	
	local curThreat, maxThreat, nextThreat
	local playerIsMax = false
	
	if #barList > 1 then
		
		sort(barList, SortMethod)
		maxThreat = tList[barList[1]]
		
		playerIsMax = maxThreat.name == nibRealUI.name
		if playerIsMax then
			-- Next highest is second in the threat table
			nextThreat = tList[barList[2]]
		else
			-- Find Player threat in the threat table
			local playerFound
			for i = 2, #barList do
				curThreat = tList[barList[i]]
				if curThreat.name == nibRealUI.name then
					playerFound = true
					break
				end
			end
			
			if playerFound then
				nextThreat = curThreat
			else
				-- Player not found, go for second in the threat table
				nextThreat = tList[barList[2]]
			end
		end
		
		SetValues(1, maxThreat.name, maxThreat.class, nibRealUI:Clamp(maxThreat.pct, 0, 100))
		ToggleRow(1, true)
		SetValues(2, nextThreat.name, nextThreat.class, nibRealUI:Clamp(nextThreat.pct, 0, 100))
		ToggleRow(2, true)
	end
end

function ThreatMeter:UpdateThreat()
	if targeted then
		if GetNumGroupMembers() > 0 then
			local unit = IsInRaid() and "raid" or "party"
			for i = 1, GetNumGroupMembers(), 1 do
				CheckUnit(unit..i)
			end
		end
		CheckUnit("targettarget")
		CheckUnit("player")
	end
	self:UpdateBars()
end

function ThreatMeter:ThreatEventUpdate()
	if GetNumGroupMembers() == 0 then
		targeted = false
	else
		if UnitExists("target") and not UnitIsDead("target") and not UnitIsPlayer("target") and UnitCanAttack("player", "target") then
			targeted = true
		else
			targeted = false
		end
	end
	self:UpdateThreat()
end

function ThreatMeter:PLAYER_REGEN_ENABLED()
	wipe(tList)
	wipe(barList)
	self:UpdateThreat()
end

function ThreatMeter:PLAYER_TARGET_CHANGED()
	wipe(tList)
	wipe(barList)
	self:ThreatEventUpdate()
end

function ThreatMeter:CreateFrames()
	local SD = nibRealUI:GetModule("StatDisplay")
	
	self.ThreatFrame = CreateFrame("Frame", "RealUI_ThreatMeter", RealUIPositionersBottomInfo)
	if SD and nibRealUI:GetModuleEnabled("StatDisplay") then
		self.ThreatFrame:SetPoint("TOPRIGHT", RealUIPositionersBottomInfo, "TOPRIGHT", -4, ndbc.resolution == 1 and -2 or -3)
		self.ThreatFrame:SetPoint("BOTTOMLEFT", RealUIPositionersBottomInfo, "BOTTOM", 0, 3)
	else
		self.ThreatFrame:SetPoint("TOPRIGHT", RealUIPositionersBottomInfo, "TOPRIGHT", -4, ndbc.resolution == 1 and -2 or -3)
		self.ThreatFrame:SetPoint("BOTTOMLEFT", RealUIPositionersBottomInfo, "BOTTOMLEFT", 4, 3)
	end
	self.ThreatFrame:SetHeight(ndbc.resolution == 1 and 27 or 28)
	
	local font = db.smallfont and nibRealUI.font.pixeltiny or nibRealUI.font.pixel1
	self.Names = {}
	self.Names[1] = self.ThreatFrame:CreateFontString(nil, "OVERLAY")
	self.Names[1]:SetPoint("TOPLEFT", self.ThreatFrame, "TOPLEFT", 0.5, -0.5)
	self.Names[1]:SetFont(unpack(font))
	self.Names[1]:SetTextColor(1, 1, 1, 1)
	
	self.Names[2] = self.ThreatFrame:CreateFontString(nil, "OVERLAY")
	self.Names[2]:SetPoint("TOPLEFT", self.ThreatFrame, "TOPLEFT", 0.5, ndbc.resolution == 1 and -13.5 or -14.5)
	self.Names[2]:SetFont(unpack(font))
	self.Names[2]:SetTextColor(1, 1, 1, 1)
	
	self.Percent = {}
	self.Percent[1] = self.ThreatFrame:CreateFontString(nil, "OVERLAY")
	self.Percent[1]:SetPoint("TOPRIGHT", self.ThreatFrame, "TOPRIGHT", 0.5, -0.5)
	self.Percent[1]:SetFont(unpack(font))
	self.Percent[1]:SetJustifyH("RIGHT")
	self.Percent[1]:SetTextColor(1, 1, 1, 1)
	
	self.Percent[2] = self.ThreatFrame:CreateFontString(nil, "OVERLAY")
	self.Percent[2]:SetPoint("TOPRIGHT", self.ThreatFrame, "TOPRIGHT", 0.5, ndbc.resolution == 1 and -13.5 or -14.5)
	self.Percent[2]:SetFont(unpack(font))
	self.Percent[2]:SetJustifyH("RIGHT")
	self.Percent[2]:SetTextColor(1, 1, 1, 1)
	
	ToggleRow(1, false)
	ToggleRow(2, false)
end

----------
function ThreatMeter:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			smallfont = true,
		},
	})
	db = self.db.profile
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterHuDOptions(MODNAME, GetOptions)
end

function ThreatMeter:OnEnable()
	self:CreateFrames()
	self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", "ThreatEventUpdate")
	self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", "ThreatEventUpdate")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
end