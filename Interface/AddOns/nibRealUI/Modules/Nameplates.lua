
local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI");
local LSM = LibStub("LibSharedMedia-3.0")
local db, ndbc

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

local function CreateBG(parent, r, g, b, a, layer)
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

local function ThreatUpdate(self, elapsed)
	self.elapsed = self.elapsed + elapsed
	if self.elapsed >= usThreat then
		if self.barFrame.threat:IsShown() then
			local _, green = self.barFrame.threat:GetVertexColor()
			if(green > .7) then
				self.barFrame.healthBar:SetStatusBarColor(.8, .8, .2) -- medium threat
			elseif(green > .1) then
				self.barFrame.healthBar:SetStatusBarColor(.8, .4, 0) -- losing aggro
			else
				self.barFrame.healthBar:SetStatusBarColor(.2, .8, .2) -- tanking
			end
		else
			self.barFrame.healthBar:SetStatusBarColor(self.r, self.g, self.b) -- normal colours e.g. not tanking/not NPC
		end
		self.elapsed = 0
	end
end

local function UpdateFrame(self)
	--print("Nameplates:UpdateFrame self.barFrame; "..tostring(self.barFrame))
	local r, g, b = self.barFrame.healthBar:GetStatusBarColor()
	--print("Nameplates:UpdateFrame r,b,g; "..tostring(r)..", "..tostring(b)..", "..tostring(g)..", ")
	local newr, newg, newb
	if g + b == 0 then
		-- Enemy, Red
		newr, newg, newb = 0.7, 0, 0
		self.barFrame.healthBar:SetStatusBarColor(0.7, 0, 0)
	elseif r + b == 0 then
		-- Friendly, Green
		newr, newg, newb = 0.33, 0.59, 0.33
		self.barFrame.healthBar:SetStatusBarColor(0.33, 0.59, 0.33)
	elseif r + g == 0 then
		-- Friendly player, Blue
		newr, newg, newb = 0.31, 0.45, 0.63
		self.barFrame.healthBar:SetStatusBarColor(0.31, 0.45, 0.63)
	elseif 2 - (r + g) < 0.05 and b == 0 then
		-- Neutral, Yellow
		newr, newg, newb = 0.7, 0.7, .2
		self.barFrame.healthBar:SetStatusBarColor(0.8, 0.8, .2)
	elseif r > 0.9 and g > 0.5 and g < 0.6 and b > 0.7 and b < 0.8 then
		-- Pink
		newr, newg, newb = paladinR * 0.9, paladinG * 0.9, paladinB * 0.9
		self.barFrame.healthBar:SetStatusBarColor(paladinR * 0.9, paladinG * 0.9, paladinB * 0.9)
	elseif g > 0.4 and g < 0.5 and b > 0.8 and b < 0.9 then
		-- Blue
		newr, newg, newb = shamanR, shamanG, shamanB
		self.barFrame.healthBar:SetStatusBarColor(shamanR, shamanG, shamanB)
	else
		newr, newg, newb = r, g, b
	end

	self.r, self.g, self.b = newr, newg, newb

	self.barFrame.healthBar:ClearAllPoints()
	self.barFrame.healthBar:SetPoint("CENTER", self.barFrame.healthBar:GetParent())
	self.barFrame.healthBar:SetHeight(db.barsize.normal.height + db.resolution[ndbc.resolution].height)
	self.barFrame.healthBar:SetWidth(db.barsize.normal.width + db.resolution[ndbc.resolution].width)

	self.barFrame.castBar:ClearAllPoints()
	self.barFrame.castBar:SetPoint("TOP", self.barFrame.healthBar, "BOTTOM", 0, -2)
	self.barFrame.castBar:SetHeight(6)--db.barsize.normal.height + db.resolution[ndbc.resolution].height)
	--print("Nameplates:UpdateFrame.SetHeight; "..tostring(self.nameFrame.name:GetText())..", Width: "..tostring(self.barFrame.castBar:GetWidth())..", Height: "..tostring(self.barFrame.castBar:GetHeight()))
	self.barFrame.castBar:SetWidth(db.barsize.normal.width + db.resolution[ndbc.resolution].width)

	--self.barFrame.highlight:SetTexture(nil)
	
	local oldName = self.nameFrame.oldname:GetText()
	local newName = oldName
	local maxNameLength = ceil((db.barsize.normal.width + db.resolution[ndbc.resolution].width) / db.resolution[ndbc.resolution].maxnamelength)
	if db.general.abbreviate then
		newName = (strlen(oldName) > maxNameLength) and gsub(oldName, "%s?(.[\128-\191]*)%S+%s", "%1.") or oldName
		if strlen(newName) > maxNameLength then
			newName = strsub(newName, 1, maxNameLength - 1)..".."
		end
	end
	self.nameFrame.name:SetText(newName)

	local level, elite, mylevel = tonumber(self.barFrame.level:GetText()), self.barFrame.dragon:IsShown(), UnitLevel("player")
	self.barFrame.level:ClearAllPoints()
	self.barFrame.level:SetPoint("RIGHT", self.barFrame.healthBar, "LEFT", -2, 0)
	self.barFrame.level:SetFont(nibRealUI.font.pixel1[1], nibRealUI.font.pixel1[2] * UIParent:GetScale(), nibRealUI.font.pixel1[3])
	self.barFrame.level:SetShadowColor(0, 0, 0, 0)
	if self.barFrame.boss:IsShown() then
		self.barFrame.level:SetText("B")
		self.barFrame.level:SetTextColor(0.8, 0.05, 0)
		self.barFrame.level:Show()
	elseif not elite and level == mylevel then
		self.barFrame.level:Hide()
	else
		self.barFrame.level:SetText(level..(elite and "+" or ""))
	end
end

local function FixCastbar(self)
	--self.border:Hide()
	if not self.barFrame then return end
	
	self.barFrame.castBar:SetHeight(3)--db.barsize.normal.height + db.resolution[ndbc.resolution].height)
	--self:SetWidth(80)
	self.barFrame.castBar:ClearAllPoints()
	self.barFrame.castBar:SetPoint("TOP", self.barFrame.healthBar, "BOTTOM", 0, -2)
	--print("CastBar Fixed!!")
end

local function ColorCastBar(self, shielded)
	if shielded then
		self.icon:SetVertexColor(1, 0, 0)
--	else
--		self.icon.bg:SetVertexColor(0, 0, 0)
	end
end

local function OnSizeChanged(self)
	--print("Nameplates:OnSizeChanged; Width: "..tostring(self:GetWidth())..", Height: "..tostring(self:GetHeight()))
	self.needFix = true
end

local function OnValueChanged(self, curValue)
	--print("OnValueChanged")
	if self.needFix then
		FixCastbar(self)
		self.needFix = nil
	end
end

local function OnShow(self)
	--print("Nameplates:OnShow; Width: "..tostring(self:GetWidth())..", Height: "..tostring(self:GetHeight()))
	self.channeling  = UnitChannelInfo("target") 
	FixCastbar(self)
	--self:SetHeight(3);
	--print("Nameplates:OnShowFixed; Width: "..tostring(self:GetWidth())..", Height: "..tostring(self:GetHeight()))
	--print("Nameplates:OnShow self.shield:IsShown(); "..tostring(self.shield:IsShown()))
	ColorCastBar(self, self.shield:IsShown())
end

local function OnEvent(self, event, unit)
	--print("OnEvent")
	if unit == "target" and event == "UNIT_SPELLCAST_NOT_INTERRUPTIBLE" or event == "UNIT_SPELLCAST_INTERRUPTIBLE" then
		if self:IsShown() then
			ColorCastBar(self, event == "UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
		end
	end
end

local CreateFrame = function(frame)
	local frame = frame
	if frame.done or (not frame) then return end
	
	frame.nameplate = true
	
	-- /cheer @zork for posting the new Nameplate structure
	frame.barFrame, frame.nameFrame = frame:GetChildren()
	frame.barFrame.threat, frame.barFrame.border, frame.barFrame.highlight, frame.barFrame.level, frame.barFrame.boss, frame.barFrame.raid, frame.barFrame.dragon = frame.barFrame:GetRegions()
	frame.barFrame.healthBar, frame.barFrame.castBar = frame.barFrame:GetChildren()
	frame.barFrame.healthBar.texture =  frame.barFrame.healthBar:GetRegions()
	frame.barFrame.castBar.texture, frame.barFrame.castBar.border, frame.barFrame.castBar.shield, frame.barFrame.castBar.icon =  frame.barFrame.castBar:GetRegions()
	
	frame.nameFrame.name = frame.nameFrame:GetRegions()
	
	frame.nameFrame.oldname = frame.nameFrame.name
	frame.nameFrame.name:Hide()
	
	local newNameRegion = nibRealUI:CreateFS(frame, "CENTER", nibRealUI.font.pixel1[2] * UIParent:GetScale())
	--print("Nameplates:CreateFrame.newNameRegion; "..tostring(frame.nameFrame.name:GetText())..", Width: "..tostring(frame:GetWidth())..", Height: "..tostring(frame:GetHeight()))
	newNameRegion:SetPoint("BOTTOM", frame.barFrame.healthBar, "TOP", 0, 0)
	newNameRegion:SetWidth(db.barsize.normal.width + db.resolution[ndbc.resolution].width)
	newNameRegion:SetHeight(8)
	frame.nameFrame.name = newNameRegion
	
	--print("Nameplates:CreateFrame.newHPregion frame.barFrame.healthBar; "..tostring(frame.barFrame.healthBar))
	local newHPRegion = nibRealUI:CreateFS(frame.barFrame.healthBar, "CENTER", nibRealUI.font.pixel1[2] * UIParent:GetScale())
	newHPRegion:SetPoint("CENTER", frame.barFrame.healthBar, "CENTER", 0, db.resolution[ndbc.resolution].hpoffset)
	newHPRegion:SetWidth(db.barsize.normal.width + db.resolution[ndbc.resolution].width)
	newHPRegion:SetHeight(8)
	frame.barFrame.healthBar.hp = newHPRegion
	frame.elapsed = 0
	frame.barFrame.healthBar:SetScript("OnUpdate", function(s, e)
		frame.elapsed = frame.elapsed + e
		if frame.elapsed >= 0.2 and db.general.showhp then
			frame.elapsed = 0
			local minHP, maxHP = s:GetMinMaxValues()
			local perHP = (s:GetValue() / maxHP) * 100
			if perHP < 100 then
				frame.barFrame.healthBar.hp:SetFormattedText("%d%%", perHP)
			else
				frame.barFrame.healthBar.hp:SetText("")
			end
		end
	end)
	
	nibRealUI:CreateBG(frame.barFrame.healthBar)
	nibRealUI:CreateBG(frame.barFrame.castBar)
	
	UpdateFrame(frame)
	frame:SetScript("OnShow", UpdateFrame)
	frame:SetScript("OnHide", OnHide)
	frame:SetScript("OnUpdate", ThreatUpdate)
	frame.elapsed = 0

	frame.barFrame.raid:ClearAllPoints()
	frame.barFrame.raid:SetPoint("RIGHT", frame.nameFrame.name, "LEFT", 0, 0)
	frame.barFrame.raid:SetHeight(14)
	frame.barFrame.raid:SetWidth(14)
	
	frame.barFrame.castBar:HookScript("OnShow", OnShow)
	frame.barFrame.castBar:HookScript("OnSizeChanged", function() OnSizeChanged(frame) end)
	frame.barFrame.castBar:HookScript("OnValueChanged", function() OnValueChanged(frame) end)
	frame.barFrame.castBar:HookScript("OnEvent", OnEvent)
	frame.barFrame.castBar:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE")
	frame.barFrame.castBar:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
	
	local iconFrame = CreateFrame("Frame", nil, frame.barFrame.castBar)
	iconFrame:SetPoint("TOPLEFT", frame.barFrame.healthBar, "TOPRIGHT", 2, 2)
	iconFrame:SetHeight(16)
	iconFrame:SetWidth(16)
	iconFrame:SetFrameLevel(0)
	
	frame.barFrame.castBar.icon:ClearAllPoints()
	frame.barFrame.castBar.icon:SetAllPoints(iconFrame)
	frame.barFrame.castBar.icon:SetTexCoord(.1, .9, .1, .9)
	frame.barFrame.castBar.icon.bg = nibRealUI:CreateBG(iconFrame)
	
	--frame.barFrame.highlight:SetTexture(nil)
	frame.barFrame.border:SetTexture(nil)
	frame.barFrame.boss:SetTexture(nil)
	frame.barFrame.threat:SetTexture(nil)
	frame.barFrame.dragon:SetTexture(nil)
	frame.barFrame.healthBar.texture:SetTexture(nibRealUI.media.textures.plain)
	frame.barFrame.castBar.shield:SetTexture(nil)
	frame.barFrame.castBar.border:SetTexture(nil)
	frame.barFrame.castBar.texture:SetTexture(nibRealUI.media.textures.plain) 
	
	frame.done = true
end

local numKids = 0
local last = 0
local OnUpdate = function(self, elapsed)
	last = last + elapsed

	if last > usNamePlates then
		last = 0
		
		local frame
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