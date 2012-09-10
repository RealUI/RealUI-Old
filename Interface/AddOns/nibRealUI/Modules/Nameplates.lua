
local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI");
local LSM = LibStub("LibSharedMedia-3.0")
local db, ndbc
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local MODNAME = "Nameplates";
local Nameplates = nibRealUI:NewModule(MODNAME, "AceEvent-3.0");

local LoggedIn = false

-- Options
local options;
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Nameplates",
		desc = "Modifies the appearance and adds features to the Nameplates.",
		childGroups = "tab",
		arg = MODNAME,
		order = 1401,
		args = {
			header = {
				type = "header",
				name = "Nameplates",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Modifies the appearance and adds features to the Nameplates.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Nameplates module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
					nibRealUI:ReloadUIDialog()
				end,
				order = 30,
			},
			general = {
				type = "group",
				name = "General",
				inline = true,
				order = 40,
				args = {
					abbreviate = {
						type = "toggle",
						name = "Abbreviate Names",
						get = function() return db.general.abbreviate end,
						set = function(info, value) 
							db.general.abbreviate = value
						end,
						order = 10,
					},
					showhp = {
						type = "toggle",
						name = "Show Health Percent",
						get = function() return db.general.showhp end,
						set = function(info, value) 
							db.general.showhp = value
						end,
						order = 20,
					},
				},
			},
		},
	};
	end
	return options;
end

local usNamePlates = 0.1
local usThreat = 0.2

local NPUpdateFrame = CreateFrame("Frame")
NPUpdateFrame:Hide()

local paladinR, paladinG, paladinB
local shamanR, shamanG, shamanB

local select = _G.select
local strlen = _G.strlen
local strsub = _G.strsub
local gsub = _G.gsub

local CreateBG = function(parent, r, g, b, a, layer)
	local offset = UIParent:GetScale() / parent:GetEffectiveScale()
	local bg = parent:CreateTexture(nil, layer or "BACKGROUND")
	bg:SetTexture(r or 0, g or 0, b or 0, a or 1)
	bg:SetPoint("BOTTOMRIGHT", offset, -offset)
	bg:SetPoint("TOPLEFT", -offset, offset)
	return bg
end

local function IsValidFrame(frame)
	local name = frame:GetName()
	return name and name:find("NamePlate")
end

local ThreatUpdate = function(self, elapsed)
	self.elapsed = self.elapsed + elapsed
	if self.elapsed >= usThreat then
		if self.oldglow:IsShown() then
			local _, green = self.oldglow:GetVertexColor()
			if(green > .7) then
				self.healthBar:SetStatusBarColor(.8, .8, .2) -- medium threat
			elseif(green > .1) then
				self.healthBar:SetStatusBarColor(.8, .4, 0) -- losing aggro
			else
				self.healthBar:SetStatusBarColor(.2, .8, .2) -- tanking
			end
		else
			self.healthBar:SetStatusBarColor(self.r, self.g, self.b) -- normal colours e.g. not tanking/not NPC
		end
		self.elapsed = 0
	end
end

local UpdateFrame = function(self)
	local r, g, b = self.healthBar:GetStatusBarColor()
	local newr, newg, newb
	if g + b == 0 then
		-- Enemy, Red
		newr, newg, newb = 0.7, 0, 0
		self.healthBar:SetStatusBarColor(0.7, 0, 0)
	elseif r + b == 0 then
		-- Friendly, Green
		newr, newg, newb = 0.33, 0.59, 0.33
		self.healthBar:SetStatusBarColor(0.33, 0.59, 0.33)
	elseif r + g == 0 then
		-- Friendly player, Blue
		newr, newg, newb = 0.31, 0.45, 0.63
		self.healthBar:SetStatusBarColor(0.31, 0.45, 0.63)
	elseif 2 - (r + g) < 0.05 and b == 0 then
		-- Neutral, Yellow
		newr, newg, newb = 0.7, 0.7, .2
		self.healthBar:SetStatusBarColor(0.8, 0.8, .2)
	elseif r > 0.9 and g > 0.5 and g < 0.6 and b > 0.7 and b < 0.8 then
		-- Pink
		newr, newg, newb = paladinR * 0.9, paladinG * 0.9, paladinB * 0.9
		self.healthBar:SetStatusBarColor(paladinR * 0.9, paladinG * 0.9, paladinB * 0.9)
	elseif g > 0.4 and g < 0.5 and b > 0.8 and b < 0.9 then
		-- Blue
		newr, newg, newb = shamanR, shamanG, shamanB
		self.healthBar:SetStatusBarColor(shamanR, shamanG, shamanB)
	else
		newr, newg, newb = r, g, b
	end

	self.r, self.g, self.b = newr, newg, newb

	self.healthBar:ClearAllPoints()
	self.healthBar:SetPoint("CENTER", self.healthBar:GetParent())
	self.healthBar:SetHeight(db.barsize.normal.height + db.resolution[ndbc.resolution].height)
	self.healthBar:SetWidth(db.barsize.normal.width + db.resolution[ndbc.resolution].width)

	self.castBar:ClearAllPoints()
	self.castBar:SetPoint("TOP", self.healthBar, "BOTTOM", 0, -2)
	self.castBar:SetHeight(db.barsize.normal.height + db.resolution[ndbc.resolution].height)
	self.castBar:SetWidth(db.barsize.normal.width + db.resolution[ndbc.resolution].width)

	self.highlight:SetTexture(nil)
	
	local oldName = self.oldname:GetText()
	local newName = oldName
	local maxNameLength = ceil((db.barsize.normal.width + db.resolution[ndbc.resolution].width) / db.resolution[ndbc.resolution].maxnamelength)
	if db.general.abbreviate then
		newName = (strlen(oldName) > maxNameLength) and gsub(oldName, "%s?(.[\128-\191]*)%S+%s", "%1.") or oldName
		if strlen(newName) > maxNameLength then
			newName = strsub(newName, 1, maxNameLength - 1)..".."
		end
	end
	self.name:SetText(newName)

	local level, elite, mylevel = tonumber(self.level:GetText()), self.elite:IsShown(), UnitLevel("player")
	self.level:ClearAllPoints()
	self.level:SetPoint("RIGHT", self.healthBar, "LEFT", -2, 0)
	self.level:SetFont(nibRealUI.font.pixel1[1], nibRealUI.font.pixel1[2] * UIParent:GetScale(), nibRealUI.font.pixel1[3])
	self.level:SetShadowColor(0, 0, 0, 0)
	if self.boss:IsShown() then
		self.level:SetText("B")
		self.level:SetTextColor(0.8, 0.05, 0)
		self.level:Show()
	elseif not elite and level == mylevel then
		self.level:Hide()
	else
		self.level:SetText(level..(elite and "+" or ""))
	end
end

local FixCastbar = function(self)
	self.castbarOverlay:Hide()

	self:SetHeight(db.barsize.normal.height + db.resolution[ndbc.resolution].height)
	-- self:SetWidth(80)
	self:ClearAllPoints()
	self:SetPoint("TOP", self.healthBar, "BOTTOM", 0, -2)
end

local ColorCastBar = function(self, shielded)
	if shielded then
		self.iconbg:SetTexture(1, 0, 0)
	else
		self.iconbg:SetTexture(0, 0, 0)
	end
end

local OnSizeChanged = function(self)
	self.needFix = true
end

local OnValueChanged = function(self, curValue)
	if self.needFix then
		FixCastbar(self)
		self.needFix = nil
	end
end

local OnShow = function(self)
	self.channeling  = UnitChannelInfo("target") 
	FixCastbar(self)
	ColorCastBar(self, self.shieldedRegion:IsShown())
end

local OnEvent = function(self, event, unit)
	if unit == "target" and event == "UNIT_SPELLCAST_NOT_INTERRUPTIBLE" or event == "UNIT_SPELLCAST_INTERRUPTIBLE" then
		if self:IsShown() then
			ColorCastBar(self, event == "UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
		end
	end
end

local CreateFrame = function(frame)
	if frame.done then return end
	
	frame.nameplate = true
	
	frame.healthBar, frame.castBar = frame:GetChildren()
	local healthBar, castBar = frame.healthBar, frame.castBar
	local glowRegion, overlayRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion = frame:GetRegions()
	local _, castbarOverlay, shieldedRegion, spellIconRegion = castBar:GetRegions()
	
	frame.oldname = nameTextRegion
	nameTextRegion:Hide()
	
	local newNameRegion = nibRealUI:CreateFS(healthBar, "CENTER", nibRealUI.font.pixel1[2] * UIParent:GetScale())
	newNameRegion:SetPoint("BOTTOM", healthBar, "TOP", 0, 2.5)
	newNameRegion:SetWidth(db.barsize.normal.width + db.resolution[ndbc.resolution].width)
	newNameRegion:SetHeight(8)
	frame.name = newNameRegion
	
	frame.level = levelTextRegion
	
	healthBar:SetStatusBarTexture(nibRealUI.media.textures.plain)
	local newHPRegion = nibRealUI:CreateFS(healthBar, "CENTER", nibRealUI.font.pixel1[2] * UIParent:GetScale())
	newHPRegion:SetPoint("CENTER", healthBar, "CENTER", 0, db.resolution[ndbc.resolution].hpoffset)
	newHPRegion:SetWidth(db.barsize.normal.width + db.resolution[ndbc.resolution].width)
	newHPRegion:SetHeight(8)
	frame.hp = newHPRegion
	healthBar.elapsed = 0
	healthBar:SetScript("OnUpdate", function(s, e)
		s.elapsed = s.elapsed + e
		if s.elapsed >= 0.2 and db.general.showhp then
			s.elapsed = 0
			local minHP, maxHP = s:GetMinMaxValues()
			local perHP = (s:GetValue() / maxHP) * 100
			if perHP < 100 then
				frame.hp:SetFormattedText("%d%%", perHP)
			else
				frame.hp:SetText("")
			end
		end
	end)
	
	castBar.castbarOverlay = castbarOverlay
	castBar.healthBar = healthBar
	castBar.shieldedRegion = shieldedRegion
	castBar:SetStatusBarTexture(nibRealUI.media.textures.plain)
	
	castBar:HookScript("OnShow", OnShow)
	castBar:HookScript("OnSizeChanged", OnSizeChanged)
	castBar:HookScript("OnValueChanged", OnValueChanged)
	castBar:HookScript("OnEvent", OnEvent)
	castBar:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE")
	castBar:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
	
	frame.highlight = highlightRegion
	
	raidIconRegion:ClearAllPoints()
	raidIconRegion:SetPoint("BOTTOM", healthBar, "TOP", 0, 10)
	raidIconRegion:SetHeight(14)
	raidIconRegion:SetWidth(14)
	
	frame.oldglow = glowRegion
	frame.elite = stateIconRegion
	frame.boss = bossIconRegion
	
	frame.done = true
	
	glowRegion:SetTexture(nil)
	overlayRegion:SetTexture(nil)
	shieldedRegion:SetTexture(nil)
	castbarOverlay:SetTexture(nil)
	stateIconRegion:SetTexture(nil)
	bossIconRegion:SetTexture(nil)
	
	UpdateFrame(frame)
	frame:SetScript("OnShow", UpdateFrame)
	frame:SetScript("OnHide", OnHide)
	
	frame.elapsed = 0
	frame:SetScript("OnUpdate", ThreatUpdate)
	
	nibRealUI:CreateBG(castBar)
	nibRealUI:CreateBG(healthBar)
	
	local iconFrame = CreateFrame("Frame", nil, castBar)
	iconFrame:SetPoint("TOPLEFT", healthBar, "TOPRIGHT", 2, 2)
	iconFrame:SetHeight(16)
	iconFrame:SetWidth(16)
	iconFrame:SetFrameLevel(0)
	
	castBar.iconbg = nibRealUI:CreateBG(iconFrame)
	
	spellIconRegion:ClearAllPoints()
	spellIconRegion:SetAllPoints(iconFrame)
	spellIconRegion:SetTexCoord(.1, .9, .1, .9)
end

local numKids = 0
local last = 0
local OnUpdate = function(self, elapsed)
	last = last + elapsed

	if last > usNamePlates then
		last = 0

		if WorldFrame:GetNumChildren() ~= numKids then
			numKids = WorldFrame:GetNumChildren()
			for i = 1, select("#", WorldFrame:GetChildren()) do
				frame = select(i, WorldFrame:GetChildren())

				if IsValidFrame(frame) then
					CreateFrame(frame)
				end
			end
		end
	end
end

-----------------------
function Nameplates:RefreshMod()
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end
	
	paladinR, paladinG, paladinB = unpack(nibRealUI:GetClassColor("PALADIN"))
	shamanR, shamanG, shamanB = unpack(nibRealUI:GetClassColor("SHAMAN"))
	
	NPUpdateFrame:SetScript("OnUpdate", OnUpdate)
	NPUpdateFrame:Show()
end

function Nameplates:PLAYER_LOGIN()
	LoggedIn = true

	self:RefreshMod()
end

function Nameplates:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME);
	self.db:RegisterDefaults({
		profile = {
			general = {
				abbreviate = true,
				showhp = true,
			},
			barsize = {
				normal = {
					height = 6,
					width = 100,
				},
			},
			resolution = {
				[1] = {
					width = 0,
					height = 0,
					maxnamelength = 4.5,
					hpoffset = 0,
				},
				[2] = {
					width = 20,
					height = 0,
					maxnamelength = 5.5,
					hpoffset = -0.5,
				},
			}
		},
	});
	db = self.db.profile;
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME));
	nibRealUI:RegisterPlainOptions(MODNAME, GetOptions);
end

function Nameplates:OnEnable()
	self:RegisterEvent("PLAYER_LOGIN")
	
	if LoggedIn then
		self:RefreshMod()
	end
end

function Nameplates:OnDisable()
	NPUpdateFrame:Hide()
end