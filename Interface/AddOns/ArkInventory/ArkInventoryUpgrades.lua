
function ArkInventory.CategoryRenumber( cat_old, cat_new )
	
	-- fix hard coded item assignments
	for k, v in pairs( ArkInventory.db.profile.option.category ) do
		if v == cat_old then
			ArkInventory.db.profile.option.category[k] = cat_new
		end
	end
	
end

function ArkInventory.ConvertOldOptions( )
	
	--ArkInventory.Output( LIGHTYELLOW_FONT_COLOR_CODE, "ConvertOldOptions" )
	
	local upgrade_version = 0

	if not ArkInventory.db.profile.option["version"] then
		ArkInventory.db.profile.option["version"] = upgrade_version
	end
	
	
	upgrade_version = 3.00
	if ArkInventory.db.profile.option.version < upgrade_version then
	
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_PROFILE"], ArkInventory.db:GetCurrentProfile( ), upgrade_version ) )
	
		ArkInventory.db.global.cache = nil
		
		for k, v in pairs( ArkInventory.db.profile.option.category ) do
			if type( v ) == "number" then
				ArkInventory.db.profile.option.category[k] = ArkInventory.CategoryCodeJoin( ArkInventory.Const.Category.Type.System, abs( v ) )
			end
		end
		
		local t
		for _, loc in pairs( ArkInventory.db.profile.option.location ) do
		
			t = { }
			
			for k, v in pairs( loc.category ) do
				if type( k ) == "number" then
					if k < 0 then
						local id = ArkInventory.CategoryCodeJoin( ArkInventory.Const.Category.Type.System, abs( k ) )
						t[id] = v
					else
						local id = ArkInventory.CategoryCodeJoin( ArkInventory.Const.Category.Type.Rule, k )
						t[id] = v
					end
					loc.category[k] = nil
				end
			end
			
			for k, v in pairs( t ) do
				loc.category[k] = v
			end
			
		end
		
		
		ArkInventory.db.profile.option.version = upgrade_version

	end

	if ArkInventory.db.global.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "rule", upgrade_version ) )
		
		if ArkInventory.db.global.option.rule then
			
			for k, v in pairs( ArkInventory.db.global.option.rule ) do
				ArkInventory.db.global.option.category[ArkInventory.Const.Category.Type.Rule].data[k] = v
				ArkInventory.db.global.option.rule[k] = nil
			end
			
			ArkInventory.db.global.option.category[ArkInventory.Const.Category.Type.Rule].next = ArkInventory.db.global.option.nextrule
			ArkInventory.db.global.option.nextrule = nil
			
		end
		
		ArkInventory.db.global.option.version = upgrade_version
		
	end
	
	
	upgrade_version = 3.0005
	if ArkInventory.db.global.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "option", upgrade_version ) )
		
		if ArkInventory.db.global.option.bugfix_alert_framelevel then
			ArkInventory.db.global.option.bugfix.alert = ArkInventory.db.global.option.bugfix_alert_framelevel
		end
		
		
		ArkInventory.db.global.option.version = upgrade_version
		
	end
	
	
	upgrade_version = 3.0201
	if ArkInventory.db.profile.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_PROFILE"], ArkInventory.db:GetCurrentProfile( ), upgrade_version ) )
		
		-- fix categories, need to add class
		if ArkInventory.db.profile.option.category then
			
			local t = { }
			
			for k, v in pairs( ArkInventory.db.profile.option.category ) do
				
				local sb, id = strsplit( ":", k )
				id = tonumber( id ) or 0
				sb = tonumber( sb ) or 0
				if sb > 20 then
					local z = sb
					sb = id
					id = z
				end
				
				local class = "item"
				if id == 0 then
					class = "empty"
				end
				
				local cid = string.format( "%s:%s:%s", class, id, sb )
				--ArkInventory.OutputDebug( "k=[", k, "], id=[", id, "], sb=[", sb, "], cid=[", cid, "] / [", v, "]" )
				t[cid] = v
				
			end
			
			ArkInventory.db.profile.option.category = t
			
		end
		
		ArkInventory.db.profile.option.version = upgrade_version
		
	end
	
	
	upgrade_version = 3.0211
	if ArkInventory.db.realm.player.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "player", upgrade_version ) )
		
		ArkInventory.db.global.player = nil
		
		for n in pairs( ArkInventory.db.realm.player.data ) do
			if string.match( n, "!" ) then
				ArkInventory.db.realm.player.data[n] = nil
			end
		end
		
		ArkInventory.db.realm.player.version = upgrade_version
		
	end
	
	
	upgrade_version = 3.0219
	if ArkInventory.db.realm.player.version < upgrade_version then
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "player", upgrade_version ) )
		ArkInventory.EraseSavedData( )
		ArkInventory.db.realm.player.version = upgrade_version
	end
	
	
	upgrade_version = 3.0223
	if ArkInventory.db.global.option.version < upgrade_version then
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "player", upgrade_version ) )
		ArkInventory.db.global.option.tooltip.scale = { enabled = false, amount = 1 }
		ArkInventory.db.global.option.version = upgrade_version
	end
	
	
	upgrade_version = 3.0230
	if ArkInventory.db.global.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "categories and rules", upgrade_version ) )
		
		local cat, cat_old
		
		cat = ArkInventory.db.global.option.sort.data
		for k in pairs( cat ) do
			cat[k].used = true
		end
		
		
		cat_old = ArkInventory.db.global.option.category[ArkInventory.Const.Category.Type.Custom].data
		ArkInventory.db.global.option.category[ArkInventory.Const.Category.Type.Custom].data = { }
		cat = ArkInventory.db.global.option.category[ArkInventory.Const.Category.Type.Custom].data
		for k, v in pairs( cat_old ) do
			if v then
				cat[k] = { used = true, name = v }
			else
				cat[k] = { used = false, name = "" }
			end
		end
		
		cat = ArkInventory.db.global.option.category[ArkInventory.Const.Category.Type.Rule].data
		for k, v in pairs( cat ) do
			if v then
				cat[k].used = true
			else
				cat[k] = { used = false, name = "" }
			end
		end
		
		ArkInventory.db.global.option.version = upgrade_version
		
	end
	
	if ArkInventory.db.profile.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_PROFILE"], ArkInventory.db:GetCurrentProfile( ), upgrade_version ) )
		
		ArkInventory.OutputWarning( "The sort order for each location has been reset to bag/slot as it couldnt be automatically transferred. You will need to create an equivalent sort method (via the config menu) to what you had and apply that to each location" )
		
		for _, v in pairs( ArkInventory.db.profile.option.location or { } ) do
			
			if v.window then
			
				if v.window.border then
					v.window.border.style = ArkInventory.Const.Texture.BorderDefault
					v.window.border.size = nil
					v.window.border.offset = nil
					v.window.border.scale = 1
					v.window.border.file = nil
				end
				
				if v.window.colour then
				
					if v.window.colour.border then
						v.window.border.colour.r = v.window.colour.border.r  or v.window.border.colour.r
						v.window.border.colour.g = v.window.colour.border.g or v.window.border.colour.g
						v.window.border.colour.b = v.window.colour.border.b or v.window.border.colour.b
						v.window.colour.border = nil
					end
					
					if v.window.colour.background then
						v.window.background.colour.r = v.window.colour.background.r or v.window.background.colour.r
						v.window.background.colour.g = v.window.colour.background.g or v.window.background.colour.g
						v.window.background.colour.b = v.window.colour.background.b or v.window.background.colour.b
						v.window.background.colour.a = v.window.colour.background.a or v.window.background.colour.a
						v.window.colour.background = nil
					end
					
					if v.window.colour.baghighlight then
						v.changer.highlight.colour.r = v.window.colour.baghighlight.r or v.changer.highlight.colour.r
						v.changer.highlight.colour.g = v.window.colour.baghighlight.g or v.changer.highlight.colour.g
						v.changer.highlight.colour.b = v.window.colour.baghighlight.b or v.changer.highlight.colour.b
						v.window.colour.baghighlight = nil
					end
				
				end
				
				v.window.colour = nil
				
			end
			
			if v.bar then
				
				if v.bar.name and v.bar.name.label then
					for id, label in pairs( v.bar.name.label ) do
						v.bar.data[id].label = label
					end
					v.bar.name.label = nil
				end
				
				if v.bar.border then
					v.bar.border.style = ArkInventory.Const.Texture.BorderDefault
					v.bar.border.size = nil
					v.bar.border.offset = nil
					v.bar.border.scale = 1
					v.bar.border.file = nil
				end
			
				if v.bar.colour then
					
					if v.bar.colour.border then
						v.bar.border.colour.r = v.bar.colour.border.r or v.bar.border.colour.r
						v.bar.border.colour.g = v.bar.colour.border.g or v.bar.border.colour.g
						v.bar.border.colour.b = v.bar.colour.border.b or v.bar.border.colour.b
						v.bar.colour.border = nil
					end
					
					if v.bar.colour.background then
						v.bar.background.colour.r =  v.bar.colour.background.r or v.bar.background.colour.r
						v.bar.background.colour.g = v.bar.colour.background.g or v.bar.background.colour.g
						v.bar.background.colour.b = v.bar.colour.background.b or v.bar.background.colour.b
						v.bar.background.colour.a = v.bar.colour.background.a or v.bar.background.colour.a
						v.bar.colour.background = nil
					end
				
				end
				
				v.bar.colour = nil
				
			end
			
			if v.slot then
			
				if v.slot.border then
					v.slot.border.style = ArkInventory.Const.Texture.BorderDefault
					v.slot.border.size = nil
					v.slot.border.offset = nil
					v.slot.border.scale = 1
					v.slot.border.file = nil
				end
			
			
				if v.slot.empty then
					
					if v.slot.empty.colour then
						v.changer.freespace.colour.r = v.slot.empty.colour.r or v.changer.freespace.colour.r
						v.changer.freespace.colour.g = v.slot.empty.colour.g or v.changer.freespace.colour.g
						v.changer.freespace.colour.g = v.slot.empty.colour.b or v.changer.freespace.colour.b
						v.slot.empty.colour = nil
					end
			
					v.slot.empty.display = nil
					v.slot.empty.show = nil
					
				end
			
			end
			
			v.sortorder = nil
			
			wipe( v.sort )
			v.sort.open = false
			v.sort.instant = false
			v.sort.default = 0
			
		end
		
		if ArkInventory.db.profile.option.ui then
			
			if ArkInventory.db.profile.option.ui.search then
				
				if ArkInventory.db.profile.option.ui.search.border then
					ArkInventory.db.profile.option.ui.search.border.style = ArkInventory.Const.Texture.BorderDefault
					ArkInventory.db.profile.option.ui.search.border.size = nil
					ArkInventory.db.profile.option.ui.search.border.offset = nil
					ArkInventory.db.profile.option.ui.search.border.scale = 1
					ArkInventory.db.profile.option.ui.search.border.file = nil
				end

				if ArkInventory.db.profile.option.ui.search.colour then
					
					if ArkInventory.db.profile.option.ui.search.colour.border then
						ArkInventory.db.profile.option.ui.search.border.colour.r = ArkInventory.db.profile.option.ui.search.colour.border.r or ArkInventory.db.profile.option.ui.search.border.colour.r
						ArkInventory.db.profile.option.ui.search.border.colour.g = ArkInventory.db.profile.option.ui.search.colour.border.g or ArkInventory.db.profile.option.ui.search.border.colour.g
						ArkInventory.db.profile.option.ui.search.border.colour.b = ArkInventory.db.profile.option.ui.search.colour.border.b or ArkInventory.db.profile.option.ui.search.border.colour.b
						ArkInventory.db.profile.option.ui.search.colour.border = nil
					end
					
					if ArkInventory.db.profile.option.ui.search.colour.background then
						ArkInventory.db.profile.option.ui.search.background.colour.r = ArkInventory.db.profile.option.ui.search.colour.background.r or ArkInventory.db.profile.option.ui.search.background.colour.r
						ArkInventory.db.profile.option.ui.search.background.colour.g = ArkInventory.db.profile.option.ui.search.colour.background.g or ArkInventory.db.profile.option.ui.search.background.colour.g
						ArkInventory.db.profile.option.ui.search.background.colour.b = ArkInventory.db.profile.option.ui.search.colour.background.b or ArkInventory.db.profile.option.ui.search.background.colour.b
						ArkInventory.db.profile.option.ui.search.background.colour.a = ArkInventory.db.profile.option.ui.search.colour.background.a or ArkInventory.db.profile.option.ui.search.background.colour.a
						ArkInventory.db.profile.option.ui.search.colour.background = nil
					end
					
				end
				
			end
		
			if ArkInventory.db.profile.option.ui.rules then
			
				if ArkInventory.db.profile.option.ui.rules.border then
					ArkInventory.db.profile.option.ui.rules.border.style = ArkInventory.Const.Texture.BorderDefault
					ArkInventory.db.profile.option.ui.rules.border.size = nil
					ArkInventory.db.profile.option.ui.rules.border.offset = nil
					ArkInventory.db.profile.option.ui.rules.border.scale = 1
					ArkInventory.db.profile.option.ui.rules.border.file = nil
				end
				
				if ArkInventory.db.profile.option.ui.rules.colour then
					
					if ArkInventory.db.profile.option.ui.rules.colour.border then
						ArkInventory.db.profile.option.ui.rules.border.colour.r = ArkInventory.db.profile.option.ui.rules.colour.border.r or ArkInventory.db.profile.option.ui.rules.border.colour.r
						ArkInventory.db.profile.option.ui.rules.border.colour.g = ArkInventory.db.profile.option.ui.rules.colour.border.g or ArkInventory.db.profile.option.ui.rules.border.colour.g
						ArkInventory.db.profile.option.ui.rules.border.colour.b = ArkInventory.db.profile.option.ui.rules.colour.border.b or ArkInventory.db.profile.option.ui.rules.border.colour.b
						ArkInventory.db.profile.option.ui.rules.colour.border = nil
					end
				
					if ArkInventory.db.profile.option.ui.rules.colour.background then
						ArkInventory.db.profile.option.ui.rules.background.colour.r = ArkInventory.db.profile.option.ui.rules.colour.background.r or ArkInventory.db.profile.option.ui.rules.background.colour.r
						ArkInventory.db.profile.option.ui.rules.background.colour.g = ArkInventory.db.profile.option.ui.rules.colour.background.g or ArkInventory.db.profile.option.ui.rules.background.colour.g
						ArkInventory.db.profile.option.ui.rules.background.colour.b = ArkInventory.db.profile.option.ui.rules.colour.background.b or ArkInventory.db.profile.option.ui.rules.background.colour.b
						ArkInventory.db.profile.option.ui.rules.background.colour.a = ArkInventory.db.profile.option.ui.rules.colour.background.a or ArkInventory.db.profile.option.ui.rules.background.colour.a
						ArkInventory.db.profile.option.ui.rules.colour.background = nil
					end
						
				end
				
			end
			
		end
		
		ArkInventory.OutputWarning( "The border styles for each location have been reset to Blizzard Tooltip (default), the colour was able to be kept though" )
		
		ArkInventory.db.profile.option.version = upgrade_version
		
	end
	
	if ArkInventory.db.char.option.version < upgrade_version then
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_CHAR"], UnitName( "player" ), upgrade_version ) )
		ArkInventory.db.char.option.ldb.mounts.track = nil
		ArkInventory.db.char.option.version = upgrade_version
	end
	
	
	upgrade_version = 3.0233
	if ArkInventory.db.global.option.version < upgrade_version then
		
		-- beta fix
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "categories", upgrade_version ) )
		
		local cat = ArkInventory.db.global.option.category[ArkInventory.Const.Category.Type.Custom].data
		for k, v in pairs( cat ) do
			
			local z = v.name
			
			while true do
				if type( z ) == "table" then
					z = z.name or "unknown"
				else
					break
				end
			end
				
			v.name = z
			
		end
		
		ArkInventory.db.global.option.version = upgrade_version
		
	end
	
	
	upgrade_version = 3.0237
	if ArkInventory.db.global.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "", upgrade_version ) )
		
		if ArkInventory.db.global.option.bugfix then
			
			if ArkInventory.db.global.option.bugfix.enable then
				ArkInventory.db.global.option.bugfix.framelevel.enable = ArkInventory.db.global.option.bugfix.enable
				ArkInventory.db.global.option.bugfix.enable = nil
			end
			
			ArkInventory.db.global.option.bugfix.framelevel.alert = 0
			ArkInventory.db.global.option.bugfix.alert = nil
			
		end
		
		ArkInventory.db.global.option.bugfix.zerosizebag.alert = true
		
		
		ArkInventory.db.global.option.version = upgrade_version
		
	end
	

	upgrade_version = 3.0240
	if ArkInventory.db.profile.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_PROFILE"], ArkInventory.db:GetCurrentProfile( ), upgrade_version ) )
		
		for _, loc in pairs( ArkInventory.db.profile.option.location ) do
			
			if loc.framehide then
				
				loc.title.hide = not not loc.framehide.header
				loc.search.hide = not not loc.framehide.search
				loc.status.hide = not not loc.framehide.status
				loc.changer.hide = not not loc.framehide.changer
				
				loc.framehide = nil
				
			end
			
		end
		
		
		ArkInventory.db.profile.option.version = upgrade_version
		
	end
	
	
	
	
	upgrade_version = 3.0248
	if ArkInventory.db.realm.player.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "player", upgrade_version ) )
		ArkInventory.EraseSavedData( )
		
		ArkInventory.db.realm.player.version = upgrade_version
		
	end
	
	if ArkInventory.db.char.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_CHAR"], UnitName( "player" ), upgrade_version ) )
		
		if ArkInventory.db.char.option.ldb.currency and ArkInventory.db.char.option.ldb.currency.tracked then
			for k, v in pairs( ArkInventory.db.char.option.ldb.currency.tracked ) do
				if v then
					ArkInventory.db.char.option.ldb.tracking.currency.tracked[k] = v
				end
			end
		end
		ArkInventory.db.char.option.ldb.currency = nil
		
		ArkInventory.db.char.option.ldb.ammo = nil
		
		
		ArkInventory.db.char.option.version = upgrade_version
		
	end
	
	
	
	upgrade_version = 3.0249
	if ArkInventory.db.realm.player.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "player", upgrade_version ) )
		ArkInventory.EraseSavedData( nil, ArkInventory.Const.Location.Token )
		
		ArkInventory.db.realm.player.version = upgrade_version
		
	end
	
	
	
	upgrade_version = 3.0250
	if ArkInventory.db.char.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_CHAR"], UnitName( "player" ), upgrade_version ) )
		
		if ArkInventory.db.char.option.ldb.mounts.ground.track then
			ArkInventory.db.char.option.ldb.mounts.ground.track = nil
		end
		
		if ArkInventory.db.char.option.ldb.mounts.flying.track then
			ArkInventory.db.char.option.ldb.mounts.flying.track = nil
		end
		
		if ArkInventory.db.char.option.ldb.mounts.water.track then
			ArkInventory.db.char.option.ldb.mounts.water.track = nil
		end
		
		
		ArkInventory.db.char.option.version = upgrade_version
		
	end

	if ArkInventory.db.profile.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_PROFILE"], ArkInventory.db:GetCurrentProfile( ), upgrade_version ) )
		
		ArkInventory.CategoryRenumber( "1!421", "1!410" ) -- arrow > projectile
		ArkInventory.CategoryRenumber( "1!422", "1!410" ) -- bullet > projectile
		ArkInventory.CategoryRenumber( "1!311", "1!410" ) -- arrow > projectile
		ArkInventory.CategoryRenumber( "1!310", "1!410" ) -- bullet > projectile
		ArkInventory.CategoryRenumber( "1!114", "1!415" ) -- riding > mount
		
		
		ArkInventory.db.profile.option.version = upgrade_version
		
	end
	
	
	
	upgrade_version = 3.0257
	if ArkInventory.db.realm.player.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "player", upgrade_version ) )
		ArkInventory.EraseSavedData( )
		
		ArkInventory.db.realm.player.version = upgrade_version
		
	end
	
	if ArkInventory.db.profile.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_PROFILE"], ArkInventory.db:GetCurrentProfile( ), upgrade_version ) )
		
		ArkInventory.CategoryRenumber( "1!413", nil ) -- soul shard
		ArkInventory.CategoryRenumber( "1!304", nil ) -- empty soul shard
		
		ArkInventory.CategoryRenumber( "1!310", nil ) -- bullet
		ArkInventory.CategoryRenumber( "1!311", nil ) -- arrow
		ArkInventory.CategoryRenumber( "1!410", nil ) -- projectile
		
		ArkInventory.CategoryRenumber( "1!508", "1!510" ) -- weapon enchanement > item enchantment
		ArkInventory.CategoryRenumber( "1!509", "1!510" ) -- armor enchanement > item enchantment
		
		
		ArkInventory.db.profile.option.version = upgrade_version
		
	end
	
	
	
	upgrade_version = 3.0260
	if ArkInventory.db.profile.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_PROFILE"], ArkInventory.db:GetCurrentProfile( ), upgrade_version ) )
		
		for k, v in pairs( ArkInventory.db.profile.option.location ) do
			if v.anchor and v.anchor[k] then
				ArkInventory.db.profile.option.anchor[k].point = v.anchor[k].point
				ArkInventory.db.profile.option.anchor[k].locked = v.anchor[k].locked
				ArkInventory.db.profile.option.anchor[k].t = v.anchor[k].t
				ArkInventory.db.profile.option.anchor[k].b = v.anchor[k].b
				ArkInventory.db.profile.option.anchor[k].l = v.anchor[k].l
				ArkInventory.db.profile.option.anchor[k].r = v.anchor[k].r
			end
			v.anchor = nil
		end
		
		
		ArkInventory.db.profile.option.version = upgrade_version
		
	end
	
	
	
	
	upgrade_version = 3.0268
	if ArkInventory.db.realm.player.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "player", upgrade_version ) )
		ArkInventory.EraseSavedData( nil, ArkInventory.Const.Location.Auction )
		
		ArkInventory.db.realm.player.version = upgrade_version
		
	end
	
	
	upgrade_version = 3.0271
	if ArkInventory.db.realm.player.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "player", upgrade_version ) )
		ArkInventory.EraseSavedData( nil, ArkInventory.Const.Location.Spellbook )
		ArkInventory.EraseSavedData( nil, ArkInventory.Const.Location.Tradeskill )
		
		ArkInventory.db.realm.player.version = upgrade_version
		
	end
	
	if ArkInventory.db.profile.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_PROFILE"], ArkInventory.db:GetCurrentProfile( ), upgrade_version ) )
		
		for k, v in pairs( ArkInventory.db.profile.option.location ) do
			v.slot.new.cutoff = v.slot.new.cutoff * 60
		end
		
		ArkInventory.db.profile.option.version = upgrade_version
		
	end
	
	
	
	
	upgrade_version = 3.0279
	if ArkInventory.db.realm.player.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_GLOBAL"], "player", upgrade_version ) )
		ArkInventory.EraseSavedData( )
		
		ArkInventory.db.realm.player.version = upgrade_version
		
	end
	
	if ArkInventory.db.profile.option.version < upgrade_version then
		
		ArkInventory.Output( string.format( ArkInventory.Localise["UPGRADE_PROFILE"], ArkInventory.db:GetCurrentProfile( ), upgrade_version ) )
		
		ArkInventory.CategoryRenumber( "1!303", nil ) -- empty key slot
		ArkInventory.CategoryRenumber( "1!406", nil ) -- key
		
		
		
		ArkInventory.db.profile.option.version = upgrade_version
		
	end


	

	
	
	ArkInventory.db.profile.option.category["0:0"] = nil
	
	if ArkInventory.db.global.vendor then
		ArkInventory.db.global.vendor = nil
	end
	
	-- check sort keys
	ArkInventory.SortKeyCheck( )
	
	-- set versions to current mod version
	ArkInventory.db.global.option.version = ArkInventory.Const.Program.Version
	ArkInventory.db.realm.player.version = ArkInventory.Const.Program.Version
	ArkInventory.db.profile.option.version = ArkInventory.Const.Program.Version
	ArkInventory.db.char.option.version = ArkInventory.Const.Program.Version
	
end
