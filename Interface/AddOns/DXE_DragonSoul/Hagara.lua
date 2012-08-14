local L,SN,ST,EJSN,EJST = DXE.L,DXE.SN,DXE.ST,DXE.EJSN,DXE.EJST

------------------------
-- Hagara
------------------------
do
	local data = {
		version = 7,
		key = "Hagara",
		zone = L.zone["Dragon Soul"],
		category = L.zone["Dragon Soul"],
		name = L.npc_dragonsoul["Hagara the Stormbinder"],
		triggers = {
			scan = {
				55689, --Hagara
			},
		},
		onactivate = {
			tracing = {
				55689, --Hagara
			},
			tracerstart = true,
			combatstop = true,
			defeat = 55689,
		},
		enrage = {
			time10n = 480,
			time25n = 480,
			time10h = 480,
			time25h = 480,
		},
		userdata = {
			nextphase = "",
		},
		windows = {
			proxwindow = true,
			proxrange = 10,
			proxoverride = true,
		},
		announces = {
			pillarsay = {
				varname = format(L.alert["%s on self"],SN[109541]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[109541]).."!",
			},
		},
		raidicons = {
			tombmark = {
				varname = SN[104451],
				type = "MULTIFRIENDLY",
				persist = 30,
				reset = 5,
				unit = "#5#",
				icon = 2,
				total = 6,
			},
			flakemark = {
				varname = SN[109325],
				type = "FRIENDLY",
				persist = 5,
				reset = 5,
				unit = "#5#",
				icon = 1,
				total = 1,
			},
		},
		--arrows = {},
		--timers = {},
		onstart = {
			{
				"alert",{"shieldcd",time = 2},
				"alert",{"tempestcd",time = 2},
			},
		},
		alerts = {
			shieldcd = {
				varname = format(L.alert["%s Cooldown"],SN[109560]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[109560]),
				time = 62,
				time2 = 30,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[109560],
			},
			shieldwarn = {
				varname = format(L.alert["%s Warning"],SN[109560]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[109560]),
				time = 3,
				flashtime = 3,
				color1 = "BLUE",
				icon = ST[109560],
				sound = "ALERT1",
			},
			tempestcd = {
				varname = format(L.alert["%s Cooldown"],SN[109552]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[109552]),
				time = 62,
				time2 = 30,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[109552],
			},
			tempestwarn = {
				varname = format(L.alert["%s Warning"],SN[109552]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[109552]),
				time = 3,
				flashtime = 3,
				color1 = "BLUE",
				icon = ST[109552],
				sound = "ALERT1",
			},
			tombwarn = {
				varname = format(L.alert["%s Warning"],SN[104448]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[104448]),
				time = 8,
				flashtime = 8,
				color1 = "WHITE",
				icon = ST[104448],
				sound = "ALERT2",
			},
			tombcd = {
				varname = format(L.alert["%s Cooldown"],SN[104448]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[104448]),
				time = 20,
				flashtime = 5,
				color1 = "WHITE",
				icon = ST[104448],
			},
			lanceself = {
				varname = format(L.alert["%s Warning on self"],SN[105297]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[105297],L.alert["YOU"]),
				time = 3,
				flashtime = 3,
				color1 = "YELLOW",
				icon = ST[105297],
				sound = "ALERT3",
				flashscreen = true,
			},
			flakeself = {
				varname = format(L.alert["%s Warning on self"],SN[109325]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[109325],L.alert["YOU"]),
				time = 3,
				flashtime = 3,
				color1 = "BLUE",
				icon = ST[109325],
				sound = "ALERT4",
				flashscreen = true,
			},
			feedbackdur = {
				varname = format(L.alert["%s Duration"],SN[108934]),
				type = "centerpopup",
				text = format(L.alert["%s Duration"],SN[108934]),
				time = 15,
				flashtime = 15,
				color1 = "WHITE",
				icon = ST[108934],
				sound = "ALERT5",
			},
			pillarself = {
				varname = format(L.alert["%s Warning on self"],SN[109541]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[109541],L.alert["YOU"]),
				time = 3,
				flashtime = 3,
				color1 = "BLUE",
				icon = ST[109541],
				sound = "ALERT5",
				flashscreen = true,
			},
			assaultcd = {
				varname = format(L.alert["%s Cooldown"],SN[110898]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[110898]),
				time = 15,
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[110898],
			},
		},
		events = {
			-- assaultcd
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 110898,
				execute = {
					{
						"alert","assaultcd",
					},
				},
			},
			-- Ice Tomb
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 104448 ,
				execute = {
					{
						"alert","tombwarn",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 104451,
				execute = {
					{
						"raidicon","tombmark",
					},
				},
			},
			-- Ice lance
			{
				type = "combatevent",
				eventtype = "SPELL_SUMMON",
				spellname = 105297,
				execute = {
					{
						"expect",{"#1#","==","&playerguid&"},
						"alert","lanceself",
					},
				},
			},
			-- Water Shield
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				srcnpcid = 55689,
				spellname = 109560,
				execute = {
					{
						"quash","assaultcd",
						"alert","shieldwarn",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				srcnpcid = 55689,
				spellname = 109560,
				execute = {
					{
						"alert","tempestcd",
						"alert","tombcd",
						"alert","feedbackdur",
					},
				},
			},
			-- Frozen Tempest
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				srcnpcid = 55689,
				spellname = 109552,
				execute = {
					{
						"quash","assaultcd",
						"alert","tempestwarn",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				srcnpcid = 55689,
				spellname = 109552,
				execute = {
					{
						"alert","shieldcd",
						"alert","tombcd",
						"alert","feedbackdur",
					},
				},
			},
			-- Frostflake (heroic)
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 109325,
				execute = {
					{
						"raidicon","flakemark",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","flakeself",
					},
				},
			},
			-- Storm Pillar
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 109541,
				execute = {
					{
						"target",{
							source = "#1#",
							wait = 0.1,
							announce = "pillarsay",
							alerts = {
								self = "pillarself",
							},
						},
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end
