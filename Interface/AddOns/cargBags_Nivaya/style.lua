local addon, ns = ...
local cargBags = ns.cargBags

local L = cBnivL

local Fonts = {
	[1] = {"Interface\\AddOns\\cargBags_Nivaya\\media\\pixel.ttf", 8, "Outlinemonochrome"},
	[2] = {"Interface\\AddOns\\cargBags_Nivaya\\media\\pixel_hr.ttf", 8, "Outlinemonochrome"},
}
------------------------------------------
-- MyContainer specific
------------------------------------------
local cbNivaya = cargBags:GetImplementation("Nivaya")
local MyContainer = cbNivaya:GetContainerClass()

local GetNumFreeSlots = function(bagType)
	local free, max = 0, 0
	if bagType == "bag" then
		for i = 0,4 do
			free = free + GetContainerNumFreeSlots(i)
			max = max + GetContainerNumSlots(i)
		end
	else
		local containerIDs = {-1,5,6,7,8,9,10,11}
		for _,i in next, containerIDs do	
			free = free + GetContainerNumFreeSlots(i)
			max = max + GetContainerNumSlots(i)
		end
	end
	return free, max
end

local QuickSort;
do
	local func = function(v1, v2)
		if (v1 == nil) or (v2 == nil) then return (v1 and true or false) end
		if v1[1] == -1 or v2[1] == -1 then
			return v1[1] > v2[1] -- empty slots last
		elseif v1[2] ~= v2[2] then
			if v1[2] and v2[2] then
				return v1[2] > v2[2] -- higher quality first
			elseif (v1[2] == nil) or (v2[2] == nil) then
				return (v1[2] and true or false)
			else
				return false
			end
		elseif v1[1] ~= v2[1] then
			return v1[1] > v2[1] -- group identical item ids
		else
			return v1[4] > v2[4] -- full/larger stacks first
		end
	end;
	QuickSort = function(tbl) table.sort(tbl, func) end
end

local SkinButton = function(btn)
	if Aurora then
		local F, C = unpack(Aurora)
		local _,class = UnitClass("player")
		F.Reskin(btn)
		
		-- Button Highlight
		btn.highlight = CreateFrame("Frame", nil, btn)
		btn.highlight:SetPoint("CENTER", btn, "CENTER", 0, 0)
		btn.highlight:SetWidth(btn:GetWidth())
		btn.highlight:SetHeight(btn:GetHeight())
		btn.highlight:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8x8", 
			edgeFile = "Interface\\Buttons\\WHITE8x8", 
			tile = false, tileSize = 0, edgeSize = 1, 
			insets = { left = 1, right = 1, top = 1, bottom = 1	}
		})
		btn.highlight:SetBackdropColor(0,0,0,0)
		btn.highlight:SetBackdropBorderColor(C.classcolours[class].r, C.classcolours[class].g, C.classcolours[class].b)
	end
end

function MyContainer:OnContentsChanged()

	local col, row = 0, 0
	local yPosOffs = self.Caption and 20 or 0
	local isEmpty = true

	local tName = self.name
	local tBankBags = string.find(tName, "cBniv_Bank%a+")
	local tBank = tBankBags or (tName == "cBniv_Bank")

	local buttonIDs = {}
  	for i, button in pairs(self.buttons) do
		local item = cbNivaya:GetItemInfo(button.bagID, button.slotID)
		if item.link then
			local _,_,tQ = GetItemInfo(item.link)
			local _,cnt = GetContainerItemInfo(button.bagID, button.slotID)
			buttonIDs[i] = { item.id, tQ, button, cnt }
		else
			buttonIDs[i] = { -1, -2, button, -1 }
		end
	end
	if (tBank and cBnivCfg.SortBank) or (not tBank and cBnivCfg.SortBags) then QuickSort(buttonIDs) end

	for _,v in ipairs(buttonIDs) do
		local button = v[3]
		button:ClearAllPoints()
	  
		local xPos = col * (38+2) + 2
		local yPos = (-1 * row * (38+2)) - yPosOffs

		button:SetPoint("TOPLEFT", self, "TOPLEFT", xPos, yPos)
		if(col >= self.Columns-1) then
			col = 0
			row = row + 1
		else
			col = col + 1
		end
		isEmpty = false
	end

	if cBnivCfg.CompressEmpty then
		local xPos = col * (38+2) + 2
		local yPos = (-1 * row * (38+2)) - yPosOffs

		local tDrop = self.DropTarget
		if tDrop then
			tDrop:ClearAllPoints()
			tDrop:SetPoint("TOPLEFT", self, "TOPLEFT", xPos, yPos)
			if(col >= self.Columns-1) then
				col = 0
				row = row + 1
			else
				col = col + 1
			end
		end
		
		cB_Bags.main.EmptySlotCounter:SetText(GetNumFreeSlots("bag"))
		cB_Bags.bank.EmptySlotCounter:SetText(GetNumFreeSlots("bank"))
	end
	
	-- This variable stores the size of the item button container
	self.ContainerHeight = (row + (col > 0 and 1 or 0)) * (38+2)

	if (self.UpdateDimensions) then self:UpdateDimensions() end -- Update the bag's height
	local t = (tName == "cBniv_Bag") or (tName == "cBniv_Bank") 
	local tAS = (tName == "cBniv_Ammo") or (tName == "cBniv_Soulshards")
	if (not tBankBags and cB_Bags.main:IsShown() and not (t or tAS)) or (tBankBags and cB_Bags.bank:IsShown()) then 
		if isEmpty then self:Hide() else self:Show() end 
	end

	cB_BagHidden[tName] = (not t) and isEmpty or false
	cbNivaya:UpdateAnchors(self)
end

--[[function MyContainer:OnButtonAdd(button)
	if not button.Border then return end
 
	local _,bagType = GetContainerNumFreeSlots(button.bagID)
	if button.bagID == KEYRING_CONTAINER then
		button.Border:SetBackdropBorderColor(0, 0, 0)	  -- Key ring
	elseif bagType and bagType > 0 and bagType < 8 then
		button.Border:SetBackdropBorderColor(1, 1, 0)		-- Ammo bag
	elseif bagType and bagType > 4 then
		button.Border:SetBackdropBorderColor(1, 1, 1)		-- Profession bags
	else
		button.Border:SetBackdropBorderColor(0, 0, 0)		-- Normal bags
	end
end]]--

-- Restack Items
local ContainerID = { bags = { 0 }, bank = { -1 }, guild = { 42 } }
for i = 1, NUM_BAG_SLOTS do table.insert(ContainerID.bags, i) end
for i = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do table.insert(ContainerID.bank, i) end

-- yielding function; items will get locked and we have to wait
local f = CreateFrame("Frame")
local function coYield(loc, bag, slot, count)
	local elapsed = 0
	f:SetScript("OnUpdate", function(_, update)
		elapsed = elapsed + update
		if type(restacker) == "thread" and coroutine.status(restacker) == "suspended" and elapsed > 0.1 then
			local locked = true
			locked = select(3, GetContainerItemInfo(bag, slot))
			if not locked then coroutine.resume(restacker) end
			elapsed = 0
		end
	end)
	coroutine.yield()
end

local restackItems = function(self)
	local tBag, tBank = (self.name == "cBniv_Bag"), (self.name == "cBniv_Bank")
	local loc = tBank and "bank" or "bags"
	
	if type(restacker) ~= "thread" or coroutine.status(restacker) == "dead" then
		restacker = coroutine.create(function()
			tabswap = 0
			local changed = true
			while changed do
				changed = false
				for _, bag in ipairs(ContainerID[loc]) do
					if changed then break end
					for slot = 1, (GetContainerNumSlots(bag)) do
						while true do
							local locked = select(3, GetContainerItemInfo(bag, slot))
							if locked then coYield(loc, bag, slot) else break end
						end
						local item = GetContainerItemLink(bag, slot)
						if item then
							local itemid = tonumber(item:match("item:(%d+)"))
							local stack = select(8, GetItemInfo(itemid))
							local count = select(2, GetContainerItemInfo(bag, slot))

							-- do "special" things with "special" items by moving them into "special" bags
							if select(9, GetItemInfo(itemid)) ~= "INVTYPE_BAG" then
								local bagType = (bag ~= 0 and bag ~= -1) and GetItemFamily(GetInventoryItemLink("player", ContainerIDToInventoryID(bag))) or 0								
								for _, sbag in ipairs(ContainerID[loc]) do
									if sbag > 0 and GetContainerNumFreeSlots(sbag) > 0 then
										local sbagID = ContainerIDToInventoryID(sbag)
										local sbagType = GetItemFamily(GetInventoryItemLink("player", sbagID))
										local itemType = GetItemFamily(item)

										if sbagType > 0 and sbagType == itemType and bagType == 0 then
											PickupContainerItem(bag, slot)
											PutItemInBag(sbagID)
											coYield(loc, bag, slot)
											break
										end
									end
								end	
							end
							if count < stack then
								-- found a partial stack
								local locked, found, done, pbag, pslot
								while true do
									-- search through bags backwards for another partial stack with a matching itemid
									for i = #ContainerID[loc], 1, -1 do
										local _bag = ContainerID[loc][i]
										if found or done then break end
										local _slots = GetContainerNumSlots(_bag)
										for _slot = _slots, 1, -1 do
											if not (_bag == bag and _slot == slot) then
												local _item = GetContainerItemLink(_bag, _slot)
												if _item then
													local _itemid = tonumber(_item:match("item:(%d+):"))
													if _itemid == itemid then
														local _stack = select(8, GetItemInfo(_itemid))
														local _count = select(2, GetContainerItemInfo(_bag, _slot))
														if _count < _stack then found, pbag, pslot = true, _bag, _slot; break end
													end
												end
											else done = true; break end
										end
									end
									locked = found and select(3, GetContainerItemInfo(pbag, pslot)) or false
									if locked then coYield(loc, pbag, pslot) else break end
								end

								if found then
									ClearCursor()

									-- if second partial stack is inside a special bag, move the original stack into it
									local bagType = (bag ~= 0 and bag ~= -1) and GetItemFamily(GetInventoryItemLink("player", ContainerIDToInventoryID(bag))) or 0
									local pbagType = (pbag ~= 0 and pbag ~= -1) and GetItemFamily(GetInventoryItemLink("player", ContainerIDToInventoryID(pbag))) or 0
									if pbagType > 0 and bagType == 0 then
										PickupContainerItem(bag, slot)
										PickupContainerItem(pbag, pslot)
									else
										PickupContainerItem(pbag, pslot)
										PickupContainerItem(bag, slot)
									end
									
									ClearCursor()
									
									changed = true
									break
								end
							end
						end
					end
				end
			end
			-- turn off yielding function
			f:SetScript("OnUpdate", nil)
		end)
		coroutine.resume(restacker)
	end	
end

-- Reset New
local resetNewItems = function(self)
	cB_KnownItems = {}
	for i = 0,4 do
		local tNumSlots = GetContainerNumSlots(i)
		if tNumSlots > 0 then
			for j = 1,tNumSlots do
				local tLink = GetContainerItemLink(i,j)
				if tLink then
					if (strsub(tLink, 13, 21) == "battlepet") then
						local _, tName = strmatch(tLink, "|H(.-)|h(.-)|h")
						local _,tStackCount = GetContainerItemInfo(i,j)
						if cB_KnownItems[tName] then
							cB_KnownItems[tName] = cB_KnownItems[tName] + tStackCount
						else
							cB_KnownItems[tName] = tStackCount
						end
					else	
						local tName = GetItemInfo(tLink)
						local _,tStackCount = GetContainerItemInfo(i,j)
						if cB_KnownItems[tName] then
							cB_KnownItems[tName] = cB_KnownItems[tName] + tStackCount
						else
							cB_KnownItems[tName] = tStackCount
						end
					end
				end
			end 
		end
	end
	cbNivaya:UpdateBags()
end

local UpdateDimensions = function(self)
	local height = 0			-- Normal margin space
	if self.BagBar and self.BagBar:IsShown() then
		height = height + 43	-- Bag button space
	end
	if self.Space then
		height = height + 16	-- additional info display space
	end
	if self.bagToggle then
		local tBag = (self.name == "cBniv_Bag")
		local extraHeight = (tBag and self.hintShown) and 12 or 0
		height = height + 24 + extraHeight
	end
	if self.Caption then		-- Space for captions
		height = height + 20
	end
	self:SetHeight(self.ContainerHeight + height)
end

local SetFrameMovable = function(f, v)
	f:SetMovable(true)
	f:SetUserPlaced(true)
	f:RegisterForClicks("LeftButton", "RightButton")
	if v then 
		f:SetScript("OnMouseDown", function() 
			f:ClearAllPoints() 
			f:StartMoving() 
		end)
		f:SetScript("OnMouseUp",  f.StopMovingOrSizing)
	else
		f:SetScript("OnMouseDown", nil)
		f:SetScript("OnMouseUp", nil)
	end
end

local createTextButton = function (name, parent, width, height)
	local button = CreateFrame("Button", nil, parent)
	button:SetWidth(width)
	button:SetHeight(height)
	button:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Buttons\\WHITE8x8",
		tile = false, tileSize = 16, edgeSize = 1,
		insets = {left = -1, right = -1, top = -1, bottom = -1},
	})
	button:SetBackdropColor(0, 0, 0, 0)
	button:SetBackdropBorderColor(.5, .5, .5, 1)
	return button
end


local GetFirstFreeSlot = function(bagtype)
	if bagtype == "bag" then
		for i = 0,4 do
			local t = GetContainerNumFreeSlots(i)
			if t > 0 then
				local tNumSlots = GetContainerNumSlots(i)
				for j = 1,tNumSlots do
					local tLink = GetContainerItemLink(i,j)
					if not tLink then return i,j end
				end
			end
		end
	else
		local containerIDs = {-1,5,6,7,8,9,10,11}
		for _,i in next, containerIDs do
			local t = GetContainerNumFreeSlots(i)
			if t > 0 then
				local tNumSlots = GetContainerNumSlots(i)
				for j = 1,tNumSlots do
					local tLink = GetContainerItemLink(i,j)
					if not tLink then return i,j end
				end
			end
		end	
	end
	return false
end

function MyContainer:OnCreate(name, settings)
	local pixelFont = Fonts[1]
	
	settings = settings or {}
	self.Settings = settings
	self.name = name

	local tBag, tBank = (name == "cBniv_Bag"), (name == "cBniv_Bank")
	local tBankBags = string.find(name, "Bank")
	
	local numSlotsBag = {GetNumFreeSlots("bag")}
	local numSlotsBank = {GetNumFreeSlots("bank")}
	
	local usedSlotsBag = numSlotsBag[2] - numSlotsBag[1]
	local usedSlotsBank = numSlotsBank[2] - numSlotsBank[1]

	self:EnableMouse(true)
	
	self.UpdateDimensions = UpdateDimensions
	
	self:SetFrameStrata("HIGH")
	tinsert(UISpecialFrames, self:GetName()) -- Close on "Esc"

	if tBag or tBank then 
		SetFrameMovable(self, cBnivCfg.Unlocked) 
	end

	if tBank or tBankBags then
		-- self.Columns = (usedSlotsBank > 112) and 12 or 10
		self.Columns = 10
	else
		-- self.Columns = (usedSlotsBag > 56) and 10 or 8
		self.Columns = 8
	end
	self.ContainerHeight = 0
	self:UpdateDimensions()
	self:SetWidth((38+2)*self.Columns+1)

	-- The frame background
	local tBankCustom = (tBankBags and not cBnivCfg.BankBlack)
	local color_rb = 0.05
	local color_gb = tBankCustom and .4 or 0.05
	local color_bb = tBankCustom and .6 or 0.05
	local alpha_fb = .85

	-- The frame background
	local background = CreateFrame("Frame", nil, self)
	background:SetBackdrop{
		bgFile = "Interface\\AddOns\\cargBags_Nivaya\\media\\texture",
		edgeFile = "Interface\\AddOns\\cargBags_Nivaya\\media\\glowTex",
		tile = true, tileSize = 16, edgeSize = 3,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	}
	background:SetFrameStrata("HIGH")
	background:SetFrameLevel(1)
	background:SetBackdropColor(color_rb,color_gb,color_bb,alpha_fb)
	background:SetBackdropBorderColor(0, 0, 0, 1)

	background:SetPoint("TOPLEFT", -6, 6)
	background:SetPoint("BOTTOMRIGHT", 6, -6)

	-- Caption, close button
	local caption = background:CreateFontString(background, "OVERLAY", nil)
	caption:SetFont(unpack(pixelFont))
	if(caption) then
		local t = L.bagCaptions[self.name] or (tBankBags and strsub(self.name, 5))
		if not t then t = self.name end
		if self.Name == "cBniv_ItemSets" then t=ItemSetCaption..t end
		caption:SetText(t)
		caption:SetPoint("TOPLEFT", 11, -10.5)
		self.Caption = caption
		
		if tBag or tBank then
			local close = CreateFrame("Button", nil, self, "UIPanelCloseButton")
			close:SetPoint("TOPRIGHT", 7, 6)	
			close:SetScript("OnClick", function(self) if cbNivaya:AtBank() then CloseBankFrame() else CloseAllBags() end end)
		end
	end
	
	-- mover buttons
	if (settings.isCustomBag) then

		local moveLR = function(dir)
			local idx = -1
			for i,v in ipairs(cB_CustomBags) do if v.name == name then idx = i end end
			if (idx == -1) then return end

			local tcol = (cB_CustomBags[idx].col + ((dir == "left") and 1 or -1)) % 2
			cB_CustomBags[idx].col = tcol
			cbNivaya:CreateAnchors()
		end

		local moveUD = function(dir)
			local idx = -1
			for i,v in ipairs(cB_CustomBags) do if v.name == name then idx = i end end
			if (idx == -1) then return end

			local pos = idx
			local d = (dir == "up") and 1 or -1
			repeat 
				pos = pos + d
			until 
				(not cB_CustomBags[pos]) or (cB_CustomBags[pos].col == cB_CustomBags[idx].col)

			if (cB_CustomBags[pos] ~= nil) then
				local ele = cB_CustomBags[idx]
				cB_CustomBags[idx] = cB_CustomBags[pos]
				cB_CustomBags[pos] = ele
				cbNivaya:CreateAnchors()
			end
		end		

		local rightBtn = createTextButton(">", self, 20, 20)
		rightBtn:SetPoint("TOPRIGHT", self, "TOPRIGHT", -2, 2)
		rightBtn:SetScript("OnClick", function() moveLR("right") end)

		local leftBtn = createTextButton("<", self, 20, 20)
		leftBtn:SetPoint("TOPRIGHT", self, "TOPRIGHT", -22, 2)
		leftBtn:SetScript("OnClick", function() moveLR("left") end)

		local downBtn = createTextButton("v", self, 20, 20)
		downBtn:SetPoint("TOPRIGHT", self, "TOPRIGHT", -42, 2)
		downBtn:SetScript("OnClick", function() moveUD("down") end)

		local upBtn = createTextButton("^", self, 20, 20)
		upBtn:SetPoint("TOPRIGHT", self, "TOPRIGHT", -62, 2)
		upBtn:SetScript("OnClick", function() moveUD("up") end)

		self.rightBtn = rightBtn
		self.leftBtn = leftBtn
		self.downBtn = downBtn
		self.upBtn = upBtn
	end
		
	local tBtnOffs = 0
  	if tBag or tBank then
		 -- Bag bar for changing bags
		local bagType = tBag and "bags" or "bank"
		
		local tS = tBag and "backpack+bags" or "bank"
		local tI = tBag and 4 or 7
				
		local bagButtons = self:SpawnPlugin("BagBar", tS)
		bagButtons:SetSize(bagButtons:LayoutButtons("grid", tI))
		bagButtons.highlightFunction = function(button, match) button:SetAlpha(match and 1 or 0.1) end
		bagButtons:SetScale(0.85)
		bagButtons.isGlobal = true
		
		bagButtons:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -23, 27)
		bagButtons:Hide()

		-- main window gets a fake bag button for toggling key ring
		self.BagBar = bagButtons
		
		-- We don't need the bag bar every time, so let's create a toggle button for them to show
		self.bagToggle = createTextButton("Bags", self, 40, 17)
		self.text = self:CreateFontString(nil, "OVERLAY", nil)
		self.text:SetPoint("CENTER", self.bagToggle, 2, 0.5)
		self.text:SetFont(unpack(pixelFont))
		self.text:SetText("Bags")
		self.text:SetJustifyH("CENTER")
		self.bagToggle:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -2, 2)
		self.bagToggle:SetScript("OnClick", function()
			if(self.BagBar:IsShown()) then 
				self.BagBar:Hide()
				if self.hint then self.hint:Show() end
				self.hintShown = true
			else
				self.BagBar:Show()
				if self.hint then self.hint:Hide() end
				self.hintShown = false
			end
			self:UpdateDimensions()
		end)
		SkinButton(self.bagToggle)

		-- Button to reset new items:
		if tBag and cBnivCfg.NewItems then
			self.resetBtn = createTextButton("Reset New", self, 75, 17)
			self.text = self:CreateFontString(nil, "OVERLAY", nil)
			self.text:SetPoint("CENTER", self.resetBtn, 2, 0.5)
			self.text:SetFont(unpack(pixelFont))
			self.text:SetText("Reset New")
			self.text:SetJustifyH("CENTER")
			self.resetBtn:SetPoint("TOPRIGHT", self.bagToggle, "TOPLEFT", -5, 0)
			self.resetBtn:SetScript("OnClick", function() resetNewItems(self) end)
			SkinButton(self.resetBtn)
		end
		
		-- Button to restack items:
		if cBnivCfg.Restack then
			self.restackBtn = createTextButton("Restack", self, 62, 17)
			self.text = self:CreateFontString(nil, "OVERLAY", nil)
			self.text:SetPoint("CENTER",  self.restackBtn, 2, 0.5)
			self.text:SetFont(unpack(pixelFont))
			self.text:SetText("Restack")
			self.text:SetJustifyH("CENTER")
			if self.resetBtn then
				self.restackBtn:SetPoint("TOPRIGHT", self.resetBtn, "TOPLEFT", -5, 0)
			else
				self.restackBtn:SetPoint("TOPRIGHT", self.bagToggle, "TOPLEFT", -5, 0)
			end
			 self.restackBtn:SetScript("OnClick", function() restackItems(self) end)
			SkinButton(self.restackBtn)
		end
		
		-- Button to show /cbniv options:
		local optionsBtn = createTextButton("Options", self, 17, 17)
		self.text = self:CreateFontString(nil, "OVERLAY", nil)
		self.text:SetPoint("CENTER", optionsBtn, 1, 0.5)
		self.text:SetFont(unpack(pixelFont))
		self.text:SetText("C")
		self.text:SetJustifyH("LEFT")
		if self.restackBtn then
			optionsBtn:SetPoint("TOPRIGHT", self.restackBtn, "TOPLEFT", -5, 0)
		elseif self.resetBtn then
			optionsBtn:SetPoint("TOPRIGHT", self.resetBtn, "TOPLEFT", -5, 0)
		else
			optionsBtn:SetPoint("TOPRIGHT", self.bagToggle, "TOPLEFT", -5, 0)
		end
		optionsBtn:SetScript("OnClick", function() 
			SlashCmdList.CBNIV("")
			print("Usage: /cbniv |cffffff00command|r")
		end)
		SkinButton(optionsBtn)
	end

	-- Item drop target
	if (tBag or tBank) then
		self.DropTarget = CreateFrame("Button", nil, self, "ItemButtonTemplate")
		--self.DropTarget.bg = self.DropTarget:CreateTexture(nil, "ARTWORK")
		self.DropTarget.bg = CreateFrame("Frame", nil, self)
		self.DropTarget.bg:SetAllPoints(self.DropTarget)
		self.DropTarget.bg:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			edgeFile = "Interface\\Buttons\\WHITE8x8",
			tile = false, tileSize = 16, edgeSize = 1,
		})
		self.DropTarget.bg:SetBackdropColor(1, 1, 1, 0.1)
		self.DropTarget.bg:SetBackdropBorderColor(0, 0, 0, 1)
		self.DropTarget:SetWidth(37)
		self.DropTarget:SetHeight(37)
		
		local DropTargetProcessItem = function()
			if CursorHasItem() then
				local bID, sID = GetFirstFreeSlot(tBag and "bag" or "bank")
				if bID then PickupContainerItem(bID, sID) end
			end
		end
		self.DropTarget:SetScript("OnMouseUp", DropTargetProcessItem)
		self.DropTarget:SetScript("OnReceiveDrag", DropTargetProcessItem)
		
		local fs = self:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		fs:SetShadowColor(0,0,0)
		fs:SetShadowOffset(0.8, -0.8)
		fs:SetTextColor(1,1,1)
		fs:SetJustifyH("LEFT")
		fs:SetPoint("BOTTOMRIGHT", self.DropTarget, "BOTTOMRIGHT", -5, 3)
		self.EmptySlotCounter = fs
		
		if cBnivCfg.CompressEmpty then 
			self.DropTarget:Show()
			self.EmptySlotCounter:Show()
		else
			self.DropTarget:Hide()
			self.EmptySlotCounter:Hide()
		end
	end
	
	if tBag then
		local infoFrame = CreateFrame("Button", nil, self)
		infoFrame:SetPoint("BOTTOMLEFT", 5, -6)
		infoFrame:SetPoint("BOTTOMRIGHT", -218, -6)
		infoFrame:SetHeight(32)

		-- Search bar
		local search = self:SpawnPlugin("SearchBar", infoFrame)
		search.isGlobal = true
		search.highlightFunction = function(button, match) button:SetAlpha(match and 1 or 0.1) end
		
		local caption = background:CreateFontString(infoFrame, "OVERLAY", nil)
		caption:SetFont(unpack(pixelFont))
		caption:SetText(L.Search)
		caption:SetPoint("BOTTOMLEFT", infoFrame, 0, 11.5)
		
		-- Hint
		self.hint = background:CreateFontString(nil, "OVERLAY", nil)
		self.hint:SetPoint("BOTTOMLEFT", infoFrame, 0, 32.5)
		self.hint:SetFont(unpack(pixelFont))
		self.hint:SetTextColor(1, 1, 1, 0.4)
		self.hint:SetText("Alt + Right Click an item to assign category")
		self.hintShown = true
		
		-- The money display
		local money = self:SpawnPlugin("TagDisplay", "[money]", self)
		money:SetPoint("TOPRIGHT", self, -28, -4.5)
		money:SetJustifyH("RIGHT")
		money:SetFont(unpack(pixelFont))
	end
	
	self:SetScale(cBnivCfg.scale)
	return self
end

------------------------------------------
-- MyButton specific
------------------------------------------
local MyButton = cbNivaya:GetItemButtonClass()
MyButton:Scaffold("Default")

function MyButton:OnAdd()
	self:SetScript('OnMouseUp', function(self, mouseButton)
		if (mouseButton == 'RightButton') and (IsAltKeyDown()) then
			local tID = GetContainerItemID(self.bagID, self.slotID)
			if tID then 
				cbNivCatDropDown.itemName = GetItemInfo(tID)
				cbNivCatDropDown.itemID = tID
				ToggleDropDownMenu(1, nil, cbNivCatDropDown, self, 0, 0)
			end
		end
	end)
end

------------------------------------------
-- BagButton specific
------------------------------------------
local BagButton = cbNivaya:GetClass("BagButton", true, "BagButton")

function BagButton:OnCreate() self:GetCheckedTexture():SetVertexColor(1, 0.8, 0, 0.8) end