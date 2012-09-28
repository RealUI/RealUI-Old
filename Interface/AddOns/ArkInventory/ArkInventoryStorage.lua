local _G = _G
local select = _G.select
local pairs = _G.pairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table


function ArkInventory.EraseSavedData( player_id, loc_id, silent )
	
	--ArkInventory.Output( "EraseSavedData( ", player_id, ", ", loc_id, ", ", silent, " )" )
	
	local rescan
	
	-- erase tooltip cache
	ArkInventory.Table.Clean( ArkInventory.Global.Cache.ItemCountRaw, nil, true )
	ArkInventory.Table.Clean( ArkInventory.Global.Cache.ItemCount, nil, true )
	
	-- erase data
	for pk, pv in pairs( ArkInventory.db.realm.player.data ) do
		
		if ( player_id == nil ) or ( string.lower( pk ) == string.lower( player_id ) ) then

			if ( string.lower( pk ) == string.lower( UnitName( "player" ) ) ) then
				rescan = true
			end
		
			for lk, lv in pairs( pv.location ) do
				
				if ( loc_id == nil ) or ( lk == loc_id ) then
					
					ArkInventory.Frame_Main_Hide( lk )
					
					lv.slot_count = 0
					
					for bk, bv in pairs( lv.bag ) do
						ArkInventory.Table.Clean( bv )
						bv.status = ArkInventory.Const.Bag.Status.Unknown
						bv.type = ArkInventory.Const.Slot.Type.Unknown
						bv.count = 0
						bv.empty = 0
						table.wipe( bv.slot )
					end
					
					ArkInventory.Frame_Main_DrawStatus( lk, ArkInventory.Const.Window.Draw.Recalculate )
					if ArkInventory.Global.Location[lk] and not silent then
						ArkInventory.Output( "Saved ", string.lower( ArkInventory.Global.Location[lk].Name ), " data for ", pv.info.name, " has been erased" )
					end
					
				end
				
			end
			
			
			if ( loc_id == nil ) or ( ( loc_id == ArkInventory.Const.Location.Vault ) and ( pv.info.class == "GUILD" ) ) then
				-- wipe entire player sent so wipe info, also if location is vault then wipe the info as well
				table.wipe( pv.info )
			end
			
			
		end
		
	end
	
	
	if rescan then
		-- current player was wiped, need to rescan
		ArkInventory.PlayerInfoSet( )
		ArkInventory.ScanLocation( )
	end
	
end

function ArkInventory.Table.Sum( tbl, fcn )
	local r = 0
	for k, v in pairs( tbl ) do
		r = r + ( fcn( v ) or 0 )
	end
	return r
end

function ArkInventory.Table.Max( tbl, fcn )
	local r = nil
	for k, v in pairs( tbl ) do
		if not r then
			r = ( fcn( v ) or 0 )
		else
			if ( fcn( v ) or 0 ) > r then
				r = ( fcn( v ) or 0 )
			end
		end
	end
	return r
end

function ArkInventory.Table.Elements( tbl )
	-- #table only returns the number of elements where the table keys are numeric and does not take into account missing values
	if tbl and type( tbl ) == "table" then
		local r = 0
		for _ in pairs( tbl ) do
			r = r + 1
		end
		return r
	end
end

function ArkInventory.Table.IsEmpty( tbl )
	-- #table only returns the number of elements where the table keys are numeric and does not take into account missing values
	if tbl and type( tbl ) == "table" then
		for _ in pairs( tbl ) do
			return false
		end
		return true
	end
end

function ArkInventory.Table.Clean( tbl, key, nilsubtables )

	-- tbl = table to be cleaned

	-- key = a specific key you want cleaned (nil for all keys)

	-- nilsubtables (true) = if a value is a table then nil it as well
	-- nilsubtables (false) = if a value is a table then leave the skeleton there
	
	if type( tbl ) ~= "table" then
		return
	end
	
	for k, v in pairs( tbl ) do
		
		if key == nil or key == k then
		
			if type( v ) == "table" then
				
				ArkInventory.Table.Clean( v, nil, nilsubtables )
				
				if nilsubtables then
					--ArkInventory.Output( "erasing subtable ", k )
					tbl[k] = nil
				end
				
			else
				
				--ArkInventory.Output( "erasing value ", k )
				tbl[k] = nil

			end
			
		end
		
	end

end

local function spairs_iter( a )
	a.idx = a.idx + 1
	local k = a[a.idx]
	if k ~= nil then
		return k, a.tbl[k]
	end
	--table.wipe( a )
	a.tbl = nil
end

function ArkInventory.spairs( tbl, cf )
	
	if type( tbl ) ~= "table" then return end
	
	local a = { }
	local c = 0
	
	for k in pairs( tbl ) do
		c = c + 1
		a[c] = k
	end
	
	table.sort( a, cf )
	
	a.idx = 0
	a.tbl = tbl
	
	return spairs_iter, a
	
end

function ArkInventory.PlayerInfoSet( )
	
	--ArkInventory.Output( "PlayerInfoSet" )
	
	local r = GetRealmName( )
	local f, f2 = UnitFactionGroup( "player" )
	local n = UnitName( "player" )
	
	ArkInventory.Global.Me = ArkInventory.db.realm.player.data[n]
	
	local p = ArkInventory.Global.Me.info
	
	p.player_id = n
	
	p.realm = r
	p.faction = f
	p.faction_local = f2
	p.name = n
	
	
	-- WARNING, most of this stuff is not available upon first login, even when the mod gets to OnEnabled (ui reloads are fine), and some are not available on logout
	
	p.class_local, p.class = UnitClass( "player" )
	p.level = UnitLevel( "player" )
	p.race_local, p.race = UnitRace( "player" )
	p.gender = UnitSex( "player" )
	
	local m = GetMoney( )
	if m > 0 then  -- returns 0 on logout so dont wipe the current value
		p.money = m
	end
	
	if p.class == "WARLOCK" then
		ArkInventory.db.global.option.tracking.items[6265] = true
	end
	
	
	if not ArkInventory.LocationIsMonitored( ArkInventory.Const.Location.Vault ) then
		
		p.guild = nil
		p.guild_id = nil
		
	else
		
		--ArkInventory.Output( "IsInGuild=[", IsInGuild( ), "], g=[", p.guild, "]" )
		p.guild = GetGuildInfo( "player" )
		
		if not p.guild then
			
			p.guild = nil
			p.guild_id = nil
			
		else
			
			p.guild_id = string.format( "%s%s", ArkInventory.Const.GuildTag, p.guild )
			
			local n = string.format( "%s%s", ArkInventory.Const.GuildTag, p.guild )
			local g = ArkInventory.db.realm.player.data[n].info
			
			g.player_id = n
			g.class_local, g.class = GUILD, "GUILD"
			
			g.realm = p.realm
			g.faction = p.faction
			g.faction_local = p.faction_local
			g.name = p.guild
			
			g.guild = p.guild
			g.guild_id = p.guild_id
			
			g.level = GetGuildLevel( )
			
			g.money = GetGuildBankMoney( )
			
		end
		
	end
	
	return p
	
end

function ArkInventory.PlayerInfoGet( id )
	
	if id == nil then
		return
	end
	
	return ArkInventory.db.realm.player.data[id]
	
end

function ArkInventory:LISTEN_STORAGE_EVENT( msg, arg1, arg2, arg3, arg4 )
	
	--ArkInventory.Output( "LISTEN_STORAGE_EVENT( ", arg1, ", ", arg2, ", ", arg3, ", ", arg4, " )" )
	
	if arg1 == ArkInventory.Const.Event.BagUpdate then
		
		--ArkInventory.Output( "BAG_UPDATE( ", arg2, ", [", arg4, "] )" )
		ArkInventory.Frame_Main_Generate( arg2, arg4 )
		
	else
		
		error( string.format( "code failure: unknown storage event [%s]", arg1 ) )
		
	end
	
end


function ArkInventory:LISTEN_PLAYER_ENTER( )

	--ArkInventory.Output( "LISTEN_PLAYER_ENTER" )
	
	ArkInventory.PlayerInfoSet( )
	
end

function ArkInventory:LISTEN_PLAYER_LEAVE( )

	--ArkInventory.Output( "LISTEN_PLAYER_LEAVE" )
	
	ArkInventory.Frame_Main_Hide( )
	
	ArkInventory.PlayerInfoSet( )
	
	ArkInventory.ScanAuctionExpire( )
	
	for loc_id in pairs( ArkInventory.Global.Location ) do
		if not ArkInventory.LocationIsSaved( loc_id ) then
			ArkInventory.EraseSavedData( ArkInventory.Global.Me.info.player_id, loc_id, true )
		end
	end
	
end

function ArkInventory:LISTEN_PLAYER_MONEY( )

	--ArkInventory.Output( "PLAYER_MONEY" )

	ArkInventory.PlayerInfoSet( )
	
	-- set saved money amount here as well
	ArkInventory.db.realm.player.data[UnitName( "player" )].info.money = GetMoney( )
	
	ArkInventory.LDB.Money:Update( )
	
end

function ArkInventory:LISTEN_PLAYER_SKILLS( )

	--ArkInventory.Output( "SKILL_LINES_CHANGED" )
	
	ArkInventory.ScanProfessions( )
	ArkInventory.ScanTradeskill( )
	
end


function ArkInventory:LISTEN_COMBAT_ENTER( )
	
	--ArkInventory.Output( "LISTEN_COMBAT_ENTER" )
	
	ArkInventory.Global.Mode.Combat = true
	
	if ArkInventory.db.global.option.auto.close.combat then
		ArkInventory.Frame_Main_Hide( )
	end
	
end

function ArkInventory:LISTEN_COMBAT_LEAVE( )
	
	--ArkInventory.Output( "LISTEN_COMBAT_LEAVE" )
	
	ArkInventory.Global.Mode.Combat = false
	
	for loc_id in pairs( ArkInventory.Global.Location ) do
		
		if ArkInventory.Global.Location[loc_id].tainted then
			
			ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
			
		else
			
			if ArkInventory.LocationOptionGet( loc_id, "slot", "cooldown", "show" ) and not ArkInventory.LocationOptionGet( loc_id, "slot", "cooldown", "combat" )  then
				ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Refresh )
			end
			
		end
		
	end
	
	ArkInventory.LDB.Mounts:Update( )
	
end


function ArkInventory:LISTEN_BAG_UPDATE_BUCKET( bagTable )
	
	--ArkInventory.Output( "LISTEN_BAG_UPDATE_BUCKET( ", bagTable, " )" )
	
	-- bagTable[bag_id] = true

	local bag_changed = false
	
	for blizzard_id in pairs( bagTable ) do
		ArkInventory.Scan( blizzard_id )
		if ArkInventory.BagID_Internal( blizzard_id ) == ArkInventory.Const.Location.Bag then
			bag_changed = true
		end
		ArkInventory.RestackResume( ArkInventory.BagID_Internal( blizzard_id ) )
	end

	-- re-scan empty bag slots to wipe their data - no events are triggered when you move a bag from one bag slot into an empty bag slot (for the empty slot, new slot is fine)
	if bag_changed then
		for _, bag_id in pairs( ArkInventory.Global.Location[ArkInventory.Const.Location.Bag].Bags ) do
			if GetContainerNumSlots( bag_id ) == 0 then
				ArkInventory.ScanBag( bag_id )
			end
		end
	end

	
 	-- instant sorting enabled
	for loc_id in pairs( ArkInventory.Global.Location ) do
		if ArkInventory.LocationOptionGet( loc_id, "sort", "instant" ) then
			ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
		end
	end
	
	ArkInventory.LDB.Bags:Update( )
	
end

function ArkInventory:LISTEN_BAG_UPDATE( event, blizzard_id )
	
	--ArkInventory.Output( "LISTEN_BAG_UPDATE( ", blizzard_id, " )" )
	
	ArkInventory:SendMessage( "LISTEN_BAG_UPDATE_BUCKET", blizzard_id )
	
end

function ArkInventory:LISTEN_BAG_LOCK( event, arg1, arg2 )

	--ArkInventory.Output( "LISTEN_BAG_LOCK( ", arg1, ",", arg2, " )" )

	if not arg2 then
	
		-- inventory lock
		
		for blizzard_id = 1, NUM_BAG_SLOTS do
			local slotName = string.format( "Bag%sSlot", blizzard_id - 1 )
			if arg1 == GetInventorySlotInfo( slotName ) then
				local loc_id, bag_id = ArkInventory.BagID_Internal( blizzard_id )
				ArkInventory.ObjectLockChanged( loc_id, bag_id, nil )
			end
		end
	
	else
	
		if arg1 == BANK_CONTAINER then
		
			local count = GetContainerNumSlots( BANK_CONTAINER )
	
			if arg2 <= count then
				-- item lock
				local loc_id, bag_id = ArkInventory.BagID_Internal( arg1 )
				ArkInventory.ObjectLockChanged( loc_id, bag_id, arg2 )
				--ArkInventory.RestackResume( loc_id )
			else
				-- bag lock
				local loc_id, bag_id = ArkInventory.BagID_Internal( arg2 - count + NUM_BAG_SLOTS )
				ArkInventory.ObjectLockChanged( loc_id, bag_id, nil )
			end

		else
	
			-- item lock
			local loc_id, bag_id = ArkInventory.BagID_Internal( arg1 )
			ArkInventory.ObjectLockChanged( loc_id, bag_id, arg2 )
			--ArkInventory.RestackResume( loc_id )
			
		end
	
	end

end

function ArkInventory:LISTEN_CHANGER_UPDATE_BUCKET( arg1 )

	--ArkInventory.Output( "LISTEN_CHANGER_UPDATE_BUCKET( ", arg1, " )" )
	
	-- arg1 = table in the format loc_id_id=true so we need to loop through them

	for k in pairs( arg1 ) do
		ArkInventory.Frame_Changer_Update( k )
	end
	
end


function ArkInventory:LISTEN_BANK_ENTER( )
	
	--ArkInventory.Output( "LISTEN_BANK_ENTER" )
	
	local loc_id = ArkInventory.Const.Location.Bank
	
	ArkInventory.Global.Mode.Bank = true
	ArkInventory.Global.Location[loc_id].isOffline = false
	
	ArkInventory.ScanLocation( loc_id )
	
	ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
	
	if ArkInventory.LocationIsControlled( loc_id ) then
		ArkInventory.Frame_Main_Show( loc_id )
	end
	
	if ArkInventory.db.global.option.auto.open.bank and ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
		ArkInventory.Frame_Main_Show( ArkInventory.Const.Location.Bag )
	end
	
	ArkInventory.Frame_Main_Generate( loc_id )
	
end

function ArkInventory:LISTEN_BANK_LEAVE( )
	
	--ArkInventory.Output( "LISTEN_BANK_LEAVE" )
	
	ArkInventory:SendMessage( "LISTEN_BANK_LEAVE_BUCKET" )
	
end

function ArkInventory:LISTEN_BANK_LEAVE_BUCKET( )
	
	--ArkInventory.Output( "LISTEN_BANK_LEAVE_BUCKET" )
	
	local loc_id = ArkInventory.Const.Location.Bank
	
	ArkInventory.Global.Mode.Bank = false
	ArkInventory.Global.Location[loc_id].isOffline = true
	
	ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
	
	if ArkInventory.LocationIsControlled( loc_id ) then
		ArkInventory.Frame_Main_Hide( loc_id )
	end
	
	if ArkInventory.db.global.option.auto.close.bank and ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
		ArkInventory.Frame_Main_Hide( ArkInventory.Const.Location.Bag )
	end
	
	if not ArkInventory.LocationIsSaved( loc_id ) then
		ArkInventory.EraseSavedData( ArkInventory.Global.Me.info.player_id, loc_id, not ArkInventory.db.profile.option.location[loc_id].notifyerase )
	end
	
end

function ArkInventory:LISTEN_BANK_UPDATE( event, arg1 )

	-- player changed a bank bag or item

	--ArkInventory.Output( "LISTEN_BANK_UPDATE( ", arg1, " ) " )

	local count = GetContainerNumSlots( BANK_CONTAINER )
	
	if arg1 <= count then
		-- item was changed
		ArkInventory:SendMessage( "LISTEN_BAG_UPDATE_BUCKET", BANK_CONTAINER )
	else
		-- bag was changed
		ArkInventory:SendMessage( "LISTEN_BAG_UPDATE_BUCKET", arg1 - count + NUM_BAG_SLOTS )
	end
	
end

function ArkInventory:LISTEN_BANK_SLOT( )

	-- player just purchased a bank bag slot
	
	--ArkInventory.Output( "LISTEN_BANK_SLOT" )
	
	for x = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
		ArkInventory:SendMessage( "LISTEN_BAG_UPDATE_BUCKET", x )
	end

end


function ArkInventory:LISTEN_VAULT_ENTER( )

	--ArkInventory.Output( "LISTEN_VAULT_ENTER" )

	local loc_id = ArkInventory.Const.Location.Vault

	ArkInventory.Global.Mode.Vault = true
	ArkInventory.Global.Location[loc_id].isOffline = false
	
	ArkInventory.PlayerInfoSet( )

	ArkInventory.ScanVaultHeader( )
	
	QueryGuildBankTab( GetCurrentGuildBankTab( ) or 1 )
	
	local cp = ArkInventory.Global.Me

	ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
	
	if ArkInventory.LocationIsControlled( loc_id ) then
		ArkInventory.Frame_Main_Show( loc_id )
		ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
	end
	
	if ArkInventory.db.global.option.auto.open.vault and ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
		ArkInventory.Frame_Main_Show( ArkInventory.Const.Location.Bag )
	end
	
end

function ArkInventory:LISTEN_VAULT_LEAVE( )

	--ArkInventory.Output( "LISTEN_VAULT_LEAVE" )
	
	ArkInventory:SendMessage( "LISTEN_VAULT_LEAVE_BUCKET" )
	
end

function ArkInventory:LISTEN_VAULT_LEAVE_BUCKET( )

	--ArkInventory.Output( "LISTEN_VAULT_LEAVE_BUCKET" )
	
	local loc_id = ArkInventory.Const.Location.Vault

	ArkInventory.Global.Mode.Vault = false
	ArkInventory.Global.Location[loc_id].isOffline = true

	ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Refresh )
	
	if ArkInventory.LocationIsControlled( loc_id ) then
		ArkInventory.Frame_Main_Hide( loc_id )
	end
	
	if ArkInventory.db.global.option.auto.close.vault and ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
		ArkInventory.Frame_Main_Hide( ArkInventory.Const.Location.Bag )
	end

	if not ArkInventory.LocationIsSaved( loc_id ) then
		ArkInventory.EraseSavedData( ArkInventory.Global.Me.info.player_id, loc_id, not ArkInventory.db.profile.option.location[loc_id].notifyerase )
	end
	
end

function ArkInventory:LISTEN_VAULT_UPDATE_BUCKET( )
	
	--ArkInventory.Output( "LISTEN_VAULT_UPDATE_BUCKET" )
	
	local loc_id = ArkInventory.Const.Location.Vault

	ArkInventory.ScanVault( )
	ArkInventory.ScanVaultHeader( )

	ArkInventory.RestackResume( ArkInventory.Const.Location.Vault )
	
 	-- instant sorting enabled
	if ArkInventory.LocationOptionGet( loc_id, "sort", "instant" ) then
		ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
	end
	
end

function ArkInventory:LISTEN_VAULT_UPDATE( event, ... )
	
	--local tab = ...
	--ArkInventory.Output( "LISTEN_VAULT_UPDATE: ", tab )
	
	ArkInventory:SendMessage( "LISTEN_VAULT_UPDATE_BUCKET" )
	
end

function ArkInventory:LISTEN_VAULT_LOCK( event, ... )

	--local tab = ...
	--ArkInventory.Output( "LISTEN_VAULT_LOCK: ", tab )
	
	local loc_id = ArkInventory.Const.Location.Vault
	local bag_id = GetCurrentGuildBankTab( )
	
	for slot_id = 1, ArkInventory.Global.Location[loc_id].maxSlot[bag_id] or 0 do
		ArkInventory.ObjectLockChanged( loc_id, bag_id, slot_id )
	end

	--ArkInventory.RestackResume( ArkInventory.Const.Location.Vault )
	
end

function ArkInventory:LISTEN_VAULT_MONEY( )

	--ArkInventory.Output( "LISTEN_VAULT_MONEY" )

	local loc_id = ArkInventory.Const.Location.Vault
	
	ArkInventory.PlayerInfoSet( )
	
end

function ArkInventory:LISTEN_VAULT_TABS( )
	
	--ArkInventory.Output( "LISTEN_VAULT_TABS" )
	
	local loc_id = ArkInventory.Const.Location.Vault
	if not ArkInventory.Global.Location[loc_id].isOffline then
		-- ignore pre vault entrance events
		ArkInventory.ScanVaultHeader( )
	end
	
end

function ArkInventory:LISTEN_VAULT_LOG( event, ... )

	--local tab = ...
	--ArkInventory.Output( "LISTEN_VAULT_LOG: ", tab )
	
	ArkInventory.Frame_Vault_Log_Update( )
	
end

function ArkInventory:LISTEN_VAULT_INFO( event, ... )

	--local tab = ...
	--ArkInventory.Output( "LISTEN_VAULT_INFO: ", tab )
	
	ArkInventory.Frame_Vault_Info_Update( )
	
end


function ArkInventory:LISTEN_VOID_UPDATE_BUCKET( )
	
	--ArkInventory.Output( "LISTEN_VOID_UPDATE_BUCKET" )
	
	local loc_id = ArkInventory.Const.Location.Void

	ArkInventory.ScanVoidStorage( )
	
 	-- instant sorting enabled
	if ArkInventory.LocationOptionGet( loc_id, "sort", "instant" ) then
		ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
	end
	
end

function ArkInventory:LISTEN_VOID_UPDATE( event, ... )
	
	--ArkInventory.Output( "LISTEN_VOID_UPDATE: ", arg1, ", ", arg2, ", ", arg3 )
	
	ArkInventory:SendMessage( "LISTEN_VOID_UPDATE_BUCKET" )
	
end


function ArkInventory:LISTEN_INVENTORY_CHANGE_BUCKET( )
	
	--ArkInventory.Output( "LISTEN_INVENTORY_CHANGE_BUCKET" )
	
	local loc_id = ArkInventory.Const.Location.Wearing
	
	ArkInventory.ScanLocation( loc_id )
	
end

function ArkInventory:LISTEN_INVENTORY_CHANGE( event, arg1, arg2 )
	
	--ArkInventory.Output( "LISTEN_INVENTORY_CHANGE( ", arg1, ", ", arg2, " ) " )

	if arg1 == "player" then
		ArkInventory:SendMessage( "LISTEN_INVENTORY_CHANGE_BUCKET" )
	end
	
end


function ArkInventory:LISTEN_MAIL_ENTER( event, ... )
	
	--ArkInventory.Output( "MAIL_SHOW" )
	
	ArkInventory.Global.Mode.Mail = true
	
	local BACKPACK_WAS_OPEN = ArkInventory.Frame_Main_Get( ArkInventory.Const.Location.Bag ):IsVisible( )
	
	MailFrame_OnEvent( MailFrame, event, ... )
	
	local loc_id = ArkInventory.Const.Location.Mail
	ArkInventory.ScanLocation( loc_id )
	ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
	
	if ArkInventory.LocationIsControlled( loc_id ) then
		ArkInventory.Frame_Main_Show( loc_id )
	end
	
	if ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
		-- blizzard auto-opens the backpack when you open the mailbox
		if not ArkInventory.db.global.option.auto.open.mail and not BACKPACK_WAS_OPEN then
			-- so we need to close it if we didnt already have it open
			ArkInventory.Frame_Main_Hide( ArkInventory.Const.Location.Bag )
		end
	end
	
	ArkInventory.Frame_Main_Generate( loc_id )
	
end

function ArkInventory:LISTEN_MAIL_LEAVE( )
	
	--ArkInventory.Output( "MAIL_CLOSED" )
	
	ArkInventory:SendMessage( "LISTEN_MAIL_LEAVE_BUCKET" )
	
end

function ArkInventory:LISTEN_MAIL_LEAVE_BUCKET( )
	
	--ArkInventory.Output( "MAIL_CLOSED_BUCKET" )
	
	ArkInventory.Global.Mode.Mail = false
	
	local loc_id = ArkInventory.Const.Location.Mail
	
	ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Refresh )
	
	if ArkInventory.LocationIsControlled( loc_id ) then
		ArkInventory.Frame_Main_Hide( loc_id )
	end
	
	if ArkInventory.db.global.option.auto.close.mail and ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
		ArkInventory.Frame_Main_Hide( ArkInventory.Const.Location.Bag )
	end
	
	if not ArkInventory.LocationIsSaved( loc_id ) then
		ArkInventory.EraseSavedData( ArkInventory.Global.Me.info.player_id, loc_id, not ArkInventory.db.profile.option.location[loc_id].notifyerase )
	end
	
end

function ArkInventory:LISTEN_MAIL_UPDATE_BUCKET( )
	
	--ArkInventory.Output( "LISTEN_MAIL_UPDATE_BUCKET" )
	
	ArkInventory.ScanMail( )
	
end

function ArkInventory:LISTEN_MAIL_UPDATE_MASSIVE_BUCKET( )
	
	--ArkInventory.Output( "LISTEN_MAIL_UPDATE_BUCKET" )
	
	ArkInventory.ScanMail( true )
	
end

function ArkInventory:LISTEN_MAIL_UPDATE( )

	--ArkInventory.Output( "MAIL_UPDATE" )
	
	ArkInventory:SendMessage( "LISTEN_MAIL_UPDATE_BUCKET" )
	
end


function ArkInventory:LISTEN_TRADE_ENTER( )

	--ArkInventory.Output( "LISTEN_TRADE_ENTER" )
	
	if ArkInventory.db.global.option.auto.open.trade and ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
		ArkInventory.Frame_Main_Show( ArkInventory.Const.Location.Bag )
	end
	
end

function ArkInventory:LISTEN_TRADE_LEAVE( )

	--ArkInventory.Output( "LISTEN_TRADE_LEAVE" )
	
	if ArkInventory.db.global.option.auto.close.trade and ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
		ArkInventory.Frame_Main_Hide( ArkInventory.Const.Location.Bag )
	end
	
end


function ArkInventory:LISTEN_AUCTION_ENTER( )
	
	--ArkInventory.Output( "LISTEN_AUCTION_ENTER" )
	
	ArkInventory.Global.Mode.Auction = true
	
	if ArkInventory.db.global.option.auto.open.auction and ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
		ArkInventory.Frame_Main_Show( ArkInventory.Const.Location.Bag )
	end
	
end

function ArkInventory:LISTEN_AUCTION_LEAVE( )
	
	--ArkInventory.Output( "LISTEN_AUCTION_LEAVE" )
	
	ArkInventory:SendMessage( "LISTEN_AUCTION_LEAVE_BUCKET" )
	
end

function ArkInventory:LISTEN_AUCTION_LEAVE_BUCKET( )
	
	--ArkInventory.Output( "LISTEN_AUCTION_LEAVE_BUCKET" )
	
	if ArkInventory.db.global.option.auto.close.auction and ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
		ArkInventory.Frame_Main_Hide( ArkInventory.Const.Location.Bag )
	end
	
	ArkInventory.Global.Mode.Auction = false
	
end

function ArkInventory:LISTEN_AUCTION_UPDATE( )
	
	--ArkInventory.Output( "LISTEN_AUCTION_UPDATE" )
	
	ArkInventory:SendMessage( "LISTEN_AUCTION_UPDATE_BUCKET" )
	
end

function ArkInventory:LISTEN_AUCTION_UPDATE_BUCKET( )
	
	--ArkInventory.Output( "LISTEN_AUCTION_UPDATE_BUCKET" )
	
	ArkInventory.ScanAuction( )
	
end

function ArkInventory:LISTEN_AUCTION_UPDATE_MASSIVE_BUCKET( )
	
	--ArkInventory.Output( "LISTEN_AUCTION_UPDATE_MASSIVE_BUCKET" )
	
	ArkInventory.ScanAuction( true )
	
end

function ArkInventory:LISTEN_MERCHANT_ENTER( event, ... )
	
	--ArkInventory.Output( "LISTEN_MERCHANT_ENTER( ", event, " )" )
	
	ArkInventory.Global.Mode.Merchant = true
	
	local BACKPACK_WAS_OPEN = ArkInventory.Frame_Main_Get( ArkInventory.Const.Location.Bag ):IsVisible( )
	
	if event == "MERCHANT_SHOW" then
		
		-- merchant / vendor
		
		MerchantFrame_OnEvent( MerchantFrame, event, ... )
		
		if ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
			
			-- blizzard auto-opens the backpack when you talk to a merchant
			if not ArkInventory.db.global.option.auto.open.merchant and not BACKPACK_WAS_OPEN then
				-- so we need to close it if we didnt already have it open
				ArkInventory.Frame_Main_Hide( ArkInventory.Const.Location.Bag )
			end
		end
	
	else
		
		-- reforger / transmogrify
		
		if ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
			if ArkInventory.db.global.option.auto.open.merchant and not BACKPACK_WAS_OPEN then
				ArkInventory.Frame_Main_Show( ArkInventory.Const.Location.Bag )
			end
		end
		
	end
	
	
end

function ArkInventory:LISTEN_MERCHANT_LEAVE( event )
	
	ArkInventory:SendMessage( "LISTEN_MERCHANT_LEAVE_BUCKET" )
	
end

function ArkInventory:LISTEN_MERCHANT_LEAVE_BUCKET( )
	
	--ArkInventory.Output( "LISTEN_MERCHANT_LEAVE_BUCKET" )
	
	ArkInventory.Global.Mode.Merchant = false
	
	if ArkInventory.db.global.option.auto.close.merchant and ArkInventory.LocationIsControlled( ArkInventory.Const.Location.Bag ) then
		ArkInventory.Frame_Main_Hide( ArkInventory.Const.Location.Bag )
	end
	
end

function ArkInventory:LISTEN_COMPANION_UPDATE( event )
	
	--ArkInventory.Output( "LISTEN_COMPANION_UPDATE( ", event, " )" )
	
	local loc_id
	
	loc_id = ArkInventory.Const.Location.Pet
	ArkInventory.CompanionDataCorrect( )
	ArkInventory.ScanLocation( loc_id )
	ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
	
	loc_id = ArkInventory.Const.Location.Mount
	ArkInventory.CompanionDataCorrect( )
	ArkInventory.ScanLocation( loc_id )
	ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
	
end



function ArkInventory:LISTEN_BATTLEPET_UPDATE( )
	
	--ArkInventory.Output( "LISTEN_BATTLEPET_UPDATE" )
	
	local loc_id = ArkInventory.Const.Location.Pet
	ArkInventory.ScanLocation( loc_id )
	--ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
	
	ArkInventory.LDB.Pets:Update( )
	
end




function ArkInventory:LISTEN_CURRENCY_UPDATE( )

	--ArkInventory.Output( "LISTEN_CURRENCY_UPDATE" )
	
	local loc_id = ArkInventory.Const.Location.Token
	
	ArkInventory.ScanLocation( loc_id )
	
	ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
	
	ArkInventory.Frame_Status_Update_Tracking( )
	
	ArkInventory.LDB.Tracking_Currency:Update( )
	
end

function ArkInventory:LISTEN_EQUIPMENT_SETS_CHANGED( )
	
	--ArkInventory.Output( "LISTEN_EQUIPMENT_SETS_CHANGED( )" )
	
	ArkInventory.ItemCacheClear( )
	ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
	
end

function ArkInventory:LISTEN_BAG_UPDATE_COOLDOWN_BUCKET( arg )
	
	for loc_id in pairs( arg ) do
		if ArkInventory.LocationOptionGet( loc_id, "slot", "cooldown", "show" ) then
			if not ArkInventory.Global.Mode.Combat or ArkInventory.LocationOptionGet( loc_id, "slot", "cooldown", "combat" ) then
				if not ArkInventory.LocationOptionGet( loc_id, "sort", "instant" ) then
					ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Refresh )
				end
			end
		end
	end
	
end

function ArkInventory:LISTEN_BAG_UPDATE_COOLDOWN( event, arg1 )
	
	--ArkInventory.Output( "LISTEN_BAG_UPDATE_COOLDOWN( ", arg1, " )" )
	
	if arg1 then
		local loc_id = ArkInventory.BagID_Internal( arg1 )
		ArkInventory:SendMessage( "LISTEN_BAG_UPDATE_COOLDOWN_BUCKET", loc_id )
	else
		for loc_id in pairs( ArkInventory.Global.Location ) do
			if ArkInventory.LocationOptionGet( loc_id, "slot", "cooldown", "global" ) then
				ArkInventory:SendMessage( "LISTEN_BAG_UPDATE_COOLDOWN_BUCKET", loc_id )
			end
		end
	end
end

function ArkInventory:LISTEN_QUEST_UPDATE_BUCKET( )
	ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
end

function ArkInventory:LISTEN_QUEST_UPDATE( )
	ArkInventory:SendMessage( "LISTEN_QUEST_UPDATE_BUCKET" )
end

function ArkInventory:LISTEN_CVAR_UPDATE( event, cvar, value )
	
	--ArkInventory.Output( event, ": ", cvar, " = ", value )
	
	if cvar == "USE_COLORBLIND_MODE" then
		ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Refresh )
		ArkInventory.LDB.Money:Update( )
	end
	
end

function ArkInventory:LISTEN_ZONE_CHANGED_BUCKET( )
	--ArkInventory.LDB.Mounts:Update( )
end

function ArkInventory:LISTEN_ZONE_CHANGED( )
	ArkInventory:SendMessage( "LISTEN_ZONE_CHANGED_BUCKET", 1 )
end

function ArkInventory:LISTEN_ACTIONBAR_UPDATE_USABLE_BUCKET( )
	if not ArkInventory.Global.Mode.Combat then
		ArkInventory.LDB.Mounts:Update( )
	end
end

function ArkInventory:LISTEN_ACTIONBAR_UPDATE_USABLE( event )
	ArkInventory:SendMessage( "LISTEN_ACTIONBAR_UPDATE_USABLE_BUCKET", 1 )
end

function ArkInventory:LISTEN_UNIT_POWER_BUCKET( )
	
	--ArkInventory.Output( "LISTEN_UNIT_POWER_BUCKET" )
	
	if ArkInventory.Global.Me.info.class == "WARLOCK" and ArkInventory.db.char.option.ldb.tracking.item.tracked[6265] then
		-- update count for lock shards
		ArkInventory.LDB.Tracking_Item:Update( )
	end
	
end

function ArkInventory:LISTEN_UNIT_POWER( )
	ArkInventory:SendMessage( "LISTEN_UNIT_POWER_BUCKET", 1 )
end

function ArkInventory:LISTEN_SPELLS_CHANGED_BUCKET( )
	
	--ArkInventory.Output( "LISTEN_SPELLS_CHANGED_BUCKET( )" )
	
	ArkInventory.ScanSpellbook( )
	
end

function ArkInventory:LISTEN_SPELLS_CHANGED( event )
	
	--ArkInventory.Output( "LISTEN_SPELLS_CHANGED( )" )
	
	ArkInventory:SendMessage( "LISTEN_SPELLS_CHANGED_BUCKET" )
	
end




function ArkInventory:LISTEN_RESCAN_LOCATION_BUCKET( arg1 )
	
	--ArkInventory.Output( "LISTEN_RESCAN_LOCATION_BUCKET( ", arg1, " )" )
	
	-- arg1 = table in the format loc_id=true so we need to loop through them
	
	for k in pairs( arg1 ) do
		ArkInventory.ScanLocation( k )
	end
	
end



function ArkInventory.BagID_Blizzard( loc_id, bag_id )
	
	-- converts internal location+bag codes into blizzzard bag ids
	
	assert( loc_id ~= nil, "code failure: loc_id is nil" )
	assert( bag_id ~= nil, "code failure: bag_id is nil" )
	
	local blizzard_id = ArkInventory.Global.Location[loc_id].Bags[bag_id]
	
	assert( blizzard_id ~= nil, string.format( "code failure: ArkInventory.Global.Location[%s].Bags[%s] is nil", loc_id, bag_id ) )
	
	return blizzard_id
	
end

function ArkInventory.BagID_Internal( blizzard_id )
	
	-- converts blizzard bag codes into storage location+bag ids
	
	assert( blizzard_id ~= nil, "code failure: blizard_id is nil" )
	
	for loc_id, loc in pairs( ArkInventory.Global.Location ) do
		for bag_id, v in pairs( loc.Bags ) do
			if blizzard_id == v then
				return loc_id, bag_id
			end
		end
	end
	
	error( string.format( "code failure: unknown blizzard id [%s]", blizzard_id ) )
	
	return
	
end

function ArkInventory.BagType( blizzard_id )
	
	assert( blizzard_id ~= nil, "code failure: blizard_id is nil" )
	
	if blizzard_id == BACKPACK_CONTAINER then
		return ArkInventory.Const.Slot.Type.Bag
	elseif blizzard_id == BANK_CONTAINER then
		return ArkInventory.Const.Slot.Type.Bag
	end
	
	local loc_id, bag_id = ArkInventory.BagID_Internal( blizzard_id )
	
	if loc_id == nil then
		return ArkInventory.Const.Slot.Type.Unknown
	elseif loc_id == ArkInventory.Const.Location.Vault then
		return ArkInventory.Const.Slot.Type.Bag
	elseif loc_id == ArkInventory.Const.Location.Mail then
		return ArkInventory.Const.Slot.Type.Mail
	elseif loc_id == ArkInventory.Const.Location.Wearing then
		return ArkInventory.Const.Slot.Type.Wearing
	elseif loc_id == ArkInventory.Const.Location.Pet then
		return ArkInventory.Const.Slot.Type.Critter
	elseif loc_id == ArkInventory.Const.Location.Mount then
		return ArkInventory.Const.Slot.Type.Mount
	elseif loc_id == ArkInventory.Const.Location.Token then
		return ArkInventory.Const.Slot.Type.Currency
	elseif loc_id == ArkInventory.Const.Location.Auction then
		return ArkInventory.Const.Slot.Type.Auction
	elseif loc_id == ArkInventory.Const.Location.Spellbook then
		return ArkInventory.Const.Slot.Type.Spellbook
	elseif loc_id == ArkInventory.Const.Location.Tradeskill then
		return ArkInventory.Const.Slot.Type.Tradeskill
	elseif loc_id == ArkInventory.Const.Location.Void then
		return ArkInventory.Const.Slot.Type.Void
	end
	
	
	if ArkInventory.Global.Location[loc_id].isOffline then
		
		local cp = ArkInventory.LocationPlayerInfoGet( loc_id )
		return cp.location[loc_id].bag[bag_id].type
		
	else
		
		local h = GetInventoryItemLink( "player", ContainerIDToInventoryID( blizzard_id ) )
		
		if h and h ~= "" then
			
			local t, s = select( 8, ArkInventory.ObjectInfo( h ) )
			
			--ArkInventory.Output( "bag[", blizzard_id, "], type[", t, "], sub[", s, "], h=", h )
			
			if t == ArkInventory.Localise["WOW_AH_CONTAINER"] then
				
				if s == ArkInventory.Localise["WOW_AH_CONTAINER_BAG"] then
					return ArkInventory.Const.Slot.Type.Bag
				elseif s == ArkInventory.Localise["WOW_AH_CONTAINER_ENCHANTING"] then
					return ArkInventory.Const.Slot.Type.Enchanting
				elseif s == ArkInventory.Localise["WOW_AH_CONTAINER_ENGINEERING"] then
					return ArkInventory.Const.Slot.Type.Engineering
				elseif s == ArkInventory.Localise["WOW_AH_CONTAINER_GEM"] then
					return ArkInventory.Const.Slot.Type.Gem
				elseif s == ArkInventory.Localise["WOW_AH_CONTAINER_HERB"] then
					return ArkInventory.Const.Slot.Type.Herb
				elseif s == ArkInventory.Localise["WOW_AH_CONTAINER_INSCRIPTION"] then
					return ArkInventory.Const.Slot.Type.Inscription
				elseif s == ArkInventory.Localise["WOW_AH_CONTAINER_LEATHERWORKING"] then
					return ArkInventory.Const.Slot.Type.Leatherworking
				elseif s == ArkInventory.Localise["WOW_AH_CONTAINER_MINING"] then
					return ArkInventory.Const.Slot.Type.Mining
				elseif s == ArkInventory.Localise["WOW_AH_CONTAINER_TACKLE"] then
					return ArkInventory.Const.Slot.Type.Tackle
				end
				
			end
			
			return ArkInventory.Const.Slot.Type.Unknown
			
		else
			
			-- empty bag slots
			return ArkInventory.Const.Slot.Type.Bag
			
		end
	
	end
	
	ArkInventory.OutputWarning( "Unknown Type: [", ArkInventory.Global.Location[loc_id].Name, "] id[", blizzard_id, "]=[empty]" )
	return ArkInventory.Const.Slot.Type.Unknown
	
end

function ArkInventory.ScanLocation( arg1 )
	
	--ArkInventory.Output( "ScanLocation( ", arg1, " )" )
	
	if not ArkInventory.Global.Enabled then
		--ArkInventory.Output( "ScanLocation( ", arg1, " ) - aborted, not ready" )
		return
	end
	
	for loc_id, loc in pairs( ArkInventory.Global.Location ) do
		if arg1 == nil or arg1 == loc_id then
			ArkInventory.Scan( loc.Bags )
		end
	end
	
end

function ArkInventory.Scan( bagTable )
	
	local bagTable = bagTable
	if type( bagTable ) ~= "table" then
		bagTable = { bagTable }
	end
	
	local processed = { }
	
	for _, blizzard_id in pairs( bagTable ) do
		
		--local t1 = GetTime( )
		--ArkInventory.Output( "scan location[", loc_id, "] inititated" )
		
		local loc_id = ArkInventory.BagID_Internal( blizzard_id )
		
		if loc_id == nil then
			--ArkInventory.OutputWarning( "aborted scan of bag ", blizzard_id, ", not an ", ArkInventory.Const.Program.Name, " controlled bag" )
			return
		elseif loc_id == ArkInventory.Const.Location.Bag or loc_id == ArkInventory.Const.Location.Bank then
			ArkInventory.ScanBag( blizzard_id )
		elseif loc_id == ArkInventory.Const.Location.Vault then
			if not processed[loc_id] then
				ArkInventory.ScanVault( )
			end
		elseif loc_id == ArkInventory.Const.Location.Wearing then
			if not processed[loc_id] then
				ArkInventory.ScanWearing( )
			end
		elseif loc_id == ArkInventory.Const.Location.Mail then
			if not processed[loc_id] then
				ArkInventory.ScanMail( )
			end
		elseif loc_id == ArkInventory.Const.Location.Pet then
			if not processed[loc_id] then
				ArkInventory.ScanBattlePet( )
			end
		elseif loc_id == ArkInventory.Const.Location.Mount then
			if not processed[loc_id] then
				ArkInventory.ScanCompanion( "MOUNT" )
			end
		elseif loc_id == ArkInventory.Const.Location.Token then
			if not processed[loc_id] then
				ArkInventory.ScanCurrency( )
			end
		elseif loc_id == ArkInventory.Const.Location.Auction then
			if not processed[loc_id] then
				ArkInventory.ScanAuction( )
			end
		elseif loc_id == ArkInventory.Const.Location.Spellbook then
			if not processed[loc_id] then
				ArkInventory.ScanSpellbook( )
			end
		elseif loc_id == ArkInventory.Const.Location.Tradeskill then
			if not processed[loc_id] then
				ArkInventory.ScanTradeskill( )
			end
		elseif loc_id == ArkInventory.Const.Location.Void then
			if not processed[loc_id] then
				ArkInventory.ScanVoidStorage( )
			end
		else
			error( string.format( "code failure: uncoded location [%s] for bag [%s]", loc_id, blizzard_id ) )
		end
		
		--t1 = GetTime( ) - t1
		--ArkInventory.Output( "scan location[" , loc_id, ".", blizzard_id, "] in ", string.format( "%0.3f", t1 ) )
		
		processed[loc_id] = true
		
	end

end

function ArkInventory.ScanBag( blizzard_id )
	
	--ArkInventory.Output( "ScanBag( ", blizzard_id, " )" )
	
	local loc_id, bag_id = ArkInventory.BagID_Internal( blizzard_id )
	
	if not loc_id then
		ArkInventory.OutputWaring( "aborted scan of bag [", blizzard_id, "], unknown bag id" )
		return
	else
		--ArkInventory.OutputWaring( "found bag id [", blizzard_id, "] in location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "]" )
	end
	
	if loc_id == ArkInventory.Const.Location.Bank and ArkInventory.Global.Mode.Bank == false then
		--ArkInventory.OutputWaring( "aborted scan of bag id [", blizzard_id, "], not at bank" )
		return
	end
	
	local cp = ArkInventory.Global.Me
	
	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.OutputWaring( "aborted scan of bag id [", blizzard_id, "], location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] is not being monitored" )
		return
	end
	
	--ArkInventory.Output( "scaning: ", ArkInventory.Global.Location[loc_id].Name, " [", loc_id, ".", bag_id, "] - [", blizzard_id, "]" )

	
	local count = 0
	local empty = 0
	local bt = ArkInventory.BagType( blizzard_id )
	local texture = nil
	local status = ArkInventory.Const.Bag.Status.Unknown
	local h = nil
	local quality = 0
	
	if loc_id == ArkInventory.Const.Location.Bag then
		
		count = GetContainerNumSlots( blizzard_id )
		
		if blizzard_id == BACKPACK_CONTAINER then
			
			if not count or count == 0 then
				if ArkInventory.db.global.option.bugfix.zerosizebag.alert then
					ArkInventory.OutputWarning( "Aborted scan of bag ", blizzard_id, ", location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] size returned was ", count, ", rescan has been scheduled for 10 seconds.  This warning can be disabled in the config menu" )
				end
				ArkInventory:SendMessage( "LISTEN_RESCAN_LOCATION_BUCKET", loc_id )
				return
			end
			
			texture = ArkInventory.Global.Location[loc_id].Texture
			status = ArkInventory.Const.Bag.Status.Active
			
		else
			
			h = GetInventoryItemLink( "player", ContainerIDToInventoryID( blizzard_id ) )
			
			if not h then
				
				texture = ArkInventory.Const.Texture.Empty.Bag
				status = ArkInventory.Const.Bag.Status.Empty
				
			else
				
				if not count or count == 0 then
					if ArkInventory.db.global.option.bugfix.zerosizebag.alert then
						ArkInventory.OutputWarning( "Aborted scan of bag ", blizzard_id, ", location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] size returned was ", count, ", rescan has been scheduled for 10 seconds.  This warning can be disabled in the config menu" )
					end
					ArkInventory:SendMessage( "LISTEN_RESCAN_LOCATION_BUCKET", loc_id )
					return
				end
				
				texture = ArkInventory.ObjectInfoTexture( h )
				status = ArkInventory.Const.Bag.Status.Active
				quality = ArkInventory.ObjectInfoQuality( h )
				
			end
			
		end
		
	end

	
	if loc_id == ArkInventory.Const.Location.Bank then
	
		count = GetContainerNumSlots( blizzard_id )
		
		if blizzard_id == BANK_CONTAINER then
			
			if not count or count == 0 then
				if ArkInventory.db.global.option.bugfix.zerosizebag.alert then
					ArkInventory.OutputWarning( "Aborted scan of bag ", blizzard_id, ", location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] size returned was ", count, ", rescan has been scheduled for 10 seconds.  This warning can be disabled in the config menu" )
				end
				ArkInventory:SendMessage( "LISTEN_RESCAN_LOCATION_BUCKET", loc_id )
				return
			end
			
			texture = ArkInventory.Global.Location[loc_id].Texture
			status = ArkInventory.Const.Bag.Status.Active
			
		else
			
			if blizzard_id - NUM_BAG_SLOTS > GetNumBankSlots( ) then
			
				texture = ArkInventory.Const.Texture.Empty.Bag
				status = ArkInventory.Const.Bag.Status.Purchase
				
			else
				
				h = GetInventoryItemLink( "player", ContainerIDToInventoryID( blizzard_id ) )
				
				if not h then
					
					texture = ArkInventory.Const.Texture.Empty.Bag
					status = ArkInventory.Const.Bag.Status.Empty
					
				else
					
					if not count or count == 0 then
						if ArkInventory.db.global.option.bugfix.zerosizebag.alert then
							ArkInventory.OutputWarning( "Aborted scan of bag ", blizzard_id, ", location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] size returned was ", count, ", rescan has been scheduled for 10 seconds.  This warning can be disabled in the config menu" )
						end
						ArkInventory:SendMessage( "LISTEN_RESCAN_LOCATION_BUCKET", loc_id )
						return
					end
					
					texture = ArkInventory.ObjectInfoTexture( h )
					status = ArkInventory.Const.Bag.Status.Active
					quality = ArkInventory.ObjectInfoQuality( h )
					
				end
				
			end

		end

	end
	
	
	local bag = cp.location[loc_id].bag[bag_id]
	
	local old_bag_count = bag.count
	local old_bag_link = bag.h
	local old_bag_status = bag.status
	
	bag.count = count
	bag.empty = empty
	bag.type = bt
	bag.texture = texture
	bag.status = status
	bag.h = h
	bag.q = quality
	
	local changed_bag = false
	if old_bag_count ~= bag.count or old_bag_link ~= bag.h or old_bag_status ~= bag.status then
		changed_bag = true
	end
	
	for slot_id = 1, bag.count do
		
		if not bag.slot[slot_id] then
			bag.slot[slot_id] = {
				loc_id = loc_id,
				bag_id = bag_id,
				slot_id = slot_id,
			}
		end
		
		local i = bag.slot[slot_id]
		local item_to_reset = i.h
		
		local texture, count, readable, quality, _, _, h, _ = GetContainerItemInfo( blizzard_id, slot_id )
		local sb = false
		
		if h then
			
			ArkInventory.TooltipSetItem( ArkInventory.Global.Tooltip.Scan, blizzard_id, slot_id )
			
			for _, v in pairs( ArkInventory.Const.Soulbound ) do
				if ( v and ArkInventory.TooltipContains( ArkInventory.Global.Tooltip.Scan, string.format( "^%s$", v ) ) ) then
					--ArkInventory.Output( loc_id, ".", bag_id, ".", slot_id, " = ", h, " - ", v )
					sb = true
					break
				end
			end
			
			i.q = ArkInventory.ObjectInfoQuality( h )
			
		else
			
			sb = false
			
			i.q = 0
			
			count = 1
			bag.empty = bag.empty + 1
			
		end
		
		local changed_item, new, reset_count = ArkInventory.ScanChanged( i, h, sb, count )
		
		i.h = h
		i.sb = sb
		i.r = readable or nil
		i.count = count
		
		if changed_item then
			
			i.new = new
			
			i.age = ArkInventory.ItemAgeUpdate( )
			
			ArkInventory.ItemCategoryGet( i )
			
			if h then
				item_to_reset = h
			end
			
			if not changed_bag then
				ArkInventory.Frame_Item_Update( loc_id, bag_id, slot_id )
				ArkInventory:SendMessage( "LISTEN_CHANGER_UPDATE_BUCKET", loc_id )
			end
			
			ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
			
		end
		
		if item_to_reset and reset_count then
			--ArkInventory.Output( "clear item count for ", item_to_reset )
			ArkInventory.ObjectCountClear( item_to_reset )
			ArkInventory.LDB.Tracking_Item:Update( )
		end
		
	end

	ArkInventory.ScanCleanup( cp, loc_id, bag_id, bag, old_bag_count )
	
end

function ArkInventory.ScanVault( )

	--ArkInventory.Output( GREEN_FONT_COLOR_CODE, "ScanVault( )" )
	
	if ArkInventory.Global.Mode.Vault == false then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of vault, not at vault" )
		return
	end
	
	if not IsInGuild( ) or not ArkInventory.Global.Me.info.guild_id then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of vault, not in a guild" )
		return
	end
	
	if GetNumGuildBankTabs( ) == 0 then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of vault, no tabs purchased" )
		return
	end
	
	local loc_id = ArkInventory.Const.Location.Vault
	local bag_id = GetCurrentGuildBankTab( )

	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of bag id [", blizzard_id, "], location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] is not being monitored" )
		return
	end
	
	local cp = ArkInventory.PlayerInfoGet( ArkInventory.Global.Me.info.guild_id )
	
	--ArkInventory.Output( GREEN_FONT_COLOR_CODE, "scaning: ", ArkInventory.Global.Location[loc_id].Name, " [", loc_id, ".", bag_id, "] - [", blizzard_id, "]" )
	
	
	local bag = cp.location[loc_id].bag[bag_id]
	
	local old_bag_count = bag.count
	local old_bag_status = bag.status
	
	bag.count = 0
	bag.empty = 0
	bag.type = ArkInventory.Const.Slot.Type.Bag
	
	if bag_id <= GetNumGuildBankTabs( ) then
		
		local name, icon, isViewable, canDeposit, numWithdrawals, remainingWithdrawals = GetGuildBankTabInfo( bag_id )
		
		bag.name = name
		bag.texture = icon
		bag.count = MAX_GUILDBANK_SLOTS_PER_TAB
		bag.status = ArkInventory.Const.Bag.Status.Active
		
	end
	
	local isViewable, canDeposit = select( 3, GetGuildBankTabInfo( bag_id ) )

	local changed_bag = false
	if old_bag_count ~= bag.count or old_bag_status ~= bag.status then
		changed_bag = true
	end
	
	--local m1 = ArkInventory.MemoryUsed( true )
	
	for slot_id = 1, bag.count or 0 do
		
		--local m1 = ArkInventory.MemoryUsed( true )
		
		if not bag.slot[slot_id] then
			bag.slot[slot_id] = { }
		end
		
		local i = bag.slot[slot_id]
		i.display_id = 14 * ( ( slot_id - 1 ) % 7 ) + math.floor( ( slot_id - 1 ) / 7 ) + 1
		
		local item_to_reset = i.h
		
		local texture, count = GetGuildBankItemInfo( bag_id, slot_id )
		local h = nil
		local sb = false
		
		if texture then
		
			h = GetGuildBankItemLink( bag_id, slot_id )
			
			if h == nil then
				ArkInventory.TooltipSetGuildBankItem( ArkInventory.Global.Tooltip.Scan, bag_id, slot_id )
				h = select( 2, ArkInventory.TooltipGetItem( ArkInventory.Global.Tooltip.Scan ) )
			end
			
		else
			
			bag.empty = bag.empty + 1
			
		end
		
		
		local changed_item, new, reset_count = ArkInventory.ScanChanged( i, h, sb, count )
		
		if changed_item or i.loc_id == nil then
			
			i.age = ArkInventory.ItemAgeUpdate( )
			
			i.loc_id = loc_id
			i.bag_id = bag_id
			i.slot_id = slot_id
			
			i.h = h
			i.count = count
			i.sb = sb
			
			i.q = ArkInventory.ObjectInfoQuality( h )
			i.new = new
			
			if h then
				item_to_reset = h
			end
			
			if not changed_bag then
				ArkInventory.Frame_Item_Update( loc_id, bag_id, slot_id )
				ArkInventory:SendMessage( "LISTEN_CHANGER_UPDATE_BUCKET", loc_id )
			end
			
			ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
			
		end
		
		if item_to_reset and reset_count then
			--ArkInventory.Output( "reset item count in tab ", bag_id, " for ", item_to_reset )
			ArkInventory.ObjectCountClear( item_to_reset, true )
		end
		
	end
	
	cp.location[loc_id].slot_count = ArkInventory.Table.Sum( cp.location[loc_id].bag, function( a ) return a.count end )
	
	if changed_bag then
		ArkInventory:SendMessage( "LISTEN_STORAGE_EVENT", ArkInventory.Const.Event.BagUpdate, loc_id, bag_id, ArkInventory.Const.Window.Draw.Recalculate )
	else
		ArkInventory:SendMessage( "LISTEN_STORAGE_EVENT", ArkInventory.Const.Event.BagUpdate, loc_id, bag_id, ArkInventory.Const.Window.Draw.Refresh )
	end
	
end

function ArkInventory.ScanVaultHeader( )
	
	--ArkInventory.Output( "ScanVaultHeader( ) start" )
	
	if ArkInventory.Global.Mode.Vault == false then
		--ArkInventory.Output( "aborted scan of tab headers, not at vault" )
		return
	end
	
--	if bag_id < 1 or bag_id > MAX_GUILDBANK_TABS then
		--ArkInventory.Output( "aborted scan of tab ", bag_id, " header, invalid tab id" )
--		return
--	end

	if not IsInGuild( ) or not ArkInventory.Global.Me.info.guild_id then
		--ArkInventory.Output( "aborted scan of tab headers, not in a guild" )
		return
	end
	
	local cp = ArkInventory.PlayerInfoGet( ArkInventory.Global.Me.info.guild_id )
	
	--ArkInventory.Output( "scaning tab headers" )
	
	local loc_id = ArkInventory.Const.Location.Vault
	
	for bag_id = 1, MAX_GUILDBANK_TABS do
		
		local bag = cp.location[loc_id].bag[bag_id]
	
		bag.type = ArkInventory.Const.Slot.Type.Bag
	
		if bag_id <= GetNumGuildBankTabs( ) then
			
			local name, icon, isViewable, canDeposit, numWithdrawals, remainingWithdrawals = GetGuildBankTabInfo( bag_id )
			
			--ArkInventory.Output( "tab = ", bag_id, ", icon = ", icon )
			
			bag.name = name
			bag.texture = icon
			bag.status = ArkInventory.Const.Bag.Status.Active
			
			-- from Blizzard_GuildBankUI.lua - GuildBankFrame_UpdateTabs( )
			local access = GUILDBANK_TAB_FULL_ACCESS
			if not isViewable then
				access = ArkInventory.Localise["VAULT_TAB_ACCESS_NONE"]
			elseif ( not canDeposit and numWithdrawals == 0 ) then
				access = GUILDBANK_TAB_LOCKED
			elseif ( not canDeposit ) then
				access = GUILDBANK_TAB_WITHDRAW_ONLY
			elseif ( numWithdrawals == 0 ) then
				access = GUILDBANK_TAB_DEPOSIT_ONLY
			end
			bag.access = access
			
			local stackString = nil
			if bag_id == GetCurrentGuildBankTab( ) then
				if remainingWithdrawals > 0 then
					stackString = string.format( "%s/%s", remainingWithdrawals, string.format( GetText( "STACKS", nil, numWithdrawals ), numWithdrawals ) )
				elseif remainingWithdrawals == 0 then
					stackString = NONE
				else
					stackString = UNLIMITED
				end
			end
			bag.withdraw = stackString
			
			if bag.access == ArkInventory.Localise["VAULT_TAB_ACCESS_NONE"] then
				bag.status = ArkInventory.Const.Bag.Status.NoAccess
				bag.withdraw = nil
			end
			
		else
			
			bag.name = string.format( GUILDBANK_TAB_NUMBER, bag_id )
			bag.texture = ArkInventory.Const.Texture.Empty.Bag
			bag.count = 0
			bag.empty = 0
			bag.access = ArkInventory.Localise["STATUS_PURCHASE"]
			bag.withdraw = nil
			bag.status = ArkInventory.Const.Bag.Status.Purchase
			
		end
		
	end
	
	ArkInventory.Frame_Changer_Update( loc_id, bag_id )
	
	--ArkInventory.Output( "ScanVaultHeader( ", bag_id, " ) end" )
	
end

function ArkInventory.ScanWearing( )

	--ArkInventory.Output( GREEN_FONT_COLOR_CODE, "ScanWearing( ) start" )
	
	local blizzard_id = ArkInventory.Const.Offset.Wearing + 1
	
	local loc_id, bag_id = ArkInventory.BagID_Internal( blizzard_id )
	
	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of bag id [", blizzard_id, "], location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] is not being monitored" )
		return
	end

	--ArkInventory.Output( GREEN_FONT_COLOR_CODE, "scaning: ", ArkInventory.Global.Location[loc_id].Name, " [", loc_id, ".", bag_id, "] - [", blizzard_id, "]" )
	
	
	local cp = ArkInventory.Global.Me
	
	local bag = cp.location[loc_id].bag[bag_id]

	bag.count = 0
	bag.empty = 0
	bag.type = ArkInventory.Const.Slot.Type.Wearing
	bag.status = ArkInventory.Const.Bag.Status.Active

	
	for slot_id, v in ipairs( ArkInventory.Const.InventorySlotName ) do
	
		bag.count = bag.count + 1
		
		if not bag.slot[slot_id] then
			bag.slot[slot_id] = { }
		end
		
		local i = bag.slot[slot_id]
		local item_to_reset = i.h
		
		local inv_id = GetInventorySlotInfo( v )
		local h = GetInventoryItemLink( "player", inv_id )
		local sb = false
		local count = 1
		
		if h then
		
			-- check for soulbound
			ArkInventory.TooltipSetInventoryItem( ArkInventory.Global.Tooltip.Scan, inv_id )
			for _, v in pairs( ArkInventory.Const.Soulbound ) do
				if ( v and ArkInventory.TooltipContains( ArkInventory.Global.Tooltip.Scan, string.format( "^%s$", v ) ) ) then
					sb = true
					break
				end
			end
			
		else
		
			bag.empty = bag.empty + 1
			
		end

		
		local changed_item, new, reset_count = ArkInventory.ScanChanged( i, h, sb, count )

		if changed_item or i.loc_id == nil then
		
			i.age = ArkInventory.ItemAgeUpdate( )

			i.loc_id = loc_id
			i.bag_id = bag_id
			i.slot_id = slot_id
			
			i.h = h
			i.count = count
			i.sb = sb
			
			i.q = ArkInventory.ObjectInfoQuality( h )
			i.new = new
		
			if h then
				item_to_reset = h
			end
			
			ArkInventory.Frame_Item_Update( loc_id, bag_id, slot_id )
			ArkInventory:SendMessage( "LISTEN_CHANGER_UPDATE_BUCKET", loc_id )
			
			ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
			
		end
		
		if item_to_reset and reset_count then
			ArkInventory.ObjectCountClear( item_to_reset )
		end

		--ArkInventory.Output( "slot=[", slot_id, "], item=[", i.h, "]" )
	
	end
	
	cp.location[loc_id].slot_count = bag.count
	
end

function ArkInventory.ScanMail( )

	local blizzard_id = ArkInventory.Const.Offset.Mail + 1
	
	local loc_id, bag_id = ArkInventory.BagID_Internal( blizzard_id )

	-- mailbox can be scanned from anywhere, just uses data from when it was last opened
	if ArkInventory.Global.Mode.Mail == false then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of mailbox, not at mailbox" )
		return
	end
	
	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of bag id [", blizzard_id, "], location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] is not being monitored" )
		return
	end

	
	--ArkInventory.Output( GREEN_FONT_COLOR_CODE, "scaning: ", ArkInventory.Global.Location[loc_id].Name, " [", loc_id, ".", bag_id, "] - [", blizzard_id, "]" )
	
	local cp = ArkInventory.Global.Me
	
	local bag = cp.location[loc_id].bag[bag_id]
	
	local old_bag_count = bag.count

	bag.count = 0
	bag.empty = 0
	bag.type = ArkInventory.Const.Slot.Type.Mail
	bag.status = ArkInventory.Const.Bag.Status.Active
	
	
	local slot_id = 0
	
	for msg_id = 1, GetInboxNumItems( ) do
	
		--ArkInventory.Output( "scanning message ", msg_id )
		
		local _, _, _, _, _, _, daysLeft, hasItem, _, wasReturned, _, canReply, _ = GetInboxHeaderInfo( msg_id )
		
		--if ( daysLeft >= 1 ) then
--			daysLeft = string.format( "%s%s%s%s", GREEN_FONT_COLOR_CODE, string.format( DAYS_ABBR, floor(daysLeft) ), " ", FONT_COLOR_CODE_CLOSE )
		--else
--			daysLeft = string.format( "%s%s%s", RED_FONT_COLOR_CODE, SecondsToTime( floor( daysLeft * 24 * 60 * 60 ) ), FONT_COLOR_CODE_CLOSE )
		--end
		
		--local expires_d = floor( daysLeft )
		--local expires_s = ( daysLeft - floor( daysLeft ) ) * 24 * 60* 60
		--local purge = not not ( wasReturned ) or ( not canReply )
		
		if hasItem then
		
			--ArkInventory.Output( "message ", msg_id, " has item(s)" )
			
			for attachment_id = 1, ATTACHMENTS_MAX_RECEIVE do
				
				local name, _, count = GetInboxItem( msg_id, attachment_id ) -- quality is bugged, always returns -1
				
				if ( name ) then
					
					--ArkInventory.Output( "message ", msg_id, ", attachment ", attachment_id, " = ", name, " x ", count, " / (", { GetInboxItemLink( msg_id, attachment_id ) }, ")" )
					
					slot_id = slot_id + 1
					
					if not bag.slot[slot_id] then
						bag.slot[slot_id] = {
							loc_id = loc_id,
							bag_id = bag_id,
							slot_id = slot_id,
						}
					end
					
					local i = bag.slot[slot_id]
					local item_to_reset = i.h
					
					local h = GetInboxItemLink( msg_id, attachment_id )
					local hasCooldown, speciesID, level, breedQuality, maxHealth, power, speed, name = ArkInventory.Global.Tooltip.Scan:SetInboxItem( msg_id, attachment_id )
					if speciesID then
						h = ArkInventory.BattlepetBaseHyperlink( speciesID, level, breedQuality, maxHealth, power, speed, name )
					end
					
					local sb = false -- always false, might be boa but sort that out if its looted
					
					if h then
						bag.count = bag.count + 1
					end
					
					local changed_item, new, reset_count = ArkInventory.ScanChanged( i, h, sb, count )
					
					i.h = h
					i.sb = sb
					
					if changed_item or i.loc_id == nil then
						
						i.age = ArkInventory.ItemAgeUpdate( )
						
						i.count = count
						
						i.q = ArkInventory.ObjectInfoQuality( h )
						i.new = new
						
						if h then
							item_to_reset = h
						end
						
						ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
						
					end
					
					if item_to_reset and reset_count then
						ArkInventory.ObjectCountClear( item_to_reset )
					end
					
				end
			
			end
		
		end
		
	end
	
	
	ArkInventory.ScanCleanup( cp, loc_id, bag_id, bag, old_bag_count )

end

function ArkInventory.ScanCompanion( type_id )
	
	--ArkInventory.Output( "ScanCompanion( ", type_id, " ) start" )
	
	local blizzard_id
	if type_id == "CRITTER" then
		return ArkInventory.ScanBattlePet( )
	elseif type_id == "MOUNT" then
		blizzard_id = ArkInventory.Const.Offset.Mount + 1
	else
		--ArkInventory.Output( "unknown companion type" )
		return
	end
	
	local loc_id, bag_id = ArkInventory.BagID_Internal( blizzard_id )
	
	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of bag id [", blizzard_id, "], location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] is not being monitored" )
		return
	end
	
	--ArkInventory.Output( GREEN_FONT_COLOR_CODE, "scaning: ", ArkInventory.Global.Location[loc_id].Name, " [", loc_id, ".", bag_id, "] - [", blizzard_id, "]" )
	
	local cp = ArkInventory.Global.Me
	
	local bag = cp.location[loc_id].bag[bag_id]
	
	local old_bag_count = bag.count
	
	bag.count = ( ( cp.info.level >= ArkInventory.Const.PLAYER_MOUNT_LEVEL ) and GetNumCompanions( type_id ) ) or 0
	bag.empty = 0
	bag.type = ArkInventory.BagType( blizzard_id )
	bag.status = ArkInventory.Const.Bag.Status.Active
	
	local creatureID, creatureName, creatureSpellID, texture, active, bitfield
	
	for slot_id = 1, bag.count do
		
		if not bag.slot[slot_id] then
			bag.slot[slot_id] = {
				loc_id = loc_id,
				bag_id = bag_id,
				slot_id = slot_id,
			}
		end
		
		local i = bag.slot[slot_id]
		local item_to_reset = i.h
		
		creatureID, creatureName, creatureSpellID, texture, active, bitfield = GetCompanionInfo( type_id, slot_id )
		
--[[
		local t = "ground"
		if bit.band( bitfield, 0x02 ) == 0x02 then
			t = "fly"
		elseif bit.band( bitfield, 0x09 ) ~= 0x09 then
			t = "water" -- water mounts dont have the ground bit
		end
]]--
		
		local h = GetSpellLink( creatureSpellID )
		local sb = true
		local count = 1
		
		--ArkInventory.Output( "type=[", type_id, "], slot=[", slot_id, "] link=", h, "." )
		
		local changed_item, new, reset_count = ArkInventory.ScanChanged( i, h, sb, count )
		
		if changed_item then
			
			i.age = ArkInventory.ItemAgeUpdate( )
			
			i.h = h
			i.count = count
			i.sb = sb
			
			i.q = 1
			i.new = new
			
			i.type = type_id
			i.texture = texture
			
			if h then
				item_to_reset = h
			end
			
			ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
			
		end
		
		if item_to_reset and reset_count then
			ArkInventory.ObjectCountClear( item_to_reset )
		end
		
	end
	
	
	if type_id == "MOUNT" then
		
		local spells = { }
		
		if IsSpellKnown( 33943 ) then
			bag.count = bag.count + 1
			spells[33943] = bag.count
			--ArkInventory.Output( "i know flight form" )
		end
		
		if IsSpellKnown( 40120 ) then
			bag.count = bag.count + 1
			spells[40120] = bag.count
			--ArkInventory.Output( "i know swift flight form" )
		end
		
		for spell_id, slot_id in pairs( spells ) do
			
			if not bag.slot[slot_id] then
				bag.slot[slot_id] = { }
			end
			
			local i = bag.slot[slot_id]
			local item_to_reset = i.h
			
			local h = GetSpellLink( spell_id )
			local sb = true
			local count = 1
			
			--ArkInventory.Output( "type=[", type_id, "], slot=[", slot_id, "] link=", h, "." )
			
			local changed_item, new, reset_count = ArkInventory.ScanChanged( i, h, sb, count )
			
			if changed_item or i.loc_id == nil then
				
				i.age = ArkInventory.ItemAgeUpdate( )
				
				i.loc_id = loc_id
				i.bag_id = bag_id
				i.slot_id = slot_id
				
				i.h = h
				i.count = count
				i.sb = sb
				
				i.q = 1
				i.new = new
				
				i.type = "SPELL"
				i.texture = select( 3, GetSpellInfo( spell_id ) )
				
				if h then
					item_to_reset = h
				end
				
				ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
				
			end
			
			if item_to_reset and reset_count then
				ArkInventory.ObjectCountClear( item_to_reset )
			end
			
		end
		
	end
	
	ArkInventory.ScanCleanup( cp, loc_id, bag_id, bag, old_bag_count )
	
end



function ArkInventory.ScanBattlePet( )
	
	--ArkInventory.Output( "ScanBattlePet( ) start" )
	
	local blizzard_id = ArkInventory.Const.Offset.Pet + 1
	local loc_id, bag_id = ArkInventory.BagID_Internal( blizzard_id )
	
	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of bag id [", blizzard_id, "], location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] is not being monitored" )
		return
	end
	
	--ArkInventory.Output( GREEN_FONT_COLOR_CODE, "scaning: ", ArkInventory.Global.Location[loc_id].Name, " [", loc_id, ".", bag_id, "] - [", blizzard_id, "]" )
	
	if not C_PetJournal.IsJournalUnlocked( ) then
		--ArkInventory.Output( "ScanBattlePet( ) aborted - journal not ready" )
		return
	end
	
	
	local cp = ArkInventory.Global.Me
	
	local bag = cp.location[loc_id].bag[bag_id]
	
	local old_bag_count = bag.count
	
	bag.count = 0
	bag.empty = 0
	bag.type = ArkInventory.BagType( blizzard_id )
	bag.status = ArkInventory.Const.Bag.Status.Active
	
	--ArkInventory.Output( "scanning pets" )
	
	local slot_id = 0
	
	for _, petID in ArkInventory.Lib.Pet:IteratePetIDs( ) do
		
		local speciesID, customName, level, xp, maxXp, displayID, name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable, unique = C_PetJournal.GetPetInfoByPetID( petID )
		--ArkInventory.Output( "petid[", petID, "], [", speciesID, " / ", customName, " / ", level, " / ", xp, " / ", maxXp, " / ", displayID, " / ", name, " / ", petType, "]" )
		
		if ( cp.info.petlevel or 0 ) < level then
			-- save highest pet level for tint unusable
			cp.info.petlevel = level
		end
		
		slot_id = slot_id + 1
	
		if not bag.slot[slot_id] then
			bag.slot[slot_id] = {
				loc_id = loc_id,
				bag_id = bag_id,
				slot_id = slot_id,
			}
		end
		
		local i = bag.slot[slot_id]
		local item_to_reset = i.h
		
		local health, maxHealth, attack, speed, rarity = C_PetJournal.GetPetStats( petID )
		
		--ArkInventory.Output( "petid[", petID, "], name=[", name, "], [", speciesID, " / ", level, " / ", rarity, " / ", maxHealth, " / ", attack, " / ", speed, " / ", customName, "]" )
		
		if isWild then
			rarity = rarity and ( rarity - 1 )
		else	
			rarity = 1
		end
		
		
		--local h = string.format( "battlepet:%s:%s:%s:%s:%s:%s:%s", speciesID or 0, level or 0, rarity or 0, maxHealth or 0, attack or 0, speed or 0, "" )
		--h = string.format( "|c%s|H%s|h[%s]|h|r", select( 4, GetItemQualityColor( rarity ) ), h, name )
		local h = C_PetJournal.GetBattlePetLink( petID )
		
		local sb = ( ( not tradable ) and true ) or nil
		local count = 1
		
		local changed_item, new, reset_count = ArkInventory.ScanChanged( i, h, sb, count )
		
		i.h = h
		
		i.sb = sb
		
		i.q = rarity
		
		i.count = 1
		
		i.type = "CRITTER"
		
		i.pet_id = petID
		i.bp = ( canBattle and true ) or nil
		i.cn = customName
		
		if changed_item then
			
			i.age = ArkInventory.ItemAgeUpdate( )
			
			i.new = new
			
			if h then
				item_to_reset = h
			end
			
			ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
			
		end
		
		if item_to_reset and reset_count then
			ArkInventory.ObjectCountClear( item_to_reset )
		end
		
	end
	
	bag.count = slot_id
	
	ArkInventory.ScanCleanup( cp, loc_id, bag_id, bag, old_bag_count )
	
end

function ArkInventory.ScanCurrency( )

	--ArkInventory.Output( "ScanCurrency( ) start" )
	
	local blizzard_id = ArkInventory.Const.Offset.Token + 1
	
	local loc_id, bag_id = ArkInventory.BagID_Internal( blizzard_id )

	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of bag id [", blizzard_id, "], location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] is not being monitored" )
		return
	end
	
	--ArkInventory.Output( GREEN_FONT_COLOR_CODE, "scaning: ", ArkInventory.Global.Location[loc_id].Name, " [", loc_id, ".", bag_id, "] - [", blizzard_id, "]" )
	
	local numTokenTypes = GetCurrencyListSize( )
	
	if numTokenTypes == 0 then return end
	
	-- expand all currency headers
	for j = numTokenTypes, 1, -1 do
		local name, isHeader, isExpanded = GetCurrencyListInfo( j )
		if isHeader and not isExpanded then
			ExpandCurrencyList( j, 1 )
		end
	end
	
	local cp = ArkInventory.Global.Me
	
	local bag = cp.location[loc_id].bag[bag_id]
	
	local old_bag_count = bag.count
	
	bag.count = 0
	bag.empty = 0
	bag.type = ArkInventory.Const.Slot.Type.Token
	bag.status = ArkInventory.Const.Bag.Status.Active
	
	local slot_id = 0
	
	numTokenTypes = GetCurrencyListSize( )
	
	for j = 1, numTokenTypes do
	
		local name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo( j )
  
		if not isHeader and name and count and count > 0 then
			
			slot_id = slot_id + 1
			
			if not bag.slot[slot_id] then
				bag.slot[slot_id] = {
					loc_id = loc_id,
					bag_id = bag_id,
					slot_id = slot_id,
				}
			end
			
			local i = bag.slot[slot_id]
			local item_to_reset = i.h
			
			local sb = true
			
			local h = GetCurrencyListLink( j )
			
			local changed_item, new, reset_count = ArkInventory.ScanChanged( i, h, sb, count )
			
			i.h = h
			i.count = count
			i.sb = sb
			
			if changed_item or i.loc_id == nil then
				
				i.age = ArkInventory.ItemAgeUpdate( )
				
				i.q = ArkInventory.ObjectInfoQuality( h )
				i.new = new
				
				if h then
					item_to_reset = h
				end
				
				ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
				
			end
			
			if item_to_reset and reset_count then
				ArkInventory.ObjectCountClear( item_to_reset )
			end
		
		end
		
	end
	
	bag.count = slot_id

	ArkInventory.ScanCleanup( cp, loc_id, bag_id, bag, old_bag_count )
	
	-- token "bag" blizzard is using (mapped to our second bag)
	bag_id = 2
	bag = cp.location[loc_id].bag[bag_id]
	bag.count = 0
	bag.empty = 0
	bag.type = ArkInventory.Const.Slot.Type.Token
	bag.status = ArkInventory.Const.Bag.Status.NoAccess
	
end

local CanUseVoidStorage = CanUseVoidStorage or ArkInventory.HookDoNothing

function ArkInventory.ScanVoidStorage( )
	
	--ArkInventory.Output( "ScanVoidStorage" )
	
	if not CanUseVoidStorage( ) then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of void storage, storage not active" )
		return
	end
	
	if ArkInventory.Global.Mode.Void == false then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of void storage, not at npc" )
		return
	end
	
	local blizzard_id = ArkInventory.Const.Offset.Void + 1
	local loc_id, bag_id = ArkInventory.BagID_Internal( blizzard_id )
	
	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of bag id [", blizzard_id, "], location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] is not being monitored" )
		return
	end

	--ArkInventory.Output( GREEN_FONT_COLOR_CODE, "scaning: ", ArkInventory.Global.Location[loc_id].Name, " [", loc_id, ".", bag_id, "] - [", blizzard_id, "]" )
	
	local cp = ArkInventory.Global.Me
	
	local bag = cp.location[loc_id].bag[bag_id]
	
	bag.count = 80
	bag.empty = 0
	bag.type = ArkInventory.BagType( blizzard_id )
	bag.status = ArkInventory.Const.Bag.Status.Active
	
	for slot_id = 1, bag.count do
		
		if not bag.slot[slot_id] then
			bag.slot[slot_id] = { }
		end
		
		local i = bag.slot[slot_id]
		i.display_id = 10 * ( ( slot_id - 1 ) % 8 ) + math.floor( ( slot_id - 1 ) / 8 ) + 1
		
		local item_to_reset = i.h
		
		local item_id, texture, locked = GetVoidItemInfo( slot_id )
		local h = GetVoidItemHyperlinkString( slot_id )
		local count = 1
		local sb = true
		
		if h then
			
		else
			
			bag.empty = bag.empty + 1
			
		end
		
		
		local changed_item, new, reset_count = ArkInventory.ScanChanged( i, h, sb, count )

		if changed_item or i.loc_id == nil then
			
			i.age = ArkInventory.ItemAgeUpdate( )
			
			i.loc_id = loc_id
			i.bag_id = bag_id
			i.slot_id = slot_id
			
			i.h = h
			i.count = count
			i.sb = sb
			
			i.q = ArkInventory.ObjectInfoQuality( h )
			i.new = new
			
			if h then
				item_to_reset = h
			end
			
			ArkInventory.Frame_Item_Update( loc_id, bag_id, slot_id )
			ArkInventory:SendMessage( "LISTEN_CHANGER_UPDATE_BUCKET", loc_id )
			
			ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
			
		end
		
		if item_to_reset and reset_count then
			--ArkInventory.Output( "clear item count for ", item_to_reset )
			ArkInventory.ObjectCountClear( item_to_reset )
			ArkInventory.LDB.Tracking_Item:Update( )
		end
		
	end
	
	cp.location[loc_id].slot_count = bag.count
	
end

function ArkInventory.ScanChanged( old, h, sb, count )

	-- check for slot changes
	
	-- return item has changed, new status, reset count

	-- do not use the full hyperlink, pull out the itemstring part and check against that, theres a bug where the name isnt always included in the hyperlink

	if not h then
		
		-- slot is empty
		
		if old.h then
			
			-- previous item was removed
			ArkInventory.ItemCacheClear( old.h )

			--ArkInventory.Output( "changed, bag=", bag_id, ", slot=", i.slot_id, ", item removed" )
			return true, ArkInventory.Const.Slot.New.No, true
			
		end
		
	else
		
		-- slot has an item
		
		if not old.h then
			
			-- item added to previously empty slot
			ArkInventory.ItemCacheClear( h )
			
			--ArkInventory.Output( "changed, bag=", bag_id, ", slot=", i.slot_id, ", item added" )
			return true, ArkInventory.Const.Slot.New.Yes, true
			
		end
		
		if ArkInventory.ObjectIDInternal( h ) ~= ArkInventory.ObjectIDInternal( old.h ) then
			
			-- different item
			ArkInventory.ItemCacheClear( h )
			
			--ArkInventory.Output( "changed, bag=", bag_id, ", slot=", i.slot_id, ", item swapped" )
			return true, ArkInventory.Const.Slot.New.Yes, true
			
		end
		
		if sb ~= old.sb then
			
			-- soulbound changed
			ArkInventory.ItemCacheClear( old.h )
			
			--ArkInventory.Output( "changed, bag=", bag_id, ", slot=", i.slot_id, ", soulbound changed" )
			return true, ArkInventory.Const.Slot.New.Yes, false
			
		end
		
		if count ~= old.count then
			-- same item, previously existed, count has changed
			if count > old.count then
				--ArkInventory.Output( "changed, bag=", bag_id, ", slot=", i.slot_id, ", increased" )
				return true, ArkInventory.Const.Slot.New.Inc, true
			else
				--ArkInventory.Output( "changed, bag=", bag_id, ", slot=", i.slot_id, ", decreased" )
				return true, ArkInventory.Const.Slot.New.Dec, true
			end
			
		end
		
	end
	
end

function ArkInventory.ScanCleanup( cp, loc_id, bag_id, bag, old_bag_count )
	
	-- remove unwanted slots
	if old_bag_count > bag.count then
		for slot_id = bag.count + 1, old_bag_count do
			
			if bag.slot[slot_id] and bag.slot[slot_id].h then
				ArkInventory.ObjectCountClear( bag.slot[slot_id].h )
			end
			
			bag.slot[slot_id] = nil
			
		end
	end
	
	if old_bag_count ~= bag.count then
		cp.location[loc_id].slot_count = ArkInventory.Table.Sum( cp.location[loc_id].bag, function( a ) return a.count end )
		ArkInventory:SendMessage( "LISTEN_STORAGE_EVENT", ArkInventory.Const.Event.BagUpdate, loc_id, bag_id, ArkInventory.Const.Window.Draw.Recalculate )
	end
	
end

function ArkInventory.ObjectInfoName( h )
	
	return select( 3, ArkInventory.ObjectInfo( h ) ) or "!"

end

function ArkInventory.ScanAuction( massive )
	
	local blizzard_id = ArkInventory.Const.Offset.Auction + 1
	
	local loc_id, bag_id = ArkInventory.BagID_Internal( blizzard_id )
	
	if ArkInventory.Global.Mode.Auction == false then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of auction house, not at auction house" )
		return
	end
	
	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of bag id [", blizzard_id, "], location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] is not being monitored" )
		return
	end
	
	
	--ArkInventory.Output( GREEN_FONT_COLOR_CODE, "scaning: ", ArkInventory.Global.Location[loc_id].Name, " [", loc_id, ".", bag_id, "] - [", blizzard_id, "]" )
	
	local cp = ArkInventory.Global.Me
	
	local bag = cp.location[loc_id].bag[bag_id]
	
	local old_bag_count = bag.count
	
	local auctions = select( 2, GetNumAuctionItems( "owner" ) )
	
	if auctions > 100 and not massive then
		ArkInventory:SendMessage( "LISTEN_AUCTION_UPDATE_MASSIVE_BUCKET" )
		return
	end
	
	bag.count = auctions
	bag.empty = 0
	bag.type = ArkInventory.Const.Slot.Type.Auction
	bag.status = ArkInventory.Const.Bag.Status.Active
	
	for slot_id = 1, bag.count do
		
		if not bag.slot[slot_id] then
			bag.slot[slot_id] = { }
		end
		
		local i = bag.slot[slot_id]
		local item_to_reset = i.h
		
		--ArkInventory.Output( "scanning auction ", slot_id, " of ", bag.count )
		
		local h = GetAuctionItemLink( "owner", slot_id )
		local name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highestBidder, owner, sold = GetAuctionItemInfo( "owner", slot_id )
		local duration = GetAuctionItemTimeLeft( "owner", slot_id )
		local sb = false
		
		--ArkInventory.Output( "auction ", slot_id, " / ", h, " / ", sold )
		
		if not h or sold == 1 then
			count = 1
			bag.empty = bag.empty + 1
			h = nil
			duration = nil
		end
		
		--ArkInventory.Output( "auction ", slot_id, " = ", h, " x ", count )
		
		local changed_item, new, reset_count = ArkInventory.ScanChanged( i, h, sb, count )
		
		if changed_item or i.loc_id == nil then
			
			table.wipe( i )
			
			i.age = ArkInventory.ItemAgeUpdate( )
			
			i.loc_id = loc_id
			i.bag_id = bag_id
			i.slot_id = slot_id
			
			i.h = h
			i.count = count
			i.sb = sb
			i.q = ArkInventory.ObjectInfoQuality( h )
			i.new = new
			
			if duration == 1 then
				-- Short (less than 30 minutes)
				i.expires = i.age + 30
			elseif duration == 2 then
				-- Medium (30 minutes to 2 hours)
				i.expires = i.age + 2 * 60
			elseif duration == 3 then
				-- Long (2 hours to 12 hours)
				i.expires = i.age + 12 * 60
			elseif duration == 4 then
				-- Very Long (more than 12 hours)
				i.expires = i.age + 48 * 60
			end
			
			if h then
				item_to_reset = h
			end
			
			ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
			
		end
		
		if item_to_reset and reset_count then
			ArkInventory.ObjectCountClear( item_to_reset )
		end
		
	end
	
	ArkInventory.ScanCleanup( cp, loc_id, bag_id, bag, old_bag_count )
	
end

function ArkInventory.ScanAuctionExpire( )
	
	local blizzard_id = ArkInventory.Const.Offset.Auction + 1
	
	local loc_id, bag_id = ArkInventory.BagID_Internal( blizzard_id )
	
	local current_time = ArkInventory.ItemAgeUpdate( )
	
	local cp = ArkInventory.Global.Me
	
	local bag = cp.location[loc_id].bag[bag_id]
	
	for slot_id = 1, bag.count do
		
		local i = bag.slot[slot_id]
		
		if i.h then
			
			local item_to_reset = i.h
			
			if ( i.expires and ( i.expires < current_time ) ) or ( i.age and ( i.age + 48 * 60 < current_time ) ) then
				
				table.wipe( i )
				
				i.loc_id = loc_id
				i.bag_id = bag_id
				i.slot_id = slot_id
				
				i.count = 1
				bag.empty = bag.empty + 1
				
				ArkInventory.ObjectCountClear( item_to_reset )
				
			end
			
		end
		
	end
	
	ArkInventory:SendMessage( "LISTEN_STORAGE_EVENT", ArkInventory.Const.Event.BagUpdate, loc_id, bag_id, ArkInventory.Const.Window.Draw.Refresh )
	
end

function ArkInventory.ScanSpellbook( )
	
	if true then return end -- not enabled yet
	
	local blizzard_id = ArkInventory.Const.Offset.Spellbook + 1
	
	local loc_id = ArkInventory.BagID_Internal( blizzard_id )
	
	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of bag id [", blizzard_id, "], location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] is not being monitored" )
		return
	end
	
	
	--ArkInventory.Output( GREEN_FONT_COLOR_CODE, "scaning: ", ArkInventory.Global.Location[loc_id].Name, " [", loc_id, ".", bag_id, "] - [", blizzard_id, "]" )
	
	local cp = ArkInventory.Global.Me
	
	local numTabs = GetNumSpellTabs( )
	
	for bag_id = 1, numTabs do
		
		local bag = cp.location[loc_id].bag[bag_id]
		
		local old_bag_count = bag.count
		
		local name, texture, offset, numSpells = GetSpellTabInfo( bag_id )

		bag.count = numSpells
		bag.empty = 0
		bag.type = ArkInventory.Const.Slot.Type.Spellbook
		bag.status = ArkInventory.Const.Bag.Status.Active
		bag.texture = texture
		
		for slot_id = 1, bag.count do
			
			if not bag.slot[slot_id] then
				bag.slot[slot_id] = { }
			end
			
			local i = bag.slot[slot_id]
			local item_to_reset = i.h
			
			--ArkInventory.Output( "scanning spellbook tab ", bag_id, ", slot ", slot_id + offset )
			
			local h = GetSpellLink( slot_id + offset, "spell")
			--local name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRange = GetSpellInfo( slot_id + offset, "spell")
			local quality = 1
			local sb = true
			local count = 1
			
			--ArkInventory.Output( "spellbook ", bag_id, " / ", slot_id, " / ", h )
			
			if not h then
				bag.empty = bag.empty + 1
				h = nil
			end
			
			local changed_item, new, reset_count = ArkInventory.ScanChanged( i, h, sb, count )
			
			if changed_item or i.loc_id == nil then
				
				table.wipe( i )
				
				i.loc_id = loc_id
				i.bag_id = bag_id
				i.slot_id = slot_id
				
				i.h = h
				i.count = count
				i.sb = sb
				i.q = ArkInventory.ObjectInfoQuality( h )
				i.new = new
				
				if h then
					item_to_reset = h
				end
				
				ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
				
			end
			
			if item_to_reset and reset_count then
				ArkInventory.ObjectCountClear( item_to_reset )
			end
			
		end
		
		
		ArkInventory.ScanCleanup( cp, loc_id, bag_id, bag, old_bag_count )
		
	end
	
end


function ArkInventory.ScanTradeskillWindow( )
	
	if IsTradeSkillLinked( ) then
		-- dont care about other players
		return
	end
	
	local restore_ShowSkillUps = TradeSkillFrame.filterTbl.hasSkillUp
	TradeSkillOnlyShowSkillUps( false )
	
	local restore_OnlyShowMakeable = TradeSkillFrame.filterTbl.hasMaterials
	TradeSkillOnlyShowMakeable( false )
	
	local restore_SubClassFilter = -1
	for _, index in pairs( { GetTradeSkillSubClasses( ) } ) do
		if GetTradeSkillSubClassFilter( index ) then
			restore_SubClassFilter = index
		end
	end
	SetTradeSkillSubClassFilter( -1, 1, 1 )
	
	
	local restore_InvSlotFilter = -1
	for _, index in pairs( { GetTradeSkillInvSlots( ) } ) do
		if GetTradeSkillInvSlotFilter( index ) then
			restore_InvSlotFilter = index
		end
	end
	SetTradeSkillInvSlotFilter( -1, 1, 1 )
	
	local restore_ItemLevelFilter_min, restore_ItemLevelFilter_max = GetTradeSkillItemLevelFilter( )
	SetTradeSkillItemLevelFilter( 0, 0 )
	
	local restore_ItemNameFilter = GetTradeSkillItemNameFilter( )
	SetTradeSkillItemNameFilter( nil )
	
	
	-- expand all categories
	local restore_header = { }
	local numSkills = GetNumTradeSkills( )
	local header = 0
	for index = numSkills, 1, -1 do
		local skillName, skillType, numAvailable, isExpanded, serviceType, numSkillUps = GetTradeSkillInfo( index )
		if skillType == "header" then
			header = header + 1
			restore_header[header] = isExpanded
			if not isExpanded then
				ExpandTradeSkillSubClass( index )
			end
		end
	end
	
	numSkills = GetNumTradeSkills( )
	ArkInventory.Output( "numSkills=", numSkills )
	for index = 1, numSkills do
		local skillName, skillType, numAvailable, isExpanded, serviceType, numSkillUps = GetTradeSkillInfo( index )
		if skillType ~= "header" then
			local h = GetTradeSkillRecipeLink( index )
			ArkInventory.Output( index, " = ", skillName, " / ", skillType, " / ", h )
		end
	end
	
	
	
	-- restore filters
	TradeSkillOnlyShowSkillUps( restore_ShowSkillUps )
	TradeSkillOnlyShowMakeable( restore_OnlyShowMakeable )
	SetTradeSkillSubClassFilter( restore_SubClassFilter, 1, 1 )
	SetTradeSkillInvSlotFilter( restore_InvSlotFilter, 1, 1 )
	SetTradeSkillItemLevelFilter( restore_ItemLevelFilter_min, restore_ItemLevelFilter_max )
	SetTradeSkillItemNameFilter( restore_ItemNameFilter )
	
	-- restore collapsed headers
	numSkills = GetNumTradeSkills( )
	header = 0
	for index = numSkills, 1, -1 do
		local skillName, skillType, numAvailable, isExpanded, serviceType, numSkillUps = GetTradeSkillInfo( index )
		if skillType == "header" then
			header = header + 1
			if not restore_header[header] then
				CollapseTradeSkillSubClass( index )
			end
		end
	end
	
end

function ArkInventory.ScanTradeskill( )
	
	if true then return end -- not enabled yet
	
	local blizzard_id = ArkInventory.Const.Offset.Tradeskill + 1
	
	local loc_id = ArkInventory.BagID_Internal( blizzard_id )
	
	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( RED_FONT_COLOR_CODE, "aborted scan of bag id [", blizzard_id, "], location ", loc_id, " [", ArkInventory.Global.Location[loc_id].Name, "] is not being monitored" )
		return
	end
	
	
	--ArkInventory.Output( GREEN_FONT_COLOR_CODE, "scaning: ", ArkInventory.Global.Location[loc_id].Name, " [", loc_id, ".", bag_id, "] - [", blizzard_id, "]" )
	
	local cp = ArkInventory.Global.Me
	
	local prof = { GetProfessions( ) }
	
	for bag_id = 1, 6 do
		
		local bag = cp.location[loc_id].bag[bag_id]
		
		local old_bag_count = bag.count
		
		bag.count = 0
		bag.empty = 0
		bag.type = ArkInventory.Const.Slot.Type.Tradeskill
		bag.status = ArkInventory.Const.Bag.Status.Active
		bag.texture = [[Interface\\Icons\\INV_Scroll_04]]
		
		local index = prof[bag_id]
		
		if index then
			
			local name, texture, rank, maxRank, numSpells, spelloffset, skillLine, rankModifier = GetProfessionInfo( index )
			bag.texture = texture
			
			CastSpell( 1 + spelloffset, BOOKTYPE_PROFESSION )
			
			
			
			local numSkills = GetNumTradeSkills( )
			ArkInventory.Output( "tradeskill ", bag_id, " = ", name, ", ", numSkills )
			
			
			
			local slot_id = 0
			
			for skillIndex = 1, bag.count do
				
				local skillName, skillType, numAvailable, isExpanded, altVerb, numSkillUps = GetTradeSkillInfo( skillIndex )
				
				
				if not bag.slot[slot_id] then
					bag.slot[slot_id] = { }
				end
				
				local i = bag.slot[slot_id]
				local item_to_reset = i.h
				
				--ArkInventory.Output( "scanning tradeskill ", bag_id, ", slot ", slot_id + offset )
				
				local h --= GetSpellLink( slot_id + offset, "spell")
				
				local quality = 1
				local sb = true
				local count = 1
				
				
				if not h then
					bag.empty = bag.empty + 1
					h = nil
				end
				
				local changed_item, new, reset_count = ArkInventory.ScanChanged( i, h, sb, count )
				
				if changed_item or i.loc_id == nil then
					
					table.wipe( i )
					
					i.loc_id = loc_id
					i.bag_id = bag_id
					i.slot_id = slot_id
					
					i.h = h
					i.count = count
					i.sb = sb
					i.q = ArkInventory.ObjectInfoQuality( h )
					i.new = new
					
					if h then
						item_to_reset = h
					end
					
					ArkInventory.Frame_Main_DrawStatus( loc_id, ArkInventory.Const.Window.Draw.Refresh )
					
				end
				
				if item_to_reset and reset_count then
					ArkInventory.ObjectCountClear( item_to_reset )
				end
				
			end
			
		end
		
		ArkInventory.ScanCleanup( cp, loc_id, bag_id, bag, old_bag_count )
		
	end
	
end


function ArkInventory.ObjectInfoTexture( h )
	local x = select( 4, ArkInventory.ObjectInfo( h ) )
	return x
end

function ArkInventory.ObjectInfoQuality( h )
	
	return ( select( 5, ArkInventory.ObjectInfo( h ) ) ) or 1
	
end

function ArkInventory.ObjectInfo( h )
	
	if h == nil or type( h ) ~= "string" then
		return
	end
	
	local class, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = ArkInventory.ObjectStringDecode( h )
	
	if class == "item" then
		
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo( v1 )
		
		if itemTexture == nil then
			itemTexture = GetItemIcon( h )
		end
		
		if not itemName then
			itemName = string.match( h, "|h%[(.+)%]|h" )
		end
		
		return class, itemLink, itemName, itemTexture, itemRarity or 0, itemLevel or 0, itemMinLevel or 0, itemType or "", itemSubType or "", itemStackCount or 1, itemEquipLoc or "", itemSellPrice or 0
		
	elseif class == "spell" then
		
		local itemName, _, itemTexture = GetSpellInfo( v1 )
		local itemLink = GetSpellLink( v1 )
		local itemRarity = 1
		
		return class, itemLink, itemName, itemTexture, itemRarity
		
	elseif class == "battlepet" then
		
		local itemName, itemTexture, petType, creatureID, sourceText, description, isWild, canBattle, tradable, unique = C_PetJournal.GetPetInfoBySpeciesID( v1 )
		--local itemLink = C_PetJournal.GetBattlePetLink( v1 )
--		v1=speciesID, v2=level, v3=quality, v4=maxHealth, v5=power, v6=speed, v7=customName
		
		return class, h, itemName, itemTexture, v3, v2, 0, string.format( "%02i", petType ), "", 1, "", 0, v1, v2, v4, v5, v6, v7, v8, v9, v10
		
	elseif class == "currency" then
		
		-- v1=currencyID
		
		local itemLink = GetCurrencyLink( v1 )
		local itemName, amount, itemTexture = GetCurrencyInfo( v1 )
		if not string.find( itemTexture, "\\" ) then
			itemTexture = string.format( "Interface\\Icons\\%s", itemTexture )
		end
		
		return class, itemLink, itemName, itemTexture, 1, 0, 0, "", "", 0, "", 0, amount
		
	end
	
end

function ArkInventory.ObjectStringHyperlinkBase( h )
	return string.match( ( h or "" ), "|H(.-)|h" ) or string.match( ( h or "" ), "^([a-z]-:.+)" )
end

function ArkInventory.ObjectStringDecode( h )
	
	-- item:itemId:enchantId:jewelId1:jewelId2:jewelId3:jewelId4:suffixId:uniqueId:linkLevel:reforgeId
	-- battlepet:speciesID:level:quality:health:power:speed:customName
	-- spell:spellID
	-- currency:currencyID
	
	local s = string.match( ( h or "" ), "|H(.-)|h" ) or string.match( ( h or "" ), "^([a-z]-:.+)" ) or ""
	local class, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = strsplit( ":", s )
	
	class = string.lower( class or "" )
	
	if class == "" then
		class = "empty"
	end
	
	v1 = tonumber( v1 ) or 0
	v2 = tonumber( v2 ) or 0
	v3 = tonumber( v3 ) or 0
	v4 = tonumber( v4 ) or 0
	v5 = tonumber( v5 ) or 0
	v6 = tonumber( v6 ) or 0
	if class ~= "battlepet" then
		v7 = tonumber( v7 ) or 0
	end
	v8 = tonumber( v8 ) or 0
	v9 = tonumber( v9 ) or 0
	v10 = tonumber( v10 ) or 0
	
	return class, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
	
end

function ArkInventory.ObjectStringDecodeItem( h )
	
	local h = h
	if type( h ) == "number" then
		h = string.format( "item:%s", h )
	end
	
	local class, id, enchant, j1, j2, j3, j4, suffix, unique = ArkInventory.ObjectStringDecode( h )
	
	if class == "item" then
		return id, suffix, enchant, j1, j2, j3, j4
	end
	
end

function ArkInventory.ScanProfessions( )
	
	--ArkInventory.Output( "ScanProfessions" )
	
	local p = { GetProfessions( ) }
	--ArkInventory.Output( "skills = [", p, "]" )
	
	ArkInventory.Global.Me.info.skills = ArkInventory.Global.Me.info.skills or { }
	
	for index = 1, ArkInventory.Const.Skills.Primary + ArkInventory.Const.Skills.Secondary do
		
		if p[index] then
			--local name, texture, rank, maxRank, numSpells, spelloffset, skillLine, rankModifier = GetProfessionInfo( p[index] )
			--ArkInventory.Output( "skill [", index, "] = [", skillLine, "] [", name, "]" )
			local skillLine = select( 7, GetProfessionInfo( p[index] ) )
			ArkInventory.Global.Me.info.skills[index] = skillLine
		else
			ArkInventory.Global.Me.info.skills[index] = nil
			--ArkInventory.Output( "skill [", index, "] = [", skillLine, "] [", name, "]" )
		end
		
	end

	ArkInventory.Table.Clean( ArkInventory.Global.Cache.Default )
	ArkInventory.LocationSetValue( nil, "resort", true )
	
end

function ArkInventory.InventoryIDGet( loc_id, bag_id )
	
	local inv_id = nil
	
	local blizzard_id = ArkInventory.BagID_Blizzard( loc_id, bag_id )
	
	if blizzard_id == nil then
		return nil
	end
	
	if loc_id == ArkInventory.Const.Location.Bag and bag_id > 1 then
		inv_id = ContainerIDToInventoryID( blizzard_id )
	elseif loc_id == ArkInventory.Const.Location.Bank and bag_id > 1 then
		inv_id = BankButtonIDToInvSlotID( blizzard_id, 1 )
	end
	
	return inv_id
	
end


function ArkInventory.ObjectIDInternal( h )

	local class, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 = ArkInventory.ObjectStringDecode( h )
	
	if class == "item" then
		return string.format( "%s:%s:%s:%s:%s:%s:%s:%s:%s", class, v1, v2, v7, v3, v4, v5, v6, v10 )
	elseif class == "empty" then
		return string.format( "%s:%s", class, v1 )
	elseif class == "spell" then
		return string.format( "%s:%s", class, v1 )
	elseif class == "battlepet" then
		return string.format( "%s:%s", class, v1 )
	elseif class == "currency" then
		return string.format( "%s:%s", class, v1 )
	else
		error( string.format( "code failure: uncoded class [%s] for object %s", class, h ) )
	end
	
end

function ArkInventory.ObjectIDTooltip( h )
	
	local class, v1, v2 = ArkInventory.ObjectStringDecode( h )
	
	--ArkInventory.Output( "class[", class, "] : [", v1, "] : [", v2, "]" )
	
	if class == "item" then
		return string.format( "%s:%s", class, v1 )
	elseif class == "empty" then
		return string.format( "%s:%s", class, v1 )
	elseif class == "spell" then
		return string.format( "%s:%s", class, v1 )
	elseif class == "battlepet" then
		return string.format( "%s:%s", class, v1 )
	elseif class == "currency" then
		return string.format( "%s:%s", class, v1 )
	else
		error( string.format( "code failure: uncoded object class [%s]", class ) )
	end

end

function ArkInventory.ObjectIDCacheCategory( loc_id, bag_id, sb, h )
	
	local soulbound = ( sb and 1 ) or 0
	
	if not h then
		-- empty slots
		local blizzard_id = ArkInventory.BagID_Blizzard( loc_id, bag_id )
		soulbound = ArkInventory.BagType( blizzard_id ) -- allows for unique codes per bag type
	end
	
	local class, v1 = ArkInventory.ObjectStringDecode( h )
	
	if class == "item" then
		return string.format( "%s:%s:%s", class, v1, soulbound )
	elseif class == "empty" then
		return string.format( "%s:%s:%s", class, 0, soulbound )
	elseif class == "spell" then
		return string.format( "%s:%s", class, v1 )
	elseif class == "battlepet" then
		return string.format( "%s:%s:%s", class, v1, soulbound )
	elseif class == "currency" then
		return string.format( "%s:%s", class, v1 )
	else
		error( string.format( "code failure: unknown object class [%s]", class ) )
	end

end

function ArkInventory.ObjectIDCacheRule( loc_id, bag_id, sb, h )
	
	return string.format( "%i:%i:%i:%s", loc_id or 0, bag_id or 0, ( sb and 1 ) or 0, ArkInventory.ObjectIDInternal( h ) )
	
end

function ArkInventory.ObjectCountClear( search_id, vault )
	
	if search_id == nil then
		return
	end
	
	local search_id = ArkInventory.ObjectIDTooltip( search_id )
	
	local cp = ArkInventory.Global.Me
	
	local player = cp.info.name
	
	if vault then 
		player = cp.info.guild_id
	end
	
	if not player then
		return
	end
	
	ArkInventory.Global.Cache.ItemCount[search_id] = nil
	
	--ArkInventory.Output( "id=", search_id, ", player=", player )
	
	if ArkInventory.Global.Cache.ItemCountRaw[search_id] and ArkInventory.Global.Cache.ItemCountRaw[search_id][player] then
		--ArkInventory.Output( "reset raw count for ", search_id, " for ", player )
		ArkInventory.Global.Cache.ItemCountRaw[search_id][player] = nil
	end
	
end

function ArkInventory.ObjectCountGet( search_id, just_me, ignore_vaults, ignore_other_faction )
	
	local search_id = ArkInventory.ObjectIDTooltip( search_id )
	
	if not ArkInventory.Global.Cache.ItemCountRaw[search_id] then
		ArkInventory.Global.Cache.ItemCountRaw[search_id] = {
--		[player] = {
--			["location"] = {
--				[loc_id] = number (count),
--			},
--			["total"] = number,
--			["vault"] = boolean,
--			["tabs"] = string ("1, 2, 3, 4, 5, 6, 7, 8")
--			["faction"] = string (english),
--		},
	}
	end
	
	local d = ArkInventory.Global.Cache.ItemCountRaw[search_id]
	
	local cp = ArkInventory.Global.Me
	
	if ( cp.info.name and not d[cp.info.name] ) or ( cp.info.guild_id and not d[cp.info.guild_id] ) then
		
		local search_alt = ArkInventory.Const.ItemSpellCrossReference[search_id]
		
		-- build raw
		for pn, pd in pairs( ArkInventory.db.realm.player.data ) do
			
			if ( pd.info.name ) and ( not d[pn] ) then
				
				for l, ld in pairs( pd.location ) do
					
					--ArkInventory.Output( "scanning location [", l, "] for item [", search_id, "]" )
					local c = 0
					local k = false
					local tabs = ""
					
					for b, bd in pairs( ld.bag ) do
						
						k = false
						
						if bd.h and search_id == ArkInventory.ObjectIDTooltip( bd.h ) then
							--ArkInventory.Output( "found bag [", b, "] equipped" )
							c = c + 1
							k = true
						end
						
						for s, sd in pairs( bd.slot ) do
							
							if sd and sd.h then
								
								-- primary match
								local oit = ArkInventory.ObjectIDTooltip( sd.h )
								local match = ( search_id == oit )
								
								-- secondary match
								if not match and search_alt then
									for k in pairs( search_alt ) do
										if k == oit then
											match = true
											break
										end
									end
								end
								
								if match then
									--ArkInventory.Output( pn, " has ", sd.count, " x ", sd.h, " in loc[", l, "], bag [", b, "] slot [", s, "]" )
									c = c + sd.count
									k = true
								end
								
							end
							
						end
						
						if k and l == ArkInventory.Const.Location.Vault then
							tabs = string.format( "%s%s, ", tabs, b )
						end
						
					end
					
					if not d[pn] then
						d[pn] = { ["vault"] = false, ["location"] = { }, ["total"] = 0, ["faction"] = pd.info.faction }
					end
					
					if c > 0 then
						
						if l == ArkInventory.Const.Location.Vault then
							d[pn].vault = true
							d[pn].tabs = string.sub( tabs, 1, string.len( tabs ) - 2 )
						end
						
						d[pn].location[l] = c
						
					end
					
				end
				
			end
			
		end
		
	end
	
	
	-- check cache exists
	if ArkInventory.Global.Cache.ItemCount[search_id] then
		return ArkInventory.Global.Cache.ItemCount[search_id]
	else
		ArkInventory.Global.Cache.ItemCount[search_id] ={ }
	end
	
	-- build return
	d = ArkInventory.Global.Cache.ItemCount[search_id]
	
	for pn, pd in pairs( ArkInventory.Global.Cache.ItemCountRaw[search_id] ) do
		
		if ( not ignore_other_faction ) or ( ignore_other_faction and pd.faction == cp.info.faction ) then
			
			if ( not just_me ) or ( just_me and pn == cp.info.name ) then
				
				for l, c in pairs( pd.location ) do
					
					local ok = true
					
					if ignore_vaults and pd.vault then
						ok = false
					end
					
					if ok then
						
						if c > 0 then
							
							if not d[pn] then
								d[pn] = { ["vault"] = pd.vault, ["tabs"] = pd.tabs, ["location"] = { }, ["total"] = 0, ["faction"] = pd.faction }
							end
							
							d[pn].location[l] = c
							d[pn].total = d[pn].total + c
							
						end
						
					end
					
				end
				
			end
			
		end
		
	end
	
	table.sort( d )
	return d
	
end

function ArkInventory.BattlepetBaseHyperlink( ... )
	local v = { ... } -- speciesID, level, breedQuality, maxHealth, power, speed, customName, bPetID
	return string.format( "battlepet:%s:%s:%s:%s:%s:%s:%s", v[1] or 0, v[2] or 0, v[3] or 0, v[4] or 0, v[5] or 0, v[6] or 0, "" )
end
