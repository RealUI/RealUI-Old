local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local L = LibStub("AceLocale-3.0"):GetLocale("nibRealUI")
local ndb, ndbc

local mass
if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local _
local MODNAME = "HuDConfig"
local HuDConfig = nibRealUI:NewModule(MODNAME, "AceEvent-3.0", "AceTimer-3.0")

local Textures = {
	ArrowVert = [[Interface\AddOns\nibRealUI\Media\HuDConfig\Arrow]],
	ArrowHoriz = [[Interface\AddOns\nibRealUI\Media\HuDConfig\ArrowLeft]],
}

local WFCollapsed

function HuDConfig:ResetDefaults()
	ndb.positions = nibRealUI:DeepCopy(nibRealUI.defaultpositions)
	if nibRealUI.db.global.tags.ldOptimized then
		nibRealUI:SetLDOptimizations()
	end
	
	nibRealUI:UpdatePositioners()
	
	if nibIceHUD then
		nibIceHUD.IceCore.defaults["gap"..ndbc.resolution] = ndb.positions[ndbc.resolution]["HuDWidth"] - 168
		nibIceHUD.IceCore:SetGap(ndb.positions[ndbc.resolution]["HuDWidth"] - 168, ndbc.resolution)
	end

	self.options.hudSVert:SetValue(ndb.positions[ndbc.resolution]["HuDY"] + 38)
	self.options.hudSWidth:SetValue(ndb.positions[ndbc.resolution]["HuDWidth"] - 168)
	self.options.ufSHoriz:SetValue(ndb.positions[ndbc.resolution]["UFHorizontal"])
	self.options.biSVert:SetValue(ndb.positions[ndbc.resolution]["BIY"])
end

local RavenTesting = false
function RealUIHuDTestMode(toggle)
	-- Toggle Test Modes
	if Raven then
		if RavenButton62 then
			if RavenButton62:IsShown() then
				if toggle then
					Raven:TestBarGroups()
					Raven:TestBarGroups()
				else
					Raven:TestBarGroups()
				end
			else
				if toggle then
					Raven:TestBarGroups()
				end
			end
		else
			if toggle then
				Raven:TestBarGroups()
			end
		end
	end
	if nibIceHUD then
		nibIceHUD.IceCore:ConfigModeToggle(toggle)
		nibIceHUD.IceCore:Redraw()
	end
	local PD = nibRealUI:GetModule("PointDisplay", true)
	if PD and nibRealUI:GetModuleEnabled("PointDisplay") then
		PD:ToggleClassConfig(toggle)
	end
	if toggle then
		HuDConfig.options.gridBox:Show()
	else
		HuDConfig.options.gridBox:Hide()
	end
	RealUIUFBossConfig(toggle, "player")

	-- if toggle then
	-- 	ExtraActionBarFrame.button:Show()
	-- 	ExtraActionBarFrame:Show()
	-- 	ExtraActionBarFrame.outro:Stop()
	-- 	ExtraActionBarFrame.intro:Play()
	-- 	if not ExtraActionBarFrame.button.icon:GetTexture() then
	-- 		ExtraActionBarFrame.button.icon:SetTexture("Interface\\ICONS\\ABILITY_SEAL")
	-- 		ExtraActionBarFrame.button.icon:Show()
	-- 	end
	-- end
end

function RealUIHuDCloseConfig()
	HuDConfig:UnregisterEvent("PLAYER_REGEN_DISABLED")
	HuDConfig.options:Hide()
	HuDConfig.options.gridBox:Hide()
	
	local function bgHide()
		HuDConfig.options.bg:Hide()
	end
	local bgFadeInfo = {
		mode = "OUT",
		timeToFade = 0.5,
		finishedFunc = bgHide,
	}
	UIFrameFade(HuDConfig.options.bg, bgFadeInfo)
	for k,v in pairs(HuDConfig.arrows) do
		UIFrameFadeOut(v, 0.3, 1, 0)
	end
	if not WFCollapsed then
		WatchFrame:Show()
	end
	RealUIHuDTestMode(false)
end

function HuDConfig:InitHuDConfig()
	if InCombatLockdown() then
		nibRealUI:Notification("RealUI", true, L["Cannot open HuD Configuration while in combat."])
		return
	end
	if not self.options then self:CreateConfigFrame() end
	if self.options:IsShown() then return end
	
	-- Watch for combat so we can hide HuD config
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	
	-- Show Option frame
	self.options:Show()
	
	-- Dark BG
	UIFrameFadeIn(self.options.bg, 0.3, 0, 1)
	
	-- Show Arrows
	for k,v in pairs(self.arrows) do
		UIFrameFadeIn(v, 0.3, 0, 1)
	end
	local a = self.arrows
	a[1]:SetPoint("BOTTOM", RealUIPositionersHuD, "TOP", 0, ndb.positions[ndbc.resolution]["HuDHeight"])
	a[2]:SetPoint("TOP", RealUIPositionersLayoutBottomItem, "BOTTOM", 0, ndbc.resolution == 1 and -97.5 or -124.5)
	a[3]:SetPoint("RIGHT", RealUIPositionersUnitFrames, "LEFT", -ndb.positions[ndbc.resolution]["UFWidth"] - 185, 0)
	a[4]:SetPoint("LEFT", RealUIPositionersUnitFrames, "RIGHT", ndb.positions[ndbc.resolution]["UFWidth"] + 185, 0)
	
	-- Grid Box
	self:PositionGridBox()
	
	-- WatchFrame
	WFCollapsed = WatchFrame.userCollapsed or not(WatchFrame:IsShown())
	if not WFCollapsed then WatchFrame:Hide() end
end

function HuDConfig:PositionGridBox()
	if not HuDConfig.options then return end
	if not HuDConfig.options:IsShown() then return end
	
	self.options.gridBox:ClearAllPoints()
	if ndbc.layout.current == 1 then
		self.options.gridBox:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 4)
	else
		self.options.gridBox:SetPoint("TOP", RealUIPositionersLayoutBottomItem, "CENTER", 0, 0)
	end
	
	local gHeight, gWidth = 20, 400
	if Grid then 
		GFM = Grid:GetModule("GridFrame", true)
		gWidth = GFM.db.profile.frameWidth * 5
		gHeight = GFM.db.profile.frameHeight * 5
	end
	self.options.gridBox:SetSize(gWidth, gHeight)
	nibRealUI:CreateBD(self.options.gridBox)
	self.options.gridBoxLabel = nibRealUI:CreateFS(self.options.gridBox, "CENTER")
	self.options.gridBoxLabel:SetJustifyV("CENTER")
	self.options.gridBoxLabel:SetPoint("CENTER", self.options.gridBox, "CENTER", 0, 0)
	self.options.gridBoxLabel:SetText("Grid Raid Fames")
end

local createTextButton = function (name, parent, width, height)
	local button = CreateFrame("Button", nil, parent, "SecureActionButtonTemplate")
	nfO = CreateFont("RealUIButtonWhiteSmall")
	nfO:SetFont(nibRealUI.font.standard, 11, "OUTLINE")
	button:SetNormalFontObject(nfO)
	button:SetHighlightFontObject(nfO)
	button:SetText(name)
	button:SetWidth(width)
	button:SetHeight(height)
	button:SetScript("OnEnter", buttonEnter)
	button:SetScript("OnLeave", buttonLeave)
	return button
end

local function ReskinSlider(f)
	f:SetBackdrop(nil)
	local bd = CreateFrame("Frame", nil, f)
	bd:SetPoint("TOPLEFT", -23, 0)
	bd:SetPoint("BOTTOMRIGHT", 23, 0)
	bd:SetFrameStrata("BACKGROUND")
	bd:SetFrameLevel(f:GetFrameLevel()-1)
	
	nibRealUI:CreateBD(bd, 0)
	f.bg = nibRealUI:CreateInnerBG(bd)
	f.bg:SetVertexColor(1, 1, 1, 0.6)

	local slider = select(4, f:GetRegions())
	slider:SetTexture("Interface\\AddOns\\nibRealUI\\Media\\HuDConfig\\SliderPos")
	slider:SetSize(16, 16)
	slider:SetBlendMode("ADD")
	
	for i = 1, f:GetNumRegions() do
		local region = select(i, f:GetRegions())
		if region:GetObjectType() == "FontString" then
			region:SetFont(unpack(nibRealUI.font.pixeltiny))
			if region:GetText() == LOW then
				region:ClearAllPoints()
				region:SetPoint("BOTTOMLEFT", bd, "BOTTOMLEFT", 3.5, 4.5)
				region:SetTextColor(0.75, 0.75, 0.75)
				region:SetShadowColor(0, 0, 0, 0)
			elseif region:GetText() == HIGH then
				region:ClearAllPoints()
				region:SetPoint("BOTTOMRIGHT", bd, "BOTTOMRIGHT", 1.5, 4.5)
				region:SetTextColor(0.75, 0.75, 0.75)
				region:SetShadowColor(0, 0, 0, 0)
			else
				region:SetTextColor(0.9, 0.9, 0.9)
			end
		end
	end
end

local function CreateCheckbox(name, parent, label, side)
    local f = CreateFrame("CheckButton", "RealUIHuDConfig" .. name, parent, "UICheckButtonTemplate")
    f:SetSize(26, 26)
	
	f.text = _G[f:GetName() .. "Text"]
    f.type = "checkbox"
	f.text:SetFont(nibRealUI.font.standard, 10)
	f.text:SetTextColor(1, 1, 1)
	f.text:SetText(label)
	f.text:ClearAllPoints()
	if side == "LEFT" then
		f.text:SetPoint("RIGHT", f, "LEFT", -4, 0)
		f.text:SetJustifyH("RIGHT")
	else
		f.text:SetPoint("LEFT", f, "RIGHT", 4, 0)
		f.text:SetJustifyH("LEFT")
	end
	
	local cbg = CreateFrame("Frame", nil, f)
	cbg:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -2)
	cbg:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
	nibRealUI:CreateBD(cbg)
	cbg:SetBackdropColor(0.8, 0.8, 0.8, 0.15)
	cbg:SetFrameLevel(f:GetFrameLevel() - 1)
	
    return f
end

local function CreateSlider(name, min, max, title, step)
	local f = CreateFrame("Slider", "RealUIHuDConfig" .. name, HuDConfig.options, "OptionsSliderTemplate")
	f:SetSize(180, 17)
	f:SetMinMaxValues(min, max)
	f:SetValue(0)
	f:SetValueStep(step)
	f.header = nibRealUI:CreateFS(f, "CENTER")
	f.header:SetPoint("BOTTOM", f, "TOP", 0, 4)
	f.header:SetText(title)
	f.value = nibRealUI:CreateFS(f, "CENTER")
	f.value:SetPoint("TOP", f, "BOTTOM", 1, -4)
	f.value:SetText(f:GetValue())
	
	return f
end

function HuDConfig:CreateConfigFrame()
	if self.options then return end
	
	self.options = CreateFrame("Frame", "RealUIHuDConfigOptions", UIParent)
	local hcO = self.options
	hcO:Hide()
	hcO:SetPoint("TOP", UIParent, "TOP", 0, -20)
	hcO:SetSize(752, 200)
	hcO:SetFrameLevel(5)
	hcO:SetFrameStrata("HIGH")
	
	-- Dark BG
	hcO.bg = CreateFrame("Frame", nil, UIParent)
	hcO.bg:SetParent(UIParent)
	hcO.bg:SetAllPoints(UIParent)
	hcO.bg:SetFrameStrata("BACKGROUND")
	hcO.bg:SetFrameLevel(0)
	hcO.bg:SetBackdrop({
		bgFile = nibRealUI.media.textures.plain,
	})
	hcO.bg:SetBackdropColor(0, 0, 0, 0.4)
	
	-- Toggle Test modes
	hcO.test = createTextButton(L["Show HuD Elements"], hcO, 186, 22)
	hcO.test:SetPoint("BOTTOM", hcO, "BOTTOM", 0, 7)
	hcO.test:SetAttribute("type", "macro")
	hcO.test:SetAttribute("macrotext",
		"/tar "..UnitName("player").."\n/focus\n/run RealUIHuDTestMode(true)"
	)
	
	-- Okay	
	hcO.okay = createTextButton(L["Okay"], hcO, 120, 22)
	hcO.okay:SetPoint("BOTTOMRIGHT", hcO.test, "BOTTOMLEFT", -1, 0)
	hcO.okay:SetAttribute("type", "macro")
	hcO.okay:SetAttribute("macrotext",
		"/clearfocus\n/cleartarget\n/run RealUIHuDCloseConfig()"
	)
	
	-- Reset to defaults
	hcO.reset = createTextButton(L["Load Defaults"], hcO, 120, 22)
	hcO.reset:SetPoint("BOTTOMLEFT", hcO.test, "BOTTOMRIGHT", 1, 0)
	hcO.reset:SetScript("OnClick", function() HuDConfig:ResetDefaults() end)
	
	-- Button Backgrounds
	nibRealUI:CreateBGSection(hcO, hcO.okay, hcO.reset)
	
	-- Header
	local header = nibRealUI:CreateFS(hcO, "CENTER")
	header:SetText(L["HuD Configuration"])
	header:SetPoint("TOP", hcO, "TOP", 0, -9)
	
	if nibIceHUD then
		-- Header HuD
		local hH1 = nibRealUI:CreateFS(hcO, "CENTER")
		hH1:SetPoint("TOP", hcO, "TOP", 0, -28)
		hH1:SetSize(200, 16)
		hH1:SetText("HuD")
		hH1:SetTextColor(unpack(nibRealUI.media.colors.red))
		
		-- HuD Sliders
		hcO.hudSVert = CreateSlider("HuDSliderVertical", -150, 150, L["Vertical"], 2)
		hcO.hudSVert:SetPoint("TOP", hH1, "BOTTOM", 0, -22)
		hcO.hudSVert:SetScript("OnValueChanged", function(self, value)
			hcO.hudSVert.value:SetText(value)
			ndb.positions[ndbc.resolution]["HuDY"] = value - 38
			nibRealUI:UpdatePositioners()
			if ndb.addonControl.msbt then HuDConfig:RegisterForUpdate("MSBT") end
			if ndb.addonControl.actionBars then HuDConfig:RegisterForUpdate("AB") end
		end)
		hcO.hudSVert:SetValue(ndb.positions[ndbc.resolution]["HuDY"] + 38)
		
		hcO.hudSWidth = CreateSlider("HuDSliderWidth", 100, 400, L["Width"], 2)
		hcO.hudSWidth:SetPoint("TOP", hcO.hudSVert, "BOTTOM", 0, -38)
		hcO.hudSWidth:SetScript("OnValueChanged", function(self, value)
			hcO.hudSWidth.value:SetText(value)
			ndb.positions[ndbc.resolution]["HuDWidth"] = value + 168
			nibRealUI:UpdatePositioners()
			if ndb.addonControl.msbt then HuDConfig:RegisterForUpdate("MSBT") end
			HuDConfig:RegisterForUpdate("HuD")
		end)
		hcO.hudSWidth:SetValue(ndb.positions[ndbc.resolution]["HuDWidth"] - 168)
	end
	
	-- Header Unit Frames
	local hUF1 = nibRealUI:CreateFS(hcO, "CENTER")
	hUF1:SetPoint("TOP", hcO, "TOP", -250, -28)
	hUF1:SetSize(200, 16)
	hUF1:SetText(UNITFRAME_LABEL)
	hUF1:SetTextColor(unpack(nibRealUI.media.colors.red))
	
	-- UF Sliders
	hcO.ufSHoriz = CreateSlider("UFSliderHorizontal", 0, 300, L["Horizontal"], 2)
	hcO.ufSHoriz:SetPoint("TOP", hUF1, "BOTTOM", 0, -22)
	hcO.ufSHoriz:SetScript("OnValueChanged", function(self, value)
		hcO.ufSHoriz.value:SetText(value)
		ndb.positions[ndbc.resolution]["UFHorizontal"] = value
		nibRealUI:UpdatePositioners()
		if ndb.addonControl.msbt then HuDConfig:RegisterForUpdate("MSBT") end
	end)
	hcO.ufSHoriz:SetValue(ndb.positions[ndbc.resolution]["UFHorizontal"])
	
	-- Header Bottom Item
	local hBI1 = nibRealUI:CreateFS(hcO, "CENTER")
	hBI1:SetPoint("TOP", hcO, "TOP", 250, -28)
	hBI1:SetSize(200, 16)
	hBI1:SetText(L["Action Bars / Grid"])
	hBI1:SetTextColor(unpack(nibRealUI.media.colors.red))
	
	-- BI Sliders
	hcO.biSVert = CreateSlider("BISliderVertical", -300, 0, L["Vertical"], 2)
	hcO.biSVert:SetPoint("TOP", hBI1, "BOTTOM", 0, -22)
	hcO.biSVert:SetScript("OnValueChanged", function(self, value)
		hcO.biSVert.value:SetText(value)
		ndb.positions[ndbc.resolution]["BIY"] = value
		nibRealUI:UpdatePositioners()
		if ndb.addonControl.actionBars then HuDConfig:RegisterForUpdate("AB") end
	end)
	hcO.biSVert:SetValue(ndb.positions[ndbc.resolution]["BIY"])
	
	-- Control MSBT checkbox
	hcO.controlmsbt = CreateCheckbox("ControlMSBT", hcO, "Control MSBT", "LEFT")
	hcO.controlmsbt:SetPoint("CENTER", hcO, "CENTER", -195, -20)
	hcO.controlmsbt:SetChecked(ndb.addonControl.msbt)
	hcO.controlmsbt:SetScript("OnClick", function(self)
		ndb.addonControl.msbt = self:GetChecked() and true or false
		if ndb.addonControl.msbt then
			HuDConfig:RegisterForUpdate("MSBT")
		end
	end)
	
	-- Control Action Bars checkbox
	hcO.controlab = CreateCheckbox("controlAB", hcO, "Control Action Bars", "RIGHT")
	hcO.controlab:SetPoint("CENTER", hcO, "CENTER", 195, -20)
	hcO.controlab:SetChecked(ndb.addonControl.actionBars)
	hcO.controlab:SetScript("OnClick", function(self)
		ndb.addonControl.actionBars = self:GetChecked() and true or false
		if ndb.addonControl.actionBars then
			HuDConfig:RegisterForUpdate("AB")
		else
			nibRealUI:ReloadUIDialog()
		end
	end)
	
	-- Control Grid checkbox
	hcO.controlgrid = CreateCheckbox("controlGrid", hcO, "Control Grid", "RIGHT")
	hcO.controlgrid:SetPoint("CENTER", hcO, "CENTER", 195, -46)
	hcO.controlgrid:SetChecked(ndb.addonControl.grid)
	hcO.controlgrid:SetScript("OnClick", function(self)
		ndb.addonControl.grid = self:GetChecked() and true or false
		if ndb.addonControl.grid then
			if nibRealUI:GetModuleEnabled("FrameMover") then
				local FM = nibRealUI:GetModule("FrameMover", true)
				if FM then FM:MoveAddons() end
			end
		else
			nibRealUI:ReloadUIDialog()
		end
	end)
	
	-- Arrows
	self.arrows = {}
	local a = self.arrows
	for i = 1, 4 do
		a[i] = CreateFrame("Frame", nil, UIParent)
		a[i]:Hide()
		a[i]:SetSize(64, 64)
		a[i].icon = a[i]:CreateTexture("ARTWORK")
		a[i].icon:SetAllPoints(a[i])
	end
	a[1].icon:SetTexture(Textures.ArrowVert)
	a[2].icon:SetTexture(Textures.ArrowVert)
	a[2].icon:SetTexCoord(0, 1, 1, 0)
	a[3].icon:SetTexture(Textures.ArrowHoriz)
	a[4].icon:SetTexture(Textures.ArrowHoriz)
	a[4].icon:SetTexCoord(1, 0, 0, 1)
	
	-- Grid Box
	hcO.gridBox = CreateFrame("Frame", "RealUIHuDConfigGridBox", UIParent)
	hcO.gridBox:Hide()
	
	-- Skin
	if Aurora then
		local F = Aurora[1]
		F.SetBD(hcO)
		F.Reskin(hcO.okay)
		F.Reskin(hcO.reset)
		F.Reskin(hcO.test)
		F.ReskinCheck(hcO.controlmsbt)
		F.ReskinCheck(hcO.controlab)
		F.ReskinCheck(hcO.controlgrid)
		ReskinSlider(hcO.hudSVert)
		ReskinSlider(hcO.hudSWidth)
		ReskinSlider(hcO.ufSHoriz)
		ReskinSlider(hcO.biSVert)
	end
end

-- Apply HuD width
function HuDConfig:ApplyHuDConfig()
	local newHuDWidth = ndb.positions[ndbc.resolution]["HuDWidth"] - 168
	nibIceHUD.IceCore.defaults["gap"..ndbc.resolution] = newHuDWidth
	nibIceHUD.IceCore:SetGap(newHuDWidth, ndbc.resolution)
	
	self.registeredUpdates["HuD"] = false
	self:CancelTimer(self.registeredTimers["HuD"])
	self.registeredTimers["HuD"] = nil
end

-- Apply AB positions
local abNeedUpdate = false
function HuDConfig:ApplyABConfig()
	if not ndb.addonControl.actionBars then return end
	if not IsAddOnLoaded("Bartender4") then return end
	
	local prof = ndbc.resolution == 1 and "RealUI" or "RealUI-HR"
	if not(Bartender4DB and Bartender4DB["namespaces"]["ActionBars"]["profiles"][prof]) then return end
	
	if not InCombatLockdown() then
		local zero = {
			x = -171.5,
			y = -147.5 
				+ ndb.positions[ndbc.resolution]["HuDY"]
				+ ndb.positions[ndbc.resolution]["BIY"]
		}
		
		-- Center Stance Bar
		local sbX = 20
		local NumStances = GetNumShapeshiftForms()
		if NumStances >= 1 then
			local sbP = Bartender4DB["namespaces"]["StanceBar"]["profiles"][prof]["padding"]
			local sbW = (NumStances * 30) + ((NumStances - 1) * sbP)
			sbX = -floor((sbW / 2)) - 5.5
		end
		
		local p = {
			stance =	{ x = sbX,			y = zero.y + 22	},
			bar1 =		{ x = zero.x,		y = zero.y		},
			bar2 =		{ x = zero.x,		y = zero.y - 27	},
			bar3 =		{ x = zero.x,		y = zero.y - 54	},
			vehicle =	{ x = zero.x + 4,	y = zero.y + 19 },
			pet1 =		{ x = zero.x + 39,	y = zero.y - 55 },
			pet2 =		{ x = zero.x + 39,	y = zero.y - 82 },
			eab =		{ x = zero.x + 140,	y = zero.y - 122},
		}
		
		-- Action Bars
		if Bartender4DB["namespaces"]["ActionBars"]["profiles"][prof]["actionbars"] then
			Bartender4DB["namespaces"]["ActionBars"]["profiles"][prof]["actionbars"][1]["position"] = {
				["x"] = p.bar1.x,
				["y"] = p.bar1.y,
				["point"] = "CENTER",
				["growHorizontal"] = "RIGHT",
				["growVertical"] = "DOWN",
			}
			Bartender4DB["namespaces"]["ActionBars"]["profiles"][prof]["actionbars"][2]["position"] = {
				["x"] = p.bar2.x,
				["y"] = p.bar2.y,
				["point"] = "CENTER",
				["growHorizontal"] = "RIGHT",
				["growVertical"] = "DOWN",
			}
			if ndbc.resolution == 2 then
				Bartender4DB["namespaces"]["ActionBars"]["profiles"][prof]["actionbars"][3]["position"] = {
					["x"] = p.bar3.x,
					["y"] = p.bar3.y,
					["point"] = "CENTER",
				["growHorizontal"] = "RIGHT",
				["growVertical"] = "DOWN",
				}
			end
		end
		-- Stance Bar
		if Bartender4DB["namespaces"]["StanceBar"]["profiles"][prof] then
			Bartender4DB["namespaces"]["StanceBar"]["profiles"][prof]["position"] = {
				["x"] = p.stance.x,
				["y"] = p.stance.y,
				["point"] = "CENTER",
				["scale"] = 1,
				["growHorizontal"] = "RIGHT",
				["growVertical"] = "DOWN",
			}
		end
		-- Vehicle Bar
		if Bartender4DB["namespaces"]["Vehicle"]["profiles"][prof] then
			Bartender4DB["namespaces"]["Vehicle"]["profiles"][prof]["position"] = {
				["x"] = p.vehicle.x,
				["y"] = p.vehicle.y,
				["point"] = "CENTER",
				["scale"] = 0.6,
				["growHorizontal"] = "RIGHT",
				["growVertical"] = "DOWN",
			}
		end
		-- Pet Bar
		if Bartender4DB["namespaces"]["PetBar"]["profiles"][prof] then
			Bartender4DB["namespaces"]["PetBar"]["profiles"][prof]["position"] = {
				["x"] = p["pet"..ndbc.resolution].x,
				["y"] = p["pet"..ndbc.resolution].y,
				["point"] = "CENTER",
				["growHorizontal"] = "RIGHT",
				["growVertical"] = "DOWN",
			}
		end
		-- Extra Action Bar
		if nibRealUI.db.global.tags.ldOptimized and Bartender4DB["namespaces"]["ExtraActionBar"]["profiles"]["RealUI-HR"] then
			Bartender4DB["namespaces"]["ExtraActionBar"]["profiles"]["RealUI-HR"] = {
				["position"] = {
					["y"] = p.eab.y,
					["x"] = p.eab.x,
					["point"] = "CENTER",
					["growHorizontal"] = "RIGHT",
					["growVertical"] = "DOWN",
				},
				["version"] = 3,
			}
		end
		
		-- Apply profile changes to Bartender bars
		local Bar4 = LibStub("AceAddon-3.0"):GetAddon("Bartender4", true)
		local B4Bars = Bar4:GetModule("ActionBars", true)
		local B4Stance = Bar4:GetModule("StanceBar", true)
		local B4Vehicle = Bar4:GetModule("Vehicle", true)
		local B4PetBar = Bar4:GetModule("PetBar", true)
		local B4EAB = Bar4:GetModule("ExtraActionBar", true)

		if B4Bars then B4Bars:ApplyConfig() end
		if B4Stance then B4Stance:ApplyConfig() end
		if B4Vehicle then B4Vehicle:ApplyConfig() end
		if B4PetBar then B4PetBar:ApplyConfig() end
		if B4EAB then B4EAB:ApplyConfig() end
		
		-- ActionBarExtras
		if nibRealUI:GetModuleEnabled("ActionBarExtras") then
			local ABE = nibRealUI:GetModule("ActionBarExtras", true)
			if ABE then ABE:RefreshMod() end
		end
		
		self.registeredUpdates["AB"] = false
	end
	
	if not self.registeredUpdates["AB"] then self:CancelTimer(self.registeredTimers["AB"]) end
	self.registeredTimers["AB"] = nil
end

-- Apply MSBT positions
function HuDConfig:ApplyMSBTConfig()
	if not ndb.addonControl.msbt then return end
	if not IsAddOnLoaded("MikScrollingBattleText") then return end
	
	local prof = ndbc.resolution == 1 and "RealUI" or "RealUI-HR"
	if not(MSBTProfiles_SavedVars and MSBTProfiles_SavedVars["profiles"][prof]) then return end
	
	local incWidth = MSBTProfiles_SavedVars["profiles"][prof]["scrollAreas"]["Incoming"]["scrollWidth"] or 130
	local notifyWidth = MSBTProfiles_SavedVars["profiles"][prof]["scrollAreas"]["Notification"]["scrollWidth"] or 300
	local xPos = ndb.positions[ndbc.resolution]["HuDX"] 
				+ (ndb.positions[ndbc.resolution]["UFHorizontal"] / 2)
				+ (ndb.positions[ndbc.resolution]["HuDWidth"] / 2)
				+ 32
	local yPos = ndb.positions[ndbc.resolution]["HuDY"] + 48
	
	local MSBTPositions = {
		incoming = {x = -xPos - incWidth, y = yPos},
		outgoing = {x = xPos, y = yPos},
		notification = {
			x = ndb.positions[ndbc.resolution]["HuDX"] - (notifyWidth / 2),
			y = ndb.positions[ndbc.resolution]["HuDY"] + 98
		},
	}
	
	if MSBTProfiles_SavedVars["profiles"][prof]["scrollAreas"]["Incoming"] then
		MSBTProfiles_SavedVars["profiles"][prof]["scrollAreas"]["Incoming"]["offsetX"] = MSBTPositions.incoming.x
		MSBTProfiles_SavedVars["profiles"][prof]["scrollAreas"]["Incoming"]["offsetY"] = MSBTPositions.incoming.y
	end
	if MSBTProfiles_SavedVars["profiles"][prof]["scrollAreas"]["Outgoing"] then
		MSBTProfiles_SavedVars["profiles"][prof]["scrollAreas"]["Outgoing"]["offsetX"] = MSBTPositions.outgoing.x
		MSBTProfiles_SavedVars["profiles"][prof]["scrollAreas"]["Outgoing"]["offsetY"] = MSBTPositions.outgoing.y
	end
	if MSBTProfiles_SavedVars["profiles"][prof]["scrollAreas"]["Notification"] then
		MSBTProfiles_SavedVars["profiles"][prof]["scrollAreas"]["Notification"]["offsetX"] = MSBTPositions.notification.x
		MSBTProfiles_SavedVars["profiles"][prof]["scrollAreas"]["Notification"]["offsetY"] = MSBTPositions.notification.y
	end
	
	self.registeredUpdates["MSBT"] = false
	self:CancelTimer(self.registeredTimers["MSBT"])
	self.registeredTimers["MSBT"] = nil
end

function HuDConfig:RegisterForUpdate(addon)
	self.registeredUpdates[addon] = true
	if not self.registeredTimers[addon] then
		self.registeredTimers[addon] = self:ScheduleRepeatingTimer("Apply"..addon.."Config", 0.1)
	end
end

function HuDConfig:PLAYER_REGEN_DISABLED()
	RealUIHuDCloseConfig()
end

----------
function HuDConfig:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {},
	})
	ndb = nibRealUI.db.profile
	ndbc = nibRealUI.db.char
	
	self.registeredUpdates = {}
	self.registeredTimers = {}
end

function HuDConfig:OnEnable()
	if ndb.addonControl.msbt then self:RegisterForUpdate("MSBT") end
	if ndb.addonControl.actionBars then
		self:RegisterForUpdate("AB")
		self:RegisterEvent("UPDATE_SHAPESHIFT_FORMS", function()
			self:RegisterForUpdate("AB")
		end)
	end
end

SlashCmdList.HUD = function()
	HuDConfig:InitHuDConfig()
end
SLASH_HUD1 = "/hud"