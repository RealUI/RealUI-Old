local _G = _G
local select = _G.select
local pairs = _G.pairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table
local CreateFrame = _G.CreateFrame


function ArkInventory.TooltipInit( name )
	
	local tooltip = _G[name]
	assert( tooltip, string.format( "XML Frame [%s] not found", name ) )
	
	return tooltip
	
end

function ArkInventory.TooltipNumLines( tooltip )
	
	return tooltip:NumLines( ) or 0
	
end

function ArkInventory.TooltipSetHyperlink( tooltip, h )
	
	tooltip:ClearLines( )
	
	local class = ArkInventory.ObjectStringDecode( h )
	
	if h and ( class == "item" or class == "spell" ) then
		return tooltip:SetHyperlink( h )
	end
	
end

function ArkInventory.TooltipSetBagItem( tooltip, bag_id, slot_id )
	
	tooltip:ClearLines( )
	
	return tooltip:SetBagItem( bag_id, slot_id )
	
end

function ArkInventory.TooltipSetInventoryItem( tooltip, slot )
	
	tooltip:ClearLines( )
	
	return tooltip:SetInventoryItem( "player", slot )
	
end

function ArkInventory.TooltipSetGuildBankItem( tooltip, tab, slot )
	
	tooltip:ClearLines( )
	
	return tooltip:SetGuildBankItem( tab, slot )
	
end

function ArkInventory.TooltipSetItem( tooltip, bag_id, slot_id )
	
	-- not for offline mode, only direct online scanning of the current player
	
	if bag_id == BANK_CONTAINER then
		
		return ArkInventory.TooltipSetInventoryItem( tooltip, BankButtonIDToInvSlotID( slot_id ) )
		
	else
		
		return ArkInventory.TooltipSetBagItem( tooltip, bag_id, slot_id )
		
	end
	
end

function ArkInventory.TooltipSetBattlePet( tooltip, h, i )
	
	-- creates a basic text tooltip, then hooks via the hyperlink for the item counts
	
	local class, speciesID, level, quality, maxHealth, power, speed, customName = ArkInventory.ObjectStringDecode( h )
	
	if class ~= "battlepet" then return end
	
	local name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable, unique = C_PetJournal.GetPetInfoBySpeciesID( speciesID )
	
	--ArkInventory.Output( "[", speciesID, " / ", level, " / ", quality, " / ", maxHealth, " / ", power, " / ", speed, " / ", customName, "]" )
	
	tooltip:ClearLines( )
	
	if i and i.cn and i.cn ~= "" then
		name = string.format( "%s (%s)", name, i.cn )
	end
	
	name = string.format( "|c%s%s|r", select( 4, GetItemQualityColor( quality ) ), name )
	
	tooltip:AddLine( string.format( "|T%s:32:32:-4:4:128:256:64:100:130:166|t %s", GetPetTypeTexture( petType ), name ) )
	
	if ArkInventory.db.global.option.tooltip.battlepet.source then
		if ( sourceText and sourceText ~= "" ) then
			tooltip:AddLine( sourceText, 1, 1, 1, true )
		end
	end
	
	if not tradable then
		tooltip:AddLine( BATTLE_PET_NOT_TRADABLE, 1, 0.1, 0.1, true )
	end
	
	if unique then
		tooltip:AddLine( ITEM_UNIQUE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true )
	end
	
	if canBattle then
		
		local xp, maxXp
		local health = maxHealth
		
		if i and i.pet_id then
			xp, maxXp = select( 4, C_PetJournal.GetPetInfoByPetID( i.pet_id ) )
			health = C_PetJournal.GetPetStats( i.pet_id )
		end
		
		tooltip:AddLine( " " )
		
		
		txt1 = LEVEL
		txt2 = string.format( "%s %s", level, "|TInterface\\PetBattles\\BattleBar-AbilityBadge-Strong-Small:0|t" )
		if xp and maxXp and xp > 0 then
			
			local pc = xp / maxXp * 100
			if pc < 1 then
				pc = 1
			elseif pc > 99 then
				pc = 99
			end
			
			txt1 = string.format( "%s (%d%%)", txt1, pc )
			
		end
		
		tooltip:AddDoubleLine( txt1, txt2 )
		
		
		local iconPetAlive = "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:0:0:32:32:16:32:16:32|t"
		local iconPetDead = "|TInterface\\Scenarios\\ScenarioIcon-Boss:0|t"
		txt1 = PET_BATTLE_STAT_HEALTH
		if health <= 0 then
			
			txt1 = string.format( "%s (%s)", txt1, DEAD )
			txt2 = string.format( "%s %s", maxHealth, iconPetDead )
			
		else
			
			if health ~= maxHealth then
				
				local pc = health / maxHealth * 100
				if pc < 1 then
					pc = 1
				elseif pc > 99 then
					pc = 99
				end
				
				txt1 = string.format( "%s (%d%%)", txt1, pc )
				
			end
			
			txt2 = string.format( "%s %s", maxHealth, iconPetAlive )
			
		end
		
		tooltip:AddDoubleLine( txt1, txt2 )
		-- |TTexturePath:size1:size2:offset-x:offset-y:original-size-x:original-size-y:crop-x1:crop-x2:crop-y1:crop-y2|t
		tooltip:AddDoubleLine( PET_BATTLE_STAT_POWER, string.format( "%s %s", power, "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:0:0:32:32:0:16:0:16|t" ) )
		tooltip:AddDoubleLine( PET_BATTLE_STAT_SPEED, string.format( "%s %s", speed, "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:0:0:32:32:0:16:16:32|t" ) )
		
	else
		
		tooltip:AddLine( ArkInventory.Localise["PET_CANNOT_BATTLE"], 1, 0.1, 0.1, true )
		
	end
	
	if ArkInventory.db.global.option.tooltip.battlepet.description and ( description and description ~= "" ) then
		tooltip:AddLine( " " )
		tooltip:AddLine( description, nil, nil, nil, true )
	end
	
	tooltip:Show( )
	ArkInventory.TooltipHook( tooltip, h )
	
end


function ArkInventory.TooltipGetMoneyFrame( tooltip )
	
	return _G[string.format( "%s%s", tooltip:GetName( ), "MoneyFrame1" )]
	
end

function ArkInventory.TooltipGetItem( tooltip )
	
	local itemName, ItemLink = tooltip:GetItem( )
	return itemName, ItemLink
	
end
	
function ArkInventory.TooltipFind( tooltip, TextToFind, IgnoreLeft, IgnoreRight, CaseSensitive )
	
	if not TextToFind or string.trim( TextToFind ) == "" then
		return false
	end
	
	local IgnoreLeft = IgnoreLeft or false
	local IgnoreRight = IgnoreRight or false
	local CaseSensitive = CaseSensitive or false
	
	local obj, txt
	
	for i = 2, ArkInventory.TooltipNumLines( tooltip ) do
	
		if not IgnoreLeft then
			obj = _G[string.format( "%s%s%s", tooltip:GetName( ), "TextLeft", i )]
			if obj and obj:IsShown( ) then
				txt = obj:GetText( )
				if txt then
				
					--ArkInventory.Output( "L[", i, "] = [", txt, "]" )
					
					if not CaseSensitive then
						txt = string.lower( txt )
						TextToFind = string.lower( TextToFind )
					end
					if string.find( txt, TextToFind ) then
						return string.find( txt, TextToFind )
					end
				end
			end
		end
		
		if not IgnoreRight then
			obj = _G[string.format( "%s%s%s", tooltip:GetName( ), "TextRight", i )]
			if obj and obj:IsShown( ) then
				txt = obj:GetText( )
				if txt then
				
					--ArkInventory.Output( "R[", i, "] = [", txt, "]" )
					
					if not CaseSensitive then
						txt = string.lower( txt )
						TextToFind = string.lower( TextToFind )
					end
					if string.find( txt, TextToFind ) then
						return string.find( txt, TextToFind )
					end
				end
			end
		end

	end

	return
	
end

function ArkInventory.TooltipGetLine( tooltip, i )

	if not i or i < 1 or i > ArkInventory.TooltipNumLines( tooltip ) then
		return
	end
	
	local obj, txt1, txt2
	
	obj = _G[string.format( "%s%s%s", tooltip:GetName( ), "TextLeft", i )]
	if obj and obj:IsShown( ) then
		txt1 = obj:GetText( )
	end
	
	obj = _G[string.format( "%s%s%s", tooltip:GetName( ), "TextRight", i )]
	if obj and obj:IsShown( ) then
		txt2 = obj:GetText( )
	end

	return txt1 or "", txt2 or ""
	
end
	
function ArkInventory.TooltipContains( tooltip, TextToFind, IgnoreLeft, IgnoreRight, CaseSensitive )

	if ArkInventory.TooltipFind( tooltip, TextToFind, IgnoreLeft, IgnoreRight, CaseSensitive ) then
		return true
	else
		return false
	end

end
	
function ArkInventory.TooltipCanUse( tooltip )

	local l = { "TextLeft", "TextRight" }
	
	local n = ArkInventory.TooltipNumLines( tooltip )
	if n > 5 then n = 5 end
	-- only go down to line 5, recipies and patterns may contain red text
	
	for i = 2, n do
		for _, v in pairs( l ) do
			local obj = _G[string.format( "%s%s%s", tooltip:GetName( ), v, i )]
			if obj and obj:IsShown( ) then
				local txt = obj:GetText( )
				local r, g, b = obj:GetTextColor( )
				local c = string.format( "%02x%02x%02x", r * 255, g * 255, b * 255 )
				if c == "fe1f1f" then
					--ArkInventory.Output( "line[", i, "]=[", txt, "]" )
					if txt ~= ITEM_DISENCHANT_NOT_DISENCHANTABLE then
						return false
					end
				end
			end
		end
	end

	return true
	
end


function ArkInventory.TooltipHook( ... )
	
	local tooltip, arg1, arg2, arg3, arg4 = ...
	
	if not tooltip then return end
	
	tooltip.ARK_Data[1] = arg1
	tooltip.ARK_Data[2] = arg2
	tooltip.ARK_Data[3] = arg3
	tooltip.ARK_Data[4] = arg4
	
	if ArkInventory.Global.Mode.Combat then return end
	
	if not tooltip:IsVisible( ) then
		-- dont add stuff to tooltips until after they become visible for the first time
		return
	end
	
	local h = nil
	
	if not h and tooltip["GetItem"] then
		h = select( 2, tooltip:GetItem( ) )
	end
	
	if not h and tooltip["GetSpell"] then
		h = select( 3, tooltip:GetSpell( ) )
		if h then
			h = GetSpellLink( h )
		end
	end
	
	if not h and arg1 then
		h = select( 2, ArkInventory.ObjectInfo( arg1 ) )
	end

	if not h then return end
	
	--ArkInventory.Output( "tooltip = ", tooltip:GetName( ), ", item = ", h )

	if ArkInventory.db.global.option.tooltip.add.count then
		ArkInventory.TooltipAddItemCount( tooltip, h )
	end
	
	--ArkInventory.TooltipAddItemAge( tooltip, h, arg1, arg2 )
	
	tooltip:Show( )
	
end

function ArkInventory.TooltipHookSetCurrencyToken( ... )
	
	local tooltip, arg1 = ...
	
	if not tooltip then return end
	
	local h = GetCurrencyListLink( arg1 )
	
	ArkInventory.TooltipHook( tooltip, h )
	
end

function ArkInventory.TooltipHookSetBackpackToken( ... )
	
	local tooltip, arg1 = ...
	
	if not tooltip then return end
	
	local name, count, icon, currencyID = GetBackpackCurrencyInfo( arg1 )
	local h = GetCurrencyLink( currencyID )
	
	ArkInventory.TooltipHook( tooltip, h )
	
end

function ArkInventory.TooltipAddEmptyLine( tooltip )
	
	if ArkInventory.db.global.option.tooltip.add.empty then
		tooltip:AddLine( " ", 1, 1, 1, 0 )
	end
	
end

function ArkInventory.TooltipAddItemCount( tooltip, h )
	
	local tt = ArkInventory.TooltipObjectCountGet( h )
	if tt then
		local tc = ArkInventory.db.global.option.tooltip.colour.count
		ArkInventory.TooltipAddEmptyLine( tooltip )
		tooltip:AddLine( tt, tc.r, tc.g, tc.b, 0 )
	end
	
end

function ArkInventory.TooltipAddItemAge( tooltip, h, blizzard_id, slot_id )
	
	if type( blizzard_id ) == "number" and type( slot_id ) == "number" then
		ArkInventory.TooltipAddEmptyLine( tooltip )
		local bag_id = ArkInventory.BagID_Internal( blizzard_id )
		tooltip:AddLine( tt, 1, 1, 1, 0 )
	end

end

function ArkInventory.TooltipObjectCountGet( search_id )
	
	local tc = ArkInventory.ObjectCountGet( search_id, ArkInventory.db.global.option.tooltip.me, not ArkInventory.db.global.option.tooltip.add.vault, ArkInventory.db.global.option.tooltip.faction )
	if tc == nil then
		--ArkInventory.OutputDebug("no count data")
		return nil
	end
	
	local paint = ArkInventory.db.global.option.tooltip.colour.class
	local colour = ""
	if paint then
		colour = HIGHLIGHT_FONT_COLOR_CODE
	end
	
	local n = UnitName( "player" )
	local f = UnitFactionGroup( "player" )
	
	local item_count_total = 0
	
	local character_count = 0
	local character_entries = { }
	
	local guild_count = 0
	local guild_entries = { }
	
	for pid, td in pairs( tc ) do
		
		local pd = ArkInventory.PlayerInfoGet( pid )
		
		local name = pd.info.name
		if paint then
			name = ArkInventory.DisplayName3( pd.info )
		end
		
		local item_count_character = 0
		local item_count_guild = 0
		
		local location_entries = { }
		
		local faction = ""
		if td.faction ~= f then
			faction = string.format( " |cff7f7f7f[%s]|r", td.faction or ArkInventory.Localise["UNKNOWN"] )
		end
		
		if td.location then
			
			for l, lc in pairs( td.location ) do
				
				if lc > 0 then
					
					if td.vault then
						if ArkInventory.db.global.option.tooltip.add.tabs then
							table.insert( location_entries, string.format( "%s %s", ArkInventory.Localise["TOOLTIP_VAULT_TABS"], td.tabs ) )
						else
							table.insert( location_entries, string.format( "%s", ArkInventory.Global.Location[l].Name ) )
						end
						item_count_guild = item_count_guild + lc
					else
						table.insert( location_entries, string.format( "%s %s%s|r", ArkInventory.Global.Location[l].Name, colour, lc ) )
						item_count_character = item_count_character + lc
					end
					
				end
				
			end
			
			if item_count_character > 0 then
				
				local me = ""
				if cn == n then
					me = ArkInventory.Localise["TOOLTIP_COUNT_ME"]
				end
				
				table.insert( character_entries, string.format( "%s%s|r%s: %s%s|r (%s)", me, name, faction, colour, item_count_character, table.concat( location_entries, ", " ) ) )
				character_count = character_count + 1
				item_count_total = item_count_total + item_count_character
				
			end
			
			if item_count_guild > 0 then
				table.insert( guild_entries, string.format( "%s|r%s: %s%s|r (%s)", name, faction, colour, item_count_guild, table.concat( location_entries, ", " ) ) )
				guild_count = guild_count + 1
			end
			
		end
		
	end

	if item_count_total > 0 or guild_count > 0 then
		
		local c = ""
		
		if character_count > 1 then
			table.sort( character_entries )
			c = string.format( "%s\n%s: %s%s|r", table.concat( character_entries, "\n" ), ArkInventory.Localise["TOTAL"], colour, item_count_total )
		else
			c = table.concat( character_entries, "\n" )
		end
		
		local g = ""
		
		if ArkInventory.db.global.option.tooltip.add.vault and guild_count > 0 then
			
			if character_count > 0 then
				g = "\n\n"
			end
			
			table.sort( guild_entries )
			g = string.format( "%s%s", g, table.concat( guild_entries, "\n" ) )
			
		end
		
		return string.format( "%s%s", c, g )
		
	else
		
		return nil
		
	end
	
end

function ArkInventory.TooltipSetMoneyCoin( frame, amount, txt, r, g, b )
	
	if not frame or not amount then
		return
	end
	
	frame:AddDoubleLine( txt or " ", " ", r or 1, g or 1, b or 1 )
	
	local numLines = frame:NumLines( )
	if not frame.numMoneyFrames then
		frame.numMoneyFrames = 0
	end
	if not frame.shownMoneyFrames then
		frame.shownMoneyFrames = 0
	end
	
	local name = string.format( "%s%s%s", frame:GetName( ), "MoneyFrame", frame.shownMoneyFrames + 1 )
	local moneyFrame = _G[name]
	if not moneyFrame then
		frame.numMoneyFrames = frame.numMoneyFrames + 1
		moneyFrame = CreateFrame( "Frame", name, frame, "TooltipMoneyFrameTemplate" )
		name = moneyFrame:GetName( )
		ArkInventory.MoneyFrame_SetType( moneyFrame, "STATIC" )
	end
	
	moneyFrame:SetPoint( "RIGHT", string.format( "%s%s%s", frame:GetName( ), "TextRight", numLines ), "RIGHT", 15, 0 )
	
	moneyFrame:Show( )
	
	if not frame.shownMoneyFrames then
		frame.shownMoneyFrames = 1
	else
		frame.shownMoneyFrames = frame.shownMoneyFrames + 1
	end
	
	MoneyFrame_Update( moneyFrame:GetName( ), amount )
	
	local leftFrame = _G[string.format( "%s%s%s", frame:GetName( ), "TextLeft", numLines )]
	local frameWidth = leftFrame:GetWidth( ) + moneyFrame:GetWidth( ) + 40
	
	if frame:GetMinimumWidth( ) < frameWidth then
		frame:SetMinimumWidth( frameWidth )
	end
	
	frame.hasMoney = 1

end

function ArkInventory.TooltipSetMoneyText( frame, money, txt, r, g, b )
	if not money then
		return
	elseif money == 0 then
		--frame:AddDoubleLine( txt or "missing text", ITEM_UNSELLABLE, r or 1, g or 1, b or 1, 1, 1, 1 )
		frame:AddDoubleLine( txt or "missing text", ArkInventory.MoneyText( money ), r or 1, g or 1, b or 1, 1, 1, 1 )
	else
		frame:AddDoubleLine( txt or "missing text", ArkInventory.MoneyText( money ), r or 1, g or 1, b or 1, 1, 1, 1 )
	end
end

function ArkInventory.TooltipShowCompare( ... )
	
	local self = ...
	
	if not self or not self.ARK_Data then return end
	
	local objectlink = self.ARK_Data[1]
	if not objectlink or type( objectlink ) ~= "string" then return end
	
	--ArkInventory.Output( self.ARK_Data[1], " / ", self.ARK_Data[2], " / ", self.ARK_Data[3], " / ", self.ARK_Data[4] )
	
	local objectlink = string.match( objectlink, "|H(.-)|h" ) or objectlink
	local class, id, extra = string.match( objectlink, "^(.-):(.-):(.+)$" )
	if not class or not id then return end
	
	local link = nil
	
	--ArkInventory.Output( class, " / ", id, " / ", extra )
	
	if class == "achievement" then
		link = GetAchievementLink( id )
--	elseif class == "instancelock" then
--		link = GetSavedInstanceChatLink(self:GetID())
	else
		return
	end
	
	if not link then return end
	
	-- sourced from GameTooltip.lua / GameTooltip_ShowCompareItem( )
	
	local shoppingTooltip1, shoppingTooltip2, shoppingTooltip3 = unpack(self.shoppingTooltips);

	local item1 = true;
	
	local side = "left";

	-- find correct side
	local rightDist = 0;
	local leftPos = self:GetLeft();
	local rightPos = self:GetRight();
	if ( not rightPos ) then
		rightPos = 0;
	end
	if ( not leftPos ) then
		leftPos = 0;
	end

	rightDist = GetScreenWidth() - rightPos;

	if (leftPos and (rightDist < leftPos)) then
		side = "left";
	else
		side = "right";
	end

	-- see if we should slide the tooltip
	if ( self:GetAnchorType() and self:GetAnchorType() ~= "ANCHOR_PRESERVE" ) then
		local totalWidth = 0;
		if ( item1  ) then
			totalWidth = totalWidth + shoppingTooltip1:GetWidth();
		end

		if ( (side == "left") and (totalWidth > leftPos) ) then
			self:SetAnchorType(self:GetAnchorType(), (totalWidth - leftPos), 0);
		elseif ( (side == "right") and (rightPos + totalWidth) >  GetScreenWidth() ) then
			self:SetAnchorType(self:GetAnchorType(), -((rightPos + totalWidth) - GetScreenWidth()), 0);
		end
	end

	-- anchor the compare tooltips
	if ( item1 ) then
		shoppingTooltip1:SetOwner(self, "ANCHOR_NONE");
		shoppingTooltip1:ClearAllPoints();
		if ( side and side == "left" ) then
			shoppingTooltip1:SetPoint("TOPRIGHT", self, "TOPLEFT", 0, -10);
		else
			shoppingTooltip1:SetPoint("TOPLEFT", self, "TOPRIGHT", 0, -10);
		end
		shoppingTooltip1:SetHyperlink(link);
		shoppingTooltip1:Show();
		
	end
	
end
