	
ArkInventory.Const.MoneyTypeInfo = { }

ArkInventory.Const.MoneyTypeInfo["PLAYER"] = {

	OnloadFunc = function( moneyFrame )
	
		assert( moneyFrame, "code error: moneyFrame argument is missing" )
		
		moneyFrame.events = { "PLAYER_MONEY", "PLAYER_TRADE_MONEY", "SEND_MAIL_MONEY_CHANGED", "SEND_MAIL_COD_CHANGED" }
		for _, v in pairs( moneyFrame.events ) do
			moneyFrame:RegisterEvent( v )
		end

	end,

	UpdateFunc = function( )
		return GetMoney( ) - GetCursorMoney( ) - GetPlayerTradeMoney( )
	end,

	PickupFunc = function( amount )
		PickupPlayerMoney( amount )
	end,

	DropFunc = function( )
		DropCursorMoney( )
	end,

	collapse = 1,
	canPickup = 1,
	showSmallerCoins = "Backpack"

}

ArkInventory.Const.MoneyTypeInfo["STATIC"] = {

	OnloadFunc = function( moneyFrame )
	
		assert( moneyFrame, "code error: moneyFrame argument is missing" )

		moneyFrame.events = { }
		
	end,

	UpdateFunc = function( moneyFrame )
		return moneyFrame.staticMoney
	end,

	collapse = 1,
	
}

ArkInventory.Const.MoneyTypeInfo["GUILDBANK"] = {

	OnloadFunc = function( moneyFrame )
	
		assert( moneyFrame, "code error: moneyFrame argument is missing" )

		moneyFrame.events = { "GUILDBANK_UPDATE_MONEY" }
		for _, v in pairs( moneyFrame.events ) do
			moneyFrame:RegisterEvent( v )
		end
		
	end,

	UpdateFunc = function( )
		return GetGuildBankMoney( ) - GetCursorMoney( )
	end,

	PickupFunc = function( amount )
		PickupGuildBankMoney( amount )
	end,

	DropFunc = function( )
		DropCursorMoney( )
	end,

	collapse = 1,
	
}

ArkInventory.Const.MoneyTypeInfo["GUILDBANK_WITHDRAW"] = {

	OnloadFunc = function( moneyFrame )
	
		assert( moneyFrame, "code error: moneyFrame argument is missing" )
		
		moneyFrame.events = { "GUILDBANK_UPDATE_WITHDRAWMONEY" }
		for _, v in pairs( moneyFrame.events ) do
			moneyFrame:RegisterEvent( v )
		end

	end,
	
	UpdateFunc = function( )
		
		local amount = 0
		
		if CanWithdrawGuildBankMoney( ) or CanGuildBankRepair() then
			amount = min( GetGuildBankMoney( ),  GetGuildBankWithdrawMoney( ) )
			if amount < 0 then
				amount = GetGuildBankMoney( )
			end
		end
		
		return amount
		
	end,

	collapse = 1,
	showSmallerCoins = "Backpack",
	
}

ArkInventory.Const.MoneyTypeInfo["GUILDBANK_REPAIR"] = {

	OnloadFunc = function( moneyFrame )
	
		assert( moneyFrame, "code error: moneyFrame argument is missing" )
		
		moneyFrame.events = { }
		for _, v in pairs( moneyFrame.events ) do
			moneyFrame:RegisterEvent( v )
		end

	end,

	UpdateFunc = function( moneyFrame )

		assert( moneyFrame, "code error: moneyFrame argument is missing" )

		return moneyFrame.staticMoney
		
	end,

	collapse = 1,
	showSmallerCoins = "Backpack",
	
}

ArkInventory.Const.MoneyTypeInfo["AUCTION"] = {

	OnloadFunc = function( moneyFrame )
	
		assert( moneyFrame, "code error: moneyFrame argument is missing" )
		
		moneyFrame.events = { }
		for _, v in pairs( moneyFrame.events ) do
			moneyFrame:RegisterEvent( v )
		end

	end,

	UpdateFunc = function( moneyFrame )
	
		assert( moneyFrame, "code error: moneyFrame argument is missing" )

		return moneyFrame.staticMoney
		
	end,
	
	showSmallerCoins = "Backpack",
	fixedWidth = 1,
	collapse = 1,
	truncateSmallCoins = nil,
	
}

ArkInventory.Const.MoneyTypeInfo["PLAYER_TRADE"] = {

	OnloadFunc = function( moneyFrame )
	
		assert( moneyFrame, "code error: moneyFrame argument is missing" )
		
		moneyFrame.events = { "PLAYER_TRADE_MONEY" }
		for _, v in pairs( moneyFrame.events ) do
			moneyFrame:RegisterEvent( v )
		end

	end,

	UpdateFunc = function( )
		return GetPlayerTradeMoney( )
	end,

	PickupFunc = function( amount )
		PickupTradeMoney( amount )
	end,

	DropFunc = function( )
		AddTradeMoney( )
	end,

	collapse = 1,
	canPickup = 1,
	
}

ArkInventory.Const.MoneyTypeInfo["TARGET_TRADE"] = {

	OnloadFunc = function( moneyFrame )
	
		assert( moneyFrame, "code error: moneyFrame argument is missing" )
		
		moneyFrame.events = { "TRADE_MONEY_CHANGED" }
		for _, v in pairs( moneyFrame.events ) do
			moneyFrame:RegisterEvent( v )
		end

	end,

	UpdateFunc = function( )
		return GetTargetTradeMoney( )
	end,

	collapse = 1,
	
}

ArkInventory.Const.MoneyTypeInfo["SEND_MAIL"] = {

	OnloadFunc = function( moneyFrame )
	
		assert( moneyFrame, "code error: moneyFrame argument is missing" )
		
		moneyFrame.events = { "SEND_MAIL_MONEY_CHANGED" }
		for _, v in pairs( moneyFrame.events ) do
			moneyFrame:RegisterEvent( v )
		end

	end,

	UpdateFunc = function( )
		return GetSendMailMoney( )
	end,

	PickupFunc = function( amount )
		PickupSendMailMoney( amount )
	end,

	DropFunc = function( )
		AddSendMailMoney( )
	end,

	collapse = nil,
	canPickup = 1,
	showSmallerCoins = "Backpack",
	
}

ArkInventory.Const.MoneyTypeInfo["SEND_MAIL_COD"] = {
	
	OnloadFunc = function( moneyFrame )
	
		assert( moneyFrame, "code error: moneyFrame argument is missing" )
		
		moneyFrame.events = { "SEND_MAIL_COD_CHANGED" }
		for _, v in pairs( moneyFrame.events ) do
			moneyFrame:RegisterEvent( v )
		end

	end,

	UpdateFunc = function( )
		return GetSendMailCOD( )
	end,

	PickupFunc = function( amount )
		PickupSendMailCOD( amount )
	end,

	DropFunc = function( )
		AddSendMailCOD( )
	end,

	collapse = 1,
	canPickup = 1,
	
}

function ArkInventory.MoneyFrame_OnEvent( moneyFrame, event, ... )

	assert( moneyFrame, "code error: moneyFrame argument is missing" )

	if not moneyFrame.info or not moneyFrame:IsVisible( ) then
		return
	end

	ArkInventory.MoneyFrame_UpdateMoney( moneyFrame )
	
end

function ArkInventory.MoneyFrame_OnEnter( moneyFrame )
	
	assert( moneyFrame, "code error: moneyFrame argument is missing" )
	
	if not moneyFrame:IsVisible( ) then
		return
	end
	
	local x, a, b
	
	x = moneyFrame:GetBottom( ) + ( moneyFrame:GetTop( ) - moneyFrame:GetBottom( ) ) / 2
	if ( x >= ( GetScreenHeight( ) / 2 ) ) then
		a = "BOTTOM"
	else
		a = "TOP"
	end

	x = moneyFrame:GetLeft( ) + ( moneyFrame:GetRight( ) - moneyFrame:GetLeft( ) ) / 2
	if ( x >= ( GetScreenWidth( ) / 2 ) ) then
		b = "RIGHT"
	else
		b = "LEFT"
	end

	GameTooltip:SetOwner( moneyFrame, string.format( "ANCHOR_%s", a ) )
	GameTooltip:ClearLines( )
	
	ArkInventory.MoneyFrame_Tooltip( GameTooltip )
	
	GameTooltip:Show( )
	
end

function ArkInventory.SmallMoneyFrame_OnLoad( moneyFrame, moneyType )

	assert( moneyFrame, "code error: moneyFrame argument is missing" )
	
	local moneyType = moneyType or "PLAYER"
	moneyFrame.small = 1
	
	ArkInventory.MoneyFrame_SetType( moneyFrame, moneyType )
	
end

function ArkInventory.MoneyFrame_SetType( moneyFrame, moneyType )
	
	assert( moneyFrame, "code error: moneyFrame argument is missing" )
	
	local info = ArkInventory.Const.MoneyTypeInfo[moneyType]
	if not info then
		ArkInventory.Output( "invalid moneyType [", moneyType, "] assigned to frame [", moneyFrame:GetName( ), "], deafulting to PLAYER" )
		info = ArkInventory.Const.MoneyTypeInfo["PLAYER"]
	end
	
	if moneyFrame.events then
		-- this money frame has already been used for something else, clean it up
		moneyFrame:UnregisterAllEvents( )
		moneyFrame.events = nil
	end

	moneyFrame.info = info
	moneyFrame.moneyType = moneyType
	
	-- register the events required
	if info.OnloadFunc then
		info.OnloadFunc( moneyFrame )
	end
	
	local frameName = moneyFrame:GetName( )
	if info.canPickup then
		_G[string.format( "%s%s", frameName, "GoldButton" )]:EnableMouse( true )
		_G[string.format( "%s%s", frameName, "SilverButton" )]:EnableMouse( true )
		_G[string.format( "%s%s", frameName, "CopperButton" )]:EnableMouse( true )
	else
		_G[string.format( "%s%s", frameName, "GoldButton" )]:EnableMouse( false )
		_G[string.format( "%s%s", frameName, "SilverButton" )]:EnableMouse( false )
		_G[string.format( "%s%s", frameName, "CopperButton" )]:EnableMouse( false )
	end

	ArkInventory.MoneyFrame_UpdateMoney( moneyFrame )
	
end

function ArkInventory.MoneyFrame_UpdateMoney( moneyFrame )

	assert( moneyFrame, "code error: moneyFrame argument is missing" )
	
	if not moneyFrame:IsVisible( ) then
		return
	end
	
	if moneyFrame.info then
		
		local moneyAmount = moneyFrame.info.UpdateFunc( moneyFrame )
		
		if moneyAmount then
			MoneyFrame_Update( moneyFrame:GetName( ), moneyAmount )
		end
		
		if moneyFrame.hasPickup == 1 then
			UpdateCoinPickupFrame( moneyAmount )
		end
		
	else
		
		ArkInventory.OutputError( "moneyType not set for moneyFrame [", moneyFrame:GetName( ), "]" )
		
	end
	
end

function ArkInventory.MoneyText( money )
	
	local money = money or 0
	local colorblindMode = GetCVarBool( "colorblindMode" )
	
	local moneyGold = floor( money / COPPER_PER_GOLD )
	local moneySilver = floor( ( money - ( moneyGold * COPPER_PER_GOLD ) ) / COPPER_PER_SILVER )
	local moneyCopper = mod( money, COPPER_PER_SILVER )
	
	local moneyText = ""
	
	if moneyGold > 0 then
		if colorblindMode then
			moneyText = string.format( "%d%s", moneyGold, GOLD_AMOUNT_SYMBOL )
		else
			--|cffffd100%s|r
			moneyText = string.format( "%s", string.format( GOLD_AMOUNT_TEXTURE, moneyGold, 0, 0 ) )
		end
	end

--	if moneySilver > 0 or ( moneyGold > 0 and moneyCopper > 0 ) then
		if moneyGold > 0 then
			if colorblindMode then
				moneyText = string.format( "%s %02d%s", moneyText, moneySilver, SILVER_AMOUNT_SYMBOL )
			else
				local SILVER_AMOUNT_TEXTURE = string.gsub( SILVER_AMOUNT_TEXTURE, "%%d", "%%02d", 1 )
				--|cffe6e6e6%s|r
				moneyText = string.format( "%s %s", moneyText, string.format( SILVER_AMOUNT_TEXTURE, moneySilver, 0, 0 ) )
			end
		else
			if colorblindMode then
				moneyText = string.format( "%d%s", moneySilver, SILVER_AMOUNT_SYMBOL )
			else
				moneyText = string.format( SILVER_AMOUNT_TEXTURE, moneySilver, 0, 0 )
			end
		end
--	end
	
--	if moneyCopper > 0 then
		if moneySilver > 0 or moneyGold > 0 then
			if colorblindMode then
				moneyText = string.format( "%s %02d%s", moneyText, moneyCopper, COPPER_AMOUNT_SYMBOL )
			else
				local COPPER_AMOUNT_TEXTURE = string.gsub( COPPER_AMOUNT_TEXTURE, "%%d", "%%02d", 1 )
				--|cffc8602c%s|r
				moneyText = string.format( "%s %s", moneyText, string.format( COPPER_AMOUNT_TEXTURE, moneyCopper, 0, 0 ) )
			end
		else
			if colorblindMode then
				moneyText = string.format( "%d%s", moneyCopper, COPPER_AMOUNT_SYMBOL )
			else
				moneyText = string.format( "%s", string.format( COPPER_AMOUNT_TEXTURE, moneyCopper, 0, 0 ) )
			end
		end
--	end
	
	return string.trim( moneyText )

end

function ArkInventory.MoneyFrame_Tooltip( tooltip )
	
	if not tooltip then return end
	
	local total = 0
	local paint = ArkInventory.db.global.option.tooltip.colour.class
	
	local player = UnitName( "player" )
	local f = UnitFactionGroup( "player" )
	
	tooltip:AddDoubleLine( "Character", "Amount" )
	for pn, pd in ArkInventory.spairs( ArkInventory.db.realm.player.data ) do
		
		if pd.info.name and pd.info.faction and string.sub( pn, 1, 1 ) ~= ArkInventory.Const.GuildTag then
			
			if ( not ArkInventory.db.global.option.tooltip.faction ) or ( ArkInventory.db.global.option.tooltip.faction and f == pd.info.faction ) then
				
				if ( not ArkInventory.db.global.option.tooltip.me ) or ( ArkInventory.db.global.option.tooltip.me and pn == player ) then
					
					total = total + ( pd.info.money or 0 )
					
					local name = pd.info.name
					if paint then
						name = ArkInventory.DisplayName3( pd.info )
					end
					
					if pd.info.faction ~= f then
						name = string.format( "%s |cff7f7f7f[%s]|r", name, pd.info.faction )
					end
					
					ArkInventory.TooltipSetMoneyText( tooltip, pd.info.money or 0, name )
				
				end
				
			end
			
		end
		
	end
	
	tooltip:AddDoubleLine( " ", " " )
	ArkInventory.TooltipSetMoneyText( tooltip, total, "Total" )
	
	total = 0
	
	
	
	if not ArkInventory.db.global.option.tooltip.me and ArkInventory.db.global.option.tooltip.add.vault then
		
		for n in pairs( ArkInventory.db.realm.player.data ) do
			if string.sub( n, 1, 1 ) == ArkInventory.Const.GuildTag then
				total = 1
			end
		end
		
		if total > 0 then
			
			tooltip:AddDoubleLine( " ", " " )
			tooltip:AddDoubleLine( " ", " " )
			
			tooltip:AddDoubleLine( ArkInventory.Global.Location[ArkInventory.Const.Location.Vault].Name, "Amount" )
			
			for pn, pd in ArkInventory.spairs( ArkInventory.db.realm.player.data ) do
				
				if pd.info.name and pd.info.faction then
					
					if ( not ArkInventory.db.global.option.tooltip.faction ) or ( ArkInventory.db.global.option.tooltip.faction and f == pd.info.faction ) then
						
						if ( not ArkInventory.db.global.option.tooltip.me ) or ( ArkInventory.db.global.option.tooltip.me and pn == player ) then
							
							if string.sub( pn, 1, 1 ) == ArkInventory.Const.GuildTag then
								
								local name = pd.info.name
								if paint then
									name = ArkInventory.DisplayName3( pd.info )
								end
								
								ArkInventory.TooltipSetMoneyText( tooltip, pd.info.money or 0, name )
								
							end
							
						end
						
					end
					
				end
				
			end
			
		end
		
	end
	
end
