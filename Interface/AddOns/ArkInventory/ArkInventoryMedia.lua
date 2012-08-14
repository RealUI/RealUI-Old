
function ArkInventory.MediaRegister( )
	
	if ArkInventory.Lib.SharedMedia then
		-- all fonts sourced from http://www.fontfreak.com and were specified as freeware, if this is not the case then please let me know and i will remove them from the mod
		
		-- fonts
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.FONT, "Anime Ace", [[Interface\AddOns\ArkInventory\Fonts\animeace.ttf]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.FONT, "Designer Block", [[Interface\AddOns\ArkInventory\Fonts\DESIB___.ttf]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.FONT, "DestructoBeam BB", [[Interface\AddOns\ArkInventory\Fonts\destructobeambb_reg.ttf]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.FONT, "Dreamspeak", [[Interface\AddOns\ArkInventory\Fonts\dfdrsp__.TTF]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.FONT, "Drummon", [[Interface\AddOns\ArkInventory\Fonts\Drummon.ttf]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.FONT, "Dustismo", [[Interface\AddOns\ArkInventory\Fonts\Dustismo.ttf]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.FONT, "Emblem", [[Interface\AddOns\ArkInventory\Fonts\Emblem.ttf]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.FONT, "Electrofied", [[Interface\AddOns\ArkInventory\Fonts\electr.ttf]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.FONT, "SF Diego Sans", [[Interface\AddOns\ArkInventory\Fonts\SF Diego Sans.ttf]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.FONT, "SF Laundromatic", [[Interface\AddOns\ArkInventory\Fonts\SF Laundromatic.ttf]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.FONT, "Zekton", [[Interface\AddOns\ArkInventory\Fonts\zekton__.ttf]] )
		
		-- borders
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.BORDER, "ArkInventory Square 1", [[Interface\AddOns\ArkInventory\Images\BorderSquare1.tga]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.BORDER, "ArkInventory Square 2", [[Interface\AddOns\ArkInventory\Images\BorderSquare2.tga]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.BORDER, "ArkInventory Square 3", [[Interface\AddOns\ArkInventory\Images\BorderSquare3.tga]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.BORDER, "ArkInventory Tooltip 1", [[Interface\AddOns\ArkInventory\Images\BorderTooltip1.tga]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.BORDER, "ArkInventory Tooltip 2", [[Interface\AddOns\ArkInventory\Images\BorderTooltip2.tga]] )
		ArkInventory.Lib.SharedMedia:Register( ArkInventory.Lib.SharedMedia.MediaType.BORDER, "ArkInventory Tooltip 3", [[Interface\AddOns\ArkInventory\Images\BorderTooltip3.tga]] )
		
		
		-- backgrounds
		--lib.MediaType.BACKGROUND
		
		--refresh media if more are added after mod is loaded
		ArkInventory.Lib.SharedMedia.RegisterCallback( ArkInventory, "LibSharedMedia_Registered", "MediaUpdate" )
		ArkInventory.Lib.SharedMedia.RegisterCallback( ArkInventory, "LibSharedMedia_SetGlobal", "MediaUpdate" )
		
	else
		
		ArkInventory.OutputWarning( "LibSharedMedia not loaded, unable to register shared media" )
		
	end
	
end

function ArkInventory.MediaSetFontFace( obj, fontName )
	
	local fontName = fontName
	
	if obj == nil or not ( obj["GetFont"] and obj["SetFont"] ) then
		return
	end
	
	if fontName == nil or fontName == "" then
		fontName = ArkInventory.db.profile.option.font.name or ArkInventory.Const.Font.Face
	end
	
	local fontPath = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Lib.SharedMedia.MediaType.FONT, fontName )
	
	local oldPath, oldSize, oldFlags = obj:GetFont( )
	if ( oldPath == fontPath ) or not ( oldSize == oldSize ) then
		return
	end
	
	oldSize = math.floor( ( oldSize or 0 ) + 0.5 )
	if oldSize < 1 or oldSize > 1024 then
		return
	end
	
	obj:SetFont( fontPath, oldSize, oldFlags )
	
end

function ArkInventory.MediaSetFontFrame( frame, fontName )

	if frame ~= nil and type( frame ) == "string" then
		frame = _G[frame]
	end
	
	if frame == nil then
		return
	end
	
	for _, obj in pairs( { frame:GetRegions( ) } ) do
		ArkInventory.MediaSetFontFace( obj, fontName )
	end

	for _, obj in pairs( { frame:GetChildren( ) } ) do
		ArkInventory.MediaSetFontFace( obj, fontName )
	end

	for _, obj in pairs( { frame:GetChildren( ) } ) do
		ArkInventory.MediaSetFontFrame( obj, fontName )
	end
	
end

function ArkInventory.MediaUpdate( )
	ArkInventory.Frame_Main_Paint_All( )
	ArkInventory.MediaSetFontAll( )
end

function ArkInventory.MediaSetFontAll( fontName )
	
	if fontName ~= nil and fontName ~= ArkInventory.db.profile.option.font.name then
		ArkInventory.db.profile.option.font.name = fontName
	end
	
	for z in pairs( ArkInventory.Global.Location ) do
		local frame = _G[string.format( "%s%s", ArkInventory.Const.Frame.Main.Name, z )]
		ArkInventory.MediaSetFontFrame( frame, fontName )
	end
	
	ArkInventory.MediaSetFontFrame( ARKINV_Search, fontName )
	ArkInventory.MediaSetFontFrame( ARKINV_Rules, fontName )
	
end
