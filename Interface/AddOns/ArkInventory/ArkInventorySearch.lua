local _G = _G
local select = _G.select
local pairs = _G.pairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table


ArkInventory.SearchRebuild = true
ArkInventory.SearchTable = { }

function ArkInventory.Frame_Search_Hide( )
	ARKINV_Search:Hide( )
end
	
function ArkInventory.Frame_Search_Show( )
	ARKINV_Search:Show( )
end

function ArkInventory.Frame_Search_Toggle( )

	if ARKINV_Search:IsVisible( ) then
		ArkInventory.Frame_Search_Hide( )
	else
		ArkInventory.Frame_Search_Show( )
	end
	
end


function ArkInventory.Frame_Search_Paint( )

	local frame = ARKINV_Search
	
	-- frameStrata
	if frame:GetFrameStrata( ) ~= ArkInventory.db.profile.option.frameStrata then
		frame:SetFrameStrata( ArkInventory.db.profile.option.frameStrata )
	end
	
	-- title
	local obj = _G[string.format( "%s%s", frame:GetName( ), "TitleWho" )]
	if obj then
		local t = string.format( "%s: %s %s", ArkInventory.Localise["SEARCH"], ArkInventory.Const.Program.Name, ArkInventory.Global.Version )
		obj:SetText( t )
	end
	
	-- font
	ArkInventory.MediaSetFontFrame( frame )
	
	-- scale
	frame:SetScale( ArkInventory.db.profile.option.ui.search.scale or 1 )
	
	local style, file, size, offset, scale, colour
	
	for _, z in pairs( { frame:GetChildren( ) } ) do
		
		-- background
		local obj = _G[string.format( "%s%s", z:GetName( ), "Background" )]
		if obj then
			style = ArkInventory.db.profile.option.ui.search.background.style or ArkInventory.Const.Texture.BackgroundDefault
			if style == ArkInventory.Const.Texture.BackgroundDefault then
				colour = ArkInventory.db.profile.option.ui.search.background.colour
				obj:SetTexture( colour.r, colour.g, colour.b, colour.a )
			else
				file = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Lib.SharedMedia.MediaType.BACKGROUND, style )
				obj:SetTexture( file )
			end
		end
		
		-- border
		style = ArkInventory.db.profile.option.ui.search.border.style or ArkInventory.Const.Texture.BorderDefault
		file = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Lib.SharedMedia.MediaType.BORDER, style )
		size = ArkInventory.db.profile.option.ui.search.border.size or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].size
		offset = ArkInventory.db.profile.option.ui.search.border.offset or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].offset
		scale = ArkInventory.db.profile.option.ui.search.border.scale or 1
		colour = ArkInventory.db.profile.option.ui.search.border.colour or { }
	
		local obj = _G[string.format( "%s%s", z:GetName( ), "ArkBorder" )]
		if obj then
			if ArkInventory.db.profile.option.ui.search.border.style ~= ArkInventory.Const.Texture.BorderNone then
				ArkInventory.Frame_Border_Paint( obj, false, file, size, offset, scale, colour.r, colour.g, colour.b, 1 )
				obj:Show( )
			else
				obj:Hide( )
			end
		end
		
		for _, c1 in pairs( { z:GetChildren( ) } ) do
			if c1:GetName( ) then
				for _, c2 in pairs( { c1:GetChildren( ) } ) do
					if c2:GetName( ) then
						local obj = _G[string.format( "%s%s", c2:GetName( ), "ArkBorder" )]
						if obj then
							if ArkInventory.db.profile.option.ui.search.border.style ~= ArkInventory.Const.Texture.BorderNone then
								ArkInventory.Frame_Border_Paint( obj, false, file, size, offset, scale, colour.r, colour.g, colour.b, 1 )
								obj:Show( )
							else
								obj:Hide( )
							end
						end
					end
				end
			end
		end
		
	end
	
end

function ArkInventory.Frame_Search_Table_Row_Build( frame )

	local f = frame:GetName( )
	
	local x
	local sz = 18
	
	-- item icon
	x = _G[string.format( "%s%s", f, "T1" )]
	x:ClearAllPoints( )
	x:SetWidth( sz )
	x:SetHeight( sz )
	x:SetPoint( "LEFT", 17, 0 )
	x:Show( )

	-- item name
	x = _G[string.format( "%s%s", f, "C1" )]
	x:ClearAllPoints( )
	x:SetWidth( 250 )
	x:SetPoint( "LEFT", string.format( "%s%s", f, "T1" ), "RIGHT", 12, 0 )
	x:SetPoint( "TOP", 0, 0 )
	x:SetPoint( "BOTTOM", 0, 0 )
	x:SetPoint( "RIGHT", -5, 0 )
	x:SetTextColor( 1, 1, 1, 1 )
	x:SetJustifyH( "LEFT", 0, 0 )
	x:Show( )

	-- Highlight
	x = _G[string.format( "%s%s", f, "Highlight" )]
	x:Hide( )
	
end

function ArkInventory.Frame_Search_Table_Build( frame )
	
	local f = frame:GetName( )

	local maxrows = tonumber( _G[string.format( "%s%s", f, "MaxRows" )]:GetText( ) )
	local rows = maxrows
	local height = 24
	
	if rows > maxrows then rows = maxrows end
	_G[string.format( "%s%s", f, "NumRows" )]:SetText( rows )
	
	if height == 0 then
		height = tonumber( _G[string.format( "%s%s", f, "RowHeight" )]:GetText( ) )
	end
	_G[string.format( "%s%s", f, "RowHeight" )]:SetText( height )

	-- stretch scrollbar to bottom row
	_G[string.format( "%s%s", f, "Scroll" )]:SetPoint( "BOTTOM", string.format( "%s%s%s", f, "Row", rows ), "BOTTOM", 0, 0 )

	-- set frame height to correct size
	_G[f]:SetHeight( height * rows + 20 )

end

function ArkInventory.Frame_Search_Table_Row_OnClick( frame )

	h = _G[string.format( "%s%s", frame:GetName( ), "Id" )]:GetText( )
	if HandleModifiedItemClick( h ) then
		return
	end
	
end

function ArkInventory.Frame_Search_Table_Reset( f )
	
	assert( f and type( f ) == "string" and _G[f], "CODE ERROR: Invalid parameter passed to Frame_Search_Table_Reset( )" )
	
	-- hide and reset all rows
	
	local t = string.format( "%s%s", f, "Table" )
	
	local h = tonumber( _G[string.format( "%s%s", t ,"RowHeight" )]:GetText( ) )
	local r = tonumber( _G[string.format( "%s%s", t, "NumRows" )]:GetText( ) )

	_G[string.format( "%s%s", t, "SelectedRow" )]:SetText( "-1" )
	for x = 1, r do
		_G[string.format( "%s%s%s%s", t, "Row", x, "Selected" )]:Hide( )
		_G[string.format( "%s%s%s%s", t, "Row", x, "Id" )]:SetText( "-1" )
		_G[string.format( "%s%s%s", t, "Row", x )]:Hide( )
		_G[string.format( "%s%s%s", t, "Row", x )]:SetHeight( h )
	end

end

function ArkInventory.Frame_Search_Table_Refresh( frame )
	
	local f = frame:GetParent( ):GetParent( ):GetParent( ):GetName( )
	
	f = string.format( "%s%s", f, "View" )
	
	ArkInventory.Frame_Search_Table_Reset( f )
	
	local filter = _G[string.format( "%s%s", f, "SearchFilter" )]:GetText( )
	--ArkInventory.Output( "filter = [", filter, "]" )
	
	local tt = { }
	ArkInventory.SearchRebuild = false

	local cp = ArkInventory.Global.Me
	
	for p, pd in ArkInventory.spairs( ArkInventory.db.realm.player.data ) do
		
		for l, ld in pairs( pd.location ) do
			
			for b, bd in pairs( ld.bag ) do
			
				for s, sd in pairs( bd.slot ) do
					
					if sd.h then
						
						local item_name = select( 3, ArkInventory.ObjectInfo( sd.h ) ) or ""
						
						if item_name == "" then
							ArkInventory.SearchRebuild = true
						end
						
						local ignore = false
						
						if filter ~= "" and item_name ~= "" then
							if not string.find( string.lower( item_name or "" ), string.lower( filter ) ) then
								ignore = true
							end
						end
						
						if not ignore then
							
							local id = ArkInventory.ObjectIDTooltip( sd.h )
							
							if not tt[id] then
								local t = select( 4, ArkInventory.ObjectInfo( sd.h ) )
								tt[id] = { id = id, sorted = item_name, name = item_name, h = sd.h, q = sd.q, t = t }
							end
							
						end
						
					end
					
				end
				
			end
			
		end
		
	end
	
	ArkInventory.SearchTable = { }
	local c = 0
	
	for _, v in pairs( tt ) do
		c = c + 1
		ArkInventory.SearchTable[c] = v
	end
		
	if #ArkInventory.SearchTable > 0 then
		table.sort( ArkInventory.SearchTable, function( a, b ) return a.sorted < b.sorted end )
		ArkInventory.Frame_Search_Table_Scroll( frame )
	end

end

function ArkInventory.Frame_Search_Table_Scroll( frame )
	
	local f = frame:GetParent( ):GetParent( ):GetParent( ):GetName( )

	f = string.format( "%s%s", f, "View" )
	
	local ft = string.format( "%s%s", f, "Table" )
	local fs = string.format( "%s%s", f, "Search" )

	local height = tonumber( _G[string.format( "%s%s", ft, "RowHeight" )]:GetText( ) )
	local rows = tonumber( _G[string.format( "%s%s", ft, "NumRows" )]:GetText( ) )

	local line
	local lineplusoffset
	
	ArkInventory.Frame_Search_Table_Reset( f )
	
	local tc = #ArkInventory.SearchTable
	
	FauxScrollFrame_Update( _G[string.format( "%s%s", ft, "Scroll" )], tc, rows, height )
	
	local linename, c, r
	
	for line = 1, rows do

		linename = string.format( "%s%s%s", ft, "Row", line )
		
		lineplusoffset = line + FauxScrollFrame_GetOffset( _G[string.format( "%s%s", ft, "Scroll" )] )

		if lineplusoffset <= tc then

			c = ""
			r = ArkInventory.SearchTable[lineplusoffset]
			
			_G[string.format( "%s%s", linename, "Id" )]:SetText( r.h )

			_G[string.format( "%s%s", linename, "T1" )]:SetTexture( r.t )
			
			local cr, cg, cb = GetItemQualityColor( r.q )
			local cc = ArkInventory.ColourRGBtoCode( cr, cg, cb )
			_G[string.format( "%s%s", linename, "C1" )]:SetText( string.format( "%s%s", cc, r.name ) )

			_G[linename]:Show( )
			
		else
		
			_G[string.format( "%s%s", linename, "Id" )]:SetText( "" )
			_G[linename]:Hide( )
			
		end
		
	end

end
