local L,SN,ST,EJSN,EJST = DXE.L,DXE.SN,DXE.ST,DXE.EJSN,DXE.EJST

------------------------
-- Warmaster Blackhorn
------------------------
do
	local data = {
		version = 12,
		key = "Blackhorn",
		zone = L.zone["Dragon Soul"],
		category = L.zone["Dragon Soul"],
		name = L.npc_dragonsoul["Warmaster Blackhorn"],
		triggers = {
			scan = {
				56598,56781, -- The Skyfire
			},
		},
		onactivate = {
			tracing = {
				"boss1",
				56427,
				56781,
			},
			tracerstart = true,
			combatstop = true,
			defeat = 56427, -- Blackhorn
		},
		--[[enrage = {
			time10n = 1080,
			time25n = 1080,
			time10h = 1080,
			time25h = 1080,
		},]]
		userdata = {
			sundertext = "",
		},
		--windows = {},
		--timers = {},
		announces = {
			shockwavesay = {
				varname = format(L.alert["%s on self"],SN[108046]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[108046]).."!",
			},
		},
		raidicons = {
			shroudmark = {
				varname = SN[110598],
				type = "FRIENDLY",
				persist = 15,
				unit = "#5#",
				icon = 1,
			},
		},
		--arrows = {},
		onstart = {
			{
				"alert",{"onslaughtcd",time = 2},
				"alert",{"riderscd",time = 2},
				"schedulealert",{"riderscd",85},
				"schedulealert",{"riderscd",145},
				"alert",{"sappercd",time = 2},
			},
			{
				"expect",{"&difficulty&",">=","3"},
				"alert",{"broadsidecd",time = 2},
			},
		},
		alerts = {
			riderscd = {
				varname = format(L.alert["%s Landing"],L.npc_dragonsoul["Dragonriders"]),
				type = "dropdown",
				text =  format(L.alert["%s Landing"],L.npc_dragonsoul["Dragonriders"]),
				time = 60,
				time2 = 25,
				flashtime = 5,
				color1 = "GREEN",
				icon = ST[39255],
			},
			onslaughtwarn = {
				varname = format(L.alert["%s Warning"],SN[106401]),
				type = "simple",
				text =  format(L.alert["%s Warning"],SN[106401]),
				time = 3,
				color1 = "PURPLE",
				icon = ST[106401],
				sound = "ALERT2",
			},
			onslaughtcd = {
				varname = format(L.alert["%s Cooldown"],SN[106401]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],SN[106401]),
				time = 34,
				time2 = 47,
				flashtime = 7.5,
				color1 = "PURPLE",
				icon = ST[106401],
			},
			shockwavewarn = {
				varname = format(L.alert["%s Warning"],SN[108046]),
				type = "centerpopup",
				text =  format(L.alert["%s Warning"],SN[108046]),
				time = 2.5,
				color1 = "YELLOW",
				icon = ST[108046],
				sound = "ALERT3",
			},
			shockwaveself = {
				varname = format(L.alert["%s on self"],SN[108046]),
				type = "simple",
				text =  format(L.alert["%s on %s"],SN[108046],L.alert["YOU"]),
				time = 3,
				color1 = "YELLOW",
				icon = ST[108046],
				flashscreen = true,
			},
			shockwavecd = {
				varname = format(L.alert["%s Cooldown"],SN[108046]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],SN[108046]),
				time = 25, -- seen 25-28
				time2 = 16,
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[108046],
			},
			roarcd = {
				varname = format(L.alert["%s Cooldown"],SN[108044]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],SN[108044]),
				time = 19.5, -- seen 19.5-23
				time2 = 4.5,
				flashtime = 5,
				color1 = "BROWN",
				icon = ST[108044],
			},
			flamescd = {
				varname = format(L.alert["%s Cooldown"],SN[109216]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],SN[109216]),
				time = 8,
				time2 = 12,
				flashtime = 5,
				color1 = "PURPLE",
				icon = ST[109216],
			},
			flamesself = {
				varname = format(L.alert["%s on self"],SN[109216]),
				type = "simple",
				text =  format(L.alert["%s on %s"],SN[109216],L.alert["YOU"]),
				time = 2,
				color1 = "PURPLE",
				icon = ST[109216],
				sound = "ALERT4",
				flashscreen = true,
				throttle = 2,
			},
			sunderwarn = {
				varname = format(L.alert["%s Warning"],SN[108043]),
				type = "simple",
				text =  "<sundertext>",
				time = 3,
				color1 = "WHITE",
				icon = ST[108043],
				sound = "ALERT5",
			},
			broadsidecd = {
				varname = format(L.alert["%s Cooldown"],EJSN[4357]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],EJSN[4357]),
				time = 70,
				time2 = 58,
				flashtime = 5,
				color1 = "ORANGE",
				icon = EJST[4357],
			},
			shroudwarn = {
				varname = format(L.alert["%s Warning"],SN[110598]),
				type = "simple",
				text =  format(L.alert["%s on %s"],SN[110598],"#5#"),
				time = 3,
				color1 = "PURPLE",
				icon = ST[110598],
				sound = "ALERT6",
			},
			sapperwarn = {
				varname = format(L.alert["%s Warning"],EJSN[4200]),
				type = "simple",
				text =  format(L.alert["%s Warning"],EJSN[4200]),
				time = 3,
				color1 = "YELLOW",
				icon = EJST[4201],
				sound = "ALERT7",
			},
			sappercd = {
				varname = format(L.alert["%s Cooldown"],EJSN[4200]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],EJSN[4200]),
				time = 40,
				time2 = 70,
				flashtime = 5,
				color1 = "YELLOW",
				icon = EJST[4201],
			},

		},
		events = {
			-- Twilight Onslaught
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 106401,
				execute = {
					{
						"quash","onslaughtcd",
						"alert","onslaughtcd",
						"alert","onslaughtwarn",
					},
				},
			},
			-- Shockwave
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 108046,
				srcisnpctype = true,
				execute = {
					{
						"quash","shockwavecd",
						"alert","shockwavecd",
						"alert","shockwavewarn",
					},
					{
						"target",{
							source = "#1#",
							wait = 0.2,
							announce = "shockwavesay",
							alerts = {
								self = "shockwaveself",
							},
						},
					},
				},
			},
			-- Disrupting Roar
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 108044,
				execute = {
					{
						"quash","roarcd",
						"alert","roarcd",
					},
				},
			},
			-- Phase 2, Vengeance
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 108045,
				execute = {
					{
						"quash","onslaughtcd",
						"alert",{"roarcd",time = 2},
						"alert",{"shockwavecd",time = 2},
						"alert",{"flamescd",time = 2},
					},
				},
			},
			-- Sunder Armor on Tanks
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				srcisnpctype = true,
				spellname = 108043,
				execute = {
					{
						"expect",{"#11#",">=","2"},
						"set",{sundertext = format("%s: %s x %s","#5#",SN[108043],"#11#")},
						"alert","sunderwarn",
					},
				},
			},
			-- Twilight Flames
			{
				type = "combatevent",
				eventtype = "SPELL_SUMMON",
				spellname = 109216,
				execute = {
					{
						"quash","flamescd",
						"alert","flamescd",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_DAMAGE",
				spellname = 109216,
				dstisplayerunit = true,
				execute = {
					{
						"alert","flamesself",
					},
				},
			},
			-- Shroud
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 110598,
				execute = {
					{
						"raidicon","shroudmark",
						"alert","shroudwarn",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 110598,
				execute = {
					{
						"removeraidicon","#5#",
					},
				},
			},
			-- Broadside & Sapper
			{
				type = "event",
				event = "EMOTE",
				execute = {
					{
						"expect",{"#1#","find",EJSN[4357]},
						"quash","broadsidecd",
						"alert","broadsidecd",
					},
					{
						"expect",{"#1#","find",EJSN[4200]},
						"quash","sappercd",
						"alert","sappercd",
						"alert","sapperwarn",
					},
				},
			},

		},
	}

	DXE:RegisterEncounter(data)
end
