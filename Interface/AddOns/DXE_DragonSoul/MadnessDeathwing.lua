local L,SN,ST,EJSN,EJST = DXE.L,DXE.SN,DXE.ST,DXE.EJSN,DXE.EJST

------------------------
-- Madness of Deathwing
------------------------
do
	local data = {
		version = 8,
		key = "Madness of Deathwing",
		zone = L.zone["Dragon Soul"],
		category = L.zone["Dragon Soul"],
		name = L.npc_dragonsoul["Madness of Deathwing"],
		triggers = {
			scan = {
				--56173, -- Madness
				56103, -- Thrall (to detect, yell probably better)
				-- more npcids?
			},
			yell = L.chat_dragonsoul["^You have done NOTHING"],
		},
		onactivate = {
			tracing = {
				57962, --Madness
			},
			tracerstart = true,
			combatstop = true,
			defeat = 57962,
		},
		enrage = {
			time10n = 1080,
			time25n = 1080,
			time10h = 1080,
			time25h = 1080,
		},
		userdata = {
			boltcd = {40,56, loop = false, type = "series"},
			tailcd = {11,17, loop = false, type = "series"},
			hemocd = {85.5,100.5, loop = false, type = "series"},
			hemocdheroic = {55,70, loop = false, type = "series"},
			parasitecd = {11,22, loop = false, type = "series"},
		},
		windows = {
			proxwindow = true,
			proxrange = 10,
		},
		--[[
		timers = {

		},]]
		announces = {
			parasitesay = {
				varname = format(L.alert["%s on self"],SN[108649]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[108649]),
			},
		},
		raidicons = {
			parasiteicon = {
				varname = SN[108649],
				type = "FRIENDLY",
				persist = 10,
				reset = 2,
				unit = "#5#",
				icon = 1,
				total = 1,
			},
		},
		--[[
		arrows = {
		},
		onstart = {
			{
			},
		},]]
		alerts = {
			tailcd = {
				varname = format(L.alert["%s Cooldown"],SN[105535]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],SN[105535]),
				time = "<tailcd>",
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[105535],
				sound = "ALERT5",
			},
			boltwarn = {
				varname = format(L.alert["%s Warning"],SN[105651]),
				type = "centerpopup",
				text =  format(L.alert["%s Warning"],SN[105651]),
				time = 18,
				time2 = 8,
				color1 = "YELLOW",
				icon = ST[105651],
				sound = "ALERT1",
			},
			boltcd = {
				varname = format(L.alert["%s Cooldown"],SN[105651]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],SN[105651]),
				time = "<boltcd>",
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[105651],
			},
			hemowarn = {
				varname = format(L.alert["%s Warning"],SN[105863]),
				type = "simple",
				text =  format(L.alert["%s Warning"],SN[105863]),
				time = 3,
				color1 = "ORANGE",
				icon = ST[105863],
				sound = "ALERT2",
			},
			hemocd = {
				varname = format(L.alert["%s Cooldown"],SN[105863]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],SN[105863]),
				time = "<hemocd>",
				time25h = "<hemocdheroic>",
				time10h = "<hemocdheroic>",
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[105863],
			},
			cataclysmwarn = {
				varname = format(L.alert["%s Warning"],SN[110044]),
				type = "dropdown",
				text =  format(L.alert["%s Warning"],SN[110044]),
				time = 60,
				flashtime = 10,
				color1 = "YELLOW",
				icon = ST[110044],
				sound = "ALERT3",
			},
			cataclysmcd = {
				varname = format(L.alert["%s Cooldown"],SN[110044]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],SN[110044]),
				time = 30,
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[110044],
			},
			shrapnelself = {
				varname = format(L.alert["%s on self"],SN[110141]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[110141],L.alert["YOU"]),
				time = 5,
				flashtime = 5,
				color1 = "GOLD",
				sound = "ALERT4",
				icon = ST[110141],
				flashscreen = true,
			},
			impalewarn = {
				varname = format(L.alert["%s Warning"],SN[106400]),
				type = "centerpopup",
				text =  format(L.alert["%s Warning"],SN[106400]),
				time = 4,
				flashtime = 4,
				color1 = "BLUE",
				icon = ST[106400],
				sound = "ALERT5",
				throttle = 6, -- should do the trick
			},
			impalecd = {
				varname = format(L.alert["%s Cooldown"],SN[106400]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],SN[106400]),
				time = 35,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[106400],
				throttle = 6,
			},
			tentaclecd = {
				varname = format(L.alert["%s Cooldown"],SN[106776]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],SN[106776]),
				time = 91,
				time2 = 10, -- seen 9-11, perhaps %based
				flashtime = 5,
				color1 = "RED",
				icon = ST[106776],
			},
			terrorcd = {
				varname = format(L.alert["%s Cooldown"],SN[106766]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],SN[106766]),
				time = 24,
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[106766],
				throttle = 1,
			},
			parasitewarn = {
				varname = format(L.alert["%s Warning"],SN[108649]),
				type = "centerpopup",
				text =  format(L.alert["%s on %s"],SN[108649],"#5#"),
				time = 10,
				flashtime = 3,
				color1 = "GREEN",
				icon = ST[108649],
				throttle = 2,
			},
			parasiteself = {
				varname = format(L.alert["%s Warning on self"],SN[108649]),
				type = "centerpopup",
				text =  format(L.alert["%s on %s"],SN[108649],L.alert["YOU"]),
				time = 10,
				flashtime = 3,
				color1 = "GREEN",
				icon = ST[108649],
				sound = "ALERT5",
				flashscreen = true,
				throttle = 2,
			},
			parasitecd = {
				varname = format(L.alert["%s Cooldown"],SN[108649]),
				type = "dropdown",
				text =  format(L.alert["%s Cooldown"],SN[108649]),
				time = "<parasitecd>",
				time2 = 60,
				flashtime = 5,
				color1 = "GREEN",
				icon = ST[108649],
				throttle = 1,
			},
			unstablecd = {
				varname = format(L.alert["%s Casting"],SN[108813]),
				type = "centerpopup",
				text =  format(L.alert["%s Casting"],SN[108813]),
				time = 13,
				flashtime = 5,
				color1 = "GOLD",
				icon = ST[108813],
				throttle = 1,
			},
		},
		events = {
			-- Assault
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 107018,
				execute = {
					{
						"quashall",true,
						"alert","boltcd", -- 40,56
						"alert","tailcd", -- 10,15
						"alert","hemocd",
					},
					{
						"expect",{"&difficulty&",">=","3"},
						"alert","parasitecd",
					},
				},
			},
			-- Bolt
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 105651,
				execute = {
					{
						"quash","boltcd",
						"schedulealert",{"cataclysmcd",44},
						"invoke",{
							{
								"expect",{"&playerbuff|"..SN[109624].."&","==","true"},
								"alert",{"boltwarn"},
							},
							{
								"expect",{"&playerbuff|"..SN[109624].."&","==","false"},
								"alert",{"boltwarn",time = 2},
							},
						},
					},
				},
			},
			-- cataclysm
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 110044,
				srcisnpctype = true,
				execute = {
					{
						"quash","cataclysmcd",
						"alert","cataclysmwarn",
					},
				},
			},
			-- Shrapnel (self only)
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 110141,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","shrapnelself", -- 5s
					},
				},
			},
			-- impale
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 106400,
				execute = {
					{
						"alert","impalewarn",
						"alert","impalecd",
					},
				},
			},
			-- No actual CLEU events *shakesfist*
			{
				type = "event",
				event = "UNIT_SPELLCAST_SUCCEEDED",
				execute = {
					{
						"expect",{"#2#","find",SN[106708]},
						"alert",{"tentaclecd",time = 2},
					},
					{
						"expect",{"#2#","find",SN[109568]},
						"quash","tentaclecd",
						"alert","tentaclecd",
						"alert","terrorcd",
					},
				},
			},
			-- Parasite
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 108649,
				execute = {
					{
						"alert",{"parasitecd",time = 2},
						"raidicon","parasiteicon",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"alert","parasitewarn",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","parasiteself",
						"announce","parasitesay",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 108649,
				execute = {
					{
						"alert","unstablecd",
					},
				},
			},
			-- Corruption died
			{
				type = "combatevent",
				eventtype = "UNIT_DIED",
				execute = {
					{
						"expect",{"&npcid|#4#&","==","56471"},
						"quash","parasitecd",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end
