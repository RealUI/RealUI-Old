local function FindPartialStack( loc_id, cb, cs, id )
	
	--ArkInventory.OutputDebug( "FindPartialStack( ", loc_id, ", ", cb, ".", cs, ", ", id, " )" )
	
	if loc_id == ArkInventory.Const.Location.Vault then
		
		local bag_id = cb
		local numslots = MAX_GUILDBANK_SLOTS_PER_TAB
		
		--ArkInventory.OutputDebug( "tab=", bag_id, ", slots=", numslots )
		
		for slot_id = 1, numslots do
			
			if ( not ArkInventory.Global.Mode.Vault ) or ( bag_id ~= GetCurrentGuildBankTab( ) ) then
				return false -- no longer at the vault or changed tabs, abort
			end
			
			if slot_id ~= cs then
				
				--ArkInventory.OutputDebug( "checking slot ", slot_id, " " , count, " x ", h )
				
				if not select( 3, GetGuildBankItemInfo( bag_id, slot_id ) ) then
				
					local h = GetGuildBankItemLink( bag_id, slot_id )
					
					if h then
						
						local item_id = ArkInventory.ObjectStringDecodeItem( h )
						
						if item_id == id then
							
							local stack = select( 10, ArkInventory.ObjectInfo( h ) )
							local count = select( 2, GetGuildBankItemInfo( bag_id, slot_id ) )
							
							if count < stack then
								--ArkInventory.OutputDebug( "found > ", bag_id, ".", slot_id )
								return true, bag_id, slot_id, count
							end
							
						end
						
					end
					
				end
				
			end
			
		end
		
	else
		
		for _, bag_id in pairs( ArkInventory.Global.Location[loc_id].Bags ) do
			
			local numslots = GetContainerNumSlots( bag_id )
			
			--ArkInventory.OutputDebug( "bag=", bag_id, ", slots=", numslots )
			
			for slot_id = 1, numslots do
				
				if ( loc_id == ArkInventory.Const.Location.Bank ) and ( not ArkInventory.Global.Mode.Bank ) then
					return false -- no longer at bank, abort
				end
				
				if not ( bag_id == cb and slot_id == cs ) then
					
					if not select( 3, GetContainerItemInfo( bag_id, slot_id ) ) then
						
						local h = GetContainerItemLink( bag_id, slot_id )
						
						if h then
							
							local item_id = ArkInventory.ObjectStringDecodeItem( h )
							
							if item_id == id then
								
								local stack = select( 10, ArkInventory.ObjectInfo( h ) )
								local count = select( 2, GetContainerItemInfo( bag_id, slot_id ) )
								
								if count < stack then
									--ArkInventory.OutputDebug( "found > ", bag_id, ".", slot_id )
									return true, bag_id, slot_id, count
								end
								
							end
							
						end
						
					end
					
				end
				
			end
			
		end
		
	end
	
	--ArkInventory.OutputDebug( "no other partial stacks found" )
	return false
	
end

local function FindProfessionItem( loc_id, ct )
	
	if loc_id == ArkInventory.Const.Location.Vault then
		return false -- vault doesnt have special bags
	end
	
	for _, bag_id in pairs( ArkInventory.Global.Location[loc_id].Bags ) do
	
		local _, bt = GetContainerNumFreeSlots( bag_id )
		
		-- only match items in normal bags to move them to profession bags
		if bt == 0 then
		
			for slot_id = 1, GetContainerNumSlots( bag_id ) do
				
				if ( loc_id == ArkInventory.Const.Location.Bank ) and ( not ArkInventory.Global.Mode.Bank ) then
					return false -- no longer at bank, abort
				end
				
				--ArkInventory.OutputDebug( "checking for special item at ", bag_id, ".", slot_id )
				
				if not select( 3, GetContainerItemInfo( bag_id, slot_id ) ) then
					
					local h = GetContainerItemLink( bag_id, slot_id )
					
					if h then
						
						-- ignore bags
						if select( 11, ArkInventory.ObjectInfo( h ) ) ~= "INVTYPE_BAG" then
							
							local it = GetItemFamily( h )
							
							if bit.band( it, ct ) > 0 then
								--ArkInventory.OutputDebug( "special > ", bag_id, ".", slot_id )
								return true, bag_id, slot_id
							end
							
						end
						
					end
					
				end
				
			end
			
		end
		
	end

	--ArkInventory.OutputDebug( "no items found for special slot" )
	return false

end

local function CompactBags( loc_id )

	local recheck = false
	
	for _, bag_id in pairs( ArkInventory.Global.Location[loc_id].Bags ) do
		
		for slot_id = 1, GetContainerNumSlots( bag_id ) do
			
			if ( loc_id == ArkInventory.Const.Location.Bank ) and ( not ArkInventory.Global.Mode.Bank ) then
				return false -- no longer at bank, abort
			end
			
			--ArkInventory.OutputDebug( "checking ", bag_id, ".", slot_id )
			
			if select( 3, GetContainerItemInfo( bag_id, slot_id ) ) then
				
				--ArkInventory.OutputDebug( "locked > ", bag_id, ".", slot_id )
				recheck = true -- this slot is locked, move on and check it again next time
				
			else
			
				local h = GetContainerItemLink( bag_id, slot_id )
				
				if h then
					
					local item_id = ArkInventory.ObjectStringDecodeItem( h )
					local stack = select( 10, ArkInventory.ObjectInfo( h ) )
					local count = select( 2, GetContainerItemInfo( bag_id, slot_id ) )
					
					if count < stack then
						
						--ArkInventory.OutputDebug( "partial stack of ", count, "x", h, " found at ", bag_id, ".", slot_id )
						
						local ok, pb, ps, pc = FindPartialStack( loc_id, bag_id, slot_id, item_id )
						
						if ok then
							
							--ArkInventory.OutputDebug( "merge > ", bag_id, ".", slot_id, " + ", pb, ".", ps )
							
							ClearCursor( )
							PickupContainerItem( pb, ps )
							PickupContainerItem( bag_id, slot_id )
							ClearCursor( )
							
							recheck = true
							
						end
					
					end
					
				end
				
			end
			
		end
		
	end
	
	if recheck then
		--ArkInventory.OutputDebug( "yielding - pending bag/lock update" )
		coroutine.yield( )
		--ArkInventory.OutputDebug( "resumed" )
	end
	
	return recheck
	
end

local function CompactVault( )

	local loc_id = ArkInventory.Const.Location.Vault
	local bag_id = GetCurrentGuildBankTab( )
	
	local _, _, isViewable, canDeposit = GetGuildBankTabInfo( bag_id )
	
	if not ( IsGuildLeader( ) or ( isViewable and canDeposit ) ) then
		ArkInventory.Output( string.format( ArkInventory.Localise["RESTACK_FAIL_ACCESS"], GUILD_BANK, bag_id ) )
		return
	end
	
	local recheck = false
	
	for slot_id = 1, MAX_GUILDBANK_SLOTS_PER_TAB do
		
		if ( not ArkInventory.Global.Mode.Vault ) or ( bag_id ~= GetCurrentGuildBankTab( ) ) then
			return false -- no longer at the vault or changed tabs, abort
		end
		
		--ArkInventory.OutputDebug( "checking vault ", bag_id, ".", slot_id )
		
		if select( 3, GetGuildBankItemInfo( bag_id, slot_id ) ) then
			
			--ArkInventory.OutputDebug( "locked > ", bag_id, ".", slot_id )
			recheck = true -- this slot is locked, move on and check it again next time
			
		else
			
			local h = GetGuildBankItemLink( bag_id, slot_id )
			
			--ArkInventory.OutputDebug( "tab=[", bag_id, "], slot=[", slot_id, "] count=[", count, "] locked=[", locked, "] item=", h )
			
			if h then
				
				local item_id = ArkInventory.ObjectStringDecodeItem( h )
				local stack = select( 10, ArkInventory.ObjectInfo( h ) )
				local count = select( 2, GetGuildBankItemInfo( bag_id, slot_id ) )
				
				if count < stack then
					
					--ArkInventory.OutputDebug( "partial > ", bag_id, ".", slot_id )
					
					local ok, pb, ps, pc = FindPartialStack( loc_id, bag_id, slot_id, item_id )
					
					if ok then
						
						--ArkInventory.OutputDebug( "merge > ", bag_id, ".", slot_id, " + ", pb, ".", ps )
						
						ClearCursor( )
						PickupGuildBankItem( pb, ps )
						PickupGuildBankItem( bag_id, slot_id )
						ClearCursor( )
						
						--ArkInventory.OutputDebug( "yielding - pending vault update" )
						coroutine.yield( )
						--ArkInventory.OutputDebug( "resumed" )
						
						recheck = true
						
					end
					
				end
			
			end
			
		end
		
	end
	
	return recheck
	
end

local function Consolidate( loc_id )
	
	--ArkInventory.Output( "consolidating" )
	
	local recheck = false
	
	if loc_id == ArkInventory.Const.Location.Vault then
		return false
	end
	
	-- move items into appropriate bag types with empty slots
	for _, bag_id in pairs( ArkInventory.Global.Location[loc_id].Bags ) do
		
		local _, bt = GetContainerNumFreeSlots( bag_id )
		
		if bt ~= 0 then
			
			--ArkInventory.OutputDebug( "bag=[", bag_id, "], type=[", bt, "]" )
			
			for slot_id = 1, GetContainerNumSlots( bag_id ) do
				
				if ( loc_id == ArkInventory.Const.Location.Bank ) and ( not ArkInventory.Global.Mode.Bank ) then
					return false -- no longer at bank, abort
				end
				
				--ArkInventory.OutputDebug( "checking bag=[", bag_id, "], slot=[", slot_id, "]" )
				
				if select( 3, GetContainerItemInfo( bag_id, slot_id ) ) then
					
					--ArkInventory.Output( "locked > ", bag_id, ".", slot_id )
					recheck = true -- this slot is locked, move on and check it again next time
					
				else
				
					local h = GetContainerItemLink( bag_id, slot_id )
					
					if not h then
						
						--ArkInventory.OutputDebug( "empty > ", bag_id, ".", slot_id )
						
						local ok, sb, ss = FindProfessionItem( loc_id, bt )
						
						if ok then
						
							--ArkInventory.OutputDebug( "move> ", sb, ".", ss, " to ", bag_id, ".", slot_id )
							
							ClearCursor( )
							PickupContainerItem( sb, ss )
							PickupContainerItem( bag_id, slot_id )
							ClearCursor( )
							
						end
						
					end
					
				end
				
			end
			
		end
		
	end
	
	if recheck then
		--ArkInventory.OutputDebug( "yielding - pending bag/lock update" )
		coroutine.yield( )
		--ArkInventory.OutputDebug( "resumed" )
	end
	
	return recheck
	
end

local function FindEmpty( loc_id, cb, ct )
	
	if ct ~= 0 then
		
		for _, bag_id in pairs( ArkInventory.Global.Location[loc_id].Bags ) do
		
			local _, bt = GetContainerNumFreeSlots( bag_id )
			
			-- look for same bag type first
			if bag_id ~= cb and bt == ct then
			
				for slot_id = 1, GetContainerNumSlots( bag_id ) do
					
					if ( loc_id == ArkInventory.Const.Location.Bank ) and ( not ArkInventory.Global.Mode.Bank ) then
						return false -- no longer at bank, abort
					end
					
					if not select( 3, GetContainerItemInfo( bag_id, slot_id ) ) then
						
						local h = GetContainerItemLink( bag_id, slot_id )
						
						if not h then
							return true, bag_id, slot_id
						end
						
					end
					
				end
				
			end
			
		end
	
	end
	
	for _, bag_id in pairs( ArkInventory.Global.Location[loc_id].Bags ) do
	
		local _, bt = GetContainerNumFreeSlots( bag_id )
		
		if bag_id ~= cb and bt == 0 then
		
			for slot_id = 1, GetContainerNumSlots( bag_id ) do
				
				if ( loc_id == ArkInventory.Const.Location.Bank ) and ( not ArkInventory.Global.Mode.Bank ) then
					return false -- no longer at bank, abort
				end
				
				if not select( 3, GetContainerItemInfo( bag_id, slot_id ) ) then
					
					local h = GetContainerItemLink( bag_id, slot_id )
					
					if not h then
						return true, bag_id, slot_id
					end
					
				end
				
			end
			
		end
		
	end
	
	--ArkInventory.Output( "no empty slots found" )
	return false
	
end

local function RestackRun( loc_id )
	
	-- DO NOT USE CACHED DATA FOR RESTACKING, PULL THE DATA DIRECTLY FROM WOW AGAIN, THE UI WILL CATCH UP
	
	if loc_id == ArkInventory.Const.Location.Bag then
		
		ArkInventory.Output( ArkInventory.Localise["RESTACK"], ": ", ArkInventory.Global.Location[loc_id].Name, " " , ArkInventory.Localise["START"] )
		
		while CompactBags( loc_id ) do end
		while Consolidate( loc_id ) do end
		
		ArkInventory.Output( ArkInventory.Localise["RESTACK"], ": ", ArkInventory.Global.Location[loc_id].Name, " " , ArkInventory.Localise["COMPLETE"] )
		
	elseif loc_id == ArkInventory.Const.Location.Bank then
		
		if ArkInventory.Global.Mode.Bank then
			
			ArkInventory.Output( ArkInventory.Localise["RESTACK"], ": ", ArkInventory.Global.Location[loc_id].Name, " " , ArkInventory.Localise["START"] )
			
			while CompactBags( loc_id ) do end
			while Consolidate( loc_id ) do end
			
			ArkInventory.Output( ArkInventory.Localise["RESTACK"], ": ", ArkInventory.Global.Location[loc_id].Name, " " , ArkInventory.Localise["COMPLETE"] )
			
		end
		
	elseif loc_id == ArkInventory.Const.Location.Vault then
		
		if ArkInventory.Global.Mode.Vault then
			
			ArkInventory.Output( ArkInventory.Localise["RESTACK"], ": ", ArkInventory.Global.Location[loc_id].Name, " " , ArkInventory.Localise["START"] )
			
			while CompactVault( ) do end
			
			ArkInventory.Output( ArkInventory.Localise["RESTACK"], ": ", ArkInventory.Global.Location[loc_id].Name, " " , ArkInventory.Localise["COMPLETE"] )
			
		end
		
	end
	
end

function ArkInventory.RestackResume( loc_id )

	--ArkInventory.Output( "ResumeThreads ", loc_id )
	
	if type( ArkInventory.Global.Thread.Restack[loc_id] ) == "thread" and coroutine.status( ArkInventory.Global.Thread.Restack[loc_id] ) == "suspended" then
		-- resume current thread
		coroutine.resume( ArkInventory.Global.Thread.Restack[loc_id] )
	end
	
end

local function RestackLocation( loc_id )
	
	if type( ArkInventory.Global.Thread.Restack[loc_id] ) ~= "thread" or coroutine.status( ArkInventory.Global.Thread.Restack[loc_id] ) == "dead" then
		
		-- thread not active, create a new one
		ArkInventory.Global.Thread.Restack[loc_id] = coroutine.create(
			function ( )
				RestackRun( loc_id )
			end
		)
		
		-- run it
		coroutine.resume( ArkInventory.Global.Thread.Restack[loc_id] )
		
	else
		
		-- restack already in progress
		ArkInventory.OutputError( ArkInventory.Localise["RESTACK"], ": ", ArkInventory.Global.Location[loc_id].Name, " " , ArkInventory.Localise["RESTACK_FAIL_WAIT"] )
		
		-- give it a push, just in case
		coroutine.resume( ArkInventory.Global.Thread.Restack[loc_id] )
		
	end
	
end

function ArkInventory.Restack( )
	
	--ArkInventory.Output( ArkInventory.Localise["RESTACK"], ": ", ArkInventory.Localise["START"] )
	
	for k, v in pairs( ArkInventory.Global.Location ) do
		if v.canRestack then
			RestackLocation( k )
		end
	end
	
	--ArkInventory.Output( ArkInventory.Localise["RESTACK"], ": ", ArkInventory.Localise["COMPLETE"] )
	
end

function ArkInventory.EmptyBag( loc_id, cbag )
	
	local cbag = ArkInventory.BagID_Blizzard( loc_id, cbag )
	
	if not ( loc_id == ArkInventory.Const.Location.Bag or loc_id == ArkInventory.Const.Location.Bank ) then
		return
	end
	
	local _, ct = GetContainerNumFreeSlots( cbag )
	local cslot = 0
	
	--ArkInventory.Output( "empty ", cbag, " [", ct, "]" )
	
	for _, bag_id in pairs( ArkInventory.Global.Location[loc_id].Bags ) do
		
		local _, bt = GetContainerNumFreeSlots( bag_id )
		
		if bag_id ~= cbag and ( bt == 0 or bt == ct ) then
			
			for slot_id = 1, GetContainerNumSlots( bag_id ) do
				
				if ( loc_id == ArkInventory.Const.Location.Bank ) and ( not ArkInventory.Global.Mode.Bank ) then
					return -- no longer at bank, abort
				end
				
				local h = GetContainerItemLink( bag_id, slot_id )
				
				if not h then
					
					repeat
						cslot = cslot + 1
						h = GetContainerItemLink( cbag, cslot )
					until h or cslot > GetContainerNumSlots( cbag )
					
					if h then
						ClearCursor( )
						PickupContainerItem( cbag, cslot )
						PickupContainerItem( bag_id, slot_id )
						ClearCursor( )
					end
				
				end
				
			end
			
		end
		
	end
	
end
