local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local LSM = LibStub("LibSharedMedia-3.0")
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local MODNAME = "ItemQuality"
local ItemQuality = nibRealUI:NewModule(MODNAME, "AceEvent-3.0", "AceBucket-3.0", "AceHook-3.0")
local _

-- Flags / Tables
local BordersSet = false
local ItemsList, NDItemsList

----
local function GetThresholdColour(percent)
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

function ItemQuality:CreateBorder(slottype, slot, name, hasText)
	local gslot = _G[slottype..slot.."Slot"]
	local height = 37
	local width = 37
	
	if gslot then
		local border = CreateFrame("Frame", slot .. name .. "B", gslot)
		border:SetParent(gslot)
		border:SetHeight(height)
		border:SetWidth(width)
		border:SetPoint("CENTER", gslot, "CENTER", 0, 0)
		border:SetAlpha(0.8)
		border:SetBackdrop({
			bgFile = [[Interface\AddOns\nibRealUI\Media\Plain]], 
			edgeFile = [[Interface\AddOns\nibRealUI\Media\Plain]], 
			tile = false, tileSize = 0, edgeSize = 1, 
			insets = { left = 0, right = 0, top = 0, bottom = 0}
		})
		border:SetBackdropColor(0,0,0,0)
		border:SetBackdropBorderColor(0,0,0,0)
		border:Hide()
		
		if hasText then
			local str = gslot:CreateFontString(slot .. name .. "S", "OVERLAY")
			str:SetFont(unpack(nibRealUI.font.pixel1))
			str:SetPoint("CENTER", gslot, "BOTTOM", 2, 6.5)
		end
	end
end

function ItemQuality:MakeTypeTable()
	ItemsList = {"Head", "Shoulder", "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands", "MainHand", "SecondaryHand"}
	NDItemsList = {"Neck", "Back", "Finger0", "Finger1", "Trinket0", "Trinket1", "Tabard", "Shirt"}
	for _, item in ipairs(ItemsList) do
		self:CreateBorder("Character", item, "ItemQuality", true)
	end
	for _, nditem in ipairs(NDItemsList) do
		self:CreateBorder("Character", nditem, "ItemQuality", false)
	end
end

function ItemQuality:UpdateItems()
	if not CharacterFrame:IsVisible() then return end
	
	for _, item in ipairs(ItemsList) do
		local id, _ = GetInventorySlotInfo(item .. "Slot")
		local str = _G[item.."ItemQualityS"]
		local v1, v2 = GetInventoryItemDurability(id)
		v1, v2 = tonumber(v1) or 0, tonumber(v2) or 0
		local percent
		if v1 == 0 or v2 == 0 then
			percent = 0
		else
			percent = v1 / v2 * 100
		end
		
		if (v2 ~= 0) then
			local text
			str:SetTextColor(GetThresholdColour(v1/v2))
			text = string.format("%d%%", percent)
			str:SetText(text)
		else
			str:SetText("")
		end
		
		self:ColourBorders(id, item)
	end
	
	self:ColourBordersND()
end

function ItemQuality:CharacterFrame_OnShow()
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "UpdateItems")
	self:RegisterBucketEvent("UPDATE_INVENTORY_DURABILITY", 0.5, "UpdateItems")
	self:UpdateItems()
end

function ItemQuality:CharacterFrame_OnHide()
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED")
	self:UnregisterBucket("UPDATE_INVENTORY_DURABILITY")
end

function ItemQuality:ColourBorders(SlotID, RawSlot)
	local quality = GetInventoryItemQuality("player", SlotID)
	if quality then
		local r, g, b, _ = GetItemQualityColor(quality)
		_G[RawSlot.."ItemQualityB"]:SetBackdropBorderColor(r, g, b)
		_G[RawSlot.."ItemQualityB"]:Show()
	else
		_G[RawSlot.."ItemQualityB"]:Hide()
	end
end

function ItemQuality:ColourBordersND()
	for _, nditem in ipairs(NDItemsList) do
		if _G["Character"..nditem.."Slot"] then
			local SlotID, _ = GetInventorySlotInfo(nditem .. "Slot")
			local quality = GetInventoryItemQuality("player", SlotID)
			if quality then
				local r, g, b, _ = GetItemQualityColor(quality)
				_G[nditem.."ItemQualityB"]:SetBackdropBorderColor(r, g, b)
				_G[nditem.."ItemQualityB"]:Show()
			else
				_G[nditem.."ItemQualityB"]:Hide()
			end
		end
	end
end

function ItemQuality:BorderToggle()
	self:UpdateItems()
end

--------------------
-- Initialization --
--------------------
function ItemQuality:OnInitialize()
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
end

function ItemQuality:OnEnable()
	self:SecureHookScript(CharacterFrame, "OnShow", "CharacterFrame_OnShow")
	self:SecureHookScript(CharacterFrame, "OnHide", "CharacterFrame_OnHide")
	if not BordersSet then
		self:MakeTypeTable()
	end
end