-- localisation checking code, read from the bottom up

local frame = CreateFrame( "Frame" )
frame.timermax = 5
frame.loopmax = 5


local updateTable = {
	["WOW_ITEM_TYPE_ARMOR"] = function( value )
		-- dont need to do anything
	end,
	["WOW_ITEM_TYPE_CONSUMABLE"] = function( value )
		ArkInventory.Const.Category.Code.Consumable[404].text = value
	end,
	["WOW_ITEM_TYPE_CONSUMABLE_BANDAGE"] = function( value )
		ArkInventory.Const.Category.Code.Consumable[432].text = value
	end,
	["WOW_ITEM_TYPE_CONSUMABLE_ELIXIR"] = function( value )
		ArkInventory.Const.Category.Code.Consumable[430].text = value
	end,
	["WOW_ITEM_TYPE_CONSUMABLE_FLASK"] = function( value )
		ArkInventory.Const.Category.Code.Consumable[431].text = value
	end,
	["WOW_ITEM_TYPE_CONSUMABLE_FOOD_AND_DRINK"] = function( value )
		ArkInventory.Const.Category.Code.Consumable[437].text = value
	end,
	["WOW_ITEM_TYPE_CONSUMABLE_ITEM_ENHANCEMENT"] = function( value )
		ArkInventory.Const.Category.Code.Consumable[440].text = value
	end,
	["WOW_ITEM_TYPE_CONSUMABLE_POTION"] = function( value )
		ArkInventory.Const.Category.Code.Consumable[424].text = value
	end,
	["WOW_ITEM_TYPE_CONSUMABLE_SCROLL"] = function( value )
		ArkInventory.Const.Category.Code.Consumable[433].text = value
	end,
	["WOW_ITEM_TYPE_CONTAINER"] = function( value )
		ArkInventory.Const.Category.Code.System[405].text = value
	end,
	["WOW_ITEM_TYPE_CONTAINER_BAG"] = function( value )
		ArkInventory.Const.Category.Code.Empty[302].text = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Bag].long = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Bag].type = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Wearing].long = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Wearing].type = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Mail].type = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Mail].long = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Critter].long = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Mount].long = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Token].long = value
	end,
	["WOW_ITEM_TYPE_CONTAINER_ENCHANTING"] = function( value )
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Enchanting].type = value
	end,
	["WOW_ITEM_TYPE_CONTAINER_ENGINEERING"] = function( value )
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Engineering].type = value
	end,
	["WOW_ITEM_TYPE_CONTAINER_GEM"] = function( value )
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Gem].type = value
	end,
	["WOW_ITEM_TYPE_CONTAINER_HERB"] = function( value )
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Herb].type = value
	end,
	["WOW_ITEM_TYPE_CONTAINER_INSCRIPTION"] = function( value )
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Inscription].type = value
	end,
	["WOW_ITEM_TYPE_CONTAINER_LEATHERWORKING"] = function( value )
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Leatherworking].type = value
	end,
	["WOW_ITEM_TYPE_CONTAINER_MINING"] = function( value )
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Mining].type = value
	end,
	["WOW_ITEM_TYPE_CONTAINER_TACKLE"] = function( value )
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Tackle].long = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Tackle].type = value
	end,
	["WOW_ITEM_TYPE_GEM"] = function( value )
		ArkInventory.Const.Category.Code.System[434].text = value
		ArkInventory.Const.Category.Code.Empty[308].text = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Gem].long = value
	end,
	["WOW_ITEM_TYPE_GLYPH"] = function( value )
		ArkInventory.Const.Category.Code.System[439].text = value
	end,
	["WOW_ITEM_TYPE_MISC"] = function( value )
		ArkInventory.Const.Category.Code.System[407].text = value
	end,
	["WOW_ITEM_TYPE_MISC_MOUNT"] = function( value )
		ArkInventory.Const.Category.Code.System[415].text = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Mount].type = value
	end,
	["WOW_ITEM_TYPE_MISC_PET"] = function( value )
		ArkInventory.Const.Category.Code.System[423].text = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Critter].type = value
	end,
	["WOW_ITEM_TYPE_MISC_REAGENT"] = function( value )
		ArkInventory.Const.Category.Code.System[408].text = value
	end,
	["WOW_ITEM_TYPE_QUEST"] = function( value )
		ArkInventory.Const.Category.Code.System[411].text = value
	end,
	["WOW_ITEM_TYPE_RECIPE"] = function( value )
		ArkInventory.Const.Category.Code.System[409].text = value
	end,
	["WOW_ITEM_TYPE_TRADE_GOODS"] = function( value )
		ArkInventory.Const.Category.Code.Trade[412].text = value
	end,
	["WOW_ITEM_TYPE_TRADE_GOODS_CLOTH"] = function( value )
		ArkInventory.Const.Category.Code.Trade[502].text = value
	end,
	["WOW_ITEM_TYPE_TRADE_GOODS_DEVICES"] = function( value )
		ArkInventory.Const.Category.Code.Trade[425].text = value
	end,
	["WOW_ITEM_TYPE_TRADE_GOODS_ELEMENTAL"] = function( value )
		ArkInventory.Const.Category.Code.Trade[503].text = value
	end,
	["WOW_ITEM_TYPE_TRADE_GOODS_ITEM_ENCHANTMENT"] = function( value )
		ArkInventory.Const.Category.Code.Trade[510].text = value
	end,
	["WOW_ITEM_TYPE_TRADE_GOODS_EXPLOSIVES"] = function( value )
		ArkInventory.Const.Category.Code.Trade[426].text = value
	end,
	["WOW_ITEM_TYPE_TRADE_GOODS_HERB"] = function( value )
		ArkInventory.Const.Category.Code.Trade[501].text = value
	end,
	["WOW_ITEM_TYPE_TRADE_GOODS_LEATHER"] = function( value )
		ArkInventory.Const.Category.Code.Trade[504].text = value
	end,
	["WOW_ITEM_TYPE_TRADE_GOODS_MATERIALS"] = function( value )
		ArkInventory.Const.Category.Code.Trade[507].text = value
	end,
	["WOW_ITEM_TYPE_TRADE_GOODS_MEAT"] = function( value )
		ArkInventory.Const.Category.Code.Trade[505].text = value
	end,
	["WOW_ITEM_TYPE_TRADE_GOODS_METAL_AND_STONE"] = function( value )
		ArkInventory.Const.Category.Code.Trade[506].text = value
	end,
	["WOW_ITEM_TYPE_TRADE_GOODS_PARTS"] = function( value )
		ArkInventory.Const.Category.Code.Trade[427].text = value
	end,
	["WOW_ITEM_TYPE_WEAPON"] = function( value )
		-- dont need to do anything
	end,
	
	
	
--	["LOCATION_MOUNT"] = function( value )
--		ArkInventory.Global.Location[ArkInventory.Const.Location.Mount].Name = value
--		BINDING_NAME_ARKINV_TOGGLE_MOUNT = value
--	end,
--	["LOCATION_PET"] = function( value )
--		ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].Name = value
--		BINDING_NAME_ARKINV_TOGGLE_PET = value
--	end,
	
	
	
	
	["CATEGORY_CONSUMABLE"] = function( value )
		-- dont need to do anything
	end,
	["CATEGORY_TRADE_GOODS"] = function( value )
		-- dont need to do anything
	end,
	["CATEGORY_OTHER"] = function( value )
		-- dont need to do anything
	end,
	
	
	
	
	["WOW_SKILL_ALCHEMY"] = function( value )
		ArkInventory.Const.Category.Code.Skill[101].text = value
	end,
	["WOW_SKILL_BLACKSMITHING"] = function( value )
		ArkInventory.Const.Category.Code.Skill[102].text = value
	end,
	["WOW_SKILL_COOKING"] = function( value )
		ArkInventory.Const.Category.Code.Skill[103].text = value
	end,
	["WOW_SKILL_ENCHANTING"] = function( value )
		ArkInventory.Const.Category.Code.Skill[105].text = value
		ArkInventory.Const.Category.Code.Empty[306].text = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Enchanting].long = value
	end,
	["WOW_SKILL_ENGINEERING"] = function( value )
		ArkInventory.Const.Category.Code.Skill[104].text = value
		ArkInventory.Const.Category.Code.Empty[307].text = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Engineering].long = value
	end,
	["WOW_SKILL_FIRST_AID"] = function( value )
		ArkInventory.Const.Category.Code.Skill[106].text = value
	end,
	["WOW_SKILL_FISHING"] = function( value )
		ArkInventory.Const.Category.Code.Skill[107].text = value
	end,
	["WOW_SKILL_HERBALISM"] = function( value )
		ArkInventory.Const.Category.Code.Skill[108].text = value
		ArkInventory.Const.Category.Code.Empty[305].text = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Herb].long = value
	end,
	["WOW_SKILL_INSCRIPTION"] = function( value )
		ArkInventory.Const.Category.Code.Skill[115].text = value
		ArkInventory.Const.Category.Code.Empty[313].text = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Inscription].long = value
	end,
	["WOW_SKILL_JEWELCRAFTING"] = function( value )
		ArkInventory.Const.Category.Code.Skill[109].text = value
	end,
	["WOW_SKILL_LEATHERWORKING"] = function( value )
		ArkInventory.Const.Category.Code.Skill[110].text = value
		ArkInventory.Const.Category.Code.Empty[312].text = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Leatherworking].long = value
	end,
	["WOW_SKILL_MINING"] = function( value )
		ArkInventory.Const.Category.Code.Skill[111].text = value
		ArkInventory.Const.Category.Code.Empty[309].text = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Mining].long = value
	end,
	["WOW_SKILL_SKINNING"] = function( value )
		ArkInventory.Const.Category.Code.Skill[112].text = value
	end,
	["WOW_SKILL_TAILORING"] = function( value )
		ArkInventory.Const.Category.Code.Skill[113].text = value
	end,
}



local itemTable = { -- key, itemtype = true / itemsubtype = false, item id
	{ "WOW_ITEM_TYPE_ARMOR", true, 2435 },
	{ "WOW_ITEM_TYPE_CONSUMABLE", true, 34722 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_BANDAGE", false, 34722 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_ELIXIR", false, 39666 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_FLASK", false, 46376 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_FOOD_AND_DRINK", false, 45932 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_ITEM_ENHANCEMENT", false, 45060 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_POTION", false, 43570 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_SCROLL", false, 49632 },
	{ "WOW_ITEM_TYPE_CONTAINER", true, 4496 },
	{ "WOW_ITEM_TYPE_CONTAINER_BAG", false, 4496 },
	{ "WOW_ITEM_TYPE_CONTAINER_ENCHANTING", false, 30748 },
	{ "WOW_ITEM_TYPE_CONTAINER_ENGINEERING", false, 30745 },
	{ "WOW_ITEM_TYPE_CONTAINER_GEM", false, 30747 },
	{ "WOW_ITEM_TYPE_CONTAINER_HERB", false, 22250 },
	{ "WOW_ITEM_TYPE_CONTAINER_INSCRIPTION", false, 39489 },
	{ "WOW_ITEM_TYPE_CONTAINER_LEATHERWORKING", false, 38399 },
	{ "WOW_ITEM_TYPE_CONTAINER_MINING", false, 30746 },
	{ "WOW_ITEM_TYPE_CONTAINER_TACKLE", false, 60218 },
	{ "WOW_ITEM_TYPE_GEM", true, 36919 },
	{ "WOW_ITEM_TYPE_GLYPH", true, 43673 },
	{ "WOW_ITEM_TYPE_MISC", true, 47180 },
	{ "WOW_ITEM_TYPE_MISC_MOUNT", false, 47180 },
	{ "WOW_ITEM_TYPE_MISC_PET", false, 8495 },
	{ "WOW_ITEM_TYPE_MISC_REAGENT", false, 17029 },
	{ "WOW_ITEM_TYPE_QUEST", true, 22014 },
	{ "WOW_ITEM_TYPE_RECIPE", true, 5640 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS", true, 2320 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_CLOTH", false, 2320 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_DEVICES", false, 15846 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_ELEMENTAL", false, 37704 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_ITEM_ENCHANTMENT", false, 38682 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_EXPLOSIVES", false, 4378 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_HERB", false, 36908 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_LEATHER", false, 44128 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_MATERIALS", false, 30183 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_MEAT", false, 35794 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_METAL_AND_STONE", false, 18567 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_PARTS", false, 43127 },
	{ "WOW_ITEM_TYPE_WEAPON", true, 2526 },
	
	{ "LOCATION_MOUNT", false, 47180 },
	{ "LOCATION_PET", false, 8495 },

	{ "CATEGORY_CONSUMABLE", true, 34722 },
	{ "CATEGORY_TRADE_GOODS", true, 2320 },
	{ "CATEGORY_OTHER", false, 5048 },
	
}


local function GetWowItemTypeHelper( primary, id, key )
	local _, _, _, _, _, itemType, itemSubType = GetItemInfo( id )
	if itemType and itemSubType then
		--ArkInventory.Output( "item: ", id, " / ", itemType, " / ", itemSubType )
		if primary then
			return itemType
		else
			return itemSubType
		end
	else
		-- no cached data, ask server and well hopefully get it next time
		--ArkInventory.Output( "item: failed ", id )
		ArkInventory.TooltipSetHyperlink( ArkInventory.Global.Tooltip.Scan, string.format( "item:%s", id ) )
	end
end

local function GetWowItemType( primary, id, key )
	if type( id ) ~= "table" then
		return GetWowItemTypeHelper( primary, id, key )
	else
		for _, v in ipairs( id ) do
			local x = GetWowItemTypeHelper( primary, v, key )
			if x then return x end
		end
	end
end

local function GetItemBasedTranslations( )

	-- cant be completely done at game load as it depends on items being in your cache, thus its "scheduled"
	
	local L = LibStub("AceLocale-3.0"):GetLocale( "ArkInventory", true )
	assert( L, "locale failed to load" )
	
	local ok = true
	
	for k, v in pairs( itemTable ) do
		
		local key, primary, id = v[1], v[2], v[3]
		
		if key and id and updateTable[key] then
			
			local oldValue = rawget( L, key )
			local newValue = GetWowItemType( primary, id, key )
			
			if not newValue then
			
				ok = false
				
				--ArkInventory.OutputWarning( "Failed to verify ", GetLocale( ), " entry ", key, ", value is [", oldValue, "]" )
			
			else
			
				if newValue ~= oldValue then
					
					if not oldValue or key == oldValue then
						--ArkInventory.OutputWarning( "Updating ", GetLocale( ), " entry ", key, " with [", newValue, "]" )
					else
						ArkInventory.OutputWarning( "Updating ", GetLocale( ), " entry ", key, " with [", newValue, "], was [", oldValue, "]" )
					end
					
					rawset( L, key, newValue )
					updateTable[key]( newValue )
					
				end
				
				table.wipe( itemTable[k] )
				updateTable[key] = nil
				
			end
			
		end
		
	end
	
	return ok
	
end



local spellTable = { -- key, spell id
	{ "WOW_SKILL_ALCHEMY", 2259 }, --, 3101, 3464, 11611, 28596, 51304, 80731
	{ "WOW_SKILL_BLACKSMITHING", 2018 }, -- , 3100, 3538, 9785, 29844, 51300, 76666
	{ "WOW_SKILL_COOKING", 2550 }, -- 3102, 3413, 18260, 33359, 51296, 88053
	{ "WOW_SKILL_ENCHANTING", 7411 }, -- 7412, 7413, 13920, 28029, 51313, 74258
	{ "WOW_SKILL_ENGINEERING", 4036 }, -- 4037, 4038, 12656, 30350, 51306, 82774
	{ "WOW_SKILL_FIRST_AID", 3273 }, -- 3274, 7924, 10846, 27028, 45542, 74559
	{ "WOW_SKILL_FISHING", 7620 }, -- 7731, 7732, 18248, 33095, 51294, 88868
	{ "WOW_SKILL_HERBALISM", 13614 }, -- 9134
	{ "WOW_SKILL_INSCRIPTION", 45357 }, -- 45358, 45359, 45360, 45361, 45363, 86008
	{ "WOW_SKILL_JEWELCRAFTING", 25229 }, -- 25230, 28894, 28895, 28897, 51311, 73318
	{ "WOW_SKILL_LEATHERWORKING", 2108 }, -- 3104, 3811, 10662, 32549, 51302, 81199
	{ "WOW_SKILL_MINING", 2575 }, -- 2576, 3564, 10248, 29354, 50310, 74517
	{ "WOW_SKILL_SKINNING", 8613 }, -- 8617, 8618, 10768, 32678, 50305, 74522
	{ "WOW_SKILL_TAILORING", 3908 }, -- 3909, 3910, 12180, 26790, 51309, 75156
}

local function GetWowSpellNameHelper( id, key )
	local name = GetSpellInfo( id )
	if name then
		--ArkInventory.Output( "spell: got ", id )
		return name
	else
		-- no cached data, ask server and well hopefully get it next time
		--ArkInventory.Output( "spell: failed ", id )
		ArkInventory.TooltipSetHyperlink( ArkInventory.Global.Tooltip.Scan, string.format( "spell:%s", id ) )
	end
end

local function GetWowSpellName( id, key )
	if type( id ) ~= "table" then
		return GetWowSpellNameHelper( id, key )
	else
		for _, v in ipairs( id ) do
			local x = GetWowSpellNameHelper( v, key )
			if x then return x end
		end
	end
end

local function GetSpellBasedTranslations( )

	-- cant be completely done at game load as it depends on items being in your cache, thus its "scheduled"
	
	local L = LibStub("AceLocale-3.0"):GetLocale( "ArkInventory", true )
	assert( L, "locale failed to load" )
	
	local ok = true
	
	for k, v in pairs( spellTable ) do
		
		local key, id = v[1], v[2]
		
		if key and id and updateTable[key] then
			
			local oldValue = rawget( L, key )
			local newValue = GetWowSpellName( id, key )
			
			if not newValue then
			
				ok = false
				
				--ArkInventory.OutputWarning( "Failed to verify ", GetLocale( ), " key [", key, "], value is [", oldValue, "]" )
			
			else
			
				if newValue ~= oldValue then
					
					if not oldValue or key == oldValue then
						--ArkInventory.OutputWarning( "Updating ", GetLocale( ), " key [", key, "] with [", newValue, "]" )
					else
						ArkInventory.OutputWarning( "Updating ", GetLocale( ), " key [", key, "] with [", newValue, "], was [", oldValue, "]" )
					end
					
					rawset( L, key, newValue )
					updateTable[key]( newValue )
					
				end
				
				updateTable[key] = nil
				table.wipe( spellTable[k] )
				
			end
			
		end
		
	end
	
	return ok

end


local tooltipTable = {
	{ "WOW_SKILL_ALCHEMY", 5640 },
	{ "WOW_SKILL_BLACKSMITHING", 10858 },
	{ "WOW_SKILL_COOKING", 6325 },
	{ "WOW_SKILL_ENCHANTING", 20758 },
	{ "WOW_SKILL_ENGINEERING", 13309 },
	{ "WOW_SKILL_FIRST_AID", 19442 },
	{ "WOW_SKILL_FISHING", 34109 },
	{ "WOW_SKILL_INSCRIPTION", 50166 },
	{ "WOW_SKILL_JEWELCRAFTING", 20854 },
	{ "WOW_SKILL_LEATHERWORKING", 18731 },
	{ "WOW_SKILL_TAILORING", 6272 },
}

local function GetWowTooltipTextHelper( id, key )
	
	ArkInventory.TooltipSetHyperlink( ArkInventory.Global.Tooltip.Scan, string.format( "item:%s", id ) )
	
	local _, _, skill, level = ArkInventory.TooltipFind( ArkInventory.Global.Tooltip.Scan, ArkInventory.Localise["WOW_TOOLTIP_SKILL"], false, true, true )
	
	if skill and level then
		--ArkInventory.Output( "tooltip: got ", id )
		return skill
	end
	
	--ArkInventory.Output( "tooltip: failed ", id )
	
end

local function GetWowTooltipText( id, key )
	if type( id ) ~= "table" then
		return GetWowTooltipTextHelper( id, key )
	else
		for _, v in ipairs( id ) do
			local x = GetWowTooltipTextHelper( v, key )
			if x then return x end
		end
	end
end

local function GetTooltipBasedTranslations( )
	
	-- cant be completely done at game load as it depends on items being in your cache, thus its "scheduled"
	
	local L = LibStub("AceLocale-3.0"):GetLocale( "ArkInventory", true )
	assert( L, "locale failed to load" )
	
	local ok = true
	
	for k, v in pairs( tooltipTable ) do
		
		local key, id, update = v[1], v[2]
		
		if key and id and updateTable[key] then
			
			local oldValue = rawget( L, key )
			local newValue = GetWowTooltipText( id, key )
			
			if not newValue then
			
				ok = false
				
				--ArkInventory.OutputWarning( "Failed to verify ", GetLocale( ), " key [", key, "], value is [", oldValue, "]" )
			
			else
			
				if newValue ~= oldValue then
					
					if not oldValue or key == oldValue then
						--ArkInventory.OutputWarning( "Updating ", GetLocale( ), " key [", key, "] with [", newValue, "]" )
					else
						ArkInventory.OutputWarning( "Updating ", GetLocale( ), " key [", key, "] with [", newValue, "], was [", oldValue, "]" )
					end
					
					rawset( L, key, newValue )
					updateTable[key]( newValue )
					
				end
				
				updateTable[key] = nil
				table.wipe( tooltipTable[k] )
				
			end
			
		end
		
	end
	
	return ok
	
end


local function GetTranslations( )
	local ok = true
	ok = ok and GetItemBasedTranslations( )
	ok = ok and GetSpellBasedTranslations( )
	ok = ok and GetTooltipBasedTranslations( )
	return ok
end

frame:SetScript( "OnUpdate",
	function( self, elapsed )
		
		self.loop = self.loop or 0
		self.timer = ( self.timer or 0 ) + elapsed
		
		if self.timer > self.timermax then
			
			self.timer = nil
			self.loop = self.loop + 1
			
			if not updateTable then
				self:Hide( )
				if ArkInventory.db.global.option.message.translation.final then
					ArkInventory.Output( "Translations for ", GetLocale( ), " are already loaded." )
				end
				return
			end
			
			if ArkInventory.db.global.option.message.translation.interim then
				ArkInventory.Output( "Loading Translations for ", GetLocale( ), ": Attempt ", self.loop, " of ", self.loopmax )
			end
			
			local ok = GetTranslations( )
			
			if ok or ( self.loop > ( self.loopmax - 1 ) ) then
				
				self:Hide( )

				if ok then
					
					if ArkInventory.db.global.option.message.translation.final then
						ArkInventory.Output( "Translations for ", GetLocale( ), " loaded." )
					end
					
					table.wipe( spellTable )
					spellTable = nil
					
					table.wipe( itemTable )
					itemTable = nil
					
					table.wipe( tooltipTable )
					tooltipTable = nil
					
					table.wipe( updateTable )
					updateTable = nil
					
				else
					
					for k in pairs( updateTable ) do
						ArkInventory.Output( k )
					end
					
					ArkInventory.OutputWarning( "Translations for ", GetLocale( ), " failed to load, you may experience issues with item categorisation and menu text" )
					
				end
				
				ArkInventory.TranslationsLoaded = true
				
				ArkInventory.ItemCacheClear( )
				ArkInventory.ScanLocation( )
				ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
				
			end
			
		end
		
		-- failsafe to ensure we dont go on forever
		if self.loop > ( self.loopmax + 1 ) then
			print( "failsafe kicked in - aborting arkinventory translations due to an error of some sort" )
			self:Hide( )
		end
		
	end
)

frame:Show( )

function ArkInventory.TranslateTryAgain( )
	frame.loopmax = frame.loopmax + frame.loop
	frame.timer = 0
	frame:Show( )
end
