local _G = _G
local select = _G.select
local pairs = _G.pairs
local ipairs = _G.ipairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table


ArkInventory.LDB = {
	Bags = ArkInventory.Lib.DataBroker:NewDataObject( string.format( "%s_%s", ArkInventory.Const.Program.Name, "Bags" ), {
		type = "data source",
		icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Bag].Texture,
		text = ArkInventory.Const.Slot.Data[ArkInventory.Const.Location.Bag].name,
	} ),
	Money = ArkInventory.Lib.DataBroker:NewDataObject( string.format( "%s_%s", ArkInventory.Const.Program.Name, "Money" ), {
		type = "data source",
		icon = [[Interface\Icons\INV_Misc_Coin_02]],
		text = "Money",
	} ),
	Companion = { },
	Pets = ArkInventory.Lib.DataBroker:NewDataObject( string.format( "%s_%s", ArkInventory.Const.Program.Name, "Pets" ), {
		type = "data source",
		icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].Texture,
		text = "",
	} ),
	Mounts = ArkInventory.Lib.DataBroker:NewDataObject( string.format( "%s_%s", ArkInventory.Const.Program.Name, "Mounts" ), {
		type = "data source",
		icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Mount].Texture,
		text = "",
	} ),
	Tracking_Currency = ArkInventory.Lib.DataBroker:NewDataObject( string.format( "%s_%s_%s", ArkInventory.Const.Program.Name, "Tracking", "Currency" ), {
		type = "data source",
		icon = nil,
		text = "Track Currency",
	} ),
	Tracking_Item = ArkInventory.Lib.DataBroker:NewDataObject( string.format( "%s_%s_%s", ArkInventory.Const.Program.Name, "Tracking", "Item" ), {
		type = "data source",
		icon = nil,
		text = "Track Items",
	} ),
}

local companionTable = { }



function ArkInventory.LDB.Bags:OnClick( button )
	if button == "RightButton" then
		ArkInventory.MenuLDBBagsOpen( self )
	else
		ArkInventory.Frame_Main_Toggle( ArkInventory.Const.Location.Bag )
	end
end

function ArkInventory.LDB.Bags:Update( )
	local loc_id = ArkInventory.Const.Location.Bag
	--ArkInventory.LDB.Bags.icon = ArkInventory.Global.Location[loc_id].Texture
	self.text = ArkInventory.Frame_Status_Update_Empty( loc_id, ArkInventory.Global.Me, true )
end



function ArkInventory.LDB.Money:Update( )
	self.text = ArkInventory.MoneyText( GetMoney( ) )
end

function ArkInventory.LDB.Money.OnTooltipShow( frame )
	ArkInventory.MoneyFrame_Tooltip( frame )
end



function ArkInventory.LDB.Tracking_Currency:Update( )
	
	self.text = ""
	local hasText = false
	
	local numTokenTypes = GetCurrencyListSize( )
	
	-- expand all token headers
	for j = numTokenTypes, 1, -1 do
		local name, isHeader, isExpanded = GetCurrencyListInfo( j )
		if isHeader and not isExpanded then
			ExpandCurrencyList( j, 1 )
		end
	end
	
	numTokenTypes = GetCurrencyListSize( )
	
	for j = 1, numTokenTypes do
		
		local name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo( j )
		
		if not isHeader then
			local h = GetCurrencyListLink( j )
			local class, id = ArkInventory.ObjectStringDecode( h )
			if ArkInventory.db.char.option.ldb.tracking.currency.tracked[id] then
				self.text = string.format( "%s  |T%s:0|t %d", self.text, icon or ArkInventory.Const.Texture.Missing, count or 0 )
				hasText = true
			end
		end
		
	end
	
	if hasText then
		self.text = string.trim( self.text )
	else
		self.text = string.format( "|T%s:0|t", ArkInventory.Global.Location[ArkInventory.Const.Location.Token].Texture )
	end
	
end

function ArkInventory.LDB.Tracking_Currency.OnClick( frame, button )
	if button == "RightButton" then
		ArkInventory.MenuLDBTrackingCurrencyOpen( frame )
	else
		ArkInventory.Frame_Main_Toggle( ArkInventory.Const.Location.Token )
	end
end

function ArkInventory.LDB.Tracking_Currency:OnTooltipShow( )
	
	self:AddLine( string.format( "%s: %s", ArkInventory.Localise["TRACKING"], ArkInventory.Localise["LDB_TRACKING_CURRENCY"] ) )
	
	local numTokenTypes = GetCurrencyListSize( )
	
	-- expand all currency headers
	for j = numTokenTypes, 1, -1 do
		name, isHeader, isExpanded = GetCurrencyListInfo( j )
		if isHeader and not isExpanded then
			ExpandCurrencyList( j, 1 )
		end
	end
	
	numTokenTypes = GetCurrencyListSize( )
	
	for j = 1, numTokenTypes do
		
		local name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo( j )
		
		if isHeader then
			self:AddLine( " " )
			self:AddLine( name )
		else
			
			local h = GetCurrencyListLink( j )
			local class, id = ArkInventory.ObjectStringDecode( h )
			
			if ArkInventory.db.char.option.ldb.tracking.currency.tracked[id] then
				self:AddDoubleLine( name, count, 0, 1, 0, 0, 1, 0 )
			else
				self:AddDoubleLine( name, count, 1, 1, 1, 1, 1, 1 )
			end
		end
		
	end
	
	self:Show( )
	
end



function ArkInventory.LDB.Tracking_Item:Update( )
	
	self.text = ""
	local hasText = false
	
	for k in ArkInventory.spairs( ArkInventory.db.global.option.tracking.items )  do
		if ArkInventory.db.char.option.ldb.tracking.item.tracked[k] then
			local count = GetItemCount( k )
			if k == 6265 then
				-- soul shards for cataclysm
				count = UnitPower( "player", 7 ) or 0
			end
			local icon = select( 10, GetItemInfo( k ) )
			self.text = string.format( "%s  |T%s:0|t %s", self.text, icon or ArkInventory.Const.Texture.Missing, count or 0 )
			hasText = true
		end
	end
	
	if hasText then
		self.text = string.trim( self.text )
	else
		self.text = string.format( "|T%s:0|t", [[Interface\Icons\Ability_Tracking]] )
	end
	
end

function ArkInventory.LDB.Tracking_Item:OnClick( button )
	if button == "RightButton" then
		ArkInventory.MenuLDBTrackingItemOpen( self )
	end
end

function ArkInventory.LDB.Tracking_Item:OnTooltipShow( )
	
	self:AddLine( string.format( "%s: %s", ArkInventory.Localise["TRACKING"], ArkInventory.Localise["ITEMS"] ) )
	
	self:AddLine( " " )
	
	for k in ArkInventory.spairs( ArkInventory.db.global.option.tracking.items )  do
		
		local count = GetItemCount( k )
		if k == 6265 then
			-- soul shards for cataclysm
			count = UnitPower( "player", 7 ) or 0
		end
		local name = GetItemInfo( k )
		
		local checked = ArkInventory.db.char.option.ldb.tracking.item.tracked[k]
		
		if checked then
			self:AddDoubleLine( name, count, 0, 1, 0, 0, 1, 0 )
		else
			self:AddDoubleLine( name, count, 1, 1, 1, 1, 1, 1 )
		end
		
	end
	
	self:Show( )
	
end


function ArkInventory.LDB.Pets:Update( )
	
	local companionType = "CRITTER"
	
	ArkInventory.LDB.Pets.Cleanup( )
	
	local total = ArkInventory.LDB.Companion.GetTotal( companionType )
	
	if total < 1 then
		self.icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].Texture
		return
	end
	
	local selected = ArkInventory.db.char.option.ldb.pets.selected
	local count = ArkInventory.LDB.Companion.GetSelectedCount( selected )
	
	if count == 0 then
		--all companions
		self.icon = [[Interface\Icons\INV_Misc_Dice_01]]
		return
	end
	
	if count > 1 then
		-- partial selection
		self.icon = [[Interface\Icons\INV_Misc_Dice_02]]
		return
	end
	
	-- just one
	for k, v in pairs( selected ) do
		if v then
			self.icon = select( 8, C_PetJournal.GetPetInfoByPetID( k ) )
			return
		end
	end
	
end

function ArkInventory.LDB.Pets:OnTooltipShow( )
	
	local companionType = "CRITTER"
	
	local total = ArkInventory.LDB.Companion.GetTotal( companionType )
	
	if total < 1 then
		self:AddLine( ArkInventory.Localise["LDB_COMPANION_NONE"] )
		return
	end
	
	local selected = ArkInventory.db.char.option.ldb.pets.selected
	local count = ArkInventory.LDB.Companion.GetSelectedCount( selected )
	
	if count == 0 then
		-- random all
		self:AddLine( ArkInventory.Localise["RANDOM"] )
		return
	end
	
	if count > 1 then
		-- random selection
		self:AddLine( string.format( "%s (%s/%s)", ArkInventory.Localise["RANDOM"], count, total ) )
		return
	end
	
	-- just the one
	for k, v in pairs( selected ) do
		if v then
			local _, customName, _, _, _, _, name = C_PetJournal.GetPetInfoByPetID( k )
			if customName and customName ~= "" then
				name = string.format( "%s (%s)", name, customName )
			end
			self:AddLine( name )
			return
		end
	end

end

function ArkInventory.LDB.Pets:OnClick( button )
	
	if IsModifiedClick( "CHATLINK" ) then
		
		-- dismiss current pet
		
		local petID = C_PetJournal.GetSummonedPetID( )
		if petID then
			C_PetJournal.SummonPetByID( petID )
		end
		
		return
		
	end
	
	ArkInventory.LDB.Pets:Update( )
	
	if button == "RightButton" then
		
		ArkInventory.MenuPetsOpen( self )
		
	else
		
		local companionType = "CRITTER"
		
		local n = ArkInventory.Lib.Pet:NumPets( )
		if n == 0 then return end
		
		ArkInventory.LDB.Companion.GetUsable( companionType, true )
		
		--ArkInventory.Output( #companionTable, " usable pets" )
		
		if #companionTable == 0 then
			-- no usable pets
		elseif #companionTable == 1 then
			C_PetJournal.SummonPetByID( companionTable[1] )
		else
			C_PetJournal.SummonPetByID( companionTable[random( 1, #companionTable )] )
		end
		
	end
	
end

function ArkInventory.LDB.Pets.Cleanup( )
	
	local companionType = "CRITTER"
	
	-- check for an remove any selected companions we no longer have (theyve either been caged or released)
	local selected = ArkInventory.db.char.option.ldb.pets.selected
	for k, v in pairs( selected ) do
		if v ~= nil and not ArkInventory.Global.Companion.CRITTER[k] then
			selected[k] = nil
			--ArkInventory.Output( "removing selected pet we dont have any more - ", k )
		end
	end
	
	-- if all companions are selected then deselect them all
	local selected = ArkInventory.db.char.option.ldb.pets.selected
	local n1 = ArkInventory.LDB.Companion.GetTotal( companionType )
	local n2 = ArkInventory.LDB.Companion.GetSelectedCount( selected )
	
	--ArkInventory.Output( "pet / ", n1, " / ", n2, " / ", selected )
	
	if n1 == n2 then
		for k, v in pairs( selected ) do
			if v == true then
				selected[k] = nil
			end
		end
	end
	
end


function ArkInventory.LDB.Mounts:Update( useMapZone )
	
	local companionType = "MOUNT"
	
	ArkInventory.LDB.Mounts.Cleanup( )
	
	ArkInventory.LDB.Mounts.IsFlyable( useMapZone )
	
	local mountType = ArkInventory.LDB.Companion.GetUsable( companionType, true )
	
	if not mountType then
		-- no usable mounts
		self.icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Mount].Texture
		return
	end
	
	local total = ArkInventory.LDB.Companion.GetTotal( companionType, mountType )
	
	--ArkInventory.Output( mountType, " / ", #companionTable, " / ", total )
	
	if total < 1 then
		self.icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Mount].Texture
		return
	end
	
	local selected = ArkInventory.db.char.option.ldb.mounts[mountType].selected
	local count = ArkInventory.LDB.Companion.GetSelectedCount( selected )
	
	if count == 0 then
		--all companions
		self.icon = [[Interface\Icons\INV_Misc_Dice_01]]
		return
	end
	
	if count > 1 then
		-- partial selection
		self.icon = [[Interface\Icons\INV_Misc_Dice_02]]
		return
	end
	
	-- just one
	for k, v in pairs( selected ) do
		if v then
			self.icon = select( 3, GetSpellInfo( k ) )
			return
		end
	end
	
end

function ArkInventory.LDB.Mounts:OnTooltipShow( ... )
	
	local companionType = "MOUNT"
	
	self:AddDoubleLine( MODE, ArkInventory.Localise["LDB_MOUNTS_TOOLTIP_SELECTION"] )
	
	for _, mountType in ipairs( ArkInventory.Const.MountTypes ) do
		
		local mode = ArkInventory.Localise[string.upper( string.format( "LDB_MOUNTS_TYPE_%s", mountType ) )]
		local total = ArkInventory.LDB.Companion.GetTotal( companionType, mountType )
		
		if total < 1 then
			
			self:AddDoubleLine( mode, ArkInventory.Localise["LDB_COMPANION_NONE"], 1, 1, 1, 1, 0, 0 )
			
		else
	
			local selected = ArkInventory.db.char.option.ldb.mounts[mountType].selected
			local count = ArkInventory.LDB.Companion.GetSelectedCount( selected )
			
			if count == 0 then
				
				-- random all
				self:AddDoubleLine( mode, ArkInventory.Localise["RANDOM"], 1, 1, 1, 1, 1, 1 )
			
			else
				
				if count > 1 then
					
					-- random selection
					self:AddDoubleLine( mode, string.format( "%s (%s/%s)", ArkInventory.Localise["RANDOM"], count, total ), 1, 1, 1, 1, 1, 1 )
					
				else
					
					-- just the one
					for k, v in pairs( selected ) do
						if v then
							local name = GetSpellInfo( k )
							self:AddDoubleLine( mode, name, 1, 1, 1, 1, 1, 1 )
						end
					end
					
				end
				
			end
			
		end
		
	end
	
end

function ArkInventory.LDB.Mounts:OnClick( button )
	
	if button == "RightButton" then
		
		ArkInventory.MenuMountsOpen( self )
		
	else
		
		local companionType = "MOUNT"
		
		if IsMounted( ) then
			
			if IsFlying( ) then
				if not ArkInventory.db.char.option.ldb.mounts.a.dismount then
					ArkInventory.OutputWarning( ArkInventory.Localise["LDB_MOUNTS_FLYING_DISMOUNT_WARNING"] )
				else
					DismissCompanion( companionType )
				end
			else
				DismissCompanion( companionType )
			end
			
			return
			
		end
		
		if ArkInventory.Global.Mode.Combat then return end
		
		local forceAlternative = IsModifiedClick( "CHATLINK" )
		local limitZone = IsModifiedClick( "DRESSUP" )
		
		if GetNumCompanions( companionType ) == 0 then return end
		
		
		ArkInventory.LDB.Mounts:Update( true )
		
		ArkInventory.LDB.Companion.GetUsable( companionType, false, forceAlternative, limitZone )
		
		
		if limitZone and forceAlternative and #companionTable == 0 then
			
			-- if both are true and no results then ignore limitZone
			ArkInventory.LDB.Companion.GetUsable( companionType, false, forceAlternative )
				
			if #companionTable == 0 then
				-- if there are still no results then ignore forceAlternative as well
				ArkInventory.LDB.Companion.GetUsable( companionType )
			end
			
		elseif ( limitZone or forceAlternative ) and #companionTable == 0 then
			
			ArkInventory.LDB.Companion.GetUsable( companionType )
			
		end
		
		
		--ArkInventory.Output( #companionTable, " available mounts" )
		
		if #companionTable == 0 then
			-- no mounts
			--ArkInventory.Output( "no usable mounts" )
			return
		end
		
		-- remove auras, except shapeshifts cannot be removed via code
--		for i = 40, 1, -1 do
--			local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura( "player", i, "CANCELABLE" )
--			if spellId and ArkInventory.db.char.option.ldb.mounts.aura[spellId] then
--				CancelUnitBuff( "player", name, nil )
--			end
--		end
		
--		local sf = GetShapeshiftForm( true )
--		if not ok and sf > 0 and ArkInventory.db.global.option.message.shapeshift.warning then
--			ArkInventory.OutputWarning( "You are currently shapeshifted (id=", sf, "). Mount summon may fail until you manually remove the shapeshift" )
--			return
--		end
		
		if #companionTable == 1 then
			CallCompanion( companionType, companionTable[1] )
		else
			CallCompanion( companionType, companionTable[random( 1, #companionTable )] )
		end
		
	end
	
end

function ArkInventory.LDB.Mounts.Cleanup( )
	
	local companionType = "MOUNT"
	
	-- remove any selected companions we no longer have (not sure how but just in case)
	for _, mountType in pairs( ArkInventory.Const.MountTypes ) do
		local selected = ArkInventory.db.char.option.ldb.mounts[mountType].selected
		for k, v in pairs( selected ) do
			if v ~= nil and not ArkInventory.Global.Companion.MOUNT[k] then
				--ArkInventory.Output( "removing selected mount we dont have any more - ", k )
				selected[k] = nil
			end
		end
	end
	
	-- if all companions are selected then deselect them all
	for _, mountType in pairs( ArkInventory.Const.MountTypes ) do
		
		local selected = ArkInventory.db.char.option.ldb.mounts[mountType].selected
		local n1 = ArkInventory.LDB.Companion.GetTotal( companionType, mountType )
		local n2 = ArkInventory.LDB.Companion.GetSelectedCount( selected )
		
		--ArkInventory.Output( mountType, " / ", n1, " / ", n2, " / ", selected )
		
		if n1 == n2 then
			for k, v in pairs( selected ) do
				if v == true then
					selected[k] = nil
				end
			end
		end
		
	end
	
end


function ArkInventory.LDB.Mounts.RidingSkill( )
	
	local skill = 0
	
	if UnitLevel( "player" ) < ArkInventory.Const.PLAYER_MOUNT_LEVEL then
		
		--ArkInventory.Output( "player level is too low for flying" )
		
	else
		
		if GetSpellInfo( ( GetSpellInfo( 33388 ) ) ) then -- apprentice
			skill = 75
			--ArkInventory.Output( "riding skill = ", skill, "/apprentice" )
		elseif GetSpellInfo( ( GetSpellInfo( 33391 ) ) ) then -- journeyman
			skill = 150
			--ArkInventory.Output( "riding skill = ", skill, "/journeyman" )
		elseif GetSpellInfo( ( GetSpellInfo( 34090 ) ) ) then -- expert
			skill = 225
			--ArkInventory.Output( "riding skill = ", skill, "/expert" )
		elseif GetSpellInfo( ( GetSpellInfo( 34091 ) ) ) then -- artisan
			skill = 300
			--ArkInventory.Output( "riding skill = ", skill, "/artisan" )
		elseif GetSpellInfo( ( GetSpellInfo( 90265 ) ) ) then -- master
			skill = 300
			--ArkInventory.Output( "riding skill = ", skill, "/master" )
		end
		
	end
	
	return skill
	
end

function ArkInventory.LDB.Mounts.IsFlyable( useMapZone )
	
	ArkInventory.IsFlyable = IsFlyableArea( )  -- its got some issues, but it usually only wrong about flying zones
	
	if ArkInventory.IsFlyable then
		
		if ArkInventory.LDB.Mounts.RidingSkill( ) < 225 then
			
			--ArkInventory.Output( "riding skill ", skill, " is too low for flying" )
			ArkInventory.IsFlyable = false
			
		else
			
			if ( useMapZone ) or ( not WorldMapFrame:IsVisible( ) ) then
				
				-- only set the map zone if the world map is not open or we need to force it
				
				SetMapToCurrentZone( ) -- wont work after a uireload, requires a zone change to kick in
				local zone = GetCurrentMapContinent( )
				-- -1 = instance
				--  0 = cosmic
				--  1 = kalimdor
				--  2 = eastern kingdoms
				--  3 = outland
				--  5 = maelstrom (deepholm)
				--  6 = pandaria
				
				if zone == 1 or zone == 2 then
					
					if not GetSpellInfo( ( GetSpellInfo( 90267 ) ) ) then
						--ArkInventory.Output( "azeroth but you dont know flight masters licence" )
						ArkInventory.IsFlyable = false
					end
					
				elseif zone == 4 then
					
					if not GetSpellInfo( ( GetSpellInfo( 54197 ) ) ) then
						
						--ArkInventory.Output( "northrend but you dont know cold weather flying" )
						ArkInventory.IsFlyable = false
						
					end
					
				elseif zone == 6 then
					
					if not GetSpellInfo( ( GetSpellInfo( 115913 ) ) ) then
						
						--ArkInventory.Output( "pandaria but you dont know wisdom of the four winds" )
						ArkInventory.IsFlyable = false
						
					end
					
				end
				
			end
			
		end
		
	end
	
	if ArkInventory.IsFlyable then
		
		-- world pvp battle in progress?
		
		for index = 1, GetNumWorldPVPAreas( ) do
			
			local pvpID, pvpZone, isActive = GetWorldPVPAreaInfo( index )
			--ArkInventory.Output( pvpID, " / ", pvpZone, " / ", isActive )
			
			if ArkInventory.IsFlyable and isActive and GetRealZoneText( ) == pvpZone then
				-- ArkInventory.Output( "battle in progress, no flying allowed" )
				ArkInventory.IsFlyable = false
				break
			end
		end
		
	end
	
end

function ArkInventory.LDB.Companion.GetAvailable( companionType, ignoreActive, mountType, limitZone )
	
	-- gather all usable companions
	
	if ( companionType == "CRITTER" ) then
		ArkInventory.LDB.Pets:GetAvailable( companionType, ignoreActive )
	elseif ( companionType == "MOUNT" ) then
		ArkInventory.LDB.Mounts:GetAvailable( companionType, ignoreActive, mountType, limitZone )
	end
	
end

function ArkInventory.LDB.Mounts:GetAvailable( companionType, ignoreActive, mountType, limitZone )
	
	table.wipe( companionTable )
	
	if ( companionType ~= "MOUNT" ) then return end
	
	if ( not mountType ) then return end
	
	local n = GetNumCompanions( companionType )
	if n == 0 then return end
	
	local selected = ArkInventory.db.char.option.ldb.mounts[mountType].selected
	local selectedCount = ArkInventory.LDB.Companion.GetSelectedCount( selected )
	
	if selectedCount == 1 then
		ignoreActive = true
	end
	
	--ArkInventory.Output( "selected ", mountType, "=", selectedCount, " = ", selected )
	
	local count = 0
	
	local mountData = ArkInventory.Global.Companion.MOUNT
	
	for idx = 1, n do
		
		local companionID, name, spellID, texture, active = GetCompanionInfo( companionType, idx )
		
		if ( not active or ignoreActive ) and ( ( selectedCount == 0 and selected[spellID] ~= false ) or ( selectedCount > 0 and selected[spellID] == true ) ) then
			
			--ArkInventory.Output( idx, " / ", name, " / ", limitZone )
			local mountEntry = mountData[spellID]
			
			local ok = IsUsableSpell( spellID )
			
			if ok and mountType then
				ok = ( mountEntry.mt == mountType )
			end
			
			if ok and limitZone and ( not mountEntry.r or not mountEntry.r.zone ) then
				ok = false
			end
			
			if ok and mountEntry.r then
				
				if ok and mountEntry.r.zone then
					
					-- has a zone restriction
					ok = false
					
					for r in string.gmatch( mountEntry.r.zone, "[^,]+" ) do
						if GetRealZoneText( ) == ArkInventory.Localise[string.upper( string.format( "WOW_ZONE_%s", r ) )] then
							ok = true
							break
						end
					end
					
--					if not ok then
--						ArkInventory.Output( name, " failed zone restrictions of ", mountEntry.r.zone )
--					end
					
				end
				
				if ok and mountEntry.r.item then
					
					-- requires specific item(s)
					
					-- blizzard seem to be handling this part ok but it cant hurt to code for it now.
					-- its only for snowballs so far as i can tell
					
					for r in string.gmatch( mountEntry.r.item, "[^,]+" ) do
						local id, count = string.match( r, "(%d+)x(%d+)" )
						--ArkInventory.Output( r, " = ", id, " / ", count )
						if GetItemCount( tonumber( id ) ) < tonumber( count ) then
							ok = false
							break
						end
					end
					
--					if not ok then
--						ArkInventory.Output( name, " failed item restrictions of ", mountEntry.r.item )
--					end
					
				end
				
				if ok and mountEntry.r.event then
					
					-- has an event/holiday restriction
					ok = false
					
--					for r in string.gmatch( mountEntry.r.event, "[^,]+" ) do
						
						-- figure out how to check for holidays?  probably look at the calendar.
						-- not urgent as no spells currently have this, only items, and we cant use items yet
						
--					end
					
--					if not ok then
--						ArkInventory.Output( name, " failed event restrictions of ", mountEntry.r.event )
--					end
					
				end
				
			end
			
			if ok then
				count = count + 1
				companionTable[count] = idx
			end
			
		end
		
	end
	
	--ArkInventory.Output( "result = ", companionTable )
	
end

function ArkInventory.LDB.Pets:GetAvailable( companionType, ignoreActive )
	
	table.wipe( companionTable )
	
	if companionType ~= "CRITTER" then return end
	
	local n = ArkInventory.Lib.Pet:NumPets( )
	if n == 0 then return end
	
	local selected = ArkInventory.db.char.option.ldb.pets.selected
	local selectedCount = ArkInventory.LDB.Companion.GetSelectedCount( selected )
	
	if selectedCount == 1 then
		ignoreActive = true
	end
	
	--ArkInventory.Output( "selected[", selectedCount, "] = ", selected )
	
	local count = 0
	local activePet = C_PetJournal.GetSummonedPetID( )
	local activeSpecies = activePet and C_PetJournal.GetPetInfoByPetID( activePet )
	
	for _, petID in ArkInventory.Lib.Pet:IteratePetIDs( ) do
		
		local speciesID = C_PetJournal.GetPetInfoByPetID( petID )
		
		if ( C_PetJournal.PetIsSummonable( petID ) ) and ( not active or ignoreActive ) and ( speciesID ~= activeSpecies ) and ( ( selectedCount == 0 and selected[petID] ~= false ) or ( selectedCount > 0 and selected[petID] == true ) ) then
			-- must be summonable, ignore dead pets
			-- cannot be same current species as active pet, if one was active
			count = count + 1
			companionTable[count] = petID
		end
	end
	
end

function ArkInventory.LDB.Companion.GetSelectedCount( selected )
	local count = 0				
	for k, v in pairs( selected ) do
		if v then count = count + 1 end
	end
	return count
end

function ArkInventory.LDB.Companion.GetUsable( companionType, ignoreActive, forceAlternative, limitZone )
	
	if companionType == "CRITTER" then
		return ArkInventory.LDB.Companion.GetAvailable( companionType, ignoreActive )
	end
	
	if IsSwimming( ) then
		if ( not forceAlternative ) then
			--ArkInventory.Output( "check underwater" )
			ArkInventory.LDB.Companion.GetAvailable( companionType, ignoreActive, "u", limitZone )
			if #companionTable > 0 then return "u" end
		else
			--ArkInventory.Output( "ignore underwater, force flying" )
		end
	end
	
	if ArkInventory.IsFlyable then
		--ArkInventory.Output( "can fly here" )
		if ( not forceAlternative ) or ( forceAlternative and IsSwimming( ) ) then
			--ArkInventory.Output( "check flying" )
			ArkInventory.LDB.Companion.GetAvailable( companionType, ignoreActive, "a", limitZone )
			if #companionTable > 0 then return "a" end
		else
			--ArkInventory.Output( "ignore flying, force land" )
		end
	end
	
	--ArkInventory.Output( "check land" )
	ArkInventory.LDB.Companion.GetAvailable( companionType, ignoreActive, "l", limitZone )
	if #companionTable > 0 then return "l" end
	
	--ArkInventory.Output( "no land mounts, check flying mounts" )
	ArkInventory.LDB.Companion.GetAvailable( companionType, ignoreActive, "a", limitZone )
	if #companionTable > 0 then return "a" end
	
	--ArkInventory.Output( "no land or flying mounts, check underwater mounts (doubt it)" )
	ArkInventory.LDB.Companion.GetAvailable( companionType, ignoreActive, "u", limitZone )
	if #companionTable > 0 then return "u" end

end

function ArkInventory.LDB.Companion.GetTotal( companionType, mountType )
	
	if companionType == "CRITTER" then
		return ArkInventory.Lib.Pet:NumPets( )
	end
	
	local count = 0
	
	for companionIndex = 1, GetNumCompanions( companionType ) do
		
		local companionID, name, spellID, texture, active = GetCompanionInfo( companionType, companionIndex )
		local mountData = ArkInventory.Global.Companion.MOUNT[spellID]
		
		if mountData and mountData.usable[mountType] then
			count = count + 1
		end
		
	end
	
	return count
	
end
