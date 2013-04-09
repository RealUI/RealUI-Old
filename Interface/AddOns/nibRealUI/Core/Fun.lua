local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local L = LibStub("AceLocale-3.0"):GetLocale("nibRealUI")
local LSM = LibStub("LibSharedMedia-3.0")

-- Color table to String
function FindSpellID(SpellName)
	print("|cffffff20 SpellID tracking active. When |r|cffffffff"..SpellName.."|r|cffffff20 next activates, the SpellID will be printed in the chat window.|r")
	local f = CreateFrame("FRAME")
	f:RegisterEvent("UNIT_AURA")
	f:SetScript("OnEvent", function(self, event, ...)
		if ... == "player" then
			local spellID = select(11, UnitAura("player", SpellName))
			if spellID then
				print(SpellName..": #", spellID); 
				f:UnregisterEvent("UNIT_AURA")
			end
		end
	end)
end

function nibRealUI:GetResolutionVals()
	local resStr = GetCVar("gxResolution")
	local resHeight = tonumber(string.match(resStr, "%d+x(%d+)"))
	local resWidth = tonumber(string.match(resStr, "(%d+)x%d+"))

	return resWidth, resHeight
end
function nibRealUI:DeepCopy(object)
	local lookup_table = {}
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end
		local new_table = {}
		lookup_table[object] = new_table
		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end
		return setmetatable(new_table, getmetatable(object))
	end
	return _copy(object)
end

function nibRealUI:ColorTableToStr(vals)
	return string.format("%02x%02x%02x", vals[1] * 255, vals[2] * 255, vals[3] * 255)
end

function nibRealUI:Round(value, places)
    return (("%%.%df"):format(places or 0)):format(value)
end

function nibRealUI:Clamp(value, min, max)
	if value < min then
		value = min
	elseif value > max then
		value = max
	elseif value ~= value or not (value >= min and value <= max) then -- check for nan...
		value = min
	end

	return value
end

function nibRealUI:CreateBD(frame, alpha)
	frame:SetBackdrop({
		bgFile = nibRealUI.media.textures.plain, 
		edgeFile = nibRealUI.media.textures.plain, 
		edgeSize = 1, 
	})
	frame:SetBackdropColor(0, 0, 0, alpha or nibRealUI.media.backgroundalpha)
	frame:SetBackdropBorderColor(0, 0, 0)
end

function nibRealUI:CreateBDFrame(f, a)
	local frame
	if f:GetObjectType() == "Texture" then
		frame = f:GetParent()
	else
		frame = f
	end

	local lvl = frame:GetFrameLevel()

	local bg = CreateFrame("Frame", nil, frame)
	bg:SetPoint("TOPLEFT", f, -1, 1)
	bg:SetPoint("BOTTOMRIGHT", f, 1, -1)
	bg:SetFrameLevel(lvl == 0 and 1 or lvl - 1)

	nibRealUI:CreateBD(bg, a or nibRealUI.media.backgroundalpha)

	return bg
end

function nibRealUI:CreateBG(frame, alpha)
	local f = frame
	if frame:GetObjectType() == "Texture" then f = frame:GetParent() end

	local bg = f:CreateTexture(nil, "BACKGROUND")
	bg:SetPoint("TOPLEFT", f, -1, 1)
	bg:SetPoint("BOTTOMRIGHT", f, 1, -1)
	bg:SetTexture(nibRealUI.media.textures.plain)
	bg:SetVertexColor(0, 0, 0, alpha or nibRealUI.media.backgroundalpha)

	return bg
end

function nibRealUI:CreateBGSection(parent, f1, f2, ...)
	-- Button Backgrounds
	local x1, y1, x2, y2 = -2, 2, 2, -2
	if ... then
		x1, y1, x2, y2 = ...
	end
	local Sect1 = CreateFrame("Frame", nil, parent)
	Sect1:SetPoint("TOPLEFT", f1, "TOPLEFT", x1, y1)
	Sect1:SetPoint("BOTTOMRIGHT", f2, "BOTTOMRIGHT", x2, y2)
	nibRealUI:CreateBD(Sect1)
	Sect1:SetBackdropColor(0.8, 0.8, 0.8, 0.15)
	Sect1:SetFrameLevel(parent:GetFrameLevel() + 1)
end

function nibRealUI:CreateInnerBG(frame)
	local f = frame
	if frame:GetObjectType() == "Texture" then f = frame:GetParent() end

	local bg = f:CreateTexture(nil, "BACKGROUND")
	bg:SetPoint("TOPLEFT", frame, 1, -1)
	bg:SetPoint("BOTTOMRIGHT", frame, -1, 1)
	bg:SetTexture(nibRealUI.media.textures.plain)
	bg:SetVertexColor(0, 0, 0, 0)

	return bg
end

function nibRealUI:CreateFS(parent, justify, ...)
	local f = parent:CreateFontString(nil, "OVERLAY")
	local size
	if ... then 
		size = ...
	else
		size = nibRealUI.font.pixel1[2]
	end
	f:SetFont(nibRealUI.font.pixel1[1], size, nibRealUI.font.pixel1[3])
	f:SetShadowColor(0, 0, 0, 0)
	if justify then f:SetJustifyH(justify) end
	return f
end

local function FormatToDecimalPlaces(num, places)
	local placeValue = ("%%.%df"):format(places)
	return placeValue:format(num)
end
function nibRealUI:ReadableNumber(num)
	local ret = 0
	if not num then
		return 0
	elseif num >= 100000000 then
		ret = FormatToDecimalPlaces(num / 1000000, 0) .. "m" -- hundred million
	elseif num >= 10000000 then
		ret = FormatToDecimalPlaces(num / 1000000, 1) .. "m" -- ten million
	elseif num >= 1000000 then
		ret = FormatToDecimalPlaces(num / 1000000, 2) .. "m" -- million
	elseif num >= 100000 then
		ret = FormatToDecimalPlaces(num / 1000, 0) .. "k" -- hundred thousand
	elseif num >= 10000 then
		ret = FormatToDecimalPlaces(num / 1000, 1) .. "k" -- ten thousand
	elseif num >= 1000 then
		ret = FormatToDecimalPlaces(num / 1000, 2) .. "k" -- thousand
	else
		ret = num -- hundreds
	end
	return ret
end

-- Reload UI dialog
function nibRealUI:ReloadUIDialog()
	LibStub("AceConfigDialog-3.0"):Close("nibRealUI")

	-- Display Dialog
	StaticPopupDialogs["PUDRUIRELOADUI"] = {
		text = L["You need to Reload the UI for changes to take effect. Reload Now?"],
		button1 = "Yes",
		button2 = "No",
		OnAccept = function()
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		notClosableByLogout = false,
	}
	StaticPopup_Show("PUDRUIRELOADUI")
end

-- Font Retrieval
function nibRealUI:RetrieveFont(font)
	local font = LSM:Fetch("font", font)
	if font == nil then font = GameFontNormalSmall:GetFont() end
	return font
end

function nibRealUI:GetFont(fontID)
	local font = {}
	if fontID == "small" then
		if self.db.char.resolution == 1 then
			font = {self:RetrieveFont(self.media.font.pixel.lowres.small[1]), self.media.font.pixel.lowres.small[2], self.media.font.pixel.lowres.small[3]}
		else
			font = {self:RetrieveFont(self.media.font.pixel.highres.small[1]), self.media.font.pixel.highres.small[2], self.media.font.pixel.highres.small[3]}
		end
	elseif fontID == "large" then
		if self.db.char.resolution == 1 then
			font = {self:RetrieveFont(self.media.font.pixel.lowres.large[1]), self.media.font.pixel.lowres.large[2], self.media.font.pixel.lowres.large[3]}
		else
			font = {self:RetrieveFont(self.media.font.pixel.highres.large[1]), self.media.font.pixel.highres.large[2], self.media.font.pixel.highres.large[3]}
		end
	else
		font = self:RetrieveFont(self.media.font.standard[1])
	end
	return font
end

-- Memory Display
local function FormatMem(memory)
	if ( memory > 999 ) then
		return format("%.1f |cff%s%s|r", memory/1024, "ff8030", "MiB")
	else
		return format("%.1f |cff%s%s|r", memory, "80ff30", "KB")
	end
end

function nibRealUI:MemoryDisplay()
	local addons, total = {}, 0
	UpdateAddOnMemoryUsage()
	local memory = gcinfo()
	
	for i = 1, GetNumAddOns() do
		if ( IsAddOnLoaded(i) ) then
			table.insert(addons, { GetAddOnInfo(i), GetAddOnMemoryUsage(i) })
			total = total + GetAddOnMemoryUsage(i)
		end
	end
	
	table.sort(addons, (function(a, b) return a[2] > b[2] end))
	
	local userMem = format("|cff00ffffMemory usage: |r%.1f |cffff8030%s|r", total/1024, "MiB")
	print(userMem)
	print("-------------------------------")
	for key, val in pairs(addons) do
		if ( key <= 20 ) then
			print(FormatMem(val[2]).."  -  "..val[1])
		end
	end
end

-- Opposite Faction
function nibRealUI:OtherFaction(f)
	if (f == "Horde") then
		return "Alliance"
	else
		return "Horde"
	end
end

-- Validate Offset
function nibRealUI:ValidateOffset(value, ...)
	local val = tonumber(value)
	local vmin, vmax = -5000, 5000
	if ... then vmin, vmax = ... end	
	if val == nil then val = 0 end
	val = max(val, vmin)
	val = min(val, vmax)
	return val
end

-- Durability Color
function nibRealUI:GetDurabilityColour(percent)
	if percent < 0 then
		return 1, 0, 0
	elseif percent <= 0.5 then
		return 1, percent * 2, 0
	elseif percent >= 1 then
		return 0, 1, 0
	else
		return 2 - percent * 2, 1, 0
	end
end

-- Item Level Color
local ilvlLimits = {
	normal = 385,
	uncommon = 437,
	rare = 463,
}
function nibRealUI:GetILVLColor(ilvl)
	if ilvl >= ilvlLimits.rare then
		return {GetItemQualityColor(4)}
	elseif ilvl >= ilvlLimits.uncommon then
		return {GetItemQualityColor(3)}
	elseif ilvl >= ilvlLimits.normal then
		return {GetItemQualityColor(2)}
	else
		return {0.8, 0.8, 0.8, "ffd0d0d0"}
	end
end

-- Class Color
function nibRealUI:GetClassColor(class, ...)
	if not RAID_CLASS_COLORS[class] then return {1, 1, 1} end
	local classColors = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
	if ... then
		return {r = classColors.r, g = classColors.g, b = classColors.b}
	else
		return {classColors.r, classColors.g, classColors.b}
	end
end