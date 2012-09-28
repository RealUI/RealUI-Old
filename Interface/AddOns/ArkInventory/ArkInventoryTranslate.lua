local _G = _G
local select = _G.select
local pairs = _G.pairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table


-- localisation checking code, read from the bottom up

local frame = CreateFrame( "Frame" )
frame.timermax = 5
frame.loopmax = 5

local lang = _G[string.upper( GetLocale( ) )] or GetLocale( )

local updateTable = {
	["WOW_SKILL_HERBALISM"] = function( value )
		ArkInventory.Const.Category.Code.Skill[108].text = value
		ArkInventory.Const.Category.Code.Empty[305].text = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Herb].long = value
		ArkInventory.Const.Skills.Data[182].text = value
	end,
	["WOW_SKILL_MINING"] = function( value )
		ArkInventory.Const.Category.Code.Skill[111].text = value
		ArkInventory.Const.Category.Code.Empty[309].text = value
		ArkInventory.Const.Slot.Data[ArkInventory.Const.Slot.Type.Mining].long = value
		ArkInventory.Const.Skills.Data[186].text = value
	end,
	["WOW_SKILL_SKINNING"] = function( value )
		ArkInventory.Const.Category.Code.Skill[112].text = value
		ArkInventory.Const.Skills.Data[393].text = value
	end,
}



local itemTable = { -- key, itemtype = true / itemsubtype = false, item id
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
				
				--ArkInventory.OutputWarning( "Failed to verify ", lang, " entry ", key, ", value is [", oldValue, "]" )
			
			else
			
				if newValue ~= oldValue then
					
					if not oldValue or key == oldValue then
						--ArkInventory.OutputWarning( "Updating ", lang, " entry ", key, " with [", newValue, "]" )
					else
						ArkInventory.OutputWarning( "Updating ", lang, " entry ", key, " with [", newValue, "], was [", oldValue, "]" )
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
	{ "WOW_SKILL_SKINNING", 8613 }, -- 8617, 8618, 10768, 32678, 50305, 74522
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
				
				--ArkInventory.OutputWarning( "Failed to verify ", lang, " key [", key, "], value is [", oldValue, "]" )
			
			else
			
				if newValue ~= oldValue then
					
					if not oldValue or key == oldValue then
						--ArkInventory.OutputWarning( "Updating ", lang, " key [", key, "] with [", newValue, "]" )
					else
						ArkInventory.OutputWarning( "Updating ", lang, " key [", key, "] with [", newValue, "], was [", oldValue, "]" )
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
	{ "WOW_SKILL_HERBALISM", 22795 }, -- 63122, 85663
	{ "WOW_SKILL_MINING", 2901 },
}

local function GetWowTooltipTextHelper( id, key )
	
	ArkInventory.TooltipSetHyperlink( ArkInventory.Global.Tooltip.Scan, string.format( "item:%s", id ) )
	
	local _, _, skill, level = ArkInventory.TooltipFind( ArkInventory.Global.Tooltip.Scan, ArkInventory.Localise["WOW_TOOLTIP_SKILL"], false, true, true )
	
	if skill and level then
		--ArkInventory.Output( "tooltip: got ", id, ", skill = ", skill, ", level = ", level )
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
				
				--ArkInventory.OutputWarning( "Failed to verify ", lang, " key [", key, "], value is [", oldValue, "]" )
			
			else
			
				if newValue ~= oldValue then
					
					if not oldValue or key == oldValue then
						--ArkInventory.OutputWarning( "Setting ", lang, " key [", key, "] with [", newValue, "]" )
					else
						ArkInventory.OutputWarning( "Updating ", lang, " key [", key, "] with [", newValue, "], was [", oldValue, "]" )
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
					ArkInventory.Output( lang, " translations already loaded." )
				end
				return
			end
			
			if ArkInventory.db.global.option.message.translation.interim then
				ArkInventory.Output( lang, " translations - attempt ", self.loop, " of ", self.loopmax, "." )
			end
			
			local ok = GetTranslations( )
			
			if ok or ( self.loop > ( self.loopmax - 1 ) ) then
				
				self:Hide( )

				if ok then
					
					if ArkInventory.db.global.option.message.translation.final then
						ArkInventory.Output( lang, " translations successfully loaded." )
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
					
					ArkInventory.OutputWarning( lang, " translations failed to load. You may experience issues with item categorisation and menu text." )
					
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
